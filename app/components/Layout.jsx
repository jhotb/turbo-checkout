import React, {useState, useEffect} from 'react'
import OrderTable from 'components/OrderTable'

export default class extends React.Component {
  render() {
    const {
      header: {
        booksPath,
        logoSvgTag,
        cartSvgTag,
        cart,
      },
      flashes
    } = this.props

    return (
      <>
        <header className="header">
          <nav className="navigation">
            <a href={booksPath} className="navigation__logo"
              dangerouslySetInnerHTML={{__html:logoSvgTag }}
            />

            <details id="order" className="navigation__cart cart">
              <summary
                dangerouslySetInnerHTML={{__html: cartSvgTag}}
              />

              <div className="cart__content">
                <OrderTable {...cart} />
              </div>
            </details>
          </nav>
        </header>

        <main>
          <div className="flashes">
            { flashes.map((flash) => (
              <div className={`flash flash--${flash.key}`}>
                {flash.value}
              </div>
            )) }
          </div>
          {this.props.children}
        </main>
      </>
    )
  }
}



