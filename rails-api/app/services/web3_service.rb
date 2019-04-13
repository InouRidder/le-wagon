class Web3Service
  def initialize
    contract_address = "0xe7736e96541aA5ee2acf011683e4B8e97086EB32"
    dummy_private_key = "d9dd376c6f8dae69b7ba11c38cbc8c0f6b6a452beb6d5d2adfed5a9a131ea5b5"

    client = Ethereum::HttpClient.new('http://localhost:8545')

    @contract = Ethereum::Contract.create(
      client: client,
      name: "Certificates",
      truffle: { paths: [ "#{Rails.root}/../energy" ]},
      address: contract_address
    )

    # key = Eth::Key.new
    # p key.private_hex
    # p key.public_hex
    # p key.address
    # @contract.key = key

    @contract.key = Eth::Key.new(priv: dummy_private_key)
  end

  def push_certificate(id, amount, timestamp, certificate_type)
    @contract.transact.push_certificate(id, amount, timestamp, certificate_type)
  end

  def certificates(id)
    @contract.call.certificates(id)
  end
end
