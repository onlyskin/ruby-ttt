#!/usr/bin/env ruby
require_relative 'lib/app.rb'

app = App.new($stdin, $stdout)
app.run
