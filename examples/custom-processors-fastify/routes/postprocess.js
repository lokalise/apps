'use strict'

module.exports = async function (fastify) {
  fastify.post('/postprocess', async function (request, reply) {
    if (!request.body) {
      return { error: 'Invalid request: Missing body' }
    }

    // Get the payload from the request:
    const payload = request.body

    // @todo: validation

    // @todo: introduce timeout

    // Iterate over the keys in the collection:
    for (const [keyId, keyValue] of Object.entries(payload.collection.keys)) {
      // Iterate over the translations in the key:
      for (const [lang, v] of Object.entries(keyValue.translations)) {
        // Process the value of the translation:
        payload.collection.keys[keyId].translations[lang].translation = v.translation.replace(
          'BANNED',
          '',
        )
      }
    }

    // @todo: validate processed values

    await reply.send(payload)
  })
}
