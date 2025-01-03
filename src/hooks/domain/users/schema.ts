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

export const UserCreateBodySchema = z.object({
  billNumbers: z.array(z.string()),
  email: z.string(),
  fcmToken: z.string(),
  fullName: z.string(),
  grantType: z.string(),
  password: z.string(),
  phoneNumber: z.string(),
  role: z.string(),
});

export type User = z.infer<typeof UserCreateBodySchema>;

export const UserCreateSchema = z.object({
  body: UserCreateBodySchema,
  requestHeader: RequestHeaderSchema,
});

export namespace UserCreateSpace {
  export type UserCreate = z.infer<typeof UserCreateSchema>;
}

export const UserErrorSchema = z.object({
  email: z.string().email("Invalid email address"),
  fullName: z.string().min(1, "Full name is required"),
  password: z.string().min(8, "Password must be at least 8 characters"),
  phoneNumber: z.string().min(10, "Phone number must be 10 digits"),
});

export type UserError = z.infer<typeof UserErrorSchema>;