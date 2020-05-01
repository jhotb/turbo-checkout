import React from 'react'
import {combineReducers, createStore, applyMiddleware, compose} from 'redux'
import reduceReducers from 'reduce-reducers'
import thunk from 'redux-thunk'
import { Provider } from 'react-redux'
import { render } from 'react-dom'
import { createBrowserHistory } from 'history'
import Breezy from '@jho406/breezy'
import BooksIndex from 'views/books/index'
import BooksShow from 'views/books/show'
import Nav from '@jho406/breezy/dist/NavComponent'
import applicationReducer from './reducer'


// Mapping between your props template to Component
// e.g {'posts/new': PostNew}
const identifierToComponentMapping = {
  'books/show': BooksShow,
  'books/index': BooksIndex,
}

const history = createBrowserHistory({})
const initialPage = window.BREEZY_INITIAL_PAGE_STATE
const baseUrl = ''

//The Nav is pretty bare bones
//Feel free to replace the implementation
const {reducer, initialState, initialPageKey, connect} = Breezy.start({
  window,
  initialPage,
  baseUrl,
  history
})

const composeEnhancers = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose

const {
  breezy: breezyReducer,
  pages: pagesReducer,
} = reducer

const store = createStore(
  combineReducers({
    breezy: breezyReducer,
    pages: reduceReducers(pagesReducer, applicationReducer),
  }),
  initialState,
  composeEnhancers(applyMiddleware(thunk))
)

connect(store)

class App extends React.Component {
  render() {
    return <Provider store={store}>
      <Nav
        store={store}
        mapping={this.props.mapping}
        history={history}
        initialPageKey={initialPageKey}
      />
    </Provider>
  }
}

document.addEventListener("DOMContentLoaded", function() {
  render(<App mapping={identifierToComponentMapping}/>, document.getElementById('app'))
})
