const results = document.querySelector("#results");
const searchMovies = (query) => {
fetch("http://www.omdbapi.com/?s=harry potter&apikey=b4c15d98")
  .then(response => response.json())
  .then((data) => {
    data.Search.forEach((result) => {
      const movieTag = `<li class="list-inline-item">
        <img src="${result.Poster}" alt="">
        <p>${result.Title}</p>
        <p>${result.year}</p>
        <p>${result.genre}</p>
        <p>${result.plot}</p>

      </li>`;
      results.insertAdjacentHTML("beforeend", movieTag);
    });
  });
};

// export { searchMovies };
