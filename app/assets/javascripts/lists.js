$(document).ready(function(){
  $("a.task_title").on("click", function(e) {
    
    e.preventDefault();
    var url = this.href + ".json";
    var editurl = this.href;
    $.get(url, function(data){
      var id = data["id"]
      var taskTitle = "<h4>" + data["title"] + "</h4>";
      var taskDescription = "<p> Description: " + "<i>"+ data["description"]+ "</i>" + "</p>";
      var taskStatus = "<p>Status: " + "<i>"+ data["status"] + "</i>" + "</p>";
      var taskDuedate = "<p>Due Date: " + "<i>"+ data["due_date"] + "</i>" + "</p>";
      var taskUser = "<p>Assigned to: " + $("#taskUser-" + id).html() + "</p>";
      var taskEdit = "<a href=" + editurl +"/edit>Edit</a> | ";
      var taskDel = "<a data-confirm='You sure?' rel='nofollow' data-method='delete' href=" + editurl+">Delete</a>";
      var taskSeperator = "<p>----------------------------------</p>";
      
      var taskJ = taskTitle + taskDescription + taskStatus + taskDuedate + taskUser+ taskEdit + taskDel +taskSeperator;
      var $selector = $("#task-" + id);
      $selector.html(taskJ);
      $selector.slideDown(1000);
      });
    });
  });
