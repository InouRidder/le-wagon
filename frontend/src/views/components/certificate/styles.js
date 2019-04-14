import withStyles from '@material-ui/core/styles/withStyles'


const styles = theme => ({
  root: {
    display: 'flex',
    flexWrap: 'wrap',
  },
  paper: {
    padding: 60,
    margin: '60px 200px',
  },
  formControl: {
    margin: theme.spacing.unit,
    minWidth: 250,
  },
  selectEmpty: {
    marginTop: theme.spacing.unit * 2,
  },
  title: {
    marginTop: 50,
  }
})

export const decorate = withStyles(styles)
