apiKey = null
sessionId = null
token = null

initializeSession = ->
  session = OT.initSession(apiKey, sessionId)

  session.on('streamCreated', (event) ->
    session.subscribe(event.stream, 'subscriber', {
        insertMode: 'append',
        width: '100%',
        height: '100%'
    })
  )

  session.on('sessionDisconnected', (event) ->
    console.log('You were disconnected from the session.', event.reason)
  )

  session.connect(token, (error)->
    if (!error)
      publisher = OT.initPublisher('publisher', {
        insertMode: 'append',
        width: '100%',
        height: '100%'
      })

      session.publish(publisher)
    else
      console.log('There was an error connecting to the session: ', error.code, error.message)
  )

$( document ).ready ->
  id = location.href.split('/')[location.href.split('/').length-1]

  $.get("/open_tok_sessions/#{id}.json", (res)->
    apiKey = res.apiKey;
    sessionId = res.sessionId;
    token = res.token;

    initializeSession();
  )


