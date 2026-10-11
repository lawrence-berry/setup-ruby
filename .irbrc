# frozen_string_literal: true

require "irb/ext/save-history"
require "irb/completion"
require "rubygems"
require "pp"

# wirble adds colour + the po/poc shortcuts, but it's optional.
begin
  require "wirble"
  Wirble.init
  Wirble.colorize
rescue LoadError
  # gem install wirble  # for colour output
end

IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "~/.irb-pry-command-history"
IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:AUTO_INDENT] = true
# IRB.conf[:BACK_TRACE_LIMIT] = 100

# Functions

# Command history via irb/ext/save-history
# Up/down arrows don't work so use this instead.
def hist(count = 0)
  history_array = Readline::HISTORY.to_a
  if count.positive?
    from = history_array.length - count
    history_array = history_array[from..-1]
  else
    count = 0
  end
  print history_array.join("\n")
end

def cp(string)
  `echo "#{string}" | pbcopy`
  puts "copied in clipboard"
end

def r!
  reload!
end
# Aliases

# Remember Wirble adds po and poc automatically
# see https://www.rubydoc.info/gems/wirble/0.1.3/Wirble/Shortcuts
alias e exit
alias h hist

# Mixins & Overrides

# print SQL to STDOUT
if ENV.include?("RAILS_ENV") && !Object.const_defined?("RAILS_DEFAULT_LOGGER")
  require "logger"
  RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
end

class Object
  # open json object in VS Code Editor
  def open_in_editor
    tempfile = File.join("tmp", SecureRandom.hex)
    File.open(tempfile, "w") { |f| f << as_json }
    system("#{'code' || 'vim'} #{tempfile}")
    sleep(1)
    File.delete(tempfile)
  end
end
