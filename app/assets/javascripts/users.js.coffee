window.UsersController = class UsersController
  constructor: ->
    @wire_follow_button()
  
  
  wire_follow_button: ->
    if $('#unfollow_button').length > 0
      $('#unfollow_button').live
        mouseover: () ->
          $(this).removeClass('success')
          $(this).addClass('danger')
          $(this).text('Unfollow')
          $(this).val('Unfollow')
        ,mouseout: () ->
          $(this).removeClass('danger')
          $(this).addClass('success')
          $(this).text('Following')
          $(this).val('Following')
  