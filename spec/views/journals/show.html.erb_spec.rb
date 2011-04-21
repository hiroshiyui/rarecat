require 'spec_helper'

describe "journals/show.html.erb" do
  before(:each) do
    @journal = assign(:journal, stub_model(Journal))
  end

  it "renders attributes in <p>" do
    render
  end
end
