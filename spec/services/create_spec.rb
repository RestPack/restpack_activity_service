require_relative '../spec_helper'

describe RestPack::Services::Activity::Create do
  is_required :application_id, :user_id, :content
  is_optional :title, :tags, :access, :latitude, :longitude

  context 'creating an activity' do
    let(:response) { subject.class.run(params) }

    context 'with valid params' do
      let(:params) { {
        application_id: 123,
        user_id: 234,
        content: "this is the activity content",
        title: "this is the title",
        latitude: 53.180999,
        longitude: -6.301528
      } }

      it 'returns the newly created activity' do
        response.success?.should == true

        response.result[:application_id].should == params[:application_id]
        response.result[:user_id].should == params[:user_id]
        response.result[:content].should == params[:content]
        response.result[:title].should == params[:title]
        response.result[:latitude].should == 53.180999
        response.result[:longitude].should == -6.301528

        response.result[:tags].should == []
        response.result[:access].should == []
        response.result[:data].should == nil
      end

      service_should_map :tags, {
        nil           => [],
        ''            => [],
        '  '          => [],
        'tag1'        => ['tag1'],
        'Tag1'        => ['Tag1'],
        ' tag1 '      => ['tag1'],
        'tag1,tag2'   => ['tag1', 'tag2'],
        'tag1,tag1'   => ['tag1'],
        'foo bar'     => ['foo bar'],
        'a|b||c|||'   => ['abc'],
      }

      service_should_map :access, {
        nil           => [],
        ''            => [],
        '  '          => [],
        ' public '    => ['public'],
        'group:123'   => ['group:123'],
        'gavin,sarah' => ['gavin', 'sarah']
      }

      service_should_map :data, {
        nil => nil,
        { } => { },
        { 'a' => 1 } => { 'a' => 1 }
      }
    end
  end
end
