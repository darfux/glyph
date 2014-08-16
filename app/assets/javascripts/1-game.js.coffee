root = exports ? this

preload = ->
    @game.load.image('einstein', 'images/test.jpg');

create = ->
    @game.add.sprite(0, 0, 'einstein');

root.init_game = ->
	@game = new Phaser.Game(1280, 720, Phaser.CANVAS, 'phaser-example', { preload: preload, create: create });