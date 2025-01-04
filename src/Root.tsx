import { GestureHandlerRootView } from 'react-native-gesture-handler';

import { ThemeProvider } from '@/theme';
import ApplicationNavigator from '@/navigation/ApplicationRoot/Application';

import '@/translations';

import { BottomSheetModalProvider } from '@gorhom/bottom-sheet';
import React from 'react';
import { PaperProvider } from 'react-native-paper';
import { PersistGate } from 'redux-persist/lib/integration/react';
import { Provider } from 'react-redux';
import {persistor, storage, store} from '@/store';

/**
 * @author Nitesh Raj Khanal
 * @function @Root
 * @returns {React.JSX.Element}
 */
const Root = (): React.JSX.Element => {
  return (
    <GestureHandlerRootView style={{ flex: 1 }}>
      <Provider store={store}>
        <PersistGate loading={null} persistor={persistor}>
          <BottomSheetModalProvider>
            <PaperProvider
              settings={{
                rippleEffectEnabled: true,
              }}
            >
              <ThemeProvider storage={storage}>
                <ApplicationNavigator />
              </ThemeProvider>
            </PaperProvider>
          </BottomSheetModalProvider>
        </PersistGate>
      </Provider>
    </GestureHandlerRootView>
  );
};

export default React.memo(Root);
