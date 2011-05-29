require 'puppet'
require 'yaml'
require 'pp'

begin
  require 'gmetric'
rescue LoadError => e
  Puppet.info "You need the `gmetric` gem to use the Ganglia report"
end

Puppet::Reports.register_report(:ganglia) do

  configfile = File.join([File.dirname(Puppet.settings[:config]), "ganglia.yaml"])
  raise(Puppet::ParseError, "Ganglia report config file #{configfile} not readable") unless File.exist?(configfile)
  config = YAML.load_file(configfile)
  GANGLIA_SERVER = config[:ganglia_server]
  GANGLIA_PORT = config[:ganglia_port]

  desc <<-DESC
  Send notification of failed reports to a Ganglia server via gmetric.
  DESC

  def process
    Puppet.debug "Sending status for #{self.host} to Ganglia server at #{GANGLIA_SERVER}"
    self.metrics.each { |metric,data|
      data.values.each { |val| 
        name = "Puppet #{val[1]} #{metric}"
        if metric == 'time'
          units = 'seconds'
        else
          units = metric
        end
        value = val[2]

        Ganglia::GMetric.send("#{GANGLIA_SERVER}", GANGLIA_PORT, {
          :name => name,
          :units => units,
          :type => 'uint8',
          :value => value,
        })
      }
    }
  end
end
