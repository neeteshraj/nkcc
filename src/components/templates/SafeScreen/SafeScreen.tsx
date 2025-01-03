import { type PropsWithChildren, useCallback } from 'react';
import type { SafeAreaViewProps } from 'react-native-safe-area-context';

import { Image, StatusBar, View } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';

import { useTheme } from '@/theme';

import { DefaultError } from '@/components/molecules';
import { ErrorBoundary } from '@/components/organisms';
import { AssetByVariant, ButtonVariant, TextByVariant } from '@/components/atoms';
import type { RouteProp} from '@react-navigation/native';
import { useFocusEffect, useNavigation, useRoute } from '@react-navigation/native';
import { Paths } from '@/navigation/paths';
import { useSelector } from '@/hooks';
import type { RootState } from '@/store';
import { useTranslation } from 'react-i18next';
import Animated, { useAnimatedStyle, useSharedValue, withTiming } from 'react-native-reanimated';
import type { RootScreenProps} from '@/navigation/types';
import { type RootStackParamList } from '@/navigation/types';

type Props = PropsWithChildren<
  {
    isError?: boolean;
    onResetError?: () => void;
  } & Omit<SafeAreaViewProps, 'mode'>
>;

const SafeScreen = <S extends keyof RootStackParamList>({
  children = undefined,
  isError = false,
  onResetError = undefined,
  style,
  ...props
}: Props) => {

  const { t } = useTranslation(["common"]);

  const { borders, components, layout, navigationTheme, variant } = useTheme();


  const route = useRoute<RouteProp<RootStackParamList, S>>();

  const navigation = useNavigation<RootScreenProps<S>['navigation']>();

  const user = useSelector((state: RootState) => state.user.user)

  const backAction = (screenName: string) => {
    if (screenName === Paths.CreateAccount) {
      navigation.goBack()
    }
  }

  const opacity = useSharedValue(0);
  const translateY = useSharedValue(-50);

  useFocusEffect(
    useCallback(() => {
      opacity.value = withTiming(1, { duration: 300 });
      translateY.value = withTiming(0, { duration: 300 });

      return () => {
        opacity.value = withTiming(0, { duration: 300 });
        translateY.value = withTiming(-50, { duration: 300 });
      };
    }, [opacity, translateY])
  )

  const animatedHeaderStyle = useAnimatedStyle(() => {
    return {
      opacity: opacity.value,
      transform: [{ translateY: translateY.value }],
    };
  });

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
        {route.name === Paths.Home && (
          <Animated.View style={[layout.row, layout.itemsCenter, layout.justifyBetween, animatedHeaderStyle]}>
            <View>
              <TextByVariant style={[components.interDescriptionWhite70]}>{t("common:welcomeBack")}</TextByVariant>
              <TextByVariant style={[components.interDescription24SemiBold]}>{user?.fullName.split(" ")[0]}</TextByVariant>
            </View>
            <ButtonVariant onPress={() => navigation.navigate(Paths.Profile)}>
              <Image source={{ uri: user?.profilePicture }} style={[layout.height50, layout.width50, borders.rounded_500]} />
            </ButtonVariant>
          </Animated.View>
        )}
        {isError ? <DefaultError onReset={onResetError} /> : children}
      </ErrorBoundary>
    </SafeAreaView>
  );
}

export default SafeScreen;
