require 'spec_helper'

describe "journals/index.html.erb" do
  before(:each) do
    assign(:journals, [
      stub_model(Journal),
      stub_model(Journal)
    ])
  end

  it "renders a list of journals" do
    render
  end
end
