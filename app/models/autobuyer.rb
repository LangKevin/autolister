class AutoBuyer < ActiveRecord::Base
  belongs_to :auto
  belongs_to :buyer
end
