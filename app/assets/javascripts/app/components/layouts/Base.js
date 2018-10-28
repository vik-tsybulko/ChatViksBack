import React, { Component } from "react";
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';
import { Route, Link, Switch } from 'react-router-dom'
import {
  indigo500,
  indigo700,
  amber500,
  grey400,
  grey100,
  grey500,
  darkBlack,
  white,
  grey300,
  fullBlack
} from 'material-ui/styles/colors';
import { fade } from 'material-ui/utils/colorManipulator';
import { getMuiTheme } from 'material-ui/styles';
import { Snackbar } from 'material-ui';
import { connect } from 'react-redux';
import { snackBarStyle } from '../common/styles';
import { alertMessage } from '../../actions/app';
import HomePage from '../layouts'
import Overview from '../pages/dashboard/Overview'

const muiTheme = getMuiTheme({
  palette: {
    primary1Color: indigo500,
    primary2Color: indigo700,
    primary3Color: grey400,
    accent1Color: amber500,
    accent2Color: grey100,
    accent3Color: grey500,
    textColor: darkBlack,
    alternateTextColor: white,
    canvasColor: white,
    borderColor: grey300,
    disabledColor: fade(darkBlack, 0.3),
    pickerHeaderColor: indigo500,
    clockCircleColor: fade(darkBlack, 0.07),
    shadowColor: fullBlack,
  },
});

class Base extends Component {

  componentWillReceiveProps(nextProps) {
    const {dispatch} = this.props;
    const { alert_message } = nextProps;
    if (alert_message != '') setTimeout(() => dispatch(alertMessage('', 'success')), 4000)
  }

  render() {
    const { alert_message, alert_type } = this.props;

    return (
      <MuiThemeProvider muiTheme={muiTheme}>
      <div>
        <Switch>
        <Route exact path='/' component={HomePage}/>
        </Switch>
        SUKA2
      <Snackbar
    open={!!alert_message}
    message={alert_message}
    autoHideDuration={4000}
    bodyStyle={snackBarStyle[alert_type]}
    />
  </div>
    </MuiThemeProvider>
  );
  }

}
const mapStateToProps = (state) => {
  const { alert_message, alert_type } = state.main
  return {
    alert_message,
    alert_type
  }
}

export default connect(mapStateToProps)(Base)
