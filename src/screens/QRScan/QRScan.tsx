import type { StackNavigationProp } from '@react-navigation/stack';
import type { FC } from 'react';
import type { Paths } from '@/navigation/paths';
import type { RootStackParamList } from '@/navigation/types';

import { useNavigation } from '@react-navigation/native';
import LottieView from 'lottie-react-native';
import React, { useRef } from 'react';
import { useTranslation } from 'react-i18next';
import { Alert, StyleSheet, View } from 'react-native';
import {
  Camera,
  getCameraDevice,
  useCameraPermission,
  useCodeScanner,
} from 'react-native-vision-camera';

import { useTheme } from '@/theme';

import {
  AssetByVariant,
  ButtonVariant,
  TextByVariant,
} from '@/components/atoms';
import { SafeScreen } from '@/components/templates';

/**
 * @author Nitesh Raj Khanal
 * @function @QRScan
 **/

  /**
   * Screen for scanning QR codes.
   * @return The screen for scanning QR codes.
   */
const QRScan: FC = () => {
  const { borders, components, gutters, layout } = useTheme();
  const { t } = useTranslation(['QRCode']);

  const navigation =
    useNavigation<StackNavigationProp<RootStackParamList, Paths.QRScan>>();

  const camera = useRef<Camera>(null);

  const devices = Camera.getAvailableCameraDevices();
  const device = getCameraDevice(devices, 'back');

  const { hasPermission, requestPermission } = useCameraPermission();
  const codeScanner = useCodeScanner({
    codeTypes: ['qr', 'ean-13'],
    onCodeScanned: (codes) => {
      for (const code of codes) {
        console.log(code.value);
      }
    },
  });

  if (!hasPermission) {
    requestPermission().then(r => {});
  }

  if (device == null) {
    Alert.alert(t('QRCode:error'), t('QRCode:camera_not_found'));
  }

  const backAction = () => {
    navigation.goBack();
  };

  return (
    <SafeScreen style={[layout.flex_1]}>
      <View style={[layout.row, layout.z10, layout.itemsCenter]}>
        <ButtonVariant
          onPress={backAction}
          style={[
            layout.height40,
            layout.width40,
            components.overlayPart,
            borders.rounded_500,
            layout.itemsCenter,
            layout.justifyCenter,
            gutters.marginHorizontal_16,
          ]}
        >
          <AssetByVariant
            extension="png"
            path="arrow_left"
            resizeMode="contain"
            style={[layout.height24, layout.width24]}
          />
        </ButtonVariant>
        <TextByVariant style={[components.interDescription18]}>
          {t('QRCode:scanQRCode')}
        </TextByVariant>
      </View>
      {device && (
        <Camera
          codeScanner={codeScanner}
          device={device}
          enableZoomGesture={true}
          focusable={true}
          isActive={true}
          ref={camera}
          style={StyleSheet.absoluteFillObject}
        />
      )}

      <View
        style={[
          components.overlayPart,
          layout.absolute,
          layout.top0,
          layout.height20Percentage,
          layout.overflowHidden,
          layout.z1,
          layout.fullWidth,
        ]}
      />
      <View
        style={[
          components.overlayPart,
          layout.absolute,
          layout.bottom0,
          layout.height20Percentage,
          layout.overflowHidden,
          layout.z1,
          layout.fullWidth,
        ]}
      />

      <View
        style={[
          components.overlayPart,
          layout.absolute,
          layout.left0,
          layout.width5percentage,
          layout.overflowHidden,
          layout.z1,
          layout.height60Percent,
          layout.top20Percentage,
        ]}
      />

      <View
        style={[
          components.overlayPart,
          layout.absolute,
          layout.right0,
          layout.width5percentage,
          layout.overflowHidden,
          layout.z1,
          layout.height60Percent,
          layout.top20Percentage,
        ]}
      />

      <View
        style={[
          layout.absolute,
          layout.top20Percentage,
          layout.bottom20Percentage,
          layout.flex_1,
          layout.justifyBetween,
          layout.alignSelfCenter,
          layout.itemsStretch,
          layout.height60Percent,
          layout.width90Percentage,
          layout.overflowHidden,
        ]}
      >
        <View style={[layout.row, layout.justifyBetween, layout.fullWidth]}>
          <AssetByVariant
            extension="png"
            path="top_left"
            style={[
              layout.width40,
              layout.height40,
              layout.bottom0,
              layout.left0,
            ]}
          />
          <AssetByVariant
            extension="png"
            path="top_right"
            style={[
              layout.width40,
              layout.height40,
              layout.bottom0,
              layout.right0,
            ]}
          />
        </View>
        <View style={[layout.row, layout.justifyBetween, layout.fullWidth]}>
          <AssetByVariant
            extension="png"
            path="bottom_left"
            style={[
              layout.width40,
              layout.height40,
              layout.bottom0,
              layout.left0,
            ]}
          />
          <AssetByVariant
            extension="png"
            path="bottom_right"
            style={[
              layout.width40,
              layout.height40,
              layout.bottom0,
              layout.right0,
            ]}
          />
        </View>
      </View>

      <LottieView
        autoPlay
        loop
        resizeMode="cover"
        // eslint-disable-next-line @typescript-eslint/no-require-imports
        source={require('@/theme/assets/lottie/scan_qr_q.json')}
        speed={10}
        style={[
          layout.z10,
          layout.height60Percent,
          layout.top20Percentage,
          layout.absolute,
          layout.fullWidth,
        ]}
      />
      <TextByVariant
        style={[
          components.interDescription,
          layout.absolute,
          layout.top82Percentage,
          layout.alignSelfCenter,
          layout.z10,
        ]}
      >
        {t('QRCode:alignTheQR')}
      </TextByVariant>

      <ButtonVariant
        style={[
          borders.rounded_500,
          components.primaryCircle,
          layout.z10,
          layout.absolute,
          layout.top87Percentage,
          layout.alignSelfCenter,
        ]}
      >
        <AssetByVariant
          extension="png"
          path="scan_icon"
          style={[layout.height24, layout.width24, layout.right0]}
        />
      </ButtonVariant>
    </SafeScreen>
  );
};

export default React.memo(QRScan);
