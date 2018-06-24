package mia.component;

import kha.graphics2.Graphics;

class RectangleRender extends Component {
    public var width:Float = 0;
    public var height:Float = 0;
    public function new(width:Float, height:Float) {
        this.width = width;
        this.height = height;       
    }

    override function init(gameObject:GameObject) {
        super.init(gameObject);

        gameObject.RegisterRenderer(render);
    }

    public function render(graphics:Graphics) {
        graphics.drawRect(gameObject.x - width / 2, gameObject.y - height / 2, width, height);
    }
}