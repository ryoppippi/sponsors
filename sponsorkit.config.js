import { defineConfig, tierPresets } from 'sponsorkit'

export default defineConfig({
  github: {
    login: 'ryoppippi',
    type: 'user',
  },
  outputDir: import.meta.dirname,
  prorateOnetime: true,
  formats: ['svg'],
  width: 800,
  name: 'sponsors'
})
