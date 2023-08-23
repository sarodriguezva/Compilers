(*
Stack Implementation in COOL.
Author: sarodriguezva
Universidad Nacional de Colombia 2023-II
*)

class List inherits A2I{
	item: Object;
	next: List;

	init(i: Object, n: List): List {
		{
			item <- i;
			next <- n;
			self;
		}
	};

	getnext(): List{
		next
	};

	flatten(): String {
		let string: String <-
			case item of
				i: Int => i2a(i);
				s: String => s;
				o: Object => { abort(); ""; };
			esac
		in
			if ( isvoid next ) then
				string
			else
				string.concat(next.flatten())
			fi
	};
};

class Stack inherits List {
	top: List;
	size: Int <- 0;
	push(i: Object): Stack {
		let aux: List <- top
		in
		{
			top <- (new List).init(i, aux);
			size <- size + 1;
			self;
		}
	};

	pop(): Stack {
		let aux: List <- top
		in
		{
			top <- aux.getnext();
			size <- size - 1;
			self;
		}
	};

	getsize(): Int {
		size
	};

	tostring(): String {
		top.flatten()
	};
};


class Main inherits IO {
	main(): Object {
		let s: Stack <- (new Stack) in
			{
				s.push("A");
				s.push("B");
				s.push("C");
				out_string(s.tostring().concat("\n"));

				while ( not (s.getsize() = 0) ) loop
				{
					out_string(s.tostring().concat("\n"));
					s.pop();
				}
				pool;
				s;
			}
	};
};
