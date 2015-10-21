require 'station'
describe Station do
  let(:cockfosters){Station.new("Cockfosters", 5)}
  it 'holds station name' do
    expect(cockfosters.name).to eq("Cockfosters")
  end
  it 'holds zone information' do
    expect(cockfosters.zone).to eq(5)
  end
end
