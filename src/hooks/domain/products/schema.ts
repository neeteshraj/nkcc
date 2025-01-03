import { z } from 'zod';

const specificationSchema = z.object({
  capacity: z.string(),
  createdAt: z.string(),
  dimensions: z.string(),
  features: z.array(z.string()),
  filterStages: z.number(),
  material: z.string(),
  powerRating: z.string(),
  updatedAt: z.string(),
  weight: z.string(),
});

const compatiblePartSchema = z.object({
  _id: z.string(),
  createdAt: z.string(),
  partName: z.string(),
  partNumber: z.string(),
  replacementFrequency: z.string(),
  updatedAt: z.string(),
});

const manualAndResourceSchema = z.object({
  _id: z.string(),
  createdAt: z.string(),
  title: z.string(),
  updatedAt: z.string(),
  url: z.string(),
});

const productSchema = z.object({
  _id: z.string(),
  brand: z.string(),
  category: z.string(),
  certifications: z.array(z.string()),
  compatibleParts: z.array(compatiblePartSchema),
  cover: z.string(),
  description: z.string(),
  discount: z.number(),
  images: z.array(z.string()),
  manualsAndResources: z.array(manualAndResourceSchema),
  model: z.string(),
  name: z.string(),
  notes: z.string(),
  price: z.number(),
  productTypeId: z.string(),
  rating: z.number(),
  releaseDate: z.string(),
  reviews: z.number(),
  slug: z.string(),
  sold: z.number(),
  specifications: specificationSchema,
  status: z.string(),
  stock: z.number(),
  thumbnail: z.string(),
  warranty: z.number(),
  warrantyDescription: z.string(),
  warrantyType: z.string(),
});

const responseHeaderSchema = z.object({
  limit: z.number(),
  pageNumber: z.number(),
  requestId: z.string(),
  responseDescription: z.string(),
  responseTitle: z.string(),
  status: z.number(),
  statusCode: z.string(),
  timeStamp: z.string(),
  totalCount: z.number(),
});

const responseSchema = z.object({
  response: z.array(productSchema),
  responseHeader: responseHeaderSchema,
});

export type ProductResponseType = z.infer<typeof responseSchema>;

export namespace ProductResponseSpace {
  export type ProductResponse = z.infer<typeof responseSchema>;
}
