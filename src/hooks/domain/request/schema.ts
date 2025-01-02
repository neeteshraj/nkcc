import { z } from 'zod';

const RequestHeaderSchema = z.object({
  action: z.string(),
  appVersion: z.string(),
  channel: z.string(),
  clientIp: z.string(),
  deviceId: z.string(),
  deviceModel: z.string(),
  deviceType: z.string(),
  languageCode: z.string(),
  requestId: z.string(),
  timestamp: z.string(),
});

export { RequestHeaderSchema };
