// Homepage manifest
//= require jquery.scrollTo-1.4.2-min.js
//= require jquery.serialScroll-1.2.2-min.js
//= require_self
function initScroll() {
  var w=0;
  $('.homepage-carousel').find('li').each(function(){
    w += $(this).outerWidth(true);
  }).end().width(w);

  $('.homepage-carousel-wrapper').serialScroll({
    axis: 'x',
    duration: 800,
    easing: 'easeInOutQuad',
    step: 1,
    cycle: true,
    items: 'li',
    interval: 8000,
    force: true,
    exclude: 3
    // prev: '.homepage-carousel-controls .prev a',
    // next: '.homepage-carousel-controls .next a',
  });

  $('.homepage-carousel-controls')
  .on('click', '.prev a', function(e) {
    e.preventDefault();
    $('.homepage-carousel-wrapper').trigger('prev');
  }).on('click', '.next a', function(e) {
    e.preventDefault();
    $('.homepage-carousel-wrapper').trigger('next');
  }).on('click', '.pause a', function(e) {
    e.preventDefault();
    $('.homepage-carousel-wrapper').trigger('stop');

    $(this).text('Play').parent('li').removeClass('pause').addClass('play');
  }).on('click', '.play a', function(e) {
    e.preventDefault();
    $('.homepage-carousel-wrapper').trigger('start');

    $(this).text('Pause').parent('li').removeClass('play').addClass('pause');
  });

  $('.homepage-carousel').on('keydown', 'a', function(e){
    if (e.which != 13) {
      $('.homepage-carousel-wrapper').trigger('stop');
      $('.homepage-carousel-wrapper').scrollTo($(this).parent());
    }
  });
}

function initSuggestions() {
  var $li = $('#homepage-search-suggestion').find('li');
  var i = Math.floor(Math.random() * $li.length);
  $li.hide().eq(i).show();
  setInterval(function() { cycleSuggestion(); }, 12000);
}

function cycleSuggestion() {
  var $li = $('#homepage-search-suggestion').find('li:visible').fadeOut(800, function() {
    $(this).next().fadeIn(800);
    if ($(this).next().length < 1) {
      $(this).siblings().first().fadeIn(800);
    }
  });
}



$(document).ready(function() {
  initScroll();
  initSuggestions();
});
