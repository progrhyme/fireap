# Extends class String
class String
  def to_snakecase
    str = self
    if /^([A-Z]+)/.match(str)
      str = $&.downcase + $'
    end
    while /[A-Z]+/.match(str)
      str = [$`, '_', $&.downcase, $'].join
    end
    str
  end
end
