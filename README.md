# puppet5-hiera-vault-poc

v0.1 20180706

Tested with Ubuntu 16.04 and CentOS 7x, but should work on other OSs with minimal effort

System Requirements: 1 vCPU, 256Mb Memory, 3G Storage/Disk

A POC example of integrating Hiera with Hashicorp Vault for secure secret lookup using Puppet 5.5+

This POC environment is based extensively on the upstream work done by:
 - Peter Souter: https://petersouter.xyz/how-to-use-vault-with-hiera-5-for-secret-management-with-puppet/
 - Dave Alden: https://github.com/davealden/hiera-vault
 - Jonathan Sokolowski: https://github.com/jsok/puppet-vault

Please note: the latter 2 modules are deployed from Git repo instead of Puppet Forge modules.

Due to the extensive changes that have happened in the Git Master branch (for JSOK) and/or the hiera-vault module not being available on the Forge at the time of writing.

INSTRUCTIONS:

Launch an instance based on the "Cloud Init" (User Data), or copy/paste the commands and logic into your virtual machine.

Access Vault in your web browser by browsing to http://<your machine>:8200 (you may need to add rules to a firewall, IPTables chain or Securtity Group to open this port)

Setup 1 master key share, and 1 Vault Token (initially, for POC), download the credentials
Unseal the vault, login with the root token

#puppet apply /etc/puppetlabs/code/environments/production/manifests/site.pp

Running Puppet with the above command at this stage should return the value from data/common.yaml:
"Value coming from Hiera YAML, Vault NOT working"

Edit the hiera.yaml file, remove the comments (#) and add the Master key noted above (beyond POC this should be changed for a service account with read/list permissions).

Within the web browser, add a secret as per 'screenshot1.png', then re-run the above 'apply' command - if all is working, you should see the following returned:
 Notice: vault parameter: SUCCESS! This 'secret' came from Vault!
 Notice: /Stage[main]/Profile::Vault/Notify[vault parameter: SUCCESS! This 'secret' came from Vault!]/message: defined 'message' as 'vault parameter: SUCCESS! This \'secret\' came from Vault!'
