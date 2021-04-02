# @summary
#   Provides a structure for defining client overrides.
#
# @see https://github.com/AdguardTeam/AdGuardHome/wiki/Clients
type Adguard::Client = Struct[{
    name                        => String,
    tags                        => Optional[Array],
    ids                         => Array,
    use_global_settings         => Boolean,
    filtering_enabled           => Optional[Boolean],
    parental_enabled            => Optional[Boolean],
    safesearch_enabled          => Optional[Boolean],
    use_global_blocked_services => Boolean,
    blocked_services            => Optional[Array[Adguard::Blocked_service]],
    upstreams                   => Optional[Array]
}]
