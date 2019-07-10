require 'csv'
desc 'Add association between EmployeeDetail & Designation from csv'
namespace :add_association_designation do

  task :add_designation_to_employee_detail =>
    [:environment, :add_default_designations] do
    file = "#{Rails.root}/tmp/employee_data.csv"
    CSV.open(file, 'r', headers: true).each do |reader|
      employee_detail = EmployeeDetail.find(reader['EmployeeDetail ID'])
      designation = Designation.find_by(name: reader['Designation'])
      employee_detail.designation = designation
      employee_detail.save!
    end
    CSV.open(file, 'r', headers: true).each do |reader|
      emp_det = EmployeeDetail.find(reader['EmployeeDetail ID'])
      desg    = Designation.find_by(name: reader['Designation'])
      if emp_det.designation_id.blank? || (emp_det.designation != desg)
        puts "Invalid designation assigned to employee detail #{emp_det.id}"
      end
    end
  end

  task :add_default_designations => :environment do
    DESIGNATIONS = [
      "Co-Founder & Director", "Director", "Director Engineering",
      "Software Architect", "Team Lead", "Operations Head",
      "Senior QA & Developer", "Senior Software Engineer", "Senior Accountant",
      "HR Executive", "Android Developer", "Software Engineer", "iOS Developer",
      "People & Culture Manager"
    ]
    DESIGNATIONS.each do |designation|
      Designation.create(name: designation)
    end
  end
end
