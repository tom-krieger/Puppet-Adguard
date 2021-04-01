# @summary
#   Valid DNS server types
type Adguard::Dns_server = Variant[Stdlib::IP::Address,Stdlib::HTTPUrl,Adguard::Ipv4_port]
