require 'json'

class JsonSSE
  def initialize(io)
    @io = io
  end

  def write(object)
    @io.write "data: #{JSON.dump(object)}\n\n"
  end

  def close
    @io.close
  end
end

class StartController < ApplicationController
  include ActionController::Live

  def show
    response.headers['Content-Type'] = 'text/event-stream'

    sse = JsonSSE.new(response.stream)

    begin
      RethinkDB::RQL.new.table( Article.table_name ).get(Article.last.id).changes.run(NoBrainer.connection.raw).each do |change|
        sse.write(change['new_val'])
      end
    rescue *client_disconnected
    ensure
      sse.close rescue nil
      NoBrainer.disconnect rescue nil
    end
  end

  private

  def client_disconnected
    return ActionController::Live::ClientDisconnected, IOError
  end
end
