console.log("app.js loaded");

const API_URL = "https://h95ozcu1tl.execute-api.ap-southeast-1.amazonaws.com";


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


    console.log("Current Selection:", {
    tuning,
    rootNote,
    scale
    });
   // Previous console log > We make them prettier sikit
   // console.log(tuning);
   // console.log(rootNote);
   // console.log(scale);

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


function loadRootNotes() {

    const notes = [
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

    const select = document.getElementById("root-note-select");

    select.innerHTML = "";

    notes.forEach(note => {

        const option = document.createElement("option");

        option.value = note;
        option.textContent = note;

        select.appendChild(option);

    });

}
