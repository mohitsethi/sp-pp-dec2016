require 'puppetclassify'
# URL of classifier as well as certificates and private key for auth
auth_info = {
  "ca_certificate_path" => "/var/lib/puppet/ssl/certs/ca.pem",
  "certificate_path"    => "/var/lib/puppet/ssl/certs/puppetmaster.emc2.com.pem",
  "private_key_path"    => "/var/lib/puppet/ssl/private_keys/puppetmaster.emc2.com.pem",
  "read_timeout"        => 90 # optional timeout, defaults to 90 if this key doesn't exist
}

# classifier_url = 'https://puppetmaster.emc2.com/classifier-api'

classifier_url = 'https://localhost/classifier-api'
puppetclassify = PuppetClassify.new(classifier_url, auth_info)

# print puppetclassify.inspect
# Get all the groups
print puppetclassify.groups.get_groups
