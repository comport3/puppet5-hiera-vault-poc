node default {
  include profile::vault
#  file { '/root/demo':
#    ensure  => file,
#    content => inline_epp(password=lookup('vault_notify')),
##   content => inline_epp($ntp_conf_template, {'service_name' => 'xntpd', 'iburst_enable' => true}),
## notify { "vault parameter: ${lookup({"name" => "vault_notify", "default_value" => "Failed to lookup value."})}":}
#  }
}
