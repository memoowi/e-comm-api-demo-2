import swaggerJSDoc from "swagger-jsdoc";
import authDocs from "./authDocs.mjs";
import userDocs from "./userDocs.mjs";
import reviewDocs from "./reviewDocs.mjs";
import cartDocs from "./cartDocs.mjs";
import addressDocs from "./addressDocs.mjs";
import categoryDocs from "./categoryDocs.mjs";
import productDocs from "./productDocs.mjs";
import adminDocs from "./adminDocs.mjs";

const swaggerOptions = {
  definition: {
    openapi: "3.0.3",
    info: {
      title: "E-commerce API",
      version: "1.0.11",
      description:
        "an API for an e-commerce website build with Express.js by memoowi",
      contact: {
        name: "memoowi",
        email: "megatenlike@gmail.com",
        url: "https://memoowi.site",
      },
    },
    servers: [{ url: "http://localhost:5000/api" }],
    tags: [
      {
        name: "Admin",
        description: "Admin routes -  NOT 4U SIKE KWAAAKKK 🦅🦅",
      },
      {
        name: "Authentication",
        description: "Authentication routes",
      },
      {
        name: "User",
        description: "User profile routes",
      },
      {
        name: "Category",
        description: "Category routes",
      },
      {
        name: "Product",
        description: "Product routes",
      },
      {
        name: "Review",
        description: "Review routes",
      },
      {
        name: "Cart",
        description: "Cart routes",
      },
      {
        name: "Address",
        description: "Address routes",
      },
    ],
    paths: {
      ...authDocs,
      ...userDocs,
      ...reviewDocs,
      ...cartDocs,
      ...addressDocs,
      ...categoryDocs,
      ...productDocs,
      ...adminDocs
    },
  },
  apis: ["./routes/*.mjs"],
  // apis: []
};

export const swaggerDocs = swaggerJSDoc(swaggerOptions);
