# @summary
#   Simple regex check for the AdGuard config file
type Adguard::Config_file = Pattern[/(.*\/)(.*)(AdGuardHome.yaml$)/]
