require_relative '../spec_helper'

describe RestPack::Services::Activity::Get do
  is_required :id, :application_id

  let(:response) { subject.class.run(params) }
  let(:params) { {} }

  before do
    @activity = ActivityFactory.create({ application_id: 100, title: 'test activity' })
  end

  context 'with valid params' do
    let(:params) { {
      id: @activity[:id],
      application_id: @activity[:application_id]
    } }

    it 'returns the correct activity' do
      response.success?.should == true
      response.result.should == @activity
    end
  end

  context 'with invalid :id' do
    let(:params) { {
      id: 142857,
      application_id: @activity[:application_id]
    }}

    it 'is unsuccessful' do
      #TODO: GJ: decide on how we handle 404 in the service layer
      response.success?.should == false
      response.result.should == nil
      response.errors['id'].should_not == nil
    end
  end
end
