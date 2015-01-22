class Connection
  attr_reader(:station_id,:line_id,:id)

  define_method(:initialize) do |attributes|
    @station_id = attributes[:station_id]
    @line_id = attributes[:line_id]
    @id = attributes[:id]
  end

  define_method(:==) do |connection_to_compare|
    @station_id == connection_to_compare.station_id() && @line_id == connection_to_compare.line_id() && @id == connection_to_compare.id()
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO connections (station_id, line_id) VALUES (#{@station_id}, #{@line_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:all) do
    connections = []
    connection_results = DB.exec("SELECT * FROM connections")
    connection_results.each() do |connection|
      station_id = connection.fetch("station_id").to_i()
      line_id = connection.fetch("line_id").to_i()
      id = connection.fetch("id").to_i()
      connections.push(Connection.new({:station_id => station_id, :line_id => line_id, :id => id}))
    end
    connections
  end

  # define_singleton_method(:search_by_station) do |station_to_find|
  #   line_ids = []
  #   connection_results = DB.exec("SELECT * FROM connections WHERE station_id = #{station_to_find.id()};")
  #   connection_results.each() do |connection|
  #     line_ids.push(connection.fetch("line_id").to_i())
  #   end
  #
  #   lines = []
  #   line_ids.each() do |line_id|
  #     line_result = DB.exec("SELECT * FROM lines WHERE id = #{line_id} ;")
  #     binding.pry
  #     id = line_result.fetch("id").to_i()
  #     line_name = line_result.fetch('name')
  #     lines.push(Line.new({:name => line_name, :id => id}))
  #   end
  #   lines
  # end

end
