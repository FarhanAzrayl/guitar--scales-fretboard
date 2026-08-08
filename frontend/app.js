console.log("app.js loaded");

const API_URL = "https://h95ozcu1tl.execute-api.ap-southeast-1.amazonaws.com";

// Just defining the notes here, so we can use it later for the root note dropdown and also for the fretboard rendering
// The index of the arrays are C = 0, C# = 1,  so forth and so on okeii

const NOTES = [
    "C",
    "C#",
    "D",
    "D#",
    "E",
    "F",
    "F#",
    "G",
    "G#",
    "A",
    "A#",
    "B"
];


// Default colours for each musical note and are also used by the scale-note buttons and will corresponding on the notes on the fretboard.

const noteColors = {
    "C": "#ff6b6b",
    "C#": "#ff9f43",
    "D": "#feca57",
    "D#": "#48dbfb",
    "E": "#1dd1a1",
    "F": "#54a0ff",
    "F#": "#5f27cd",
    "G": "#a55eea",
    "G#": "#ff6b81",
    "A": "#00d2d3",
    "A#": "#ff9ff3",
    "B": "#c8d6e5"
};

// loadScales() fetches data from DynamoDB, then put it in here
let scalesData = [];


// Lets mix all into one startup function, much cleaner nanti susah nak organize if buat satu2

async function initializeApp() {

    await loadTunings();

    await loadScales();

    loadRootNotes();

    loadOpenStringNotes();

    applyTuningPreset();

    addEventListeners();
    renderFretboard();

}

initializeApp();

// This one untuk populate the Tuning dropdown from DynamoDB

async function loadTunings() {

    try {
        const response = await fetch(`${API_URL}/tunings`);
        const tunings = await response.json();

        const select = document.getElementById("tuning-select");

        select.innerHTML = "";

        tunings.forEach(tuning => {

            const option = document.createElement("option");

            option.value = tuning.TuningName;
            option.textContent = tuning.TuningName;

            // This is what reads the presets that we have from the JSON file in DynamoDB okay
            option.dataset.notes = JSON.stringify(tuning.Notes);

            select.appendChild(option);
        });

        // Make Standard the initial preset
        const standardOption = Array.from(select.options)
            .find(option => option.value === "Standard");

        if (standardOption) {
            select.value = "Standard";
        }
    }

    catch (err) {

        console.error(err);
    }
}

// This one untuk populate the Scale dropdown from DynamoDB

async function loadScales() {

    try {

        const response = await fetch(`${API_URL}/scales`);
        const scales = await response.json();

        // Referring to the ScaleData array dekat atas, that will depend on the information from DynamoDB
        scalesData = scales;
        console.log(scalesData);

         // Testing to see if Lambda works
        console.log(scales);


        const select = document.getElementById("scale-select");
        select.innerHTML = "";
        scales.forEach(scale => {

            const option = document.createElement("option");

            option.value = scale.ScaleName;
            option.textContent = scale.ScaleName;

            select.appendChild(option);

        });
    }

    catch (err) {
        console.error(err);
    }


}


// This one yang akan add the event listeners to elements mana and also the toggle button yang selected from the html,
// so bila kita change the value dia akan trigger the renderFretboard function

function addEventListeners() {

    document
    .getElementById("tuning-select")
    .addEventListener("change", () => {

        // This one asks to re-render when the preset is selected
        applyTuningPreset();
        renderFretboard();
    });

    document
        .getElementById("root-note-select")
        .addEventListener("change", renderFretboard);

    document
        .getElementById("scale-select")
        .addEventListener("change", renderFretboard);

    document
        .getElementById("show-notes-toggle")
        .addEventListener("change", renderFretboard);

    // This one is basically telling us that if we Change String 1 punya note? > RENDER FRETBOARD
    document
        .querySelectorAll(".open-string-select")
        .forEach(select => {
        select.addEventListener("change", renderFretboard);
    });

    // This one is for the highlight toggle. With each action, render. Same as the ones at the above lah
    document
        .getElementById("highlight-scales-toggle")
        .addEventListener("change", renderFretboard);

    document
        .getElementById("highlight-scale-toggle")
        .addEventListener("change", renderFretboard);

    document
        .getElementById("scale-highlight-color")
        .addEventListener("input", renderFretboard);

    document
        .getElementById("highlight-scale-toggle")
        .addEventListener("change", () => {

        const scaleToggle =
            document.getElementById("highlight-scale-toggle");

        const noteToggle =
            document.getElementById("highlight-scales-toggle");

        if (scaleToggle.checked) {
            noteToggle.checked = false;
        }
        renderFretboard();
    });

}



// This one yang akan render the fretboard ikut the data from input kita ambik from above

function renderFretboard() {

    const tuning = getSelectedTuning();
    const rootNote = getSelectedRootNote();
    const scale = getSelectedScale();

    const frets = document.querySelectorAll("td.fret");
    const openStringNotes = getOpenStringNotes();

    // Ni untuk Toggle btw
    const showNotes = shouldShowNotes();
    console.log(showNotes);

    const highlightScales = shouldHighlightScales();
    const scaleNotes = getScaleNotes();
    const scaleHighlightColor = getScaleHighlightColor();

    // This is to loop through all the frets and then populate the note on each fret based on the open note and the fret number
    // The function is declared below; function getNoteAtFret(openNote, fret)
    // We have also now added that on the initial render, kita populate with Standard tuning first. We take from the STANDARD_TUNING array table dekat atas
    frets.forEach(fret => {
    const stringNumber = Number(fret.dataset.string);
    // Okay so this one is negative one, sebab dekat HTML kita letak string as 1-6, but arrays starts from 0, so array dia 0-5. Kita match dia gitchew
    const openNote = openStringNotes[stringNumber - 1];
    const fretNumber = Number(fret.dataset.fret);
    const note = getNoteAtFret(openNote, fretNumber);
    const isScaleNote = scaleNotes.includes(note);

    if (highlightNotes && isScaleNote) {

        fret.classList.add("scale-highlight");

        fret.style.setProperty(
            "--highlight-color",
            noteColors[note]
    );

    }

    else if (highlightScale && isScaleNote) {

        fret.classList.add("scale-highlight");

        fret.style.setProperty(
            "--highlight-color",
            scaleHighlightColor
        );
    }

    else {
        fret.classList.remove("scale-highlight");
    }


    if (showNotes) {
        fret.textContent = note;
        }
    
    else {
        // Why check 12th fret first? Sebab kita overlook and tak letak the 12th fret dalam class fret-marker
        // So bila kita off the toggle, the 12th fret marker dots will also be gone. So we need to check for this first before the else if statement below.
        if (fret.dataset.fret === "12") {
            fret.innerHTML = `
                <div class="double-marker">
                    <span>●</span>
                    <span>●</span>
                </div>
            `;
            }

        // Ni untuk marker dots, sebab if tak letak ni, dots will also be gone on off Toggle same as above
        else if (fret.classList.contains("marker")) {
            fret.textContent = "●";
        }

        else {
            fret.textContent = "";
        }

    }

    });

    updateScaleNotesDisplay(scaleNotes);

    console.log(frets);

    console.log("Current Selection:", {
    tuning,
    rootNote,
    scale
    });

    // TESTING NAK TENGOK DEKAT CONSOLE DIA READ AS APA, REMOVE AFTER DONE
    // console.log(getNoteAtFret("E", 0)); -> Success yesss
    // TESTING NAK TENGOK DEKAT CONSOLE DIA READ AS APA, REMOVE AFTER DONE

   // Previous console log > We make them prettier sikit
   // console.log(tuning);
   // console.log(rootNote);
   // console.log(scale);

}

// Ni semua helper function for the renderFretboard() function btw. They act as kinda like a module. Treat them as employees that has to do what Renderer wants when Renderer asks for it


// Ni function to get the selected open-string notes from the STANDARD_TUNING array table kita buat atas tu
function getOpenStringNotes() {
    const selects = document.querySelectorAll(".open-string-select");
    return Array.from(selects).map(select => select.value);
}

// Ni untuk determine the first note from fret 0, in which will dictate how the notes on the frets of a string will auto-populdate
function getNoteAtFret(openNote, fret) {
    // indexOf() ni untuk return the index of the note that is on the fret of the open note (note 0) and dia akan compare to the NOTES array yang kita declare dekat atas tu
    const startIndex = NOTES.indexOf(openNote);
    // % is used to return the remainder after division. So, if the index + fret is equals to 12, (array kita sampai [11] only), it will divide and then return the remainder
    // Basically loops back to the front of the array/index. 14 / 12, baki 2. So the array that it returns is [2]
    // The normal lesser than will basically be for example 4+3/12 = 7/12 = 0, but the remainder is 7
    const noteIndex = (startIndex + fret) % NOTES.length;
    return NOTES[noteIndex];

}


// Ni function untuk load the Root notes > This function is saying return selected value from "tuning-select" from our html
function getSelectedTuning() {
    const select = document.getElementById("tuning-select");
    return select.value;
}

// Ni function untuk load the Root notes > This function is saying return selected value from "root-note-select" from our html
function getSelectedRootNote() {
    const select = document.getElementById("root-note-select");
    return select.value;
}

// Ni function untuk load the Root notes > This function is saying return selected value from "scale-select" from our html
function getSelectedScale() {
    const select = document.getElementById("scale-select");
    return select.value;
}


 // We are just looping the notes from the Notes dekat atas sekali tu

function loadRootNotes() {

    const select = document.getElementById("root-note-select");

    select.innerHTML = "";

    NOTES.forEach(note => {

        const option = document.createElement("option");

        option.value = note;
        option.textContent = note;

        select.appendChild(option);

    });

}

// Ni untuk dropdown Root Notes because we are adding it so each individual strings are editable
// We are also making this function call the Standard tuning from the global constant dekat atas tu for initial load
// Initial load will be Standard tuning basically before the drop down basically okeiii

function loadOpenStringNotes() {

    const selects = document.querySelectorAll(".open-string-select");

    selects.forEach(select => {
        NOTES.forEach(note => {
            const option = document.createElement("option");

            option.value = note;
            option.textContent = note;

            select.appendChild(option);
        });
    });
}



// This one is for the Toggle button

function shouldShowNotes() {

    return document.getElementById("show-notes-toggle").checked;

}

// This one fetches from DynamoDB
// Ni function to fetch the scale intervals from the JSON file in DynamoDB
function getSelectedScaleIntervals() {
    const scaleName = getSelectedScale();
    // scaleName is Major or Minor for example, so if scaeName is Major, get the intervals
    const scale = scalesData.find(scale => scale.ScaleName === scaleName);
    if (!scale) {
        return [];
    }

    return scale.Intervals;
}

// This one make the changes using the fetched data from DynamoDB
// This function is the one that actually bagi the actual notes belonging to the selected scale after we get the Intervals from DynamoDB
function getScaleNotes() {
    const rootNote = getSelectedRootNote();
    const intervals = getSelectedScaleIntervals();
    const rootIndex = NOTES.indexOf(rootNote);

    return intervals.map(interval => {
        const noteIndex = (rootIndex + interval) % NOTES.length;
        return NOTES[noteIndex];
    });
}


// Function untuk highli8ght the notes when toggled on
function shouldHighlightScales() {
    return document.getElementById("highlight-scales-toggle").checked;
}

// Function for the highlight colour picker



// Ni function untuk change the tuning based on the preset drop down selected
function applyTuningPreset() {

    const tuningSelect = document.getElementById("tuning-select");
    const selectedOption = tuningSelect.options[tuningSelect.selectedIndex];

    if (!selectedOption || !selectedOption.dataset.notes) {
        return;
    }

    const notes = JSON.parse(selectedOption.dataset.notes);
    const openStringSelects = document.querySelectorAll(".open-string-select");

    openStringSelects.forEach((select, index) => {
        select.value = notes[index];
    });
}

// This is just the function to display the Notes within a Scale selected
function getScaleNotes() {
    const rootNote = getSelectedRootNote();
    const intervals = getSelectedScaleIntervals();
    const rootIndex = NOTES.indexOf(rootNote);

    return intervals.map(interval => {
        const noteIndex = (rootIndex + interval) % NOTES.length;
        return NOTES[noteIndex];
    });
}

// Function that updates the display of the notes within the scale as per the one atas ni
function updateScaleNotesDisplay(scaleNotes) {

    const display = document.getElementById("scale-notes-display");

    if (!display) {
        return;
    }

    display.innerHTML = "";
    
    scaleNotes.forEach(note => {

        const wrapper = document.createElement("div");
        wrapper.className = "scale-note-wrapper";

        const noteElement = document.createElement("button");

        noteElement.className = "scale-note";
        noteElement.textContent = note;

        noteElement.style.backgroundColor = noteColors[note];

        noteElement.addEventListener("click", event => {
            event.stopPropagation();
            openNoteColorPicker(note, wrapper);

        });

        wrapper.appendChild(noteElement);
        display.appendChild(wrapper);
    });
}

// Function ni untuk the button yang untuk colour picker
function openNoteColorPicker(note, wrapper) {

    // Remove an existing popup first
    closeNoteColorPicker();

    const popup = document.createElement("div");

    popup.className = "note-color-popup";
    popup.id = "note-color-popup";

    popup.innerHTML = `
        <div class="note-color-popup-title">
            ${note} Colour
        </div>

        <input
            type="color"
            class="note-color-input"
            value="${noteColors[note]}"
        >

        <span class="note-color-value">
            ${noteColors[note]}
        </span>
    `;

    wrapper.appendChild(popup);

        const colorInput =
        popup.querySelector(".note-color-input");

        const colorValue =
        popup.querySelector(".note-color-value");

        colorInput.addEventListener("input", event => {

        const newColor = event.target.value;

        noteColors[note] = newColor;
        colorValue.textContent = newColor;

        const noteElement =
            wrapper.querySelector(".scale-note");

        noteElement.style.backgroundColor = newColor;

        // Update the fretboard terus
        renderFretboard();
    });
}


function closeNoteColorPicker() {
    const popup =
        document.getElementById("note-color-popup");

    if (popup) {
        popup.remove();
    }
}

// Function to highlight scales with the same colour
function shouldHighlightScale() {
    return document
        .getElementById("highlight-scale-toggle")
        .checked;
}

function getScaleHighlightColor() {
    return document
        .getElementById("scale-highlight-color")
        .value;
}