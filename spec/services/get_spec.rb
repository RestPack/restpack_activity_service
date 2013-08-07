require_relative '../spec_helper'

describe Commands::Activity::Get do
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
      response.success?.should == false
      response.result.should == {}
      response.status.should == :not_found
    end
  end
end
