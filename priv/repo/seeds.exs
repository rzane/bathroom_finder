alias BathroomFinder.Repo
alias BathroomFinder.Bathroom
alias BathroomFinder.Category

restaurants = Repo.insert! %Category{
  name: "Restaurants"
}

offices = Repo.insert! %Category{
  name: "Offices"
}

Repo.insert! %Bathroom{
  description: "The code is 1515.",
  label: "Starbucks, Walnut Street, Philadelphia, PA, United States",
  latitude: 39.949642,
  longitude: -75.16741999999999,
  category_id: restaurants.id
}

Repo.insert! %Bathroom{
  description: "Vey clean.",
  label: "PromptWorks, Chestnut Street, Philadelphia, PA, United States",
  latitude: 39.9507393,
  longitude: -75.1607353,
  category_id: offices.id
}
