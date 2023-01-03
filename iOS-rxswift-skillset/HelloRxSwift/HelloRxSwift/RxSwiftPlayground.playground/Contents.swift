import UIKit
import RxSwift
import RxCocoa

/*
 let observable = Observable.just(1)
 
 let observable2 = Observable.of(1,2,3)
 
 let observable3 = Observable.of([1,2,3])
 
 let observable4 = Observable.from([1,2,3,4,5])
 
 observable4.subscribe { event in
 print(event)
 if let element =  event.element {
 print(element)
 }
 }
 
 observable3.subscribe { event in
 print(event)
 if let element =  event.element {
 print(element)
 }
 }
 
 let subscription4 = observable4.subscribe (onNext: { element in
 print(element)
 })
 
 subscription4.dispose()

 */

let disposeBag = DisposeBag()

/*
Observable.of("A","B","C")
    .subscribe {
        print($0)
    }.disposed(by: disposeBag)

Observable<String>.create { observer in
    observer.onNext("A")
    observer.onCompleted()
    observer.onNext("?")
    return Disposables.create()
}.subscribe(onNext: {
    print($0)
}, onError: {
    print($0)
}, onCompleted: {
    print("Completed")
}, onDisposed: {
    print("Disposed")
}).disposed(by: disposeBag)
*/

/*
let subject = PublishSubject<String>()

subject.onNext("Issue 1")

subject.subscribe { event in
    print(event)
}

subject.onNext("Issue 2")
subject.onNext("Issue 3")

//subject.dispose()
subject.onCompleted()

subject.onNext("Issue 4")
*/

/*
let subject = BehaviorSubject(value: "Intial Value")

subject.onNext("Issue 0")

subject.subscribe { event in
    print(event)
}

subject.onNext("Issue 1")
*/

/*
let subject = ReplaySubject<String>.create(bufferSize: 2)

subject.onNext("Issue 1")
subject.onNext("Issue 2")
subject.onNext("Issue 3")

subject.subscribe {
    print($0)
}

subject.onNext("Issue 4")
subject.onNext("Issue 5")
subject.onNext("Issue 6")

print("[Subscription 2]")

subject.subscribe {
    print($0)
}
*/

/*
let variable = Variable([String]())
variable.value.append("Item 1")

variable.asObservable().subscribe {
    print($0)
}

variable.value.append("Item 2")
*/

let relay = BehaviorRelay(value: ["Item 1"])

var value = relay.value
value.append("Item 2")
value.append("Item 3")
relay.accept(value)
//relay.accept(relay.value + ["Item 2"])

relay.asObservable()
    .subscribe {
        print($0)
    }
