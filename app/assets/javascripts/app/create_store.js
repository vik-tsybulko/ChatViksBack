import { createStore, combineReducers } from 'redux'
import { routerReducer } from 'react-router-redux'
import main from './reducers/main'


const store = createStore(
  combineReducers({
    main,
    routing: routerReducer
  })
);

export { store }
