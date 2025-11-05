/* this function removes a  tab from the Resource horizontal menu, depending on the href
*/
function remove_tab(menu, which) {
    list = menu.querySelector("ul");
    if (typeof list !== "undefined" && list != null) {
        lis = list.querySelectorAll("li");
        if (typeof lis !== "undefined" && lis != null) {
            for (li of lis) {
                a = li.querySelector('a');
                if (a.href.match(which)) {
                    li.style.display = 'none';
                }
            }
        }
    }
}
/* 
    These functions are used to move the Resource horizontal menu to within the resizable pane 
    It assumes you've activated detect_elem.js in the layout_head_html.erb
*/
/* 
    get the horizontal menu 
    returns the object, or null
*/

function get_horiz() {
    tabRow = document.getElementById("tabs");
    if (typeof tabRow !== "undefined" && tabRow != null) {
        move = tabRow.querySelectorAll(".navbar-default");
        if (typeof move !== "undefined" && move != null && move.length != null && move.length > 0) {
            return (move[0]);
        }
    }
    return (null);
}

function move_horizontal_tabs() {
    sidebar = document.getElementById("sidebar");
    if (typeof sidebar !== "undefined" && sidebar != null ) {
        row = sidebar.parentElement;
        move = get_horiz();
        if (move != null) {
            remove_tab(move, "inventory") // get rid of the collection inventory tab
            move.classList.remove("col-sm-9");
            row = sidebar.parentElement;
            if (typeof row !== "undefined") {
                scope = row.getElementsByClassName("resizable-content-pane");
                if (typeof scope !== "undefined" && scope != null && scope.length != null && scope.length > 0) {
                    scope = scope[0];
                    scope.insertBefore(move, scope.children[0]);
                }
            }
        }
    }
}

/* organization and overview */
waitForElement('.resizable-content-pane').then(
        (element) => {
        move_horizontal_tabs();
        }
    );
/* digital */
waitForElement('#cite_modal').then(
    (element) => {
        menu = get_horiz();
        if (menu != null) {
            remove_tab(menu, 'inventory');
        }

    }
);
