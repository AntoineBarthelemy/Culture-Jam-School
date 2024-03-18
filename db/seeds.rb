puts "Clearing existing data..."

# Require
require "open-uri"


# Destroy de toute les instances
Notification.destroy_all
Friend.destroy_all()
User.destroy_all()
Category.destroy_all()
Toi.destroy_all()
Post.destroy_all()
ToiArtist.destroy_all()
Artist.destroy_all()


# User.create!(email: "test@test.com", password: "azerty", username: "testuser", permitted: true)

user_name = ["oscar", "antoine", "sacha", "constance", "alexandre", "ahmed", "fares", "victoria", "sofiane", "ophelie", "samuel", "kim", "theophile", "guillaume", "anouar", "zena", "wilfried", "isaiah", "coralie", "clemence", "nicolas", "clothilde", "gabrielle", "pierre"]


puts "Creating users, Estimated waiting #{user_name.length * 2} secondes..."

user_name.each do |name|


  cloudinary_image_url_avatar = "https://res.cloudinary.com/drrbvxo6s/image/upload/#{name}"


  avatar = URI.open(cloudinary_image_url_avatar)



  user_photo = User.new(
    email: "#{Faker::Internet.email}",
    password: "123456",
    username: name,
    permitted: [true,false].sample
    )

  user_photo.photo.attach(io: avatar, filename: "nes.png", content_type: "image/jpg")
  user_photo.save



end

puts "#{User.count} users created successfully!"

puts "Creating categories..."

['Cinema', 'Spectacle', 'Litterature', 'Exposition'].each do |category_name|
  Category.create!(name: category_name)
end

puts "#{Category.count} categories created sucessfully!"

ITEMS = {

  #  Cinema

  "Le Fantôme de l'Opéra" => {
    title: "Le Fantôme de l'Opéra",
    description: "Une histoire intemporelle de séduction et de désespoir. Le Fantôme, vivant dans les catacombes de l'Opéra de Paris, utilise ses pouvoirs pour aider la jeune soprano Christine à devenir une étoile. Cette sombre et romantique histoire captive le public avec ses belles mélodies et son récit dramatique.",
    trailer: "https://www.youtube.com/watch?v=n6jCJZEFIto",
    artists: ["Gerard Butler", "Emmy Rossum", "Patrick Wilson"],
    category: Category.find_by(name: "Cinema")
  },
  "Hamilton" => {
    title: "Hamilton",
    description: "Une comédie musicale américaine qui mélange hip hop, jazz, R&B et Broadway pour raconter l'histoire d'Alexander Hamilton, l'un des pères fondateurs de l'Amérique. Sa technique narrative innovante, sa musique et la diversité de son casting ont été saluées pour avoir insufflé une nouvelle vie à Broadway.",
    trailer: "https://www.youtube.com/watch?v=DSCKfXpAGHc",
    artists: ["Lin-Manuel Miranda", "Leslie Odom Jr.", "Phillipa Soo", "Renée Elise Goldsberry"],
    category: Category.find_by(name: "Cinema")
  },
  "Cirque du Soleil : O" => {
    title: "Cirque du Soleil : O",
    description: "Une tapisserie aquatique d'art, de surréalisme et de romance théâtrale dans la production intemporelle 'O'. Les artistes du spectacle se lancent dans un voyage aquatique de fantaisie et d'illusion, intégrant sans effort l'acrobatie, la plongée et la natation.",
    trailer: "https://www.youtube.com/watch?v=OvoT7W2E-_Y",
    artists: ["Cirque du Soleil Performers"],
    category: Category.find_by(name: "Cinema")
  },
  "Wicked" => {
    title: "Wicked",
    description: "L'histoire inédite des sorcières d'Oz. 'Wicked' raconte l'histoire d'une femme à la peau verte nommée Elphaba, qui devient la méchante sorcière de l'Ouest. Ce spectacle captivant explore les thèmes de l'amitié, de l'amour et de l'intrigue politique.",
    trailer: "https://www.youtube.com/watch?v=3g4ekwTd6Ig",
    artists: ["Idina Menzel", "Kristin Chenoweth", "Joel Grey"],
    category: Category.find_by(name: "Cinema")
  },
  "Le Roi Lion" => {
    title: "Le Roi Lion",
    description: "Une histoire vibrante et excitante de la savane africaine. 'Le Roi Lion' donne vie à l'histoire de Simba, un jeune prince lion qui se lance dans un voyage pour comprendre son destin royal. Des visuels époustouflants et des chansons encadrent ce conte intemporel de famille et de pardon.",
    trailer: "https://www.youtube.com/watch?v=7TavVZMewpY",
    artists: ["Donald Glover", "Beyoncé", "James Earl Jones"],
    category: Category.find_by(name: "Cinema")
  },
  "Groupe Blue Man" => {
    title: "Groupe Blue Man",
    description: "Une performance dynamique et innovante qui combine musique, technologie et comédie pour créer une forme de divertissement qui défie la catégorisation et qui plaît aux gens de tous âges.",
    trailer: "https://www.youtube.com/watch?v=YLluFt0G88w",
    artists: ["Blue Man Group Performers"],
    category: Category.find_by(name: "Cinema")
  },
    "La Famille Bélier" => {
    title: "La Famille Bélier",
    description: "Dans cette comédie dramatique touchante, Paula, une adolescente de 16 ans, est l'interprète indispensable à ses parents sourds au quotidien, surtout pour l'exploitation de la ferme familiale. Un jour, encouragée par son professeur de musique qui lui a découvert un don pour le chant, elle décide de préparer le concours de Radio France. Un choix de vie qui signifierait pour elle l'éloignement de sa famille et un passage inévitable à l'âge adulte.",
    trailer: "https://www.youtube.com/watch?v=5ZNG3j4TGzk",
    artists: ["Louane Emera", "Karin Viard", "François Damiens"],
    category: Category.find_by(name: "Cinema")
  },
  "Avatar" => {
    title: "Avatar",
    description: "Sur la luxuriante planète alien de Pandora vivent les Na'vi, des êtres qui semblent primitifs mais sont hautement évolués. L'environnement de la planète étant toxique, des hybrides humains/Na'vi, appelés Avatars, doivent se lier aux esprits humains pour permettre un mouvement libre sur Pandora.",
    trailer: "https://www.youtube.com/watch?v=5PSNL1qE6VY",
    artists: ["Sam Worthington", "Zoe Saldana", "Sigourney Weaver"],
    category: Category.find_by(name: "Cinema")
  },
  "E.T. l'extra-terrestre" => {
    title: "E.T. l'extra-terrestre",
    description: "Un enfant en difficulté trouve le courage d'aider un alien sympathique à s'échapper de la Terre et à retourner dans son monde natal.",
    trailer: "https://www.youtube.com/watch?v=qYAETtIIClk",
    artists: ["Henry Thomas", "Drew Barrymore", "Peter Coyote"],
    category: Category.find_by(name: "Cinema")
  },
  "Casablanca" => {
    title: "Casablanca",
    description: "Se déroulant pendant la Seconde Guerre mondiale, il se concentre sur un expatrié américain qui doit choisir entre son amour pour une femme et l'aider, elle et son mari, un leader de la Résistance tchèque, à s'échapper de la ville de Casablanca contrôlée par Vichy pour continuer sa lutte contre les nazis.",
    trailer: "https://www.youtube.com/watch?v=BkL9l7qovsE",
    artists: ["Humphrey Bogart", "Ingrid Bergman", "Paul Henreid"],
    category: Category.find_by(name: "Cinema")
  },
  "Retour vers le futur" => {
    title: "Retour vers le futur",
    description: "Un jeune homme est accidentellement envoyé trente ans dans le passé dans une DeLorean capable de voyager dans le temps, inventée par son ami, le Dr Emmett Brown, et doit s'assurer que ses parents, alors adolescents, se réunissent afin de sauvegarder sa propre existence.",
    trailer: "https://www.youtube.com/watch?v=qvsgGtivCgs",
    artists: ["Michael J. Fox", "Christopher Lloyd", "Lea Thompson"],
    category: Category.find_by(name: "Cinema")
  },
  "Le Seigneur des Anneaux : La Communauté de l'Anneau" => {
    title: "Le Seigneur des Anneaux : La Communauté de l'Anneau",
    description: "Un jeune hobbit, Frodon, est poussé dans une quête épique pour détruire l'Anneau Unique, créé par le Seigneur des Ténèbres Sauron pour conquérir les terres de la Terre du Milieu.",
    trailer: "https://www.youtube.com/watch?v=V75dMMIW2B4",
    artists: ["Elijah Wood", "Ian McKellen", "Viggo Mortensen", "Sean Astin"],
    category: Category.find_by(name: "Cinema")
  },
  "Les Dents de la mer" => {
    title: "Les Dents de la mer",
    description: "Un grand requin blanc mangeur d'hommes attaque les baigneurs sur Amity Island, poussant le chef de la police locale à le chasser avec l'aide d'un biologiste marin et d'un chasseur de requins professionnel.",
    trailer: "https://www.youtube.com/watch?v=U1fu_sA7XhE",
    artists: ["Roy Scheider", "Robert Shaw", "Richard Dreyfuss"],
    category: Category.find_by(name: "Cinema")
  },
  "Gladiator" => {
    title: "Gladiator",
    description: "Un ancien général romain se lance dans une quête de vengeance contre l'empereur corrompu qui a assassiné sa famille et l'a envoyé en esclavage.",
    trailer: "https://www.youtube.com/watch?v=owK1qxDselE",
    artists: ["Russell Crowe", "Joaquin Phoenix", "Connie Nielsen"],
    category: Category.find_by(name: "Cinema")
  },
  "Il faut sauver le soldat Ryan" => {
    title: "Il faut sauver le soldat Ryan",
    description: "Après le débarquement en Normandie, un groupe de soldats américains passe derrière les lignes ennemies pour récupérer un parachutiste dont les frères ont été tués au combat.",
    trailer: "https://www.youtube.com/watch?v=zwhP5b4tD6g",
    artists: ["Tom Hanks", "Matt Damon", "Tom Sizemore"],
    category: Category.find_by(name: "Cinema")
  },
  "Le Silence des agneaux" => {
    title: "Le Silence des agneaux",
    description: "Une jeune recrue du FBI doit solliciter l'aide d'un tueur en série cannibale incarcéré et manipulateur pour attraper un autre tueur en série, un fou qui écorche ses victimes.",
    trailer: "https://www.youtube.com/watch?v=W6Mm8Sbe__o",
    artists: ["Jodie Foster", "Anthony Hopkins", "Scott Glenn"],
    category: Category.find_by(name: "Cinema")
  },
  "Toy Story" => {
    title: "Toy Story",
    description: "Une poupée de cowboy se sent profondément menacée et jalouse lorsqu'une nouvelle figurine d'astronaute le supplante comme jouet préféré dans la chambre d'un garçon.",
    trailer: "https://www.youtube.com/watch?v=KYz2wyBy3kc",
    artists: ["Tom Hanks", "Tim Allen"],
    category: Category.find_by(name: "Cinema")
  },
  "Psychose" => {
    title: "Psychose",
    description: "Une secrétaire de Phoenix détourne quarante mille dollars de son employeur, prend la fuite et s'enregistre dans un motel isolé tenu par un jeune homme sous la domination de sa mère.",
    trailer: "https://www.youtube.com/watch?v=DTJQfFQ40lI",
    artists: ["Anthony Perkins", "Janet Leigh", "Vera Miles"],
    category: Category.find_by(name: "Cinema")
  },





  # Spectacle

  "Cirque du Soleil: Alegria" => {
      title: "Cirque du Soleil: Alegria",
      description: "Un classique intemporel du Cirque du Soleil, 'Alegria' plonge le public dans un univers de fantaisie et de performance époustouflante, mêlant acrobaties, musique et danse dans un spectacle magique.",
      trailer: "https://www.youtube.com/watch?v=OZflc7tx8_E",
      artists: ["Guy Laliberté", "Franco Dragone"],
       category: Category.find_by(name: "Spectacle")
    },
    "Notre-Dame de Paris" => {
      title: "Notre-Dame de Paris",
      description: "Basé sur le roman de Victor Hugo, ce spectacle musical raconte l'histoire tragique de Quasimodo et Esmeralda à Paris au 15ème siècle. Une production épique alliant puissance vocale, chorégraphie impressionnante et décors somptueux.",
      trailer: "https://www.youtube.com/watch?v=YPZtRmx1Dyk",
      artists: ["Hélène Ségara", "Garou", "Daniel Lavoie"],
       category: Category.find_by(name: "Spectacle")
    },
    "Le Roi Lion - Comédie Musicale" => {
      title: "Le Roi Lion - Comédie Musicale",
      description: "Adaptation sur scène du célèbre cinema_film d'animation de Disney, 'Le Roi Lion' est une comédie musicale qui transporte les spectateurs dans la savane africaine avec des costumes spectaculaires, des décors innovants et une musique envoûtante.",
      trailer: "https://www.youtube.com/watch?v=7TavVZMewpY",
      artists: ["Elton John", "Tim Rice"],
       category: Category.find_by(name: "Spectacle")
    },
    "Les Misérables - Comédie Musicale" => {
      title: "Les Misérables - Comédie Musicale",
      description: "Cette adaptation du roman classique de Victor Hugo est une des comédies musicales les plus célèbres au monde, racontant les luttes et les rêves de Jean Valjean dans la France post-révolutionnaire.",
      trailer: "https://www.youtube.com/watch?v=IddP8AAIGTQ",
      artists: ["Claude-Michel Schönberg", "Alain Boublil", "Jean-Marc Natel", "Herbert Kretzmer"],
       category: Category.find_by(name: "Spectacle")
    },
    "Ballet de l'Opéra National de Paris: Lac des Cygnes" => {
      title: "Ballet de l'Opéra National de Paris: Lac des Cygnes",
      description: "Le 'Lac des Cygnes', interprété par le Ballet de l'Opéra National de Paris, est un chef-d'œuvre intemporel qui captive le public avec sa musique de Tchaïkovski et sa danse classique émouvante.",
      trailer: "https://www.youtube.com/watch?v=9rJoB7y6Ncs",
      artists: ["Pyotr Ilyich Tchaikovsky"],
       category: Category.find_by(name: "Spectacle")
    },
    "Holiday on Ice" => {
      title: "Holiday on Ice",
      description: "Un spectacle sur glace époustouflant qui combine patinage artistique de haut niveau, costumes éblouissants et décors magiques pour créer une expérience inoubliable pour toute la famille.",
      trailer: "https://www.youtube.com/watch?v=xezqM57Vm3s",
      artists: ["Robin Cousins"],
       category: Category.find_by(name: "Spectacle")
    },
    "Mamma Mia! - Comédie Musicale" => {
      title: "Mamma Mia! - Comédie Musicale",
      description: "Basée sur les chansons d'ABBA, cette comédie musicale joyeuse raconte l'histoire d'un mariage sur une île grecque, un secret familial et la recherche de l'identité, le tout enveloppé dans les hits intemporels d'ABBA.",
      trailer: "https://www.youtube.com/watch?v=unfzfe8f9NI",
      artists: ["Benny Andersson", "Björn Ulvaeus", "Stig Anderson"],
       category: Category.find_by(name: "Spectacle")
    },
    "Phantom of the Opera à Broadway" => {
      title: "Phantom of the Opera à Broadway",
      description: "Le 'Fantôme de l'Opéra' à Broadway est la production emblématique du célèbre roman, mettant en scène l'histoire d'amour tragique entre un compositeur défiguré et une jeune soprano dans l'Opéra de Paris.",
      trailer: "https://www.youtube.com/watch?v=44w6elsJr_I",
      artists: ["Andrew Lloyd Webber", "Charles Hart"],
       category: Category.find_by(name: "Spectacle")
    },
    "Grease - Comédie Musicale" => {
      title: "Grease - Comédie Musicale",
      description: "L'histoire d'amour emblématique entre Danny Zuko et Sandy Olsson, sur fond de rock'n'roll des années 50. 'Grease' est une célébration de la jeunesse, de l'amour et des voitures, avec des numéros musicaux qui ont traversé les générations.",
      trailer: "https://www.youtube.com/watch?v=wzWmxjYNfz4",
      artists: ["Jim Jacobs", "Warren Casey"],
       category: Category.find_by(name: "Spectacle")
    },
    "Billy Elliot - Le Musical" => {
      title: "Billy Elliot - Le Musical",
      description: "Dans une ville minière anglaise, un jeune garçon découvre sa passion pour la danse classique, contre les souhaits de son père. 'Billy Elliot' est une histoire inspirante de lutte et de triomphe, avec une musique émouvante d'Elton John.",
      trailer: "https://www.youtube.com/watch?v=JoiVEyCosEE",
      artists: ["Elton John", "Lee Hall"],
       category: Category.find_by(name: "Spectacle")
    },
    "Chicago - Le Musical" => {
      title: "Chicago - Le Musical",
      description: "Ambition, trahison, meurtre et jazz. 'Chicago' raconte l'histoire de Roxie Hart et Velma Kelly, deux meurtrières dans le Chicago des années 1920, qui deviennent des célébrités dans leur quête de liberté.",
      trailer: "https://www.youtube.com/watch?v=8IxcfbldgBY",
      artists: ["John Kander", "Fred Ebb"],
       category: Category.find_by(name: "Spectacle")
    },
    "Cats - Comédie Musicale" => {
      title: "Cats - Comédie Musicale",
      description: "Un spectacle magique qui transporte le public dans un monde mystique peuplé de chats. Avec sa musique envoûtante d'Andrew Lloyd Webber, 'Cats' est un spectacle visuellement spectaculaire et une prouesse chorégraphique.",
      trailer: "https://www.youtube.com/watch?v=FtSd844cI7U",
      artists: ["Andrew Lloyd Webber", "T.S. Eliot"],
       category: Category.find_by(name: "Spectacle")
    },
    "West Side Story - Comédie Musicale" => {
      title: "West Side Story - Comédie Musicale",
      description: "Une adaptation moderne de 'Roméo et Juliette'. 'West Side Story' est l'histoire d'un amour impossible entre Tony et Maria, sur fond de rivalités entre gangs dans le New York des années 50.",
      trailer: "https://www.youtube.com/watch?v=yA_aFprGzyc",
      artists: ["Leonard Bernstein", "Stephen Sondheim"],
       category: Category.find_by(name: "Spectacle")
    },
    "Le Cirque Invisible" => {
      title: "Le Cirque Invisible",
      description: "Jean-Baptiste Thierrée et Victoria Chaplin vous invitent dans leur monde féerique où le cirque se mêle à la magie. 'Le Cirque Invisible' est une expérience unique, un spectacle où l'imagination n'a pas de limites.",
      trailer: "https://www.youtube.com/watch?v=KVJn2lJ6aAk",
      artists: ["Jean-Baptiste Thierrée", "Victoria Chaplin"],
       category: Category.find_by(name: "Spectacle")
    },
    "Stomp" => {
      title: "Stomp",
      description: "Un spectacle rythmique explosif qui utilise des objets du quotidien pour créer un univers sonore incroyable. 'Stomp' est une expérience percussive à couper le souffle, mêlant musique, danse et performance théâtrale.",
      trailer: "https://www.youtube.com/watch?v=tZ7aYQtIldg",
      artists: ["Luke Cresswell", "Steve McNicholas"],
       category: Category.find_by(name: "Spectacle")
    },
    "Le Bourgeois Gentilhomme" => {
      title: "Le Bourgeois Gentilhomme",
      description: "La comédie-ballet de Molière et Lully revient à la vie dans cette production éclatante, racontant l'histoire de Monsieur Jourdain, un bourgeois qui aspire à devenir gentilhomme.",
      trailer: "https://www.youtube.com/watch?v=2JgOvn2N9bI",
      artists: ["Molière", "Jean-Baptiste Lully"],
       category: Category.find_by(name: "Spectacle")
    },
    "Fuerza Bruta" => {
      title: "Fuerza Bruta",
      description: "Un spectacle avant-gardiste qui brise la barrière entre le public et les performeurs. 'Fuerza Bruta' est une expérience immersive où la musique, la danse et les acrobaties se rencontrent dans un espace où tout est possible.",
      trailer: "https://www.youtube.com/watch?v=IbFhj4M9lu4",
      artists: ["Diqui James"],
       category: Category.find_by(name: "Spectacle")
    },
    "Swan Lake - Ballet" => {
      title: "Swan Lake - Ballet",
      description: "Le célèbre ballet de Tchaïkovski, 'Le Lac des Cygnes', est un conte de fées qui raconte l'histoire d'amour tragique entre le prince Siegfried et la princesse Odette, maudite à vivre comme un cygne le jour.",
      trailer: "https://www.youtube.com/watch?v=9rJoB7y6Ncs",
      artists: ["Pyotr Ilyich Tchaikovsky"],
       category: Category.find_by(name: "Spectacle")
    },
    "KÀ by Cirque du Soleil" => {
      title: "KÀ by Cirque du Soleil",
      description: "Une aventure épique qui unit acrobaties, arts martiaux, marionnettes et multimédia pour raconter l'histoire d'un voyage héroïque. 'KÀ' est une expérience visuelle à couper le souffle, exclusive au MGM Grand Las Vegas.",
      trailer: "https://www.youtube.com/watch?v=SEVU-YLpM8A",
      artists: ["Guy Laliberté", "Robert Lepage"],
       category: Category.find_by(name: "Spectacle")
    },
    "Sleep No More" => {
      title: "Sleep No More",
      description: "Une expérience théâtrale immersive inspirée de 'Macbeth' de Shakespeare. 'Sleep No More' est une représentation unique où le public se déplace librement à travers un espace théâtral gothique, devenant ainsi partie intégrante de la narration.",
      trailer: "https://www.youtube.com/watch?v=C2pH2VbOcFg",
      artists: ["Felix Barrett", "Maxine Doyle"],
       category: Category.find_by(name: "Spectacle")
    },

    # Litterature

    "Gatsby le Magnifique" => {
      title: "Gatsby le Magnifique",
      description: "L'histoire de Jay Gatsby, un millionnaire mystérieux qui poursuit passionnément la belle Daisy Buchanan, reflétant les illusions du rêve américain et la haute société des années 1920.",
      trailer: "https://www.youtube.com/watch?v=rARN6agiW7o",
      artists: ["F. Scott Fitzgerald" ],
      category: Category.find_by(name: "Litterature")
    },
    "Ne tirez pas sur l'oiseau moqueur" => {
      title: "Ne tirez pas sur l'oiseau moqueur",
      description: "Dans le sud ségrégationniste des États-Unis, Atticus Finch, un avocat intègre, défend un homme noir accusé à tort de viol, enseignant à ses enfants des leçons précieuses sur la justice et l'empathie.",
      trailer: "https://www.youtube.com/watch?v=KR7loA_oziY",
      artists: ["Harper Lee"],
      category: Category.find_by(name: "Litterature")
    },
    "Orgueil et Préjugés" => {
      title: "Orgueil et Préjugés",
      description: "L'histoire d'Elizabeth Bennet et de M. Darcy, deux personnes très différentes qui surmontent les malentendus et les différences de classe sociale pour découvrir l'amour véritable dans l'Angleterre du 19e siècle.",
      trailer: "https://www.youtube.com/watch?v=fJA27Jujzq4",
      artists: ["Jane Austen"],
      category: Category.find_by(name: "Litterature")
    },
    "Harry Potter à l'école des sorciers" => {
      title: "Harry Potter à l'école des sorciers",
      description: "Harry Potter découvre qu'il est le fils de deux sorciers puissants et qu'il possède des pouvoirs magiques uniques. À l'école de sorcellerie de Poudlard, il trouve l'amitié et le courage face au sorcier maléfique Voldemort.",
      trailer: "https://www.youtube.com/watch?v=VyHV0BRtdxo",
      artists: ["J.K. Rowling"],
      category: Category.find_by(name: "Litterature")
    },
    "Le Seigneur des Anneaux: La Communauté de l'Anneau" => {
      title: "Le Seigneur des Anneaux: La Communauté de l'Anneau",
      description: "Frodon Sacquet, un jeune hobbit, hérite d'un anneau magique aux pouvoirs immenses. Avec l'aide de ses amis, il doit entreprendre un voyage périlleux pour détruire l'anneau et empêcher le mal de s'emparer du monde.",
      trailer: "https://www.youtube.com/watch?v=V75dMMIW2B4",
      artists: ["J.R.R. Tolkien"],
      category: Category.find_by(name: "Litterature")
    },
    "Les Jeux de la Faim" => {
      title: "Les Jeux de la Faim",
      description: "Dans un futur dystopique, Katniss Everdeen se porte volontaire pour remplacer sa sœur dans les Hunger Games, une compétition télévisée où les participants doivent se battre à mort. Son courage changera le destin de la nation.",
      trailer: "https://www.youtube.com/watch?v=mfmrPu43DF8",
      artists: ["Suzanne Collins"],
      category: Category.find_by(name: "Litterature")
    },
    "Autant en emporte le vent" => {
      title: "Autant en emporte le vent",
      description: "L'histoire épique de Scarlett O'Hara et de Rhett Butler pendant la guerre civile américaine et la reconstruction, explorant l'amour, la guerre, la passion et la perte dans le sud des États-Unis.",
      trailer: "https://www.youtube.com/watch?v=0X94oZgJis4",
      artists: ["Margaret Mitchell"],
      category: Category.find_by(name: "Litterature")
    },
    "Les Évadés" => {
      title: "Les Évadés",
      description: "Basé sur la nouvelle de Stephen King, ce film suit l'histoire d'Andy Dufresne, un banquier injustement condamné à la prison à vie, qui trouve l'espoir et l'humanité dans les murs sombres de Shawshank.",
      trailer: "https://www.youtube.com/watch?v=6hB3S9bIaco",
      artists: ["Stephen King"],
      category: Category.find_by(name: "Litterature")
    },
    "Jurassic Park" => {
      title: "Jurassic Park",
      description: "Adapté du roman de Michael Crichton, Jurassic Park est une aventure palpitante sur une île où des dinosaures génétiquement recréés s'échappent, mettant en péril la vie des visiteurs du parc.",
      trailer: "https://www.youtube.com/watch?v=QWBKEmWWL38",
      artists: ["Michael Crichton"],
      category: Category.find_by(name: "Litterature")
    },
    "Fight Club" => {
      title: "Fight Club",
      description: "Un homme insatisfait de sa vie consumériste forme un club de combat souterrain avec Tyler Durden, un vendeur de savon charismatique, plongeant dans une spirale de violence. Le film est une critique acerbe de la société moderne.",
      trailer: "https://www.youtube.com/watch?v=qtRKdVHc-cE",
      artists: ["Chuck Palahniuk"],
      category: Category.find_by(name: "Litterature")
    },
    "Les Misérables" => {
      title: "Les Misérables",
      description: "L'adaptation cinématographique du roman de Victor Hugo et de la comédie musicale, racontant l'histoire de Jean Valjean, un ex-convict cherchant la rédemption dans la France post-révolutionnaire, tout en étant poursuivi par l'inspecteur Javert.",
      trailer: "https://www.youtube.com/watch?v=IuEFm84s4oI",
      artists: ["Victor Hugo"],
      category: Category.find_by(name: "Litterature")
    },
    "L'Odyssée de Pi" => {
      title: "L'Odyssée de Pi",
      description: "Après un naufrage, Pi Patel se retrouve sur un canot de sauvetage avec un tigre du Bengale. Au cours de leur voyage extraordinaire, Pi découvre la force de la volonté et le pouvoir de l'histoire.",
      trailer: "https://www.youtube.com/watch?v=j9Hjrs6WQ8M",
      artists: ["Yann Martel"],
      category: Category.find_by(name: "Litterature")
    },
    "Le Parrain" => {
      title: "Le Parrain",
      description: "Le patriarche vieillissant d'une dynastie du crime organisé transfère le contrôle de son empire clandestin à son fils réticent. Adapté du roman de Mario Puzo, ce film est une saga épique sur la famille, le pouvoir et la loyauté.",
      trailer: "https://www.youtube.com/watch?v=sY1S34973zA",
      artists: ["Mario Puzo"],
      category: Category.find_by(name: "Litterature")
    },
    "La Liste de Schindler" => {
      title: "La Liste de Schindler",
      description: "L'histoire vraie d'Oskar Schindler, un industriel allemand qui a sauvé la vie de plus de mille Juifs polonais pendant l'Holocauste en les employant dans ses usines.",
      trailer: "https://www.youtube.com/watch?v=gG22XNhtnoY",
      artists: ["Thomas Keneally"],
      category: Category.find_by(name: "Litterature")
    },
    "Forrest Gump" => {
      title: "Forrest Gump",
      description: "Forrest Gump, un homme aux capacités mentales limitées, mais au cœur pur, traverse des moments historiques des États-Unis au 20e siècle, influençant la vie de ceux qu'il rencontre grâce à sa naïveté désarmante.",
      trailer: "https://www.youtube.com/watch?v=bLvqoHBptjg",
      artists: ["Winston Groom"],
      category: Category.find_by(name: "Litterature")
    },
    "Le Silence des Agneaux" => {
      title: "Le Silence des Agneaux",
      description: "Clarice Starling, une jeune agente du FBI, doit solliciter l'aide d'Hannibal Lecter, un psychiatre emprisonné et cannibale, pour attraper un autre tueur en série. Une plongée terrifiante dans l'esprit de la folie.",
      trailer: "https://www.youtube.com/watch?v=W6Mm8Sbe__o",
      artists: ["Thomas Harris"],
      category: Category.find_by(name: "Litterature")
    },
    "Da Vinci Code" => {
      title: "Da Vinci Code",
      description: "Robert Langdon, symbologiste, est entraîné dans une chasse au trésor à travers des monuments historiques, sur la piste d'un secret qui pourrait remettre en question les fondements du christianisme.",
      trailer: "https://www.youtube.com/watch?v=zMba3fckhuQ",
      artists: ["Dan Brown"],
      category: Category.find_by(name: "Litterature")
    },
    "Le Labyrinthe" => {
      title: "Le Labyrinthe",
      description: "Des adolescents sont piégés dans un labyrinthe géant et doivent s'associer pour trouver une issue. Basé sur le roman de James Dashner, c'est une histoire de survie, de leadership et de courage face à l'inconnu.",
      trailer: "https://www.youtube.com/watch?v=AwwbhhjQ9Xk",
      artists: ["James Dashner"],
      category: Category.find_by(name: "Litterature")
    },
    "Divergente" => {
      title: "Divergente",
      description: "Dans une société dystopique divisée en cinq factions basées sur les vertus humaines, Tris Prior découvre qu'elle est Divergente et ne rentre dans aucune faction, la mettant en danger de mort.",
      trailer: "https://www.youtube.com/watch?v=sutgWjz10sM",
      artists: ["Veronica Roth"],
      category: Category.find_by(name: "Litterature")
    },

    # Exposition

  "Van Gogh : Peint avec des Mots" => {
    title: "Van Gogh : Peint avec des Mots",
    description: "Un voyage cinématographique dans la vie de Vincent Van Gogh, raconté à travers ses lettres à son frère Théo, révélant l'homme derrière les toiles emblématiques.",
    trailer: "https://www.youtube.com/watch?v=6a8Eimr-fm0",
    artists: ["Vincent Van Gogh"],
    category: Category.find_by(name: "Exposition")
  },
  "Frida" => {
    title: "Frida",
    description: "La vie passionnée de Frida Kahlo, peinte à travers son art, son amour tumultueux avec Diego Rivera et sa lutte personnelle, dans un portrait vibrant de l'artiste.",
    trailer: "https://www.youtube.com/watch?v=uOUzQYqba4Y",
    artists: ["Frida Kahlo"],
    category: Category.find_by(name: "Exposition")
  },
  "Les Impressionnistes" => {
    title: "Les Impressionnistes",
    description: "L'histoire des pionniers de l'art moderne, les Impressionnistes, et comment ils ont révolutionné la peinture, présentée à travers une série documentaire captivante.",
    trailer: "https://www.youtube.com/watch?v=5ZAxZQ0_-mk",
    artists: ["Claude Monet", "Edgar Degas", "Camille Pissarro", "Pierre-Auguste Renoir"],
    category: Category.find_by(name: "Exposition")
  },
  "Léonard de Vinci : L'Œuvre" => {
    title: "Léonard de Vinci : L'Œuvre",
    description: "Une exploration cinématographique des œuvres de Léonard de Vinci, offrant un regard intime sur les peintures et dessins du maître de la Renaissance.",
    trailer: "https://www.youtube.com/watch?v=v7uRFVR9BPU",
    artists: ["Leonardo da Vinci"],
    category: Category.find_by(name: "Exposition")
  },
  "La Jeune Fille à la Perle" => {
    title: "La Jeune Fille à la Perle",
    description: "Inspiré par le mystérieux tableau de Vermeer, ce film explore l'histoire derrière la création de l'une des œuvres d'art les plus célèbres au monde.",
    trailer: "https://www.youtube.com/watch?v=IERZr6Lcuyo",
    artists: ["Johannes Vermeer"],
    category: Category.find_by(name: "Exposition")
  },
  "Aimer Vincent" => {
    title: "Aimer Vincent",
    description: "Le premier long métrage peint à la main au monde, qui explore la vie et les œuvres controversées de Vincent Van Gogh à travers les yeux des personnes qui l'ont connu.",
    trailer: "https://www.youtube.com/watch?v=CGzKnyhYDQI",
    artists: ["Vincent Van Gogh"],
    category: Category.find_by(name: "Exposition")
  },
  "Klimt & Schiele : Eros et Psyché" => {
    title: "Klimt & Schiele : Eros et Psyché",
    description: "Revisitant l'époque érotique et psychologique de Vienne de 1900 à travers les œuvres de Gustav Klimt et Egon Schiele dans une exposition captivante.",
    trailer: "https://www.youtube.com/watch?v=BrVnc0xwvZ4",
    artists: ["Gustav Klimt", "Egon Schiele"],
    category: Category.find_by(name: "Exposition")
  },
  "Basquiat : La Rage de la Richesse" => {
    title: "Basquiat : La Rage de la Richesse",
    description: "Une plongée profonde dans la vie de Jean-Michel Basquiat, suivant son ascension fulgurante dans le monde de l'art new-yorkais des années 80 et son héritage durable.",
    trailer: "https://www.youtube.com/watch?v=3Ms1RQxB5F8",
    artists: ["Jean-Michel Basquiat"],
    category: Category.find_by(name: "Exposition")
  },
  "Munch 150" => {
    title: "Munch 150",
    description: "Célébrant le 150e anniversaire de la naissance d'Edvard Munch, cette exposition rassemble le plus grand nombre d'œuvres de Munch jamais présentées.",
    trailer: "https://www.youtube.com/watch?v=frSED6XBRzE",
    artists: ["Edvard Munch"],
    category: Category.find_by(name: "Exposition")
  },
  "Le Jardin de l'Artiste : L'Impressionnisme Américain" => {
    title: "Le Jardin de l'Artiste : L'Impressionnisme Américain",
    description: "Explorant l'Impressionnisme Américain à travers l'objectif des jardins d'artistes, ce documentaire offre un aperçu de l'intersection de l'art, du jardinage et de l'histoire sociale.",
    trailer: "https://www.youtube.com/watch?v=Ys7mP68_Mds",
    artists: ["Various American Impressionist Artists"],
    category: Category.find_by(name: "Exposition")
  },
  "Les Nymphéas de Monet : La Magie de l'Eau et de la Lumière" => {
    title: "Les Nymphéas de Monet : La Magie de l'Eau et de la Lumière",
    description: "Découvrez comment les Nymphéas de Monet ont révolutionné l'art moderne, à travers une exploration de son œuvre ultime au sein de l'Orangerie Museum à Paris.",
    trailer: "https://www.youtube.com/watch?v=7Zn95OF_D3M",
    artists: ["Claude Monet"],
    category: Category.find_by(name: "Exposition")
  },
  "Picasso : Amour, Sexe et Art" => {
    title: "Picasso : Amour, Sexe et Art",
    description: "Un regard sur la vie de Pablo Picasso, avec un accent particulier sur ses muses, ses amours et son impact sur l'art du 20e siècle.",
    trailer: "https://www.youtube.com/watch?v=3GmJ11G5bP4",
    artists: ["Pablo Picasso"],
    category: Category.find_by(name: "Exposition")
  },
  "Gauguin : Voyage à Tahiti" => {
    title: "Gauguin : Voyage à Tahiti",
    description: "Suivez Paul Gauguin dans son voyage à Tahiti, une quête de liberté, d'évasion et d'inspiration loin de la civilisation occidentale.",
    trailer: "https://www.youtube.com/watch?v=9MrnAJsxL8c",
    artists: ["Paul Gauguin"],
    category: Category.find_by(name: "Exposition")
  },
  "Degas : Passion pour la Perfection" => {
    title: "Degas : Passion pour la Perfection",
    description: "À travers une série d'expositions et de collections privées, découvrez la quête de la perfection d'Edgar Degas et son impact sur l'art moderne.",
    trailer: "https://www.youtube.com/watch?v=ZjgBQ2tDufI",
    artists: ["Edgar Degas"],
    category: Category.find_by(name: "Exposition")
  },
  "Michel-Ange : Amour et Mort" => {
    title: "Michel-Ange : Amour et Mort",
    description: "Une exploration de la vie et des œuvres de Michel-Ange, révélant les luttes et les succès de l'un des plus grands artistes de la Renaissance.",
    trailer: "https://www.youtube.com/watch?v=0FG6NXFkF3k",
    artists: ["Michelangelo Buonarroti"],
    category: Category.find_by(name: "Exposition")
  },
  "Raphaël : Le Seigneur des Arts" => {
    title: "Raphaël : Le Seigneur des Arts",
    description: "Plongez dans la vie de Raphaël, un génie de la Renaissance, dont les œuvres continuent d'influencer l'art mondial des siècles après sa mort.",
    trailer: "https://www.youtube.com/watch?v=9vHFsXOdTt0",
    artists: ["Raphael Sanzio"],
    category: Category.find_by(name: "Exposition")
  },
  "Turner : Peintures de Lumière" => {
    title: "Turner : Peintures de Lumière",
    description: "L'histoire de J.M.W. Turner, dont les peintures révolutionnaires ont capturé la beauté transitoire de la lumière et annoncé l'ère de l'impressionnisme.",
    trailer: "https://www.youtube.com/watch?v=Tn4zSR_5ioI",
    artists: ["J.M.W. Turner"],
    category: Category.find_by(name: "Exposition")
  },
  "Vermeer : L'Âge d'Or de l'Art Hollandais" => {
    title: "Vermeer : L'Âge d'Or de l'Art Hollandais",
    description: "Découvrez Johannes Vermeer, le maître de la lumière, dont les peintures intimes et détaillées offrent un aperçu fascinant de la vie quotidienne au 17e siècle.",
    trailer: "https://www.youtube.com/watch?v=FTtW0Jq9f5I",
    artists: ["Johannes Vermeer"],
    category: Category.find_by(name: "Exposition")
  },
  "Le Monde de Banksy" => {
    title: "Le Monde de Banksy",
    description: "Une immersion dans l'univers mystérieux de Banksy, l'artiste de rue le plus célèbre au monde, connu pour ses œuvres provocatrices et politiquement engagées.",
    trailer: "https://www.youtube.com/watch?v=9R5VwxvUUvI",
    artists: ["Banksy"],
    category: Category.find_by(name: "Exposition")
  },
  "Warhol : L'Art du Pop" => {
    title: "Warhol : L'Art du Pop",
    description: "Un regard sur la vie et l'œuvre d'Andy Warhol, figure emblématique du Pop Art, dont l'approche novatrice a changé la perception de l'art.",
    trailer: "https://www.youtube.com/watch?v=U3YFgZj6zUw",
    artists: ["Andy Warhol"],
    category: Category.find_by(name: "Exposition")
  },
  "Kandinsky : Un Voyage vers l'Abstraction" => {
    title: "Kandinsky : Un Voyage vers l'Abstraction",
    description: "Explorez le voyage de Wassily Kandinsky vers l'abstraction, un mouvement qui a bouleversé l'art traditionnel et ouvert la voie à une nouvelle forme d'expression.",
    trailer: "https://www.youtube.com/watch?v=tiX_Af33vN8",
    artists: ["Wassily Kandinsky"],
    category: Category.find_by(name: "Exposition")
  },
  "Magritte : Ceci n'Est Pas une Pipe" => {
    title: "Magritte : Ceci n'Est Pas une Pipe",
    description: "Une exploration de l'œuvre de René Magritte, maître du surréalisme, dont les images trompeuses et les idées philosophiques ont défié la réalité.",
    trailer: "https://www.youtube.com/watch?v=h6lLQb6Z8Ho",
    artists: ["René Magritte"],
    category: Category.find_by(name: "Exposition")
  },
  "Hopper : Fenêtres sur la Solitude" => {
    title: "Hopper : Fenêtres sur la Solitude",
    description: "Edward Hopper, peintre de la solitude moderne, capture l'isolement et la mélancolie à travers ses représentations emblématiques de la vie américaine.",
    trailer: "https://www.youtube.com/watch?v=SpMzoBR2Szo",
    artists: ["Edward Hopper"],
    category: Category.find_by(name: "Exposition")
  },
  "L'Âge de Rembrandt" => {
    title: "L'Âge de Rembrandt",
    description: "Revivez l'âge d'or de la peinture hollandaise à travers l'œuvre de Rembrandt, dont les portraits et scènes bibliques révèlent une humanité profonde et une maîtrise de la lumière.",
    trailer: "https://www.youtube.com/watch?v=1pUWJGmN8ZU",
    artists: ["Rembrandt van Rijn"],
    category: Category.find_by(name: "Exposition")
  }
}

def dynamic_content_for_toi(category_id)
  category = Category.find(category_id)

  # For cinema
  cinema_film = ITEMS.keys.sample
  description = ITEMS[cinema_film][:description]
  trailer = ITEMS[cinema_film][:trailer]
  cinema_name = ITEMS[cinema_film][:artists]

  # For spectacle
  spectacle_film = ITEMS.keys.sample
  spectacle_description = ITEMS[spectacle_film][:description]
  spectacle_trailer = ITEMS[spectacle_film][:trailer]
  spectacle_name = ITEMS[spectacle_film][:artists]

  # For litterature
  litterature_book = ITEMS.keys.sample
  litterature_description = ITEMS[litterature_book][:description]
  litterature_trailer = ITEMS[litterature_book][:trailer]
  litterature_name = ITEMS[litterature_book][:artists]

  # For exposition
  exposition_book = ITEMS.keys.sample
  exposition_description = ITEMS[exposition_book][:description]
  exposition_trailer = ITEMS[exposition_book][:trailer]
  exposition_name = ITEMS[exposition_book][:artists]

  case category.name
  when "Cinema"
    {
      title: cinema_film,
      description: description,
      trailer: trailer,
      name: cinema_name
    }
  when "Spectacle"
    {
      title: spectacle_film,
      description: spectacle_description,
      trailer: spectacle_trailer,
      name: spectacle_name
    }
  when "Litterature"
    {
      title: litterature_book,
      description: litterature_description,
      trailer: litterature_trailer,
      name: litterature_name
    }
  when "Exposition"
    {
      title: exposition_book,
      description: exposition_description,
      trailer: exposition_trailer,
      name: exposition_name
    }
  else
    { title: "N/A", description: "N/A", trailer: "N/A" }
  end
end


puts "Creating Tois, please it will be longer, Estimated waiting #{ITEMS.length * 2 / 60} minutes..."





def normalize_string(s)
  # Mettre en minuscule
  s.downcase!
  # Supprimer les accents
  s = I18n.transliterate(s)
  # Supprimer les espaces, les points, et autres caractères spéciaux
  s.gsub!(/[\s.!&,\'-]/, '')
  s
end
compteur = 0

ITEMS.each do |name, infos|
  compteur += 1
  title_toi = infos[:title]
  formatted_string = normalize_string(title_toi)





  if compteur == 40
    puts "Still in progress: Estimated waiting #{40 * 2 / 60} minutes..."
  end

  toi = Toi.new(
    title: title_toi,
    category: infos[:category],
    location: Faker::Address.full_address,
    description: infos[:description],
    trailer: infos[:trailer]
    )


  cloudinary_image_url = "https://res.cloudinary.com/drrbvxo6s/image/upload/#{formatted_string}"

  file = URI.open(cloudinary_image_url)



  toi.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
  toi.save
  toi.title = name
  toi.save

  infos[:artists].each do |name|
    artist = Artist.create!(
      name: name
    )
    ToiArtist.create!(
      artist: artist,
      toi: toi
    )
  end
end

puts "#{Toi.count} tois created sucessfully!"

puts "Creating posts..."

critiques = {

  "Le Fantôme de l'Opéra" => [
    "Une performance spectaculaire qui captive dès le début.",
    "Un classique intemporel magnifiquement interprété.",
    "Une expérience théâtrale mémorable, bien que par moments prévisible."],

  "Hamilton" => [
    "Une révolution dans le monde de la comédie musicale, absolument incontournable.",
    "Hamilton mélange histoire et modernité avec brio.",
    "Une œuvre d'art qui redéfinit le genre musical, même si elle peut sembler longue."],


  "Cirque du Soleil : O" => [
    "Une immersion totale dans un monde aquatique féerique. 'O' repousse les limites de la performance live.",
     "Le Cirque du Soleil éblouit encore avec 'O', mêlant eau, feu, et acrobaties dans un spectacle inoubliable.",
     "Bien que visuellement époustouflant, 'O' peut par moments sembler répétitif. Néanmoins, une expérience à voir."],

  "Wicked" => [
    "Wicked offre une perspective rafraîchissante sur le monde d'Oz, avec des performances vocales qui donnent des frissons.",
    "Un conte de sorcières captivant, 'Wicked' séduit par son histoire profonde et ses décors somptueux.",
    "Malgré une mise en scène et des effets spéciaux impressionnants, 'Wicked' peut parfois manquer de rythme."],

  "Les Misérables" => [
    "Une adaptation bouleversante et puissante du classique de Victor Hugo. Les Misérables touche droit au cœur.",
    "Les voix, l'histoire, l'émotion brute - 'Les Misérables' est un tour de force théâtral.",
    "Si l'histoire est intemporelle, certaines longueurs peuvent freiner l'élan de cette production des 'Misérables'."],

  "Le Roi Lion" => [
    "Le Roi Lion sur scène est une prouesse technique et artistique, capturant toute la magie du film original.",
    "Avec des costumes et une mise en scène innovants, 'Le Roi Lion' est un spectacle familial par excellence.",
    "Bien que le spectacle soit visuellement spectaculaire, il peine parfois à capturer l'essence émotionnelle du film."],

  "Groupe Blue Man" => [
    "Un spectacle énergique et interactif qui brise les conventions. Le Groupe Blue Man est un incontournable.",
    "Innovant, drôle, et surprenant, le Groupe Blue Man offre une expérience unique en son genre.",
    "Bien que divertissant, le Groupe Blue Man peut ne pas plaire à tous, son approche étant parfois trop expérimentale."],

  "Le Livre de Mormon" => [
    "Hilarant, provocateur, et étonnamment touchant,
    'Le Livre de Mormon' est une réussite.",
    "Ce musical pousse les limites tout en offrant des numéros mémorables et des rires constants.",
     "Peut-être un peu trop osé pour certains, mais 'Le Livre de Mormon' est une critique intelligente sous couvert d'humour."],

  "Avatar" => [
    "Une immersion incroyable dans le monde de Pandora, où chaque détail est un spectacle visuel.",
    "Avatar sur scène apporte une dimension nouvelle à l'histoire, malgré quelques longueurs.",
    "Visuellement impressionnant, mais manque parfois de la profondeur émotionnelle du film."
  ],

  "E.T. l'extra-terrestre" => [
    "Une aventure qui réchauffe le cœur, rappelant l'importance de l'amitié et du courage.",
    "E.T. revient dans une adaptation touchante, bien que certains moments clés manquent d'impact sur scène.",
    "Captivant pour les enfants et nostalgique pour les adultes, même si l'adaptation perd un peu de magie."
  ],

  "Casablanca" => [
    "Un classique intemporel magnifiquement adapté au théâtre, capturant l'essence de l'amour et du sacrifice.",
    "Casablanca sur scène est une réussite, bien que l'alchimie entre les personnages principaux puisse parfois sembler forcée.",
    "Rend hommage au film, mais manque de surprises pour ceux qui connaissent déjà l'histoire par cœur."
  ],

  "Retour vers le futur" => [
    "Une machine à remonter le temps théâtrale qui apporte humour et nostalgie en abondance.",
    "Inventive et divertissante, cette adaptation joue habilement avec le temps, malgré quelques incohérences.",
    "Amusant, mais ne parvient pas à égaler l'originalité et le charme du film."
  ],

  "Le Seigneur des Anneaux : La Communauté de l'Anneau" => [
    "Une épopée fantastique qui prend vie de manière spectaculaire sur scène, avec des décors et des effets spéciaux époustouflants.",
    "Captivant et fidèle à l'œuvre de Tolkien, bien que la durée puisse tester la patience de certains.",
    "Une aventure immersive, mais qui peut parfois se sentir surchargée par sa propre ambition."
  ],

  "Les Dents de la mer" => [
    "Un thriller palpitant qui réussit à transmettre la tension et la terreur du film original.",
    "Les effets spéciaux sont impressionnants, mais le spectacle peut parfois manquer de profondeur narrative.",
    "Excitant et effrayant, bien que certains éléments semblent moins convaincants sur scène."
  ],

  "Gladiator" => [
    "Une histoire de vengeance épique qui transporte le public dans l'ancienne Rome avec une puissance dramatique inégalée.",
    "Spectaculaire et émouvant, Gladiator sur scène est une réussite, même si le rythme est inégal.",
    "Des performances fortes et une mise en scène grandiose, mais manque parfois de subtilité."
  ],

  "Il faut sauver le soldat Ryan" => [
    "Une représentation théâtrale poignante de la guerre, soulignant le courage et le sacrifice.",
    "Intense et émotionnellement chargé, bien que certaines scènes de combat puissent sembler moins réalistes sur scène.",
    "Captivant, rendant hommage aux héros de guerre, mais avec des moments qui peuvent sembler surjoués."
  ],

  "Les Aventuriers de l'Arche perdue" => [
    "Une aventure exaltante qui capture l'esprit du film avec action et humour.",
    "Dynamique et divertissante, cette adaptation fait revivre l'excitation de la chasse au trésor.",
    "Amusante, mais manque parfois de la profondeur et de la complexité du film original."
  ],

  "Le Silence des agneaux" => [
    "Un thriller psychologique saisissant qui explore les profondeurs de l'esprit humain.",
    "Intense et captivant, avec des performances qui glacent le sang, bien que l'adaptation puisse parfois diluer l'impact du récit.",
    "Terrifiant et fascinant, mais la transition du film au théâtre n'est pas sans défis."
  ],

  "La Liste de Schindler" => [
    "Une œuvre profondément émouvante qui rend hommage à l'histoire vraie d'un homme extraordinaire.",
    "Puissant et poignant, bien que la représentation de l'horreur puisse parfois sembler atténuée.",
    "Inspirant et éducatif, mais la gravité du sujet exige une mise en scène délicate."
  ],

  "Toy Story" => [
    "Une joyeuse aventure qui ravira les enfants et touchera les adultes, pleine de nostalgie et de rires.",
    "Créatif et coloré, Toy Story sur scène est un régal, même si certains gags perdent de leur effet en live.",
    "Amusant et sentimental, mais certains personnages et moments clés manquent de l'éclat du film."
  ],

  "Psychose" => [
    "Un classique du suspense magnifiquement adapté, qui garde le public en haleine jusqu'à la fin.",
    "Intrigant et bien exécuté, bien que la célèbre scène de la douche soit difficile à reproduire avec le même impact.",
    "Captivant, mais l'atmosphère unique d'Alfred Hitchcock est un défi à égaler sur scène."
  ],

  "Autant en emporte le vent" => [
    "Une saga épique d'amour et de perte, magnifiquement transposée sur scène, capturant l'essence du Sud américain.",
    "Emouvant et visuellement impressionnant, bien que la longueur du récit puisse peser sur le rythme.",
    "Romantique et tragique, mais certains aspects du récit semblent datés à l'ère moderne."

  ],

  "Van Gogh : Peint avec des Mots" => [
    "Une exploration émouvante et profondément personnelle de la vie de Van Gogh, à travers ses propres mots.",
    "Ce film offre un regard intime sur l'âme tourmentée de Van Gogh, enrichi par des visuels magnifiques.",
    "Bien que captivant, le format peut parfois sembler restrictif pour couvrir l'ampleur de sa vie complexe."
  ],

  "Frida" => [
    "Une représentation vibrante et colorée de la vie de Frida Kahlo, pleine de passion et de douleur.",
    "Le film capture brillamment l'esprit indomptable de Frida, mais peut parfois glisser dans le mélodrame.",
    "Salma Hayek incarne Frida Kahlo avec une intensité remarquable, apportant à la vie l'artiste iconique."
  ],

  "Les Impressionnistes" => [
    "Un voyage fascinant à travers le mouvement impressionniste, éclairant ses innovations artistiques.",
    "Le documentaire brille par ses insights mais manque parfois de contexte historique approfondi.",
    "Visuellement stupéfiant, il rend hommage aux œuvres mais peut laisser les amateurs d'art vouloir plus."
  ],

  "Léonard de Vinci : L'Œuvre" => [
    "Une plongée captivante dans le génie de Léonard de Vinci, révélant des détails fascinants de ses œuvres.",
    "Le film éclaire brillamment l'esprit de Da Vinci, bien que sa structure puisse parfois désorienter.",
    "Un hommage éducatif et inspirant à l'un des plus grands esprits de l'histoire, magnifiquement produit."
  ],

  "La Jeune Fille à la Perle" => [
    "Une interprétation visuellement époustouflante qui donne vie à l'énigmatique tableau de Vermeer.",
    "Le film brille par sa reconstitution historique et la performance subtile de Scarlett Johansson.",
    "Captivant et esthétiquement plaisant, mais certains pourraient trouver le rythme un peu lent."
  ],

  "Aimer Vincent" => [
    "Une prouesse technique et artistique, racontant la vie de Van Gogh de manière innovante.",
    "Chaque scène peinte à la main est un hommage vibrant à l'œuvre de Van Gogh, bien que le récit puisse parfois sembler décousu.",
    "Une expérience cinématographique unique, mêlant art et émotion de manière inoubliable."
  ],

  "Klimt & Schiele : Eros et Psyché" => [
    "Une exploration fascinante de deux figures centrales de la Sécession viennoise, riche en détails artistiques et historiques.",
    "Le documentaire offre un aperçu profond de leur art, mais peut parfois sembler trop académique pour un public non initié.",
    "Visuellement captivant, il met en lumière l'influence durable de Klimt et Schiele sur l'art moderne."
  ],

  "Basquiat : La Rage de la Richesse" => [
    "Un portrait cru et dynamique de Basquiat, capturant l'essence de sa créativité et de sa complexité.",
    "Le film navigue habilement entre son ascension fulgurante et sa chute tragique, bien que certains aspects de sa vie restent effleurés.",
    "Une célébration puissante de son génie, tout en exposant les défis qu'il a affrontés dans le monde de l'art."
  ],

 "Fuerza Bruta" =>[
  "Un tourbillon d'énergie et de créativité, 'Fuerza Bruta' brise les frontières entre le spectacle et le public.",
  "Une expérience sensorielle unique, où la musique, la lumière et le mouvement fusionnent pour créer un moment d'évasion pure.",
  "Malgré son intensité, certains pourraient trouver le spectacle déroutant, mais son audace est incontestablement captivante."
],

"Warhol : L'Art du Pop" => [
  "Une exploration fascinante de l'icône du Pop Art, révélant les multiples facettes de Warhol, de l'artiste à l'observateur social.",
  "Le documentaire brille par son accès à des œuvres rares et des interviews, offrant une perspective neuve sur l'impact de Warhol.",
  "Bien qu'il puisse parfois sembler superficiel dans son traitement de sujets complexes, il capture avec brio l'esprit de l'époque de Warhol."

], "Le Jardin de l'Artiste : L'Impressionnisme Américain" => [
  "Un voyage éblouissant à travers les jardins qui ont inspiré les maîtres de l'Impressionnisme américain.",
  "Le documentaire marie habilement l'art et la nature, bien que par moments il puisse sembler un peu didactique.",
  "Une célébration de la couleur et de la lumière, offrant une perspective fraîche sur des œuvres bien-aimées."
],

   "Kandinsky : Un Voyage vers l'Abstraction"=> [
  "Une plongée captivante dans l'évolution de Kandinsky vers l'abstraction, illuminant son génie artistique.",
  "Le documentaire navigue habilement à travers les phases créatives de Kandinsky, bien que certains puissent désirer plus de contexte historique.",
  "Visuellement époustouflant, il démontre comment Kandinsky a brisé les conventions pour explorer l'expression pure."
],

 "Degas : Passion pour la Perfection" => [
  "Une exploration fascinante de l'obsession de Degas pour maîtriser chaque détail, capturant l'essence de ses sujets avec une précision inégalée.",
  "Ce documentaire plonge profondément dans la quête incessante de perfection de Degas, révélant à la fois sa rigueur artistique et les défis personnels qu'il a dû surmonter.",
  "Inspirant et révélateur, bien qu'il puisse par moments sembler se perdre dans les détails techniques, laissant peu de place à l'émotion."
],

"Le Monde de Banksy" => [
  "Une immersion audacieuse dans l'univers provocateur de Banksy, où l'art rencontre l'activisme avec un impact visuel stupéfiant.",
  "Ce documentaire capture l'esprit rebelle de Banksy, explorant comment ses œuvres éphémères ont remis en question les conventions sociales et politiques.",
  "Fascinant et énigmatique, bien que certains spectateurs puissent désirer une exploration plus approfondie de l'identité secrète de l'artiste."
],

"Le Bourgeois Gentilhomme" => [
  "Une satire délicieuse qui se moque brillamment des prétentions du bourgeois aspirant à l'ascension sociale, avec l'esprit de Molière qui brille de mille feux.",
  "Cette production donne vie au génie comique de Molière, offrant un portrait vibrant du Monsieur Jourdain, à la fois ridicule et attachant.",
  "Divertissante et perspicace, bien que par moments, la moquerie élaborée de la pièce puisse sembler quelque peu répétitive pour les spectateurs modernes."
],

"Cats - Comédie Musicale" => [
  "Un spectacle enchanteur qui transporte les spectateurs dans un monde mystique peuplé de chats aux personnalités fascinantes.",
  "Avec des chorégraphies époustouflantes et des costumes innovants, 'Cats' réussit à captiver l'audience du début à la fin.",
  "Magique et immersif, bien que l'histoire puisse parfois sembler secondaire face à la splendeur visuelle et à la performance artistique."
],

"Ballet de l'Opéra National de Paris: Lac des Cygnes" => [
  "Une interprétation époustouflante du chef-d'œuvre de Tchaïkovski, alliant grâce, technique et émotion dans une performance inoubliable.",
  "Le Ballet de l'Opéra National de Paris donne vie à cette histoire d'amour tragique avec une précision et une beauté qui laissent sans voix.",
  "Magnifique et envoûtant, bien que la familiarité de l'œuvre puisse ne pas surprendre les aficionados du ballet, la qualité de l'exécution reste sans égale."
],

 "Notre-Dame de Paris" => [
  "Une adaptation scénique émouvante et puissante du roman classique de Victor Hugo, qui captive le public avec ses mélodies envoûtantes et ses performances passionnées.",
  "Cette comédie musicale transporte les spectateurs au cœur du Paris médiéval, avec une mise en scène spectaculaire et des décors qui recréent l'ambiance de l'époque de manière magistrale.",
  "Inoubliable et profondément touchante, bien que l'œuvre aborde des thèmes sombres, elle est illuminée par des moments de beauté et d'humanité qui éclairent la condition humaine."
],

"West Side Story - Comédie Musicale" => [
  "Une retranscription scénique électrisante de la tragédie shakespearienne, transposée dans le New York des années 50, qui brille par son intensité dramatique et ses numéros musicaux iconiques.",
  "Cette production capture à la perfection la tension et la passion de l'histoire d'amour maudite entre Tony et Maria, soutenue par des chorégraphies époustouflantes et une musique inoubliable.",
  "Poignante et vibrante, 'West Side Story' est une œuvre intemporelle qui explore les thèmes de l'amour, du conflit et de l'espoir, malgré un contexte de violence et de préjugés."
],

"Stomp" => [
  "Un spectacle rythmique explosif qui transforme des objets du quotidien en instruments de musique, offrant une expérience sonore et visuelle sans pareil.",
  "Avec une énergie contagieuse, 'Stomp' mélange danse, musique et théâtre de rue dans une performance qui défie les conventions et captive le public de tous âges.",
  "Innovant et dynamique, bien que basé sur un concept simple, 'Stomp' réussit à surprendre et à divertir grâce à son originalité et à la virtuosité de ses interprètes."
],

"Billy Elliot - Le Musical" => [
  "Une histoire émouvante d'aspiration et de courage, 'Billy Elliot' touche le cœur avec son récit inspirant d'un jeune garçon qui défie les conventions pour poursuivre sa passion pour la danse.",
  "Avec des numéros de danse époustouflants et une musique captivante, ce musical transcende le divertissement pour offrir une expérience profondément humaine et motivante.",
  "Puissant et poignant, 'Billy Elliot' est une célébration de la détermination et de l'esprit humain, bien que son contexte social difficile puisse émouvoir de manière inattendue."
],

"Fight Club" => [
  "Une plongée audacieuse dans les abysses de la psyché masculine, 'Fight Club' déconstruit avec brio les notions d'identité, de consommation et de rébellion dans la société moderne.",
  "Avec des performances inoubliables et une mise en scène qui oscille entre le brut et le stylisé, ce film reste un jalon culturel provocateur qui défie les attentes à chaque tournant.",
  "Intense et perturbant, 'Fight Club' est à la fois une critique acerbe de notre époque et une célébration de la libération personnelle, bien que son message puisse parfois sembler ambigu ou controversé."
],

"Hopper : Fenêtres sur la Solitude" => [
  "Une exploration intime et contemplative de l'œuvre d'Edward Hopper, capturant avec sensibilité les moments de solitude et de mélancolie qui définissent son art.",
  "Ce documentaire plonge le spectateur dans l'univers silencieux de Hopper, où la lumière et l'ombre jouent un rôle central, révélant la profondeur émotionnelle cachée dans la banalité du quotidien.",
  "Emouvant et révélateur, 'Hopper : Fenêtres sur la Solitude' offre une nouvelle perspective sur les tableaux emblématiques de l'artiste, bien que certains puissent désirer une analyse plus approfondie de ses techniques et influences."
],

"Chicago - Le Musical" => [
  "Un tourbillon de jazz, de scandale et de séduction, 'Chicago' captive par son histoire cynique de célébrité et de crime dans les années 1920, servie par des numéros musicaux électrisants.",
  "Avec son style vif et sa satire mordante, ce musical emblématique offre une critique acerbe de la corruption judiciaire et de la quête effrénée de notoriété, le tout enveloppé dans une chorégraphie époustouflante.",
  "Séduisant et provocateur, 'Chicago' est un spectacle incontournable qui allie parfaitement humour noir et performances brillantes, bien que son cynisme puisse ne pas plaire à tous les publics."
],

"Le Roi Lion - Comédie Musicale" => [
  "Une adaptation scénique époustouflante du classique de Disney, 'Le Roi Lion' émerveille par sa créativité, ses costumes somptueux et ses marionnettes innovantes, qui donnent vie à la savane africaine avec une magie inégalée.",
  "Avec une musique emblématique qui résonne dans le cœur des spectateurs, ce musical transcende l'histoire de Simba pour explorer des thèmes universels de courage, d'amour et d'identité, captivant petits et grands.",
  "Magnifique et immersif, 'Le Roi Lion' est une prouesse artistique qui marie harmonieusement spectacle visuel et profondeur émotionnelle, bien que son succès planétaire puisse parfois éclipser la simplicité touchante de son message."
],

"Cirque du Soleil: Alegria" => [
  "Une ode à la beauté de la performance humaine, 'Alegria' captive par son mélange exquis de cirque, de théâtre et de musique, offrant un spectacle qui touche l'âme et éveille les sens.",
  "Avec des acrobaties à couper le souffle, des costumes féériques et une bande sonore envoûtante, 'Alegria' emmène les spectateurs dans un voyage émotionnel à travers la joie, la tristesse et l'espoir.",
  "Inoubliable et profondément humain, 'Alegria' est une célébration de la vie et de ses hauts et bas, présentée avec la magie et la maestria caractéristiques du Cirque du Soleil, bien que son ampleur puisse parfois sembler écrasante."
],

"Da Vinci Code" => [
  "Un voyage captivant qui mêle mystères historiques et aventure palpitante, 'Da Vinci Code' séduit par son intrigue complexe et ses énigmes intellectuelles.",
  "Avec un mélange de théories controversées et une narration rapide, le récit remet en question les perceptions et maintient le public en haleine.",
  "Engageant et provocateur, bien que ses interprétations historiques spéculatives ne soient pas du goût de tous, 'Da Vinci Code' reste une exploration fascinante de la foi, de l'art et de la conspiration."
],
"Jurassic Park" => [
  "Une révolution cinématographique qui a marqué une génération, 'Jurassic Park' combine des effets spéciaux révolutionnaires avec une narration captivante pour recréer le monde fascinant des dinosaures.",
  "Sous la direction de maître de Steven Spielberg, ce film mélange parfaitement aventure, suspense et une réflexion profonde sur les limites de la science et de l'ingénierie génétique.",
  "Inoubliable et visuellement époustouflant, 'Jurassic Park' est à la fois un divertissement de haut niveau et une mise en garde contre l'arrogance humaine face aux forces de la nature, bien que certains aspects de son scénario puissent sembler simplifiés avec le recul."
],
"Picasso : Amour, Sexe et Art" => [
  "Une plongée intime et révélatrice dans la vie tumultueuse de Picasso, explorant comment ses passions ont façonné son œuvre et révolutionné l'art moderne.",
  "Ce documentaire met en lumière les relations complexes et souvent controversées de Picasso, soulignant l'influence de ses muses et de ses amours sur son processus créatif.",
  "Captivant et provocateur, 'Picasso : Amour, Sexe et Art' offre une perspective nuancée sur le génie artistique, bien que son approche sans concession puisse parfois choquer. L'œuvre demeure une célébration de la force créatrice inépuisable de Picasso."
],
"Grease - Comédie Musicale" => [
  "Un voyage nostalgique et énergique dans les années 50, 'Grease' capture l'essence de l'adolescence, de l'amour et des défis de grandir avec une bande sonore qui reste intemporelle.",
  "Avec ses personnages iconiques et ses numéros musicaux entraînants, cette comédie musicale est une célébration de la jeunesse et de la culture pop, mêlant humour, danse et émotions.",
  "Vibrante et pleine de vie, 'Grease' est à la fois un hommage affectueux et une parodie légère de l'époque du rock'n'roll, bien que sa représentation des stéréotypes de genre puisse sembler datée à certains spectateurs modernes."
],
"Le Labyrinthe" => [
  "Un thriller dystopique captivant qui mêle habilement suspense, action et mystère, plongeant les spectateurs dans un univers aussi intrigant qu'effrayant.",
  "Avec son récit haletant et ses personnages bien dessinés, 'Le Labyrinthe' offre une exploration fascinante de la survie, de l'amitié et de la résilience face à l'inconnu.",
  "Intense et immersif, bien que certains éléments de l'intrigue puissent sembler prévisibles, le film réussit à maintenir l'intérêt grâce à son rythme soutenu et à ses rebondissements inattendus."
],
"Orgueil et Préjugés" => [
  "Une adaptation exquise du classique de Jane Austen, qui capture avec brio l'esprit et l'ironie du roman, tout en explorant les thèmes de l'amour, de la classe sociale et des malentendus.",
  "Avec des dialogues étincelants et une reconstitution fidèle de l'époque, 'Orgueil et Préjugés' séduit par son mélange de romance, d'humour et de critique sociale.",
  "Élégant et intelligent, bien que fidèle à l'esprit du livre, le film parvient à rester accessible et captivant pour un public moderne, offrant une réflexion toujours actuelle sur les préjugés et l'orgueil."
],
"Forrest Gump" => [
  "Un voyage émotionnel à travers les décennies de l'histoire américaine, vu à travers les yeux d'un homme au grand cœur et à l'esprit simple, qui trouve sa voie dans les moments clés du 20e siècle.",
  "Avec une performance inoubliable de Tom Hanks, 'Forrest Gump' mélange comédie, drame et romance, créant une œuvre cinématographique touchante qui célèbre la résilience et la bonté humaine.",
  "Captivant et profondément humain, bien que par moments idéalisé, le film offre une perspective unique sur l'histoire, l'amour et l'amitié, le tout enveloppé dans une narration magistrale."
],
"L'Odyssée de Pi" => [
  "Une épopée visuelle stupéfiante qui explore les thèmes de la survie, de la foi et de l'extraordinaire voyage d'un jeune homme à travers l'océan, accompagné d'un tigre du Bengale.",
  "Grâce à des effets spéciaux révolutionnaires et une mise en scène poétique, 'L'Odyssée de Pi' transporte les spectateurs dans un monde où le réel et le merveilleux se rencontrent de la manière la plus émouvante.",
  "Envoûtant et profond, le film réussit à capturer l'essence du roman original tout en offrant une expérience cinématographique unique, bien que certains trouvent son approche philosophique par moments un peu abstraite."
],
"KÀ by Cirque du Soleil" => [
  "Une aventure épique qui défie la gravité, 'KÀ' combine des prouesses acrobatiques à couper le souffle avec une histoire captivante de bien contre mal, le tout dans une production visuellement somptueuse.",
  "Avec sa scène révolutionnaire qui tourne et s'élève, créant des terrains de jeu verticaux, 'KÀ' pousse les limites de la performance live, offrant une expérience immersive inégalée.",
  "Spectaculaire et innovant, bien que l'histoire puisse par moments sembler secondaire face à l'extravagance visuelle et technique, 'KÀ' reste une démonstration magistrale de ce que le Cirque du Soleil fait de mieux."
],
"Gatsby le Magnifique" => [
  "Une plongée envoûtante dans le faste et la décadence des années 1920, 'Gatsby le Magnifique' capture l'essence de l'ambition, de l'amour perdu et de l'illusion du rêve américain.",
  "Avec des décors somptueux et une bande sonore qui mêle habilement jazz classique et rythmes modernes, le film offre une reconstitution vibrante de l'époque tout en explorant la complexité des personnages de Fitzgerald.",
  "Magnifique et tragique, le film réussit à transmettre la mélancolie et le désir inassouvi au cœur du roman, bien que certains critiques trouvent que le style visuel flamboyant peut parfois éclipser la profondeur narrative."
],
"Divergente" => [
  "Un thriller dystopique captivant qui explore les thèmes de l'identité, du choix et de la résistance dans une société divisée en factions basées sur les vertus humaines.",
  "Avec son intrigue riche et son univers bien construit, 'Divergente' entraîne les spectateurs dans une aventure pleine de suspense et d'action, portée par des performances solides et un développement de personnage convaincant.",
  "Inspirant et haletant, bien que certains éléments de l'histoire puissent sembler familiers aux amateurs du genre dystopique, 'Divergente' se distingue par sa réflexion sur le courage et l'individualité."
],
"Sleep No More" => [
  "Une expérience théâtrale immersive et unique qui brouille les frontières entre spectacle et public, plongeant les spectateurs dans une atmosphère sombre inspirée de Macbeth.",
  "Cette production audacieuse invite les spectateurs à explorer librement les espaces mystérieux, découvrant des scènes théâtrales intenses et des performances interactives au détour des couloirs.",
  "Envoûtant et mystérieux, bien que certains participants puissent souhaiter une orientation plus claire dans le labyrinthe narratif complexe de l'expérience."
],
"Le Parrain" => [
  "Un chef-d'œuvre cinématographique intemporel qui plonge les spectateurs dans l'univers impitoyable de la mafia italo-américaine à travers l'ascension de la famille Corleone.",
  "Ce film épique, réalisé par Francis Ford Coppola, explore les thèmes de la loyauté, du pouvoir et de la corruption, avec des performances légendaires qui ont marqué l'histoire du cinéma.",
  "Captivant et profondément émouvant, bien que certains critiques puissent désirer une représentation plus nuancée des figures féminines dans le récit."
],
"Les Nymphéas de Monet : La Magie de l'Eau et de la Lumière" => [
  "Une plongée fascinante dans l'un des chefs-d'œuvre les plus emblématiques de Claude Monet, où l'eau et la lumière fusionnent pour créer une expérience visuelle sans pareille.",
  "Cette exposition dévoile l'obsession de Monet pour capturer les nuances changeantes de la lumière sur l'étang de son jardin à Giverny, offrant une immersion profonde dans son processus artistique.",
  "Envoûtante et poétique, bien que certains visiteurs puissent rechercher une contextualisation plus approfondie de l'impact de ces œuvres sur l'art moderne."
],
"Vermeer : L'Âge d'Or de l'Art Hollandais" => [
  "Une exploration intime de l'œuvre de Johannes Vermeer, mettant en lumière sa maîtrise exceptionnelle de la lumière et du détail qui définit l'âge d'or de l'art hollandais.",
  "L'exposition offre une rare occasion de voir de près certaines des peintures les plus célèbres de Vermeer, révélant les techniques subtiles et la précision émotionnelle de l'artiste.",
  "Captivante et éducative, bien que certains visiteurs puissent désirer une analyse plus poussée des influences et de l'héritage de Vermeer dans l'histoire de l'art."
],
"Les Évadés" => [
  "Une épopée captivante de résilience et d'amitié au sein des murs oppressants de la prison de Shawshank, où deux hommes, liés par l'espoir et l'ingéniosité, défient leur destin.",
  "Ce récit explore la force intérieure et la quête de liberté face à l'injustice, à travers les yeux d'Andy Dufresne, un banquier injustement condamné, et de Red, le fixeur de la prison.",
  "Profondément émouvant et inspirant, bien que certains lecteurs puissent rechercher une exploration plus approfondie des personnages secondaires et du contexte social de l'époque."
],
"Les Jeux de la Faim" => [
  "Une aventure dystopique haletante où courage, survie et rébellion se mêlent dans l'arène impitoyable des Jeux de la Faim, un combat télévisé à mort entre jeunes issus des différents districts.",
  "Ce roman suit le parcours de Katniss Everdeen, une jeune fille du District 12, qui se porte volontaire pour participer aux jeux à la place de sa petite sœur, déclenchant une série d'événements qui remettront en question le pouvoir tyrannique du Capitole.",
  "Captivant et réfléchi, bien que certains lecteurs puissent désirer une exploration plus détaillée des dynamiques politiques et des répercussions psychologiques sur les participants des jeux."
],
"Magritte : Ceci n'Est Pas une Pipe" => [
  "Une immersion profonde dans l'univers surréaliste de René Magritte, où le célèbre tableau 'La trahison des images' défie notre perception de la réalité et de l'art.",
  "Cette exploration détaille comment Magritte utilise des objets quotidiens, les transformant par l'art pour questionner l'observateur sur la nature de la représentation et la réalité.",
  "Intrigant et provocateur, bien que certains amateurs d'art puissent désirer une analyse plus approfondie des influences philosophiques et culturelles derrière l'œuvre de Magritte."
],
"Le Seigneur des Anneaux: La Communauté de l'Anneau" => [
  "Une aventure épique à travers la Terre du Milieu, où Frodon Sacquet, un jeune hobbit, se voit confier une quête périlleuse : détruire l'Anneau Unique pour mettre fin au règne de Sauron.",
  "Accompagné par la Communauté, composée de hobbits, d'hommes, d'un magicien, d'un nain et d'un elfe, Frodon doit traverser des terres hostiles, peuplées de créatures maléfiques et de dangers imprévus.",
  "Captivant et richement détaillé, bien que certains lecteurs puissent rechercher une exploration plus profonde des nombreux personnages secondaires et de leurs histoires personnelles."
],
"Turner : Peintures de Lumière" => [
  "Une exploration éblouissante de l'œuvre de J.M.W. Turner, maître incontesté de la lumière, dont les peintures révolutionnaires ont redéfini les frontières de l'art paysager et maritime.",
  "Cet aperçu met en lumière comment Turner a capturé l'essence éphémère de la lumière et de l'atmosphère, fusionnant ciel et mer dans des toiles vibrantes d'émotion et de mouvement.",
  "Fascinant et innovant, bien que certains amateurs d'art puissent désirer une exploration plus approfondie des techniques et des influences qui ont façonné l'approche unique de Turner."
],
"Raphaël : Le Seigneur des Arts" => [
  "Une exploration captivante de la vie et de l'œuvre de Raphaël, l'un des maîtres de la Renaissance, dont les peintures et fresques définissent encore aujourd'hui l'idéal de la beauté artistique.",
  "Ce récit met en lumière le talent exceptionnel de Raphaël pour la composition, la couleur et la forme, illustrant comment son œuvre a influencé l'art et la culture bien au-delà de son époque.",
  "Enrichissant et inspirant, bien que certains amateurs d'art puissent désirer une analyse plus approfondie des techniques spécifiques de Raphaël et de son impact sur ses contemporains et les générations futures."
],
"Mamma Mia! - Comédie Musicale" => [
  "Une explosion joyeuse de musique et de danse, ancrée dans les hits intemporels d'ABBA, qui raconte l'histoire touchante de famille, d'amitié et d'amour sur une île grecque idyllique.",
  "L'intrigue se tisse autour de Sophie, qui, à la veille de son mariage, invite secrètement trois hommes du passé de sa mère, espérant découvrir l'identité de son père et l'avoir à ses côtés pour son grand jour.",
  "Entraînante et émouvante, bien que certains spectateurs puissent désirer une exploration plus approfondie des relations et des conflits internes des personnages."
],
"Le Silence des Agneaux" => [
  "Un thriller psychologique haletant qui suit Clarice Starling, une jeune recrue du FBI, dans sa quête pour capturer un tueur en série, avec l'aide d'Hannibal Lecter, un brillant psychiatre devenu cannibale.",
  "Ce récit plonge le lecteur dans une atmosphère sombre et tendue, où le danger et la manipulation psychologique se cachent à chaque page, testant les limites de l'esprit humain et de la moralité.",
  "Captivant et profondément perturbant, bien que certains lecteurs puissent désirer une exploration plus approfondie des dynamiques psychologiques entre les personnages principaux."
],
"Phantom of the Opera à Broadway" => [
  "Une expérience théâtrale envoûtante qui transporte le public dans les profondeurs mystérieuses de l'Opéra de Paris, où un fantôme masqué mène une existence solitaire et nourrit une passion obsessionnelle pour une jeune soprano talentueuse.",
  "Cette production légendaire mêle amour, jalousie, et musique spectaculaire, offrant des performances vocales puissantes, des décors somptueux et une mise en scène à couper le souffle qui a captivé les spectateurs du monde entier.",
  "Magique et mémorable, bien que certains spectateurs puissent rechercher une exploration plus profonde des émotions et du passé mystérieux du Fantôme."
],
"Harry Potter à l'école des sorciers" => [
  "Une aventure magique qui commence lorsque Harry Potter, un jeune orphelin, découvre qu'il est en fait un sorcier et est invité à étudier à l'école de sorcellerie de Poudlard.",
  "Au fil de sa première année à Poudlard, Harry se lie d'amitié avec Ron Weasley et Hermione Granger, apprend les bases de la magie et découvre la vérité sur la mort de ses parents et le mystérieux Lord Voldemort.",
  "Enchantant et plein de merveilles, bien que certains lecteurs puissent chercher une exploration plus profonde des arrière-plans et des motivations des personnages secondaires."
],
"Ne tirez pas sur l'oiseau moqueur" => [
  "Un roman profondément émouvant qui explore les thèmes de l'innocence, de la justice et de la moralité à travers les yeux de Scout Finch, une jeune fille grandissant dans l'Alabama des années 1930.",
  "L'histoire se concentre sur le procès d'un homme noir accusé à tort de viol, défendu par Atticus Finch, le père de Scout, qui se bat contre les préjugés raciaux ancrés dans sa communauté.",
  "Puissant et provocateur, bien que certains lecteurs puissent rechercher une exploration plus approfondie des perspectives des personnages secondaires et de l'impact de l'événement sur la communauté dans son ensemble."
],
"Les Misérables - Comédie Musicale" => [
  "Une épopée musicale bouleversante qui narre les destins croisés de personnages emblématiques dans la France du 19e siècle, sur fond de lutte pour la justice et la rédemption.",
  "Cette adaptation magistrale du roman de Victor Hugo plonge le spectateur au cœur des révoltes populaires, à travers les yeux de Jean Valjean, un ancien forçat en quête de salut, confronté à l'implacable inspecteur Javert.",
  "Puissante et émouvante, bien que certains spectateurs puissent désirer une exploration plus approfondie des nombreux personnages secondaires et de leurs histoires personnelles."
],
"Le Cirque Invisible" => [
  "Une expérience théâtrale et circassienne unique, où Jean-Baptiste Thierrée et Victoria Chaplin transforment la scène en un monde de rêves et d'illusions, mêlant magie, acrobaties et poésie visuelle.",
  "Ce spectacle enchanteur invite les spectateurs à plonger dans l'imaginaire, avec des numéros qui défient la réalité, des costumes métamorphoses et une mise en scène où le merveilleux côtoie le fantastique.",
  "Captivant et mystérieux, bien que certains spectateurs puissent désirer une trame narrative plus claire au milieu de cette féérie visuelle et acrobatique."
],
"La Famille Bélier" => [
  "Une comédie dramatique touchante qui raconte l'histoire de Paula, une adolescente dotée d'une voix exceptionnelle, la seule entendante dans une famille de sourds, confrontée au dilemme de poursuivre ses rêves musicaux ou de rester auprès de sa famille.",
  "Le film explore avec humour et sensibilité les dynamiques familiales uniques des Bélier, tout en abordant des thèmes universels tels que l'indépendance, l'identité et le passage à l'âge adulte.",
  "Émouvant et inspirant, bien que certains spectateurs puissent rechercher une exploration plus profonde des perspectives des personnages sourds au-delà des interactions familiales."
],
"Holiday on Ice" => [
  "Un spectacle sur glace époustouflant qui combine des performances de patinage artistique de haut niveau avec des costumes éblouissants, des décors impressionnants et une musique captivante, offrant une expérience visuelle et émotionnelle inégalée.",
  "Cette production emmène les spectateurs dans un voyage féerique à travers différents thèmes et histoires, où chaque numéro de patinage est conçu pour émerveiller et captiver, grâce à l'agilité et l'expression artistique des patineurs.",
  "Enchantant et visuellement spectaculaire, bien que certains spectateurs puissent désirer une trame narrative plus continue, le charme du spectacle réside dans la diversité des performances et la beauté du patinage sur glace."
],
"Michel-Ange : Amour et Mort" => [
  "Une exploration profonde et révélatrice de la vie de Michel-Ange, l'un des plus grands artistes de la Renaissance, dont l'œuvre a transcendé le temps, mais dont la vie personnelle était emplie de conflits, de passion et de dévotion.",
  "Ce documentaire plonge dans les luttes intérieures de Michel-Ange, entre son dévouement presque divin à son art et les tumultes de ses relations personnelles, offrant un aperçu intime de son processus créatif et de sa quête incessante de perfection.",
  "Fascinant et émouvant, bien que certains spectateurs puissent désirer une analyse plus approfondie des influences politiques et culturelles de l'époque sur son œuvre."
],
"L'Âge de Rembrandt" => [
  "Une plongée captivante dans le Siècle d'Or hollandais, une période de prospérité et de renouveau artistique, où Rembrandt émerge comme une figure centrale, révolutionnant l'art du portrait et du clair-obscur.",
  "Ce documentaire explore l'impact profond de Rembrandt sur l'art de son époque, mettant en lumière sa capacité unique à capturer l'essence humaine avec une intensité émotionnelle et une profondeur psychologique inégalées.",
  "Instructif et inspirant, bien que certains amateurs d'art puissent rechercher une exploration plus approfondie des techniques spécifiques de Rembrandt et de leur influence sur les générations futures d'artistes."
],



















}

def post_function(rating, toi_title, critiques)
  base_critique = critiques[toi_title] || [
    "Une réalisation époustouflante qui redéfinit le genre. À voir absolument !",
    "Une proposition intéressante, bien que certains aspects mériteraient d'être peaufinés.",
    "Malgré quelques efforts notables, le résultat final peine à convaincre."
  ]


  critique = case rating
             when 1..2
               "Décevant. #{base_critique[2]}"
             when 3..6
               "Moyen. #{base_critique[1]}"
             when 7..10
               "Exceptionnel ! #{base_critique[0]}"
             else
               "Rating non valide."
             end

  return critique
end

200.times do ||
  user = User.order('RANDOM()').first
  toi = Toi.order('RANDOM()').first
  toi_title = toi.title
  rating = rand(1..10)

  Post.create!(
    rating: rating,
    review: post_function(rating, toi_title, critiques),
    user_id: user.id,
    toi_id: toi.id
  )

end

puts "#{Post.count} posts created sucessfully!"

puts "Creating Friend..."

User.all.each do |user|
  Friend.create(follower: User.first, following: user)
  Friend.create(follower: user, following: User.first)
end

puts "#{Friend.count} friends created sucessfully!"
