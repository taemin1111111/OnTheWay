const searchBar = document.getElementById('searchBar');

document.addEventListener('mousemove', (e) => {
    if(e.chlienty < 100) {
        searchBar.classList.add('visible');
    } else {
        searchBar.classList.remove('visible');
    }
})