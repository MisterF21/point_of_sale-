describe Purchase do
  it { should belong_to :cashier }
  it { should belong_to :product }
  it { should belong_to :customer }
end
