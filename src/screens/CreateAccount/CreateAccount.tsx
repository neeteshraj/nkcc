import { ButtonVariant, InputVariant, InputWithIconVariant, TextByVariant } from '@/components/atoms';
import { Checkbox } from '@/components/molecules';
import { SafeScreen } from '@/components/templates';
import type { ApiError } from '@/hooks';
import { ApiErrorSchema, type User, useRegisterMutation, UserErrorSchema } from '@/hooks';
import { Paths } from '@/navigation/paths';
import type { CreateAccountScreenProps, RootStackParamList } from '@/navigation/types';
import { APP_SECRETS } from '@/secrets/secrets';
import { reduxStorage } from '@/store';
import { useTheme } from '@/theme';
import { generateRequestHeader } from '@/utilities';
import { CommonActions, useNavigation, useRoute } from '@react-navigation/native';
import type { StackNavigationProp } from '@react-navigation/stack';
import type { FC } from 'react';
import React, { useCallback, useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import type { TextInput } from 'react-native';
import { Keyboard, KeyboardAvoidingView, Platform, TouchableWithoutFeedback, View } from 'react-native';
import Animated, { useAnimatedStyle, useSharedValue, withSpring } from 'react-native-reanimated';

/**
* @author Nitesh Raj Khanal
* @function @CreateAccount 
**/

const CreateAccount: FC = () => {
    const { backgrounds, borders, colors, components, gutters, layout } = useTheme();
    const { t } = useTranslation(["create_account"]);

    const navigation = useNavigation<StackNavigationProp<RootStackParamList, Paths.Onboarding>>();

    const route = useRoute<CreateAccountScreenProps['route']>();

    const { billNumber } = route.params;

    const [register, { data, error, isLoading, isSuccess, reset }] = useRegisterMutation()
    const scale = useSharedValue(1);

    const [userPayload, setUserPayload] = useState<User>({
        billNumbers: [billNumber],
        email: "",
        fcmToken: "fcm-token",
        fullName: "",
        grantType: APP_SECRETS.GRANT_TYPE,
        password: "",
        phoneNumber: "",
        role: APP_SECRETS.APP_ROLE,
    });
    const [isChecked, setIsChecked] = useState<boolean>(false);
    const [formErrors, setFormErrors] = useState({
        email: '',
        fullName: '',
        password: '',
        phoneNumber: '',
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

    const navigateAction = useCallback(
        async (pathName: string) => {
            if (pathName === Paths.PrivacyPolicy) {
                navigation.navigate(Paths.PrivacyPolicy);
            } else if (pathName === Paths.TermsOfUse) {
                navigation.navigate(Paths.TermsOfUse);
            }
        },
        [navigation],
    );

    const animateCheckbox = useCallback(() => {
        scale.value = withSpring(1.1, { damping: 2, stiffness: 100 }, () => {
            scale.value = withSpring(1, { damping: 2, stiffness: 100 });
        });
    }, [scale]);

    const validateInputs = useCallback(() => {
        const result = UserErrorSchema.safeParse(userPayload);

        if (result.success) {
            setFormErrors({
                email: '',
                fullName: '',
                password: '',
                phoneNumber: '',
            });
            return true;
        } else {
            const errors = result.error.flatten().fieldErrors;
            setFormErrors({
                email: errors.email?.[0] || '',
                fullName: errors.fullName?.[0] || '',
                password: errors.password?.[0] || '',
                phoneNumber: errors.phoneNumber?.[0] || '',
            });
            return false;
        }
    }, [userPayload]);

    const completeAction = useCallback(async () => {
        if (!isChecked) {
            animateCheckbox();
            return;
        }
        if (validateInputs()) {
            const requestHeader = await generateRequestHeader();
            const requestData = {
                body: userPayload,
                requestHeader,
            };
            console.log(requestData)
            register(requestData);
        }
    }, [isChecked, validateInputs, animateCheckbox, userPayload, register]);

    useEffect(() => {
        if (error) {
            const parsedError = ApiErrorSchema.safeParse(error);
            if (parsedError.success) {
                const apiError = error as ApiError;
                if (apiError.data.responseHeader.responseTitle === t("create_account:emailAlreadyExists")) {
                    setFormErrors((prev) => ({
                        ...prev,
                        email: t("create_account:emailAlreadyExistsDescription"),
                    }));
                } else {
                    console.log("Unhandled error:", apiError.data.responseHeader.responseTitle);
                }
            }
        }
    }, [error, t]);

    useEffect(() => {
        const successAction = async () => {
            if (isSuccess) {
                try {
                    await reduxStorage.setItem(APP_SECRETS.ACCESS_TOKEN, data.response.tokenInfo.authToken);
                    await reduxStorage.setItem(APP_SECRETS.REFRESH_TOKEN, data.response.tokenInfo.refreshToken);
                    navigation.dispatch(
                        CommonActions.reset({
                            index: 0,
                            routes: [{ name: Paths.Authenticated }],
                        })
                    )
                } catch (error) {
                    console.error("Error storing tokens:", error);
                }
            }
        }
        successAction();
    }, [data, isSuccess, navigation, reset])

    const handleCheckboxToggle = (isChecked: boolean) => {
        setIsChecked(isChecked);
    };

    const animatedStyle = useAnimatedStyle(() => {
        return {
            transform: [{ scale: scale.value }],
        };
    });

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

                    <View style={[gutters.paddingHorizontal_12, gutters.marginBottom_24]}>
                        <InputVariant
                            autoCapitalize="none"
                            cursorColor={colors.white}
                            onChangeText={(text) => updateUserPayload({ email: text })}
                            onFocus={() => setFormErrors((prev) => ({ ...prev, email: '' }))}
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
                        {formErrors.email && (
                            <TextByVariant style={[components.errorText, gutters.marginTop_4]}>
                                {formErrors.email}
                            </TextByVariant>
                        )}
                    </View>

                    <View style={[gutters.paddingHorizontal_12, gutters.marginBottom_24]}>
                        <InputVariant
                            autoCapitalize="none"
                            cursorColor={colors.white}
                            onChangeText={(text) => updateUserPayload({ fullName: text })}
                            onFocus={() => setFormErrors((prev) => ({ ...prev, fullName: '' }))}
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
                        {formErrors.fullName && (
                            <TextByVariant style={[components.errorText, gutters.marginTop_4]}>
                                {formErrors.fullName}
                            </TextByVariant>
                        )}
                    </View>

                    <View style={[gutters.paddingHorizontal_12, gutters.marginBottom_24]}>
                        <InputWithIconVariant
                            autoCapitalize="none"
                            cursorColor={colors.white}
                            direction='right'
                            onChangeText={(text) => updateUserPayload({ password: text })}
                            onFocus={() => setFormErrors((prev) => ({ ...prev, password: '' }))}
                            onSubmitEditing={() => phoneNumberRef.current?.focus()}
                            placeholder={t('create_account:password')}
                            placeholderTextColor={colors.white50}
                            ref={passwordRef}
                            returnKeyLabel='next'
                            returnKeyType='next'
                            secureTextEntry
                            selectionColor={colors.white}
                            style={[
                                layout.flex_1,
                                gutters.marginRight_10,
                                components.interDescription18UnAligned,
                                components.textLeft,
                            ]}
                            value={userPayload.password}
                        />
                        {formErrors.password && (
                            <TextByVariant style={[components.errorText, gutters.marginTop_4]}>
                                {formErrors.password}
                            </TextByVariant>
                        )}
                    </View>

                    <View style={[gutters.paddingHorizontal_12, gutters.marginBottom_32]}>
                        <InputVariant
                            autoCapitalize="none"
                            cursorColor={colors.white}
                            keyboardType='numbers-and-punctuation'
                            maxLength={10}
                            onChangeText={(text) => updateUserPayload({ phoneNumber: text })}
                            onFocus={() => setFormErrors((prev) => ({ ...prev, phoneNumber: '' }))}
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
                        {formErrors.phoneNumber && (
                            <TextByVariant style={[components.errorText, gutters.marginTop_4]}>
                                {formErrors.phoneNumber}
                            </TextByVariant>
                        )}
                    </View>
                    <Animated.View style={[gutters.paddingHorizontal_12, gutters.marginBottom_24, layout.row, layout.wrap, layout.itemsCenter, animatedStyle]}>
                        <Checkbox onToggle={handleCheckboxToggle} />
                        <TextByVariant style={[components.interDescription14, gutters.marginLeft_6]}>
                            {t('create_account:agreeTo')}
                        </TextByVariant>
                        <ButtonVariant
                            onPress={() => navigateAction(Paths.PrivacyPolicy)}
                        >
                            <TextByVariant style={[components.textButtoninterDescription14]}>
                                {" "}
                                {t('create_account:privacyPolicy')}
                            </TextByVariant>
                        </ButtonVariant>
                        <TextByVariant style={[components.interDescription14]}>
                            {" "}
                            {t('create_account:and')}
                        </TextByVariant>
                        <ButtonVariant
                            onPress={() => navigateAction(Paths.TermsOfUse)}
                        >
                            <TextByVariant style={[components.textButtoninterDescription14]}>
                                {" "}
                                {t('create_account:termsOfUse')}
                            </TextByVariant>
                        </ButtonVariant>
                    </Animated.View>
                    <ButtonVariant
                        disabled={isLoading || !userPayload.email || !userPayload.fullName || !userPayload.password || !userPayload.phoneNumber}
                        onPress={completeAction}
                        style={[(isLoading || !userPayload.email || !userPayload.fullName || !userPayload.password || !userPayload.phoneNumber) ? components.disabledButton : components.primaryButton, gutters.marginTop_48]}
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
