# @summary Manages an Adguard Home installation
# 
# @example Basic usage
#   class {'adguard':
#     users => [{
#       username => 'user',
#       password => '$2a$10$DBX2KdCRP6JKS8TqvkVWTOjUgUQLtlWGkxkZAuiUZGTURhorjlX6K'
#     }],
#   }
# 
# @param webui_interface
#   The interface to bind the WebUI to.
# @param webui_port
#   The port to bind the WebUI to.
# @param users
#   The users to add to allow access to the WebUI.
#   Note: the password needs to be in BCrypt-encrypted format.
# @param http_proxy
#   Define an optional http_proxy.
#   While adguard supports SOCKS5 alongside HTTP/S, this is **not** supported in the Puppet module at this time.
# @param rlimit_nofile
#   Limit on the maximum number of open files for server process (Linux).
# @param debug_pprof
#   Enable pprof HTTP server listening on port 6060 for debugging. 
# @param web_session_ttl
#   Web session TTL (in hours) a web user will stay signed in for this amount of time.
# @param dns_interface
#   The interface to bind to for DNS.
# @param dns_port
#   The port to bind dns to
# @param statistics_interval
#   Time interval for statistics (in days).
# @param querylog_enabled
#   Query logging (also used to calculate top 50 clients, blocked domains and requested domains for statistical purposes).
# @param querylog_file_enabled
#   Write query logs to a file. 
# @param querylog_interval
#   Time interval for query log (in days).
# @param querylog_size_memory
#   Number of entries kept in memory before they are flushed to disk. 
# @param anonymize_client_ip
#   If true, anonymize clients' IP addresses in logs and stats.
# @param protection_enabled
#   Whether any kind of filtering and protection should be done, when off it works as a plain dns forwarder. 
# @param blocking_mode
#   Specifies how to block DNS requests. 
#   Valid options:
#     - default (respond with NXDOMAIN status) 
#     - null_ip (respond with the unspecified IP address (0.0.0.0))
#     - custom_ip (respond with blocking_ipv4 or blocking_ipv6 address)
# @param blocking_ipv4
#   IP address to be returned for a blocked A request if blocking_mode is set to custom_ip. 
# @param blocking_ipv6
#   IP address to be returned for a blocked AAAA request if blocking_mode is set to custom_ip. 
# @param blocked_response_ttl
#   For how many seconds the clients should cache a filtered response. Low values are useful on LAN if you change filters very often,
#   high values are useful to increase performance and save traffic. 
# @param parental_block_host
#   IP (or domain name) which is used to respond to DNS requests blocked by parental control. 
# @param safebrowsing_block_host
#   IP (or domain name) which is used to respond to DNS requests blocked by safe-browsing. 
# @param ratelimit
#   DDoS protection, specifies in how many packets per second a client should receive. 
#   Anything above that is silently dropped. 
#   To disable set 0, default is 20. Safe to disable if DNS server is not available from internet.
# @param ratelimit_whitelist
#   An array of ip addresses to whitelist from ratelimiting.
# @param refuse_any
#   Another DDoS protection mechanism. 
#   Requests of type ANY are rarely needed, so refusing to serve them mitigates against attackers trying to use your DNS as a reflection. 
#   Safe to disable if DNS server is not available from internet. 
# @param upstream_dns
#   An array of upstream DNS servers. Can be a URL or IP.
# @param upstream_dns_file
#   Path to a file with the list of upstream DNS servers. If it is configured, the value of upstream_dns is ignored. Defaults to undef
# @param bootstrap_dns
#   List of DNS servers used for initial hostname resolution in case an upstream server name is a hostname.
# @param all_servers
#   Enables parallel queries to all configured upstream servers to speed up resolving. 
#   If disabled, the queries are sent to each upstream server one-by-one and then sorted by RTT. 
# @param fastest_addr
#   Use Fastest Address algorithm. It finds an IP address with the lowest latency and returns this IP address in DNS response. 
# @param allowed_clients
#   IP addresses of allowed clients.
# @param disallowed_clients
#   IP addresses of disallowed clients.
# @param blocked_hosts
#   An array of hosts to block.
# @param dns_cache_size
#   DNS cache size (in bytes). 
# @param dns_cache_ttl_min
#   Override TTL value (minimum) received from upstream server. This value can't larger than 3600 (1 hour).
# @param dns_cache_ttl_max
#   Override TTL value (maximum) received from upstream server. 
# @param bogus_nxdomain
#    Transform responses with these IP addresses to NXDOMAIN
# @param aaaa_disabled
#   Respond with an empty answer to all AAAA requests
# @param enable_dnssec
#   Set DNSSEC flag in the outgoing DNS requests and check the result.
#   Note if running an additional DNS server (such as Unbound or BIND) that uses DNSSEC you do not want DNSSEC on both
#   as you will get erroes with legitimate DNS requests.
# @param edns_client_subnet
#   Enable EDNS Client Subnet option. If enabled, AdGuard Home will be sending ECS extension to the upstream DNS servers. 
#   Please note, that this will be done for clients with public IP addresses only.
# @param max_goroutines
#   Max. number of parallel goroutines for processing incoming requests
# @param filtering_enabled
#   Filtering of DNS requests based on filter lists. 
# @param filters_update_interval
#   How often the filters update (in hours). 
# @param parental_enabled
#   Parental control-based DNS requests filtering
# @param safesearch_enabled
#   Enforcing "Safe search" option for search engines, when possible.
# @param safebrowsing_enabled
#   Filtering of DNS requests based on safebrowsing
# @param safebrowsing_cache_size
#   Safe Browsing cache size (in bytes).
# @param safesearch_cache_size
#   Safe Search cache size (in bytes).
# @param parental_cache_size
#   Parental Control cache size (in bytes). 
# @param cache_time
#   Safe Browsing, Safe Search, Parental Control cache TTL. 
# @param rewrites
#   An array of custom rewrite rules
#   Format:
#      - domain: the domain to perform the rewrite on
#      - answer: the ip address to point to
# @param blocked_services
#   An array of any services you wish to block.
# @param filters
#   An array of block filters to add. Will default to the standard list provided by AdGuard
#   Format:
#     - name: the name for the filter (eg AdGuard Default)
#     - enabled: true/false
#     - url: the URL to point to
# @param whitelist_filters
#   An array of whitelist filters to add.
#   Format:
#     - name: the name for the filter (eg AdGuard Default)
#     - enabled: true/false
#     - url: the URL to point to
# @param user_rules
#   Any custom rules you'd like to define, optional.
# @param clients
#   EXPERIMENTAL: Individual client settings
#   Not extensively tested, please report any issues on the project repo.
# @param log_compress
#   Whether or not to compress the logs. 
# @param log_localtime
#   Whether to format timestamps using computer's local time.
# @param log_max_backups
#   Maximum number of old log files to retain (MaxAge may still cause them to get deleted) (default: 0, which retains all old log files)
# @param log_max_size
#   Maximum size in megabytes of the log file before it gets rotated. 
# @param log_max_age
#   MaxAge is the maximum number of days to retain old log files. 
# @param log_file
#   Path to the log file. If empty, writes to stdout, if syslog -- system log (or eventlog on Windows).
#   Valid options are: 
#     - unixpath
#     - undef 
#     - syslog
# @param verbose_logging
#   Enable or disable verbose logging. Defaults to false
# @param adguard_path
#   The path to where you'd like AdGuard installed, defaults to /opt/AdGuardHome
# @param manage_config
#   Whether or not to manage the AdGuardHome.yaml file
# @param configuration_file
#   The path to where you want to store the configuration file, must be the full path to AdGuardHome.yaml. 
# @param service_name
#   The name of the service to manage, defaults to AdGuardHome
# @param version
#   The version to install from the GitHub release
class adguard
(
  Array[Adguard::User] $users,
  Stdlib::IP::Address::V4::Nosubnet $webui_interface = '0.0.0.0',
  Stdlib::Port $webui_port = 80,
  Optional[Stdlib::HTTPUrl] $http_proxy = undef,
  Integer $rlimit_nofile = 0,
  Boolean $debug_pprof = false,
  Integer $web_session_ttl = 8,
  Stdlib::IP::Address::V4::Nosubnet $dns_interface = '0.0.0.0',
  Stdlib::Port $dns_port = 53,
  Integer $statistics_interval = 1,
  Boolean $querylog_enabled = true,
  Boolean $querylog_file_enabled = true,
  Integer $querylog_interval = 90,
  Integer $querylog_size_memory = 1000,
  Boolean $anonymize_client_ip = false,
  Boolean $protection_enabled = true,
  Enum['default','null_ip','custom_ip'] $blocking_mode = 'default',
  Optional[Stdlib::IP::Address::V4::Nosubnet] $blocking_ipv4 = undef,
  Optional[Stdlib::IP::Address::V6] $blocking_ipv6 = undef,
  Integer $blocked_response_ttl = 10,
  Variant[Stdlib::Fqdn,Stdlib::IP::Address] $parental_block_host = 'family-block.dns.adguard.com',
  Variant[Stdlib::Fqdn,Stdlib::IP::Address] $safebrowsing_block_host = 'standard-block.dns.adguard.com',
  Integer $ratelimit = 20,
  Optional[Array[Stdlib::IP::Address]] $ratelimit_whitelist = undef,
  Boolean $refuse_any = true,
  Array[Adguard::Dns_server] $upstream_dns = ['https://dns10.quad9.net/dns-query'],
  Optional[Stdlib::Unixpath] $upstream_dns_file = undef,
  Array[Stdlib::IP::Address] $bootstrap_dns = [
    '9.9.9.10',
    '149.112.112.10',
    '2620:fe::10',
    '2620:fe::fe:10'
  ],
  Boolean $all_servers = false,
  Boolean $fastest_addr = false,
  Optional[Array[Stdlib::IP::Address]] $allowed_clients = undef,
  Optional[Array[Stdlib::IP::Address]] $disallowed_clients = undef,
  Array $blocked_hosts = [
    'version.bind',
    'id.server',
    'hostname.bind'
  ],
  Integer $dns_cache_size = 4194304,
  Integer[default,3600] $dns_cache_ttl_min = 0,
  Integer[default,3600] $dns_cache_ttl_max = 0,
  Optional[Array[Adguard::Dns_server]] $bogus_nxdomain = undef,
  Boolean $aaaa_disabled = false,
  Boolean $enable_dnssec = false,
  Boolean $edns_client_subnet = false,
  Integer $max_goroutines = 300,
  Boolean $filtering_enabled = true,
  Integer $filters_update_interval = 24,
  Boolean $parental_enabled = false,
  Boolean $safesearch_enabled = false,
  Boolean $safebrowsing_enabled = false,
  Integer $safebrowsing_cache_size = 1048576,
  Integer $safesearch_cache_size = 1048576,
  Integer $parental_cache_size = 1048576,
  Integer $cache_time = 30,
  Optional[Array[Adguard::Rewrite]] $rewrites = undef,
  Optional[Array[Adguard::Blocked_service]] $blocked_services = undef,
  Array[Adguard::Filter] $filters = $adguard::params::filters,
  Optional[Array[Adguard::Filter]] $whitelist_filters = undef,
  Optional[Array] $user_rules = undef,
  Optional[Array[Adguard::Client]] $clients = undef,
  Boolean $log_compress = false,
  Boolean $log_localtime = false,
  Integer $log_max_backups = 0,
  Integer $log_max_size = 100,
  Integer $log_max_age = 3,
  Boolean $verbose_logging = false,
  Adguard::Log_file $log_file = undef,
  Stdlib::Unixpath $adguard_path = '/opt/AdGuardHome',
  Boolean $manage_config = true,
  Adguard::Config_file $configuration_file = "${adguard_path}/AdGuardHome.yaml",
  String $service_name = 'AdGuardHome',
  String $version = 'latest',
)
inherits adguard::params
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
