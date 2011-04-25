class Journal < ActiveRecord::Base
  validates_presence_of :unique_id, :title
  validates_uniqueness_of :unique_id, :case_sensitive => false
end
