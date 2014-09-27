class window.GameStatusView extends Backbone.View

  className: 'game-status alert'

  template: _.template '<%= status %>'


  initialize: ->
    @model.on 'change', =>
      @render()
    @render()

  render: ->
    @$el.html ''
    @$el.html @template @model.attributes
    if @model.attributes.status is 'You Win!'
      @$el.addClass 'alert-success'
    else if @model.attributes.status is 'You Lose!'
      @$el.addClass 'alert-danger'
    else if @model.attributes.status is 'You Tied!'
      @$el.addClass 'alert-warning'
