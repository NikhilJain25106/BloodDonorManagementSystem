document.addEventListener("DOMContentLoaded", function () {

    // ---- Registration form validation ----
    const registerForm = document.getElementById("registerForm");
    if (registerForm) {
        registerForm.addEventListener("submit", function (e) {
            let errors = [];

            const age = parseInt(document.querySelector('[name="age"]').value);
            if (isNaN(age) || age < 18 || age > 65) {
                errors.push("Age must be between 18 and 65.");
            }

            const phone = document.querySelector('[name="phone"]').value.trim();
            if (!/^\d{10}$/.test(phone)) {
                errors.push("Phone number must be exactly 10 digits.");
            }

            const email = document.querySelector('[name="email"]').value.trim();
            if (!/^[\w.+-]+@[\w-]+\.[a-zA-Z]{2,}$/.test(email)) {
                errors.push("Please enter a valid email address.");
            }

            if (errors.length > 0) {
                e.preventDefault();
                let box = document.getElementById("clientErrorBox");
                if (!box) {
                    box = document.createElement("div");
                    box.id = "clientErrorBox";
                    box.className = "alert alert-danger mt-3";
                    registerForm.prepend(box);
                }
                box.innerHTML = "<i class='fa-solid fa-circle-exclamation me-2'></i>" + errors.join(" ");
                window.scrollTo(0, 0);
            }
        });
    }
});
