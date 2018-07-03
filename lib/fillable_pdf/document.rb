module FillablePdf
  class Document
    attr_writer :template
    attr_reader :attributes

    def field_names
      Pdftk.get_field_names(template)
    end

    def write(read_only: true)
      tempfile = Tempfile.new([SecureRandom.uuid, '.pdf'])
      Pdftk.fill_form template, tempfile, attributes, flatten: read_only
      tempfile
    end

    def read
      blob = (document = write).read
      File.exist?(document) && File.unlink(document)
      blob
    end
  end
end
