import React, { Component } from 'react';
import { BrowserRouter as Router, Route, Link } from "react-router-dom";
import 'bulma/css/bulma.css'
import getWeb3 from '../utils/getWeb3'
var certificatesArtifact = require('../contracts/Certificates.json');


class Certificate extends Component {
  async componentDidMount() {
    const web3 = await getWeb3

    const jsonInterface = certificatesArtifact.abi
    const address = "0x539bc5Ef3907DC37eFE798926A7D52d75C8FA512"
    const options = {}

    console.log(web3.instance)

    const contractInstance = await web3.instance.eth.Contract(jsonInterface, address, options)

    console.log(contractInstance)

    const certificates = await contractInstance.methods.certificates(1).call()

    console.log(certificates)

    const accounts = await web3.instance.eth.getAccounts()

    // console.log(accounts)
    // await contractInstance.methods.pushCertificate(2, 100, 12345, 0).send({ from: accounts[0] })
  }


  render() {
    return (
      <Router>
        <div>
          <p>Dit is de certificate page</p>

          <hr />

        </div>
      </Router>
    );
  }
}

export default Certificate;
