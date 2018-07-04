require 'securerandom'
require 'pdf_forms'

require 'fillable_pdf/version'
require 'fillable_pdf/document'

module FillablePdf
  Form = PdfForms.new(ENV['PDFTK_PATH'], utf8_fields: true)
end
