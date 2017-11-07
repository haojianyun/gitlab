require 'spec_helper'

describe ClusterApplicationEntity do
  describe '#as_json' do
    let(:application) { build(:applications_helm) }
    subject { described_class.new(application).as_json }

    it 'has name' do
      expect(subject[:name]).to eq(application.name)
    end

    it 'has status' do
      expect(subject[:status]).to eq(:installable)
    end

    it 'has no status_reason' do
      expect(subject[:status_reason]).to be_nil
    end

    context 'when application is errored' do
      let(:application) { build(:applications_helm, :errored) }

      it 'has corresponded data' do
        expect(subject[:status]).to eq(:errored)
        expect(subject[:status_reason]).not_to be_nil
        expect(subject[:status_reason]).to eq(application.status_reason)
      end
    end
  end
end
