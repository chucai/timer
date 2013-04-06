class Item
	attr_accessor :name, :site, :time, :money, :number, :type

  def initialize(options = nil)
    unless options.nil?
      @name   = options["name"]
      @site   = options["site"]
      @time   = options["time"]
      @money  = options["money"]
      @number = options["number"]
      @type   = options["type"]
      @date_format = options[:data_format] || "%Y-%m-%d %H:%M"
    end
  end


  def format_time
    DateTime.parse(self.time).strftime(@date_format)
  end

end