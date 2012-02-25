require 'spec_helper'

describe Commands do
  def process(text)
    command = described_class.process text
  end

  it 'should recognize sounds' do
    command = process '/play my_sound_name'
    command.type.should eq(:sound)
    command.data.should eq('my_sound_name')
  end

  %w{gif jpeg jpg png}.each do |ext|
    it "should recognize #{ext} images" do
      url = "http://some.host.com/example-image.#{ext}"
      command = process url
      command.type.should eq(:image)
      command.data.should eq(url)
    end
  end

  it 'should catch unknown commands' do
    command = process '/unknown command'
    command.type.should eq(:unknown)
    command.data.should eq('command')
  end
end