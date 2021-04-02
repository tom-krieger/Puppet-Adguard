# @summary
#   A structured hash for sepcifying DHCP options for IPV6
#
#
type Adguard::Dhcp_v6_options = Struct[
  range_start => Stdlib::IP::Address::V6,
  lease_duration => Integer,
  ra_slaac_only => Boolean,
  ra_allow_slaac => Boolean,
]
