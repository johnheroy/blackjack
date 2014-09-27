#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @resetAttr()
  resetAttr: ->
    @set 'deck', deck = new Deck()
    @set 'gameStatus', new GameStatus()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on 'lost', =>
      @get('gameStatus').gameLost()
    @get('dealerHand').on 'gameFinished', =>
      pScore = @get('playerHand').getBestScore()
      dScore = @get('dealerHand').getBestScore()
      if pScore is 21 and dScore is 21
        @get('gameStatus').gameTied()
      else if  pScore >= dScore or dScore > 21
        @get('gameStatus').gameWon()
      else
        @get('gameStatus').gameLost()
