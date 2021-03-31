# @summary
#   An array of usernames/passwords
type Adguard::Users = Tuple[Struct[
    username => String,
    password => String
  ],1,default]
