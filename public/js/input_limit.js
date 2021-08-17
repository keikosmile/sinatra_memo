const inputTitle = document.querySelector('.js-2input__input-title');
const judgeTitle = document.querySelector('.js-2input__judge-title');
const countTitle = document.querySelector('.js-2input__count-title');

const inputBody = document.querySelector('.js-2input__input-body');
const judgeBody = document.querySelector('.js-2input__judge-body');
const countBody = document.querySelector('.js-2input__count-body');

const button = document.querySelector('.js-2input__btn');

const judgeCount = (inputTitleCount, inputBodyCount) => {
  let countTitleBoolean = inputTitleCount > 0 && inputTitleCount < 30 ? true : false;
  let countBodyBoolean = inputBodyCount >= 0 && inputBodyCount < 500 ? true : false;
  return [countTitleBoolean, countBodyBoolean];
}

const enableButton = (countTitleBoolean, countBodyBoolean) => {
  if (countTitleBoolean && countBodyBoolean) {
    button.removeAttribute('disabled');
  } else {
    button.setAttribute('disabled', true);
  }
};

const commonFunction = () => {
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
