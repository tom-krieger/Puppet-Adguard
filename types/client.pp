# @summary
#   A hash of client overrides
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
