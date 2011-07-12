# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

class CsvBuilderReportsController < ApplicationController
  before_filter {|c| c.prepend_view_path(File.expand_path(File.dirname(__FILE__) + '/../templates')) }
  before_filter { @csv_builder ||= {} }

  def simple
    # dummy
    respond_to do |format|
      format.html
      format.csv
    end
  end

  def complex
    respond_to do |format|
      format.csv do
        @csv_filename = 'some_complex_filename.csv'
        @csv_builder[:col_sep] = "\t"
        @data = TEST_DATA
      end
    end
  end

  def encoding
    respond_to do |format|
      format.csv { @csv_builder[:output_encoding] = 'UTF-16' }
    end
  end

end
Rails.application.routes.draw { match ':controller/:action' }


describe CsvBuilderReportsController do
  render_views

  describe "Simple layout" do
    it "still responds to HTML" do
      get 'simple'
      response.should be_success
    end

    it "responds to CSV" do
      get 'simple', :format => 'csv'
      response.should be_success
    end
  end

  describe "Layout with options" do
    it "sets output encoding correctly" do
      get 'encoding', :format => 'csv'
      response.body.to_s.should == generate({ :output_encoding => 'UTF-8' }, ['ąčęėįšųūž'])
    end

    it "passes csv options" do
      get 'complex', :format => 'csv'
      response.body.to_s.should == generate({ :col_sep => "\t" })
    end

    it "sets filename" do
      get 'complex', :format => 'csv'
      response.headers['Content-Disposition'].should match(/filename="some_complex_filename.csv"/)
    end
  end
end
