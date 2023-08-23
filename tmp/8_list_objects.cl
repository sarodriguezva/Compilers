class List inherits A2I {
	item: Object;
	next: List;

	init(i: Object, n:List): List {
		{
			item <- i;
			next <- n;
			self;
		}
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

(*This is a Multiple line comment*)
class Main inherits IO {
	main(): Object {
		let first: String <- "Hello ",
		second: String <- "World! ",
		newline: String <- "\n",
		nil: List, --no null exists in cool, this is a single line comment
		list: List <- (new List).init(first, (new List).init(second, (new List).init(123, (new List).init(newline, nil))))
		in
			out_string(list.flatten())
	};
};
