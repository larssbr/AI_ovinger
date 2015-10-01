require 'open-uri'
require 'cgi'

module RemoteLibraryHelper

  RESULTS_PER_PAGE = 20

  def self.purify(str)
    str.strip.encode('UTF-8', 'binary', :invalid => :replace, :undef => :replace, :replace => '')
  end

  class ResultEntry
    attr_accessor :entry_id, :title, :author, :publication, :year, :url

    def initialize(entry_id, title, author, publication, year, url)
      @entry_id = entry_id
      @title = title
      @author = author
      @publication = publication
      @year = year
      @url = url
    end
  end

  class SearchResults
    attr_reader :results, :count, :pos, :total

    def initialize(total, pos = 1)
      @results = []
      @count = 0
      @pos = pos
      @total = total
    end

    def add_entry(entry_id, title, author, publication, year, url)
      entry = ResultEntry.new(entry_id, title, author, publication, year, url)
      @results << entry
      @count += 1
    end

    def get_paginated_results
      current_page = ((@pos - 1) / RESULTS_PER_PAGE) + 1
      WillPaginate::Collection.create(current_page, RESULTS_PER_PAGE, @total) do |pager|
        pager.replace(@results)
      end
    end
  end

  class ACMHelper
    def search(query, page)
      pos = page * RESULTS_PER_PAGE - RESULTS_PER_PAGE + 1
      doc = Nokogiri::HTML(open("http://dl.acm.org/results.cfm?query=#{query}&start=#{pos}"))
      error = doc.css("span[style='background-color:yellow']")
      unless error.empty?
        return SearchResults.new(0)
      end

      core = doc.xpath('//body/div/table/tr[3]/td/table/tr[3]/td[2]/table')
      titles = doc.css("a[class='medium-text']")
      authors = doc.css("div[class='authors']")
      years = core.css("table[style='padding: 5px; 5px; 5px; 5px;'] tr[valign='top'] td[class='small-text']")
      publications = doc.css("div[class='addinfo']")
      results_count = doc.css("table[class='small-text'] tr[valign='top'] td")

      total = results_count[0].text.split.last.gsub(',','').to_i
      results = SearchResults.new(total, pos)

      index = 0
      titles.each do |title|
        author_names = authors[index].css('a')
        if author_names.size > 1
          author_name = author_names.first.text.strip + ' et al'
        elsif author_names.size == 1
          author_name = author_names.first.text.strip
        else
          author_names = authors[index].text.strip.split(', ')
          if author_names.size > 1
            author_name = author_names.first + ' et al'
          else
            author_name = author_names.first
          end
        end

        href = title['href'].strip
        query_params = CGI.parse(href[href.index('?') + 1 .. -1])
        entry_id = "ACM_#{query_params['id'].first}"
        url = "http://dl.acm.org/#{href}"
        results.add_entry entry_id,
                          title.text.strip,
                          author_name,
                          publications[index].text.strip,
                          years[index * 2].text.split[1].strip,
                          url
        index += 1
      end
      results
    end
  end

  class IEEEHelper
    def search(query, page)
      pos = page * RESULTS_PER_PAGE - RESULTS_PER_PAGE + 1
      doc = Nokogiri::XML(open("http://ieeexplore.ieee.org/gateway/ipsSearch.jsp?querytext=#{query}&rs=#{pos}&hc=#{RESULTS_PER_PAGE}"))
      error = doc.xpath('//Error')
      unless error.empty?
        return SearchResults.new(0)
      end

      elements = doc.xpath('//root/document')
      total = doc.xpath('//root/totalfound').first.text.strip.to_i
      results = SearchResults.new(total, pos)

      elements.each do |element|
        entry_id = element.xpath('arnumber').first.text.strip
        title = RemoteLibraryHelper::purify(element.xpath('title').first.text)
        authors = RemoteLibraryHelper::purify(element.xpath('authors').first.text)
        authors_list = authors.split(';')
        if authors_list.count > 1
          authors = authors_list[0].strip + ' et al'
        end
        publication = RemoteLibraryHelper::purify(element.xpath('pubtitle').first.text)
        year = element.xpath('py').first.text.strip.to_i
        url = element.xpath('mdurl').first.text.strip
        results.add_entry "IEEE_#{entry_id}",
                          title,
                          authors,
                          publication,
                          year,
                          url
      end
      results
    end
  end

end
