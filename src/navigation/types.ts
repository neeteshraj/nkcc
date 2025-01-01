import type { StackScreenProps } from '@react-navigation/stack';
import type { Paths } from '@/navigation/paths';

export type RootStackParamList = {
  [Paths.Authenticated]: undefined;
  [Paths.CreateAccount]: undefined;
  [Paths.Example]: undefined;
  [Paths.Home]: undefined;
  [Paths.Onboarding]: undefined;
  [Paths.QRScan]: undefined;
  [Paths.Startup]: undefined;  
  [Paths.UnAuthenticated]: undefined;
};

export type RootScreenProps<
  S extends keyof RootStackParamList = keyof RootStackParamList,
> = StackScreenProps<RootStackParamList, S>;
