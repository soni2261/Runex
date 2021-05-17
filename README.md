# Runex

L'application Runex a été conçue et fabriquée dans le contexte du projet d'intégration de fin de programme Sciences, informatiques et mathématiques (SIM) au cégep Bois-de-Boulogne.



Titre 

Runex 

 
 

Description du projet 

Le projet est une application sportive qui permet de faire un suivi d'entraînement détaillé d’une personne lambda comme celle d’un athlète. Pour se démarquer des applications existantes telles que Runkeeper et Strava, nous allons intégrer certaines fonctionnalités de Waze dans notre application Runex, telles que le pouvoir d’interaction entre les utilisateurs afin qu’ils puissent améliorer et fournir du contenu à l’application.  Runex intégrera des outils tels que la carte de routes de Google, et permettra aux utilisateurs de personnaliser leur itinéraire. 

 


L’équipe 

Les membres de l’équipe de notre projet sont Ali Taladar, Serguei Markov, Sonia Rahal et Sarah Al Taleb. 

 


L’idée 

Notre projet est une application qui permet de faire un suivi de son entraînement sportif. Les utilisateurs pourront suivre leur progrès pendant et après les randonnées, selon des statistiques enregistrés sur leur profil. Les options de sport offertes aux utilisateurs sont de la randonnée pédestre, de la course et du vélo. 

Deux options sont offertes : soit faire un entraînement seul ou en groupe. Un espace communauté servira à ceux qui désirent créer des événements, afin de rencontrer d’autres utilisateurs pendant leur sport. L’application offrira des endroits pratiques aux utilisateurs tels que des fontaines d’eau, des places pour réparer les vélos, des vues magnifiques, et toute autre place pour laquelle l’utilisateur (ou les utilisateurs) a/ont un intérêt. 


 

L’utilité 

Runex est utile pour faire un suivi de son entrainement, se donner des objectifs de sport et pour avoir un itinéraire tracé vers une destination. 

L’innovation 

Ce qui démarque Runex des autres applications est notamment la création d’événements qui permet de regrouper les utilisateurs. De plus, la visibilité des autres utilisateurs à proximité est utile afin de motiver les utilisateurs et d’encourager la création de contacts. Finalement, les intérêts des utilisateurs sont une priorité, et c’est pourquoi l’ajout de vues magnifiques, de coins de réparation de vélos, de fontaines d’eau, etc… sur la carte de route est une option importante et innovatrice. 

 
 

Cas d’utilisation (scénario, acteurs) 

Scénario #1 

Un cycliste désire faire 1h de sport et de faire une analyse. Selon les données que l’application a collectées, un chemin sera prédéterminé afin qu’il puisse faire du sport. Une fois qu’il décide de commencer le sport, sa vitesse (son nombre de km/h) sera enregistrée, ainsi que la durée de son entraînement et l’élévation. À la fin de sa séance, il pourra voir le nombre de kilomètres parcourus, la durée du sport et la vitesse moyenne du sport. 

Scénario #2 

Un athlète décide de courir avec son chien pendant une trentaine de minutes. Il utilisera le GPS de l’application pour savoir quel chemin prendre pour se rendre au parc. Une fois rendu au parc, il arrêtera l’application, puis il sera indiqué la distance qu’il a parcouru avec son chien. 

Scénario #3 

Une personne active doit aller au travail à la marche, et elle décide d’utiliser l’application pour avoir l’itinéraire de chez-elle jusqu’au travail. Une fois arrivée, cette personne pourra savoir la vitesse moyenne à laquelle elle a marchée, ainsi que la distance et l’élévation. 

 


Acteur 

Il y a un unique acteur du cas d’utilisation. Il est responsable de commencer et terminer un entraînement. 



Public cible 

Runex s’adresse aux personnes qui désirent enregistrer leurs rapports d'entraînement et suivre leur progrès. 





Technologies 

En ce qui concerne les technologies à utiliser, nous prévoyons recourir aux ressources telles que Git, Visual Studio Code, Dart, Flutter, Firebase, l’API de Google Maps et l’émulateur Android avec Android Studio. En effet, ces outils nous ont permis de développer une application à la hauteur de nos objectifs. Git a servi à travailler en équipe pour planifier et organiser notre code. Visual Studio Code était la plateforme où nous avons programmé et testé notre application, alors que Dart est la langue de programmation que nous avions eu à apprendre. Flutter est notre logiciel d’interface de l’utilisateur pour une utilisation instinctive. Nous avons utilisé une base de données pour certaines statistiques que nous avons entreposées sur Firebase. Dans notre application, qui vise en premier lieu à tracer un itinéraire pour les utilisateurs lors de leur sport, nous avions eu besoin d’implémenter la carte des routes, que nous accédons par l’API de Google Maps. Finalement, afin de simuler des itinéraires sur l’application durant la création de Runex, nous avons eu recours à un émulateur de téléphone cellulaire sur Android Studio. 

Ces nombreux outils, bien qu'utiles, présentait certains défis et difficultés. En effet, puisqu'aucun des membres de l’équipe avait déjà travaillé avec ces outils, nous devions entre autres apprendre comment fonctionnent les bases de données, comment intégrer Google Maps dans l’application et repérer les localisations des utilisateurs et de certaines places. 





Problèmes à régler

La gestion des différents cas et scénarios n'a pas été complétée. Il y a certaines exceptions à corriger.





Perspectives 


Avec le peu de temps et de connaissances sur les technologies utilisées, il était difficile de respecter les échéances et nos attentes. Si nous avions eu le double du temps alloué pour ce projet, nous aurions pu débuter la section communauté qui est l’innovation principale de Runex.  

On voudrait ajouter une barre de progression pour les objectifs. Aussi, nous voudrions ajouter dans le futur la section communauté. Cela permettrait d’interagir avec les autres utilisateurs de l’application et de visualiser ceux qui sont à proximité pour des entrainements en groupe si possible.  

On voudrait aussi faire une reconnaissance lorsqu’un défi est complété sous forme de badge ou de trophées qui s’ajoutent au profil et qui serait visible par les autres membres de l’application. Ces badges offrent une certaine notoriété, en donnant droit à la création d’évènements et à la participation d’évènements de plus haut niveau.  

En effet, nous voulions faire initialement des évènements asynchrones, qui donneraient la possibilité aux membres de pouvoir faire des évènements, que ça soit une course contre la montre ou de longue distance indépendante dans un espace de temps. 

On voudrait aussi implémenter un classement des meilleurs sportifs du mois serait disponible dans l’onglet; pour se classer il serait nécessaire de compléter ses propres objectifs, les défis donnés par Runex ou encore avec la participation aux évènements synchrones et asynchrones. 

Pour ce qui est de la carte, il y aurait implémentation d’animations pour faire le suivi de l’utilisateur et l’ajout de marqueurs des places importantes, telles que des abreuvoirs, stations de réparation, de vues imprenables, d’ateliers de vélo, etc. Il serait aussi possible de voir la performance d’un segment dans la ville grâce à un classement municipal mensuel. Plusieurs petits ajouts de contenus sur la carte optimiseraient les itinéraires et dépanneraient les utilisateurs en cas de pépin. En effet, la gestion des différents scénarios possibles n’a pas été faite. Le projet fonctionne, mais pourrait rencontrer certaines erreurs particulières lors de l’utilisation. 

Une optimisation globale de l’application pour faciliter la navigation dans les différentes sections et le chargement de la carte en préchargeant d’un cache.  La section historique donnerait un aperçu sur l’itinéraire parcourues. 







Bibliographie, installation et configuration

 

Pour installer Flutter et configurer l’environnement de travail: 

https://www.youtube.com/watch?v=5izFFbdHnWY&t=381s 

 

Pour apprendre Flutter: 

https://www.youtube.com/playlist?list=PL4cUxeGkcC9jLYyp2Aoh6hcWuxFDX6PBJ 

https://www.youtube.com/playlist?list=PLzMcBGfZo4-knQWGK2IC49Q_5AnQrFpzv 

 

Pour l’implémentation de l’itinéraire: 

https://www.youtube.com/watch?v=IAIDZxwnEdI&t=1922s 

 

Pour l’implémentation de la complétion automatique d’endroits : 

https://www.youtube.com/watch?v=_KZKvVYyA4o 

https://medium.com/comerge/location-search-autocomplete-in-flutter-84f155d44721 

 

Pour l’implémentation de la base de données Firebase:  

https://www.youtube.com/playlist?list=PL4cUxeGkcC9j--TKIdkb3ISfRbJeJYQwC 
