require_relative '../spec_helper'

describe RestPack::Services::Activity::List do
  is_required :application_id
  is_optional :user_id, :page, :page_size, :tags, :access, :query

  before do
    ActivityFactory.create({
      application_id: 100, user_id: 200, title: 'Achievement Unlocked 1',
      content: 'Three in a row! You have unlocked the "three-in-a-row" achievement.',
      tags: 'achievement,three in a row',
      access: 'user:100,group:300'
    })

    ActivityFactory.create({
      application_id: 100, user_id: 200, title: 'Achievement Unlocked 2',
      content: 'Five in a row! You have unlocked the "five-in-a-row" achievement.',
      tags: 'achievement,five in a row',
      access: 'user:100,group:300'
    })

    ActivityFactory.create({
      application_id: 100, user_id: 200, title: '3 Photos Uploaded',
      content: '3 photos have been uploaded',
      tags: 'photos',
      access: 'user:100,group:142857',
      data: {
        photos: ['1.png', '2.png', '3.png']
      }
    })

    ActivityFactory.create({
      application_id: 100, user_id: 200, title: 'Check In: Eatery120',
      content: 'You checked in to Eatery 130, Ranelagh, Dublin 6',
      tags: 'checkin,eatery120,ranelagh,dublin',
      access: 'user:100,public',
      latitude: 53.324577,
      longitude: -6.254193
    })
  end

  context 'listing activities' do
    let(:response) { subject.class.run(params) }

    context ':application_id' do
      context 'valid' do
        let(:params) { { application_id: 100 } }
        it 'retuns activities' do
          response.result[:meta][:activities][:count].should == RestPack::Models::Activity.count
        end
      end

      context 'invalid' do
        let(:params) { { application_id: 999 } }
        it 'retuns no activities' do
          response.result[:meta][:activities][:count].should == 0
        end
      end
    end

    context ':user_id' do
      context 'valid' do
        let(:params) { { application_id: 100, user_id: 200 }}

        it 'returns activities' do
          response.result[:meta][:activities][:count].should == RestPack::Models::Activity.count
        end
      end

      context 'invalid' do
        let(:params) { { application_id: 100, user_id: 999 }}

        it 'returns no activities' do
          response.result[:meta][:activities][:count].should == 0
        end
      end
    end

    context ':tags' do
      context '"achievement" tag' do
        let(:params) { { application_id:100, tags: 'achievement' } }

        it 'returns two "achievement" activities' do
          response.result[:meta][:activities][:count].should == 2
          response.result[:activities][0][:title].should == 'Achievement Unlocked 1'
          response.result[:activities][1][:title].should == 'Achievement Unlocked 2'
        end
      end

      context 'two tags' do
        let(:params) { { application_id:100, tags: 'achievement,five in a row' } }

        it 'returns single "achievement" activity' do
          response.result[:meta][:activities][:count].should == 1
          response.result[:activities][0][:title].should == 'Achievement Unlocked 2'
        end
      end
    end

    context ':access' do
      context 'invalid group' do
        let(:params) { { application_id:100, access: 'group:999' } }

        it 'returns no activities' do
          response.result[:meta][:activities][:count].should == 0
        end
      end

      context 'valid group' do
        let(:params) { { application_id:100, access: 'group:300' } }

        it 'returns relevant activities' do
          response.result[:meta][:activities][:count].should == 2
        end
      end

      context 'two access tags' do
        let(:params) { { application_id:100, access: 'public,group:142857' } }

        it 'returns activities with either access tag' do
          response.result[:meta][:activities][:count].should == 2
        end
      end
    end

    context ':query' do
      context 'with match in title' do
        let(:params) { { application_id:100, query: "check in" } }

        it 'returns a match' do
          response.result[:meta][:activities][:count].should == 1
          response.result[:activities][0][:title].should == 'Check In: Eatery120'
        end
      end

      context 'with match in content' do
        let(:params) { { application_id:100, query: 'Ranelagh' } }

        it 'returns a match' do
          response.result[:meta][:activities][:count].should == 1
          response.result[:activities][0][:title].should == 'Check In: Eatery120'
        end
      end
    end
  end
end
