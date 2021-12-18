require "./lib.rb"

begin
  include TinyPostManLib
  if ARGV[0] === "-remove-token"
    TinyPostManLib.remove_token
  end
  TinyPostManLib.banner
  TinyPostManLib.check_token
  token = TinyPostManLib.read_token
  api_server = TinyPostManLib.ask_for_api_server
  use_ssl = TinyPostManLib.should_ssl_be_included
  while true
    endpoint = TinyPostManLib.ask_for_endpoint
    method = TinyPostManLib.ask_for_method
    payload = TinyPostManLib.ask_for_payload
    response = ""
    TinyPostManLib.pre_request
    if method == "POST"
      response = TinyPostManLib.porform_post_request api_server + endpoint, token, payload, use_ssl
    elsif method == "PUT"
      response = TinyPostManLib.porform_put_request api_server + endpoint, token, payload, use_ssl
    elsif method == "GET"
      response = TinyPostManLib.porform_get_request api_server + endpoint, token, use_ssl
    elsif method == "DELETE"
      response = TinyPostManLib.porform_delete_request api_server + endpoint, token, use_ssl
    else
      TinyPostManLib.throw_my_error "invalid method!", true
    end
    TinyPostManLib.show_response response
  end
rescue SystemExit, Interrupt
  TinyPostManLib.throw_my_error "good bye :*)", true
rescue Exception => e
  puts e
end
