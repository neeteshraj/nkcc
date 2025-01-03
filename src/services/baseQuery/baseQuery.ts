import type {
  BaseQueryFn,
  FetchArgs,
  FetchBaseQueryError,
} from '@reduxjs/toolkit/query/react';
import type { RootState } from '@/store';

import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react';

import { API_BASE_URL } from '@/config';

const baseQuery = fetchBaseQuery({
  baseUrl: API_BASE_URL,
  prepareHeaders: (headers, { getState }) => {
    // headers.set('Content-Type', 'application/json');
    const token = (getState() as RootState).user.tokenInfo?.authToken;
    if (token) {
      headers.set('Authorization', `Bearer ${token}`);
    }
    return headers;
  },
});

const baseQueryWithInterceptor: BaseQueryFn<
  FetchArgs | string,
  unknown,
  FetchBaseQueryError
> = async (args, api, extraOptions) => {
  try {
    const result = await baseQuery(args, api, extraOptions);

    if (result.error && result.error.status === 401) {
      console.error('Unauthorized request');
    }

    return result;
  } catch (error) {
    console.error('Request error:', error);
    throw error;
  } finally {
  }
};

export const api = createApi({
  baseQuery: baseQueryWithInterceptor,
  endpoints: () => ({}),
  reducerPath: 'api',
  refetchOnReconnect: true,
});
