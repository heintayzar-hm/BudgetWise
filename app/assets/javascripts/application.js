document.addEventListener('DOMContentLoaded', () => {
    const themeChanger = document.querySelector('.theme-changer');
    const toggleDarkMode = () => {
        document.documentElement.classList.toggle('dark');
        themeChanger.children[0].classList.toggle('hidden');
        themeChanger.children[1].classList.toggle('hidden');
        localStorage.setItem('darkMode', document.documentElement.classList.contains('dark'));
    }
    const handleHamburger = (x) => {
        x.classList.toggle("change");
      }
    if (localStorage.getItem('darkMode') === 'true') {
        toggleDarkMode();
    }
    themeChanger.addEventListener('click',toggleDarkMode);

    const hamburger = document.querySelector('.humburger');
    const navigationLinks = document.querySelector('.navigation-links');
    hamburger.addEventListener('click', () => {
        navigationLinks.classList.toggle('active');
        document.body.classList.toggle('overflow-hidden');
        handleHamburger(hamburger);
    });
  });
