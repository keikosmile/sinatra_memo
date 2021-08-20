const inputTitle = document.querySelector('.js-2input__input-title');
const inputBody = document.querySelector('.js-2input__input-body');

const enableButton = (isValidCount) => {
  const button = document.querySelector('.js-2input__btn');
  if (isValidCount) {
    button.removeAttribute('disabled');
  } else {
    button.setAttribute('disabled', true);
  }
};

inputTitle.addEventListener('input', () => {
  const inputTitleCount = inputTitle.value.length;
  const inputBodyCount = inputBody.value.length;
  const isValidTitleCount = inputTitleCount > 0 && inputTitleCount < 30;
  const isValidBodyCount = inputBodyCount >= 0 && inputBodyCount < 500;
  enableButton(isValidTitleCount && isValidBodyCount);

  const countTitle = document.querySelector('.js-2input__count-title');
  countTitle.innerText = inputTitleCount;

  const judgeTitle = document.querySelector('.js-2input__judge-title');
  if (isValidTitleCount) {
    judgeTitle.classList.remove('js-danger');
  } else {
    judgeTitle.classList.add('js-danger');
  }
});

inputBody.addEventListener('input', () => {
  const inputTitleCount = inputTitle.value.length;
  const inputBodyCount = inputBody.value.length;
  const isValidTitleCount = inputTitleCount > 0 && inputTitleCount < 30;
  const isValidBodyCount = inputBodyCount >= 0 && inputBodyCount < 500;
  enableButton(isValidTitleCount && isValidBodyCount);

  const countBody = document.querySelector('.js-2input__count-body');
  countBody.innerText = inputBodyCount;

  const judgeBody = document.querySelector('.js-2input__judge-body');
  if (isValidBodyCount) {
    judgeBody.classList.remove('js-danger');
  } else {
    judgeBody.classList.add('js-danger');
  }
});

const evt = new Event('input');
inputTitle.dispatchEvent(evt);
inputBody.dispatchEvent(evt);
