'use strict'

module.exports = async function (fastify) {
  fastify.get('/', async function (request, reply) {
    await reply.send({ hello: 'world' })
  })
}
