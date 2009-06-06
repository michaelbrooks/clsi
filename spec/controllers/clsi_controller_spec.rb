require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'action_web_service/test_invoke'

describe ClsiController do
  describe 'getToken' do
    it "should return a token and create a user with that token" do
      token = invoke :getToken
      token.length.should eql 32
      user = User.find_by_token(token)
      user.should_not be_nil
    end
  end

  describe 'compile' do
    it "should return a list of compiled files for a successful compile" do
      @compile = mock('compile', :project => mock('project', :name => 'My Project'))
      @compile.stub!(:compile)
      @compile.stub!(:status).and_return(:success)
      @compile.stub!(:return_files).and_return(['output/output.pdf', 'output/output.log'])
      Compile.should_receive('new_from_request').with('request_xml').and_return(@compile)
      result = invoke :compile, 'request_xml'
      
      parser = REXML::Document.new result
      parser.elements['compile'].elements['status'].text.should eql 'success'
      parser.elements['compile'].elements['name'].text.should eql 'My Project'

      file1 = parser.elements['compile'].elements['output'].elements[1]
      file1.name.should eql 'file'
      file1.attributes['type'].should eql 'pdf'
      file1.attributes['url'].should eql 'output/output.pdf'

      file2 = parser.elements['compile'].elements['output'].elements[2]
      file2.name.should eql 'file'
      file2.attributes['type'].should eql 'log'
      file2.attributes['url'].should eql 'output/output.log'
    end

    it "should return the log file for an unsuccessful compile" do
      @compile = mock('compile', :project => mock('project', :name => 'My Project'))
      @compile.stub!(:compile)
      @compile.stub!(:status).and_return(:failed)
      @compile.stub!(:return_files).and_return(['output/output.log'])

      Compile.should_receive('new_from_request').with('request_xml').and_return(@compile)
      result = invoke :compile, 'request_xml'
      
      parser = REXML::Document.new result
      parser.elements['compile'].elements['status'].text.should eql 'failed compile'
      parser.elements['compile'].elements['name'].text.should eql 'My Project'

      file = parser.elements['compile'].elements['output'].elements[1]
      file.name.should eql 'file'
      file.attributes['type'].should eql 'log'
      file.attributes['url'].should eql 'output/output.log'
    end

    it "should return an error message for an unsuccessful compile" do
      @compile = mock('compile', :project => mock('project', :name => 'My Project'))
      Compile.should_receive('new_from_request').with('bad_xml').and_raise(CLSI::ParseError.new('malformed XML'))
      result = invoke :compile, 'bad_xml'
      
      parser = REXML::Document.new result
      #raise result
      parser.elements['compile'].elements['status'].text.should eql 'failed parse'
      parser.elements['compile'].elements['status'].attributes['reason'].should eql 'malformed XML'
    end
  end
end