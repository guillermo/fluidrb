begin
  require 'wirble'

    # start wirble (with color)
    Wirble.init
    Wirble.colorize
rescue LoadError => err
  puts "sudo gem install wirble to get some colorization"
end


FDB = FluidDB
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.fluiddb-history" 

puts <<-EOF
Welcome to FluidDB Ruby Console
===============================

Remember: FDB == FluidDB
set $debug = true for debugg messages
EOF
