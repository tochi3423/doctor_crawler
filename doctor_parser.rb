require_relative './common.rb'

class DoctorParser
  def parse_doctor(html)
    doc = Nokogiri::HTML.parse(html, nil, "UTF-8")
    doctor_name = doc.css("div.indexIshiList.clearfix > ul > li> a")
    return doctor_name
  end

  def parse_detail_page(html)
    doctor_hash = {}
    doc = Nokogiri::HTML.parse(html, nil, "UTF-8")
    doctor_hash["time_table"] = doc.css("#rightIn > div > div.staffYotei > dl > dd")&.text
    return doctor_hash if doc.css("div.staffHead > dl.clearfix").text.blank?
    doc.css("div.staffHead > dl").each do |dl|
      if dl.css("dt h5").text.include?("認定資格")
        doctor_hash["certification"] = dl.css("dd > div > p").text
      elsif dl.css("dt h5").text.include?("専門領域")
        doctor_hash["major"] = dl.css("dd p").text
      end
    end
    return doctor_hash
  end
end