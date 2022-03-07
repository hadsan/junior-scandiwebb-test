/**
 * Route for eshop.
 */
"use strict";

const express = require("express");
const router = express.Router();
const eshop = require("../src/eshop.js");
const bodyParser = require("body-parser");
const urlencodedParser = bodyParser.urlencoded({
    extended: false
});
const sitename = "| BuckStar";

router.get("/index", async (req, res) => {
    let data = {
        title: "Välkommen | BuckStar"
    };

    data.res = await eshop.showProducts();
    res.render("eshop/index", data);
});

router.get("/about", (req, res) => {
    let data = {
        title: "Om | BuckStar"
    };

    res.render("eshop/about-me", data);
});

router.get("/category", async (req, res) => {
    let data = {
        title: "Kategorier | BuckStar"
    };

    data.res = await eshop.showCategories();

    res.render("eshop/category-show", data);
});

router.get("/product", async (req, res) => {
    let data = {
        title: "Produkter | BuckStar"
    };

    data.res = await eshop.showProducts();

    res.render("eshop/product-show", data);
});

router.get("/edit/:id", async (req, res) => {
    let id = req.params.id;
    let data = {
        title: `Edit product ${id} ${sitename}`,
        product: id
    };

    data.res = await eshop.showProduct(id);

    res.render("eshop/product-edit", data);
});

router.post("/edit", urlencodedParser, async (req, res) => {
    // console.log(JSON.stringify(req.body, null, 4));
    await eshop.editProduct(req.body.id, req.body.pris, req.body.namn);
    res.redirect("/eshop/product");
});

router.get("/product/:id", async (req, res) => {
    let id = req.params.id;
    let data = {
        title: `Product ${id} ${sitename}`,
        product: id
    };

    data.res = await eshop.showProduct(id);

    res.render("eshop/product-view", data);
});

router.get("/category/:id", async (req, res) => {
    let id = req.params.id;
    let data = {
        title: `Kategori ${id} ${sitename}`,
        category: id
    };

    data.res = await eshop.categoryProduct(id);

    res.render("eshop/product-category", data);
});

router.get("/delete/:id", async (req, res) => {
    let id = req.params.id;
    let data = {
        title: `Delete product ${id} ${sitename}`,
        product: id
    };

    data.res = await eshop.showProduct(id);

    res.render("eshop/product-delete", data);
});

router.post("/delete", urlencodedParser, async (req, res) => {
    // console.log(JSON.stringify(req.body, null, 4));
    console.log(req.body.id);
    await eshop.deleteProduct(req.body.id);
    res.redirect("/eshop/product");
});

router.get("/create", async (req, res) => {
    let data = {
        title: "Create product | BuckStar",
        inv: await eshop.getShelfs()
    };

    data.res = await eshop.showCategories();
    res.render("eshop/product-create", data);
});

router.post("/create", urlencodedParser, async (req, res) => {
    // Extract the data from the posted form
    // console.log(JSON.stringify(req.body, null, 4));
    await eshop.createProduct(req.body.id, req.body.pris, req.body.namn,
        req.body.beskrivning, req.body.kategori, req.body.hylla, req.body.antal);
    res.redirect("/eshop/product");
});

router.get("/about", async (req, res) => {
    let data = {
        title: "Hadsan | BuckStar"
    };

    data.res = "HI";
    res.render("eshop/about-me", data);
});

router.get("/orders", async (req, res) => {
    let data = {
        title: "Beställningar | BuckStar"
    };

    data.res = await eshop.showOrders();
    res.render("eshop/orders-view", data);
});

router.get("/order/:id", async (req, res) => {
    let orderId = req.params.id;
    let customerId = await eshop.getOrderId(orderId);
    let customer = await eshop.getCustomer(customerId);
    let orderStatus = await eshop.ShoworderStatus(orderId);
    let namn = customer[0].Namn;
    let data = {
        title: `Order ${orderId} ${namn}`,
        customerId: customerId,
        orderId: orderId,
        orderStatus: orderStatus,
        namn: namn
    };

    data.res = await eshop.showOrderRows(orderId);
    res.render("eshop/order-view", data);
});

router.get("/orders/:id", async (req, res) => {
    let id = req.params.id;
    let customer = await eshop.getCustomer(id);
    let namn = customer[0].Namn;
    let data = {
        title: `Order ${id} ${sitename}`,
        id: id,
        namn: namn
    };

    data.res = await eshop.showCustomerOrders(id);

    res.render("eshop/customers-orders-view", data);
});

router.get("/customers", async (req, res) => {
    let data = {
        title: "Kunder | BuckStar"
    };

    data.res = await eshop.showCustomers();
    res.render("eshop/customers-view", data);
});

router.get("/new-order/:id", async (req, res) => {
    let id = req.params.id;
    let orderId = await eshop.createOrderId();

    res.redirect("/eshop/create-order/" + id + "/" + orderId);
});

router.get("/create-order/:customer_id/:id", async (req, res) => {
    let id = req.params.customer_id;
    let orderId = req.params.id;
    let data = {
        title: "Skapa beställning | BuckStar",
        id: id,
        orderId: orderId,
    };

    data.res = await eshop.showProducts();
    res.render("eshop/order-create", data);
});

router.post("/create-order/:customer_id/:id", urlencodedParser, async (req, res) => {
    let id = req.params.customer_id;
    let orderId = req.params.id;

    await eshop.createOrder(id);
    await eshop.orderStatus(orderId);
    await eshop.createOrderRow(orderId, req.body.produkt_id, req.body.namn,
        req.body.pris, req.body.total);
    res.redirect("/eshop/cart/" + id + "/" + orderId);
});

router.get("/add-order/:customer_id/:id", async (req, res) => {
    let id = req.params.customer_id;
    let orderId = req.params.id;
    let data = {
        title: "Skapa beställning | BuckStar",
        id: id,
        orderId: orderId,
    };

    data.res = await eshop.showProducts();
    res.render("eshop/order-create", data);
});

router.post("/add-order/:customer_id/:id", urlencodedParser, async (req, res) => {
    let id = req.params.customer_id;
    let orderId = req.params.id;

    await eshop.orderStatus(orderId);
    await eshop.createOrderRow(orderId, req.body.produkt_id, req.body.namn,
        req.body.pris, req.body.total);
    res.redirect("/eshop/cart/" + id + "/" + orderId);
});

router.get("/edit-order/:id", async (req, res) => {
    let orderId = req.params.id;
    let customerId = await eshop.getOrderId(orderId);
    let customer = await eshop.getCustomer(customerId);
    let orderStatus = await eshop.ShoworderStatus(orderId);
    let namn = customer[0].Namn;
    let data = {
        title: "Redigera beställning | BuckStar",
        orderId: orderId,
        customerId: customerId,
        orderStatus: orderStatus,
        namn: namn
    };

    data.res = await eshop.showOrderRows(orderId);
    res.render("eshop/order-edit", data);
});

router.post("/edit-order/:id", urlencodedParser, async (req, res) => {
    let orderId = req.params.id;
    let customerId = await eshop.getOrderId(orderId);

    await eshop.editOrder(orderId, req.body.produkt_id, req.body.antal);
    await eshop.orderStatus(orderId);
    res.redirect("/eshop/orders/" + customerId);
});

router.get("/delete-order/:id", async (req, res) => {
    let orderId = req.params.id;
    let customerId = await eshop.getOrderId(orderId);
    let customer = await eshop.getCustomer(customerId);
    let namn = customer[0].Namn;
    let orderStatus = await eshop.ShoworderStatus(orderId);
    let data = {
        title: "Radera beställning | BuckStar",
        orderId: orderId,
        orderStatus: orderStatus,
        namn: namn
    };

    data.res = await eshop.showOrderRows(orderId);
    res.render("eshop/delete-order", data);
});

router.post("/delete-order/:id", urlencodedParser, async (req, res) => {
    let orderId = req.params.id;
    let customerId = await eshop.getOrderId(orderId);

    await eshop.deleteOrder(orderId);
    await eshop.orderStatus(orderId);
    res.redirect("/eshop/orders/" + customerId);
});

router.get("/cart/:customer_id/:id", async (req, res) => {
    let id = req.params.customer_id;
    let orderId = req.params.id;
    let customer = await eshop.getCustomer(id);
    let namn = customer[0].Namn;
    let data = {
        title: "Varukorg | BuckStar",
        orderId: orderId,
        id: id,
        namn: namn
    };

    data.res = await eshop.showOrderRows(orderId);
    await eshop.orderStatus(orderId);
    res.render("eshop/cart", data);
});

router.get("/order-complete/:id", urlencodedParser, async (req, res) => {
    let orderId = req.params.id;
    let customerId = await eshop.getOrderId(orderId);
    let customer = await eshop.getCustomer(customerId);
    let namn = customer[0].Namn;
    let data = {
        title: "Beställning | BuckStar",
        orderId: orderId,
        namn: namn
    };

    await eshop.statusToOrdered(orderId);
    await eshop.orderStatus(orderId);
    res.render("eshop/ordered", data);
});

router.get("/customer/:id", urlencodedParser, async (req, res) => {
    let id = req.params.id;
    let customer = await eshop.getCustomer(id);
    let namn = customer[0].Namn;
    let data = {
        title: "Beställning | BuckStar",
        id: id,
        namn: namn
    };

    data.res = await eshop.getCustomer(id);
    res.render("eshop/customer-view", data);
});
module.exports = router;
