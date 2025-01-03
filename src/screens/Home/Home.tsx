import React, { useCallback, useMemo, useState } from 'react';
import { FlatList, Image, RefreshControl, SectionList, View } from 'react-native';
import LinearGradient from 'react-native-linear-gradient';
import { SafeScreen } from '@/components/templates';
import { useDispatch, useGetProductListQuery, useSelector } from '@/hooks';
import { useTheme } from '@/theme';
import type { FC } from 'react';
import type { RootState } from '@/store';
import { ButtonVariant, TextByVariant } from '@/components/atoms';
import { useTranslation } from 'react-i18next';
import { useNavigation } from '@react-navigation/native';
import type { StackNavigationProp } from '@react-navigation/stack';
import type { RootStackParamList } from '@/navigation/types';
import { Paths } from '@/navigation/paths';
import { productActions } from '@/store/slices';
import { Skeleton } from '@rneui/themed';

const Home: FC = () => {
    const { t } = useTranslation(["home"]);
    const dispatch = useDispatch();
    const { backgrounds, borders, colors, components, gutters, layout } = useTheme();
    const navigation = useNavigation<StackNavigationProp<RootStackParamList, Paths.Home>>();
    const [currentPage, setCurrentPage] = useState(1);
    const [isFetching, setIsFetching] = useState(false);
    const [isRefreshing, setIsRefreshing] = useState(false);

    const { error, isLoading, refetch } = useGetProductListQuery({
        limit: 10,
        page: currentPage,
    });

    const products = useSelector((state: RootState) => state.products.products);
    const uniqueProducts = useMemo(() => {
        const seenIds = new Set();
        return products.filter((product) => {
            if (seenIds.has(product._id)) {
                return false;
            }
            seenIds.add(product._id);
            return true;
        });
    }, [products]);

    const sections = useMemo(() => {
        if (!uniqueProducts || isLoading || error) {
            return [];
        }
        return [
            {
                data: [uniqueProducts],
                title: 'Our Products',
            },
            {
                data: [uniqueProducts],
                title: 'Deals of the Week',
            },
        ];
    }, [uniqueProducts, isLoading, error]);

    const handleLoadMore = useCallback(() => {
        if (isFetching) { return; }
        setIsFetching(true);
        setCurrentPage((prevPage) => prevPage + 1);
        refetch()
            .then((response) => {
                if (response.data?.response?.length) {
                    dispatch(
                        productActions.appendProducts({
                            newProducts: response.data.response,
                        })
                    );
                }
            })
            .finally(() => setIsFetching(false));
    }, [dispatch, isFetching, refetch]);

    const handleRefresh = useCallback(() => {
        setIsRefreshing(true);
        setCurrentPage(1);
        refetch()
            .finally(() => setIsRefreshing(false));
    }, [refetch]);

    const navToSpecificProduct = () => {
        navigation.navigate(Paths.ProductDetails);
    };

    const renderHorizontalList = ({ item }: { item: typeof products }) => (
        <FlatList
            data={isLoading ? Array(10).fill(null) : item}
            horizontal
            keyExtractor={(product, index) => isLoading ? `skeleton-${index}` : `${product._id}-${index}`}
            onScroll={({ nativeEvent }) => {
                const { contentOffset, contentSize, layoutMeasurement } = nativeEvent;
                const isHalfway = contentOffset.x > contentSize.width * 0.5 - layoutMeasurement.width;
                if (isHalfway) { handleLoadMore(); }
            }}
            removeClippedSubviews={true}
            renderItem={({ item: product }) => (
                isLoading ? (
                    <Skeleton
                        animation="wave"
                        height={140}
                        LinearGradientComponent={LinearGradient}
                        style={[gutters.marginRight_10]}
                        width={190}
                    />
                ) : (
                    <ButtonVariant onPress={navToSpecificProduct} style={[layout.row, gutters.marginRight_10]}>
                        <View style={[layout.height17Percentage, layout.width50Percentage, borders.rounded_8]}>
                            <Image
                                resizeMethod="resize"
                                resizeMode="stretch"
                                source={{ uri: product.thumbnail }}
                                style={[layout.fullWidth, layout.fullHeight, layout.overflowHidden, borders.rounded_8, layout.absolute]}
                            />
                            <View style={[layout.absolute, layout.bottom10Percent, layout.left5Percentage, layout.z10]}>
                                <TextByVariant style={[components.bebasNeueBody]}>
                                    {product.name}
                                </TextByVariant>
                                <TextByVariant style={[components.interDescription12white]}>
                                    {t("home:by")}{" "}{product.brand}
                                </TextByVariant>
                            </View>
                            <LinearGradient
                                colors={['transparent', 'rgba(0, 0, 0, 0.1)', 'rgba(0, 0, 0, 0.2)', 'rgba(0, 0, 0, 0.3)', 'rgba(0, 0, 0, 0.4)']}
                                style={[layout.absolute, layout.left0, layout.bottom0, layout.right0, layout.height60Percent, borders.rounded_8]}
                            />
                        </View>
                    </ButtonVariant>
                )
            )}
            scrollEventThrottle={16}
            showsHorizontalScrollIndicator={false}
        />
    );

    const renderSectionHeader = ({ section: { title } }: { section: { title: string } }) => (
        <View style={[layout.row, layout.itemsCenter, layout.justifyBetween, gutters.marginVertical_16]}>
            {isLoading ? (
                <Skeleton
                    animation="wave"
                    height={30}
                    LinearGradientComponent={LinearGradient}
                    width={120}
                />
            ) : (
                <TextByVariant style={[components.bebasNeueDescription26]}>{title}</TextByVariant>
            )}

            <ButtonVariant>
                {isLoading ? (
                    <Skeleton
                        animation="wave"
                        height={20}
                        LinearGradientComponent={LinearGradient}
                        width={80}
                    />
                ) : (
                    <TextByVariant style={[components.bebasNeueDescription26White70]}>{t("home:seeAll")}</TextByVariant>
                )}
            </ButtonVariant>
        </View>
    );

    if (isLoading) {
        return (
            <SafeScreen style={[backgrounds.background, gutters.paddingHorizontal_16]}>
                <Skeleton
                    animation="wave"
                    height={40}
                    LinearGradientComponent={LinearGradient}
                    width={80}
                />
            </SafeScreen>
        );
    }

    return (
        <SafeScreen style={[backgrounds.background, gutters.paddingHorizontal_16]}>
            <SectionList
                keyExtractor={(item, index) => `section-${index}`}
                refreshControl={
                    <RefreshControl
                        colors={[colors.white]}
                        onRefresh={handleRefresh}
                        progressBackgroundColor={colors.primary}
                        refreshing={isRefreshing}
                        tintColor={colors.white}
                    />
                }
                removeClippedSubviews={true}
                renderItem={renderHorizontalList}
                renderSectionHeader={renderSectionHeader}
                scrollEventThrottle={16}
                sections={sections}
                showsVerticalScrollIndicator={false}
                stickySectionHeadersEnabled={false}
            />
        </SafeScreen>
    );
};

export default React.memo(Home);
