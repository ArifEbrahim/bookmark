require 'pg'

def persisted_data(table, id)
  connection = PG.connect(dbname: 'bookmark_manager_test')
  result = connection.query("SELECT * FROM #{table} WHERE id = #{id};")
  result.first
end

def setup_test_database
  con = PG.connect(dbname: 'bookmark_manager_test')
  con.exec('TRUNCATE bookmarks, comments, users;')
end