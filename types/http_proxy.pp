# @summary
#   Very basic validation to ensure we have a supported proxy type
type Adguard::Http_proxy = Pattern[/^(http|https|socks5)\:\/\//]
