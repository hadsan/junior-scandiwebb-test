/**
 * Terminal client for eshop database.
 */
"use strict";

// Read from commandline
const readline = require("readline");

// Import the module  src/eshop
const eshop = require("./src/eshop.js");

/**
 * Main function.
 *
 * @returns void
 */
(function() {
    const rl = readline.createInterface({
        input: process.stdin,
        output: process.stdout
    });

    console.log("Välkommen till BuckStar\n");
    menu();
    rl.setPrompt("\n--> ");
    rl.prompt();
    rl.on("close", process.exit);
    rl.on("line", async (line) => {
        line = line.trim();
        let split = line.split(" ");
        let cmd = split[0];
        let number;
        let id;
        let shelf;
        let str;

        switch (cmd) {
            case "quit":
            case "exit":
                process.exit();
                break;
            case "log":
                number = split[1];
                str = await eshop.showLog(number);
                console.log(str);
                break;
            case "menu":
                menu();
                break;
            case "shelf":
                str = await eshop.showShelfs();
                console.log(str);
                break;
            case "inventory":
                if (split.length == 1) {
                    str = await eshop.showInventory();
                    console.log(str);
                } else {
                    number = '%' + split[1] + '%';

                    console.log("\nSöker efter: " + number + '\n');

                    str = await eshop.filterInventory(number);

                    console.log(str);
                }
                break;
            case "invadd":
                id = split[1];
                shelf = split[2];
                number = split[3];
                if (number > 0) {
                    str = await eshop.addInventory(id, shelf, number);
                    console.log(str);
                }
                break;
            case "invdel":
                id = split[1];
                shelf = split[2];
                number = split[3];
                if (number > 0) {
                    str = await eshop.deleteInventory(id, shelf, number);
                    console.log(str);
                }
                break;
            case "order":
                if (split.length == 1) {
                    str = await eshop.showOrdersTable();
                    console.log(str);
                } else if (split.length == 2 && !isNaN(split[1])) {
                    console.log("\nSöker efter: " + split[1] + '\n');

                    str = await eshop.filterOrder(split[1]);

                    console.log(str);
                }
                break;
            case "picklist":
                if (split.length == 1) {
                    //no order id selected.
                    console.log("\nOBS! Mata in en orderID efter 'picklist'.");
                } else if (split.length == 2 && !isNaN(split[1])) {
                    number = split[1];
                    let array = await eshop.showOrderRows(number);

                    // get each order row and add to picklist.
                    for (var i = 0; i < array.length; i++) {
                        await eshop.createPicklist(number, array[i].produkt_id);
                    }
                    if (array.length != 0) {
                        str = await eshop.showPicklist(number);
                        console.log(str);
                    } else {
                        console.info('\nOBS! Order nr ' + number + ' finns ej/är raderad.\n');
                    }
                }
                break;
            case "ship":
                if (split.length == 1) {
                    //no order id selected.
                    console.log("\nOBS! Mata in en orderID efter 'ship'.");
                } else if (split.length == 2 && !isNaN(split[1])) {
                    number = split[1];
                    str = await eshop.showOrder(number);

                    if (str.length != 0) {
                        str = await eshop.shipOrder(number);

                        if (str == 'skickad') {
                            console.log("\nOrder nr." + number + " har skickats!\n");
                        } else if (str == 'raderad') {
                            console.log("\nOBS! Din order är " + str + "!\n");
                        } else if (str == 'uppdaterad' || str == 'skapad') {
                            console.log("\nStatus: '" + str + "' Gå in på hemsidan"
                                        + " och beställ din order först!\n");
                        } else {
                            console.log("\nOBS! Varor saknas/plock lista har inte skapats.");
                        }
                    } else {
                        console.log("\nOBS! Order nr. " + number + " finns inte!\n");
                    }
                }
                break;
            case "about":
                console.log("\nNedanstående är namnen på alla som har jobbat med"
                            +" E-shopen:\nHadsan Hassan\n");

                break;
            default:
                console.info("OBS! inmatningen '" + split.join(" ") + "'" +
                    "är inte ett giltigt kommando!\n");
                menu();
        }

        rl.prompt();
    });
})();

/**
 * Menu
 *
 *
 * @returns {string} returns menu.
 */
function menu() {
    let menu;

    menu = "Du kan välja bland de följande kommandon.\n" +
        "menu - Visar en meny för alla alternativ.\n" +
        "exit, quit, ctrl-c - Avslutar programmet.\n" +
        "log <limit> - se loggen och välj filtrera hur antal rader.\n" +
        "shelf - se lagret\n" +
        "inventory - se alla produkter i lagret\n" +
        "inventory <str> - flitrera genom produkterna i lagret\n" +
        "invadd <productid> <shelf> <number> - lägg till produkter i lagret\n" +
        "invdel <productid> <shelf> <number> - ta bort produkter från lagret\n" +
        "order <str> - filtrera genom alla order med kund/order ID.\n" +
        "order - se alla order.\n" +
        "picklist <orderid> - skapa och se en plocklista.\n" +
        "ship <orderid> - skicka iväg en order.\n" +
        "about - namn på dem som löst uppgiften.\n";
    console.info(menu);
}
