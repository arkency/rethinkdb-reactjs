#= require jquery
#= require jquery_ujs

#= require react
#= require react_ujs

#= require components
#= require_tree .

ShowArticleFactory = React.createFactory(ShowArticle)

$ ->
  $('[data-reactive]').each (_nop, element) ->
    reactivePath = $(element).attr('data-reactive')
    source = new EventSource(reactivePath);
    source.addEventListener 'message', (e) ->
      console.log(e.data)
      React.render(
        ShowArticleFactory(JSON.parse(e.data))
        element
      )

