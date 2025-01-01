import { AppRegistry } from 'react-native';

import { name as appName } from './app.json';
import App from './src/Root';
import 'react-native-gesture-handler';

if (__DEV__) {
  import('@/reactotron.config');
}

AppRegistry.registerComponent(appName, () => App);
