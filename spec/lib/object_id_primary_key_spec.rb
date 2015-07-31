require 'spec_helper'

describe ObjectIdPrimaryKey do
  it "should assign an object_id to a newly created object" do
    address = Address.new
    expect(address.id).to eq(nil)

    address.save!
    address.reload
    expect(address.id).to_not eq(nil)
    expect(BSON::ObjectId.legal?(address.id)).to eq(true)
  end

  it 'should reject an invalid object_id provided during initialization' do
    expect{ Address.create(id: 'BAD_ID') }.to raise_error('Invalid ObjectId')
  end

  it 'should not overwrite an object_id provided as part of initialization' do
    id = BSON::ObjectId.new.to_s

    address = Address.create(id: id)

    address.reload

    expect(address.id).to eq(id)
  end

  it 'should prevent an update with an invalid object_id' do
    address = Address.create

    expect{ address.update_attribute :id, 'BAD_ID' }.to raise_error('Invalid ObjectId')
  end

  describe '#base64_id' do
    it 'returns the base 64 encoded version of the ID' do
      address = Address.new(id: '55babee2416c65a98e020000')
      expect(address.base64_id).to eq('Vbq-4kFsZamOAgAA')
    end
  end

  describe '.find_by_base64_id' do
    it 'finds an object' do
      address = Address.create(id: '55babee2416c65a98e020000')
      expect(Address.find_by_base64_id('Vbq-4kFsZamOAgAA')).to eq(address)
    end
  end
end
