default[:monit][:services]              = [] # List of items from the "monit" data bag that
                                             # describe services monitored by monit.
default[:monit][:logfile]               = "syslog facility log_daemon"

# The following is a list of events for which monit will send notifications:
default[:monit][:notify][:events]       = []
default[:monit][:notify][:negate_events]= false # if true, will negate the list of notification events
default[:monit][:notify][:enable]       = false # set true to send alerts
default[:monit][:notify][:email]        = "notify@example.com" # address to which alerts are sent

default[:monit][:httpd][:enable]        = true
default[:monit][:httpd][:port]          = 3737
default[:monit][:httpd][:address]       = nil # hosts can only connect from this address; monit defaults to "localhost"
default[:monit][:httpd][:allow]         = nil # default: %w{localhost}
default[:monit][:httpd][:signature]     = "enable" # or disable
default[:monit][:httpd][:basic_auth_accounts] = [] # a list of 'admin:"password"' entries to use for BasicAuth
                                                   # the quotes around the password are required!

default[:monit][:poll_period]           = 60
default[:monit][:poll_start_delay]      = 120

default[:monit][:mail][:server]         = "localhost"
default[:monit][:mail][:port]           = "25"
default[:monit][:mail][:username]       = nil
default[:monit][:mail][:password]       = nil
default[:monit][:mail][:security]       = nil # SSLV2, SSLV3 or TLSV1
default[:monit][:mail][:checksum]       = nil # the server certificate checksum
default[:monit][:mail][:timeout]        = "5" # timeout in seconds for the mail server 
default[:monit][:mail][:use_node_fqdn]  = false # Use the Node's FQDN for "using hostname" 
default[:monit][:mail][:format][:subject] = "$SERVICE $EVENT"
default[:monit][:mail][:format][:from]    = nil  # defaults to "monit@hostname"
default[:monit][:mail][:format][:message]    = <<-EOS
Monit $ACTION $SERVICE at $DATE on $HOST: $DESCRIPTION.
Yours sincerely,
monit
EOS

default[:monit][:queue][:location]      = "/var/monit"  # base directory where events will be stored
default[:monit][:queue][:slots]         = nil           # limit the size of the queue
