include Rake::DSL
require 'bundler'
Bundler.require

Wox::Tasks.create :info_plist => 'receipt/receipt-Info.plist', :sdk => 'iphoneos', :configuration => 'Release' do
  build :debug, :configuration => 'Debug'

  build :release, :developer_certificate => 'iPhone Distribution: OOO InTech' do
    ipa :adhoc, :provisioning_profile => '118144FF-F5D1-4F66-B2E3-8742ACB97E27' do
      testflight :publish, :api_token => 'a3977a2c0068de2da1c13be524ba7c27_MzE5NjI0MjAxMi0wMi0xNiAwMjowOTo1NC4wMzk5ODM',
                           :team_token => '5c625c79bc3ab7734e70c55ddd7a1ede_MTIwODY2MjAxMi0wOC0xMyAxNToxMToyNS41MjQyOTQ',
                           :notes => proc { File.read("CHANGELOG") },
                           :distribution_lists => %w[Internal],
                           :notify => true

    end
  end
end
