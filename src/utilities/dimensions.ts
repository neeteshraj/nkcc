import { Dimensions, PixelRatio } from 'react-native';

const { height, width } = Dimensions.get('window');

const guidelineBaseWidth = 375;
const guidelineBaseHeight = 812;

const horizontalScale = (size: number) => (width / guidelineBaseWidth) * size;
const verticalScale = (size: number) => (height / guidelineBaseHeight) * size;
const moderateScale = (size: number, factor = 0.5) =>
	size + (horizontalScale(size) - size) * factor;

export { horizontalScale, moderateScale, verticalScale };

const widthPercentToDp = (value: string) => {
	const givenWidth = typeof value === 'number' ? value : Number.parseFloat(value);

	return PixelRatio.roundToNearestPixel((width * givenWidth) / 100);
};

const heightPercentToDp = (value: string) => {
	const givenHeight = typeof value === 'number' ? value : Number.parseFloat(value);

	return PixelRatio.roundToNearestPixel((height * givenHeight) / 100);
};

const widthToDp = (value: number) => {
	return widthPercentToDp(`${(value / width) * 100}%`);
};

const heightToDp = (value: number) => {
	return heightPercentToDp(`${(value / height) * 100}%`);
};

const screenWidth = Dimensions.get('window').width;

/**
 * Converts provided width percentage to independent pixel (dp).
 * @param  {string} widthPercent The percentage of screen's width that UI element should cover
 *                               along with the percentage symbol (%).
 * @return {number}              The calculated dp depending on current device's screen width.
 */
export const useWidth = (widthPercent: string): number => {
	const elemWidth = Number.parseFloat(widthPercent);
	return PixelRatio.roundToNearestPixel((screenWidth * elemWidth) / 100);
};

export {
	height,
	heightPercentToDp,
	heightToDp,
	width,
	widthPercentToDp,
	widthToDp,
};

export const HEIGHT = 220;
export const OVERDRAG = 20;
