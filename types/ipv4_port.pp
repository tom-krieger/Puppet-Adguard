# @summary 
#   Accepts an IPV4 address with a port (eg 192.168.1.1:8080)
type Adguard::Ipv4_port = Pattern[/[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}:[0-9]{1,5}/]
