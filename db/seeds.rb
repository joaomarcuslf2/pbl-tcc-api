# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(username: "admin", email: "admin@admin.com", role: "admin", password: "@admin123")

(2..6).each { |ref|
  User.create(username: "manager#{ref}", email: "manager#{ref}@email.com", role: "manager", password: "@manager123")
}

(7..22).each { |ref|
  User.create(username: "user#{ref}", email: "user#{ref}@email.com", role: "user", password: "@user123", rate: 1200 + rand(0..550))
}

(1..7).each { |ref|
  areas = [
    "Redes",
    "Algoritmo",
    "Estrutura de Dados",
    "Matemática"
  ]

  event = Event.create(
    name: "Hackathon com nome genérico #{ref}",
    description: "descrição genérica",
    active: rand(0..3) > 0 ? true : false,
    status: "waiting",
    need_additional: rand(0..3) == 0 ? true : false,
    user_id: rand(2..6),
    areas: "#{areas[rand(0..3)]},#{areas[rand(0..3)]}"
  )

  initial = rand(7..20)
  final = rand(21..22)

  (initial..final).each { |user_id|
    Inscription.create(
      user_id: user_id,
      event_id: event.id
    )
  }
}

Requisite.create(name: "Pontualidade", description: "Será avaliado se o projeto foi entregue corretamente")
Requisite.create(name: "Comunicação", description: "Será avaliado se o grupo foi capaz de se expressar corretamente")
Requisite.create(name: "Eficácia", description: "Será avaliado se a entrega foi feita respeitando o objetivo do evento")
