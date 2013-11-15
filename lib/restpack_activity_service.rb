require 'restpack_service'
RestPack::Service::Loader.load 'restpack_activity_service', 'Activities'

require "restpack_activity_service/api/activity"
