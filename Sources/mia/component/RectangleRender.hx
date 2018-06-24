package mia.component;

import kha.Color;
import kha.graphics2.Graphics;

class RectangleRender extends Component {
    public var width:Float = 0;
    public var height:Float = 0;

    var color:Color;

    public function new(width:Float, height:Float, ?color:Color = Color.White) {
        this.width = width;
        this.height = height;
        this.color = color;       
    }

    override function init(gameObject:GameObject) {
        super.init(gameObject);

        gameObject.RegisterRenderer(render);
    }

    public function render(graphics:Graphics) {
        var colorCache = graphics.color;
        graphics.color = color;
        graphics.drawRect(gameObject.worldX - width / 2, gameObject.worldY - height / 2, width, height);
        graphics.color = colorCache;
    }
}