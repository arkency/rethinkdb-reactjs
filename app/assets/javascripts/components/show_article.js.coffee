DOM = React.DOM

window.ShowArticle = React.createClass
  name: "ShowArticle"
  render: ->
    DOM.div null,
      DOM.p null,
        DOM.strong null, "Title: "
        @props.title
      DOM.p null,
        DOM.strong null, "Text: "
        @props.text
