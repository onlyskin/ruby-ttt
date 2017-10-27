class IdGenerator
  def initialize
    @seed = 0
  end

  def id
    @seed = @seed + 1
    @seed
  end
end
