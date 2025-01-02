import type { ImageStyle, TextStyle, ViewStyle } from 'react-native';
import type { ComponentTheme } from '@/theme/types/theme';

import { StyleSheet } from 'react-native';

import { heightToDp, widthToDp } from '@/utilities';

import { BebasNeue, Inter } from './fonts';

// eslint-disable-next-line @typescript-eslint/no-empty-object-type
interface AllStyle
  extends Record<string, AllStyle | ImageStyle | TextStyle | ViewStyle> {}

export default ({
  backgrounds,
  borders,
  colors,
  fonts,
  layout,
}: ComponentTheme) => {
  return {
    absoluteFill: {
      ...StyleSheet.absoluteFillObject,
    },
    bebasNeueDescription: {
      ...BebasNeue.bold,
      ...fonts.size_32,
      color: colors.white,
    },
    bebasNeueTitle: {
      ...BebasNeue.bold,
      ...fonts.size_48,
      color: colors.white,
      textAlign: 'center',
    },
    buttonCircle: {
      ...layout.justifyCenter,
      ...layout.itemsCenter,
      ...backgrounds.purple100,
      ...fonts.gray400,
      borderRadius: 35,
      height: 64,
      width: 64,
    },
    circle250: {
      borderRadius: 140,
      height: 250,
      width: 250,
    },
    interDescription: {
      ...Inter.regular,
      ...fonts.size_16,
      color: colors.white,
      textAlign: 'center',
    },
    interDescription18: {
      ...Inter.regular,
      ...fonts.size_18,
      color: colors.white,
      textAlign: 'center',
    },
    interDescription18UnAligned: {
      ...Inter.regular,
      ...fonts.size_18,
      color: colors.white,
    },
    interDescriptionBlack: {
      ...Inter.regular,
      ...fonts.size_16,
      color: colors.black,
      textAlign: 'center',
    },
    interDescriptionUnAligned: {
      ...Inter.regular,
      ...fonts.size_16,
      color: colors.white,
    },
    interErrorRed: {
      ...Inter.regular,
      ...fonts.size_12,
      color: colors.red500,
    },
    overlay: {
      ...backgrounds.black80,
      ...StyleSheet.absoluteFillObject,
    },
    overlayBackButton: {
      ...backgrounds.white80,
    },
    overlayPart: {
      ...backgrounds.black80,
    },
    primaryButton: {
      backgroundColor: colors.primary,
      height: 55,
      ...layout.justifyCenter,
      ...layout.itemsCenter,
      ...layout.fullWidth,
      ...borders.rounded_500,
    },
    primaryCircle: {
      backgroundColor: colors.primary,
      height: heightToDp(55),
      width: widthToDp(55),
      ...layout.justifyCenter,
      ...layout.itemsCenter,
      ...borders.rounded_500,
    },

    textButton: {
      height: 55,
      ...layout.justifyCenter,
      ...layout.itemsCenter,
      ...layout.fullWidth,
    },
    textButtoninterDescription: {
      ...Inter.regular,
      ...fonts.size_16,
      color: colors.white,
      textAlign: 'center',
      textDecorationLine: 'underline',
    },
    textLeft: {
      textAlign: 'left',
    },
  } as const satisfies AllStyle;
};
