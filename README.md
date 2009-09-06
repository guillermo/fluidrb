FLUIDRB
=======

Ruby api for fluidDB


    


Current Features
----------------

  * fluiddb and fluiddb-sandbox command to open a fluiddb console with history and completion
  * Full implemented: Namespace, Object, Tag and User
  

Todo
----

  * permissions:
  * policies:	 

Spec Coverage
-------------

  FluidDB::Namespace
    should find the user namespace
    should create a new namespace
    should edit namespace
    should remove namespaces
    should raise error
      on create if already exists
      on remove if no exists
  FluidDB::Object
    should create an Object
    should read and write tags
    should find objects
  FluidDB::Tag
    should be able to find
    should create a new tag
    should edit a tag
    should remove a tag
    should raise error
      on create if already exists
      on remove if no exists
  FluidDB::User
    should return an User if exists
    should raise an error if an User doesn't exists


Sample Session
--------------

    FluidDb (master)$ ./bin/fluiddb-sandbox 
    Welcome to FluidDB Ruby Console
    ===============================

    Remember: * FDB == FluidDB
              * set $debug = true for debugg messages
              * FDB is ready to work with the sandbox"


    >> obj = FDB::Object.create!(:about => 'Cerveza Wadus')
    => #<FluidDB::Object URI="https://fluidDB.fluidinfo.com/objects/e7c83db0-b2be-4a9c-bd9b-800d80a97e45", about="Cerveza Wadus", path="/objects/e7c83db0-b2be-4a9c-bd9b-800d80a97e45", id="e7c83db0-b2be-4a9c-bd9b-800d80a97e45">

    >> obj.test.opinion = 'good taste'
    => "good taste"

    >> obj.test.opinion
    => #<FluidDB::Object path="/objects/0c171290-6d8d-467d-9789-3733c9c83e7f/test/opinion">

    >> obj.test.opinion.value
    => "good taste"

    >> obj / 'test/opinion'
    => "good taste"

    >> FDB::Object.find('has test/opinion').map{|obj| obj.test.opinion.value }
    => ["These is a "really good" object", "Good taste", "good opinion", "good taste"]

    >> obj.tags.map{|t| t.value}
    => ["Cerveza Wadus", "Good taste"]

    >> FDB::User.find('test')
    => #<FluidDB::User path="/users/test", name="test", id="8cc64c7d-a155-4246-ab2b-564f87fd9222">

    >> ns = FDB::Namespace.create!('test/cars', 'cars namespace')
    => #<FluidDB::Namespace URI="https://fluidDB.fluidinfo.com/namespaces/test/cars", path="/namespaces/test/cars", id="2876cad0-0fbf-4a02-b191-ee442a69d249">

    >> ns.update!("i don't have any car for a namespace")
    => #<FluidDB::Namespace URI="https://fluidDB.fluidinfo.com/namespaces/test/cars", path="/namespaces/test/cars", value="", id="2876cad0-0fbf-4a02-b191-ee442a69d249">

    >> FDB::Namespace.find('test/cars').destroy!
    => true

    >> FDB::Namespace.find('test').namespaces[-2..-1]
    => [#<FluidDB::Namespace path="/namespaces/test/fluidrb:guillermo:12522082095738315431458669685913185">, #<FluidDB::Namespace path="/namespaces/test/cars">]

    >> FDB::Tag.create!('test/opinion','opinion tag')
    => #<FluidDB::Tag indexed=true, URI="https://fluidDB.fluidinfo.com/tags/test/opinion", path="/tags/test/opinion", description="opinion tag", id="f00696ac-f2a7-4651-be55-bc43c60bd3e7">
    
    >> FDB::Tag.find('test/opinion')
    => #<FluidDB::Tag indexed=true, path="/tags/test/opinion", description="save my opinion", id="f00696ac-f2a7-4651-be55-bc43c60bd3e7">

    >> FDB::Tag.find('test/opinion').update!('Bad opinions').fetch
    => #<FluidDB::Tag indexed=true, path="/tags/test/opinion", value="", description="Bad opinions", id="f00696ac-f2a7-4651-be55-bc43c60bd3e7">

    >> FDB::Tag.find('test/opinion').destroy!
    => true

    >> FDB::Tag.find('test/opinion')
    FluidDB::Error: 404: TNonexistentAttribute at test/opinion}
    
    
Disclaimer
----------

   These is just two nights work for personal playing with fluiddb, so it is not full clean as good as production software (must be).
   Feel free to fork me.
   
   