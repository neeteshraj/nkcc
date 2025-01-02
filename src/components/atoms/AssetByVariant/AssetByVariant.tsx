import React, { useEffect, useState } from 'react';
import { Image } from 'react-native';
import Video from 'react-native-video';
import type { ImageProps } from 'react-native';
import { z } from 'zod';

import { useTheme } from '@/theme';
import getAssetsContext from '@/theme/assets/getAssetsContext';
import LottieView from 'lottie-react-native';

type Props = {
  extension?: string;
  isLoading?: boolean;
  path: string;
  paused?: boolean;
  repeat?: boolean;
} & Omit<ImageProps, 'source'>;

const images = getAssetsContext('images');
const videos = getAssetsContext('videos');
const lottie = getAssetsContext('lottie');

function AssetByVariant({ extension = 'png', isLoading = false, path, paused = false, repeat = false, ...props }: Props) {
  const [asset, setAsset] = useState<null | number | string>(null);
  const { variant } = useTheme();

  useEffect(() => {
    try {
      const fetchAsset = (basePath: string, fileExtension: string): number | string => {
        return z
          .custom<number | string>()
          .parse(
            extension === 'mp4'
              ? videos(`./${basePath}.${fileExtension}`)
              : extension === 'json'
                ? lottie(`./${basePath}.${fileExtension}`)
                : images(`./${basePath}.${fileExtension}`)
          );
      };

      const defaultSource = fetchAsset(path, extension);

      if (variant === 'default') {
        setAsset(defaultSource);
        return;
      }

      try {
        const variantSource = fetchAsset(`${variant}/${path}`, extension);
        setAsset(variantSource);
      } catch (error) {
        console.warn(
          `Couldn't load the asset: ${path}.${extension} for the variant ${variant}, Fallback to default`,
          error,
        );
        setAsset(defaultSource);
      }
    } catch (error) {
      console.error(`Couldn't load the asset: ${path}`, error);
    }
  }, [variant, extension, path]);

  if (!asset) {
    return null;
  }

  if (extension === 'json') {
    return (
      <LottieView
        autoPlay
        loop={repeat}
        source={typeof asset === 'string' ? asset : Image.resolveAssetSource(asset).uri}
        style={[props.style]}
      />
    );
  }

  if (extension === 'mp4') {
    return (
      <Video
        paused={paused}
        repeat={repeat}
        source={
          typeof asset === 'string'
            ? { uri: asset }
            : { uri: Image.resolveAssetSource(asset).uri }
        }
        style={[props.style]}
        testID="variant-video"
      />
    );
  }

  return (
    <Image
      resizeMode="contain"
      source={typeof asset === 'string' ? { uri: asset } : asset}
      style={props.style}
      testID="variant-image"
    />
  );
}

export default AssetByVariant;
