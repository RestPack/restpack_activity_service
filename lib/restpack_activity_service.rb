require 'restpack_service'
RestPack::Service::Loader.load 'restpack_activity_service', 'Activity'

require "restpack_activity_service/api/activity"
