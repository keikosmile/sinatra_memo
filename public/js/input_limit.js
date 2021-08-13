$(function() {
  $('.js-2input__input1').on('input', function() {

    var cnt = $('.js-2input__input1').val().length;
    var cnt2 = $('.js-2input__input2').val().length;

    $('.js-2input__cnt1').text(cnt);

    // cntは黒字
    if (cnt > 0 && cnt < 30) {
      $('.js-2input__target1').removeClass('js-danger');
      // cnt2は黒字
      if (cnt2 >= 0 && cnt2 < 500) {
        $('.js-2input__btn').prop('disabled', false);
      }
      // cnt2は赤字
      else {
        $('.js-2input__btn').prop('disabled', true);
      }
    // cntは赤字
    } else {
      $('.js-2input__target1').addClass('js-danger');
      $('.js-2input__btn').prop('disabled', true);
    }
  });

  $('.js-2input__input2').on('input', function() {

    var cnt = $('.js-2input__input1').val().length;
    var cnt2 = $('.js-2input__input2').val().length;

    $('.js-2input__cnt2').text(cnt2);

    // cnt2は黒字
    if (cnt2 >= 0 && cnt2 < 500) {
      $('.js-2input__target2').removeClass('js-danger');
      // cntは黒字
      if (cnt > 0 && cnt < 30) {
        $('.js-2input__btn').prop('disabled', false);
      // cntは赤字
      } else {
        $('.js-2input__btn').prop('disabled', true);
      }
    // cnt2は赤字
    } else {
      $('.js-2input__target2').addClass('js-danger');
      $('.js-2input__btn').prop('disabled', true);
    }
  });

  $('.js-2input__input1').trigger('input');
  $('.js-2input__input2').trigger('input');
});
