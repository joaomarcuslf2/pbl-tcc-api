names = [
  "Maria",
  "Letícia",
  "Rosângela",
  "Anna",
  "Ana",
  "Carla",
  "Nicole",
  "Sandra",
  "Larissa",
  "Marina",
  "Hellen",
  "Fernando",
  "João",
  "Cristiano",
  "Luciano",
  "César",
  "Allan",
  "Carlos",
  "Jordan",
  "Erique",
  "Henrique",
  "Felipe",
  "Thiago",
  "Rodolfo"
]

surnames = [
  "Fernandes",
  "Alves",
  "Gomes",
  "de Souza",
  "Moraes",
  "Lemos",
  "Aguiar",
  "da Silva",
  "Silva",
  "Souza"
]

eventsNames = [
  "HACKATHON: Desenvolvimento social e urbano",
  "Projeto final: Projeto de conclusão do curso",
  "Teste: Envio dos resultados da matéria",
  "Hackathon: Planejamento de estruturas",
  "Hackathon: Teste de evento",
  "Hackathon: Gamificação aplicada à matéria",
  "Hackathon: Teste de evento",
]

areas = [
  "Redes",
  "Algoritmo",
  "Estrutura de Dados",
  "Matemática"
]

User.create(username: "admin", email: "admin@admin.com", role: "admin", password: "@admin123")

(2..6).each { |ref|
  User.create(username: "manager#{ref}", email: "manager#{ref}@email.com", role: "manager", password: "@manager123")
}

(7..22).each { |ref|
  User.create(username: "user#{ref}", email: "user#{ref}@email.com", role: "user", password: "@user123", rate: 1200 + rand(0..250), name: "#{names.sample} #{surnames.sample}")
}

(1..7).each { |ref|
  event = Event.create(
    name: eventsNames[ref] || "#{eventsNames.sample} #{ref}",
    description: "Descrição do evento #{eventsNames[ref]}",
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
