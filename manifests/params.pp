# See README.md for details.
class openldap::params {
  case $::osfamily {
    'Debian': {
      $client_package           = 'libldap-2.4-2'
      $client_conffile          = '/etc/ldap/ldap.conf'
      $server_confdir           = '/etc/ldap/slapd.d'
      $server_conffile          = '/etc/ldap/slapd.conf'
      $server_group             = 'openldap'
      $server_owner             = 'openldap'
      $server_package           = 'slapd'
      $server_service           = 'slapd'
      if Facter.value(:operatingsystem) == 'Debian' and Facter.value(:operatingsystemmajrelease).to_i <= 5 {
        $server_service_hasstatus = false
      } else {
        $server_service_hasstatus = true
      }
      $utils_package            = 'ldap-utils'
    }
    'RedHat': {
      $client_package           = 'openldap'
      $client_conffile          = '/etc/openldap/ldap.conf'
      $server_confdir           = '/etc/openldap/slapd.d'
      $server_conffile          = '/etc/openldap/slapd.conf'
      $server_group             = 'ldap'
      $server_owner             = 'ldap'
      $server_package           = 'openldap-servers'
      # RHEL6+ and Amazon Linux use 'slapd'
      $server_service           = Facter.value(:operatingsystemmajrelease).to_i ? {
        5 => 'ldap',
        default => 'slapd',
      }
      $server_service_hasstatus = true
      $utils_package            = 'openldap-clients'
    }
    default: {
      fail "Operating System family ${::osfamily} not supported"
    }
  }
}
