(function() { this.JST || (this.JST = {}); this.JST["posts/show"] = function(obj){var __p=[],print=function(){__p.push.apply(__p,arguments);};with(obj||{}){__p.push('<main>\n  <h3>Title: ',  model.get('title') ,'</h3>\n  <p>',  model.get('body') ,'</p>\n  <br><br>\n  <a href=\'#\'>All Posts</a>\n</main>\n');}return __p.join('');};
}).call(this);
