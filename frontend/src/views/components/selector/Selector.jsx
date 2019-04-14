import React from 'react'
import ReactDOM from 'react-dom'
import InputLabel from '@material-ui/core/InputLabel'
import MenuItem from '@material-ui/core/MenuItem'
import FormControl from '@material-ui/core/FormControl'
import Select from '@material-ui/core/Select'
import Paper from '@material-ui/core/Paper'
// import Grid from '@material-ui/core/Grid'
import {decorate} from './styles'

class Selector extends React.Component {
  state = {
    age: '',
    name: 'hai',
    labelWidth: 0,
  };

  componentDidMount() {
    this.setState({
      //labelWidth: ReactDOM.findDOMNode(this.InputLabelRef).offsetWidth,
    });
  }

  handleChange = event => {
    this.setState({ [event.target.name]: event.target.value })
  };

  render() {
    const { classes } = this.props

    return (
      <Paper elevation={1} className={classes.paper}>
        <form className={classes.root} autoComplete="off">
          <FormControl className={classes.formControl}>
            <InputLabel htmlFor="country">Land</InputLabel>
            <Select
              value={this.state.country}
              onChange={this.handleChange}
              inputProps={{
                name: 'country',
                id: 'country',
              }}
            >
              {countries.map(country =>
                <MenuItem value={country}>
                  {country}
                </MenuItem>
              )}
            </Select>
          </FormControl>
          <FormControl className={classes.formControl}>
            <InputLabel htmlFor="city">Stad</InputLabel>
            <Select
              value={this.state.city}
              onChange={this.handleChange}
              inputProps={{
                name: 'city',
                id: 'city',
              }}
            >
              {cities.map(city => 
                <MenuItem value={city}>{city}</MenuItem>
              )}
            </Select>
          </FormControl>
          <FormControl className={classes.formControl}>
            <InputLabel htmlFor="neighbourhood">Buurt</InputLabel>
            <Select
              value={this.state.neighbourhood}
              onChange={this.handleChange}
              inputProps={{
                name: 'neighbourhood',
                id: 'neighbourhood',
              }}
            >
              {neighbourhoods.map(neighbourhood =>
                <MenuItem value={neighbourhood}>
                  {neighbourhood}
                </MenuItem>
              )}
            </Select>
          </FormControl>
        </form>
      </Paper>
    )
  }
}

const countries = [
  'België',
  'Duitsland',
  'Frankrijk',
  'Nederland',
  'Verenigd Koninkrijk',
  'Bulgarije',
  'Zuid-Cyprus',
  'Denemarken',
  'Estland',
  'Finland',
  'Griekenland',
  'Hongarije',
  'Ierland',
  'Italië',
  'Kroatië',
  'Letland',
  'Litouwen',
  'Luxemburg',
  'Malta',
  'Oostenrijk',
  'Polen',
  'Portugal',
  'Roemenië',
  'Slovenië',
  'Slowakije',
  'Spanje',
  'Tsjechië',
  'Zweden',
]

const cities = [
  'Amsterdam',
  'Rotterdam',
  'Den Haag',
  'Utrecht', 
  'Eindhoven', 
  'Groningen', 
  'Tilburg', 
  'Almere', 
  'Breda', 
  'Nijmegen', 
  'Apeldoorn', 
  'Haarlem', 
  'Arnhem', 
  'Enschede', 
  'Amersfoort', 
  'Zaanstad', 
  "'s-Hertogenbosch", 
  'Haarlemmermeer', 
  'Zwolle',
  'Zoetermeer',
  'Leiden', 
  'Leeuwarden', 
  'Maastricht', 
  'Dordrecht', 
  'Ede', 
  'Alphen aan den Rijn', 
  'Alkmaar', 
  'Westland', 
  'Emmen', 
  'Delft', 
  'Venlo'
]

const neighbourhoods = [
  'Binnenstad',
  'Schilders- en Zeeheldenwijk',
  'Oranjewijk',
  'Korrewegwijk',
  'Oosterparkwijk',
  'Oosterpoortwijk',
  'Herewegwijk en Helpman',
  'Stadsparkwijk',
  'Hoogkerk',
  'Noorddijk',
]

export default decorate(Selector)