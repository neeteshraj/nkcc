import { AssetByVariant, ButtonVariant, TextByVariant } from '@/components/atoms';
import { SafeScreen } from '@/components/templates';
import { useTheme } from '@/theme';
import type { FC } from 'react';
import React from 'react';
import { useTranslation } from 'react-i18next';
import { SectionList, Text, View } from 'react-native';

/**
 * @author Nitesh
 * @function @Profile
 **/

const Profile: FC = () => {
    const { backgrounds, borders, components, gutters, layout } = useTheme();

    const { t } = useTranslation(['profile']);

    const sections = [
        {
            data: ['Profile Settings', 'Notification Settings', 'Registered Products'],
            title: 'Account',
        },
        {
            data: ['Help Center', 'Security Settings', 'Report a Problem', 'Support Request'],
            title: 'Others',
        },
        {
            data: ["Logout"],
            title: 'Logout',
        }
    ];

    const renderItem = ({ index, item, section }: { index: number; item: string; section: typeof sections[number] }) => {
        if (section.title === 'Logout') {
            return(
                <ButtonVariant style={[components.errorButton, gutters.marginVertical_24]}>
                    <TextByVariant style={[components.interDescription]}>{t("profile:logout")}</TextByVariant>
                </ButtonVariant>
            )
        }

        return (
            <View
                style={[
                    borders.white70,
                    index === 0 && borders.wTop_1,
                    index === section.data.length - 1 ? borders.wBottom_1 : null,
                    borders.wLeft_1,
                    borders.wRight_1,
                    index === 0 && borders.roundedTop_8,
                    index === section.data.length - 1 && borders.roundedBottom_8,
                    gutters.paddingHorizontal_16,
                ]}
            >
                <ButtonVariant
                    style={[
                        layout.row,
                        layout.justifyBetween,
                        layout.itemsCenter,
                        index !== section.data.length - 1 && borders.wBottom_1,
                        borders.white70,
                        gutters.paddingVertical_20,
                    ]}
                >
                    <Text style={[components.interDescription]}>{item}</Text>

                    <AssetByVariant
                        extension="png"
                        path="arrow_right"
                        style={[layout.height18, layout.width18]}
                    />
                </ButtonVariant>
            </View>
        );
    };



    const renderSectionHeader = ({ section }: { section: typeof sections[number] }) => (
        section.title !== "Logout" ? <View style={[gutters.marginBottom_12]}>
            <Text style={[components.interDescriptionUnAligned, gutters.marginTop_20]}>{section.title}</Text>
        </View> : null
    );

    return (
        <SafeScreen style={[backgrounds.background, gutters.paddingHorizontal_16]}>
            <SectionList
                keyExtractor={(item, index) => `${item}-${index}`}
                renderItem={renderItem}
                renderSectionHeader={renderSectionHeader}
                scrollEventThrottle={16}
                sections={sections}
                showsVerticalScrollIndicator={false}
                stickySectionHeadersEnabled={false}
            />
        </SafeScreen>
    );
};

export default React.memo(Profile);
