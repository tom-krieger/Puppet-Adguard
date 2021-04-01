# @summary
#   Provides a structure for defining client overrides.
#   For more information see the official AdGuard docs: https://github.com/AdguardTeam/AdGuardHome/wiki/Clients
#
# @example
#   {
#      name => 'My Laptop',
#      tags => ['my_tag'],
#      ids  => ['00:1B:44:11:3A:B7'],
#      use_global_settings => false,
#      filtering_enabled => true,
#      parental_enabled => false,
#      safesearch_enabled => false,
#      use_global_blocked_services => false,
#      blocked_services => ['Facebook'],
#      upstreams => ['8.8.8.8']
#   }
#
# @param name
#   The name of the client.
# @param tags
#   Any tags to provide for the client
# @param ids
#   An array of ids to use for the client (usually MAC address)
# @param use_global_settings
#   Whether or not to use the global settings
# @param filtering_enabled
#   Whether to enable or disable filtering for this client
# @param parental_enabled
#   Whether to enable or disable parental filtering for this client
# @param safesearch_enabled
#   Whether to force safesearches on this client or not
# @param use_global_blocked_services
#   Whether to override the global_blocked_services for this client or not
# @param blocked_services
#   Which services to block for this client
# @param upstreams
#   Override upstream DNS servers for this client
type Adguard::Client = Struct[
    name => String,
    tags => Optional[Array],
    ids => Array,
    use_global_settings => Boolean,
    filtering_enabled => Optional[Boolean],
    parental_enabled  => Optional[Boolean],
    safesearch_enabled => Optional[Boolean],
    use_global_blocked_services => Boolean,
    blocked_services => Optional[Array[Adguard::Blocked_service]],
    upstreams => Optional[Array]
]
