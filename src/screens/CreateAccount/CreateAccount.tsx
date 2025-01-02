import { ButtonVariant, InputVariant, TextByVariant } from '@/components/atoms';
import { SafeScreen } from '@/components/templates';
import type { User } from '@/hooks';
import { useTheme } from '@/theme';
import type { FC } from 'react';
import React, { useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import type { TextInput } from 'react-native';
import { Keyboard, KeyboardAvoidingView, Platform, TouchableWithoutFeedback, View } from 'react-native';

/**
* @author Nitesh Raj Khanal
* @function @CreateAccount
**/

const CreateAccount: FC = () => {
    const { backgrounds, borders, colors, components, gutters, layout } = useTheme();
    const { t } = useTranslation(["create_account"]);

    const [userPayload, setUserPayload] = useState<User>({
        email: "",
        fullName: "",
        password: "",
        phoneNumber: "",
    });

    const updateUserPayload = (newData: Partial<User>) => {
        setUserPayload((prevState) => ({
            ...prevState,
            ...newData,
        }));
    };

    const fullNameRef = useRef<TextInput>(null);
    const emailRef = useRef<TextInput>(null);
    const passwordRef = useRef<TextInput>(null);
    const phoneNumberRef = useRef<TextInput>(null);

    return (
        <SafeScreen style={[backgrounds.background, gutters.paddingHorizontal_16]}>
            <TouchableWithoutFeedback onPress={Keyboard.dismiss}>
                <KeyboardAvoidingView style={[layout.flex_1, layout.justifyCenter]}
                    {...(Platform.OS === 'ios' && { behavior: 'padding' })}
                >
                    <View style={[gutters.paddingHorizontal_80, gutters.marginBottom_24]}>
                        <TextByVariant style={[components.bebasNeueTitle]}>
                            {t("create_account:letsCreateAccount")}
                        </TextByVariant>
                    </View>
                    <View style={[gutters.paddingHorizontal_32, gutters.marginBottom_24]}>
                        <TextByVariant style={[components.interDescription]}>
                            {t("create_account:createAccountDescription")}
                        </TextByVariant>
                    </View>

                    <View style={[gutters.paddingHorizontal_20, gutters.marginBottom_24]}>
                        <InputVariant
                            autoCapitalize="none"
                            cursorColor={colors.white}
                            onChangeText={(text) => updateUserPayload({ email: text })}
                            onSubmitEditing={() => fullNameRef.current?.focus()}
                            placeholder={t('create_account:enterEmailAddress')}
                            placeholderTextColor={colors.white50}
                            ref={emailRef}
                            returnKeyLabel='next'
                            returnKeyType='next'
                            selectionColor={colors.white}
                            style={[
                                backgrounds.background,
                                borders.wBottom_1,
                                borders.white50,
                                gutters.paddingVertical_16,
                                components.interDescription18UnAligned,
                                components.textLeft,
                            ]}
                            value={userPayload.email}
                        />
                    </View>

                    <View style={[gutters.paddingHorizontal_20, gutters.marginBottom_24]}>
                        <InputVariant
                            autoCapitalize="none"
                            cursorColor={colors.white}
                            onChangeText={(text) => updateUserPayload({ fullName: text })}
                            onSubmitEditing={() => passwordRef.current?.focus()}
                            placeholder={t('create_account:enterFullName')}
                            placeholderTextColor={colors.white50}
                            ref={fullNameRef}
                            returnKeyLabel='next'
                            returnKeyType='next'
                            selectionColor={colors.white}
                            style={[
                                backgrounds.background,
                                borders.wBottom_1,
                                borders.white50,
                                gutters.paddingVertical_16,
                                components.interDescription18UnAligned,
                                components.textLeft,
                            ]}
                            value={userPayload.fullName}
                        />
                    </View>

                    <View style={[gutters.paddingHorizontal_20, gutters.marginBottom_24]}>
                        <InputVariant
                            autoCapitalize="none"
                            cursorColor={colors.white}
                            onChangeText={(text) => updateUserPayload({ password: text })}
                            onSubmitEditing={() => phoneNumberRef.current?.focus()}
                            placeholder={t('create_account:password')}
                            placeholderTextColor={colors.white50}
                            ref={passwordRef}
                            returnKeyLabel='next'
                            returnKeyType='next'
                            secureTextEntry
                            selectionColor={colors.white}
                            style={[
                                backgrounds.background,
                                borders.wBottom_1,
                                borders.white50,
                                gutters.paddingVertical_16,
                                components.interDescription18UnAligned,
                                components.textLeft,
                            ]}
                            value={userPayload.password}
                        />
                    </View>

                    <View style={[gutters.paddingHorizontal_20, gutters.marginBottom_32]}>
                        <InputVariant
                            autoCapitalize="none"
                            cursorColor={colors.white}
                            onChangeText={(text) => updateUserPayload({ phoneNumber: text })}
                            onSubmitEditing={Keyboard.dismiss}
                            placeholder={t('create_account:enterPhoneNumber')}
                            placeholderTextColor={colors.white50}
                            ref={phoneNumberRef}
                            returnKeyLabel='done'
                            returnKeyType='done'
                            selectionColor={colors.white}
                            style={[
                                backgrounds.background,
                                borders.wBottom_1,
                                borders.white50,
                                gutters.paddingVertical_16,
                                components.interDescription18UnAligned,
                                components.textLeft,
                            ]}
                            value={userPayload.phoneNumber}
                        />
                    </View>
                    <View style={[gutters.paddingHorizontal_20, gutters.marginBottom_24, layout.row, layout.wrap]}>
                        <TextByVariant style={[components.interDescription]}>
                            {t('create_account:agreeTo')}
                        </TextByVariant>
                        <ButtonVariant>
                            <TextByVariant style={[components.textButtoninterDescription]}>
                                {" "}
                                {t('create_account:privacyPolicy')}
                            </TextByVariant>
                        </ButtonVariant>
                        <TextByVariant style={[components.interDescription]}>
                            {" "}
                            {t('create_account:and')}
                        </TextByVariant>
                        <ButtonVariant>
                            <TextByVariant style={[components.textButtoninterDescription]}>
                                {" "}
                                {t('create_account:termsOfUse')}
                            </TextByVariant>
                        </ButtonVariant>
                    </View>
                    <ButtonVariant
                        style={[components.primaryButton, gutters.marginTop_24]}
                    >
                        <TextByVariant style={[components.interDescriptionBlack]}>
                            {t('create_account:complete')}
                        </TextByVariant>
                    </ButtonVariant>
                </KeyboardAvoidingView>
            </TouchableWithoutFeedback>
        </SafeScreen>
    );
};

export default React.memo(CreateAccount);
