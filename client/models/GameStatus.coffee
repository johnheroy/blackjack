class window.GameStatus extends Backbone.Model

  defaults:
    status: ''

  gameWon: ->
    @set 'status', 'You Win!'

  gameLost: ->
    @set 'status', 'You Lose!'

  gameTied: ->
    @set 'status', 'You Tied!'
