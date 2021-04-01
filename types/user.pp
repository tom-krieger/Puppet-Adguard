# @summary
#   A structed hash for providing users for the adguard web UI.
#
# @param username
#   The username used to login
# @param password
#   The password in BCrypt-encrypted format
type Adguard::User = Struct[
    username => String,
    password => String
]
