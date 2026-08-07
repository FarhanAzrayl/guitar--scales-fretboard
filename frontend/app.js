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


// Lets mix all into one startup function, much cleaner nanti susah nak organize if buat satu2

async function initializeApp() {

    await loadTunings();

    await loadScales();

    loadRootNotes();

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

            select.appendChild(option);
        });

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
        .addEventListener("change", renderFretboard);

    document
        .getElementById("root-note-select")
        .addEventListener("change", renderFretboard);

    document
        .getElementById("scale-select")
        .addEventListener("change", renderFretboard);

    document
        .getElementById("show-notes-toggle")
        .addEventListener("change", renderFretboard);

}



// This one yang akan render the fretboard ikut the data from input kita ambik from above

function renderFretboard() {

    const tuning = getSelectedTuning();
    const rootNote = getSelectedRootNote();
    const scale = getSelectedScale();

    const frets = getAllFrets();

    console.log(frets);

    console.log("Current Selection:", {
    tuning,
    rootNote,
    scale
    });

    // TESTING NAK TENGOK DEKAT CONSOLE DIA READ AS APA, REMOVE AFTER DONE
    console.log(getNoteAtFret("E", 0));
    // TESTING NAK TENGOK DEKAT CONSOLE DIA READ AS APA, REMOVE AFTER DONE

   // Previous console log > We make them prettier sikit
   // console.log(tuning);
   // console.log(rootNote);
   // console.log(scale);

}

// Just calling all the frets from the html > returned as array
function getAllFrets() {
    return document.querySelectorAll(".fret");
}

// Ni untuk determine the first note from fret 0, in which will dictate how the notes on the frets of a string will auto-populdate
function getNoteAtFret(openNote, fret) {
    // indexOf() ni untuk return the index of the note that is on the fret of the open note (note 0) and dia akan compare to the NOTES array yang kita declare dekat atas tu
    const startIndex = NOTES.indexOf(openNote);
    console.log(startIndex);

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