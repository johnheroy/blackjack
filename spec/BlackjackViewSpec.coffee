assert = chai.assert

describe "initialize view", ->

  $appV = null

  beforeEach ->
    $appV = new AppView(model: new App()).$el

  it "should have two cards for player + dealer", ->
    assert.strictEqual $appV.find('.player-hand-container').find('.card').length, 2
    assert.strictEqual $appV.find('.dealer-hand-container').find('.card').length, 2

  it "should only have 1 dealer card revealed", ->
    assert.strictEqual $appV.find('.dealer-hand-container').find('.covered').length, 1

describe "hit", ->

  appV  = null
  hand  = null
  jack  = null
  queen = null
  ace   = null
  ace2  = null
  ace3  = null
  seven = null

  beforeEach ->
    appV  = new AppView(model: new App())
    jack  = new Card rank: 11, suit: 0
    queen = new Card rank: 12, suit: 0
    ace   = new Card rank: 1,  suit: 0
    ace2  = new Card rank: 1,  suit: 0
    ace3  = new Card rank: 1,  suit: 0
    seven = new Card rank: 7,  suit: 0
    hand  = appV.model.get 'playerHand'
    hand.remove hand.at 0
    hand.remove hand.at 0

  it "should show a new card on the player hand on hit", ->
    appV.$el.find('.hit-button').click()
    assert.strictEqual appV.$el.find('.player-hand-container').find('.card').length, 1

  it "should lose the game if you go above 21", ->
    hand.add jack
    hand.add queen
    hand.add seven
    console.log appV.$el.find('.game-status-container').html()
    assert.strictEqual appV.$el.find('.game-status').text(), 'You Lose!'


  it 'should show best player score with 1 ace', ->
    hand.add jack
    hand.add seven
    hand.add ace
    assert.strictEqual appV.$el.find('.player-hand-container').find('.score').text(), '18'

  it 'should show best player score with multiple aces', ->
    hand.add ace
    assert.strictEqual appV.$el.find('.player-hand-container').find('.score').text(), '11'
    hand.add ace2
    assert.strictEqual appV.$el.find('.player-hand-container').find('.score').text(), '12'
    hand.add seven
    assert.strictEqual appV.$el.find('.player-hand-container').find('.score').text(), '19'
    hand.add queen
    assert.strictEqual appV.$el.find('.player-hand-container').find('.score').text(), '19'
    hand.add ace3
    assert.strictEqual appV.$el.find('.player-hand-container').find('.score').text(), '20'


describe 'stand', ->

  appV  = null
  hand  = null
  jack  = null
  queen = null
  ace   = null
  seven = null
  dealerHand = null

  beforeEach ->
    appV  = new AppView(model: new App())
    jack  = new Card rank: 11, suit: 0
    queen = new Card rank: 12, suit: 0
    ace   = new Card rank: 1,  suit: 0
    seven = new Card rank: 7,  suit: 0
    three = new Card rank: 3,  suit: 0
    hand  = appV.model.get 'playerHand'
    hand.remove hand.at 0
    hand.remove hand.at 0
    hand.add new Card rank: 12, suit: 1
    hand.add new Card rank: 11, suit: 1
    dealerHand  = appV.model.get 'dealerHand'
    dealerHand.remove dealerHand.at 0
    dealerHand.remove dealerHand.at 0
    dealerHand.add jack.flip()
    dealerHand.add three

  it 'should reveal other dealer card when player stands', ->
    assert.strictEqual $appV.find('.dealer-hand-container').find('.covered').length, 1
    appV.$el.find('.stand-button').click()
    assert.strictEqual $appV.find('.dealer-hand-container').find('.covered').length, 0

  it 'should have dealer play hand when player stands', ->
    appV.$el.find('.stand-button').click()
    assert.strictEqual ($appV.find('.dealer-hand-container').find('.card').length > 2) , true

  xit 'dealer should hit until 17 or above', ->
    # todo
    appV.$el.find('.stand-button').click()


  it 'should not give player more cards if they hit after standing', ->
    appV.$el.find('.stand-button').click()
    appV.$el.find('.hit-button').click()
    appV.$el.find('.hit-button').click()
    appV.$el.find('.hit-button').click()
    assert.strictEqual $appV.find('.player-hand-container').find('.card').length, 2

  xit 'player can beat dealer after standing', ->
    appV.$el.find('.stand-button').click()

  xit 'player can lose to dealer after standing', ->
    appV.$el.find('.stand-button').click()

  xit 'should win immediately if you hit 21 exactly', ->
    hand.add jack
    hand.add queen
    hand.add ace
    assert.strictEqual appV.$el.find('.game-status').text(), 'You Win!'

