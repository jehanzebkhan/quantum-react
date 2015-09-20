 @Products = React.createClass
    getInitialState: ->
          products: @props.data
    getDefaultProps: ->
      products: []
    addProduct: (product) ->
      products = @state.products.slice()
      products.push product
      @setState products: products
    deleteProduct: (product) ->
      index = @state.products.indexOf product
      products = React.addons.update(@state.products, { $splice: [[index, 1]] })
      @replaceState products: products
    updateProduct: (product, data) ->
      index = @state.products.indexOf product
      products = React.addons.update(@state.products, { $splice: [[index, 1, data]] })
      @replaceState products: products
    render: ->
      React.DOM.div
        className: 'products'
        React.DOM.h2
          className: 'title'
          'Products'
        React.createElement ProductForm, handleNewProduct: @addProduct
        React.DOM.hr null
        React.DOM.table
          className: 'table table-bordered'
          React.DOM.thead null,
            React.DOM.tr null,
              React.DOM.th null, 'Title'
              React.DOM.th null, 'Description'
              React.DOM.th null, 'Actions'
          React.DOM.tbody null,
            for product in @state.products
              React.createElement Product, key: product.id, product: product, handleDeleteProduct: @deleteProduct, handleUpdateProduct: @updateProduct
