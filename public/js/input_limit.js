jQuery(function($) {
  // body textareaへ入力時のイベント
  $('.js_body').on('input', function() {
    // 文字数を取得する
    var cnt = $(this).val().length;
    // 現在の文字数を表示する
    $('.js_now_body_cnt').text(cnt);
    // 0文字以上かつ500文字以内の場合、ボタンを有効化＆黒字
    if (cnt >= 0 && 500 > cnt) {
      $('.js_btn').prop('disabled', false);
      $('.js_body_cnt_area').removeClass('js_cnt_danger');
    } else {
      // 500文字を超える場合、ボタンを無効化＆赤字
      $('.js_btn').prop('disabled', true);
      $('.js_body_cnt_area').addClass('js_cnt_danger');
    }
  });

  // title テキストボックスへ入力時のイベント
  $('.js_title').on('input', function() {
    // 文字数を取得する
    var cnt = $(this).val().length;
    // 現在の文字数を表示する
    $('.js_now_title_cnt').text(cnt);
    // 1文字以上かつ30文字以内の場合、ボタンを有効化＆黒字
    if (cnt > 0 && 30 > cnt) {
      $('.js_btn').prop('disabled', false);
      $('.js_title_cnt_area').removeClass('js_cnt_danger');
    } else {
      // 0文字または30文字を超える場合、ボタンを無効化＆赤字
      $('.js_btn').prop('disabled', true);
      $('.js_title_cnt_area').addClass('js_cnt_danger');
    }
  });

  // リロード時に初期文字列が入っていた時の対策
  $('.js_body').trigger('input');
  $('.js_title').trigger('input');
});
