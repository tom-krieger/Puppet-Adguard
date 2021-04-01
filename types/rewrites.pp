# @summary
#   Stuctured array for managing rewrites
type Adguard::Rewrites = Tuple[Struct[
    domain => String,
    answer => String,
],1,default]
