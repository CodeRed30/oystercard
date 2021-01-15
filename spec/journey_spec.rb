require 'journey'

describe Journey do
  let(:card) {double :oystercard, :touch_in => entry_station}
  let(:entry_station) {double :station}

  # it "remembers the entry station" do
  #   card.touch_in(entry_station)
  #   expect(subject.route).to have_attributes(:entry_station => entry_station)
  # end

end
