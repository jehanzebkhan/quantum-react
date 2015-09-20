@ProductForm = React.createClass
  getInitialState: ->
    title: ''
    description: ''
  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value
  valid: ->
    @state.title && @state.description
  handleSubmit: (e) ->
    e.preventDefault()
    $.post '', { product: @state }, (data) =>
      @props.handleNewProduct data
      @setState @getInitialState()
    , 'JSON'
  render: ->
    React.DOM.form
      className: 'form'
      onSubmit: @handleSubmit
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Title'
          name: 'title'
          value: @state.title
          onChange: @handleChange
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Description'
          name: 'description'
          value: @state.description
          onChange: @handleChange
      React.DOM.button
        type: 'submit'
        className: 'btn btn-primary'
        disabled: !@valid()
        'Create Product'
