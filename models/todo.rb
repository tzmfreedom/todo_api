class Todo < ActiveRecord::Base
  before_update :set_completed_at, :if => lambda { self.completed_changed? && self.completed == true }
 
  def set_completed_at
    self.completed_at = Time.now
  end
end