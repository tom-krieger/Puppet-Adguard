# @summary
#   Ensures correct input for DHCP options
type Adguard::Dhcp_option = Variant[Pattern[/^(\d)* hex ([\da-fA-F]{2})([\da-fA-F]{2})([\da-fA-F]{2})*$/],Stdlib::IP::Address::V4::Nosubnet]
