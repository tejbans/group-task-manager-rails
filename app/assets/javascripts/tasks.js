
$(function(){
$("a[href='/mylists']").on("click", function(e) {
      e.preventDefault();
      var tasks=[];
      var tasklists="<h2> My Tasks </h2>";
    $.get("/mylists.json", function(data){
        data.forEach(function(task_attr){
          var task = new Task(task_attr)
          tasks.push(task);
        });
       
        tasks.forEach(function(task){
           tasklists += task.buildTask();
        });
        $('.col-md-8').html(tasklists);
    });
  });
});


function Task(attributes){
    this.id = attributes.id;
    this.title= attributes.title;
    this.description = attributes.description;
    this.status = attributes.status;
    this.due_date = attributes.due_date;
    this.list_id = attributes.list_id;
    this.list_name= attributes.list_info;
    this.user_name= attributes.user_info;
  }

Task.prototype.buildTask = function(){
   var taskList = "";
             taskList += "<li><h3>"+ "<a class=task_title href=/lists/"+ this["list_id"]+ "/tasks/"+ this["id"] + ">"+ this["title"] + "</a></h3> " ;
             taskList +=  this["status"] + ' | ' ;
             taskList +=  this["due_date"] + ' | ' ;
             taskList +=  "Assigned to: " + this["user_name"] + '</li><br>' ;
             
      return taskList
    }

