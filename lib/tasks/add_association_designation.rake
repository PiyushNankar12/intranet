require 'csv'
desc 'Add association between EmployeeDetail & Designation from csv'
namespace :add_association_designation do

  task :add_designation_to_employee_detail =>
    [:environment, :add_default_designations] do
    file = "#{Rails.root}/tmp/employee_data.csv"
    CSV.open(file, 'r', headers: true).each do |reader|
      user = User.find(reader['User ID'])
      designation = Designation.find_by(name: reader['Designation'])
      user.designation = designation
      user.save
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
