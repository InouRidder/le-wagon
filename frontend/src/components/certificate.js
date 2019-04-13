import React, { Component } from 'react';
import { BrowserRouter as Router, Route, Link } from "react-router-dom";
import 'bulma/css/bulma.css'
import getWeb3 from '../utils/getWeb3'
var certificatesArtifact = require('../contracts/Certificates.json');

const CERTTYPES = ["Tradable", "Non tradable"]

class Certificate extends Component {
  constructor(props) {
    super(props)

    this.state = {
      smartmeterID: 1,
      certificates: []
    }
  }

  async componentDidMount() {
    const web3 = await getWeb3

    const jsonInterface = certificatesArtifact.abi
    const address = "0x539bc5Ef3907DC37eFE798926A7D52d75C8FA512"
    const options = {}

    console.log(web3.instance)

    const contractInstance = await web3.instance.eth.Contract(jsonInterface, address, options)

    console.log(contractInstance)

    const certificates = await contractInstance.methods.certificates(this.state.smartmeterID).call()

    console.log(certificates)

    const accounts = await web3.instance.eth.getAccounts()

    // console.log(accounts)
    // await contractInstance.methods.pushCertificate(2, 100, 12345, 0).send({ from: accounts[0] })

    var certificateList = []

    var i

    for (i = 0; i < certificates[0].length; i++) {
      console.log(i)
      certificateList.push({
        amount: certificates[0][i],
        timestamp: certificates[1][i],
        certificateType: certificates[2][i]
      })
    }

    this.setState({certificates: certificateList})
  }


  render() {

    const certificates = this.state.certificates.map((certificate) => {
      return (
        <li key={ Math.random().toString(36).replace(/[^a-z]+/g, '')  }>
          <strong>amount:</strong> { Number(certificate.amount) } <strong>type:</strong> { CERTTYPES[certificate.certificateType] } <strong>timestamp:</strong> { Number(certificate.timestamp) }
        </li>
      )
    })

    return (
      <Router>
        <div>
          <p>Dit is de certificate page</p>

          <hr />

          <ul>
            { certificates }
          </ul>
        </div>
      </Router>
    );
  }
}

export default Certificate;
