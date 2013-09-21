require 'restpack_service'
RestPack::Service::Loader.load 'activity', Dir.pwd

require "restpack_activity_service/api/activity"
