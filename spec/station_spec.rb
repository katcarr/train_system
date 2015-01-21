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

end
