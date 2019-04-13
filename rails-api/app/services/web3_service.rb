class Web3Service
  def initialize
    contract_address = "0x539bc5Ef3907DC37eFE798926A7D52d75C8FA512"
    dummy_private_key = "8695fe6ca35eeb46a6e920093e97ed374aaab45b92e7103cd6b65d1975c018d7"

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
