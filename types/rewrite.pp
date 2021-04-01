# @summary
#   Stuctured hash for managing rewrites
#
# @param domain
#   The domain to create the rewrite rule for
# @param answer
#   The answer to return
type Adguard::Rewrite = Struct[
    domain => String,
    answer => String,
]
