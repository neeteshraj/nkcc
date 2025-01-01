export type AssetType = 'fonts' | 'icons' | 'images' | 'lottie' | 'videos';

export default (type: AssetType) =>
  type === 'images'
    ? require.context('./images', true, /\.(png|jpg|jpeg|gif|webp)$/)
    : type === 'icons'
      ? require.context('/icons', true, /\.svg$/)
      : type === 'videos'
        ? require.context('./videos', true, /\.(mp4|webm)$/)
        : type === 'lottie'
          ? require.context('./lottie', true, /\.json$/)
          : type === 'fonts'
            ? require.context('./fonts', true, /\.(ttf|otf)$/)
            : () => {
                throw new Error('Invalid asset type');
              };
