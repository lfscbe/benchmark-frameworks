import Fastify from 'fastify'
import os from 'os'

const {
  PORT: port,
  HOST: host,
  LOG_LEVEL: logLevel = 'info'
} = process.env
const hostName = os.hostname()

const app = Fastify({
  logger: { level: logLevel },
})

app.get('/', async (request, reply) => {
  return { hello: hostName }
})

/**
 * Run the server!
 */
const start = async () => {
  try {
    if (!port || ! host) throw new Error('Port and host must be defined in environment variables')
    await app.listen({ port, host })
  } catch (err) {
    app.log.error(err)
    process.exit(1)
  }
}

await start()