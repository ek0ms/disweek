FactoryGirl.define do
  factory :photo, aliases: [:photo_1] do
    link "https://www.instagram.com/p/BEuLW1HRm77/"
    low_res_link "https://scontent.cdninstagram.com/t51.2885-15/s320x320/e35/12976372_580361552138047_896185468_n.jpg?ig_cache_key=MTIzNzk3Njg5NDk0Mzk0ODUzOQ%3D%3D.2"
    created_on_insta 1461684547
    username "mynameyeffzhen"
    profile_picture "https://scontent.cdninstagram.com/t51.2885-19/s150x150/13129995_1532469667058834_410948918_a.jpg"
    caption "poofs"
    location
    likes 20
    comments 10
    popularity 30

    factory :photo_2 do
      link "https://www.instagram.com/p/BEuLZg3xm7_/"
      low_res_link "https://scontent.cdninstagram.com/t51.2885-15/s320x320/e35/12960142_1017627551648549_971027856_n.jpg?ig_cache_key=MTIzNzk3NzA3OTM2NzQ5NTQyMw%3D%3D.2"
      created_on_insta 1461688547
      username "mynameyeffzhen"
      profile_picture "https://scontent.cdninstagram.com/t51.2885-19/s150x150/13129995_1532469667058834_410948918_a.jpg"
      caption "i love cream puffs"
      location
      likes 20
      comments 10
      popularity 30
    end
  end
end
