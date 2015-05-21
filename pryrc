# vim: ft=ruby
require 'ori'
require 'interactive_editor'

class Object
  # Return only the methods not present in basic objects
  def interesting_methods
    (self.methods - Object.new.methods).sort
  end
end

# https://github.com/deivid-rodriguez/pry-byebug
if defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
  Pry::Commands.delete 'c'
  Pry::Commands.delete 'n'
  Pry::Commands.delete 's'
  Pry::Commands.delete 'f'
end
