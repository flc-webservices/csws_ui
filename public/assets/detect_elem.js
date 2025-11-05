/*
   This script is used to detect when an element is created in the DOM. 
   You can address the element as an id ("#foo") or a class (".bar").  
   At this time, you are limited to only the first element of the class.
*/


function waitForElement(selector) {
    return new Promise((resolve) => {
        const observer = new MutationObserver((mutations, observer) => {
            const nodelist = document.querySelectorAll(selector);
            if (nodelist && nodelist.length > 0) {
                element = nodelist[0];
                observer.disconnect();
                resolve(element);
            }
        });

        observer.observe(document, {
            childList: true,
            subtree: true,
        });
    });
}

