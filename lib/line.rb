class Line

  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes[:name]
    @id = attributes[:id]
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO lines (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:all) do
    returned_lines = DB.exec("SELECT * FROM lines;")
    lines = []
    returned_lines.each() do |line|
      name = line.fetch("name")
      id = line.fetch("id").to_i()
      lines.push(Line.new({:name => name, :id => id}))
    end
    lines
  end

  define_method(:==) do |line_to_compare|
    @name == line_to_compare.name() && @id == line_to_compare.id()
  end

  define_method(:update) do |new_name|
    @name = new_name
    DB.exec("UPDATE lines SET name = '#{@name}' WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM lines WHERE id = #{@id};")
  end
  

end
