import React from 'react'

export default class extends React.Component {
  render() {
    const {
      caption,
      title,
      quantity,
      price,
      lineItems,
      footer
    } = this.props

    return (
      <table>
        <caption>{ caption }</caption>
        <thead>
          <tr>
            <th>{ title }</th>
            <th>{ quantity }</th>
            <th>{ price }</th>
            <th></th>
          </tr>
        </thead>

        <tbody>
          {lineItems.map(({id, title, quantity, price, form}) => (
            <tr key={id}>
              <td> { title } </td>
              <td> { quantity } </td>
              <td> { price } </td>
              <td dangerouslySetInnerHTML={ {__html: form} } />
            </tr>
          ))}
          <tr>
            <td></td>
            <td></td>
            <td>{ footer }</td>
            <td></td>
          </tr>
        </tbody>
      </table>
    )
  }
}

