import type { TextStyle } from 'react-native';
import type { UnionConfiguration } from '@/theme/types/config';
import type { FontColors, FontSizes } from '@/theme/types/fonts';

import { config } from '@/theme/_config';

export const generateFontColors = (configuration: UnionConfiguration) => {
  return Object.entries(configuration.fonts.colors ?? {}).reduce(
    (acc, [key, value]) => {
      return Object.assign(acc, {
        [`${key}`]: {
          color: value,
        },
      });
    },
    {} as FontColors,
  );
};

export const generateFontSizes = () => {
  return config.fonts.sizes.reduce((acc, size) => {
    return Object.assign(acc, {
      [`size_${size}`]: {
        fontSize: size,
      },
    });
  }, {} as FontSizes);
};

export const staticFontStyles = {
  alignCenter: {
    textAlign: 'center',
  },
  bold: {
    fontWeight: 'bold',
  },
  capitalize: {
    textTransform: 'capitalize',
  },
  uppercase: {
    textTransform: 'uppercase',
  },
} as const satisfies Record<string, TextStyle>;

export const BebasNeue: Record<string, TextStyle> = {
  bold: {
    fontFamily: 'BebasNeue-Bold',
  },
  book: {
    fontFamily: 'BebasNeue-Book',
  },
  light: {
    fontFamily: 'BebasNeue-Light',
  },
  regular: {
    fontFamily: 'BebasNeue-Regular',
  },
  thin: {
    fontFamily: 'BebasNeue-Thin',
  },
};

export const Inter: Record<string, TextStyle> = {
  black:{
    fontFamily: 'Inter-Black',
  },
  blackItalic:{
    fontFamily: 'Inter-BlackItalic',
  },
  bold: {
    fontFamily: 'Inter-Bold',
  },
  boldItalic: {
    fontFamily: 'Inter-BoldItalic',
  },
  extraBold: {
    fontFamily: 'Inter-ExtraBold',
  },
  extraBoldItalic: {
    fontFamily: 'Inter-ExtraBoldItalic',
  },
  extraLight: {
    fontFamily: 'Inter-ExtraLight',
  },
  extraLightItalic: {
    fontFamily: 'Inter-ExtraLightItalic',
  },
  italic: {
    fontFamily: 'Inter-Italic',
  },
  light: {
    fontFamily: 'Inter-Light',
  },
  lightItalic: {
    fontFamily: 'Inter-LightItalic',
  },
  medium: {
    fontFamily: 'Inter-Medium',
  },
  mediumItalic: {
    fontFamily: 'Inter-MediumItalic',
  },
  regular: {
    fontFamily: 'Inter-Regular',
  },
  semiBold: {
    fontFamily: 'Inter-SemiBold',
  },
  semiBoldItalic: {
    fontFamily: 'Inter-SemiBoldItalic',
  },
  thin: {
    fontFamily: 'Inter-Thin',
  },
  thinItalic: {
    fontFamily: 'Inter-ThinItalic',
  },
}