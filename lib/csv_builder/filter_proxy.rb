# encoding: utf-8

module CsvBuilder

  DEFAULT_INPUT_ENCODING  = Encoding::UTF_8
  DEFAULT_OUTPUT_ENCODING = Encoding::ISO_8859_1

  class FilterProxy < Proxy

    # Transliterate into the required encoding if necessary
    def initialize(data, options = {})
      @options = options.dup

      #@options.reverse_merge!(:input_encoding => 'UTF-8', :output_encoding => 'LATIN1')
      @options.reverse_merge!(:input_encoding => DEFAULT_INPUT_ENCODING, :output_encoding => DEFAULT_OUTPUT_ENCODING)

      @input_encoding  = @options.delete(:input_encoding)
      @output_encoding = @options.delete(:output_encoding)
    end

    # Transliterate before passing to CSV so that the right characters (e.g. quotes) get escaped
    def <<(row)
      begin
        base << [*row].map do |value|
          v = value.to_s
          v.force_encoding(@input_encoding)
          v.encode(@output_encoding, :undef => :replace)
          v.encode!
        end
      rescue
        base << [*row]
      end
    end

    alias :add_row :<<

  end
end