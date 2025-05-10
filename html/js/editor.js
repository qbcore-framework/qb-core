// Main data store
let configData = {};
let currentFile = "config";
let currentEditItem = null;
let editPath = null;

// Elements
const dataContainer = document.getElementById("data-container");
const searchInput = document.getElementById("search-input");
const saveBtn = document.getElementById("save-btn");
const closeBtn = document.getElementById("close-btn");
const editModal = document.getElementById("edit-modal");
const closeModalBtn = document.getElementById("close-modal-btn");
const saveItemBtn = document.getElementById("save-item-btn");
const cancelEditBtn = document.getElementById("cancel-edit-btn");
const editorForm = document.getElementById("editor-form");
const fileListItems = document.querySelectorAll(".file-list li");
const fabButton = document.getElementById("add-item-fab");
let fileInput;

// Initialize
document.addEventListener("DOMContentLoaded", () => {
    // Add event listeners
    searchInput.addEventListener("input", filterData);
    saveBtn.addEventListener("click", saveChanges);
    closeBtn.addEventListener("click", closeEditor);
    closeModalBtn.addEventListener("click", closeModal);
    saveItemBtn.addEventListener("click", saveItemChanges);
    cancelEditBtn.addEventListener("click", closeModal);
    fabButton.addEventListener("click", addItemModal);

    fileListItems.forEach((item) => {
        item.addEventListener("click", () => {
            // Update active state
            fileListItems.forEach((i) => i.classList.remove("active"));
            item.classList.add("active");

            // Change current file
            currentFile = item.dataset.file;

            // Load file data - in a real implementation, this would trigger a fetch to the server
            // For now, we'll just use the data we already have
            currentFile = item.dataset.file;
            renderData();
        });
    });

    // Listen for NUI messages from FiveM
    window.addEventListener("message", function (event) {
        const data = event.data;

        if (data.action === "populateData") {
            // Expect data.data to be an object with each file's data
            configData = data.data;
            renderData();
        }
    });
});

const templates = {
    jobs: {
        defaultDuty: false,
        offDutyPay: false,
        type: "",
        label: "",
        grades: [
            {
                name: "",
                isboss: false,
                payment: 0,
            },
        ],
    },
    gangs: {
        label: "",
        grades: [
            {
                name: "",
                isboss: false,
                level: 0,
            },
        ],
    },
    items: {
        unique: false,
        shouldClose: false,
        useable: false,
        name: "",
        label: "",
        weight: 0,
        type: "",
        image: "",
        description: "",
        ammotype: "",
    },
    vehicles: {
        brand: "",
        price: 0,
        name: "",
        category: "",
        model: "",
        type: "",
        shop: ["pdm"],
    },
    weapons: {
        name: "",
        label: "",
        damageReason: "",
        weapontype: "",
        ammotype: "",
    },
};

function addItemModal() {
    const modal = document.getElementById("edit-modal");
    const editorForm = document.getElementById("editor-form");

    // Clear the form and set it up for adding a new item
    editorForm.innerHTML = ""; // Clear any existing content
    modal.classList.remove("hidden"); // Show the modal

    // Get the template for the current category
    const template = templates[currentFile] || {};

    // Add fields for the new item based on the template
    Object.entries(template).forEach(([key, value]) => {
        const formGroup = document.createElement("div");
        formGroup.className = "form-group";

        const label = document.createElement("label");
        label.textContent = key;
        formGroup.appendChild(label);

        if (typeof value === "boolean" || typeof value === "string" || typeof value === "number") {
            const field = createInputField({
                key,
                value,
                onChange: () => {}, // No need to handle it now, we'll read from DOM on save
            });
            formGroup.appendChild(field.querySelector("input"));
        } else if (Array.isArray(value)) {
            const arrayField = createArrayField({
                key,
                array: value,
                onItemChange: () => {}, // Again, no live tracking needed
                onItemRemove: (index) => {
                    value.splice(index, 1);
                    addItemModal(); // re-render modal
                },
                onItemAdd: () => {
                    // Clone first item or fallback
                    if (value.length > 0 && typeof value[0] === "object") {
                        const newItem = {};
                        Object.entries(value[0]).forEach(([k, v]) => {
                            newItem[k] = typeof v === "number" ? 0 : typeof v === "boolean" ? false : "";
                        });
                        value.push(newItem);
                    } else {
                        value.push("");
                    }
                    addItemModal(); // re-render modal
                },
            });
            arrayField.id = `new-item-${key}`;
            formGroup.appendChild(arrayField);
        } else {
            const input = document.createElement("input");
            input.type = "text";
            input.className = "form-control";
            input.value = value;
            formGroup.appendChild(input);
        }

        editorForm.appendChild(formGroup);
    });

    // Add Save and Cancel buttons
    const saveButton = document.getElementById("save-item-btn");
    saveButton.onclick = saveNewItem;

    const cancelButton = document.getElementById("cancel-edit-btn");
    cancelButton.onclick = () => {
        modal.classList.add("hidden"); // Hide the modal
    };
}

function saveNewItem() {
    const template = templates[currentFile] || {};
    const newItem = {};

    // Populate the new item based on the template
    Object.entries(template).forEach(([key, value]) => {
        if (Array.isArray(value)) {
            // Handle arrays
            const arrayContainer = document.getElementById(`new-item-${key}`);
            const arrayItems = Array.from(arrayContainer.querySelectorAll(".array-item"));
            newItem[key] = arrayItems.map((itemGroup) => {
                const item = {};
                Array.from(itemGroup.querySelectorAll("input")).forEach((input) => {
                    const itemKey = input.dataset.itemKey;
                    item[itemKey] = input.type === "number" ? parseFloat(input.value) || 0 : input.value;
                });
                return item;
            });
        } else {
            // Handle simple values
            const input = document.getElementById(`new-item-${key}`);
            if (input) {
                newItem[key] = input.type === "checkbox" ? input.checked : input.value;
            }
        }
    });

    // Add the new item to the current category
    if (!configData[currentFile]) {
        configData[currentFile] = {};
    }
    const itemName = document.getElementById("new-item-name").value.trim();
    if (!itemName) {
        alert("Please provide a name for the new item.");
        return;
    }
    configData[currentFile][itemName] = newItem;

    // Update the UI
    renderData();

    // Close the modal
    document.getElementById("edit-modal").classList.add("hidden");
}

// Render data in the container
function renderData() {
    dataContainer.innerHTML = "";

    if (!configData[currentFile]) {
        dataContainer.innerHTML = "<p>No data available for this file.</p>";
        return;
    }

    const data = configData[currentFile];
    const searchText = searchInput.value.toLowerCase();

    // For object-based data (like jobs)
    Object.entries(data).forEach(([key, value]) => {
        // If there's a search term, filter the data
        if (searchText && !key.toLowerCase().includes(searchText) && !JSON.stringify(value).toLowerCase().includes(searchText)) {
            return;
        }

        const card = document.createElement("div");
        card.className = "data-card";
        card.dataset.key = key;

        // Create card header
        const header = document.createElement("h3");
        header.textContent = key;
        card.appendChild(header);

        // Create properties section
        const properties = document.createElement("div");
        properties.className = "data-properties";

        // Add main properties (not going too deep)
        Object.entries(value).forEach(([propKey, propValue]) => {
            // Skip complex objects for the card view
            if (typeof propValue === "object" && propValue !== null) {
                return;
            }

            const property = document.createElement("div");
            property.className = "property";

            const label = document.createElement("span");
            label.className = "property-label";
            label.textContent = propKey;

            const val = document.createElement("span");
            val.className = "property-value";
            val.textContent = propValue;

            property.appendChild(label);
            property.appendChild(val);
            properties.appendChild(property);
        });

        card.appendChild(properties);

        // Add click event to edit
        card.addEventListener("click", () => {
            editItem(key, value);
        });

        dataContainer.appendChild(card);
    });
}

// Create form for editing
function createForm(obj) {
    editorForm.innerHTML = "";

    const sortedKeys = Object.keys(obj).sort((a, b) => {
        const typeOrder = (value) => {
            if (typeof value === "boolean") return 0;
            if (typeof value === "string" || typeof value === "number") return 1;
            if (Array.isArray(value)) return 2;
            return 3;
        };
        return typeOrder(obj[a]) - typeOrder(obj[b]);
    });

    sortedKeys.forEach((key) => {
        const value = obj[key];
        const formGroup = document.createElement("div");
        formGroup.className = "form-group";

        const label = document.createElement("label");
        label.htmlFor = `field-${key}`;
        label.textContent = key;
        formGroup.appendChild(label);

        if (typeof value === "boolean" || typeof value === "string" || typeof value === "number") {
            const field = createInputField({
                key,
                value,
                onChange: (val) => updateValue(key, val),
            });
            formGroup.appendChild(field.querySelector("input"));
        } else if (Array.isArray(value)) {
            const arrayField = createArrayField({
                key,
                array: value,
                onItemChange: (index, itemKey, val) => {
                    if (itemKey) {
                        updateArrayObjectValue(key, index, itemKey, val);
                    } else {
                        updateArrayValue(key, index, val);
                    }
                },
                onItemRemove: (index) => removeArrayItem(key, index),
                onItemAdd: () => addArrayItem(key, value),
            });
            formGroup.appendChild(arrayField);
        } else {
            // Fallback for objects or unknown types
            const objectContainer = document.createElement("div");
            objectContainer.className = "complex-object";

            const header = document.createElement("div");
            header.className = "complex-object-header";
            objectContainer.appendChild(header);

            const textarea = document.createElement("textarea");
            textarea.className = "form-control";
            textarea.value = JSON.stringify(value, null, 2);
            textarea.dataset.key = key;

            textarea.addEventListener("input", (e) => {
                try {
                    const parsed = JSON.parse(e.target.value);
                    updateValue(key, parsed);
                    textarea.style.borderColor = "#3d3d3d";
                } catch (err) {
                    textarea.style.borderColor = "#ff4d4d";
                }
            });

            objectContainer.appendChild(textarea);
            formGroup.appendChild(objectContainer);
        }

        editorForm.appendChild(formGroup);
    });
}

// UTILS

function createInputField({ key, value, onChange }) {
    const formGroup = document.createElement("div");
    formGroup.className = "form-group";

    const label = document.createElement("label");
    label.textContent = key;
    formGroup.appendChild(label);

    const input = document.createElement("input");

    if (typeof value === "boolean") {
        input.type = "checkbox";
        input.checked = value;
    } else if (typeof value === "number") {
        input.type = "number";
        input.value = value;
    } else {
        input.type = "text";
        input.value = value;
    }

    input.className = "form-control";

    input.addEventListener("input", (e) => {
        let newValue;
        if (input.type === "checkbox") {
            newValue = input.checked;
        } else if (input.type === "number") {
            newValue = parseFloat(e.target.value) || 0;
        } else {
            newValue = e.target.value;
        }

        onChange(newValue);
    });

    formGroup.appendChild(input);
    return formGroup;
}

function createArrayField({ key, array, onItemChange, onItemRemove, onItemAdd }) {
    const container = document.createElement("div");
    container.className = "complex-object";

    const header = document.createElement("div");
    header.className = "complex-object-header";

    const addBtn = document.createElement("button");
    addBtn.className = "add-item-btn";
    addBtn.textContent = "Add Item";
    addBtn.addEventListener("click", (e) => {
        e.preventDefault();
        onItemAdd();
    });

    header.appendChild(addBtn);
    container.appendChild(header);

    array.forEach((item, index) => {
        const arrayItem = document.createElement("div");
        arrayItem.className = "array-item";

        // Remove button
        const removeBtn = document.createElement("button");
        removeBtn.className = "remove-item-btn";
        removeBtn.textContent = "x";
        removeBtn.addEventListener("click", (e) => {
            e.preventDefault();
            e.stopPropagation();
            onItemRemove(index);
        });
        arrayItem.appendChild(removeBtn);

        if (typeof item === "object" && item !== null) {
            Object.entries(item).forEach(([itemKey, itemValue]) => {
                const field = createInputField({
                    key: itemKey,
                    value: itemValue,
                    onChange: (val) => onItemChange(index, itemKey, val),
                });
                arrayItem.appendChild(field);
            });
        } else {
            const input = document.createElement("input");
            input.className = "form-control";
            input.value = item;
            input.addEventListener("input", (e) => {
                onItemChange(index, null, e.target.value);
            });
            arrayItem.appendChild(input);
        }

        container.appendChild(arrayItem);
    });

    return container;
}

// Filter data based on search input
function filterData() {
    renderData();
}

// Edit an item
function editItem(key, value) {
    currentEditItem = { key, value: JSON.parse(JSON.stringify(value)) };
    editPath = null; // Reset path for root level editing

    // Create form for editing
    createForm(value);

    // Show the modal
    editModal.classList.remove("hidden");
}

function setDeepValue(obj, pathArray, value) {
    const lastKey = pathArray.pop();
    const target = pathArray.reduce((acc, key) => acc[key], obj);
    target[lastKey] = value;
}

function updateValue(key, value) {
    const path = editPath ? editPath.split(".").concat(key) : [key];
    setDeepValue(currentEditItem.value, path, value);
}

function updateArrayValue(arrayKey, index, value) {
    const path = editPath ? editPath.split(".").concat([arrayKey, index]) : [arrayKey, index];
    setDeepValue(currentEditItem.value, path, value);
}

function updateArrayObjectValue(arrayKey, index, itemKey, value) {
    const path = editPath ? editPath.split(".").concat([arrayKey, index, itemKey]) : [arrayKey, index, itemKey];
    setDeepValue(currentEditItem.value, path, value);
}

function updateArray(arrayKey, action, index = null, newItem = null) {
    const path = editPath ? editPath.split(".").concat([arrayKey]) : [arrayKey];
    const target = path.reduce((acc, key) => acc[key], currentEditItem.value);

    if (action === "add") {
        target.push(newItem);
    } else if (action === "remove" && index !== null) {
        target.splice(index, 1);
    }

    createForm(currentEditItem.value);
}

function addArrayItem(arrayKey, array) {
    let newItem;
    if (array.length > 0 && typeof array[0] === "object" && array[0] !== null) {
        newItem = {};
        Object.keys(array[0]).forEach((key) => {
            const sample = array[0][key];
            newItem[key] = typeof sample === "number" ? 0 : typeof sample === "boolean" ? false : "";
        });
    } else {
        newItem = typeof array[0] === "number" ? 0 : "";
    }
    updateArray(arrayKey, "add", null, newItem);
}

function removeArrayItem(arrayKey, index) {
    updateArray(arrayKey, "remove", index);
}

// Save changes to the edited item
function saveItemChanges() {
    configData[currentFile][currentEditItem.key] = currentEditItem.value;
    closeModal();
    renderData();
}

// Close the edit modal
function closeModal() {
    editModal.classList.add("hidden");
    currentEditItem = null;
    editPath = null;
}

// Save all changes to the server
function saveChanges() {
    // Send data back to the client
    fetch(`https://${GetParentResourceName()}/saveConfig`, {
        method: "POST",
        headers: {
            "Content-Type": "application/json; charset=UTF-8",
        },
        body: JSON.stringify({
            file: currentFile,
            data: configData[currentFile],
        }),
    }).catch((err) => console.error("Error:", err));
}

// Close the editor
function closeEditor() {
    fetch(`https://${GetParentResourceName()}/closeEditor`, {
        method: "POST",
    }).catch((err) => console.error("Error:", err));
}
