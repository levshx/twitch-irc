import twitch_irc, strutils
var client = newIrc("irc.freenode.net", nick="TestBot1234",
                 joinChans = @["#nim-offtopic"])
client.connect()
while true:
  var event: IrcEvent
  if client.poll(event):
    case event.typ
    of EvConnected:
      discard
    of EvDisconnected, EvTimeout:
      break
    of EvMsg:
      if event.cmd == MPrivMsg:
        var msg = event.params[event.params.high]
        if msg == "!test": client.privmsg(event.origin, "hello")
        if msg == "!lag":
          client.privmsg(event.origin, formatFloat(client.getLag))
        if msg == "!excessFlood":
          for i in 0..10:
            client.privmsg(event.origin, "TEST" & $i)
      
      echo(event.raw)
