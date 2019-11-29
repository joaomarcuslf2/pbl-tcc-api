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
  "João Carlos",
  "Anna Clara",
  "Cristiano",
  "Pedro Henrique",
  "Paulo Henrique",
  "Luciano",
  "César",
  "Allan",
  "Carlos",
  "Jordan",
  "Erique",
  "Henrique",
  "Felipe",
  "Thiago",
  "Rodolfo",
  "Bárbara",
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
  "Souza",
  "Andrade",
  "Almeida",
  "Machado",
  "Ferreira",
  "Braga",
  "da Costa",
  "Gomes",
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
  "Matemática",
  "Banco de Dados",
  "Interface Homem-máquina",
  "Relacionamento Interpessoal",
]

User.create(username: "admin", email: "admin@admin.com", role: "admin", password: "@admin123")

(1..5).each { |ref|
  User.create(username: "manager#{ref}", email: "manager#{ref}@email.com", role: "manager", password: "@manager123")
}

(1..22).each { |ref|
  User.create(username: "user#{ref}", email: "user#{ref}@email.com", role: "user", password: "@user123", rate: 1200 + rand(0..250), name: "#{names.sample} #{surnames.sample}")
}

(1..eventsNames.length-1).each { |ref|
  event = Event.create(
    name: eventsNames[ref] || "#{eventsNames.sample} #{ref}",
    description: "Descrição do evento #{eventsNames[ref]}",
    active: rand(0..3) > 0 ? true : false,
    status: "waiting",
    need_additional: rand(0..3) == 0 ? true : false,
    user_id: rand(2..6),
    areas: "#{areas[rand(0..3)]},#{areas[rand(2..areas.length-1)]}"
  )

  initial = rand(7..20)
  final = rand(18..22)

  (initial..final).each { |user_id|
    Inscription.create(
      user_id: user_id,
      event_id: event.id
    )
  }
}

Requisite.create(name: "Pontualidade", description: "Será avaliado se o projeto foi entregue corretamente")

Pill.create(
  title: "Aprendendo sobre pontualidade 1",
  content: "É normal termos problema com horário, porém em trabalhos acadêmicos e profissionais isso pode ter penalidades altas,\npara não sofrê-las, tente começar com um caderno ou aplicativo no celular(hoje em dia é bem comum os sistemas operacionais virem com aplicativos de agenda e de alarmes),\ncadastre um alarme informando o que você quer fazerr em qual horário, isso já fará com quê você tenha uma melhor organização pessoal.\nAplicativos para celular e computador recomendados: Google Agenda, Google Keep\n\nBoa sorte nos próximos eventos! :D",
  min: 0,
  max: 33,
  requisite_id: 1
)

Pill.create(
  title: "Aprendendo sobre pontualidade 2",
  content: "Você conseguiu uma nota regular na pontualidade, isso já é algo bom, mas por quê parar agora?\nÉ muito comum nos vermos lotado de informações, e isso pode comprometer demais a pontualidade dos eventos, para impedir isso, tente colocar o celular e as redes sociais no modo silencioso, e também procure sobre o método pomodoro, nesse método você irá dedicar um tempo digamos que 3 horas para uma tarefa, você irá distribuir essas horas em ciclos, normalmente 25 minutos de tarefa, 5 de descanso, e a cada 2 ciclos de tarefa seguidos você irá tirar 2 de descanso, com isso, você terá muito mais sucesso em suas tarefas.\nTópicos para pesquisa: Pomodoro\n\nBoa sorte nos próximos eventos! :D",
  min: 34,
  max: 66,
  requisite_id: 1
)

Pill.create(
  title: "Aprendendo sobre pontualidade 3",
  content: "Você conseguiu ir muito bem nesse evento!\nProvavelmente você já chegou em um modelo próprio de organização, seria bom que você pudesse compartilhá-lô com seus outros colega, talvez assim você possa ajudar de alguma forma todos ao seu redor.\nPara tentar também te dar algumas dicas de como ajudar em se organizar, tente pesquisar sobre aplicativos que deixem tanto o celular quanto seu navegador em um modo focado, nesse modo você não receberá notificações, podendo focar muito mais nos estudos.\n\nContinue assim, e boa sorte nos próximos eventos! :D",
  min: 67,
  max: 100,
  requisite_id: 1
)

Requisite.create(name: "Comunicação", description: "Será avaliado se o grupo foi capaz de se expressar corretamente")

Pill.create(
  title: "Aprendendo sobre Comunicação 1",
  content: "Parece que você não se saiu tão bem em Comunicação, sabemos que é muito complicado se comunicar, as vezes por timidez, as vezes por incompatibilidade de perfil com outros membros do grupo, porém devemos sempre ter em mente que em maioria dos casos não existe trabalho sozinho, para tudo tanto no meio acadêmico quanto no mercado de trabalho precisamos aprender a trabalher em equipes e grupos diversos, com isso em mente, separamos algumas dicas para você:\nSe seu problema for timidez, lembre-se que quase sempre os julgamentos que achamos que os outros tem de nós, estão em nossa própria cabeça.\nSe seu problema for incompatibilidade de perfil, lembre-se que você não precisa ser amigo do seu grupo, porém vocês precisam ser companheiros pois o projeto depende de todos vocês juntos.\nSe você tiver algum outro problema, tente conversar com algum professor, ele com certeza pode te ajudar.\n\nMelhor sorte nos próximos eventos! :D",
  min: 0,
  max: 33,
  requisite_id: 2
)

Pill.create(
  title: "Aprendendo sobre Comunicação 2",
  content: "Você conseguiu uma nota regular em Comunicação, isso já é algo bom, mas por quê parar agora?\nGrupos tem uma tendência de separar as tarefas e só juntá-las no final, normalmente isso faz o projeto se tornar um Frankenstein, com isso em mente, nos próximos projetos tente fazer algo mais integrado, tente conversar mais sobre o que cada um está fazendo, tente também ver se alguém precisa de ajuda ou não.\n\nBoa sorte nos próximos eventos! :D",
  min: 34,
  max: 66,
  requisite_id: 2
)

Pill.create(
  title: "Aprendendo sobre Comunicação 3",
  content: "Você conseguiu ir muito bem nesse evento!\nVocê e seu grupo parecem ter tido uma bela performance numa área muito importante no meio acadêmico e no mercado, tente compartilhar com seus outros colegas como vocês se organizaram para tornar essa nota possível.\n\nContinue assim, e boa sorte nos próximos eventos! :D",
  min: 67,
  max: 100,
  requisite_id: 2
)

Requisite.create(name: "Eficácia", description: "Será avaliado se a entrega foi feita respeitando o objetivo do evento")

Pill.create(
  title: "Aprendendo sobre Eficácia 1",
  content: "Parece que você não se saiu tão bem em Eficácia, sabemos que muitas vezes os projetos podem ser difíceis, porém é importante termos capricho e ler re-ler, perguntar para o professor quando tiverem dúvidas do projeto, isso é muito importante para o mercado.\n\nMelhor sorte nos próximos eventos! :D",
  min: 0,
  max: 33,
  requisite_id: 3
)

Pill.create(
  title: "Aprendendo sobre Eficácia 2",
  content: "Você conseguiu uma nota regular em Eficácia, isso já é algo bom, mas por quê parar agora?\nMuitas vezes nós comprometemos a eficácia do projeto pois não entendenmos completamente o que o evento está pedindo, para isso, SEMPRE leia com atenção a descrição do evento, se o professor disponibilizar algum material de referência leia-o também com atenção e tente seguir as referências para que possa se aprofundar nesse assunto.\n\nBoa sorte nos próximos eventos! :D",
  min: 34,
  max: 66,
  requisite_id: 3
)

Pill.create(
  title: "Aprendendo sobre Eficácia 3",
  content: "Você conseguiu ir muito bem nesse evento!\nA eficácia normalmente é o que chama atenção no projeto, muitas vezes um projeto que funciona melhor que outros tem maior destaque no mercado, tente sempre focar nisso, porém não esqueça que existem outras habilidades que também são bastante reconhecidas, compartilhe com seus colegas como você fez seu projeto e ajude a desenvolver sua comunidade.\n\nContinue assim, e boa sorte nos próximos eventos! :D",
  min: 67,
  max: 100,
  requisite_id: 3
)
