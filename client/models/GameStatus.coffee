class window.GameStatus extends Backbone.Model

  defaults:
    status: ''

  gameWon: ->
    @status.set 'You Win!'

  gameLost: ->
    @status.set 'You Lost!'
