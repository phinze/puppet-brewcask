require 'spec_helper'

describe 'brewcask' do
  let(:facts) { default_test_facts }

  it do
    should contain_class('boxen::config')
    should contain_class('homebrew')

    should contain_file('/test/boxen/env.d/10_brewcask.sh').
      with_ensure('absent')

    should contain_file('/test/boxen/homebrew/Library/Taps/boxen-brews/cmd/brew-boxen-cask-install.rb').
      with_source('puppet:///modules/brewcask/brew-boxen-cask-install.rb').
      with_mode('0755')
  end
end
