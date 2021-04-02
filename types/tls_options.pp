# @summary
#   Configures TLS options in AdGuard Home
type Adguard::Tls_options = Struct[{
  server_name           => Stdlib::Host,
  force_https           => Boolean,
  port_https            => Stdlib::Port,
  port_dns_over_tls     => Stdlib::Port,
  port_dns_over_quic    => Stdlib::Port,
  port_dnscrypt         => Stdlib::Port,
  dnscrypt_config_file  => Optional[Stdlib::Unixpath],
  allow_unencrypted_doh => Boolean,
  strict_sni_check      => Boolean,
  certificate_chain     => Optional[String],
  private_key           => Optional[String],
  certificate_path      => Optional[Stdlib::Unixpath],
  private_key_path      => Optional[Stdlib::Unixpath]
}]
