import type { PayloadAction } from '@reduxjs/toolkit';
import type { MyOwnProductResponseSpace, ProductResponseSpace } from '@/hooks';

import { createSlice } from '@reduxjs/toolkit';

interface MyOwnedProductState {
  error: null | string;
  loading: boolean;
  products: MyOwnProductResponseSpace.MyOwnProductResponse['response'];
  responseHeader: MyOwnProductResponseSpace.MyOwnProductResponse['responseHeader'] | null;
}

const initialState: MyOwnedProductState = {
  error: null,
  loading: false,
  products: [],
  responseHeader: null,
};

const myOwnProductSlice = createSlice({
  initialState,
  name: 'myProducts',
  reducers: {
    appendMyProducts: (
      state,
      action: PayloadAction<{
        newProducts: ProductResponseSpace.ProductResponse['response'];
      }>,
    ) => {
      state.products = [...state.products, ...action.payload.newProducts];
    },
    setError: (state, action: PayloadAction<null | string>) => {
      state.error = action.payload;
    },
    setLoading: (state, action: PayloadAction<boolean>) => {
      state.loading = action.payload;
    },
    setMyProducts: (
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

export const myOwnProductActions = myOwnProductSlice.actions;
export const MyOwnProductReducer = myOwnProductSlice.reducer;
export default myOwnProductSlice.reducer;
