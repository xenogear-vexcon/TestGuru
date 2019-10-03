document.addEventListener('turbolinks:load', function() {

  $('.badge-inline-link').on('click', formInlineHandler)

  function formInlineLinkHandler(event) {
    event.preventDefault()

    var badgeId = this.dataset.badgeId
    formInlineHandler(badgeId)
  }

  function formInlineHandler(badgeId) {
    event.preventDefault()
    
    var rule = document.getElementById("badge_rule");
    var title = document.getElementById("badge_title");

    if (rule.value == "first_attempt") {
      rule.value.selected = true;
      title.value = "First try";
      title.textContent = "First try";
    } else if (rule.value == "tests_by_category_finished") {
      rule.value.selected = true;
      title.value = "All tests in category";
      title.textContent = "All tests in category";
    } else if (rule.value == "tests_by_level_finished") {
      rule.value.selected = true;
      title.value = "All tests by level";
      title.textContent = "All tests by level";
    }
  }

  // function autoFill(badge_rule) {
  //   document.getElementById('badge_title').value = badge_rule;
  // }

})

