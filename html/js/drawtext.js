let direction = null;

/**
 * Draws text on the screen
 * @param {{text: string, position?: 'left' | 'right' | 'top'}} textData
 */
const drawText = async (textData) => {
    const text = document.getElementById("text");
    let { position } = textData;
    switch (textData.position) {
        case "left":
            addClass(text, position);
            direction = "left";
            break;
        case "top":
            addClass(text, position);
            direction = "top";
            break;
        case "right":
            addClass(text, position);
            direction = "right";
            break;
        default:
            addClass(text, "left");
            direction = "left";
            break;
    }

    text.innerHTML = textData.text;
    document.getElementById("drawtext-container").style.display = "block";
    await sleep(100);
    addClass(text, "show");
};

/**
 * Changes the text on the screen
 * @param {{text: string, position?: 'left' | 'right' | 'top'}} textData
 */
const changeText = async (textData) => {
    const text = document.getElementById("text");
    let { position } = textData;

    removeClass(text, "show");
    addClass(text, "pressed");
    addClass(text, "hide");

    await sleep(500);
    removeClass(text, "left");
    removeClass(text, "right");
    removeClass(text, "top");
    removeClass(text, "bottom");
    removeClass(text, "hide");
    removeClass(text, "pressed");

    switch (textData.position) {
        case "left":
            addClass(text, position);
            direction = "left";
            break;
        case "top":
            addClass(text, position);
            direction = "top";
            break;
        case "right":
            addClass(text, position);
            direction = "right";
            break;
        default:
            addClass(text, "left");
            direction = "left";
            break;
    }
    text.innerHTML = textData.text;

    await sleep(100);
    text.classList.add("show");
};

/**
 * Hides the displayed text
 */
const hideText = async () => {
    const text = document.getElementById("text");
    removeClass(text, "show");
    addClass(text, "hide");

    setTimeout(() => {
        removeClass(text, "left");
        removeClass(text, "right");
        removeClass(text, "top");
        removeClass(text, "bottom");
        removeClass(text, "hide");
        removeClass(text, "pressed");
        document.getElementById("drawtext-container").style.display = "none";
    }, 1000);
};

/**
 * Handles key press events
 */
const keyPressed = () => {
    const text = document.getElementById("text");
    addClass(text, "pressed");
};

window.addEventListener("message", (event) => {
    const data = event.data;
    const action = data.action;
    const textData = data.data;
    switch (action) {
        case "DRAW_TEXT":
            return drawText(textData);
        case "CHANGE_TEXT":
            return changeText(textData);
        case "HIDE_TEXT":
            return hideText();
        case "KEY_PRESSED":
            return keyPressed();
        default:
            return;
    }
});

/**
 * Sleep function to delay execution for a given number of milliseconds.
 * @param {number} ms
 * @returns Promise<void>
 */
const sleep = (ms) => {
    return new Promise((resolve) => setTimeout(resolve, ms));
};

/**
 * Removes a class from an element if it exists.
 * @param {HTMLElement} element
 * @param {string} name
 */
const removeClass = (element, name) => {
    if (element.classList.contains(name)) {
        element.classList.remove(name);
    }
};

/**
 * Adds a class to an element if it doesn't already exist.
 * @param {HTMLElement} element
 * @param {string} name
 */
const addClass = (element, name) => {
    if (!element.classList.contains(name)) {
        element.classList.add(name);
    }
};
