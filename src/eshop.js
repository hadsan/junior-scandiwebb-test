/**
 * A module exporting functions to access the eshop database.
 */
"use strict";

module.exports = {
    showCategories: showCategories,
    showProducts: showProducts,
    showProduct: showProduct,
    editProduct: editProduct,
    deleteProduct: deleteProduct,
    createProduct: createProduct,
    categoryProduct: categoryProduct,
    getInventory: getInventory,
    getShelfs: getShelfs,
    showLog: showLog,
    showShelfs: showShelfs,
    showInventory: showInventory,
    filterInventory: filterInventory,
    filterOrder: filterOrder,
    addInventory: addInventory,
    deleteInventory: deleteInventory,
    showOrdersTable: showOrdersTable,
    showCustomers: showCustomers,
    getCustomer: getCustomer,
    getOrderId: getOrderId,
    createOrder: createOrder,
    createOrderRow: createOrderRow,
    showOrders: showOrders,
    showCustomerOrders: showCustomerOrders,
    showOrder: showOrder,
    showOrderRows: showOrderRows,
    statusToOrdered: statusToOrdered,
    orderStatus: orderStatus,
    ShoworderStatus: ShoworderStatus,
    editOrder: editOrder,
    deleteOrder: deleteOrder,
    createOrderId: createOrderId,
    showPicklist: showPicklist,
    createPicklist: createPicklist,
    shipOrder: shipOrder
};

const mysql = require("promise-mysql");
const config = require("../config/db/eshop.json");
let db;



/**
 * Main function.
 * @async
 * @returns void
 */
(async function() {
    db = await mysql.createConnection(config);

    process.on("exit", () => {
        db.end();
    });
})();



/**
 * Output resultset as formatted table with details on eshop using npm 'cli-table'.
 *
 * @param {Array} number Resultset with details on from database query.
 *
 * @returns {string} Formatted table to print out.
 */
async function showLog(number) {
    let res;
    let sql;

    if (number == undefined) {
        sql = `SELECT
                    *
                    FROM logg;`;

        res = await db.query(sql);
    } else {
        sql = `SELECT
                    *
                    FROM logg
                    LIMIT ?
                    ;`;

        res = await db.query(sql, [parseInt(number)]);
    }

    let tableArr = [];
    var Table = require('cli-table');
    var table = new Table();

    // Add table headers.
    tableArr.push("Tidstämpel");
    tableArr.push("Händelse");
    table.push(tableArr);
    tableArr = [];

    // add table content
    for (const row of res) {
        tableArr.push(row.tidstampel.toString());
        tableArr.push(row.handelse);
        table.push(tableArr);
        tableArr = [];
    }
    return table.toString();
}

/**
 * Output resultset as formatted table with details on eshop using npm 'cli-table'.
 *
 *
 * @returns {string} Formatted table to print out.
 */
async function showShelfs() {
    let res;
    let sql;

    sql = `CALL show_shelfs();`;

    res = await db.query(sql);

    let tableArr = [];
    var Table = require('cli-table');
    var table = new Table();

    // Add table headers.
    tableArr.push("Hylla");
    table.push(tableArr);
    tableArr = [];

    // add table content
    for (const row of res[0]) {
        tableArr.push(row.hylla);
        table.push(tableArr);
        tableArr = [];
    }
    return table.toString();
}
/**
 * Output resultset as formatted table with details on eshop using npm 'cli-table'.
 *
 *
 * @returns {string} Formatted table to print out.
 */
async function showInventory() {
    let res;
    let sql;

    sql = `CALL show_inventory();`;

    res = await db.query(sql);

    let tableArr = [];
    var Table = require('cli-table');
    var table = new Table();

    // Add table headers.
    tableArr.push("ID");
    tableArr.push("Namn");
    tableArr.push("Antal");
    tableArr.push("Hylla");
    table.push(tableArr);
    tableArr = [];

    // add table content
    for (const row of res[0]) {
        tableArr.push(row.produkt_id);
        tableArr.push(row.namn);
        tableArr.push(row.antal.toString());
        tableArr.push(row.hylla);
        table.push(tableArr);
        tableArr = [];
    }
    return table.toString();
}

/**
 * Output resultset as formatted table with details on eshop using npm 'cli-table'.
 *
 *
 * @returns {string} Formatted table to print out.
 */
async function filterInventory(value) {
    let res;
    let sql;

    sql = `CALL filter_inventory(?);`;

    res = await db.query(sql, [value]);
    let tableArr = [];
    var Table = require('cli-table');
    var table = new Table();

    // Add table headers.
    tableArr.push("ID");
    tableArr.push("Namn");
    tableArr.push("Antal");
    tableArr.push("Hylla");
    table.push(tableArr);
    tableArr = [];

    // add table content
    for (const row of res[0]) {
        tableArr.push(row.produkt_id);
        tableArr.push(row.namn);
        tableArr.push(row.antal.toString());
        tableArr.push(row.hylla);
        table.push(tableArr);
        tableArr = [];
    }

    return table.toString();
}

/**
 * Output resultset as formatted table with details on eshop using npm 'cli-table'.
 *
 *
 * @returns {string} Formatted table to print out.
 */
async function filterOrder(value) {
    let res;
    let sql;

    sql = `CALL filter_order(?);`;

    res = await db.query(sql, [value]);
    let tableArr = [];
    var Table = require('cli-table');
    var table = new Table();

    // Add table headers.
    tableArr.push("ID");
    tableArr.push("KundID");
    tableArr.push("Namn");
    tableArr.push("Antal");
    tableArr.push("Skapad");
    tableArr.push("Status");

    table.push(tableArr);
    tableArr = [];
    // add table content
    for (const row of res[0]) {
        tableArr.push(row.orderid);
        tableArr.push(row.kundid);
        tableArr.push(row.namn);
        tableArr.push(row.antal.toString());
        tableArr.push(row.skapad.toString());
        tableArr.push(row.stat.toString());
        table.push(tableArr);
        tableArr = [];
    }
    return table.toString();
}

/**
 * Output resultset as formatted table with details on eshop using npm 'cli-table'.
 *
 *
 * @returns {string} Formatted table to print out.
 */
async function addInventory(id, shelf, number) {
    let res;
    let sql;

    sql = `CALL add_inventory(?, ?, ?);`;

    res = await db.query(sql, [id, shelf, number]);
    let tableArr = [];
    var Table = require('cli-table');
    var table = new Table();

    // Add table headers.
    tableArr.push("ID");
    tableArr.push("Namn");
    tableArr.push("Antal");
    tableArr.push("Hylla");
    table.push(tableArr);
    tableArr = [];

    // add table content
    for (const row of res[0]) {
        tableArr.push(row.produkt_id);
        tableArr.push(row.namn);
        tableArr.push(row.antal.toString());
        tableArr.push(row.hylla);
        table.push(tableArr);
        tableArr = [];
    }

    return table.toString();
}

/**
 * Output resultset as formatted table with details on eshop using npm 'cli-table'.
 *
 *
 * @returns {string} Formatted table to print out.
 */
async function deleteInventory(id, shelf, number) {
    let res;
    let sql;

    sql = `CALL delete_inventory(?, ?, ?);`;

    res = await db.query(sql, [id, shelf, number]);
    let tableArr = [];
    var Table = require('cli-table');
    var table = new Table();

    // Add table headers.
    tableArr.push("ID");
    tableArr.push("Namn");
    tableArr.push("Antal");
    tableArr.push("Hylla");
    table.push(tableArr);
    tableArr = [];

    // add table content
    for (const row of res[0]) {
        tableArr.push(row.produkt_id);
        tableArr.push(row.namn);
        tableArr.push(row.antal.toString());
        tableArr.push(row.hylla);
        table.push(tableArr);
        tableArr = [];
    }

    return table.toString();
}


/**
 * Output resultset as formatted table with details on eshop using npm 'cli-table'.
 *
 *
 * @returns {string} Formatted table to print out.
 */
async function showOrdersTable() {
    let res;
    let sql;

    sql = `CALL show_orders();`;

    res = await db.query(sql);

    let tableArr = [];
    var Table = require('cli-table');
    var table = new Table();

    // Add table headers.
    tableArr.push("ID");
    tableArr.push("KundID");
    tableArr.push("Namn");
    tableArr.push("Antal");
    tableArr.push("Skapad");
    tableArr.push("Status");

    table.push(tableArr);
    tableArr = [];
    // add table content
    for (const row of res[0]) {
        tableArr.push(row.orderid);
        tableArr.push(row.kundid);
        tableArr.push(row.namn);
        tableArr.push(row.antal.toString());
        tableArr.push(row.skapad.toString());
        tableArr.push(row.stat.toString());
        table.push(tableArr);
        tableArr = [];
    }
    return table.toString();
}

/**
 * Show all categories.
 *
 * @async
 * @returns {RowDataPacket} Resultset from the query.
 */
async function showCategories() {
    let sql = `CALL show_categories();`;
    let res;

    res = await db.query(sql);
    //console.log(res);
    console.info(`SQL: ${sql} got ${res.length} rows.`);

    return res[0];
}

/**
 * Show all products.
 *
 * @async
 * @returns {RowDataPacket} Resultset from the query.
 */
async function showProducts() {
    let sql = `CALL show_products();`;
    let res;

    res = await db.query(sql);
    //console.log(res);
    console.info(`SQL: ${sql} got ${res.length} rows.`);

    return res[0];
}

/**
 * Edit details on a product.
 *
 * @async
 * @param {string} id      The id of the product to be updated.
 * @param {int} price The updated price of the product.
 * @param {string} name    The updated name of the product.
 *
 * @returns {void}
 */
async function editProduct(id, price, name) {
    let sql = `CALL edit_product(?, ?, ?);`;
    let res;

    res = await db.query(sql, [id, price, name]);
    //console.log(res);
    console.info(`SQL: ${sql} got ${res.length} rows.`);
}

/**
 * Show details for a product.
 *
 * @async
 * @param {string} id A id of the product.
 *
 * @returns {RowDataPacket} Resultset from the query.
 */
async function showProduct(id) {
    let sql = `CALL show_product(?);`;
    let res;

    res = await db.query(sql, [id]);
    //console.log(res);
    console.info(`SQL: ${sql} got ${res.length} rows.`);

    return res[0];
}


/**
 * Show details for a category.
 *
 * @async
 * @param {string} id A id of the category.
 *
 * @returns {RowDataPacket} Resultset from the query.
 */
async function categoryProduct(id) {
    let sql = `CALL show_category_products(?);`;
    let res;

    res = await db.query(sql, [id]);
    //console.log(res);
    console.info(`SQL: ${sql} got ${res.length} rows.`);

    return res[0];
}

/**
 * Delete a product.
 *
 * @async
 * @param {string} id      The id of the product to be deleted.
 *
 * @returns {void}
 */
async function deleteProduct(id) {
    let sql = `CALL delete_product(?);`;
    let res;

    res = await db.query(sql, [id]);

    console.info(`SQL: ${sql} got ${res.length} rows.`);
}


/**
 * Create a new product.
 *
 * @async
 * @param {string} id      id of the product.
 * @param {int} pris
 * @param {string} namn
 * @param {string} beskrivning
 * @param {string} kategori
 * @param {antal} antal
 *
 * @returns {void}
 */
async function createProduct(id, pris, namn, beskrivning, kategori, hylla, antal) {
    let sql = `CALL create_product(?, ?, ?, ?, ?, ?, ?);`;
    let res;

    res = await db.query(sql, [id, pris, namn, beskrivning, kategori, hylla, antal]);
    console.log(res);
    console.info(`SQL: ${sql} got ${res.length} rows.`);
}

/**
 * Get inventory.
 *
 * @async
 *
 * @returns {void}
 * @returns {RowDataPacket} Resultset from the query.
 */
async function getInventory() {
    let sql = `CALL show_inventory();`;
    let res;

    res = await db.query(sql);
    console.log(res);
    console.info(`SQL: ${sql} got ${res.length} rows.`);
    return res[0];
}

/**
 * Get inventory.
 *
 * @async
 *
 * @returns {void}
 * @returns {RowDataPacket} Resultset from the query.
 */
async function getShelfs() {
    let sql = `CALL show_shelfs();`;
    let res;

    res = await db.query(sql);
    console.log(res);
    console.info(`SQL: ${sql} got ${res.length} rows.`);
    return res[0];
}

/**
 * Show all customers.
 *
 * @async
 * @returns {RowDataPacket} Resultset from the query.
 */
async function showCustomers() {
    let sql = `CALL show_customers();`;
    let res;

    res = await db.query(sql);
    //console.log(res);
    console.info(`SQL: ${sql} got ${res.length} rows.`);

    return res[0];
}

/**
 * Show a customer.
 *
 * @async
 * @param {id} id
 * @returns {RowDataPacket} Resultset from the query.
 */
async function getCustomer(id) {
    let sql = `CALL show_customer(?);`;
    let res;

    res = await db.query(sql, [id]);
    //console.log(res);
    console.info(`SQL: ${sql} got ${res.length} rows.`);

    return res[0];
}

/**
 * Show the next order id.
 *
 * @async
 * @returns {RowDataPacket} Resultset from the query.
 */
async function createOrderId() {
    let sql = `CALL next_order_id();`;
    let res;

    res = await db.query(sql);
    //console.log(res);
    console.info(`SQL: ${sql} got ${res.length} rows.`);

    return res[0][0].id;
}

/**
 * Show a customer.
 *
 * @async
 * @param {id} id
 * @returns {RowDataPacket} Resultset from the query.
 */
async function getOrderId(id) {
    let sql = `CALL get_customer_order(?);`;
    let res;

    res = await db.query(sql, [id]);
    //console.log(res);
    console.info(`SQL: ${sql} got ${res.length} rows.`);

    return res[0][0].kund_id;
}

/**
 * Show customers orders.
 *
 * @async
 * @returns {RowDataPacket} Resultset from the query.
 */
async function showOrders() {
    let sql = `CALL show_orders();`;
    let res;

    res = await db.query(sql);
    //console.log(res);
    console.info(`SQL: ${sql} got ${res.length} rows.`);

    return res[0];
}

/**
 * Show specific customers orders.
 * @param {id} id
 * @async
 * param
 * @returns {RowDataPacket} Resultset from the query.
 */
async function showCustomerOrders(id) {
    let sql = `CALL show_customers_orders(?);`;
    let res;

    res = await db.query(sql, [id]);
    //console.log(res);
    console.info(`SQL: ${sql} got ${res.length} rows.`);

    return res[0];
}

/**
 * Edit customers order.
 *
 * @async
 * @param {id} orderid
 * @param {id} produktid
 * @param {id} antal
 * @returns {RowDataPacket} Resultset from the query.
 */
async function editOrder(orderid, produktid, antal) {
    let sql = `CALL edit_order(?, ?, ?);`;
    let res;

    res = await db.query(sql, [orderid, produktid, antal]);
    console.info(`SQL: ${sql} got ${res.length} rows.`);

    return res[0];
}

/**
 * Delete customers order.
 *
 * @async
 * @param {id} orderid
 * @returns {RowDataPacket} Resultset from the query.
 */
async function deleteOrder(orderid) {
    let sql = `CALL delete_order(?);`;
    let res;

    res = await db.query(sql, [orderid]);
    console.info(`SQL: ${sql} got ${res.length} rows.`);

    return res[0];
}

/**
 * Show customers order.
 *
 * @async
 * @param {id} id
 * @returns {RowDataPacket} Resultset from the query.
 */
async function showOrder(id) {
    let sql = `CALL show_order(?);`;
    let res;

    res = await db.query(sql, [id]);

    return res[0];
}

/**
 * Show customers orderrows.
 *
 * @async
 * @param {id} id
 * @returns {RowDataPacket} Resultset from the query.
 */
async function showOrderRows(id) {
    let sql = `CALL show_orderrows(?);`;
    let res;

    res = await db.query(sql, [id]);

    return res[0];
}

/**
 * @returns {RowDataPacket} Resultset from the query.
 * @param {int} id      id of the order.
 */
async function createOrder(id) {
    let sql = `CALL create_order(?);`;
    let res;

    res = await db.query(sql, [id]);
    console.log(res);
    console.info(`SQL: ${sql} got ${res.length} rows.`);
    return res[0];
}


/**
 * @returns {RowDataPacket} Resultset from the query.
 * @param {int} orderid      id of the order.
 * @param {string} produktid
 * @param {string} namn
 * @param {int} pris
 * @param {int} antal
 * @returns {void}
 */
async function createOrderRow(orderid, produktid, namn, pris, antal) {
    let sql = `CALL create_orderrow(?, ?, ?, ?, ?);`;
    let res;

    res = await db.query(sql, [orderid, produktid, namn, pris, antal]);
    console.log(res);
    console.info(`SQL: ${sql} got ${res.length} rows.`);
}

/**
 * @returns {RowDataPacket} Resultset from the query.
 * @param {int} orderid      id of the order.
 */
async function orderStatus(orderid) {
    let sql = `CALL order_status(?);`;
    let res;

    res = await db.query(sql, [orderid]);
    console.log(res);
    console.info(`SQL: ${sql} got ${res.length} rows.`);
}


/**
 * @returns {RowDataPacket} Resultset from the query.
 * @param {int} orderid      id of the order.
 */
async function ShoworderStatus(orderid) {
    let sql = `CALL show_orderstatus(?);`;
    let res;

    res = await db.query(sql, [orderid]);
    return res[0][0].stat;
}


/**
 * @returns {RowDataPacket} Resultset from the query.
 * @param {int} orderid      id of the order.
 */
async function shipOrder(orderid) {
    let sql = `CALL ship_order(?);`;

    await db.query(sql, [orderid]);
    let str = await ShoworderStatus(orderid);

    return str;
}

/**
 * @returns {RowDataPacket} Resultset from the query.
 * @param {int} orderid      id of the order.
 */
async function statusToOrdered(orderid) {
    let sql = `CALL bestall_status(?);`;
    let res;

    res = await db.query(sql, [orderid]);
    console.log(res);
    console.info(`SQL: ${sql} got ${res.length} rows.`);
}

/**
 * @returns {RowDataPacket} Resultset from the query.
 * @param {int} orderid      id of the order.
 */
async function showPicklist(orderid) {
    let sql = `CALL show_picklist(?);`;
    let res;

    res = await db.query(sql, [orderid]);

    let tableArr = [];
    var Table = require('cli-table');
    var table = new Table();

    // Add table headers.
    tableArr.push("OrderID");
    tableArr.push("ProduktID");
    tableArr.push("Antal");
    tableArr.push("Hylla");
    tableArr.push("Status");

    table.push(tableArr);
    tableArr = [];
    // add table content
    for (const row of res[0]) {
        tableArr.push(row.order_id);
        tableArr.push(row.produkt_id);
        tableArr.push(row.antal.toString());
        tableArr.push(row.hylla);
        tableArr.push(row.stat);
        table.push(tableArr);
        tableArr = [];
    }
    return table.toString();
}

/**
 * @returns {RowDataPacket} Resultset from the query.
 * @param {int} orderid      id of the order.
 * @param {string} produktid      id of the product.
 */
async function createPicklist(orderid, produktid) {
    let sql = `CALL create_picklist(?, ?);`;

    await db.query(sql, [orderid, produktid]);
}
