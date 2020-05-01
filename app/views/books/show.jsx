import React from 'react'
import {mapStateToProps, mapDispatchToProps} from '@jho406/breezy'
import {connect} from 'react-redux'
import BaseScreen from 'components/BaseScreen'
import Layout from 'components/Layout'
import * as applicationActionCreators from 'javascript/packs/action_creators'

class BooksShow extends BaseScreen {
  addToCart = () => {
    const body = JSON.stringify({
      book_id: this.props.bookId
    })

    this.remote('/line_items?bzq=data.header.cart', {method: 'POST', body})
  }

  render () {
    const {
      title,
      price,
      form,
      image,
      description
    } = this.props

    return (
      <Layout {...this.props}>
        <h1 className="page-title">{title}</h1>
          <section className="book">
          <div dangerouslySetInnerHTML={{__html: image}}/>
          <article
            className="book__content"
            dangerouslySetInnerHTML={{__html: description}}
          />
          <div className="book__actions">
            <p>{ price }</p>
            <button onClick={this.addToCart} className="button button--primary">
              Add to Cart
            </button>
          </div>
        </section>
      </Layout>
    )
  }
}

export default connect(
  mapStateToProps,
  {...mapDispatchToProps, ...applicationActionCreators}
)(BooksShow)

