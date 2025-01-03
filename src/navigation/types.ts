import type { StackScreenProps } from '@react-navigation/stack';
import type { Paths } from '@/navigation/paths';

export type RootStackParamList = {
  [Paths.Authenticated]: undefined;
  [Paths.BottomTab]: undefined;
  [Paths.CreateAccount]: {
    billNumber: string;
  };
  [Paths.Example]: undefined;
  [Paths.Home]: undefined;
  [Paths.Onboarding]: undefined;
  [Paths.PrivacyPolicy]: undefined;
  [Paths.ProductDetails]: undefined;
  [Paths.Products]: undefined;
  [Paths.Profile]: undefined;
  [Paths.QRScan]: undefined;
  [Paths.Services]: undefined;
  [Paths.Startup]: undefined;
  [Paths.TermsOfUse]: undefined;
  [Paths.UnAuthenticated]: undefined;
};

export type RootScreenProps<
  S extends keyof RootStackParamList = keyof RootStackParamList,
> = StackScreenProps<RootStackParamList, S>;

export type CreateAccountScreenProps = StackScreenProps<
  RootStackParamList,
  Paths.CreateAccount
>;
export type ExampleScreenProps = StackScreenProps<
  RootStackParamList,
  Paths.Example
>;
export type HomeScreenProps = StackScreenProps<RootStackParamList, Paths.Home>;
export type OnboardingScreenProps = StackScreenProps<
  RootStackParamList,
  Paths.Onboarding
>;
export type PrivacyPolicyScreenProps = StackScreenProps<
  RootStackParamList,
  Paths.PrivacyPolicy
>;
export type QRScanScreenProps = StackScreenProps<
  RootStackParamList,
  Paths.QRScan
>;
export type StartupScreenProps = StackScreenProps<
  RootStackParamList,
  Paths.Startup
>;
export type TermsOfUseScreenProps = StackScreenProps<
  RootStackParamList,
  Paths.TermsOfUse
>;
export type UnAuthenticatedScreenProps = StackScreenProps<
  RootStackParamList,
  Paths.UnAuthenticated
>;
export type AuthenticatedScreenProps = StackScreenProps<
  RootStackParamList,
  Paths.Authenticated
>;
export type ProductsScreenProps = StackScreenProps<
  RootStackParamList,
  Paths.Products
>;
export type ProfileScreenProps = StackScreenProps<
  RootStackParamList,
  Paths.Profile
>;
export type ServicesScreenProps = StackScreenProps<
  RootStackParamList,
  Paths.Services
>;
export type BottomTabScreenProps = StackScreenProps<
  RootStackParamList,
  Paths.BottomTab
>;
export type ProductDetailsScreenProps = StackScreenProps<
  RootStackParamList,
  Paths.ProductDetails
>;
