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

    context 'latitude / longitude' do
      let(:params) { {
        application_id: 123,
        user_id: 234,
        content: "this is the activity content",
        title: "this is the title",
        latitude: latititude,
        longitude: longitude
      } }

      context 'when both are nil' do
        let(:latititude) { nil }
        let(:longitude) { nil }

        it 'latitude and longitude should both be nil' do
          response.success?.should == true

          response.result[:latitude].should == nil
          response.result[:longitude].should == nil
        end
      end

      # context 'when latitude is present, but longitude is not present' do
      #   let(:latititude) { 123.45 }
      #   let(:longitude) { nil }

      #   it 'should return a validation error' do
      #     response.success?.should == false
      #     response.errors["base"].should == ["Both Latitude and Longitude are required"]
      #   end
      # end

      # context 'when latitude is not present, but longitude is present' do
      #   let(:latititude) { nil }
      #   let(:longitude) { 90.1 }

      #   it 'should return a validation error' do
      #     response.success?.should == false
      #     response.errors["base"].should == ["Both Latitude and Longitude are required"]
      #   end
      # end

    end
  end
end
