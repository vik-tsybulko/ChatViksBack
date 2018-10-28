import React, {Component} from 'react'
import ReactDOM from 'react-dom'
import { Provider } from 'react-redux'
import { HashRouter as Router, Route, Link } from 'react-router-dom'
import { store } from './create_store'

// import BaseLayout from './components/layouts/Base'
import injectTapEventPlugin from 'react-tap-event-plugin'


class BaseLayout extends Component {
  render(){
    return(
      <div>
        BaseLayout
        <Link to='/'>home</Link>
        <Link to='/over'>over</Link>
        <Route exact path='/' component={Home}/>
        <Route path='/over' component={Over}/>
      </div>
    )
  }
}
class Home extends Component {
  render(){
    return(
      <div>HOME</div>
    )
  }
}
class Over extends Component {
  render(){
    return(
      <div>OvER</div>
    )
  }
}


window.onload = function () {
  ReactDOM.render(
    <Provider store={store}>
      <Router>
        <BaseLayout/>
      </Router>
    </Provider>,
    document.getElementById('content')
  );
}
