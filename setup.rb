#!/usr/bin/env ruby

is_update = (ARGV[0] == 'update')

# Utility functions
def log msg
  puts "===> #{msg}".green
end

def error msg
  puts msg.red
  exit 1
end

class String
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end

  def yellow
    colorize(33)
  end

  def pink
    colorize(35)
  end
end

#######################################################
# Setup environment

# Carthage installation
`which carthage`
if $?.exitstatus == 1
  log 'Installing Carthage'
  `brew install carthage`
end

#######################################################
# Libraries installation

# Carthage
if is_update
  log "Updating Carthage's libraries"
  msg = `TOOLCHAINS=com.apple.dt.toolchain.Swift_3_2 carthage update --platform iOS --cache-builds`
else
  log "Installing Carthage's libraries"
  msg = `TOOLCHAINS=com.apple.dt.toolchain.Swift_3_2 carthage bootstrap --platform iOS --cache-builds`
end
if $?.exitstatus == 1
  error msg
end
