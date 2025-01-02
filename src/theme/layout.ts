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
  justifyEvenly:{
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
  bottom20Percentage: {
    bottom: heightPercentToDp('20'),
  },
  height20Percentage: {
    height: heightPercentToDp('20'),
  },
  height40: {
    height: 40,
  },
  height60Percent: {
    height: heightPercentToDp('60'),
  },
  left0: {
    left: 0,
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
