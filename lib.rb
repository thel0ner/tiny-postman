require "net/http"
require "uri"
require "json"
require "rainbow"
require "readline"

module TinyPostManLib
  def banner()
    puts Rainbow("Welcome to TinyPostMan, a simple API tester - Version 1.0.0").blue.underline
  end

  def remove_token()
    if File.exists?("./token.txt") === true
      puts Rainbow("removing token.txt ...").cyan
      File.delete("./token.txt")
      puts Rainbow("token.txt removed successfully").green
    end
  end

  def check_token()
    if File.exists?("./token.txt") === false
      puts Rainbow("Token not provided").red
      puts Rainbow("Provide token here, and then press enter:").cyan
      token = Readline.readline("Bearer ", true)
      file = File.new("./token.txt", "w")
      if file
        file.syswrite(token)
        puts Rainbow("token saved successfully").green
      else
        puts Rainbow("could not create file! please check permissions!").red
        puts Rainbow("Aborting...").cyan
        exit()
      end
    else
      puts Rainbow("token file found successfully").green
    end
  end

  def read_token()
    answer = ""
    IO.foreach("./token.txt") do |line|
      answer = answer + line
    end
    answer
  end

  def ask_for_api_server()
    puts Rainbow("Please enter the url of api server: ").cyan
    api_server = Readline.readline("", true)
    api_server
  end

  def should_ssl_be_included()
    puts Rainbow("Should use SSL? (Y/n)").cyan
    should_use_ssl = Readline.readline("", false)
    if (should_use_ssl === "Y")
      true
    else
      false
    end
  end

  def ask_for_endpoint()
    puts Rainbow("Please enter the endpooint: ")
    end_point = Readline.readline("", true)
    end_point
  end

  def ask_for_method()
    puts Rainbow("Which method do you want to choose? (POST,GET,PUT,DELETE)")
    method_choosen = Readline.readline("", true)
    method_choosen
  end

  def ask_for_payload()
    puts Rainbow("Enter the payload: ")
    payload = Readline.readline("", true)
    payload
  end

  def throw_my_error(inpt, should_die)
    puts Rainbow(inpt).red
    if should_die
      exit()
    end
  end

  def pre_request()
    puts Rainbow("Sending request...").green
  end

  def show_response(response)
    puts Rainbow("Parsing response....").green
    puts JSON.pretty_generate(JSON.parse(response))
    puts Rainbow('Request completed, now I\'m ready for another round of requst :/').blue
  end

  def porform_post_request(path, token, payload, is_ssl)
    uri = URI.parse(path)
    header = {
      'Content-type': "application/json",
      'Authorization': "Bearer " + token,
    }
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = is_ssl
    request = Net::HTTP::Post.new(uri.request_uri, header)
    request.body = payload
    response = http.request(request)
    response.body
  end

  def porform_put_request(path, token, payload, is_ssl)
    uri = URI.parse(path)
    header = {
      'Content-type': "application/json",
      'Authorization': "Bearer " + token,
    }
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = is_ssl
    request = Net::HTTP::Put.new(uri.request_uri, header)
    request.body = payload
    response = http.request(request)
    response.body
  end

  def porform_get_request(path, token, is_ssl)
    uri = URI.parse(path)
    header = {
      'Content-type': "application/json",
      'Authorization': "Bearer " + token,
    }
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = is_ssl
    request = Net::HTTP::Get.new(uri)
    response = http.request(request)
    response.body
  end

  def porform_delete_request(path, token, is_ssl)
    uri = URI.parse(path)
    header = {
      'Content-type': "application/json",
      'Authorization': "Bearer " + token,
    }
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = is_ssl
    request = Net::HTTP.Delete.new(uri.request_uri, header)
    response = http.request(request)
    response.body
  end
end
