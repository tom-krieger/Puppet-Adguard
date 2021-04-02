# @summary
#   Used to manage filters in Adguard
#
type Adguard::Filter = Struct[{
    name    => String,
    enabled => Boolean,
    url     => Stdlib::HTTPUrl,
}]
