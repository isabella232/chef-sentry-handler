require_relative File.expand_path("../../spec_helper.rb", __FILE__)
require_relative File.expand_path("../../../../files/default/sentry.rb", __FILE__)

require 'chef'

describe Raven::Chef::SentryHandler do

  before do
    @node = Chef::Node.new
    @node.chef_environment = "testing"
    @node.default["sentry"] = {
      "dsn" => "http://test.test",
      "verify_ssl" => true
    }
  end

  describe "#sanitize_exception" do
    context "exception has a keyword" do
      it "sanitizes with a keyword" do
        exception = "there's a key here"

        expect(described_class.new(@node).send(:sanitize_exception, exception)).to eq(SANITIZED_EXCEPTION_MESSAGE)
      end
    end
  end

  describe "#sanitize_exception" do
    context "exception has no keyword" do
      it "returns the exception" do
        exception = "there's no k3y here"

        expect(described_class.new(@node).send(:sanitize_exception, exception)).to eq(exception)
      end
    end
  end
end
