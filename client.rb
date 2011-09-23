require 'bundler/setup'
require 'eventmachine'

module Handler
  include EM::Deferrable

  def receive_data(data); end

  def connection_completed
    start_tls(verify_peer: false)
    EM.system("ps -p #{Process.pid} v") { |out, status| puts out }
    succeed
  end
end

EM.run do
  EM::Iterator.new(0..1000, 10).each do |n, iter|
    EM.connect('127.0.0.1', 1234, Handler) do |c|
      c.callback { iter.next }
    end
  end
end
