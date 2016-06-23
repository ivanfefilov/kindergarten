require "administrate/field/base"

class CkeditorField < Administrate::Field::Base
  def to_s
    data
  end
end
