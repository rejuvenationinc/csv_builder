# encoding: utf-8

module CsvBuilder # :nodoc:

  # Template handler for csv templates
  #
  # Add rows to your CSV file in the template by pushing arrays of columns into csv
  #
  #   # First row
  #   csv << [ 'cell 1', 'cell 2' ]
  #   # Second row
  #   csv << [ 'another cell value', 'and another' ]
  #   # etc...
  #
  # You can set the default filename for that a browser will use for 'save as' by
  # setting <tt>@filename</tt> instance variable in your controller's action method
  # e.g.
  #
  #   @csv_filename = 'report.csv'
  #
  # You can also set the input encoding and output encoding by setting
  # <tt>@input_encoding</tt> and <tt>@output_encoding</tt> instance variables.
  # These default to 'UTF-8' and 'LATIN1' respectively. e.g.
  #
  #   @output_encoding = 'UTF-8'
  class TemplateHandler
    class_attribute :default_format
    self.default_format = Mime[:csv]

    def call(template)
      <<-EOV
      begin;
        self.output_buffer = String.new;
        csv = CsvBuilder::CsvProxy.new(self.output_buffer, @csv_builder || {});
        #{template.source};
        if @csv_filename;
          controller.response.headers['Content-Disposition'] = %Q{attachment; filename="\#{@csv_filename}"};
        end;
        self.output_buffer;
      rescue Exception => e;
        Rails.logger.warn("Exception \#{e} \#{e.message} with class \#{e.class.name} thrown when rendering CSV");
        raise e;
      end;
      EOV
    end

  end
end
