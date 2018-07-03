require "fillable_pdf/version"
require 'securerandom'

module FillablePdf
  Pdftk = PdfForms.new(ENV['PDFTK_PATH'] || '/usr/bin/pdftk')
end
