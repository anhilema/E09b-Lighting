# E09b-Lighting

The purpose of this exercise is for you to explore 3D lighting and camera movement in Godot. There are many steps, and some of the concepts are a little complicated, so I would recommend that you stop and test frequently. I have tried to be as clear as possible.

This exercise is loosely based on the How to light a 3d scene in Godot (3d tutorial) by GDQuest. The YouTube video is
[available here](https://www.youtube.com/watch?v=iamttSmxA2I).


This exercise is different from the GDQuest tutorial in distinct ways, so please follow the directions I provide. The video may help you to visualize anything you might find confusing, however.

--- 

Please Fork and Clone the repository to your computer. In the folder that is created, locate the project.godot file and open it in Godot.

In World.tscn, I have provided a starting place for the exercise: the scene contains a parent Spatial node (named World), a Position3D node, and a Spatial node (named Pivot). I have also included several files in the Assets folder, which we will use during this exercise.

In the Assets folder, you will find scene.gltf. This is a [3D model of a small cabin](https://sketchfab.com/3d-models/gr-5df64141235040749103749123e43010) created by luyssport and released under a CC Attribution-NonCommerical-ShareAlike license. This is the model we will use for exploring how light sources work in Godot.

The first step is to tell Godot how to import the scene. In the FileSystem panel, highlight res://Assets/scene.gltf. Then select the Import tab (in the Scene panel). Under Materials, make sure Location is set to Mesh and Storage is set to Files (.tres). Under Meshes, make sure Light Baking is set to Enable. You should then push the Reimport button at the bottom of the panel.

After the scene has been reimported, drag scene.gltf from the FileSystem panel in to the Scene panel as a child of the Position3D node. If you reimported the scene correctly, you should see the cabin appear in the main workspace. Rename the "scene" node to "Cabin".

Click on the scene icon next to the Cabin node. A message will appear warning you that the scene was imported, push the "create a new scene" button. When that scene appears, click on the eye icon next to sky and water002. This will cause those nodes (and their corresponding meshes) to disappear. Save the Cabin scene, and return to the World scene.

Select the Position3D node, and in the Inspector, change Spatial->Transform->Translation.y = 6

Right click on the Pivot node and Add Child Node. Choose Camera. Select the Camera node and in the Inspector, check the box next to Current. In Spatial->Transform. Change Translation.y = 6 and Translation.z = 5

With the Camera selected, you should now see a checkbox (labeled Preview) in the top left corner of the Viewport. If you check that box, you should see a fairly-close view of the right side of the house. Test it, and then leave it unchecked.

Godot, by default, creates a procedurally-generated skybox for 3D games with a blue, cloudless sky (which reflects on the meshes in the scene. The next step will be to replace this with a custom skybox and allow Godot to illuminate the cabin with indirect lighting.

Right click on the World node and Add Child Node. Select GIProbe. This will provide some constraints to Godot for precomputing the global illumination. Select the GIProbe node, and in the inspector, set the Extents to x=30, y=30, z=30. Immediately over the Viewport, you should see a button labeled Bake GIProbe. Press that now. Now, we would prefer to not have to look at the green cube, so we will hide it in the editor. To the left of the Bake GIProbe button is one labeled View. If you press that, you should see a Gizmos submenu. Select the eye next to GIProbe (so the eye is now closed).

Right click on the World node and Add Child Node. Select WorldEnvironment. Drag it to the top of the Scene panel, so it appears immediately under World. In the Inspector, select Environment and choose New Environment. After the new Environment has been created, select Environment again and Save it as res://scenes/Enironment.tres. Then select Environment once more and choose Edit.

Under Background->Mode, select Sky, and under Background->Sky, select New PanoramaSky. Edit the PanoramaSky, and drag the res://Assets/venice_sunset_1k.hd file (acquired  from HDRIHaven (Links to an external site.)) into Panorama. The skybox should now appear as a boardwalk at sunset in Venice. Go back to editing the Environment. 

We actually only want the colors of the skybox reflecting on our model, so in Background->Mode, instead select Color+Sky. In Background->Color, type in R=68, G=68, B=68, A=255.

In Ambient Light->Color, type in R=95, G=33, B=217, A=255, set Ambient Light->Energy=0.2, and set Ambient Light->Sky Contribution=0.5

Set ToneMap->Mode to Aces and Ss Reflections->Enabled to On. There is a thorough discussion of ToneMap in the GDQuest video—it adjusts how the exposure and white balance are calculated. SS reflections allows metallic surfaces to be reflective.

We will now experiment with two different types of light sources. Back in the Scene panel, right-click on the World node and Add Child Node. Select DirectionalLight. In the Inspector, change Spatial->Transform->Translation: x=-15, y=10, z=20. Spatial->Rotation Degrees: x=-10, y=-40, z=-25. The arrow should be aligned with where the sun was in the Venice Sunset panorama (indicating where the directional light is coming from). To make it look more like a sunset, change Light->Light->Color: R=235, G=104, B=8, and change Light->Light->Energy=0.6

Right-click on the World node and Add Child Node. Select OmniLight. In the Inspector, change Spatial->Transform->Translation: x=1.711, y=4.333, z=0.268. Change Light->Light->Color: R=197, G=188, B=109. Change OmniLight->Omni->Attenuation=2 (drag down the line)

Finally, we will add a little dynamism to the camera. Right-click on the Pivot node, and Attach Script. Set the path to res://Scripts/Pivot.gd with an Empty Template.

In the resulting Pivot.gd script, type the following:

```
extends Spatial

export var speed = 15
export var zoom_speed = 1.5
export var zoom_min = 5
export var zoom_max = 15

func _physics_process(delta):
	rotation_degrees.y += delta*speed
	$Camera.translation.z += delta*zoom_speed
	if $Camera.translation.z > zoom_max or $Camera.translation.z < zoom_min:
		zoom_speed *= -1
```

Run the scene. The result should look something like this: 

![Cabin example](https://github.com/BL-MSCH-C220-S20/E09b-Lighting/blob/master/cabin.gif)

Save and commit your changes, Push the repository back to GitHub, and turn in a link to your repository on Canvas.
