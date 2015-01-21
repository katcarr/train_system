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


end
