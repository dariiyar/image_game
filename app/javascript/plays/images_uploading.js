ImagesUploading = {
    init:  function (callback) {
        const form = document.forms.namedItem('new_play');

        const showError = function (message) {
            let el = form.querySelector('.error-block');
            el.innerHTML = message;
            el.classList.remove("hidden");
        };

        const imagesValidator = function(images){
            let message='';
            if(images.length < 2)
                message = 'Please upload at least two images';
            if(message.length > 0)
                showError(message);
            return !message.length
        };

        const submitHandler = function (ev) {
            ev.preventDefault();
            const formData = new FormData(form);
            if(!imagesValidator([...form.querySelector('input[type="file"][multiple]').files]))
                return;
            form.querySelector('.error-block').classList.add("hidden");
            fetch(form.action, {
                method: 'POST',
                body: formData
            }).then((response) => {
                if (response.ok) {
                    form.classList.add("hidden");
                    if (typeof callback == "function")
                        response.json().then((data) => { callback(data)});
                }
                else
                    response.json().then((response) => { console.log('Error: ' + response.errors); })
            }).catch(function(error) {
                console.log('Fetch Error:' + error);
            });
        };

        form.addEventListener('submit', submitHandler);
    }
};
