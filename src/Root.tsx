import { GestureHandlerRootView } from 'react-native-gesture-handler';
import { MMKV } from 'react-native-mmkv';

import { ThemeProvider } from '@/theme';
import ApplicationNavigator from '@/navigation/ApplicationRoot/Application';

import '@/translations';
import React from 'react';
import { PaperProvider } from 'react-native-paper';

export const storage = new MMKV();

/**
 * @author Nitesh Raj Khanal
 * @function @Root
 * @returns {JSX.Element}
 */
const Root = (): JSX.Element => {
  return (
    <GestureHandlerRootView>
      <PaperProvider settings={{
        rippleEffectEnabled: true
      }}>
        <ThemeProvider storage={storage}>
          <ApplicationNavigator />
        </ThemeProvider>
      </PaperProvider>
    </GestureHandlerRootView>
  );
}

export default React.memo(Root);
