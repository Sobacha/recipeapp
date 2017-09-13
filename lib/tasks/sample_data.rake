namespace :db do
  desc 'Drop, create, migrate, seed and populate sample data'
  task prepare: [:drop, :create, :migrate, :seed, :populate_sample_data] do
    puts 'Ready to go!'
  end

  desc 'Populates the database with sample data'
  task populate_sample_data: :environment do
    # user table
    User.create!(name: "Example One",
                 email: "exampleone@example.com",
                 password: "exampleone",
                 password_confirmation: "exampleone")
    User.create!(name: "Example Two",
                 email: "exampletwo@example.com",
                 password: "exampletwo",
                 password_confirmation: "exampletwo")
    User.create!(name: "Example Three",
                 email: "examplethree@example.com",
                 password: "examplethree",
                 password_confirmation: "examplethree")
    # recipe table
    # for user Example One
    Recipe.create!(category: "Japanese",
                   title: "揚げ出し豆腐",
                   ingredients: "木綿豆腐　…　１丁（３５０ｇ程度）
                   ししとう　…　一人２本ほど（お好みで）
                   薬味　…　大根おろし、おろし生姜、薬味ねぎなど適量
                   揚げ油　…　適量
                   だし汁　…　２００ｍl
                   醤油　…　大さじ３と小さじ１（５０ml）
                   みりん　…　大さじ１と小さじ２（２５ml）",
                   direction: "豆腐は木綿豆腐を用意すること、また豆腐は揚げやすい大きさにすること
                   木綿豆腐は切ったあとに水切りをするものの、水気は切りすぎないこと
                   薬味をできれば数種類用意すること、またその薬味は豆腐を揚げる前にすべて用意しておくこと
                   油は160℃～170℃の少し低めの温度で揚げること",
                   url: "http://www.sirogohan.com/recipe/agedasi/",
                   recipe_image: "http://www.sirogohan.com/_files/recipe/images/agedasi/agedasiyoko.JPG",
                   user_id: 1)
    Recipe.create!(category: "和食",
                   title: "おいももち",
                   ingredients: "じゃがいも　４個
                   片栗粉 大さじ２
                   しょうゆ 大さじ２
                   砂糖 大さじ２
                   水 大さじ１",
                   direction: "1. じゃがいもをやわらかくなるまで茹でて、温かいうちにつぶします。
                   2. １に片栗粉を加え、じゃがいものかたちがなくなるまでよく捏ねます。
                   3. 直径５ｃｍほどの丸に成形し、油をひいたフライパンできつね色になるまで焼きます。
                   4. しょうゆ、砂糖、水を合わせて３に加え、絡めるように焼きます。",
                   url: "https://cookpad.com/recipe/1489753",
                   recipe_image: "https://img.cpcdn.com/recipes/1489753/280/63851b684139663a2adfa8dd7f538172.jpg?u=1087558&p=1309953023",
                   user_id: 1)
    Recipe.create!(category: "Italian",
                   title: "Pizza dough",
                   ingredients: "1 teaspoon active-dry yeast
                   3/4 cup lukewarm water (not hot)
                   2 cups all-purpose flour, plus more if needed
                   1 1/2 teaspoons salt",
                   direction: "Dissolve the yeast in the water: Pour the water into the bowl of a stand mixer or a medium-sized mixing bowl. Sprinkle the yeast over the water, and let stand until the yeast has dissolved.
                   Stir in the flour and salt to form a shaggy dough: Add all of the flour and salt to the bowl with the water and yeast. Stir with a stiff spatula until you’ve formed a floury, shaggy dough.
                   Knead the dough for about 5 minutes: Using the dough hook on a stand mixer, or kneading by hand against the counter, knead the dough until it forms a smooth, slightly tacky ball that springs back when you poke it, 5 to 8 minutes. If the dough sticks to the bowl or your hands like bubblegum, add a tablespoon of flour at a time until it’s easier to work with; avoid adding too much flour if possible.
                   Option 1 — Use the dough right away: If you're in a hurry, skip the rise and make the pizza right now. It will make a thin-crusted pizza with a cracker-like flavor.
                   Option 2 — Let the dough rise for 1 to 1 1/2 hours: If you're planning to make pizza today, then give the dough a rise. Clean out the mixing bowl, film it with a little oil, and transfer the dough back inside. Cover the bowl and let the dough rise until doubled in bulk, 1 to 1 1/2 hours.
                   Option 3 — Store the dough in the fridge: If you're planning to make pizza in the next few days, cover the bowl and store it in the fridge. If you have time, let it rise for about a half an hour before you put it in the fridge to get things going, but it will also be find if you need to store it right away.
                   Prepare the oven for baking: If your dough has been in the fridge, take it out and let it warm on the counter while the oven heats. Heat the oven as hot as it will go, or at least 500°F; put a baking stone or upside-down, heavy sheet pan in the bottom third of the oven.
                   Prepare the pizzas: Divide the dough in half, and pat or roll one of the pieces into a 10-inch round. Transfer the round of dough to a floured baking peel, the back of a sheet pan, or a piece of parchment paper. Top with about 1/4 cup of sauce, some cheese and any other toppings.
                   Bake the pizza for 5 to 10 minutes: Slide the pizza into the oven on top of the baking stone or upside-down sheet pan. Bake until the cheese is melted, the crust golden, and you see a some charred bits on the top and edges. Baking time will vary depending on the heat of your oven and how thick or thin you rolled your pizza.
                   Cool (briefly!) and eat: Let your pizza cool just enough so it won't burn your mouth when you take a bite. Meanwhile, top your other round of dough and get it baking.",
                   url: "http://www.thekitchn.com/how-to-make-pizza-dough-recipe-221367",
                   recipe_image: "https://atmedia.imgix.net/2a68894d40c90073832ce2cda83f0a266a8ad47c?auto=format&q=45&w=600.0&h=800.0&fit=max&cs=strip",
                   user_id: 1)
    Recipe.create!(category: "",
                   title: "Meatball",
                   ingredients: "8 ounces ground pork (butt)
                   8 ounces ground lamb (shoulder)
                   8 ounces ground beef (round)
                   5 ounces frozen spinach, thawed and drained
                   1/2 cup Parmesan cheese, finely grated
                   1 large egg
                   1 1/2 teaspoons dried basil
                   1 1/2 teaspoons dried parsley
                   1 teaspoon garlic powder
                   1 teaspoon kosher salt
                   1/2 teaspoon red pepper flakes
                   1/2 cup bread crumbs",
                   direction: "Heat the oven to 400 degrees F.
                   Combine the pork, lamb, beef, spinach, cheese, egg, basil, parsley, garlic powder, salt, red pepper flakes, and 1/4 cup of the bread crumbs in a large mixing bowl. Using your hands, mix until all ingredients are well incorporated. Use immediately or place in refrigerator for up to 24 hours.
                   Place the remaining 1/4 cup of bread crumbs into a small bowl. Cover a scale with plastic wrap. Weigh meatballs into 1 1/2-ounce portions and place on a half sheet pan. Using clean hands, shape the meatballs into rounds, roll in the breadcrumbs and place the meatballs in miniature muffin tin cups. Cook for 20 minutes, or until golden and cooked through.",
                   url: "https://altonbrown.com/baked-meatballs-recipe/",
                   recipe_image: "https://altonbrown.com/wp-content/uploads/2015/10/alton-brown-baked-meatballs.jpg",
                   user_id: 1)
    Recipe.create!(category: "Dessert",
                   title: "Belgian Waffle",
                   ingredients: "2 cups all-purpose flour
                   3/4 cup sugar
                   3-1/2 teaspoons baking powder
                   2 large eggs, separated
                   1-1/2 cups milk
                   1 cup butter, melted
                   1 teaspoon vanilla extract
                   Sliced fresh strawberries or syrup",
                   direction: "In a bowl, combine flour, sugar and baking powder. In another bowl, lightly beat egg yolks. Add milk, butter and vanilla; mix well. Stir into dry ingredients just until combined. Beat egg whites until stiff peaks form; fold into batter.
                   Bake in a preheated waffle iron according to manufacturer's directions until golden brown. Serve with strawberries or syrup. Yield: 10 waffles (about 4-1/2 inches). ",
                   url: "https://www.tasteofhome.com/recipes/true-belgian-waffles",
                   recipe_image: "https://cdn2.tmbi.com/TOH/Images/Photos/37/300x300/exps4869_RDS2928497A10_11_1b_WEB.jpghttps://cdn2.tmbi.com/TOH/Images/Photos/37/300x300/exps4869_RDS2928497A10_11_1b_WEB.jpg",
                   user_id: 1)
    # for user Example Two
    Recipe.create!(category: "Japanese",
                   title: "揚げ出し豆腐",
                   ingredients: "木綿豆腐　…　１丁（３５０ｇ程度）
                   ししとう　…　一人２本ほど（お好みで）
                   薬味　…　大根おろし、おろし生姜、薬味ねぎなど適量
                   揚げ油　…　適量
                   だし汁　…　２００ｍl
                   醤油　…　大さじ３と小さじ１（５０ml）
                   みりん　…　大さじ１と小さじ２（２５ml）",
                   direction: "豆腐は木綿豆腐を用意すること、また豆腐は揚げやすい大きさにすること
                   木綿豆腐は切ったあとに水切りをするものの、水気は切りすぎないこと
                   薬味をできれば数種類用意すること、またその薬味は豆腐を揚げる前にすべて用意しておくこと
                   油は160℃～170℃の少し低めの温度で揚げること",
                   url: "http://www.sirogohan.com/recipe/agedasi/",
                   recipe_image: "http://www.sirogohan.com/_files/recipe/images/agedasi/agedasiyoko.JPG",
                   user_id: 2)
    Recipe.create!(category: "和食",
                   title: "おいももち",
                   ingredients: "じゃがいも　４個
                   片栗粉 大さじ２
                   しょうゆ 大さじ２
                   砂糖 大さじ２
                   水 大さじ１",
                   direction: "1. じゃがいもをやわらかくなるまで茹でて、温かいうちにつぶします。
                   2. １に片栗粉を加え、じゃがいものかたちがなくなるまでよく捏ねます。
                   3. 直径５ｃｍほどの丸に成形し、油をひいたフライパンできつね色になるまで焼きます。
                   4. しょうゆ、砂糖、水を合わせて３に加え、絡めるように焼きます。",
                   url: "https://cookpad.com/recipe/1489753",
                   recipe_image: "https://img.cpcdn.com/recipes/1489753/280/63851b684139663a2adfa8dd7f538172.jpg?u=1087558&p=1309953023",
                   user_id: 2)
    Recipe.create!(category: "Italian",
                   title: "Pizza dough",
                   ingredients: "1 teaspoon active-dry yeast
                   3/4 cup lukewarm water (not hot)
                   2 cups all-purpose flour, plus more if needed
                   1 1/2 teaspoons salt",
                   direction: "Dissolve the yeast in the water: Pour the water into the bowl of a stand mixer or a medium-sized mixing bowl. Sprinkle the yeast over the water, and let stand until the yeast has dissolved.
                   Stir in the flour and salt to form a shaggy dough: Add all of the flour and salt to the bowl with the water and yeast. Stir with a stiff spatula until you’ve formed a floury, shaggy dough.
                   Knead the dough for about 5 minutes: Using the dough hook on a stand mixer, or kneading by hand against the counter, knead the dough until it forms a smooth, slightly tacky ball that springs back when you poke it, 5 to 8 minutes. If the dough sticks to the bowl or your hands like bubblegum, add a tablespoon of flour at a time until it’s easier to work with; avoid adding too much flour if possible.
                   Option 1 — Use the dough right away: If you're in a hurry, skip the rise and make the pizza right now. It will make a thin-crusted pizza with a cracker-like flavor.
                   Option 2 — Let the dough rise for 1 to 1 1/2 hours: If you're planning to make pizza today, then give the dough a rise. Clean out the mixing bowl, film it with a little oil, and transfer the dough back inside. Cover the bowl and let the dough rise until doubled in bulk, 1 to 1 1/2 hours.
                   Option 3 — Store the dough in the fridge: If you're planning to make pizza in the next few days, cover the bowl and store it in the fridge. If you have time, let it rise for about a half an hour before you put it in the fridge to get things going, but it will also be find if you need to store it right away.
                   Prepare the oven for baking: If your dough has been in the fridge, take it out and let it warm on the counter while the oven heats. Heat the oven as hot as it will go, or at least 500°F; put a baking stone or upside-down, heavy sheet pan in the bottom third of the oven.
                   Prepare the pizzas: Divide the dough in half, and pat or roll one of the pieces into a 10-inch round. Transfer the round of dough to a floured baking peel, the back of a sheet pan, or a piece of parchment paper. Top with about 1/4 cup of sauce, some cheese and any other toppings.
                   Bake the pizza for 5 to 10 minutes: Slide the pizza into the oven on top of the baking stone or upside-down sheet pan. Bake until the cheese is melted, the crust golden, and you see a some charred bits on the top and edges. Baking time will vary depending on the heat of your oven and how thick or thin you rolled your pizza.
                   Cool (briefly!) and eat: Let your pizza cool just enough so it won't burn your mouth when you take a bite. Meanwhile, top your other round of dough and get it baking.",
                   url: "http://www.thekitchn.com/how-to-make-pizza-dough-recipe-221367",
                   recipe_image: "https://atmedia.imgix.net/2a68894d40c90073832ce2cda83f0a266a8ad47c?auto=format&q=45&w=600.0&h=800.0&fit=max&cs=strip",
                   user_id: 2)
    Recipe.create!(category: "",
                   title: "Meatball",
                   ingredients: "8 ounces ground pork (butt)
                   8 ounces ground lamb (shoulder)
                   8 ounces ground beef (round)
                   5 ounces frozen spinach, thawed and drained
                   1/2 cup Parmesan cheese, finely grated
                   1 large egg
                   1 1/2 teaspoons dried basil
                   1 1/2 teaspoons dried parsley
                   1 teaspoon garlic powder
                   1 teaspoon kosher salt
                   1/2 teaspoon red pepper flakes
                   1/2 cup bread crumbs",
                   direction: "Heat the oven to 400 degrees F.
                   Combine the pork, lamb, beef, spinach, cheese, egg, basil, parsley, garlic powder, salt, red pepper flakes, and 1/4 cup of the bread crumbs in a large mixing bowl. Using your hands, mix until all ingredients are well incorporated. Use immediately or place in refrigerator for up to 24 hours.
                   Place the remaining 1/4 cup of bread crumbs into a small bowl. Cover a scale with plastic wrap. Weigh meatballs into 1 1/2-ounce portions and place on a half sheet pan. Using clean hands, shape the meatballs into rounds, roll in the breadcrumbs and place the meatballs in miniature muffin tin cups. Cook for 20 minutes, or until golden and cooked through.",
                   url: "https://altonbrown.com/baked-meatballs-recipe/",
                   recipe_image: "https://altonbrown.com/wp-content/uploads/2015/10/alton-brown-baked-meatballs.jpg",
                   user_id: 2)
    Recipe.create!(category: "Dessert",
                   title: "Belgian Waffle",
                   ingredients: "2 cups all-purpose flour
                   3/4 cup sugar
                   3-1/2 teaspoons baking powder
                   2 large eggs, separated
                   1-1/2 cups milk
                   1 cup butter, melted
                   1 teaspoon vanilla extract
                   Sliced fresh strawberries or syrup",
                   direction: "In a bowl, combine flour, sugar and baking powder. In another bowl, lightly beat egg yolks. Add milk, butter and vanilla; mix well. Stir into dry ingredients just until combined. Beat egg whites until stiff peaks form; fold into batter.
                   Bake in a preheated waffle iron according to manufacturer's directions until golden brown. Serve with strawberries or syrup. Yield: 10 waffles (about 4-1/2 inches). ",
                   url: "https://www.tasteofhome.com/recipes/true-belgian-waffles",
                   recipe_image: "https://cdn2.tmbi.com/TOH/Images/Photos/37/300x300/exps4869_RDS2928497A10_11_1b_WEB.jpghttps://cdn2.tmbi.com/TOH/Images/Photos/37/300x300/exps4869_RDS2928497A10_11_1b_WEB.jpg",
                   user_id: 2)
    # for user Example Three
    Recipe.create!(category: "Japanese",
                   title: "揚げ出し豆腐",
                   ingredients: "木綿豆腐　…　１丁（３５０ｇ程度）
                   ししとう　…　一人２本ほど（お好みで）
                   薬味　…　大根おろし、おろし生姜、薬味ねぎなど適量
                   揚げ油　…　適量
                   だし汁　…　２００ｍl
                   醤油　…　大さじ３と小さじ１（５０ml）
                   みりん　…　大さじ１と小さじ２（２５ml）",
                   direction: "豆腐は木綿豆腐を用意すること、また豆腐は揚げやすい大きさにすること
                   木綿豆腐は切ったあとに水切りをするものの、水気は切りすぎないこと
                   薬味をできれば数種類用意すること、またその薬味は豆腐を揚げる前にすべて用意しておくこと
                   油は160℃～170℃の少し低めの温度で揚げること",
                   url: "http://www.sirogohan.com/recipe/agedasi/",
                   recipe_image: "http://www.sirogohan.com/_files/recipe/images/agedasi/agedasiyoko.JPG",
                   user_id: 3)
    Recipe.create!(category: "和食",
                   title: "おいももち",
                   ingredients: "じゃがいも　４個
                   片栗粉 大さじ２
                   しょうゆ 大さじ２
                   砂糖 大さじ２
                   水 大さじ１",
                   direction: "1. じゃがいもをやわらかくなるまで茹でて、温かいうちにつぶします。
                   2. １に片栗粉を加え、じゃがいものかたちがなくなるまでよく捏ねます。
                   3. 直径５ｃｍほどの丸に成形し、油をひいたフライパンできつね色になるまで焼きます。
                   4. しょうゆ、砂糖、水を合わせて３に加え、絡めるように焼きます。",
                   url: "https://cookpad.com/recipe/1489753",
                   recipe_image: "https://img.cpcdn.com/recipes/1489753/280/63851b684139663a2adfa8dd7f538172.jpg?u=1087558&p=1309953023",
                   user_id: 3)
    Recipe.create!(category: "Italian",
                   title: "Pizza dough",
                   ingredients: "1 teaspoon active-dry yeast
                   3/4 cup lukewarm water (not hot)
                   2 cups all-purpose flour, plus more if needed
                   1 1/2 teaspoons salt",
                   direction: "Dissolve the yeast in the water: Pour the water into the bowl of a stand mixer or a medium-sized mixing bowl. Sprinkle the yeast over the water, and let stand until the yeast has dissolved.
                   Stir in the flour and salt to form a shaggy dough: Add all of the flour and salt to the bowl with the water and yeast. Stir with a stiff spatula until you’ve formed a floury, shaggy dough.
                   Knead the dough for about 5 minutes: Using the dough hook on a stand mixer, or kneading by hand against the counter, knead the dough until it forms a smooth, slightly tacky ball that springs back when you poke it, 5 to 8 minutes. If the dough sticks to the bowl or your hands like bubblegum, add a tablespoon of flour at a time until it’s easier to work with; avoid adding too much flour if possible.
                   Option 1 — Use the dough right away: If you're in a hurry, skip the rise and make the pizza right now. It will make a thin-crusted pizza with a cracker-like flavor.
                   Option 2 — Let the dough rise for 1 to 1 1/2 hours: If you're planning to make pizza today, then give the dough a rise. Clean out the mixing bowl, film it with a little oil, and transfer the dough back inside. Cover the bowl and let the dough rise until doubled in bulk, 1 to 1 1/2 hours.
                   Option 3 — Store the dough in the fridge: If you're planning to make pizza in the next few days, cover the bowl and store it in the fridge. If you have time, let it rise for about a half an hour before you put it in the fridge to get things going, but it will also be find if you need to store it right away.
                   Prepare the oven for baking: If your dough has been in the fridge, take it out and let it warm on the counter while the oven heats. Heat the oven as hot as it will go, or at least 500°F; put a baking stone or upside-down, heavy sheet pan in the bottom third of the oven.
                   Prepare the pizzas: Divide the dough in half, and pat or roll one of the pieces into a 10-inch round. Transfer the round of dough to a floured baking peel, the back of a sheet pan, or a piece of parchment paper. Top with about 1/4 cup of sauce, some cheese and any other toppings.
                   Bake the pizza for 5 to 10 minutes: Slide the pizza into the oven on top of the baking stone or upside-down sheet pan. Bake until the cheese is melted, the crust golden, and you see a some charred bits on the top and edges. Baking time will vary depending on the heat of your oven and how thick or thin you rolled your pizza.
                   Cool (briefly!) and eat: Let your pizza cool just enough so it won't burn your mouth when you take a bite. Meanwhile, top your other round of dough and get it baking.",
                   url: "http://www.thekitchn.com/how-to-make-pizza-dough-recipe-221367",
                   recipe_image: "https://atmedia.imgix.net/2a68894d40c90073832ce2cda83f0a266a8ad47c?auto=format&q=45&w=600.0&h=800.0&fit=max&cs=strip",
                   user_id: 3)
    Recipe.create!(category: "",
                   title: "Meatball",
                   ingredients: "8 ounces ground pork (butt)
                   8 ounces ground lamb (shoulder)
                   8 ounces ground beef (round)
                   5 ounces frozen spinach, thawed and drained
                   1/2 cup Parmesan cheese, finely grated
                   1 large egg
                   1 1/2 teaspoons dried basil
                   1 1/2 teaspoons dried parsley
                   1 teaspoon garlic powder
                   1 teaspoon kosher salt
                   1/2 teaspoon red pepper flakes
                   1/2 cup bread crumbs",
                   direction: "Heat the oven to 400 degrees F.
                   Combine the pork, lamb, beef, spinach, cheese, egg, basil, parsley, garlic powder, salt, red pepper flakes, and 1/4 cup of the bread crumbs in a large mixing bowl. Using your hands, mix until all ingredients are well incorporated. Use immediately or place in refrigerator for up to 24 hours.
                   Place the remaining 1/4 cup of bread crumbs into a small bowl. Cover a scale with plastic wrap. Weigh meatballs into 1 1/2-ounce portions and place on a half sheet pan. Using clean hands, shape the meatballs into rounds, roll in the breadcrumbs and place the meatballs in miniature muffin tin cups. Cook for 20 minutes, or until golden and cooked through.",
                   url: "https://altonbrown.com/baked-meatballs-recipe/",
                   recipe_image: "https://altonbrown.com/wp-content/uploads/2015/10/alton-brown-baked-meatballs.jpg",
                   user_id: 3)
    Recipe.create!(category: "Dessert",
                   title: "Belgian Waffle",
                   ingredients: "2 cups all-purpose flour
                   3/4 cup sugar
                   3-1/2 teaspoons baking powder
                   2 large eggs, separated
                   1-1/2 cups milk
                   1 cup butter, melted
                   1 teaspoon vanilla extract
                   Sliced fresh strawberries or syrup",
                   direction: "In a bowl, combine flour, sugar and baking powder. In another bowl, lightly beat egg yolks. Add milk, butter and vanilla; mix well. Stir into dry ingredients just until combined. Beat egg whites until stiff peaks form; fold into batter.
                   Bake in a preheated waffle iron according to manufacturer's directions until golden brown. Serve with strawberries or syrup. Yield: 10 waffles (about 4-1/2 inches). ",
                   url: "https://www.tasteofhome.com/recipes/true-belgian-waffles",
                   recipe_image: "https://cdn2.tmbi.com/TOH/Images/Photos/37/300x300/exps4869_RDS2928497A10_11_1b_WEB.jpghttps://cdn2.tmbi.com/TOH/Images/Photos/37/300x300/exps4869_RDS2928497A10_11_1b_WEB.jpg",
                   user_id: 3)
    # food table
    # for user Example One
    Food.create!(category: "Meat",
                 name: "Tofu",
                 purchase_date: "2017-10-10",
                 expiration_date: "2017-10-10",
                 quantity: 1,
                 user_id: 1)
    Food.create!(category: "Grain",
                 name: "米",
                 purchase_date: "2017-10-01",
                 expiration_date: "2017-10-15",
                 quantity: 5,
                 user_id: 1)
    Food.create!(category: "Fruit",
                 name: "Strawberry",
                 purchase_date: "2017-10-10",
                 expiration_date: "2017-10-20",
                 quantity: 1,
                 user_id: 1)
    Food.create!(category: "Dairy",
                 name: "Milk",
                 purchase_date: "2017-10-01",
                 expiration_date: "2017-11-15",
                 quantity: 1,
                 user_id: 1)
    Food.create!(category: "Meat",
                 name: "Beef",
                 purchase_date: "2017-10-10",
                 expiration_date: "2017-10-10",
                 quantity: 1,
                 user_id: 1)
    Food.create!(category: "Other",
                 name: "わかめ",
                 purchase_date: "2017-10-01",
                 expiration_date: "2018-10-15",
                 quantity: 5,
                 user_id: 1)
    Food.create!(category: "Vegetable",
                 name: "Broccoli",
                 purchase_date: "2017-10-10",
                 expiration_date: "2017-10-12",
                 quantity: 1,
                 user_id: 1)
    Food.create!(category: "Vegetable",
                 name: "じゃがいも",
                 purchase_date: "2017-10-01",
                 expiration_date: "2017-10-30",
                 quantity: 15,
                 user_id: 1)
    Food.create!(category: "Other",
                 name: "Soy sauce",
                 purchase_date: "2017-10-10",
                 expiration_date: "2019-10-10",
                 quantity: 1,
                 user_id: 1)
    Food.create!(category: "Other",
                 name: "Cane Sugar",
                 purchase_date: "2017-10-01",
                 expiration_date: "2020-10-15",
                 quantity: 1,
                 user_id: 1)
    # for user Example Two
    Food.create!(category: "Meat",
                 name: "Tofu",
                 purchase_date: "2017-10-10",
                 expiration_date: "2017-10-10",
                 quantity: 1,
                 user_id: 2)
    Food.create!(category: "Grain",
                 name: "米",
                 purchase_date: "2017-10-01",
                 expiration_date: "2017-10-15",
                 quantity: 5,
                 user_id: 2)
    Food.create!(category: "Fruit",
                 name: "Strawberry",
                 purchase_date: "2017-10-10",
                 expiration_date: "2017-10-20",
                 quantity: 1,
                 user_id: 2)
    Food.create!(category: "Dairy",
                 name: "Milk",
                 purchase_date: "2017-10-01",
                 expiration_date: "2017-11-15",
                 quantity: 1,
                 user_id: 2)
    Food.create!(category: "Meat",
                 name: "Beef",
                 purchase_date: "2017-10-10",
                 expiration_date: "2017-10-10",
                 quantity: 1,
                 user_id: 2)
    Food.create!(category: "Other",
                 name: "わかめ",
                 purchase_date: "2017-10-01",
                 expiration_date: "2018-10-15",
                 quantity: 5,
                 user_id: 2)
    Food.create!(category: "Vegetable",
                 name: "Broccoli",
                 purchase_date: "2017-10-10",
                 expiration_date: "2017-10-12",
                 quantity: 1,
                 user_id: 2)
    Food.create!(category: "Vegetable",
                 name: "じゃがいも",
                 purchase_date: "2017-10-01",
                 expiration_date: "2017-10-30",
                 quantity: 15,
                 user_id: 2)
    Food.create!(category: "Other",
                 name: "Soy sauce",
                 purchase_date: "2017-10-10",
                 expiration_date: "2019-10-10",
                 quantity: 1,
                 user_id: 2)
    Food.create!(category: "Other",
                 name: "Cane Sugar",
                 purchase_date: "2017-10-01",
                 expiration_date: "2020-10-15",
                 quantity: 1,
                 user_id: 2)
    # for user Example Three
    Food.create!(category: "Meat",
                 name: "Tofu",
                 purchase_date: "2017-10-10",
                 expiration_date: "2017-10-10",
                 quantity: 1,
                 user_id: 3)
    Food.create!(category: "Grain",
                 name: "米",
                 purchase_date: "2017-10-01",
                 expiration_date: "2017-10-15",
                 quantity: 5,
                 user_id: 3)
    Food.create!(category: "Fruit",
                 name: "Strawberry",
                 purchase_date: "2017-10-10",
                 expiration_date: "2017-10-20",
                 quantity: 1,
                 user_id: 3)
    Food.create!(category: "Dairy",
                 name: "Milk",
                 purchase_date: "2017-10-01",
                 expiration_date: "2017-11-15",
                 quantity: 1,
                 user_id: 3)
    Food.create!(category: "Meat",
                 name: "Beef",
                 purchase_date: "2017-10-10",
                 expiration_date: "2017-10-10",
                 quantity: 1,
                 user_id: 3)
    Food.create!(category: "Other",
                 name: "わかめ",
                 purchase_date: "2017-10-01",
                 expiration_date: "2018-10-15",
                 quantity: 5,
                 user_id: 3)
    Food.create!(category: "Vegetable",
                 name: "Broccoli",
                 purchase_date: "2017-10-10",
                 expiration_date: "2017-10-12",
                 quantity: 1,
                 user_id: 3)
    Food.create!(category: "Vegetable",
                 name: "じゃがいも",
                 purchase_date: "2017-10-01",
                 expiration_date: "2017-10-30",
                 quantity: 15,
                 user_id: 3)
    Food.create!(category: "Other",
                 name: "Soy sauce",
                 purchase_date: "2017-10-10",
                 expiration_date: "2019-10-10",
                 quantity: 1,
                 user_id: 3)
    Food.create!(category: "Other",
                 name: "Cane Sugar",
                 purchase_date: "2017-10-01",
                 expiration_date: "2020-10-15",
                 quantity: 1,
                 user_id: 3)
  end
end
