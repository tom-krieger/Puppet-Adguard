# Changelog

All notable changes to this project will be documented in this file.

## Release 

### [v0.1.1](https://github.com/shoddyguard/Puppet-Adguard/tree/v0.1.1) (2020-04-01)

**Features**
- Moved several complex types into their own definitions rather than defining them in the parameters of the main class.
- Moved default parameter declarations from hiera into the manifests. This allows Puppet-Strings to extract default values into documentaion and makes things easier to locate.
- Tidied up documentation and added some more examples
- Expanded acceptance testing slightly
- Adds support for DHCP on IPV4 and IPV6, IPV6 remains untested
- Adds experimental support for TLS/SSL
- Adds basic ipset support
  
**Bugfixes**
Partially fixed #10 whereby you could not specify port numbers when using IP addresses (eg `127.0.0.1:5353` would fail).  
This is marked as partially fixed as it works for IPV4 addresses but not IPV6 addresses at present.  
Will require more familiarity with IPV6 before that can be implemented.

**Known Issues**

### [v0.1.0](https://github.com/shoddyguard/Puppet-Adguard/tree/v0.1.0) (2020-03-21)

**Features**
Initial release

**Bugfixes**

**Known Issues**
DHCP, IPSET and TLS/SSL not yet implemented