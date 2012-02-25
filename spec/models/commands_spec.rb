require 'spec_helper'

module Commands
  replace %r{:emoji:} do
    "EMOJI"
  end

  replace %r{:\w+:} do |word|
    word[1...-1].upcase
  end
end

describe Commands do
  def process(text)
    command = described_class.process text
  end

  context 'replacing' do
    it 'should replace emoji' do
      command = process "Here is an :emoji:!"
      command.data.should eq("Here is an EMOJI!")
    end

    it 'should replace all instances of :word: with :WORD:' do
      command = process "hey, :smile: have a :beer:!"
      command.data.should eq("hey, SMILE have a BEER!")
    end
  end

  context 'listening' do
    it 'should recognize pastes' do
      command = process "a\nb\nc\n"
      command.type.should eq(:paste)
      command.data.should eq("a\nb\nc\n")
    end

    it 'should recognize sounds' do
      command = process '/play my_sound_name'
      command.type.should eq(:sound)
      command.data.should eq('my_sound_name')
    end

    it 'should not recognize urls within text' do
      command = process 'heres my website screenshot http://example.com/screenshot.gif'
      command.type.should eq(:text)
    end

    it 'should not recognize commands within text' do
      command = process 'to use commands use /command'
      command.type.should eq(:text)
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

    it 'should catch unknown commands without args' do
      command = process '/clear'
      command.type.should eq(:clear)
      command.data.should be_nil
    end
  end
end