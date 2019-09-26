class SeleniumHelper
  attr_accessor :session
  attr_accessor :sleep_time
  attr_accessor :timeout_wait
  def initialize(sleep_time: 1)
    @sleep_time = sleep_time
    Selenium::WebDriver::Chrome.driver_path = "/mnt/c/chromedriver.exe"
    ua = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.116 Safari/537.36"
    caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {args: ["--headless","--no-sandbox", "--disable-setuid-sandbox", "--disable-gpu", "--user-agent=#{ua}", 'window-size=1280x800']})
    caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {args: ["--user-agent=#{ua}", "window-size=1280x800"]})
    client = Selenium::WebDriver::Remote::Http::Default.new
    client.read_timeout = timeout_wait
    client.open_timeout = timeout_wait
    @session = Selenium::WebDriver.for :chrome, desired_capabilities: caps, http_client: client
    @session.manage.timeouts.implicit_wait = timeout_wait
  end

  def timeout_wait
    return 300 if @timeout_wait.nil?
    @timeout_wait
  end

  def sleep_designated
    sleep @sleep_time
  end

  def html
    @session.page_source
  end
end