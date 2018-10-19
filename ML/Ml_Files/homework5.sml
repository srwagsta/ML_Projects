(* Question 1 *)
fun merge_sort _ nil = nil
  | merge_sort _ (x::nil) = x::nil
  | merge_sort f list = 
  let
    fun split list = 
      let
        val cut = (length list) div 2
      in
        ( List.take (list,cut) , List.drop (list,cut) )
    end;

    fun merge (nil, remaining) = remaining
      | merge (remaining, nil) = remaining
      | merge ((left as lh::l), (right as rh::r)) = 
      if f(lh, rh)
      then lh::merge (l, right)
      else rh::merge (left,r);
    val (left, right) = split list
  in
    merge ((merge_sort f left), (merge_sort f right))
  end;

merge_sort (op >) [0, 5, 1, ~4, 9, 11];

(* Question 2 *)
fun selection_sort _ nil = nil
  | selection_sort f list = 
    let
      fun select nil = nil
        | select [x] = [x]
        | select (firstElement::list) = 
          let
            val (testElement::remaining) = select(list)
          in
            if(f(testElement,firstElement)) 
            then select(testElement::firstElement::remaining) 
            else firstElement::testElement::remaining
          end;
    in 
      select list
    end;

selection_sort (op >) [0, 5, 1, ~4, 9, 11];

(* Question 3 *)
fun insertion_sort _ nil = nil
  |	insertion_sort f list = 
  let 
    fun insert x nil = [x]
      |	insert x (head::rest) = 
        if f(x,head)
        then x::head::rest
        else head::(insert x rest)
    fun sort sofar nil = sofar
      | sort sofar (element::list) = 
        insert element (sort sofar list)  
  in
    sort nil list
  end;

insertion_sort (op >) [0, 5, 1, ~4, 9, 11];

(* Question 4 *)
fun quicksort (_, nil) = nil
  | quicksort (_, [x]) = [x]
  | quicksort (f, rest) =
  let
    fun get (head::_, 1) = head
      | get (_::rest, index) = get(rest, index-1);

    val pivot = (get(rest, 1) + get(rest,(length rest + 1) div 2) + get(rest, length rest) div 3)

    fun split nil = ( nil, nil, nil )
      | split (x :: remaining) =
      let
        val ( lower, middle, upper ) = split remaining
      in
        if f( pivot, x )
        then ( lower, middle, x::upper )
        else 
          if x = pivot
          then (lower, x::middle, upper)
          else (x::lower, middle, upper )
      end;
    val ( lower, middle, upper ) = split rest
  in
    quicksort(f, lower) @ middle @ quicksort(f, upper)
  end ;

quicksort ((op >),[0, 5, 1, ~4, 9, 11]);