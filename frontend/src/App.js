import React, { Component } from 'react'
import { BrowserRouter as Router, Route } from "react-router-dom"
import 'bulma/css/bulma.css'
import Certificate from '../src/views/components/certificate'
import Home from './views/home/Home'
import Navbar from './views/components/navbar/Navbar'

class App extends Component {

  render() {
    return (
      <Router>
        <div>
          <Navbar />
          <hr />
          <Route exact path="/" component={Home} />
          <Route path="/certificates" component={Certificate} />
        </div>
      </Router>
    );
  }
}

export default App;
