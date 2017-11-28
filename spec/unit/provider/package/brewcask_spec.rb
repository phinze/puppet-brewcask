require 'spec_helper'

provider = Puppet::Type.type(:package).provider(:brewcask)

describe provider do
  it 'should have an install method' do
    is_expected.to respond_to(:install)
  end

  it 'should have a uninstall method' do
    is_expected.to respond_to(:uninstall)
  end

  it 'should not have a latst method' do
    is_expected.not_to respond_to(:latest)
  end

  it 'should not have a update method' do
    is_expected.not_to respond_to(:update)
  end

  describe 'when installing' do
    context 'installing cask without install options' do
      before do
        @resource = Puppet::Type.type(:package).new(
                                                    :name     => 'mycask',
                                                    :ensure   => :present,
                                                    :provider => :brewcask,
                                                   )
        @provider = provider.new(@resource)
      end

      it 'should return install command' do
        expect{ @provider.install }.to raise_error(Puppet::ExecutionFailure,
                                                    /brew boxen-cask-install mycask/)
      end

      it 'should return nil query' do
        expect(@provider.query).to eq(nil)
      end
    end

    context 'installing cask with install options' do
      before do
        @resource = Puppet::Type.type(:package).new(
                                                    :name     => 'mycask',
                                                    :ensure   => :present,
                                                    :provider => :brewcask,
                                                    :install_options => '--foo',
                                                    )
        @provider = provider.new(@resource)
      end

      it 'should return install command with install options' do
        expect { @provider.install }.to raise_error(Puppet::ExecutionFailure,
                                                    /brew cask install --foo mycask/)
      end
    end
  end

  describe 'when uninstalling' do
      before do
        @resource = Puppet::Type.type(:package).new(
                                                    :name     => 'mycask',
                                                    :ensure   => :present,
                                                    :provider => :brewcask,
                                                    )
        @provider = provider.new(@resource)
      end

      it 'should return uninstall command' do
        expect { @provider.uninstall }.to raise_error(Puppet::ExecutionFailure,
                                                      /brew cask uninstall --force mycask/)
      end
  end
end
