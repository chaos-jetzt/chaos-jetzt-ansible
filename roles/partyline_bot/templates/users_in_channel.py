#!/usr/bin/env python
# -*- coding: utf-8 #
from __future__ import print_function
from mastodon import Mastodon
import Ice, sys
import time

mastodon = Mastodon(
    access_token = '{{ partyline42_at_chaossocial_access_token }}',
    api_base_url = 'https://chaos.social'
)

#Path to Murmur.ice
iceslice = "/usr/share/slice/Murmur.ice"

# Includepath for Ice, this is default for Debian
iceincludepath = "/usr/share/Ice/slice"

# Murmur-Port (not needed to work, only for display purposes)
serverport = 64738

# Host of the Ice service; most probably this is 127.0.0.1
icehost = "127.0.0.1"

# Port where ice listen
iceport = 6502

# Ice Password to get read access.
# If there is no such var in your murmur.ini, this can have any value.
# You can use the values of icesecret, icesecretread or icesecretwrite in your murmur.ini
icesecret = "secret"

# MessageSizeMax; increase this value, if you get a MemoryLimitException.
# Also check this value in murmur.ini of your Mumble-Server.
# This value is being interpreted in kibiBytes.
messagesizemax = "65535"

Ice.loadSlice("--all -I%s %s" % (iceincludepath, iceslice))

props = Ice.createProperties([])
props.setProperty("Ice.MessageSizeMax", str(messagesizemax))
props.setProperty("Ice.ImplicitContext", "Shared")
props.setProperty("Ice.Default.EncodingVersion", "1.0")
id = Ice.InitializationData()
id.properties = props

ice = Ice.initialize(id)
ice.getImplicitContext().put("secret", icesecret)

import Murmur

try:
  meta = Murmur.MetaPrx.checkedCast(ice.stringToProxy("Meta:tcp -h %s -p %s" % (icehost, iceport)))
except Ice.ConnectionRefusedException:
  print('Could not connect to Murmur via Ice. Please check ')
  ice.shutdown()
  sys.exit(1)

try:
  server=meta.getServer(1)
except Murmur.InvalidSecretException:
  print('Given icesecreatread password is wrong.')
  ice.shutdown()
  sys.exit(1)

has_users = False
old_has_users = False

while True:
    onlineusers = server.getUsers()
    channels = server.getChannels()

    channelname = "partyline42"

    has_users = False

    for channel in channels.values():
        if channel.name == channelname:
            for user in onlineusers.values():
                if user.channel == channel.id:
                        has_users = True

    if has_users != old_has_users:
        if has_users:
            mastodon.status_post("There are people in the #Partyline42\nGo join them!", visibility="unlisted")
        else:
            mastodon.status_post("There is noone in the #Partyline42 :(", visibility="unlisted")

    old_has_users = has_users

    time.sleep(10)

