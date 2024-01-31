#!/opt/puppetlabs/puppet/bin/ruby

require 'json'
require 'yaml'

begin
  csr_yaml = YAML.dump(JSON.load(ENV['CSR_ATTRIBUTES']))
  File.open('/etc/puppetlabs/puppet/csr_attrbitues.yaml', 'w') do |file|
    file.write(csr_yaml)
  end
rescue => error
  puts "Error on reading JSON env. Terminating"
  p error.message
  exit 99
end
