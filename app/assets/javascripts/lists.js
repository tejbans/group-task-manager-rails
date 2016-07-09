
 $(function() {
  $("span[class=title]").on("click", function(e) {
    e.preventDefault();
    var url = this.childNodes[0].href + ".json";
    $.get(url, function(data){
      var id = data["id"]
      var taskTitle = "<h4>" + data["title"] + "</h4>";
      var taskDescription = "<p> Description: " + "<i>"+ data["description"]+ "</i>" + "</p>";
      var taskStatus = "<p>Status: " + "<i>"+ data["status"] + "</i>" + "</p>";
      var taskDuedate = "<p>Due Date: " + "<i>"+ data["due_date"] + "</i>" + "</p>";
      var taskUser = "<p>Assigned to: " + $("#taskUser-" + id).html() + "</p>";
      var taskSeperator = "<p>----------------------------------</p>";
      
      var taskJ = taskTitle + taskDescription + taskStatus + taskDuedate + taskUser+ taskSeperator;

      $("#task-" + id).html(taskJ);
    });
  });
});
