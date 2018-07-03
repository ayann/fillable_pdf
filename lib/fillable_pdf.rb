require "fillable_pdf/version"

module FillablePdf
  Pdftk = PdfForms.new(ENV['PDFTK_PATH'] || '/usr/bin/pdftk')
end
