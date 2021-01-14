require "oystercard"

describe OysterCard do

  let(:entry_station) {double :station}
  let(:exit_station) {double :station}
  let(:journey) {{ :entry_station => entry_station, :exit_station => exit_station }}

  describe "#balance" do

    it "has balance of 0 on initializing" do
      expect(subject.balance).to eq 0
    end

  end

  describe "#top_up" do

    it "takes one argument" do
      expect(subject).to respond_to(:top_up).with(1).argument
    end

    it "increases balance" do
      expect{ subject.top_up(10) }.to change{ subject.balance }.by 10
    end
  end

    # before(:context) { subject.top_up(OysterCard::MAXIMUM_BALANCE) }

      describe "card with maximum balance" do

      it "raises error if balance limit is reached" do
        subject.top_up(OysterCard::MAXIMUM_BALANCE)
        expect { subject.top_up(OysterCard::MINIMUM_BALANCE) }.to raise_error "Unable to top up as it would exceed balance limit (£#{OysterCard::MAXIMUM_BALANCE})"
      end
     end




  describe '#deduct' do

    it "decreases balance by MINIMUM_BALANCE" do
      subject.top_up(10)
      subject.touch_in(entry_station)
      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-OysterCard::MINIMUM_BALANCE)
    end
  end

  describe "#touch_in" do

    it { is_expected.to respond_to :touch_in }

    it "sets in_journey? to be true" do
      subject.top_up(OysterCard::MINIMUM_BALANCE)
      subject.touch_in(entry_station)
      expect(subject).to be_in_journey
    end

    it "raises an error if you re below the minimum fare" do
      expect{ subject.touch_in(entry_station) }.to raise_error "Insufficient funds"
    end

    # it "remembers the entry station" do
    #   subject.top_up(OysterCard::MINIMUM_BALANCE)
    #   subject.touch_in(entry_station)
    #   expect(journey.route).to have_attributes(:entry_station => entry_station)
    # end
  end

  describe "#touch_out" do
    it { is_expected.to respond_to :touch_out }

    it "sets in_journey? to be false" do
      subject.top_up(OysterCard::MINIMUM_BALANCE)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject).not_to be_in_journey
    end
  end

  describe "#in_journey?" do

    it { is_expected.to respond_to :in_journey? }

    it "is initially not in a journey" do
      expect(subject).not_to be_in_journey
    end
  end

  describe "#journey_history" do

    it "checks if journey_history is empty" do
      expect(subject.journey_history).to be_empty
    end

    it "records journey_history" do
      subject.top_up(10)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journey_history).to include journey
    end

  end

end
