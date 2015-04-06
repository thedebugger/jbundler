#!/usr/bin/env ruby
require 'jbundler'
require 'optparse' 
options = {}  
optparse = OptionParser.new do|opts| 

  opts.banner = "Usage: jbundle [options]"

  opts.separator ''
  opts.separator '* load jars: `Jars.require_jars_lock`'
  opts.separator '* classpath features: see `Jars::Classpath'
  opts.separator ''
  opts.separator 'NOTE: JBundler is not need during runtime !'
  opts.separator ''
  opts.separator 'Options:'
  opts.separator ''

  opts.on( '-v', '--verbose', 'Output more information' ) do |t|
    options[:verbose] = t
  end

  opts.on( '-d', '--debug', 'Output debug information' ) do |t|
    options[:debug] = t
  end

  opts.on( '-f', '--force', 'Force creation of Jars.lock' ) do |t|
    options[:force] = t
  end

  opts.on( '-t', '--tree', 'Show dependency tree' ) do |t|
    options[:tree] = t
  end

  opts.on( '-u', '--update JAR_COORDINATE', 'Resolves given dependency and use  latest version' ) do |u|
    options[:update] = u
  end

  opts.on( '--vendor-dir DIRECTORY', 'Vendor directory where to copy the installed jars.', 'add this directory to $LOAD_PATH or set JARS_HOME respectively.' ) do |dir|
    options[:vendor_dir] = File.expand_path( dir )
  end

  opts.on( '-h', '--help', 'Display this screen' ) do
    puts opts
    exit
  end
end
optparse.parse!

require 'jbundler/executor'
mvn = JBundler::Executor.new( options[:debug], options[:verbose] )
mvn.lock_down( options )
