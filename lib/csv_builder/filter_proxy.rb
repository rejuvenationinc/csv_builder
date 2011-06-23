# encoding: utf-8

module CsvBuilder
  class FilterProxy < Proxy

    # Transliterate into the required encoding if necessary
    def init(base, target, options = {}, &block)
      options = options.dup

      options.reverse_merge!(:input_encoding => 'UTF-8', :output_encoding => 'LATIN1')

      super(base, target, options, &block)
    end

    # Transliterate before passing to CSV so that the right characters (e.g. quotes) get escaped
    def <<(row)
      if options[:input_encoding] != options[:output_encoding]
        # TODO: do some checking to make sure iconv works correctly in
        # current environment. See ActiveSupport::Inflector#transliterate
        # definition for details
        #
        # Not using the more standard //IGNORE//TRANSLIT because it raises
        # Iconv::IllegalSequence for some inputs
        @iconv = Iconv.new("#{options[:output_encoding]}//TRANSLIT//IGNORE", options[:input_encoding])
      end

      base << if @iconv then row.map { |value| @iconv.iconv(value.to_s) } else row end
    end

    alias :add_row :<<

  end
end