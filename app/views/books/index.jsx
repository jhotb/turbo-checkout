import React from 'react'
import {mapStateToProps, mapDispatchToProps} from '@jho406/breezy'
import {connect} from 'react-redux'
import BaseScreen from 'components/BaseScreen'
import Layout from 'components/Layout'
import * as applicationActionCreators from 'javascript/packs/action_creators'

class BooksIndex extends BaseScreen {
  render () {
    const {
      books,
      title,
    } = this.props

    return (
      <Layout {...this.props}>
        <h1 className="page-title">{title}</h1>
        <ul className="collection">
          {books.map(({id, title, path, image}) => (
            <li className="collection__item" key={id}>
              <a href={path}>
                <div dangerouslySetInnerHTML={{__html: image}}/>
                <h2>{ title }</h2>
              </a>
            </li>
          ))}
        </ul>
      </Layout>
    )
  }
}

export default connect(
  mapStateToProps,
  {...mapDispatchToProps, ...applicationActionCreators}
)(BooksIndex)
