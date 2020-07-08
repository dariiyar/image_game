GameConfiguration = {
    init:  function (data) {
        const TIME_LIMIT = 10;
        const { images, play_id } = data;
        const game_container = document.querySelector('.timer-container');
        const images_container = game_container.querySelector('.images');
        const time_container = game_container.querySelector('h1');
        const table_container = document.querySelector('.play-table');
        const imagesTimerOverlap = function () {
            let i = 0;
            let obj = {};
            [...Array(TIME_LIMIT+1).keys()].reverse().forEach((el) => {
                if(!el)
                    return;
                if(i === images.length)
                    i=0;
                obj[el.toString()] = i;
                i++;
            });
            return obj;
        }();
        let interval_id;

        const fillImages = function(){
            images.forEach(function (image, index) {
                let node = document.createElement("img");
                node.setAttribute('class', 'hidden');
                node.setAttribute('data-index-' + index, '');
                node.setAttribute('data-id', image.id);
                node.setAttribute('src', image.link);
                images_container.appendChild(node);
            });
        };
        const startGame = function(){
            let timePassed = 0;
            time_container.innerHTML = TIME_LIMIT;
            showImage(TIME_LIMIT);
            interval_id = setInterval(() => {
                timePassed = timePassed += 1;
                if(timePassed === TIME_LIMIT)
                    timePassed = 0;
                let currentTime = TIME_LIMIT - timePassed;
                currentTime === TIME_LIMIT ? hideImage(1) : hideImage(currentTime + 1);
                showImage(currentTime)
                time_container.innerHTML = currentTime;
            }, 1000);
        };
        const showImage = function (prop) {
            images_container.querySelector('img[data-index-' + imagesTimerOverlap[prop] +']').classList.remove('hidden')
        };
        const hideImage = function (prop) {
            images_container.querySelector('img[data-index-' + imagesTimerOverlap[prop] +']').classList.add('hidden')
        };
        const finishGameHandler = function(){
            clearInterval(interval_id);
            const formData = new FormData();
            formData.set('image', images_container.querySelector(":not(.hidden").getAttribute('data-id'));
            formData.set('play', play_id);
            formData.set('timer', time_container.innerHTML);

            fetch('/finish',{
                method: 'PUT',
                body: formData
            }).then((response) => {
                if (response.ok) {
                    game_container.classList.add("hidden");
                    response.json().then((data) => {
                        table_container.querySelector('td.timer').innerHTML = data.timer;
                        let node = document.createElement("img");
                        console.log(data)
                        node.setAttribute('src', data.image_link);
                        table_container.querySelector('td.image').appendChild(node);
                        table_container.classList.remove("hidden");
                    });
                }
                else
                    response.json().then((response) => { console.log('Error: ' + response.errors); })
            }).catch(function(error) {
                console.log('Fetch Error:' + error);
            });
        };

        game_container.classList.remove('hidden');
        fillImages();
        startGame();
        game_container.querySelector('#finish_button').addEventListener('click', finishGameHandler);
    }
};