document.addEventListener('DOMContentLoaded', () => {

    // functions
    const toggleDarkMode = () => {
        document.documentElement.classList.toggle('dark');
        themeChanger.children[0].classList.toggle('hidden');
        themeChanger.children[1].classList.toggle('hidden');
        localStorage.setItem('darkMode', document.documentElement.classList.contains('dark'));
    }
    const handleHamburger = (x) => {
        navigationLinks.classList.toggle('active');
        document.body.classList.toggle('overflow-hidden');
        x.classList.toggle("change");
    }

    const handleSort = (event) => {
        event.preventDefault();
        const sortParams = event.target.dataset
        // handle for reverse sort
        const updateUrl = `${window.location.pathname}?${new URLSearchParams(sortParams)}`
          fetch(updateUrl).then((response) => {
              return (response.text());
          }).then((html) => {
              const parser = new DOMParser();
              const newDoc = parser.parseFromString(html, "text/html");
              const newCards = newDoc.querySelector(".cards");
              const oldCards = document.querySelector(".cards");
              oldCards.innerHTML = newCards.innerHTML;
              window.history.pushState({}, "", updateUrl);
          });
    }

    // check if dark mode is enabled
    if (localStorage.getItem('darkMode') === 'true') {
        toggleDarkMode();
    }

    // add event listener to theme changer
    const themeChanger = document.querySelector('.theme-changer');
    if (themeChanger) {
        themeChanger.addEventListener('click', toggleDarkMode);
    }

    // // add event listener to hamburger
    const hamburger = document.querySelector('.humburger');
    const navigationLinks = document.querySelector('.navigation-links');
    if (hamburger) {
        hamburger.addEventListener('click', () => {
            handleHamburger(hamburger);
        });
    }
    // add event listener to navigation links
    const sortLinks = document.querySelectorAll(".sort-link");
    if (sortLinks) {
        sortLinks.forEach((link) => {
            link.addEventListener('click', handleSort);
        });
    }

  });
