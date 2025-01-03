import type { BottomSheetDefaultBackdropProps } from '@gorhom/bottom-sheet/lib/typescript/components/bottomSheetBackdrop/types';
import type { StackNavigationProp } from '@react-navigation/stack';
import type { FC } from 'react';
import type { RootStackParamList } from '@/navigation/types';

import {
  BottomSheetBackdrop,
  BottomSheetModal,
  BottomSheetTextInput,
  BottomSheetView,
} from '@gorhom/bottom-sheet';
import { CommonActions, useNavigation } from '@react-navigation/native';
import React, { useCallback, useEffect, useMemo, useRef } from 'react';
import { useTranslation } from 'react-i18next';
import { View } from 'react-native';
import type { TextInput } from 'react-native-gesture-handler';

import { useTheme } from '@/theme';
import type { ApiError } from '@/hooks';
import { ApiErrorSchema, useLoginMutation } from '@/hooks';
import { Paths } from '@/navigation/paths';

import {
  AssetByVariant,
  ButtonVariant,
  TextByVariant,
} from '@/components/atoms';

import { heightPercentToDp } from '@/utilities';
import { generateRequestHeader } from '@/utilities/generateRequestHeader';
import { ActivityIndicator } from 'react-native-paper';
import { reduxStorage } from '@/store';
import { APP_SECRETS } from '@/secrets/secrets';

/**
 * @author Nitesh Raj Khanal
 * @function @Onboarding
 **/

const Onboarding: FC = () => {
  const { backgrounds, borders, colors, components, gutters, layout } =
    useTheme();

  const { t } = useTranslation(['onboarding']);

  const navigation =
    useNavigation<StackNavigationProp<RootStackParamList, Paths.Onboarding>>();

  const snapPoints = useMemo(
    () => [heightPercentToDp('27'), heightPercentToDp('27')],
    [],
  );

  const inputFieldRef = useRef<TextInput>(null);
  const bottomSheetModalRef = useRef<BottomSheetModal>(null);

  const [codeInBill, setCodeInBill] = React.useState<string>('');

  const [login, { data, error, isLoading, isSuccess, reset }] = useLoginMutation();

  const navigateAction = useCallback(
    async (pathName: string) => {
      if (pathName === Paths.QRScan) {
        bottomSheetModalRef.current?.dismiss();
        navigation.navigate(Paths.QRScan);
      } else if (pathName === Paths.CreateAccount) {
        const requestHeader = await generateRequestHeader()
        const requestData = {
          body: {
            billNumber: codeInBill,
            fcmToken: 'fcm-token',
          },
          requestHeader,
        };
        login(requestData);
      }
    },
    [navigation, bottomSheetModalRef, codeInBill, login],
  );

  useEffect(() => {
    const successAction = async () => {
      if (isSuccess) {
        bottomSheetModalRef.current?.dismiss();

        try {
          await reduxStorage.setItem(APP_SECRETS.ACCESS_TOKEN, data.response.tokenInfo.authToken);
          await reduxStorage.setItem(APP_SECRETS.REFRESH_TOKEN, data.response.tokenInfo.refreshToken);
          navigation.dispatch(
            CommonActions.reset({
              index: 0,
              routes: [{ name: Paths.Authenticated }],
            })
          )
        } catch (error) {
          console.error("Error storing tokens:", error);
        }
      }
    }
    successAction();
  }, [data, isSuccess, navigation, reset])

  if (error) {
    if (ApiErrorSchema.safeParse(error).success) {
      const apiError = error as ApiError;

      if (apiError.data.responseHeader.responseTitle === t("onboarding:userNotFound")) {
        bottomSheetModalRef.current?.dismiss();
        reset();
        navigation.navigate(Paths.CreateAccount, {
          billNumber: codeInBill
        });
      }
    } else {
      console.error('Error:', error);
    }
  }

  const renderBackdrop = useCallback(
    (
      props: BottomSheetDefaultBackdropProps & React.JSX.IntrinsicAttributes,
    ) => (
      <BottomSheetBackdrop
        appearsOnIndex={0}
        disappearsOnIndex={-1}
        {...props}
      />
    ),
    [],
  );
  const sheetChangeAction = useCallback((index: number) => {
    console.log('handleSheetChanges', index);
  }, []);

  const changeCodeInBill = (text: string) => {
    setCodeInBill(text);
  }

  const toggleBottomSheet = () => {
    setCodeInBill('');
    bottomSheetModalRef.current?.present();
  };

  return (
    <View style={[layout.flex_1]}>
      <AssetByVariant
        extension="mp4"
        path="splash_screen"
        paused={false}
        repeat={true}
        style={[components.absoluteFill]}
      />
      <View
        style={[
          components.overlay,
          layout.flex_1,
          layout.justifyEnd,
          layout.itemsCenter,
          gutters.paddingHorizontal_28,
        ]}
      >
        <AssetByVariant
          extension="png"
          path="logo_onboarding"
          style={[layout.width150, layout.height150]}
        />
        <TextByVariant
          style={[components.bebasNeueTitle, gutters.marginTop_12]}
        >
          {t('onboarding:onboarding_title_1')}
        </TextByVariant>
        <TextByVariant
          style={[components.interDescription, gutters.marginVertical_24]}
        >
          {t('onboarding:onboarding_description_1')}
        </TextByVariant>

        <ButtonVariant
          onPress={() => navigateAction(Paths.QRScan)}
          style={[components.primaryButton, gutters.marginVertical_12]}
        >
          <TextByVariant style={[components.interDescriptionBlack]}>
            {t('onboarding:scan_to_add_product')}
          </TextByVariant>
        </ButtonVariant>

        <ButtonVariant
          onPress={toggleBottomSheet}
          style={[components.textButton, gutters.marginBottom_12]}
        >
          <TextByVariant style={[components.interDescription]}>
            {t('onboarding:enter_code_to_add_product')}
          </TextByVariant>
        </ButtonVariant>
      </View>

      <BottomSheetModal
        android_keyboardInputMode="adjustResize"
        backdropComponent={renderBackdrop}
        backgroundStyle={[backgrounds.background, borders.rounded_0]}
        enableDismissOnClose
        enablePanDownToClose={true}
        handleComponent={null}
        handleIndicatorStyle={[layout.width40, backgrounds.white]}
        index={2}
        keyboardBehavior="interactive"
        keyboardBlurBehavior="restore"
        onChange={sheetChangeAction}
        ref={bottomSheetModalRef}
        snapPoints={snapPoints}
      >
        <BottomSheetView
          style={[gutters.paddingHorizontal_28, gutters.marginVertical_32]}
        >
          <TextByVariant style={[components.bebasNeueDescription]}>
            {t('onboarding:enterProductCode')}
          </TextByVariant>
          <BottomSheetTextInput
            autoCapitalize="none"
            cursorColor={colors.white}
            editable={!isLoading}
            keyboardType="numbers-and-punctuation"
            maxLength={8}
            onChangeText={changeCodeInBill}
            onSubmitEditing={() => navigateAction(Paths.CreateAccount)}
            placeholder={t('onboarding:8DigitsOnBill')}
            placeholderTextColor={colors.white50}
            ref={inputFieldRef}
            returnKeyLabel="Done"
            returnKeyType="done"
            selectionColor={colors.white}
            style={[
              backgrounds.background,
              borders.wBottom_1,
              borders.white50,
              gutters.paddingVertical_16,
              components.interDescription18UnAligned,
              components.textLeft,
              gutters.marginVertical_16,
            ]}
            value={codeInBill}
          />
          {error &&
            <TextByVariant style={[components.interErrorRed]}>
              {t("onboarding:billNumberNotFound")}
            </TextByVariant>}

          <ButtonVariant
            disabled={codeInBill.length !== 8 || isLoading}
            onPress={() => navigateAction(Paths.CreateAccount)}
            style={[components.primaryButton, gutters.marginVertical_12]}
          >
            {isLoading ? (
              <ActivityIndicator color={colors.background} size="small" />
            ) : (
              <TextByVariant style={[components.interDescriptionBlack]}>
                {t('onboarding:continue')}
              </TextByVariant>
            )}
          </ButtonVariant>
        </BottomSheetView>
      </BottomSheetModal>
    </View>
  );
};

export default React.memo(Onboarding);
