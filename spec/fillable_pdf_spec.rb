# frozen_string_literal: true

RSpec.describe FillablePdf do
  it 'has a version number' do
    expect(FillablePdf::VERSION).not_to be nil
  end

  describe 'Form' do
    context 'when ENV PDFTK_PATH is nil' do
      it 'has a Pdftk default path' do
        ENV['PDFTK_PATH'] = nil
        expect(FillablePdf::Form.pdftk).to eq('/usr/local/bin/pdftk')
      end
    end

    context 'when ENV PDFTK_PATH is not nil' do
      before do
        ENV['PDFTK_PATH'] = '/usr/bin/pdftk'
      end

      it 'has a Pdftk default path' do
        expect { FillablePdf::Form.pdftk }.to eq(ENV['PDFTK_PATH'])
      end
    end
  end
end
