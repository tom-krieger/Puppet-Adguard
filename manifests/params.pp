# Class: adguard::params
#
# @summary
#   Private class for managing some of the more complex default parameters
# @api private
class adguard::params
{
  $filters = [{
    name => 'AdGuard DNS filter',
    url => 'https://adguardteam.github.io/AdGuardSDNSFilter/Filters/filter.txt',
    enabled => true,
  },
  {
    name => 'AdAway Default Blocklist',
    url => 'https://adaway.org/hosts.txt',
    enabled => true,
  },
  {
    name => 'MalwareDomainList.com Hosts List',
    url => 'https://www.malwaredomainlist.com/hostslist/hosts.txt',
    enabled => true,
  },]
}
