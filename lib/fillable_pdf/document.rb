module FillablePdf
  class Document
    attr_accessor :template
    attr_reader :fields, :context

    def initialize(template, context = nil)
      @template = template
      @context  = context
      @fields   = initialize_fields
    end

    def field_names
      Form.get_field_names(template)
    end

    def write(read_only: true)
      tempfile = Tempfile.new([SecureRandom.uuid, '.pdf'])
      Form.fill_form template, tempfile, fields, flatten: read_only
      tempfile
    end

    def read
      blob = (document = write).read
      File.exist?(document) && File.unlink(document)
      blob
    end

    def fill(field, value)
      fields[field.to_s] = value
    end

    def fill_out(**args)
      args.each do |field, value|
        fill(field, value)
      end
    end

    def value_of(field)
      fields.transform_keys(&:to_s)[field.to_s]
    end

    def join_with(
      before: nil,
      after: nil,
      output: Tempfile.new([SecureRandom.uuid, '.pdf'])
    )
      document     = read
      combined_pdf = CombinePDF.new

      before    && (combined_pdf << CombinePDF.parse(before))
      document  && (combined_pdf << CombinePDF.parse(document))
      after     && (combined_pdf << CombinePDF.parse(after))

      combined_pdf.save(output) && output
    end

    private

    def initialize_fields
      {}.tap do |hash|
        field_names.each { |field| hash[field] = nil }
      end
    end
  end
end
