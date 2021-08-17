document.querySelectorAll('.js-table__row-link').forEach(row => {
  row.addEventListener('click', () => {
    location = row.getAttribute('data-href');
  })
});
