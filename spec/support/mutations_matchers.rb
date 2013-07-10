def is_required(*params)
  params.each do |param|
    it ":#{param} parameter must be required" do
      expect(subject.class.input_filters.required_inputs).to include(param)
    end
  end
end

def is_optional(*params)
  params.each do |param|
    it ":#{param} parameter must be required" do
      expect(subject.class.input_filters.optional_inputs).to include(param)
    end
  end
end

def service_request_with(param, value, &block)
  context "when :#{param} = #{value.inspect}" do
    let(:params) do
      super().merge({ param => value })
    end
    it { yield(response.result) }
  end
end

def service_should_map(param, map)
  context param do
    map.each do |value, expected|
      service_request_with(param, value) { |r| r[param].should == expected }
    end
  end
end
