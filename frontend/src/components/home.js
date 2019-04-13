import React, { Component } from 'react';
import { BrowserRouter as Router, Route, Link } from "react-router-dom";
import 'bulma/css/bulma.css'

class Home extends Component {
  render() {
    return (
      <Router>
        <div>
          <p>Dit is de homepage</p>

          <hr />

        </div>
      </Router>
    );
  }
}

export default Home;
