# @summary
#   A structured hash used to supply DHCP options for IPV4
#
# @see https://github.com/AdguardTeam/AdGuardHome/wiki/Configuration#configuration-file
type Adguard::Dhcp_v4_options = Struct[{
  gateway_ip     => Stdlib::IP::Address::V4::Nosubnet,
  subnet_mask    => Stdlib::IP::Address::V4::Nosubnet,
  range_start    => Stdlib::IP::Address::V4::Nosubnet,
  range_end      => Stdlib::IP::Address::V4::Nosubnet,
  lease_duration => Integer,
  options        => Optional[Array[Adguard::Dhcp_option]],
}]
