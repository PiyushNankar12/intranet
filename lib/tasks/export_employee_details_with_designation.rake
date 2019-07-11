require 'csv'
desc 'Export employee details with designation'
task :export_employee_details_with_designation => :environment do
  file = "#{Rails.root}/tmp/employee_data.csv"
  column_headers = ['User ID', 'Designation']
  CSV.open(file, 'w', write_headers: true, headers: column_headers) do |writer|
    User.each do |user|
      writer << [user.id.to_s, user.designation]
    end
  end
end
