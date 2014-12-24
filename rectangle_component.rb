class RectangleComponent < Component

  attr_reader :x, :y, :width, :height, :owner

  def initialize(owner, x, y, width, height)
    @x = @prev_x = x
    @y = @prev_y = y
    @width = width
    @height = height
    @owner = owner
  end

  def update

  end

  def receive_message(message)
    payload = message.payload
    if payload[:type] == "position_updated"
      @prev_x = @x
      @prev_y = @y
      @x = payload[:x]
      @y = payload[:y]
    end

    if payload[:type] == "position_reset"
      @x = payload[:x] || @prev_x
      @y = payload[:y] || @prev_y
    end
  end

end