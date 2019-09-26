require_relative './selenium.rb'

class DoctorCrawler < SeleniumHelper
  def navigate_web_page
    @session.navigate.to("http://hospinfo.tokyo-med.ac.jp/ishi/")
    sleep_designated
  end

  def input_clinical_department(department)
    select = Selenium::WebDriver::Support::Select.new(@session.find_element(:css, "select[name='shinryoka']"))
    select.select_by(:text, department.text)
    sleep_designated
    return html
  end

  def get_department
    select = Selenium::WebDriver::Support::Select.new(@session.find_element(:css, "select[name='shinryoka']"))
    departments = select.options
    return departments
  end

  def navigate_detail_page(url)
    @session.navigate.to(url)
    sleep_designated
    return html
  end
end