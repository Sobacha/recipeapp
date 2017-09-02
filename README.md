# Recipe app
[Rails 5.0.2]
[Ruby 2.2.3]

---

This is my first app project with Ruby on Rails mainly to practice.

It has two basic features.

1. To organize recipes. You can save/edit/delete recipes.
To organize food mainly to prevent food to be expired.

2. You can add/edit/delete food. It shows food list by category in ascending order of expiration date.
It also has an icon to show saved recipes that use food in your list if any.

### How to use

---

```bash
git clone git@github.com:Sobacha/recipeapp.git
cd recipeapp
bundle install
rake db:migrate
rails server
```
