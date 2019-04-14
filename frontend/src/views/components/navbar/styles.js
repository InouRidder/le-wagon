import withStyles from '@material-ui/core/styles/withStyles'

const styles = (theme) => ({
  root: {
    flexGrow: 1,
    width: '100%',
  },
  appBar: {
    backgroundColor: '#fff'
  },
  logo: {
    height: '50px',
  },
  logoLink: {
    // paddingTop: theme.spacing.unit * 3,
    // paddingBottom: theme.spacing.unit * 3,
    // paddingLeft: theme.spacing.unit,
    // paddingRight: theme.spacing.unit * 2,
  },
  container: {
      margin: 0
  },
  item: {
      textAlign: 'center',
      verticalAlign: 'middle',
      padding: 0,
  },
  flex: {
    flex: 1,
  },
  menuButton: {
    color: '#002c76',
    display: 'inline-block',
    marginLeft: 10,
    marginTop: 10,
    fontFamily: 'verdana, arial, sans-serif',
    fontSize: 15,
    '&:hover': {
        color: '#00aeef',
        textDecoration: 'none',
    },
  },
})

export const decorate = withStyles(styles)
