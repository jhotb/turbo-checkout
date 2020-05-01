import React, {useState, useEffect} from 'react'
import OrderTable from 'components/OrderTable'
import BaseScreen from 'components/BaseScreen'

const Alert = ({flash}) => {
   let [visibility, setVisibility] = useState(true);

  useEffect(() => {
    const timer = setTimeout(() => {
      setVisibility(false)
    }, 5000);
    return () => clearTimeout(timer);
   }, [])

  return(
    visibility && <div className={`flash flash--${flash.key}`}>
      {flash.value}
    </div>
  )
}

export default class extends BaseScreen {
  removeFromCart = (id) => {
    this.remote(`/line_items/${id}?bzq=data.header.cart`, {method: 'DELETE'})
  }

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
                <OrderTable {...cart} removeFromCart={this.removeFromCart} />
              </div>
            </details>
          </nav>
        </header>
        <main>
          <div className="flashes">
            { flashes.map((flash) => (
              <Alert flash={flash} key={flash.id}/>
            )) }
          </div>
          {this.props.children}
        </main>
      </>
    )
  }
}



