class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop()).last()
    if @isDealer
      @checkDealerHand()
    else
      @checkPlayerHand()
    # if @getBestScore > 21 and !@isDealer then this.trigger

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.

    cardValues = @map (card) ->
      card.get 'value'

    results = [0]

    for cardValue in cardValues
      if cardValue is 1
        copy = results.splice()
        results = results.map (val) ->
          val + 10
        copy = copy.map (val) ->
          val + 1
        result = result.concat copy
      else
        results = results.map (val) ->
          val + cardValue

    results


    # hasAce = @reduce (memo, card) ->
    #   memo or card.get('value') is 1
    # , false
    # score = @reduce (score, card) ->
    #   score + if card.get 'revealed' then card.get 'value' else 0
    # , 0
    # if hasAce then [score, score + 10] else [score]

  getBestScore: ->
    sortedScores = @scores().sort()
    bestScore = sortedScores[0]
    for score in sortedScores
      if score > bestScore and score <= 21
        bestScore = score
    bestScore
