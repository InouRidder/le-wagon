import * as React from 'react'
import AppBar from '@material-ui/core/AppBar'
import Toolbar from '@material-ui/core/Toolbar'
import { Link as RouterLink } from 'react-router-dom'
import Link from '@material-ui/core/Link'
import Grid from '@material-ui/core/Grid'
import Typography from '@material-ui/core/Typography'
import {decorate} from './styles'

class Navbar extends React.PureComponent {
    render() {
        const { classes } = this.props
        return (
            <div className={classes.root}>
                <AppBar className={classes.appBar}>
                    <Toolbar>
                        <Grid container justify='center' spacing={8} className={classes.container}>
                            <Grid item xs={3}>
                                <a href='http://www.certiq.nl' target='_blank' rel="noopener noreferrer" className={classes.logoLink}>
                                    <img alt="Logo Certiq" src="/certiq-icon.png" className={classes.logo} />
                                </a>
                            </Grid>
                            <Grid item xs={4} className={classes.item}>
                                <Typography variant="subtitle" gutterBottom className={classes.welcome}>
                                    Welkom Mark Hagoort
                                </Typography>
                            </Grid>
                            <Grid item xs={2} className={classes.item}>
                                <Link component={RouterLink} to={'/'} className={classes.menuButton}>
                                    Home
                                </Link>
                            </Grid>
                            <Grid item xs={2} className={classes.item}>
                                <Link component={RouterLink} to={'/certificates'} className={classes.menuButton}>
                                    Certificates
                                </Link>
                            </Grid>
                        </Grid>
                    </Toolbar>
                </AppBar>
            </div>
        )
    }
}

export default decorate(Navbar)