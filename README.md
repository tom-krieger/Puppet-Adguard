[![validate-puppet-module Actions Status](https://github.com/shoddyguard/Puppet-Adguard/workflows/validate-puppet-module/badge.svg?branch=main)](https://github.com/shoddyguard/Puppet-Adguard/actions)[![publish-puppet-module Actions Status](https://github.com/shoddyguard/Puppet-Adguard/workflows/publish-puppet-module/badge.svg)](https://github.com/shoddyguard/Puppet-Adguard/actions)
# Puppet-Adguard
Puppet module for installing and managing AdGuard Home

# Module description
This module will install and configure AdGuard Home on a node, it largely uses the defaults provided by AdGuard Home in a typical installation.  
Management is largely performed by manipulating the `AdGuardHome.yaml` file.  
There are some features that are not yet working in this module, see the [Known Limitations](#know-limitations) sections for more information. 

This module has been tested on the following platforms:
- Ubuntu 20.04

# Setup
The below demonstrates a minimum configuration:  
```puppet
class {'adguard':
    users => [{
        username => 'user',
        password => '$2y$10$c6lDDShTh5ezcvKhyWwOMet6C/0tLxlgYX53wf58jl9tBdUVbYSqe',
    }]
}
```
This will download AdGuardHome and install it with default parameters and provide access to the user `user` with a password of `password`.  

# Usage

## Configuring listeners
By default the WebUI is configured to listen on port `80` and DNS on port `53`, they are also both bound to listen on all interfaces (`0.0.0.0`)
You may wish to change this to suit your needs:
```puppet
class {'adguard':
    users => [{
        username => 'user',
        password => '$2y$10$c6lDDShTh5ezcvKhyWwOMet6C/0tLxlgYX53wf58jl9tBdUVbYSqe',
    }],
    webui_interface => '192.168.33.33',
    webui_port => 3000,
    dns_interface => '127.0.0.1',
    dns_port => 5353,
}
```
This would configure the webui to be available on port `3000` on interface `192.168.33.33`, meaning to get to the WebUI you would need to visit `http://192.168.33.33:3000`.
It would also configure the DNS server to listen on port `5353` on localhost only, meaning you would only be able to query DNS locally on this node and would need to specify port `5353` (eg `127.0.0.1#5353`)

## Managing filters
By default this module configures the standard AdGuard filter entries:
- `https://adguardteam.github.io/AdGuardSDNSFilter/Filters/filter.txt`
- `https://adaway.org/hosts.txt`
- `https://www.malwaredomainlist.com/hostslist/hosts.txt`

However you may wish to set your own:
```puppet
class {'adguard':
    users => [{
        username => 'user',
        password => '$2y$10$c6lDDShTh5ezcvKhyWwOMet6C/0tLxlgYX53wf58jl9tBdUVbYSqe',
    }],
    filters => 
    [
      {
        name => 'My Custom List',
        url => 'https://example.com/hosts.txt',
        enable => true,
      },
      {
        name => 'Another Custom List',
        url => 'https://foo.com/list.txt',
        enable => true,
      }
    ]
}
```
A hiera example:
```yaml
adguard::filters:
  - name: 'My Custom List'
    url: 'https://example.com/hosts.txt'
    enable: true
  - name: 'Another Custom List'
    url: https://foo.com/list.txt'
    enable: true
```
**Note**: *defining your own lists will replace all the default entries, if you wish to keep them make sure to specify them in your configuration.*

## Setting upstream DNS
By default the module configures the following upstream DNS server:
- `https://dns10.quad9.net/dns-query`

You may wish to change this to your liking:
```puppet
class {'adguard':
    users => [{
        username => 'user',
        password => '$2y$10$c6lDDShTh5ezcvKhyWwOMet6C/0tLxlgYX53wf58jl9tBdUVbYSqe',
    }],
    upstream_dns => ['9.9.9.9','8.8.8.8']
```
or via hiera:
```yaml
adguard::upstream_dns:
  - '9.9.9.9'
  - '8.8.8.8'
```
*Note*: when specifying HTTP(S) servers AdGuard may need to call out to a bootstrap server to be able to resolve the IP address for the upstream server.  
By default the following bootstrap servers are configured:
- '9.9.9.10'
- '149.112.112.10'
- '2620:fe::10'
- '2620:fe::fe:10'
These can be changed by changing the `bootstrap_dns` parameter.

## Disabling configuration file management
Due to the fact this module manages configuration of AdGuard by manipulating the `AdGuardHome.yaml` file there may be instances where Puppet fights against AdGuard Home with both trying to change the contents of the file. 

This is only likely to happen when AdGuard have made changes to the way in which the configuration file is constructed (for example a new parameter has been added, or an existing one modified during an update). 

To get around this you can disable management of the `AdGuardHome.yaml` file:
```puppet
class {'adguard':
    manage_config => false,
}
```
This will stop Puppet from modifing the configuration file and allow AdGuard to manage the file.

You may also wish to disable configuration file managment if you prefer to use to the WebUI to configure AdGuard, or you wish to use one of the [unsupported features](#unsupported-features).  

**Note**: *Puppet will create the configuration file if it is missing with the values you have specified in your manifests and/or hiera.*  

If your configuration file has been overwritten Puppet will back it up before overwritting it, it will be stored in the same directory as the configuration file with a `.puppet` extension.  

# Know Limitations
## Unsupported features
Currently this module does not support:
- DHCP
- ipset
- TLS/SSL settings