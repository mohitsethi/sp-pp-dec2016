

## How to install

```
gem install puppetclassify
```

### Locally

```
gem build puppetclassify.gemspec
gem install puppetclassify-0.1.0.gem
```
## How to use

Here is the basic configuration you'll need to use the puppetclassify class:

```ruby
require 'puppetclassify'
# URL of classifier as well as certificates and private key for auth
auth_info = {
  "ca_certificate_path" => "/etc/puppetlabs/puppet/ssl/certs/ca.pem",
  "certificate_path"    => "/etc/puppetlabs/puppet/ssl/certs/myhostname.vm.pem",
  "private_key_path"    => "/etc/puppetlabs/puppet/ssl/private_keys/myhostname.vm.pem",
  "read_timeout"        => 90 # optional timeout, defaults to 90 if this key doesn't exist
}

classifier_url = 'https://puppetmaster.local:4433/classifier-api'
puppetclassify = PuppetClassify.new(classifier_url, auth_info)
```

### Basic case

If you are wanting to get all of the groups the classifier knows about:

```ruby
# Get all the groups
puppetclassify.groups.get_groups
```

### Taking action on a specific group by name

If you have a group you want to modify, but do not know the group ID:

```ruby
my_group_id = puppetclassify.groups.get_group_id("My Group Name")
group_delta = {"variables"=>{"key"=>"value"}, "id"=>my_group_id, "classes"=>{"motd"=>{"content"=>"hello!"}}} # an example to update a groups variables and classes
puppetclassify.groups.update_group(group_delta)
```

### Retrieving classification of a node

Because the Console classifies nodes based on rules, you may want to submit a
complete `facts` hash for rules to match. See [the API docs](https://docs.puppetlabs.com/pe/latest/nc_classification.html)
for examples.

You can retrieve facts for the local node either using Facter from Ruby or the
command line. For example:

```ruby
#! /opt/puppetlabs/puppet/bin/ruby
require 'facter'

facts = { 'fact' => Facter.to_hash }
```

or:

```ruby
#! /usr/bin/env ruby
require 'json'

facts = { 'fact' => JSON.parse(`facter -j`) }
```

Once you have the facts, retrieving classification of a node is simple:

```ruby
#! /opt/puppetlabs/puppet/bin/ruby
require 'facter'
require 'puppetclassify'

# NOTE: Add setup information here for puppetclassify

# gather facts
facts = { 'fact' => Facter.to_hash }

# Get a node's classification
puppetclassify.classification.get('myhostname.puppetlabs.vm', facts)
```

### Pinning and unpinning nodes to a group in Puppet enterprise

If you want to "pin" a node to a specific group so it gets that classification, you can
invoke the pin_nodes command. And if you want to remove nodes from that group, you can run
the unpin_nodes command.

If you want to remove nodes from every group they are pinned to, use the unpin_from_all command.

```ruby
my_group_id = puppetclassify.groups.get_group_id("My Super Awesome Group Name")

nodes = ["hostname.com", "myotherhost.com", "anotherhost.com"]
# pin nodes to group
puppetclassify.groups.pin_nodes(my_group_id, nodes)

# unpin nodes from group
puppetclassify.groups.unpin_nodes(my_group_id, nodes)

# unpin nodes from EVERY group
puppetlcassify.commands.unpin_from_all(nodes)
```
