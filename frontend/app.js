const API_URL = "https://h95ozcu1tl.execute-api.ap-southeast-1.amazonaws.com";

async function loadScales() {

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

loadScales();