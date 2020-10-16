Blacklight.onLoad(function() {
  $('form.advanced button.collapse-toggle').on('mousedown', function(e) {
    e.preventDefault();
  });

  // Button clicks should change focus. As of 10/3/19, Firefox for Mac and
  // Safari both do not set focus to a button on button click.
  document.querySelectorAll('button.collapse-toggle').forEach((button) => {
    button.addEventListener('click', () => {
      event.target.focus();
    });
  });
});
