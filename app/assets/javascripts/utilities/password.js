document.addEventListener('turbolinks:load', function () {
  var confirmation = document.querySelector('.password-confirmation-form');
  if (confirmation) {
    confirmation.addEventListener('focus', compareValue(confirmation));
  }
})

function compareValue(confirmation) {
  confirmation.addEventListener('keyup', function () {
    var password = document.querySelector('.password-form');
    var passwordConfirm = document.querySelector('.password-confirmation-form');

    if (passwordConfirm.value === password.value) {
      document.querySelector('.octicon-check').classList.remove('hide');
      document.querySelector('.octicon-alert').classList.add('hide');
    } else if (passwordConfirm.value === "") {
      document.querySelector('.octicon-check').classList.add('hide');
      document.querySelector('.octicon-alert').classList.add('hide');
    } else {
      document.querySelector('.octicon-check').classList.add('hide');
      document.querySelector('.octicon-alert').classList.remove('hide');
    }
  })
}