import type { ViewStyle } from 'react-native';

import { heightPercentToDp, widthPercentToDp } from '@/utilities';

export default {
  alignSelfCenter: {
    alignSelf: 'center',
  },
  col: {
    flexDirection: 'column',
  },
  colReverse: {
    flexDirection: 'column-reverse',
  },
  height150: {
    height: 150,
  },
  height18: {
    height: 18,
  },
  height24: {
    height: 24,
  },
  itemsCenter: {
    alignItems: 'center',
  },
  itemsEnd: {
    alignItems: 'flex-end',
  },
  itemsStart: {
    alignItems: 'flex-start',
  },
  itemsStretch: {
    alignItems: 'stretch',
  },
  justifyAround: {
    justifyContent: 'space-around',
  },
  justifyBetween: {
    justifyContent: 'space-between',
  },
  justifyCenter: {
    justifyContent: 'center',
  },
  justifyEnd: {
    justifyContent: 'flex-end',
  },
  justifyEvenly: {
    justifyContent: 'space-evenly',
  },
  justifyStart: {
    justifyContent: 'flex-start',
  },
  overflowHidden: {
    overflow: 'hidden',
  },
  row: {
    flexDirection: 'row',
  },
  rowReverse: {
    flexDirection: 'row-reverse',
  },
  width150: {
    width: 150,
  },
  width18: {
    width: 18,
  },
  width24: {
    width: 24,
  },
  width5percentage: {
    width: widthPercentToDp('5'),
  },
  wrap: {
    flexWrap: 'wrap',
  },
  /* Sizes Layouts */
  flex_1: {
    flex: 1,
  },
  fullHeight: {
    height: '100%',
  },
  fullWidth: {
    width: '100%',
  },
  /* Positions */
  absolute: {
    position: 'absolute',
  },
  bottom0: {
    bottom: 0,
  },
  bottom10Percent: {
    bottom: '10%',
  },
  bottom10Percentage: {
    bottom: heightPercentToDp('10'),
  },
  bottom20Percentage: {
    bottom: heightPercentToDp('20'),
  },
  flexGrow0: {
    flexGrow: 0,
  },
  height17Percentage: {
    height: heightPercentToDp('17'),
  },
  height20Percentage: {
    height: heightPercentToDp('20'),
  },
  height40: {
    height: 40,
  },
  height45: {
    height: 45,
  },
  height50: {
    height: 50,
  },
  height60Percent: {
    height: heightPercentToDp('60'),
  },
  left0: {
    left: 0,
  },
  left5Percentage: {
    left: widthPercentToDp('5'),
  },
  relative: {
    position: 'relative',
  },
  right0: {
    right: 0,
  },
  top0: {
    top: 0,
  },
  top20Percentage: {
    top: heightPercentToDp('20'),
  },
  top65Percentage: {
    top: heightPercentToDp('65'),
  },
  top80Percentage: {
    top: heightPercentToDp('80'),
  },
  top82Percentage: {
    top: heightPercentToDp('82'),
  },
  top85Percentage: {
    top: heightPercentToDp('85'),
  },
  top87Percentage: {
    top: heightPercentToDp('87'),
  },
  top90Percentage: {
    top: heightPercentToDp('90'),
  },
  top95Percentage: {
    top: heightPercentToDp('95'),
  },
  width40: {
    width: 40,
  },
  width40Percentage: {
    width: widthPercentToDp('40'),
  },
  width45: {
    width: 45,
  },
  width50: {
    width: 50,
  },
  width50Percentage: {
    width: widthPercentToDp('50'),
  },
  width90Percentage: {
    width: widthPercentToDp('90'),
  },
  z1: {
    zIndex: 1,
  },
  z10: {
    zIndex: 10,
  },
} as const satisfies Record<string, ViewStyle>;
