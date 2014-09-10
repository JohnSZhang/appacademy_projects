#Q1 Write a method super_print that takes a String. This method should take optional parameters :times, :upcase, and :reverse. Hardcode reasonable defaults in a defaults hash defined in the super_print method. Use Hash#merge to combine the defaults with any optional parameters passed by the user. Do not modify the incoming options hash.
require 'debugger'
def super_print(text, options = {})
  default_options = { times: 1, upcase: false, reverse: false }
  options = default_options.merge(options)
  text = text.upcase if options[:upcase]
  text = text * options[:times]
  text = text.reverse if options[:reverse]
  text
end