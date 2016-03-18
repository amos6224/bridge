require 'spec_helper'

describe AdminInterface::LockableAdminParser do
  let(:permalinks) { ["namely"] }
  let(:emails) { ["attila1@namely.com"] }
  let(:command) { "lock" }
  let(:authorized_by) { "damon1@namely.com" }
  let(:data) do
    {
      "permalink"     => permalinks,
      "emails"        => emails,
      "command"       => command,
      "authorized_by" => authorized_by,
    }
  end

  let(:parser) { AdminInterface::LockableAdminParser.new(data) }

  describe '#permalinks' do
    it { expect(parser.permalinks).to eq ['namely'] }
  end

  describe '#emails' do
    it { expect(parser.emails).to eq ['attila1@namely.com'] }
  end

  describe '#command' do
    it { expect(parser.command).to eq 'lock' }
  end

  describe '#authorized_by' do
    it { expect(parser.authorized_by).to eq 'damon1@namely.com' }
  end

  context AdminInterface::LockableAdminParser::InvalidPermalinks do
    it 'when namely does not exist' do
      expect{ parser.validate! }.to raise_error(
        described_class, 'Invalid permalinks: namely'
      )
    end

    it 'when namely does exist' do
      FactoryGirl.create(:company, permalink: 'namely')
      expect{ parser.validate! }.not_to raise_error
    end
  end

  context AdminInterface::LockableAdminParser::TooRisky do
    before { FactoryGirl.create(:company, permalink: 'namely') }
    let(:command) { 'unlock' }
    let(:permalinks) { [] }

    it 'when unlocking admins without permalinks' do
      expect{ parser.validate! }.to raise_error(
        described_class, 'too risky'
      )
    end
  end

end
