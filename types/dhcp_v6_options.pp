# @summary
#   A structured hash for sepcifying DHCP options for IPV6
#
# @see https://github.com/AdguardTeam/AdGuardHome/wiki/DHCP#dhcpv6-options
type Adguard::Dhcp_v6_options = Struct[{
  range_start    => Stdlib::IP::Address::V6,
  lease_duration => Integer,
  ra_slaac_only  => Boolean,
  ra_allow_slaac => Boolean,
}]
