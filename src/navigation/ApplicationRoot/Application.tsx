import type { RootStackParamList } from '@/navigation/types';

import { NavigationContainer, useNavigationContainerRef } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { SafeAreaProvider } from 'react-native-safe-area-context';
import BootSplash from 'react-native-bootsplash';

import { useTheme } from '@/theme';
import { Paths } from '@/navigation/paths';

import { Startup } from '@/screens';
import UnAuthenticatedNavigator from '../UnAuthNav/UnAuthNav';
import AuthenticatedNavigator from '../AuthNav/AuthNav';

const Stack = createNativeStackNavigator<RootStackParamList>();

function ApplicationNavigator() {
  const { variant } = useTheme();
  const navigationRef = useNavigationContainerRef();

  return (
    <SafeAreaProvider>
      <NavigationContainer onReady={() => {
        BootSplash.hide()
          .then(() => {

          })
          .catch(() => {
            'Error while hiding bootsplash';
          });

      }} ref={navigationRef}
      >
        <Stack.Navigator key={variant} screenOptions={{
          animation: 'fade',
          animationDuration: 0.01,
          gestureEnabled: true,
          headerShown: false,
        }}>
          <Stack.Screen component={Startup} name={Paths.Startup} />
          <Stack.Screen component={UnAuthenticatedNavigator} name={Paths.UnAuthenticated} />
          <Stack.Screen component={AuthenticatedNavigator} name={Paths.Authenticated} />
        </Stack.Navigator>
      </NavigationContainer>
    </SafeAreaProvider>
  );
}

export default ApplicationNavigator;
