require_relative './doctor_crawler.rb'
require_relative './doctor_parser.rb'
require_relative './common.rb'

class DoctorLogic
  def initialize
    @crawler = DoctorCrawler.new
    @parser = DoctorParser.new
  end

  def main
    @crawler.navigate_web_page
    departments = @crawler.get_department
    departments.delete_if do |department|
      department.text == "診療科を選択する" || department.text == "指定なし"
    end
    departments.each do |department|
      html = @crawler.input_clinical_department(department)
      doctor_name = @parser.parse_doctor(html)
      doctor_name.each do |doctor|
        doctor_hash ={
          "name" => doctor.text,
          "url" => "http://hospinfo.tokyo-med.ac.jp/#{doctor.attribute('href')}",
          "department" => department.text
        }
        insert_hash(Doctor, doctor_hash)
      end
    end
    doctor_arr = Doctor.pluck(:id, :url)
    doctor_arr.each do |doctor|
      html = @crawler.navigate_detail_page(doctor[-1])
      new_doctor_hash = @parser.parse_detail_page(html)
      Doctor.find(doctor[0]).update(new_doctor_hash)
    end
  end

  def insert_hash(class_name, hash)
    class_name.create(hash)
  end
end

logic = DoctorLogic.new
logic.main