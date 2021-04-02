# This tests basic TLS configuration.
# Only basic configuration is checked as unsure how to test more extensively in a container.
require 'spec_helper_acceptance'

# Copy over a dummy SSL cert + key (generated by OpenSSL) to use for testing SSL, 
# this expires on 2022/04/02, unsure if this will cause errors in the future.
# This also only tests the "path" options for TLS and not specifying the certs directly, we should implement this later.
pp_tls = <<-MANIFEST
    $ca_cert = @("CA_CERT"/L)
-----BEGIN CERTIFICATE-----
MIIFcjCCA1oCCQDRZO9ndAf3hTANBgkqhkiG9w0BAQsFADB7MQswCQYDVQQGEwJH
QjEXMBUGA1UECAwOQ2FtYnJpZGdlc2hpcmUxEjAQBgNVBAcMCUNhbWJyaWRnZTEZ
MBcGA1UEAwwQYWRndWFyZC10ZXN0LmNvbTEkMCIGCSqGSIb3DQEJARYVZmFrZUBh
ZGd1YXJkLXRlc3QuY29tMB4XDTIxMDQwMjE0MDgxNloXDTIyMDQwMjE0MDgxNlow
ezELMAkGA1UEBhMCR0IxFzAVBgNVBAgMDkNhbWJyaWRnZXNoaXJlMRIwEAYDVQQH
DAlDYW1icmlkZ2UxGTAXBgNVBAMMEGFkZ3VhcmQtdGVzdC5jb20xJDAiBgkqhkiG
9w0BCQEWFWZha2VAYWRndWFyZC10ZXN0LmNvbTCCAiIwDQYJKoZIhvcNAQEBBQAD
ggIPADCCAgoCggIBAMF5g9a1A10WQmto3rtYCBAR1Q+C9YVdnrzLN5EUp5FB6skp
sDHDSYMYpJyTbGR9JXfYmC/bh54OTyrX8gdE35jxBi7QL61+MdAmy62oG61yXXNe
GRuYpdZVw+tY41NYeE0pII7D7WBEB3LFuiAfucDy5bGuxEv/v5uwwm1YRGkWWCPq
st/x5J+ln0OxkJW3J+bGYe/IomEwMaJk7qdnT7O1M8Ofnt1lGUaxEzxyoukUqvS3
QTEVOn4NQKePnJARXTOmpzQPAYMt/VbhkUdGG7ehgqRRwh0eLF2Sc6/L88OCOMR8
9Mbm/Z95H0kMG8nobbULRYg+ve7KHvuKWTjgPrT5ilsjj1/8TVf4ksXq84Sho70m
Om3bqaCUxwfF67D6EsKRKGr/0xd4NLt53SA+ifrHkymi4yyD7/F3YKvttff48QF+
Z9wB+JsrDRjO8DB2u4j2FUw+pDiSm79BigerqxucbeQZ6KhBN5H4gb/54ERvNJmn
OCInkVCwfDuWZdzOJ6gL90ah7Bir4vCUzBz3h8K078Pe4sKsiNUkacimcI8lcTjX
r3as/BpvyG1qlrciE9qgiXxJo+T9IHgg6dRxuo/8Kq59cjS71S/FQykuKUurAws9
AmUHtmWmAZe31t64Q4Yo697lsLbqrbo6y25faVMB82nHBKHNSP78HybSWPblAgMB
AAEwDQYJKoZIhvcNAQELBQADggIBAEOOgHw4bbsOgUri0YpHs1X2xPrT+6Epqxkb
vgunhqjmllYfcl/oEPQOHKpxvP+fG66vsgNu1jc002m9mofH4egkvYr+TTr+jK3m
WzWhr+61403VO/jOPhwdgwJXrrwGyeK10eOBmmeIfqv+/MhSpM21vL+YXqDZbkqg
BDegVbBDfMvYSHhU9mNJIU4B87B2EN6iWYiIxI7NGvcC3Ve/jiWoTAnCvd2zfLkx
695xP/1XBJWTkNGQnbBHwZclr75JXx8KOOl57Jww9N8D7l1tLlmRCLvooHIeSPNd
jf4xPPY8sSbeTjfhdD7JFOPd5PVXPhTAnESmhCsHmU4jPVgwn9JPop9tB4vWec53
0XlDOv/A1CI2S+0eXRmAqruW6UbZhmH3W+qtWuGR0jwRe0n8fFe2MtHfv7kpvfUv
+Xe8KHYn3F37SmMHcW4tkdcfJm44iTkN07q5XcBXR1NoQ9to1Cgy7CGJXyCXU/x/
BbV1L4XhsdmPTl5HMNlJqwIy0mDRiUAXwnJQC/8PiEBXFgkq5iZDWb115gDwvEdr
nP6MqfyoIdRND+5QtTQ8m501SQvhjo83DzzyyOWKgFcSo9BXJBUdwCaYXBi7rl2b
aBaI/zSx8ccuD0nFfzS/gdArre1YtVEIAz+Q9ykz9MeJuTR92GunyVhRWsXN0K9H
gZQYfmbK
-----END CERTIFICATE----- 
CA_CERT
    $keyfile = @("KEYFILE"/L)
-----BEGIN ENCRYPTED PRIVATE KEY-----
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
+em/FgbfSx2NOAfdaIJMUrMOCg==
-----END ENCRYPTED PRIVATE KEY-----
KEYFILE
    file {'/root/cert.pem':
        ensure => present,
        content => $ca_cert
    }
    file {'/root/key.pem':
        ensure => present,
        content => $keyfile
    }
    class {'adguard':
        users => [
          {
              username => 'user',
              password => '$2y$10$c6lDDShTh5ezcvKhyWwOMet6C/0tLxlgYX53wf58jl9tBdUVbYSqe',
          }],
        enable_tls => true,
        tls_options => {
            server_name => 'adguard-test.com',
            force_https => false,
            port_https => 443,
            port_dns_over_tls => 853,
            port_dns_over_quic => 784,
            port_dnscrypt => 0,
            allow_unencrypted_doh => false,
            strict_sni_check => false,
            certificate_path => '/root/cert.pem',
            private_key_path => '/root/key.pem',
        }
    }
MANIFEST

idempotent_apply(pp_tls)

describe 'adguard_tls' do
    context service('AdGuardHome') do
        it { is_expected.to be_enabled }
        it { is_expected.to be_running }
    end
    # Ensure our ports are listening
    context port(80) do
        it { is_expected.to be_listening }
    end
    context port(53) do
        it { is_expected.to be_listening }
    end
    context file('/opt/AdGuardHome/AdGuardHome.yaml') do
        it { is_expected.to be_file }
        its(:content) { is_expected.to match(%r{server_name: adguard-test.com}) }
      end
end