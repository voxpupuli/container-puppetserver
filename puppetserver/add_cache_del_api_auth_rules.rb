#!/opt/puppetlabs/puppet/bin/ruby

require 'hocon/parser/config_document_factory'
require 'hocon/config_value_factory'

auth_conf = '/etc/puppetlabs/puppetserver/conf.d/auth.conf'

conf_hash = Hocon.load(auth_conf)
conf = Hocon::Parser::ConfigDocumentFactory.parse_file(auth_conf)

rule_to_add = [
  {
    'match-request' => {
      'path'   => '/puppet-admin-api/v1/environment-cache',
      'type'   => 'path',
      'method' => 'delete'
    },
    'allow'      => '*',
    'sort-order' => 500,
    'name'       => 'puppet admin api clear caches'
  }
]

conf_hash['authorization']['rules'] += rule_to_add

new_conf = conf.set_config_value('authorization.rules', Hocon::ConfigValueFactory.from_any_ref(conf_hash['authorization']['rules']))

File.open(auth_conf, 'w') { |file| file.write(new_conf.render) }

