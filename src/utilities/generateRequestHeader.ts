import DeviceInfo from 'react-native-device-info';
import type {RequestSpace} from "@/hooks/domain/request/schema";

export const generateRequestHeader = async (
    langCode: string = 'en',
    appChannel: string = 'SCA',
    appAction: string = 'GET',
): Promise<RequestSpace.RequestHeader> => {
    const requestId = await generateUniqueId();
    const timestamp = new Date().toISOString();
    const channel = appChannel;
    const deviceType =
        DeviceInfo.getDeviceType() === 'Handset' ? 'MOBILE' : 'TABLET';
    const deviceId = await DeviceInfo.getUniqueId();
    const clientIp = await DeviceInfo.getIpAddress();
    const action = appAction;
    const appVersion = DeviceInfo.getVersion();
    const languageCode = langCode;
    const deviceModel = DeviceInfo.getModel();

    return {
        action,
        appVersion,
        channel,
        clientIp,
        deviceId,
        deviceModel,
        deviceType,
        languageCode,
        requestId,
        timestamp,
    };
};

const generateUniqueId = async (): Promise<string> => {
    const timestamp = new Date().getTime();
    const random = Math.floor(Math.random() * 1000);
    return `HOMEEASE-${timestamp}-${random}`;
};