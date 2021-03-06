require 'fireap/view_controller/terminal'
require 'fireap/view_model/application'

module Fireap
  class Monitor

    # @param ctx [Fireap::Context]
    def initialize(options, ctx)
      @appname  = options['app']
      @appdata  = Fireap::ViewModel::Application.new(options['app'], ctx)
      @interval = options['interval'].to_i || 2
      @ctx      = ctx
    end

    def monitor(options)
      @screen = Fireap::ViewController::Terminal.new

      int = 0
      Signal.trap(:INT) { int = 1 }

      @appdata.refresh
      while int == 0
        @screen.clear
        @screen.draw( @appdata.render_text )
        sleep @interval
        @appdata.refresh
      end

      @screen.finalize

      puts "End."
    end

    def oneshot(options)
      @appdata.refresh
      puts @appdata.render_text
    end
  end
end
