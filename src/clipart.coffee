# Description:
#   Returns clip art images from openclipart.org API.
#
# Commands:
#   hubot clipart me <query> - Queries openclipart for <query> and returns a random result.
#   Aliases:
#     hubot clipart <query>
#     hubot clip me <query>
#     hubot clip <query>
#
# Author:
#   Original - desmondmorris
#   Improved by Dylan Davidson

module.exports = (robot) ->
  robot.respond /(?: clip|clipart)(?: me)? (.*)/i, (msg) ->
    clipartMe msg, (url) ->
      msg.send encodeURI(url)

clipartMe = (msg, cb) ->

  q = query: msg.match[1], amount: 5, sort: 'downloads'

  msg.http('https://openclipart.org/search/json/')
    .query(q)
    .get() (err, res, body) ->
      data = JSON.parse(body)
      images = data.payload
      if images?.length > 0
        image  = msg.random images
        cb "#{image.svg.png_full_lossy}"
