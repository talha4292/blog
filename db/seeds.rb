# frozen_string_literal: true

User.create(email: 'bloggyadmin@gmail.com', first_name: 'Bloggy', last_name: 'Admin', username: 'bloggyadmin',
            about: '', birthday: '1991-09-13', role: 'admin', image_data: nil, password: '123456',
            password_confirmation: '123456')

User.create(email: 'talhatahir598@gmail.com', first_name: 'Talha', last_name: 'Tahir', username: 'talha598',
            about: '', birthday: '2000-04-28', role: 'moderator', image_data: nil, password: '123456',
            password_confirmation: '123456')

User.create(email: 'usmanjanjuaa3@gmail.com', first_name: 'Usman', last_name: 'Mazhar', username: 'usmanjan3',
            about: '', birthday: '2000-07-23', role: 'user', image_data: nil, password: '123456',
            password_confirmation: '123456')

User.create(email: 'usmanvirk052@gmail.com', first_name: 'Usman', last_name: 'Virk', username: 'usman052',
            about: '', birthday: '2000-07-23', role: 'user', image_data: nil, password: '123456',
            password_confirmation: '123456')

Post.create(title: 'Ruby on Rails', text: "<h1>Ruby</h1>\r\n<p>Programming Language</p>\r\n", user_id: 3,
            status: 1, image_data: '{"id":"e814c119567baf77ea4af3755ea24c50.png","storage":"store","metadata":' \
                                   '{"filename":"video-bg.png","size":706733,"mime_type":"image/png","width":' \
                                   '1146,"height":560}}')

Like.create(user_id: 4, likeable_type: 'Post', likeable_id: 1)

Comment.create(text: 'Nice!', user_id: 4, commentable_type: 'Post', commentable_id: 1, parent_id: nil, image_data: nil)

Suggestion.create(text: "<h1>Ruby</h1>\r\n<p>Programming Language mostly in Rails App</p>\r\n", user_id: 4, post_id: 1)

Report.create(text: 'Spam', user_id: 3, reportable_type: 'Comment', reportable_id: 1)
