shared_examples_for 'http response' do |template|
  it 'success' do
    expect(response).to be_success
  end

  it 'status code of 200' do
    expect(response.status).to eq 200
  end

  it "renders #{template} template" do
    expect(response).to render_template template
  end
end
