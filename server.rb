require 'bundler/setup'
require 'eventmachine'

module Handler
  def receive_data(data); end

  def post_init
    start_tls(private_key_file: 'test.key', cert_chain_file: 'test.crt', verify_peer: false)
    EM.system("ps -p #{Process.pid} v") { |out, status| puts out }
  end
end

EM.run do
  EM.start_server('127.0.0.1', 1234, Handler)
end
