

# running the app:
    flutter run -d chrome --web-renderer html // run the app
    
    flutter build web --web-renderer html --release
    or 
    flutter build web --no-sound-null-safety --web-renderer=html


# TODO:
    -> Put messages working
        -> Ao inserir dados na cloud, inserir na seguinte forma (next lines should occurs at the same time)
            -> messages (collection) -> senderUserid (document) -> to (collectino) -> receiverId -> (document) -> messagedata  
            -> messages (collection) -> receiverId (document) -> to (collectino) -> senderUserid -> (document) -> messagedata
        -> Cada Chat so deve guardar o registo das ultimas 5 mensagens de cada utilizador. utilizar alguma estrutura de dados do tip FIFO
    -> Video call working
    -> Ao mudar foto de perfil, Colocar um icone de loading.
    -> Inserir atributo em user para verificar se esta online ou nao

    