# frozen_string_literal: true

# TODO: Pry-byebug config from all the below.

# Refs https://github.com/pry/pry/wiki/Customization-and-configuration
#      https://github.com/justin808/justin808-dotfiles/blob/master/home/.pryrc
#      https://raw.githubusercontent.com/JuanitoFatas/dotpryrc/master/.pryrc
#      https://gist.githubusercontent.com/devonzuegel/c6e69d1d9981fc740a46/raw/552eab2ee027bb138a7f253e64d71fe61f8bbc90/.pryrc
#      https://gist.github.com/807492

# Pry config

Pry.config.commands.alias_command "e", "quit", desc: "Leave Pry REPL"
def r
  reload!
end

Pry.config.history_file = "~/.irb-pry-command-history"
Pry.config.history_load = true
# Pry.config.editor = "nvim"

prompt = "".dup
prompt << "AWS@" if defined?(AWS)
prompt << "#{Rails.version}@" if defined?(Rails)
prompt << RUBY_VERSION.to_s
prompt << " on #{ENV['DEPLOY_ENV']}" if defined?(ENV["DEPLOY_ENV"]) && ENV["DEPLOY_ENV"]
Pry.config.prompt = Pry::Prompt.new(
  prompt,
  prompt,
  [proc { |obj, nest_level, _| "[#{nest_level}] #{prompt}(#{obj})-> " }]
)

default_command_set = Pry::CommandSet.new do
  command "copy", "Copy argument to the clip-board" do |str|
    IO.popen("pbcopy", "w") { |f| f << str.to_s }
  end
end
Pry.config.commands.import default_command_set

my_hook = Pry::Hooks.new.add_hook(:before_session, :add_dirs_to_load_path) do
  # adds the directories /spec and /test directories to the path if they exist and not already included
  dir = `pwd`.chomp
  dirs_added = []
  %w{spec test presenters lib}.map { |d| "#{dir}/#{d}" }.each do |p|
    if File.exist?(p) && !$LOAD_PATH.include?(p)
      $LOAD_PATH << p
      dirs_added << p
    end
  end
  puts "Added #{dirs_added.join(', ')} to load path in ~/.pryrc." if dirs_added.any?
end
my_hook.exec_hook(:before_session)

# Helpers

def do_time(repetitions = 100, &block)
  require "benchmark"
  Benchmark.bm { |b| b.report { repetitions.times(&block) } }
end

# Use Array.toy or Hash.toy to get an array or hash to play with
class Array
  def self.toy(n = 10, &block)
    block_given? ? Array.new(n, &block) : Array.new(n) { |i| i + 1 }
  end
end

class Hash
  def self.toy(n = 10)
    Hash[Array.toy(n).zip(Array.toy(n) { |c| (96 + (c + 1)).chr })]
  end
end

# External Integrations

# look at ~/.aprc for more settings for awesome_print
begin
  require "awesome_print"
  # If you want awesome_print without automatic pagination, use the line below
  Pry.config.print = proc { |output, value| output.puts value.ai }
rescue LoadError => e
  puts "gem install awesome_print  # <-- highly recommended"
end

# load Rails Console helpers like reload
# Although ... this doesn't seem to include reload!
if defined?(Rails)
  begin
    require "rails/console/app"
    require "rails/console/helpers"
    extend Rails::ConsoleMethods
    puts "Rails Console Helpers loaded"
  rescue LoadError => e
    require "console_app"
    require "console_with_helpers"
  end
end

# Hit !! to repeat last command
Pry::Commands.command /^!!$/, "repeat last command" do
  pry_instance.input = StringIO.new(Pry.history.to_a.last)
end


# Rails cheatsheet

# distinct values
# BpLocation.select(:country).distinct

# Count occurences
# BpLocation.group("country").count("country")
# or Record.count('DISTINCT date')


# Aliases

# Run Pry.history.load first
Pry.config.commands.alias_command "ha", "hist -a", desc: "History for all users"
Pry.config.commands.alias_command "hg", "hist -T 20 -G", desc: "Up to 20 commands matching expression"
Pry.config.commands.alias_command "hG", "hist -G", desc: "Commands matching expression ever used"
Pry.config.commands.alias_command "hr", "hist -r", desc: "hist -r <command number> to run a command"

puts "Loaded ~/.pryrc"
puts
