@Product = React.createClass

  getInitialState: ->
    edit: false

  handleToggle: (e) ->
    e.preventDefault()
    @setState edit: !@state.edit

  handleDelete: (e) ->
    e.preventDefault()
    # yeah... jQuery doesn't have a $.delete shortcut method
    $.ajax
      method: 'DELETE'
      url: "/products/#{ @props.product.id }"
      dataType: 'JSON'
      success: () =>
        @props.handleDeleteProduct @props.product

  handleEdit: (e) ->
    e.preventDefault()
    data =
      title: React.findDOMNode(@refs.title).value
      description: React.findDOMNode(@refs.description).value
    # jQuery doesn't have a $.put shortcut method either
    $.ajax
      method: 'PUT'
      url: "/products/#{ @props.product.id }"
      dataType: 'JSON'
      data:
        product: data
      success: (data) =>
        @setState edit: false
        @props.handleUpdateProduct @props.product, data

  productForm: ->
    React.DOM.tr null,
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.product.title
          ref: 'title'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.product.description
          ref: 'description'
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-default'
          onClick: @handleEdit
          'Update'
        React.DOM.a
          className: 'btn btn-danger'
          onClick: @handleToggle
          'Cancel'

  productRow: ->
    React.DOM.tr null,
      React.DOM.td null, @props.product.title
      React.DOM.td null, @props.product.description
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-default'
          onClick: @handleToggle
          'Edit'
        React.DOM.a
          className: 'btn btn-danger'
          onClick: @handleDelete
          'Delete'

  render: ->
    if @state.edit
      @productForm()
    else
      @productRow()
