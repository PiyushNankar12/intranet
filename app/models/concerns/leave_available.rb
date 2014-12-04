module LeaveAvailable
  extend ActiveSupport::Concern
  
  def assign_leave
    date_of_joining = self.private_profile.date_of_joining
    self.employee_detail.update_attribute(:available_leaves, calculate_leave(date_of_joining))
  end   
 
  def calculate_leave(date_of_joining)
    leaves = (13 - date_of_joining.month) * PER_MONTH_LEAVE
    leaves = leaves - 1 if date_of_joining.day > 15
    leaves
  end

  def set_leave_details_per_year
    self.employee_detail.update_attribute(:available_leaves, PER_MONTH_LEAVE*12)
  end
  
  def eligible_for_leave?
    !!(self.private_profile.try(:date_of_joining).try(:present?) && ['Admin', 'Intern'].exclude?(self.role))
  end  
end 
