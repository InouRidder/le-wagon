class Web3Service
  def initialize
    contract_address = "0xBA21822d572a2572DdF75555442615bD41AA54FE"
    dummy_private_key = "b393cbaed558525b81db7492aa7aaae2ca86377aa33b85937f55829b7317a98a"

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
