class List {
	item: String;
	next: List;

	init(i: String, n:List): List {
		{
			item <- i;
			next <- n;
			self;
		}
	};

	flatten(): String {
		if ( isvoid next ) then
			item
		else
			item.concat(next.flatten())
		fi
	};
};

(*This is a Multiple line comment*)
class Main inherits IO {
	main(): Object {
		let first: String <- "Hello ",
		second: String <- "World!",
		newline: String <- "\n",
		nil: List, --no null exists in cool, this is a single line comment
		list: List <- (new List).init(first, (new List).init(second, (new List).init(newline, nil)))
		in
			out_string(list.flatten())
	};
};
