class window.HandView extends Backbone.View

  className: 'hand'

  #todo: switch to mustache
  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'add remove change', =>
      @render()
      if !@collection.isDealer
        @collection.checkPlayerHand()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    console.log @collection.isDealer
    if !@collection.isDealer or @collection.stood
      @$('.score').text @collection.getBestScore()
    # else
    #   @$('.score').text ' '

