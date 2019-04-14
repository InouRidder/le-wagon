import withStyles from '@material-ui/core/styles/withStyles'

const styles = (theme) => ({
    itemOne: {
       backgroundColor: '#00aeef',
       height: 45,
    },
})

export const decorate = withStyles(styles)