window.onhashchange = function () {
  let mark = window.location.hash.substr(2);
  try {
    mark = decodeURIComponent(mark);
  } catch (e) {
    // Ignore decoding error and fallback
  }
  const pathname = window.location.pathname;
  const isHomePage = pathname === "/" || pathname === "/index.html" || pathname.endsWith("/index.html") || pathname.endsWith("/");

  // 1. Highlight sidebar categories
  const categoryLinks = document.getElementsByClassName("category-link");
  for (const link of categoryLinks) {
    const tag = link.getAttribute("data-tag");
    if (tag === mark) {
      link.classList.add("active");
      if (isHomePage) {
        link.href = "#"; // Clicking again clears the filter
      }
    } else {
      link.classList.remove("active");
      if (isHomePage) {
        link.href = tag ? "#/" + tag : "#";
      }
    }
  }

  // 2. Filter cards on homepage
  if (isHomePage) {
    const cards = document.getElementsByClassName("card");
    for (const card of cards) {
      let found = false;
      const tags = card.getElementsByClassName("tag");
      for (const tag of tags) {
        const a = tag.children[0];
        if (a.innerText === mark) {
          tag.classList.add("selected");
          a.href = "#";
          found = true;
        } else {
          tag.classList.remove("selected");
          a.href = "#/" + a.innerText;
        }
      }
      card.hidden = mark.length > 0 && !found;
    }
  }
};

window.onhashchange();
