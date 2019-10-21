document.addEventListener('turbolinks:load', function () {
  var progress = document.querySelector('.progress');
  var myProgress = document.querySelector('.myProgress');

  if (progress && myProgress) {
    var question = progress.dataset.questionIndex - 1;
    var questions = progress.dataset.allQuestions;
    myProgress.style.width = question / questions * 100 + '%';
  }
});