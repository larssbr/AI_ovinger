require 'open-uri'

class RemoteLibraryController < ApplicationController
  def search
    if params[:page]
      page = params[:page].to_i
    else
      page = 1
    end

    if params[:db] == 'ieee'
      @target_db = 'ieee'
      helper = RemoteLibraryHelper::IEEEHelper.new
    else
      @target_db = 'acm'
      helper = RemoteLibraryHelper::ACMHelper.new
    end

    if params[:query] != ''
      @results = helper.search(URI::encode_www_form_component(params[:query]), page)
      @reading_list = ReadingList.find(params[:reading_list_id])
    else
      @results = :empty_query
    end
    respond_to do |format|
      format.js
    end
  end
end
