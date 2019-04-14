class Web3Service
  def initialize
    contract_address = "0x13B8C1CbF63aFC4b0b2759872B9e50AeA19E8885"
    dummy_private_key = "0e1f90152d2eccd5b087f5c83513f6d09a44a5d845e57c3555b6822fd51ec6f9"

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
