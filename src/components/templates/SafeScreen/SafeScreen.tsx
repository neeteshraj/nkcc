import type { PropsWithChildren } from 'react';
import type { SafeAreaViewProps } from 'react-native-safe-area-context';

import { StatusBar } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';

import { useTheme } from '@/theme';

import { DefaultError } from '@/components/molecules';
import { ErrorBoundary } from '@/components/organisms';
import { AssetByVariant, ButtonVariant } from '@/components/atoms';
import { useNavigation, useRoute } from '@react-navigation/native';
import { Paths } from '@/navigation/paths';

type Props = PropsWithChildren<
  {
    isError?: boolean;
    onResetError?: () => void;
  } & Omit<SafeAreaViewProps, 'mode'>
>;

function SafeScreen({
  children = undefined,
  isError = false,
  onResetError = undefined,
  style,
  ...props
}: Props) {
  const { layout, navigationTheme, variant } = useTheme();
  const route = useRoute();

  const navigation = useNavigation()

  const backAction = (screenName: string) => {
    if (screenName === Paths.CreateAccount) {
      navigation.goBack()
    }
  }

  return (
    <SafeAreaView {...props} mode="padding" style={[layout.flex_1, style]}>
      <StatusBar
        backgroundColor={navigationTheme.colors.background}
        barStyle={variant === 'dark' ? 'light-content' : 'light-content'}
      />
      <ErrorBoundary onReset={onResetError}>
        {route.name === Paths.CreateAccount && (
          <ButtonVariant hitSlop={{ bottom: 20, left: 20, right: 20, top: 20 }} onPress={backAction.bind(null, route.name)} style={[layout.height24, layout.width24]}>
            <AssetByVariant
              extension='png'
              path='arrow_back'
              style={[layout.fullHeight, layout.fullWidth]}
            />
          </ButtonVariant>
        )}
        {isError ? <DefaultError onReset={onResetError} /> : children}
      </ErrorBoundary>
    </SafeAreaView>
  );
}

export default SafeScreen;
