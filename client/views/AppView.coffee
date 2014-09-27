class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="game-status-container"></div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": ->
      #if @model.get 'currentTurn' == 'player'
      @model.get('playerHand').hit()
    "click .stand-button": ->
      @lockButtons()
      @model.get('playerHand').stand()
      @model.get('dealerHand').stand()

  initialize: ->
    @render()
    @listenTo(@model.get('gameStatus'), 'change:status', @lockButtons)

  lockButtons: ->
    $('.hit-button').attr 'disabled', true
    $('.stand-button').attr 'disabled', true

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.game-status-container').html new GameStatusView(model: @model.get 'gameStatus').el
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
