import React, {Component} from "react";
import {AppBar, Drawer, IconButton, Menu, MenuItem, Popover, FlatButton} from 'material-ui';
import {MapSettingsIcon,AreasIcon,HazardHistoriesIcon,DashboardIcon, LogoutIcon, EmailSettingsIcon, EmployersIcon, AdminsIcon, EmployeesIcon, AchievementsIcon, CompaniesIcon, TestsIcon, DepartmentsIcon, QuestionsIcon, OptionsIcon, EmergencyIcon, HazardIcon, SolosIcon} from '../common/icons';
import {connect} from 'react-redux';
import {ActionSettingsPower,ActionOpenInNew, HardwareSecurity, ContentContentPaste, NavigationArrowDropRight, SocialGroup,ActionSettings, ActionSettingsApplications, ActionLanguage, ContentReport, ActionQuestionAnswer, ActionReportProblem} from 'material-ui/svg-icons'
// import {loadCountries, loadCurrentUser, loadSettings, selectLanguage} from "../../actions/content";
import PropTypes from "prop-types";
import Overview from "../pages/dashboard/Overview";
import { Route, Link, Switch } from 'react-router-dom'
// import {check as getCurrentUser} from "../../services/sessions";


class HomePage extends Component {
  state = { open: false };

  handleToggle = () => this.setState({open: !this.state.open});


  componentDidMount(){
  }

  render() {
    console.log(this.props)
    return (
      <div className="dashboard-page">
        <Link to={`${this.props.match.path}u`}>sdhjsfdh</Link>
        <Switch>
        <Route path={`${this.props.match.path}u`} component={Overview}/>
        </Switch>
        hh
      </div>
    );
  }

}

HomePage.contextTypes = {
  muiTheme: PropTypes.object.isRequired
};

const mapStateToProps = (state) => {
  return {
    language: state.main.language,
  }
};

// const mapDispatchToProps = (dispatch) => {
//   return {
//     onLoadCountries(countries){
//       dispatch(loadCountries(countries))
//     },
//     onLoadCurrentUser(currentUser){
//       dispatch(loadCurrentUser(currentUser))
//     },
//     onLoadSettings(settings){
//       dispatch(loadSettings(settings))
//     },
//     onSelectLanguage(language){
//       dispatch(selectLanguage(language))
//     }
//   }
// };
export default connect(mapStateToProps)(HomePage);
