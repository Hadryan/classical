class Album < ActiveRecord::Base
  belongs_to :composer
  belongs_to :obraType
  belongs_to :solist
  belongs_to :director
  belongs_to :orchest
end
