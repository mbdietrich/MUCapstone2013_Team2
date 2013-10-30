        var singlePlayer = function(ev) {
            if(ev){
                ev.stopPropagation();
            }
            else{
                    window.event.stopPropagation();
            }
                $.post("create", {type: "solo", botname: "DefaultBot"}, function(e) {
                    document.location.href = "game.jsp";
                });

            }
            var multiPlayer = function(ev) {
            if(ev){
                ev.stopPropagation();
            }
            else{
                    window.event.stopPropagation();
            }
                $.post("create", {type: "any"}, function(e) {
                    document.location.href = "game.jsp";
                });

            }
            var joinPublicGame = function(id) {
                if(window.event){
                window.event.stopPropagation();
                }
                var pubName = id;
                $.post("create", {type: "public", player: pubName}, function(e) {
                    document.location.href = "game.jsp";
                });
            }
            var joinPrivateGame = function(id) {
                var privName = id;
                if(window.event){
                window.event.stopPropagation();
                }
                $.post("create", {type: "private", player: privName}, function(e) {
                    document.location.href = "game.jsp";
                });
            }
            var openPrivateGame = function(){
                if(window.event){
                window.event.stopPropagation();
                }
                window.location = "privateGame.jsp";
                /*
                $.post("create", {type: "newprivate"}, function(e) {
                    document.location.href= "game.jsp";
                })*/
            }         
            var openGame = function() {
                if(window.event){
                window.event.stopPropagation();
                }
                $.post("create", {type: "open"}, onGameCreate);
            }
