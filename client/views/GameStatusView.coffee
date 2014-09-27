class window.GameStatusView extends Backbone.View

  className: 'game-status'

  template: _.template '<%= status %>'


  initialize: ->
    @model.on 'change', => @render()
    @render()

  render: ->
    @$el.html ''
    @$el.html @template @model.attributes
    # We need to add a class to display color of status
