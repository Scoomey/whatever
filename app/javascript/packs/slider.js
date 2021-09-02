function slider() {
  let minyear = document.getElementById("minyear");
  let maxyear = document.getElementById("maxyear");

  let thumbLeft = document.querySelector(".slider > .thumb.left");
  let thumbRight = document.querySelector(".slider > .thumb.right");
  let range = document.querySelector(".slider > .range");

  function setLeftValue() {
    let _this = minyear,
      min = parseInt(_this.min),
      max = parseInt(_this.max);

    _this.value = Math.min(parseInt(_this.value), parseInt(maxyear.value) - 1);

    let percent = ((_this.value - min) / (max - min)) * 100;

    thumbLeft.style.left = percent + "%";
    range.style.left = percent + "%";
  }
  setLeftValue();

  function setRightValue() {
    let _this = maxyear,
      min = parseInt(_this.min),
      max = parseInt(_this.max);

    _this.value = Math.max(parseInt(_this.value), parseInt(minyear.value) + 1);

    let percent = ((_this.value - min) / (max - min)) * 100;

    thumbRight.style.right = (100 - percent) + "%";
    range.style.right = (100 - percent) + "%";
  }
  setRightValue();

  minyear.addEventListener("input", setLeftValue);
  maxyear.addEventListener("input", setRightValue);

  minyear.addEventListener("mouseover", function () {
    thumbLeft.classList.add("hover");
  });
  minyear.addEventListener("mouseout", function () {
    thumbLeft.classList.remove("hover");
  });
  minyear.addEventListener("mousedown", function () {
    thumbLeft.classList.add("active");
  });
  minyear.addEventListener("mouseup", function () {
    thumbLeft.classList.remove("active");
  });

  maxyear.addEventListener("mouseover", function () {
    thumbRight.classList.add("hover");
  });
  maxyear.addEventListener("mouseout", function () {
    thumbRight.classList.remove("hover");
  });
  maxyear.addEventListener("mousedown", function () {
    thumbRight.classList.add("active");
  });
  maxyear.addEventListener("mouseup", function () {
    thumbRight.classList.remove("active");
  });
  console.log("slider js connected");
}

function displayValue() {
  let minyear = document.getElementById('minyear'),
    output1 = document.getElementById('output1'),
    maxyear = document.getElementById('maxyear'),
    output2 = document.getElementById('output2');

  output1.innerHTML = minyear.value;
  output2.innerHTML = maxyear.value;
  // use 'change' instead to see the difference in response
  minyear.addEventListener('input', function () {
    output1.innerHTML = minyear.value;
  }, false);
  maxyear.addEventListener('input', function () {
    output2.innerHTML = maxyear.value;
  }, false);
}

export { slider, displayValue };
