# @summary 
#   This function ensures that the TLS config is valid before applying it.
#
# @param tls_options
#   Accepts a hash of tls_options
#
# @return [Boolean] Returns true if the configuration is valid
function adguard::validate_tls_options(Adguard::Tls_options $tls_options) >> Boolean {
  # If dnscrypt is enabled (any port other than 0) there must be a path to a config file
  if ($tls_options['port_dnscrypt'] != 0 and !$tls_options['dnscrypt_config_file'])
  {
    fail('dnscrypt_config_file must be set when port_dnscrypt is set to a non zero value')
  }
  # Perform sanity checks on the certificate values as there are a few combinationss that won't work.
  if ($tls_options['certificate_chain'] or $tls_options['private_key'])
  {
    # AdGuard Home only supports using either hardcoded certs or a path on disk, not both at the same time.
    if ($tls_options['certificate_path'] or $tls_options['private_key_path'])
    {
      fail('cannot use certificate_chain/private_key with certificate_path/private_key_path')
    }
    # Seeing as we've confirmed certificate_chain and/or private_key are in use we need to ensure both values are present
    if (!$tls_options['certificate_chain'] or !$tls_options['private_key'])
    {
      fail('both certificate_chain and private_key must be set together')
    }
  }
  else
  {
    # We've confirmed that neither certificate_chain or private_key is set so validate we have paths to the certs
    if (!$tls_options['certificate_path'] or !$tls_options['private_key_path'])
    {
      fail('certificate_path and private_key_path required when not providing certificate_chain/private_key')
    }
  }
  # And if we've gotten here then return true
  Boolean('true')
}
