document.addEventListener('turbolinks:load', function() {
  var password = document.querySelector('.password_form')
  var password_confirmation = document.querySelector('.password_confirmation_form')

  if (password && password_confirmation) {
    password.addEventListener('input', fieldColor)
    password_confirmation.addEventListener('input', fieldColor)
  }
})

function fieldColor() {
  if (password.value === password_confirmation.value) {
    document.querySelector('.octicon-check').classList.remove('hide');
    document.querySelector('.octicon-alert').classList.add('hide');
  } else if (password_confirmation.value === "") {
    document.querySelector('.octicon-check').classList.add('hide');
    document.querySelector('.octicon-alert').classList.add('hide');
  } else {
    document.querySelector('.octicon-check').classList.add('hide');
    document.querySelector('.octicon-alert').classList.remove('hide');
  }
}
