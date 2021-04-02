# @summary
#   Stuctured hash for managing rewrites
#
type Adguard::Rewrite = Struct[{
    domain => String,
    answer => String,
}]
