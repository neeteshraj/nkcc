import { z } from 'zod';

const ResponseHeaderSchema = z.object({
  requestId: z.string(),
  responseDescription: z.string(),
  responseTitle: z.string(),
  status: z.number(),
  statusCode: z.string(),
  timeStamp: z.string(),
});

const ApiErrorSchema = z.object({
  data: z.object({
    responseHeader: ResponseHeaderSchema,
  }),
  status: z.number(),
});

export type DataResponseHeader = z.infer<typeof ResponseHeaderSchema>;
export type ApiError = z.infer<typeof ApiErrorSchema>;
export { ApiErrorSchema, ResponseHeaderSchema };


