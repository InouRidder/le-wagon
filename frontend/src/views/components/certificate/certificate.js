import React, { Component } from 'react';
import { BrowserRouter as Router} from "react-router-dom";
import 'bulma/css/bulma.css'
import getWeb3 from '../../../utils/getWeb3'
import { decorate } from './styles';
var certificatesArtifact = require('../../../contracts/Certificates.json');


const CERTTYPES = ["Tradable", "Non tradable"]

class Certificate extends Component {
  constructor(props) {
    super(props)

    this.state = {
      smartmeterID: 1,
      certificates: [],
      contract: null,
      web3: null
    }

    this.handleMeterChange = this.handleMeterChange.bind(this)
    this.handleSubmit = this.handleSubmit.bind(this)
  }

  async componentDidMount() {
    const web3 = await getWeb3

    const jsonInterface = certificatesArtifact.abi
    const address = "0xBA21822d572a2572DdF75555442615bD41AA54FE"
    const options = {}

    const contractInstance = await web3.instance.eth.Contract(jsonInterface, address, options)

    this.setState({ contract: contractInstance, web3: web3.instance })
  }

  handleMeterChange(event) {
    this.setState({ smartmeterID: event.target.value });
  }

  async handleSubmit(event) {
    const certificates = await this.state.contract.methods.certificates(this.state.smartmeterID).call()

    var certificateList = []

    var i
    if (certificates) {
      for (i = 0; i < certificates[0].length; i++) {
        certificateList.push({
          amount: certificates[0][i],
          timestamp: certificates[1][i],
          certificateType: certificates[2][i]
        })
      }
    }

    this.setState({certificates: certificateList})
  }


  render() {

    const certificates = this.state.certificates.map((certificate) => {
      return (
        <tr key={ Math.random().toString(36).replace(/[^a-z]+/g, '')  }>
          <td>{ Number(certificate.amount) }</td>
          <td>{ CERTTYPES[certificate.certificateType] }</td>
          <td>{ Number(certificate.timestamp) }</td>
        </tr>
      )
    })

    const form = (
      <div className="field has-addons">
        <div className="control">
          <input className="input" type="text" placeholder="Find a repository" value={this.state.smartmeterID} onChange={this.handleMeterChange} />
        </div>
        <div className="control">
          <button className="button is-info" onClick={this.handleSubmit}>
            Get certificates
          </button>
        </div>
      </div>
    )

    return (
      <Router>
        <div className="container">
          <p className="title">Certificates</p>

          <hr />
          { this.state.contract ? form : null }

          <br />

          <table className="table is-fullwidth">
            <thead>
              <tr>
                <th>Amount</th>
                <th>Type</th>
                <th>Timestamp</th>
              </tr>
            </thead>
            <tbody>
              { certificates }
            </tbody>
          </table>
        </div>
      </Router>
    );
  }
}

export default decorate(Certificate);
