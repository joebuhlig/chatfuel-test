import { withPluginApi } from 'discourse/lib/plugin-api';

export default {
  name: 'chatfuel',
  initialize(container){

    withPluginApi('0.8.12', (api) => {
    })
  }
}