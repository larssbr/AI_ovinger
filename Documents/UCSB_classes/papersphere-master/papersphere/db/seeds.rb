# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(:email => 'chris@test.com', :password => 'test1234', :password_confirmation => 'test1234', :name => 'Chris Horuk')

user1 = User.create(:email => 'hiranya@test.com', :password => 'test1234', :password_confirmation => 'test1234', :name => 'Hiranya Jayathilaka')
user2 = User.create(:email => 'alex@test.com', :password => 'test1234', :password_confirmation => 'test1234', :name => 'Alex Pucher')
user3 = User.create(:email => 'nevena@test.com', :password => 'test1234', :password_confirmation => 'test1234', :name => 'Nevena Golubovic')

paper1 = Paper.create(:title => 'Test Paper 1', :author => 'Author 1',
                      :year => 2011, :publication => 'Publication 1',
                      :url => 'http://foo1.com', :paper_code => 'TEST_001')
paper2 = Paper.create(:title => 'Test Paper 2', :author => 'Author 2',
                      :year => 2012, :publication => 'Publication 2',
                      :url => 'http://foo2.com', :paper_code => 'TEST_002')
paper3 = Paper.create(:title => 'Test Paper 3', :author => 'Author 3',
                      :year => 2013, :publication => 'Publication 3',
                      :url => 'http://foo3.com', :paper_code => 'TEST_003')

list = ReadingList.create(:name => 'Distributed Systems')
list.user = user
list.save

list1 = ReadingList.create(:name => 'MAE Reading List')
list1.user = user1
list1.save

list.add_paper(paper1)
list.add_paper(paper2)
list.add_paper(paper3)

group1 = Group.create(:name => 'My Project Team')
group1.owner = user
group1.save

group2 = Group.create(:name => 'People I Hate')
group2.owner = user1
group2.save

member1 = GroupMember.create
member1.group = group1
member1.user = user1
member1.save

member2 = GroupMember.create
member2.group = group1
member2.user = user2
member2.save

member3 = GroupMember.create
member3.group = group1
member3.user = user3
member3.save

member4 = GroupMember.create
member4.group = group2
member4.user = user
member4.save

member5 = GroupMember.create
member5.group = group2
member5.user = user2
member5.save

member6 = GroupMember.create
member6.group = group2
member6.user = user3
member6.save

share1 = ReadingListShare.create(:access_rights => 'readonly')
share1.group = group1
share1.reading_list = list
share1.save

share2 = ReadingListShare.create(:access_rights => 'readwrite')
share2.group = group2
share2.reading_list = list1
share2.save
