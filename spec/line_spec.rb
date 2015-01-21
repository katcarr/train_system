require('spec_helper')

describe('Line') do
  describe("#name") do
    it("returns the name of the line") do
      test_line = Line.new({:name => "Green"})
      expect(test_line.name()).to(eq("Green"))
    end
  end

  describe("#id") do
    it("returns the id of the line") do
      test_line = Line.new({:id => 1})
      expect(test_line.id()).to(eq(1))
    end
  end

  describe('#save') do
    it("save itself to the line table in the database") do
      test_line = Line.new({:name => "Blue"})
      test_line.save()
      expect(Line.all()).to(eq([test_line]))
    end
  end

  describe('.all') do
    it("is empty when initalized") do
      test_line = Line.new({:name => "Blue"})
      expect(Line.all()).to(eq([]))
    end
  end

  describe("#==") do
    it("will return true if name and id are equal for both line objects") do
      test_line1 = Line.new({:name => "Blue"})
      test_line1.save()
      expect(test_line1.==(test_line1)).to(eq(true))
    end
  end

  describe("#update") do
    it("will change name of line to name of argument") do
      test_line1 = Line.new({:name => "Blue"})
      test_line1.save()
      test_line1.update("Sky")
      expect(Line.all().first().name()).to(eq("Sky"))
    end
  end

  describe("#delete") do
    it("will delete the saved line from the database") do
      test_line = Line.new({:name => "Blue"})
      test_line.save()
      test_line.delete()
      expect(Line.all()).to(eq([]))
    end
  end

end
