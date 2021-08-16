let inputTitle = document.querySelector('.js-2input__input-title');
let judgeTitle = document.querySelector('.js-2input__judge-title');
let countTitle = document.querySelector('.js-2input__count-title');

let inputBody = document.querySelector('.js-2input__input-body');
let judgeBody = document.querySelector('.js-2input__judge-body');
let countBody = document.querySelector('.js-2input__count-body');

let button = document.querySelector('.js-2input__btn');

let judgeCount = (inputTitleCount, inputBodyCount) => {
  let countTitleBoolean = inputTitleCount > 0 && inputTitleCount < 30 ? true : false;
  let countBodyBoolean = inputBodyCount >= 0 && inputBodyCount < 500 ? true : false;
  return [countTitleBoolean, countBodyBoolean];
}

let enableButton = (countTitleBoolean, countBodyBoolean) => {
  if (countTitleBoolean && countBodyBoolean) {
    button.removeAttribute('disabled');
  } else {
    button.setAttribute('disabled', true);
  }
};

let commonFunction = () => {
  let inputTitleCount = inputTitle.value.length;
  let inputBodyCount = inputBody.value.length;
  let [countTitleBoolean, countBodyBoolean] = judgeCount(inputTitleCount, inputBodyCount);
  enableButton(countTitleBoolean, countBodyBoolean);
  return [inputTitleCount, inputBodyCount, countTitleBoolean, countBodyBoolean];
}

inputTitle.addEventListener('input', () => {
  let [inputTitleCount, inputBodyCount, countTitleBoolean, countBodyBoolean] = commonFunction();
  countTitle.innerText = inputTitleCount;
  if (countTitleBoolean) {
    judgeTitle.classList.remove('js-danger');
  } else {
    judgeTitle.classList.add('js-danger');
  }
});

inputBody.addEventListener('input', () => {
  let [inputTitleCount, inputBodyCount, countTitleBoolean, countBodyBoolean] = commonFunction();
  countBody.innerText = inputBodyCount;
  if (countBodyBoolean) {
    judgeBody.classList.remove('js-danger');
  } else {
    judgeBody.classList.add('js-danger');
  }
});

let evt = new Event('input');
inputTitle.dispatchEvent(evt);
inputBody.dispatchEvent(evt);
