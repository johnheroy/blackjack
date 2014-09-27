class window.Hand extends Backbone.Collection

  model: Card

  defaults:
    stood: false

  events:
    'change'

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    if @isDealer or !@stood
      @add(@deck.pop()).last()

  stand: ->
    @stood = true
    if @isDealer
      @each (card) ->
        if !card.get 'revealed' then card.flip()
      @playDealerHand()

  playDealerHand: ->
    if @getBestScore() < 17
      setTimeout =>
        @hit()
        @playDealerHand()
      , 1000
    else
      @checkDealerHand()


  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    cardValues = @map (card) ->
      card.get 'value'

    results = [0]

    for cardValue in cardValues
      if cardValue is 1
        copy = results.slice()
        results = results.map (val) ->
          val + 11
        copy = copy.map (val) ->
          val + 1
        results = results.concat copy
      else
        results = results.map (val) ->
          val + cardValue
    results

  getBestScore: ->
    sortedScores = @scores().sort()
    bestScore = sortedScores[0]
    for score in sortedScores
      if score > bestScore and score <= 21
        bestScore = score
    bestScore

  checkPlayerHand: ->
    if @getBestScore() > 21
      @trigger 'lost'

  checkDealerHand: ->
    @trigger 'gameFinished'
