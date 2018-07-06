class profile::vault {
  exec { '/opt/puppetlabs/puppet/bin/gem install vault':
    command => '/opt/puppetlabs/puppet/bin/gem install vault',
    creates => '/opt/puppetlabs/puppet/lib/ruby/gems/2.4.0/gems/vault-0.11.0',
  }
  exec { '/opt/puppetlabs/puppet/bin/gem install debouncer':
    command => '/opt/puppetlabs/puppet/bin/gem install debouncer',
    creates => '/opt/puppetlabs/puppet/lib/ruby/gems/2.4.0/gems/debouncer-0.2.2',
  }
  file { '/mnt/vault/':
    ensure => directory,
    owner  => 'vault',
    group  => 'vault',
  }
  class { '::vault':
    manage_storage_dir => true,
    storage => {
      file => {
        path => '/mnt/vault/data',
      },
    },
    listener => {
      tcp => {
	address       => '0.0.0.0:8200',
        tls_disable   => 1,
      },
    },
    version   => '0.10.3',
    enable_ui => true,
  }
  notify { "vault parameter: ${lookup({"name" => "vault_notify", "default_value" => "Failed to lookup value."})}":}
}
