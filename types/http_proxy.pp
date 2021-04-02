# @summary
#   Very basic validation to ensure the proxy type is sensible
type Adguard::Http_proxy = Pattern[/^(http|https|socks5)\:\/\//]
