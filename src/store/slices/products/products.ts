import type { PayloadAction } from '@reduxjs/toolkit';
import type { ProductResponseSpace } from '@/hooks';

import { createSlice } from '@reduxjs/toolkit';

interface ProductState {
  error: null | string;
  loading: boolean;
  products: ProductResponseSpace.ProductResponse['response'];
  responseHeader: null | ProductResponseSpace.ProductResponse['responseHeader'];
}

const initialState: ProductState = {
  error: null,
  loading: false,
  products: [],
  responseHeader: null,
};

const productSlice = createSlice({
  initialState,
  name: 'products',
  reducers: {
    appendProducts: (
        state,
        action: PayloadAction<{ newProducts: ProductResponseSpace.ProductResponse['response'] }>,
      ) => {
        state.products = [...state.products, ...action.payload.newProducts];
      },
    setError: (state, action: PayloadAction<null | string>) => {
      state.error = action.payload;
    },
    setLoading: (state, action: PayloadAction<boolean>) => {
      state.loading = action.payload;
    },
    setProducts: (
      state,
      action: PayloadAction<{
        products: ProductResponseSpace.ProductResponse['response'];
        responseHeader: ProductResponseSpace.ProductResponse['responseHeader'];
      }>,
    ) => {
      state.responseHeader = action.payload.responseHeader;
      state.products = action.payload.products;
    },
  },
});

export const productActions = productSlice.actions;
export const ProductReducer = productSlice.reducer;
export default productSlice.reducer;
