jQuery( function($) {
  //data-hrefの属性を持つtrを選択しclassにclickableを付加
  $('.js_table_body_row[data-href]').addClass('clickable').click(
    //ata-hrefの属性を持つtrをクリックしたら動作
    function() {
      //data-href属性の値をattr()メソッドで取得し、ページを遷移させる
      window.location = $(this).attr('data-href');

  //もしtr内にa要素があれば、a要素にホバーした時に以下動作させる
  }).find('a').hover( function() {
    //a要素の先祖要素trのクリックイベントを解除
    $(this).parents('tr').unbind('click');

  //a要素からホバーが抜けたら以下実行
  }, function() {
    //a要素の先祖要素trにクリックイベントを付加
    $(this).parents('tr').click( function() {
      //data-href属性の値をattr()メソッドで取得し、ページを遷移させる
      window.location = $(this).attr('data-href');
    });
  });
});
