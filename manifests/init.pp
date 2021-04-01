# @summary Manages an Adguard Home installation
# 
# @param webui_interface
#   The interface to bind the WebUI to.
#   Default: 0.0.0.0 (all interfaces)
# @param webui_port
#   The port to bind the WebUI to.
#   Default: 80
# @param users
#   The users to add to the WebUI in an array of hashes.
#   `[{username => 'user', password => '$2a$10$DBX2KdCRP6JKS8TqvkVWTOjUgUQLtlWGkxkZAuiUZGTURhorjlX6K'}]`
#   Note: the password needs to be in BCrypt-encrypted format, to get a password: `htpasswd -bnBC 10 "" MY_NEW_PASS | tr -d ':'`
# @param http_proxy
#   Define an optional http_proxy.
#   While adguard supports SOCKS5 alongside HTTP/S, this is **not** supported in the Puppet module at this time.
#   Default: undef
# @param rlimit_nofile
#   Limit on the maximum number of open files for server process (Linux).
#   Default: 0 (use system default)
# @param debug_pprof
#   Enable pprof HTTP server listening on port 6060 for debugging. 
#   Default: false
# @param web_session_ttl
#   Web session TTL (in hours) a web user will stay signed in for this amount of time.
#   Default: 8
# @param dns_interface
#   The interface to bind to for DNS.
#   Default: 0.0.0.0 (all interfaces)
# @param dns_port
#   The port to bind dns to, defaults to 53.
#   Note: if you're on a systemd OS and you're binding to port 53 AdGuard won't be able to start due to resolved's DNSStubListener
#   as such DNSStubListener will be disabled in /etc/systemd/resolved.conf, 
#   this WILL break name resolution when there's no DNS server running locally.
# @param statistics_interval
#   Time interval for statistics (in days).
#   Default: 1
# @param querylog_enabled
#   Query logging (also used to calculate top 50 clients, blocked domains and requested domains for statistical purposes).
#   Default: true
# @param querylog_file_enabled
#   Write query logs to a file. 
#   Default: true
# @param querylog_interval
#   Time interval for query log (in days).
#   Default: 90
# @param querylog_size_memory
#   Number of entries kept in memory before they are flushed to disk. 
#   Default: 1000
# @param anonymize_client_ip
#   If true, anonymize clients' IP addresses in logs and stats.
#   Default: false
# @param protection_enabled
#   Whether any kind of filtering and protection should be done, when off it works as a plain dns forwarder. 
#   Default: to true
# @param blocking_mode
#   Specifies how to block DNS requests. 
#   Valid options:
#     - default (respond with NXDOMAIN status) 
#     - null_ip (respond with the unspecified IP address (0.0.0.0))
#     - custom_ip (respond with blocking_ipv4 or blocking_ipv6 address)
#   Default: default
# @param blocking_ipv4
#   IP address to be returned for a blocked A request if blocking_mode is set to custom_ip. 
#   Default: undef
# @param blocking_ipv6
#   IP address to be returned for a blocked AAAA request if blocking_mode is set to custom_ip. 
#   Default: undef
# @param blocked_response_ttl
#   For how many seconds the clients should cache a filtered response. Low values are useful on LAN if you change filters very often,
#   high values are useful to increase performance and save traffic. 
#   Default: 10
# @param parental_block_host
#   IP (or domain name) which is used to respond to DNS requests blocked by parental control. 
#   Default: family-block.dns.adguard.com
# @param safebrowsing_block_host
#   IP (or domain name) which is used to respond to DNS requests blocked by safe-browsing. 
#   Default: standard-block.dns.adguard.com
# @param ratelimit
#   DDoS protection, specifies in how many packets per second a client should receive. 
#   Anything above that is silently dropped. 
#   To disable set 0, default is 20. Safe to disable if DNS server is not available from internet.
#   Default: 20
# @param ratelimit_whitelist
#   An array of ip addresses to whitelist from ratelimiting.
#   Default: undef
# @param refuse_any
#   Another DDoS protection mechanism. 
#   Requests of type ANY are rarely needed, so refusing to serve them mitigates against attackers trying to use your DNS as a reflection. 
#   Safe to disable if DNS server is not available from internet. 
#   Default: true
# @param upstream_dns
#   An array of upstream DNS servers. Can be a URL or IP.
# @param upstream_dns_file
#   Path to a file with the list of upstream DNS servers. If it is configured, the value of upstream_dns is ignored. Defaults to undef
# @param bootstrap_dns
#   List of DNS servers used for initial hostname resolution in case an upstream server name is a hostname.
#   Default:
#     - 9.9.9.9
#     - 8.8.8.8
#     - 2620:fe::fe
#     - 2620:fe::9
# @param all_servers
#   Enables parallel queries to all configured upstream servers to speed up resolving. 
#   If disabled, the queries are sent to each upstream server one-by-one and then sorted by RTT. 
#   Default: false
# @param fastest_addr
#   Use Fastest Address algorithm. It finds an IP address with the lowest latency and returns this IP address in DNS response. 
#   Default: false
# @param allowed_clients
#   IP addresses of allowed clients.
#   Default: undef
# @param disallowed_clients
#   IP addresses of disallowed clients.
#   Default: undef
# @param blocked_hosts
#   An array of hosts to block.
#   Default: undef
# @param dns_cache_size
#   DNS cache size (in bytes). 
#   Default: 4194304
# @param dns_cache_ttl_min
#   Override TTL value (minimum) received from upstream server. This value can't larger than 3600 (1 hour).
#   Default: 0 (do not override)
# @param dns_cache_ttl_max
#   Override TTL value (maximum) received from upstream server. 
#   Default: 0 (do not override)
# @param bogus_nxdomain
#    Optional - Transform responses with these IP addresses to NXDOMAIN
# @param aaaa_disabled
#   Respond with an empty answer to all AAAA requests
#   Default: false
# @param enable_dnssec
#   Set DNSSEC flag in the outgoing DNS requests and check the result.
#   Note if running an additional DNS server (such as Unbound or BIND) that uses DNSSEC you do not want DNSSEC on both
#   as you will get erroes with legitimate DNS requests.
#   Default: false
# @param edns_client_subnet
#   Enable EDNS Client Subnet option. If enabled, AdGuard Home will be sending ECS extension to the upstream DNS servers. 
#   Please note, that this will be done for clients with public IP addresses only.
#   Default: false
# @param max_goroutines
#   Max. number of parallel goroutines for processing incoming requests
#   Default: 300
# @param filtering_enabled
#   Filtering of DNS requests based on filter lists. 
#   Default: true
# @param filters_update_interval
#   How often the filters update (in hours). 
#   Default: 24.
# @param parental_enabled
#   Parental control-based DNS requests filtering
#   Default: false
# @param safesearch_enabled
#   Enforcing "Safe search" option for search engines, when possible.
#   Default: false
# @param safebrowsing_enabled
#   Filtering of DNS requests based on safebrowsing
#   Default: false
# @param safebrowsing_cache_size
#   Safe Browsing cache size (in bytes).
#   Default: 1048576
# @param safesearch_cache_size
#   Safe Search cache size (in bytes).
#   Default: 1048576
# @param parental_cache_size
#   Parental Control cache size (in bytes). 
#   Default: 1048576
# @param cache_time
#   Safe Browsing, Safe Search, Parental Control cache TTL. 
#   Default: 30
# @param rewrites
#   An array of custom rewrite rules
#   Format:
#     domain: the domain to perform the rewrite on
#     answer: the ip address to point to
#   Default: undef
# @param blocked_services
#   An array of any services you wish to block.
#   Default: undef
# @param filters
#   An array of block filters to add.
#   Format
#     name: the name for the filter (eg AdGuard Default)
#     enabled: true/false
#     url: the URL to point to
#   Default: the default list provided by AdGuard
# @param whitelist_filters
#   An array of whitelist filters to add.
#     name: the name for the filter (eg AdGuard Default)
#     enabled: true/false
#     url: the URL to point to
#   Default: undef
# @param user_rules
#   Any custom rules you'd like to define, optional.
#   Default: undef
# @param clients
#   EXPERIMENTAL: Individual client settings
#   Not extensively tested, please report any issues on the project repo.
#   Default: undef
# @param log_compress
#   Whether or not to compress the logs. 
#   Default: false
# @param log_localtime
#   Whether to format timestamps using computer's local time.
#   Default: false
# @param log_max_backups
#   Maximum number of old log files to retain (MaxAge may still cause them to get deleted) (default: 0, which retains all old log files)
#   Defaults to 0.
# @param log_max_size
#   Maximum size in megabytes of the log file before it gets rotated. 
#   Defaults: 100
# @param log_max_age
#   MaxAge is the maximum number of days to retain old log files. 
#   Default: 3
# @param log_file
#   Path to the log file. If empty, writes to stdout, if syslog -- system log (or eventlog on Windows).
#   Valid options are: unixpath, undef or 'syslog'.
#   Default: undef
# @param verbose_logging
#   Enable or disable verbose logging. Defaults to false
# @param adguard_path
#   The path to where you'd like AdGuard installed, defaults to /opt/AdGuardHome
# @param manage_config
#   Whether or not to manage the AdGuardHome.yaml file
#   This is designed as a failsafe option (see Disabling configuration file management in the README)
#   If the the file format changes drastically in the future you can set this to false to stop Puppet fighting with AdGuardHome.
#   The initial configuration file will always be created by Puppet.
#   Default: true
# @param configuration_file
#   The path to where you want to store the configuration file, must be a full path to AdGuardHome.yaml. 
#   Default: a child of adguard::adguard_path
# @param service_name
#   The name of the service to manage, defaults to AdGuardHome
# @param version
#   The version to install from the GitHub release
class adguard
(
  Stdlib::IP::Address::V4::Nosubnet $webui_interface,
  Stdlib::Port $webui_port,
  Array[Adguard::User] $users,
  Optional[Stdlib::HTTPUrl] $http_proxy,
  Integer $rlimit_nofile,
  Boolean $debug_pprof,
  Integer $web_session_ttl,
  Stdlib::IP::Address::V4::Nosubnet $dns_interface,
  Stdlib::Port $dns_port,
  Integer $statistics_interval,
  Boolean $querylog_enabled,
  Boolean $querylog_file_enabled,
  Integer $querylog_interval,
  Integer $querylog_size_memory,
  Boolean $anonymize_client_ip,
  Boolean $protection_enabled,
  Enum['default','null_ip','custom_ip'] $blocking_mode,
  Optional[Stdlib::IP::Address::V4::Nosubnet] $blocking_ipv4,
  Optional[Stdlib::IP::Address::V6] $blocking_ipv6,
  Integer $blocked_response_ttl,
  Variant[Stdlib::Fqdn,Stdlib::IP::Address] $parental_block_host,
  Variant[Stdlib::Fqdn,Stdlib::IP::Address] $safebrowsing_block_host,
  Integer $ratelimit,
  Optional[Tuple[Stdlib::IP::Address,1,default]] $ratelimit_whitelist,
  Boolean $refuse_any,
  Tuple[Variant[Stdlib::IP::Address,Stdlib::HTTPUrl,Adguard::Ipv4_port],1,4] $upstream_dns,
  Optional[Stdlib::Unixpath] $upstream_dns_file,
  Tuple[Stdlib::IP::Address,1,default] $bootstrap_dns,
  Boolean $all_servers,
  Boolean $fastest_addr,
  Optional[Tuple[Stdlib::IP::Address,1,default]] $allowed_clients,
  Optional[Tuple[Stdlib::IP::Address,1,default]] $disallowed_clients,
  Array $blocked_hosts,
  Integer $dns_cache_size,
  Integer[default,3600] $dns_cache_ttl_min,
  Integer[default,3600] $dns_cache_ttl_max,
  Optional[Tuple[Stdlib::Fqdn,Stdlib::IP::Address::V4::Nosubnet,1,default]] $bogus_nxdomain,
  Boolean $aaaa_disabled,
  Boolean $enable_dnssec,
  Boolean $edns_client_subnet,
  Integer $max_goroutines,
  Boolean $filtering_enabled,
  Integer $filters_update_interval,
  Boolean $parental_enabled,
  Boolean $safesearch_enabled,
  Boolean $safebrowsing_enabled,
  Integer $safebrowsing_cache_size,
  Integer $safesearch_cache_size,
  Integer $parental_cache_size,
  Integer $cache_time,
  Optional[Adguard::Rewrites] $rewrites,
  Optional[Tuple[Adguard::Blocked_service,1,default]] $blocked_services,
  Tuple[Struct[
    name => String,
    enabled => Boolean,
    url => Stdlib::HTTPUrl,
  ],1,default] $filters,
  Optional[Tuple[Struct[
    name => String,
    enabled => Boolean,
    url => Stdlib::HTTPUrl,
  ],1,default]] $whitelist_filters,
  Optional[Array] $user_rules,
  Optional[Tuple[Struct[
    name => String,
    tags => Optional[Array],
    ids => Array,
    use_global_settings => Boolean,
    filtering_enabled => Optional[Boolean],
    parental_enabled  => Optional[Boolean],
    safesearch_enabled => Optional[Boolean],
    use_global_blocked_services => Boolean,
    blocked_services => Optional[Array],
    upstreams => Optional[Array]
  ],1,default]] $clients,
  Boolean $log_compress,
  Boolean $log_localtime,
  Integer $log_max_backups,
  Integer $log_max_size,
  Integer $log_max_age,
  Boolean $verbose_logging,
  Variant[Stdlib::Unixpath,Enum['syslog'],Undef] $log_file,
  Stdlib::Unixpath $adguard_path,
  Boolean $manage_config,
  Pattern[/(.*\/)(.*)(AdGuardHome.yaml$)/] $configuration_file,
  String $service_name,
  String $version,
)
{
  if ($blocking_mode == 'custom_ip')
  {
    if (!$blocking_ipv4 or !$blocking_ipv6)
    {
      fail('blocking_ipv4 and/or blocking_ipv6 must be declared when blocking_mode is set to custom_ip')
    }
  }
  if ($clients)
  {
    # Sanity check the client data
    $clients.each | $client | {
      # When using global settings we can't specify individual settings
      if ($client['use_global_settings'] == true)
      {
        if ($client['filtering_enabled'] or $client['parental_enabled'] or $client['safesearch_enabled'] or $client['safebrowsing_enabled'])
        {
          fail('cannot set individual client settings when use_global_settings is true')
        }
      }
      if ($client['use_global_blocked_services'] == true)
      {
        if ($client['blocked_services'])
        {
          fail ('cannot declare blocked_services when use_global_blocked_services is true')
        }
      }
    }
  }
  # Puppet has excellent facts, make use of them
  case $::architecture
  {
    /(amd64|x64)/:
    {
      $cpu_arch = 'amd64'
    }
    /(i386|i486|i686|i786|x86)/:
    {
      $cpu_arch = '386'
    }
    default:
    {
      fail('unsupported cpu architecture')
    }
  }
  # Annoyingly the AdGuard archives container a folder instead of being directly in the root :(
  # Get the parent path unless we're already installing to the root of somewhere
  if ($adguard_path =~ /(.*\/)(.*)AdGuardHome$/)
  {
    $extract_path = $1
  }
  else
  {
    $extract_path = $adguard_path
  }
  $extension = '.tar.gz' # right now we only support tar.gz, but if we add support for Windows we'll need to support .zip as well
  $kernel = downcase($::kernel)
  # Ensure the path exists with the relevant permissions
  file { $adguard_path:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }
  # Copy the configuration file
  file { $configuration_file:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644', # Stop fighting with AdGuard
    replace => $manage_config,
    backup  => '.puppet',
    content => template('adguard/AdGuardHome.yaml.erb'),
    require => File[$adguard_path],
    notify  => Service[$service_name],
  }
  # Download the release from GitHub and extract it
  githubreleases_download { "${adguard_path}/adguard${extension}":
    author            => 'AdguardTeam',
    repository        => 'AdGuardHome',
    asset             => true,
    asset_filepattern => "^AdGuardHome_${kernel}_${cpu_arch}${extension}",
    release           => $version,
    require           => File[$adguard_path],
  }
  archive { "${adguard_path}/adguard${extension}":
    extract      => true,
    extract_path => $extract_path,
    creates      => "${adguard_path}/AdGuardHome",
    require      => Githubreleases_download["${adguard_path}/adguard${extension}"],
  }
  exec { 'install_adguard':
    command => "${adguard_path}/AdGuardHome -s install -c ${configuration_file}",
    creates => '/etc/systemd/system/AdGuardHome.service',
    require => Archive["${adguard_path}/adguard${extension}"],
  }
  service { $service_name:
    ensure    => 'running',
    subscribe =>  File[$configuration_file],
    require   => Exec['install_adguard']
  }
  # If we're on a systemd and we're using port 53 we'll get an issue in starting up due to resolved, so we'll need to sort that out
  if (($::systemd == true or $::os['family'] =~ /[dD]ebian/) and $dns_port == 53)
  {
    notice('disabling resolved DNSStubListener')
    ini_setting {'adguard_disable_DNSStubListener':
      ensure            => present,
      path              => '/etc/systemd/resolved.conf',
      setting           => 'DNSStubListener',
      key_val_separator => '=',
      value             => 'no',
      section           => 'Resolve',
      section_prefix    => '[',
      section_suffix    => ']',
      notify            => Service['systemd_resolved_adguard'],
      # Ordering is important here - essentially we want to ensure we've downloaded the AdGuard package before we kill name resolution
      # but we need to make the change before starting the AdGuard service.
      before            => Service[$service_name],
      require           => Githubreleases_download["${adguard_path}/adguard${extension}"],
    }
    service {'systemd_resolved_adguard':
      ensure    => 'running',
      name      => 'systemd-resolved',
      subscribe => Ini_setting['adguard_disable_DNSStubListener']
    }
  }
}
