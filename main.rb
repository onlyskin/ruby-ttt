#!/usr/bin/env ruby
require_relative 'lib/ui.rb'
require_relative 'lib/app.rb'

ui = Ui.new
ui.clear
app = App.new(ui)
app.run
