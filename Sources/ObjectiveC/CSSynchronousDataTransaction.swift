//
//  CSSynchronousDataTransaction.swift
//  CoreStore
//
//  Copyright © 2016 John Rommel Estropia
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Foundation
import CoreData


// MARK: - CSSynchronousDataTransaction

/**
 The `CSSynchronousDataTransaction` serves as the Objective-C bridging type for `SynchronousDataTransaction`.
 */
@objc
public final class CSSynchronousDataTransaction: CSBaseDataTransaction {
    
    /**
     Saves the transaction changes and waits for completion synchronously. This method should not be used after the `-commitAndWait` method was already called once.
     
     - returns: a `CSSaveResult` containing the success or failure information
     */
    @objc
    public func commitAndWait() -> CSSaveResult {
        
        return bridge {
            
            self.swift.commitAndWait()
        }
    }
    
    /**
     Begins a child transaction synchronously where `NSManagedObject` creates, updates, and deletes can be made. This method should not be used after the `-commitAndWait` method was already called once.
     
     - parameter closure: the block where creates, updates, and deletes can be made to the transaction. Transaction blocks are executed serially in a background queue, and all changes are made from a concurrent `NSManagedObjectContext`.
     - returns: a `CSSaveResult` value indicating success or failure, or `nil` if the transaction was not comitted synchronously
     */
    @objc
    public func beginSynchronous(closure: (transaction: CSSynchronousDataTransaction) -> Void) -> CSSaveResult? {
        
        return bridge {
            
            self.swift.beginSynchronous { (transaction) in
                
                closure(transaction: transaction.objc)
            }
        }
    }
    
    
    // MARK: BaseDataTransaction
    
    /**
     Creates a new `NSManagedObject` with the specified entity type.
     
     - parameter into: the `CSInto` clause indicating the destination `NSManagedObject` entity type and the destination configuration
     - returns: a new `NSManagedObject` instance of the specified entity type.
     */
    @objc
    public override func createInto(into: CSInto) -> NSManagedObject {
        
        return self.swift.create(into.swift)
    }
    
    /**
     Returns an editable proxy of a specified `NSManagedObject`. This method should not be used after the `-commitAndWait` method was already called once.
     
     - parameter object: the `NSManagedObject` type to be edited
     - returns: an editable proxy for the specified `NSManagedObject`.
     */
    @objc
    @warn_unused_result
    public override func editObject(object: NSManagedObject?) -> NSManagedObject? {
        
        return self.swift.edit(object)
    }
    
    /**
     Returns an editable proxy of the object with the specified `NSManagedObjectID`. This method should not be used after the `-commitAndWait` method was already called once.
     
     - parameter into: a `CSInto` clause specifying the entity type
     - parameter objectID: the `NSManagedObjectID` for the object to be edited
     - returns: an editable proxy for the specified `NSManagedObject`.
     */
    @objc
    @warn_unused_result
    public override func editInto(into: CSInto, objectID: NSManagedObjectID) -> NSManagedObject? {
        
        return self.swift.edit(into.swift, objectID)
    }
    
    /**
     Deletes a specified `NSManagedObject`. This method should not be used after the `-commitAndWait` method was already called once.
     
     - parameter object: the `NSManagedObject` type to be deleted
     */
    @objc
    public override func deleteObject(object: NSManagedObject?) {
        
        return self.swift.delete(object)
    }
    
    /**
     Deletes the specified `NSManagedObject`s.
     
     - parameter objects: the `NSManagedObject`s to be deleted
     */
    public override func deleteObjects(objects: [NSManagedObject]) {
        
        self.swift.delete(objects)
    }
    
    
    // MARK: CoreStoreBridge
    
    internal typealias SwiftType = SynchronousDataTransaction
    
    internal override var swift: SynchronousDataTransaction {
        
        return super.swift as! SynchronousDataTransaction
    }
    
    public required init(_ swiftObject: SynchronousDataTransaction) {
        
        super.init(swiftObject)
    }
    
    required public init(_ swiftObject: BaseDataTransaction) {
        
        fatalError("init has not been implemented")
    }
}


// MARK: - SynchronousDataTransaction

extension SynchronousDataTransaction {
    
    // MARK: CoreStoreBridgeable
    
    internal typealias ObjCType = CSSynchronousDataTransaction
}
