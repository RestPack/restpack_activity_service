module Commands::Activities::Activity
  class Get < RestPack::Service::Commands::Get
    required do
      integer :id
      integer :application_id
    end
  end
end
