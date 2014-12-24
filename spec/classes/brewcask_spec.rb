require 'spec_helper'

describe 'brewcask' do
  let(:facts) { default_test_facts }

  it do
    should include_class('homebrew')

    should contain_file('/test/boxen/homebrew-cask').with_ensure('directory')
    should contain_file('/test/boxen/homebrew-cask/Caskroom').with_ensure('directory')

    should contain_homebrew__tap('caskroom/cask').with_before('Package[brew-cask]')
    should contain_package('brew-cask').with_provider('homebrew')
    should contain_boxen__env_script('brewcask').with_ensure('present')
  end
end
