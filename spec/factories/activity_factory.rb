class ActivityFactory
  def self.create(params = {})
    params.reverse_merge!({
      application_id: 456,
      user_id: 123,
      content: "This is the content ##{sequence}"
    })

    RestPack::Services::Activity::Create.run!(params)
  end

  private

  def self.sequence
    @@sequence ||= 0
    @@sequence += 1
    @@sequence
  end
end
