require('spec_helper')

describe("Station") do

  describe("#name") do
    it("will return the name of the station") do
      test_station = Station.new({:name => "Rose Quarter"})
      expect(test_station.name()).to(eq("Rose Quarter"))
    end
  end

  describe("#id") do
    it("will return the id of the station") do
      test_station = Station.new({:name => "Rose Quarter", :id => 6})
      expect(test_station.id()).to(eq(6))
    end
  end

  describe("#save") do
    it("will save itself into the Stations table") do
      test_station = Station.new({:name => "Rose Quarter"})
      test_station.save()
      expect(Station.all()).to(eq([test_station]))
    end
  end

  describe(".all") do
    it("will return an array of station elements in the Stations table") do
      test_station = Station.new({:name => "Rose Quarter"})
      test_station.save()
      expect(Station.all()).to(eq([test_station]))
    end
  end

  describe("#==") do
    it("return true if name and id are the same for both station objects") do
      test_station = Station.new({:name => "Rose Quarter"})
      test_station.save()
      expect(test_station.==(test_station)).to(eq(true))
    end
  end

  describe("#update") do
    it("will update the name of the station in the database") do
      test_station = Station.new({:name => "Rose Quarter"})
      test_station.save()
      test_station.update("Moda")
      expect(Station.all().first().name()).to(eq("Moda"))
    end
  end

  describe("#delete") do
    it("will delete itself from the table Stations") do
      test_station = Station.new({:name => "Rose Quarter"})
      test_station.save()
      test_station.delete()
      expect(Station.all()).to(eq([]))
    end
  end

  describe("#lines") do
    it("will return an array of the line objects that stop at that station") do
      test_line1 = Line.new({:name => "Blue"})
      test_line1.save()
      test_station1 = Station.new({:name =>"Rose Quarter"})
      test_station1.save()
      test_connection1 = Connection.new({:line_id => test_line1.id(), :station_id => test_station1.id()})
      test_connection1.save()
      test_line2 = Line.new({:name => "Yellow"})
      test_line2.save()
      test_connection2 = Connection.new({:line_id => test_line2.id(), :station_id => test_station1.id()})
      test_connection2.save()
      expect(test_station1.lines()).to(eq([test_line1, test_line2]))
    end
  end

end
