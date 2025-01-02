import { z } from 'zod';

import { RequestHeaderSchema, ResponseHeaderSchema } from '@/hooks';

export const billSchema = z.object({
  billNumber: z.string(),
});

export type billType = z.infer<typeof billSchema>;

const RequestBodySchema = z.object({
  body: billSchema.extend({
    fcmToken: z.string(),
  }),
  requestHeader: RequestHeaderSchema,
});

export namespace RequestSpace {
  export type RequestBody = z.infer<typeof RequestBodySchema>;
}

export const UserSchema = z.object({
  billNumbers: z.array(z.string()),
  email: z.string(),
  fcmToken: z.string(),
  fullName: z.string(),
  profilePicture: z.string(),
  role: z.string(),
  username: z.string(),
});

const TokenInfoSchema = z.object({
  authToken: z.string(),
  expiresIn: z.number(),
  generatedAt: z.number(),
  refreshExpiresIn: z.number(),
  refreshToken: z.string(),
});

const ResponseBodySchema = z.object({
  tokenInfo: TokenInfoSchema,
  user: UserSchema,
});

const ApiResponseSchema = z.object({
  response: ResponseBodySchema,
  responseHeader: ResponseHeaderSchema,
});

export namespace UserResponseSpace {
  export type UserResponse = z.infer<typeof ApiResponseSchema>;
}

export const UserCreateSchema = z.object({
  email: z.string(),
  fullName: z.string(),
  password: z.string(),
  phoneNumber: z.string(),
});

export type User = z.infer<typeof UserCreateSchema>;
