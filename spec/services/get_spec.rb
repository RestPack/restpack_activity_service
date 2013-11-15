require 'spec_helper'

describe Commands::Activities::Activity::Get do
  is_required :id, :application_id

  let(:response) { subject.class.run(params) }
  let(:params) { {} }

  before do
    @activity = create(:activity)
  end

  context 'with valid params' do
    let(:params) { {
      id: @activity[:id],
      application_id: @activity[:application_id]
    } }

    it 'returns the correct activity' do
      response.success?.should == true
      response.result.should == Serializers::Activities::Activity.resource(@activity)
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
