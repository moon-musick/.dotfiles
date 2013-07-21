require 'rubygems' unless defined? Gem
require 'irb/completion'
require 'wirb'
Wirb.start

IRB.conf[:AUTO_INDENT] = true

class Object
  # Return only the methods not present in basic objects
  def interesting_methods
    (self.methods - Object.new.methods).sort
  end
end
