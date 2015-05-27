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
end
