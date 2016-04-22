DB.create_table? :books do
  primary_key :id
  String :isbn
  String :title
  String :author
  #String :location
  String :summary
end

class Book < Sequel::Model
end
