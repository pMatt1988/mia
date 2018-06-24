package mia.component;

class Component {
    var gameObject:GameObject;

    /**
     *  override this to init GameObject.
     *  @param gameObject - GameObject to add as parent.
     */
    public function init(gameObject:GameObject) {
        
        this.gameObject = gameObject;
    }
}