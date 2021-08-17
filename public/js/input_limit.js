const inputTitle = document.querySelector('.js-2input__input-title');
const judgeTitle = document.querySelector('.js-2input__judge-title');
const countTitle = document.querySelector('.js-2input__count-title');

const inputBody = document.querySelector('.js-2input__input-body');
const judgeBody = document.querySelector('.js-2input__judge-body');
const countBody = document.querySelector('.js-2input__count-body');

const button = document.querySelector('.js-2input__btn');

const enableButton = (countTitleBoolean, countBodyBoolean) => {
  if (countTitleBoolean && countBodyBoolean) {
    button.removeAttribute('disabled');
  } else {
    button.setAttribute('disabled', true);
  }
};

const commonFunction = () => {
  const inputTitleCount = inputTitle.value.length;
  const inputBodyCount = inputBody.value.length;
  const isValidTitleCount = inputTitleCount > 0 && inputTitleCount < 30;
  const isValidBodyCount = inputBodyCount >= 0 && inputBodyCount < 500;
  enableButton(isValidTitleCount, isValidBodyCount);
  return [inputTitleCount, inputBodyCount, isValidTitleCount, isValidBodyCount];
}

inputTitle.addEventListener('input', () => {
  let [inputTitleCount, inputBodyCount, isValidTitleCount, isValidBodyCount] = commonFunction();
  countTitle.innerText = inputTitleCount;
  if (isValidTitleCount) {
    judgeTitle.classList.remove('js-danger');
  } else {
    judgeTitle.classList.add('js-danger');
  }
});

inputBody.addEventListener('input', () => {
  let [inputTitleCount, inputBodyCount, isValidTitleCount, isValidBodyCount] = commonFunction();
  countBody.innerText = inputBodyCount;
  if (isValidBodyCount) {
    judgeBody.classList.remove('js-danger');
  } else {
    judgeBody.classList.add('js-danger');
  }
});

let evt = new Event('input');
inputTitle.dispatchEvent(evt);
inputBody.dispatchEvent(evt);
