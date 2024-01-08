open CML

fun prog () =
    let
	val c1 : int chan = channel ()
	val e1 = recvEvt c1
	val c2 : int chan = channel ()
	val e2 = recvEvt c2
	val c3 : int chan = channel ()
	val e3 = recvEvt c3
	val c4 : int chan = channel ()
	val e4 = recvEvt c4
	val c5 : int chan = channel ()
	val e5 = recvEvt c5
    in
	spawn (fn () => send (c1, 100));
	spawn (fn () => send (c2, 200));
	spawn (fn () => send (c3, 300));
	spawn (fn () => send (c4, 400));
	spawn (fn () => send (c5, 500));
	spawn (fn () =>
		  let
		      val r = ref 0
		      fun server () = (
			  let
			      val value = select ([e1, e2, e3, e4, e5])
			  in
			      r := value
			  end;
			  print ("value = " ^ Int.toString (!r) ^ "\n");
			  server ()
		      )
		  in
		      server ()
		  end);
	()
    end

val _ =
    RunCML.doit (prog, NONE)
