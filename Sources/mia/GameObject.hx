package mia;


import mia.component.Component;
import kha.graphics2.Graphics;

class GameObject {
    public var x:Float = 0;
    public var y:Float = 0;

    public var parent:GameObject;

    public var worldX(get, null):Float;
    public var worldY(get, null):Float;

    var renderers:Array<Graphics->Void> = [];
    var updaters:Array<Void->Void> = [];

    public var children:Array<GameObject> = [];
    public var components:Array<Component> = [];

    public var enabled = true;
    public var active = true;
    public var visible = true;

    public function new(?x:Float = 0, ?y:Float = 0) {
        this.x = x;
        this.y = y;
    }

    public function render(graphics:Graphics) {
        for(r in renderers){
            r(graphics);
        }
    }

    public function update() {
        for(u in updaters) {
            u();
        }
    }

    public function AddChild(go:GameObject):GameObject {
        if(children.indexOf(go) != -1) return null;
        children.push(go);
        go.parent = this;
        return go;

    }

    public function RemoveChild(go:GameObject) {
        children.remove(go);
    }

    /**
     *  Add a Component to this GameObject
     *  @param component - Component to add to GameObject
     */
    public function AddComponent(component:Component) : Component {
        components.push(component);
        component.init(this);
        return component;
    }

    /**
     *  Remove a Component from this GameObject
     *  @param component - Component to remove.
     */
    public function RemoveComponent(component:Component) {
        components.remove(component);
    }

    /**
     *  Retrieve Component of type T from GameObject.
     *  If component does not exist on GameObject, returns null
     *  @param componentType - Type of.
     *  @return return Component of type T on the GameObject or null
     */
    public function GetComponent<T>(componentType:Class<T>) : T {
        for(c in components) {
            if(Std.is(c, componentType)) {
                return cast c;
            }
        }
        return null;
    }

    public function Destroy() {
        renderers = [];
        updaters = [];
        children = [];
        components = [];
    }
    
    

    public function RegisterRenderer(renderer:Graphics->Void) {
        if(renderers.indexOf(renderer) == -1) {
            renderers.push(renderer);
        }
    }
    public function UnregisterRenderer(renderer:Graphics->Void) {
        renderers.remove(renderer);
    }

    public function RegisterUpdater(updater:Void->Void) {
        if(updaters.indexOf(updater) == -1) {
            updaters.push(updater);
        }
    }
    public function UnregisterUpdater(udpater:Void->Void) {
        updaters.remove(udpater);
    }

    function get_worldX():Float {
        if(parent != null) return x + parent.worldX;
        return x;
    }

    function get_worldY():Float {
        if(parent != null) return y + parent.worldY;
        return y;
    }

    /**
     *  Recursively Render go and all of go's children
     *  @param go - GameObject to render
     *  @param graphics - Graphics of Framebuffer
     */
    public static function DoRender(go:GameObject, graphics:Graphics) {
        if(!go.enabled || !go.visible) return;
        go.render(graphics);
        for(c in go.children) {
            DoRender(c, graphics);
        }
    }

    /**
     *  Recursively Update go and all of go's children
     *  @param go - GameObject to update
     */
    public static function DoUpdate(go:GameObject) {
        if(!go.enabled || !go.visible) return;
        go.update();
        for(c in go.children) {
            DoUpdate(c);
        }
    }
}