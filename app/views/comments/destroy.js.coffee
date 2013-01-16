$('#new_comment')[0].reset()

$('#comments_count').html '<%= @comment.post.comments.count %>'

$('#<%= dom_id(@comment) %>')
  .fadeOut ->
    $(this).remove()



