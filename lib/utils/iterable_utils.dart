extension IterableFunction on Iterable{
  // Iterable flatten() => this.expand((e) => e is Iterable ? e.flatten() : [e]);
  Iterable<T> flatten<T>() => this.expand((e) => e is Iterable ? e.flatten() : [e as T]);
}
