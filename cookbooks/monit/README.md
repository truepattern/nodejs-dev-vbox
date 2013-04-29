Overview
========

Chef cookbook for the [monit](http://mmonit.com/monit/) monitoring and
management tool. This cookbook has been updated to configure services 
defined in a data bag.

This cookbook was forked from [StudyBlue/monit](https://github.com/StudyBlue/monit), version 0.7.

Attributes
==========


* `default[:monit][:services]` - List of items from the _monit_ data bag that describe services monitored by monit. For more info, see *Usage* below.
* `default[:monit][:logfile]` - The file to which monit logs are written
* `default[:monit][:notify][:enable]` - enable email notifications
* `default[:monit][:notify][:email]` - the email to which notifications are sent.
* `default[:monit][:httpd][:enable]` - enable the http server
* `default[:monit][:httpd][:port]` - port on which the http server listens
* `default[:monit][:httpd][:address]` - the address to which the server binds
* `default[:monit][:httpd][:allow]` - the addresses from which connections are allowed (default `%w{localhost}`)
* `default[:monit][:httpd][:signature]` - either "enable" or "disable". Determines whether monit shows a signature
* `default[:monit][:httpd][:basic_auth_accounts]` - An array of `admin:"password"` entries that are used for HTTP Basic Auth. Not the quotes around the password; these are required.
* `default[:monit][:poll_period]` - the time (in seconds) between poll cycles
* `default[:monit][:poll_start_delay]` - the amount of time (in seconds) before monit starts polling services.
* `default[:monit][:mail][:server]` - host on which the smtp mail server runs
* `default[:monit][:mail][:port]` - The port on which the SMTP server runs (default is 25)
* `default[:monit][:mail][:username]` - Username for an SMTP account
* `default[:monit][:mail][:password]` - Password for an SMTP account
* `default[:monit][:mail][:security]` - Send secure email. Must be one of: SSLV2, SSLV3 or TLSV1
* `default[:monit][:mail][:checksum]` - SMTP Server certificat checksum (optional)
* `default[:monit][:mail][:timeout]` - The timeout (in seconds) for sending mail
* `default[:monit][:mail][:use_node_fqdn]` - Whether or not to use the node's FQDN in as the hostname (default is `false`)
* `default[:monit][:mail][:format][:subject]` - default subject for emails from monit
* `default[:monit][:mail][:format][:from]` - email address from which messages are sent
* `default[:monit][:mail][:format][:message]` - template for messages (see `attributes/default.rb` for details)
* `default[:monit][:queue][:location]` - base directory where events will be stored
* `default[:monit][:queue][:slots]` - limit the size of the queue; this is the number of messages that will be held

Usage
=====

Right now, this cookbook only supports simple process monitoring. To set up process monitors, create a `monit` data bag, and create items that look similar to the following:

This would be `data_bags/monit/monit_services.json`:

    {
      "id": "monit_services",
      "postgresql": {
        "process_name": "postgres",
        "pidfile":      "/var/run/postgresql/9.1-main.pid",
        "start_command":"/usr/sbin/service postgresql start",
        "stop_command": "/usr/sbin/service postgresql stop",
        "check_port": "5432",
        "check_protocol": "pgsql",
        "check_times": 2,
        "within_cycles": 3,
        "then_action": "restart"
      },
      "supervisor": {
        "process_name": "supervisor",
        "pidfile":      "/var/run/supervisord.pid",
        "start_command":"/etc/init.d/supervisor start",
        "stop_command":"/etc/init.d/supervisor stop",
        "check_socket": "/var/run/supervisor.sock",
        "check_times": 1,
        "within_cycles": 2,
        "then_action": "restart"
      }
    }

This item would set up a monitor for the `postgres` and `supervisor` processes. Note that it checks for PostgreSQL using a TCP port while Supervisor uses a Unix socket.

This would result in the following:
* `/etc/monit/conf.d/postgresql.conf`:

        CHECK PROCESS postgres WITH PIDFILE /var/run/postgresql/9.1-main.pid
          START PROGRAM "/usr/sbin/service postgresql start"
          STOP PROGRAM "/usr/sbin/service postgresql stop"
          IF FAILED PORT 5432 PROTOCOL pgsql 2 TIMES WITHIN 3 CYCLES THEN restart

* `/etc/monit/conf.d/supervisor.conf`:

        CHECK PROCESS supervisor WITH PIDFILE /var/run/supervisord.pid
          START PROGRAM "/etc/init.d/supervisor start"
          STOP PROGRAM "/etc/init.d/supervisor stop"
          IF FAILED unixsocket /var/run/supervisor.sock 1 TIMES WITHIN 2 CYCLES THEN restart

You can then set up a role, and override any of the existing attributes, and specify any data bag items taht will be used to set up service monitoring.

You might have a `monit` role that looks like:

    name "monit"
    description "Monit role"
    run_list(
      "recipe[monit::default]",
      "recipe[monit::services]"
    )

    default_attributes(
      "monit" => {
        "services" => ["monit_services", ],
      }
    )
    

History
=======

version 0.8.1
-------------
 * added additional SMTP configuration
 * added additional HTTPD configuration

version 0.8
-----------
 * added more generic services recipes that pulls configuration data from a data bag
 * only supporting Ubuntu/Debian
 * removed postfix/ssh recipes

version 0.7
-----------
 * create /etc/monit/conf.d.  Thanks Karel Minarik (https://github.com/karmi)

version 0.6
-----------
 * Released to github
 * Defaults no alert on ACTION event.
   When you manually stop/start a service, alerting me about what I just did isn't useful.

