ImagesUploading = {
    init:  function () {
        const form = document.forms.namedItem('new_play');
        const submit_handler = function (ev) {
            ev.preventDefault();
            const formData = new FormData(form);
            if(![...form.querySelector('input[type="file"][multiple]').files].length)
                return;
            fetch(form.action, {
                method: 'POST',
                body: formData
            }).then((response) => {
                if (response.ok) {
                    console.log(response.json());
                }
                else
                    response.json().then((response) => { console.log('Error: ' + response.errors); })
            }).catch(function(error) {
                console.log('Fetch Error:' + error);
            });
        };
        form.addEventListener('submit', submit_handler);
    }
};
