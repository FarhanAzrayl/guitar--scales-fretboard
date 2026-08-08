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

// Ni just untuk load the initial tuning for the fretboard je. Instead of having it empty on first load and we have to select the tuning, this is to load Standard tuning first

const STANDARD_TUNING = [
    "E",
    "B",
    "G",
    "D",
    "A",
    "E"
];


// Lets mix all into one startup function, much cleaner nanti susah nak organize if buat satu2

async function initializeApp() {

    await loadTunings();

    await loadScales();

    loadRootNotes();

    loadOpenStringNotes();

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

    // This one is basically telling us that if we Change String 1 punya note? > RENDER FRETBOARD
    document
    .querySelectorAll(".open-string-select")
    .forEach(select => {
        select.addEventListener("change", renderFretboard);
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

    // This is to loop through all the frets and then populate the note on each fret based on the open note and the fret number
    // The function is declared below; function getNoteAtFret(openNote, fret)
    // We have also now added that on the initial render, kita populate with Standard tuning first. We take from the STANDARD_TUNING array table dekat atas
    frets.forEach(fret => {
    const stringNumber = Number(fret.dataset.string);
    // Okay so this one is negative one, sebab dekat HTML kita letak string as 1-6, but arrays starts from 0, so array dia 0-5. Kita match dia gitchew
    const openNote = openStringNotes[stringNumber - 1];
    const fretNumber = Number(fret.dataset.fret);
    const note = getNoteAtFret(openNote, fretNumber);

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
    
    // Bring this back nanti if the if/else doesn't work
    // fret.textContent = note; 

});

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

// Just calling all the frets from the html > returned as array
function getAllFrets() {
    // Ingat, for note 0 or the open string, the class name we gave is different. Tapi kita dah bagi value on each fret/string. So we use those instead. 
    // data-string = which string?
    // data-fret = which fret?
    return document.querySelectorAll("[data-string][data-fret]");
}

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
    selects.forEach((select, index) => {

        NOTES.forEach(note => {

            const option = document.createElement("option");

            option.value = note;
            option.textContent = note;

            select.appendChild(option);

        });
        // Ni ha we tell them to select STANDARD_TUNING kita letak dekat atas tu. Lets not overcomplicate and add another layer of calculation
        select.value = STANDARD_TUNING[index];
    });
}



// This one is for the Toggle button

function shouldShowNotes() {

    return document.getElementById("show-notes-toggle").checked;

}