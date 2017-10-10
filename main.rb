#!/usr/bin/env ruby
require_relative 'lib/App.rb'
require_relative 'lib/Board.rb'

app = App.new($stdin, $stdout, Board.new)
app.run
