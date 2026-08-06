console.log("app.js loaded");

const API_URL = "https://h95ozcu1tl.execute-api.ap-southeast-1.amazonaws.com";


//This one untuk tukar the scales dropdown and pull the data from DynamoDB

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


//This one untuk tukar the scales dropdown and pull the data from DynamoDB

async function loadScales() {

    try {

        console.log("Fetching scales...");

        const response = await fetch(`${API_URL}/scales`);

        console.log(response);

        const scales = await response.json();

        console.log(scales);

        const select = document.getElementById("scale-select");

        select.innerHTML = "";

        scales.forEach(scale => {

            const option = document.createElement("option");

            option.value = scale.ScaleName;
            option.textContent = scale.ScaleName;

            select.appendChild(option);

        });

        console.log("Finished");

    }

    catch (err) {

        console.error(err);

    }

}

//This one untuk tukar the Root Notes dekat the Guitar Fretboard. The notes we define here, tak payah overcomplicate and store dalam DynamoDB -->

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

loadTunings();
loadScales();
loadRootNotes();