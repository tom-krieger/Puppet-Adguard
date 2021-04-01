# @summary
#   A structured hash used to supply DHCP options for IPV4
#   For more information see the DHCP section of https://github.com/AdguardTeam/AdGuardHome/wiki/Configuration#configuration-file
#
# @param lease_duration
#   The lease duration in seconds (AdGuards default is 86400)
type Adguard::Dhcp_v4_options = Struct[
  gateway_ip => Stdlib::IP::Address::V4::Nosubnet,
  subnet_mask => Stdlib::IP::Address::V4::Nosubnet,
  range_start => Stdlib::IP::Address::V4::Nosubnet,
  range_end => Stdlib::IP::Address::V4::Nosubnet,
  lease_duration => Integer,
  options => Optional[Array[Adguard::Dhcp_option]],
]
