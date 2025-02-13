import swaggerJSDoc from "swagger-jsdoc";
import authDocs from "./authDocs.mjs";
import userDocs from "./userDocs.mjs";
import reviewDocs from "./reviewDocs.mjs";
import cartDocs from "./cartDocs.mjs";
import addressDocs from "./addressDocs.mjs";
import categoryDocs from "./categoryDocs.mjs";
import productDocs from "./productDocs.mjs";
import adminDocs from "./adminDocs.mjs";
import orderDocs from "./orderDocs.mjs";

const swaggerOptions = {
  definition: {
    openapi: "3.0.3",
    info: {
      title: "E-commerce API",
      version: "1.0.11",
      description:
        "Built with Express.js by memoowi, this demo e-commerce API offers a practical example of how to build an online store.  It covers essential features like product, user, category, review, cart, etc.",
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
      {
        name: "Order",
        description: "Order routes",
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
      ...adminDocs,
      ...orderDocs
    },
  },
  apis: ["./routes/*.mjs"],
  // apis: []
};

export const swaggerDocs = swaggerJSDoc(swaggerOptions);

export const swaggerUiOptions = {
  customCss: `
    body { background-color:rgb(232, 242, 255) !important; }
    .topbar { display: none; }
    .swagger-ui .information-container { padding: 0 !important; max-width: 100% !important; }
    .swagger-ui .info { background-color:rgb(0, 11, 81) !important; padding: 40px; color: white !important; text-align: center; margin: 0; }
    .swagger-ui .info .title { color:rgb(95, 149, 255) !important; font-weight: bold; }
    .swagger-ui .info .description p { color:rgb(255, 255, 255) !important; font-weight: 500; font-size: 16px; max-width: 640px !important; }
    .link { color:rgb(201, 143, 255) !important; font-size: 16px; }
    .link:hover { color:rgb(255, 251, 192) !important; text-decoration: underline }
    .swagger-ui .btn { background-color:rgb(29, 20, 147) !important; color: white !important; }
  `,
  customSiteTitle: "E-comm API by Memoowi", // Custom Page Title
  customfavIcon: "https://example.com/favicon.ico", // Custom Favicon
};
