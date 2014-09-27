class window.CardView extends Backbone.View

  className: 'card'

  template: _.template '<img src="img/card_png/<%= fileName  %>.png">' #'<%= rankName %> of <%= suitName %>'

  initialize: ->
    @model.on 'change', => @render
    @render()

  render: ->
    @$el.children().detach().end().html
    @$el.html @template @model.fileName()#@model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'
