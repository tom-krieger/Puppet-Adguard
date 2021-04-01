# @summary
#   Used to manage filters in Adguard
#
# @example
#   {
#       name => 'My Filter',
#       enabled => true,
#       url => 'http://filters.com/myfilter.txt',
#   }
#
# @param name
#   The name of the filter.
# @param enabled
#   Whether to enabled or disable the filter.
# @param url
#   The url to the filter.
type Adguard::Filter = Struct[
    name => String,
    enabled => Boolean,
    url => Stdlib::HTTPUrl,
]
