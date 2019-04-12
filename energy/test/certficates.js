var Certificates = artifacts.require("./Certificates.sol")

contract('PanelAuction', accounts => {
  let certificatesInstance

  const userOne = accounts[0]
  const userTwo = accounts[1]

  it("should deploy the contract", async () => {
    certificatesInstance = await Certificates.deployed();
  })

  it("should push cetrificates", async () => {
    const id = 1000001
    const amount = 100
    const timestamp = Math.floor(Date.now() / 1000)
    const certificateType = 0

    await certificatesInstance.pushCertificate(id, amount, timestamp, certificateType, {from: userOne})
    const certificates = await certificatesInstance.certificates.call(id)

    console.log(certificates)
    assert.equal(certificates[0][0], amount, "Wrong amount")
    assert.equal(certificates[1][0], timestamp, "Wrong timestamp")
    assert.equal(certificates[2][0], certificateType, "Wrong certificate type")
  })
})
