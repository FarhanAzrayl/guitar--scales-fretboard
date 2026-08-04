console.log("app.js loaded");

const API_URL = "https://h95ozcu1tl.execute-api.ap-southeast-1.amazonaws.com";

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

loadScales();