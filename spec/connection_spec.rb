require('spec_helper')

describe("Connection") do
  describe("#station_id") do
    it("returns station_id") do
      test_line = Line.new({:name => "Blue"})
      test_line.save()
      test_station = Station.new({:name =>"Rose Quarter"})
      test_station.save()
      test_connection = Connection.new({:line_id => test_line.id(), :station_id => test_station.id()})
      expect(test_connection.station_id()).to(eq(test_station.id()))
    end
  end

  describe("#line_id") do
    it("returns line_id") do
      test_line = Line.new({:name => "Blue"})
      test_line.save()
      test_station = Station.new({:name =>"Rose Quarter"})
      test_station.save()
      test_connection = Connection.new({:line_id => test_line.id(), :station_id => test_station.id()})
      expect(test_connection.line_id()).to(eq(test_line.id()))
    end
  end

  describe("#==") do
    it("returns true if id ,line_id and station_id are the same for both objects") do
      test_connection1 = Connection.new({:line_id => 3, :station_id => 2, :id => 1})
      test_connection2 = Connection.new({:line_id => 3, :station_id => 2, :id => 1})
      expect(test_connection1.==(test_connection2)).to(eq(true))
    end
  end

  describe("#save") do
    it("saves itself to the database") do
      test_line = Line.new({:name => "Blue"})
      test_line.save()
      test_station = Station.new({:name =>"Rose Quarter"})
      test_station.save()
      test_connection = Connection.new({:line_id => test_line.id(), :station_id => test_station.id()})
      test_connection.save()
      expect(Connection.all()).to(eq([test_connection]))
    end
  end

  describe(".all") do
    it("is empty when initalized") do
      test_line = Line.new({:name => "Blue"})
      test_line.save()
      test_station = Station.new({:name =>"Rose Quarter"})
      test_station.save()
      test_connection = Connection.new({:line_id => test_line.id(), :station_id => test_station.id()})
      expect(Connection.all()).to(eq([]))
    end
  end



end
