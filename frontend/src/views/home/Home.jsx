import * as React from 'react'
import { BrowserRouter as Router } from "react-router-dom"
import Grid from '@material-ui/core/Grid'
import {decorate} from './styles'
import Selector from '../components/selector/Selector'
import GraphLine from '../components/graphs/graphline'
import BarCharting from '../components/graphs/barchart'

class Home extends React.PureComponent {
  render() {
    const {classes} = this.props
    return (
      <Router>
        <div>
          <Grid container justify='center'>
            <Grid item xs={12} className={classes.itemOne}>
            </Grid>
          </Grid>
        <Selector />
        <div className="container">
          <div className="row">
            <div className="col">
              <h2>Tradable (actual) and non-tradable(predicted) certified energy over time</h2>
              <br />
              <GraphLine />
            </div>
            <div className="col">
              <h2>Accumulated tradable (actual) and non-tradable(predicted) certified energy</h2>
              <br />
              <BarCharting />
            </div>
          </div>
        </div>
        </div>
      </Router>
    )
}
}

export default decorate(Home)
