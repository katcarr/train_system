class Station
  attr_reader(:name,:id)

  define_method(:initialize) do |attributes|
    @name = attributes[:name]
    @id = attributes[:id]
  end

  define_method(:save) do
    results = DB.exec("INSERT INTO stations (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first().fetch('id').to_i()
  end

  define_singleton_method(:all) do
    stations = []
    station_results = DB.exec("SELECT * FROM stations;")
    station_results.each do |station|
      name = station.fetch("name")
      id = station.fetch("id").to_i()
      stations.push(Station.new({:name => name, :id => id}))
    end
    stations
  end

  define_method(:==) do |station_to_compare|
    @name == station_to_compare.name() && @id == station_to_compare.id()
  end

  define_method(:update) do |new_name|
    @name = new_name
    DB.exec("UPDATE stations SET name = '#{@name}' WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM stations WHERE id = #{@id};")
  end

  define_method(:lines) do
    line_ids = []
    connection_results = DB.exec("SELECT * FROM connections WHERE station_id = #{@id};")
    connection_results.each() do |connection|
      line_ids.push(connection.fetch("line_id").to_i())
    end

    lines = []
    line_ids.each() do |line_id|
      line_result = DB.exec("SELECT * FROM lines WHERE id = #{line_id} ;")
      id = line_result.first().fetch("id").to_i()
      line_name = line_result.first().fetch('name')
      lines.push(Line.new({:name => line_name, :id => id}))
    end
    lines
  end

end
