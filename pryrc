require 'ori'

class Object
  # Return only the methods not present in basic objects
  def interesting_methods
    (self.methods - Object.new.methods).sort
  end
end
