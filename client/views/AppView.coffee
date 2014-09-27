class window.AppView extends Backbone.View

  className: 'app'

  template: _.template '
    <div class="game-status-container"></div>
    <div class="dealer-hand-container"></div>
    <div class="player-hand-container"></div>
    <button class="hit-button btn btn-default">Hit</button> <button class="stand-button btn btn-default">Stand</button>
    <button class="new-game-button btn btn-primary">New Game?</button>
  '

  events:
    "click .hit-button": ->
      #if @model.get 'currentTurn' == 'player'
      @model.get('playerHand').hit()
    "click .stand-button": ->
      @lockButtons()
      @model.get('playerHand').stand()
      @model.get('dealerHand').stand()
    'click .new-game-button': ->
      @model.resetAttr()
      @render()

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
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
