class Task
  attr_reader :i, :length
  def initialize(path, i, &blk)
    @i = i
    @data = blk.call
    t = File.read("#{path}/tasks/#{i}.rb")
    @length = t.length
    self.instance_eval t
  end

  def test
    success = true
    @data.each do |input, expected|
      output = do_it(input)
      unless output == expected
        success = false
      end
    end
    success
  end

  def success?
    @success ||= test
  end
end

