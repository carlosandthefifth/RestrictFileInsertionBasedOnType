trigger FeedTrigger on FeedItem (before insert, after insert) {
    
    List <FeedItem> FeedItems = trigger.new;
    if (trigger.IsBefore) {
        for (FeedItem F : FeedItems) {
            system.debug('Before - F.ContentType: ' + F.ContentType);
            List <ContentDocument> C = [SELECT id, FileType FROM ContentDocument where parentID = :F.id];
            system.debug('Before C.FileType: ' + C[0].FileType);
            if (C[0].FileType != 'PDF') F.AddError('not allowed');   
        }
    } else {
        for (FeedItem F : FeedItems) {
            system.debug('After - F.ContentType: ' + F.ContentType);
            if (F.ContentType != 'PDF') F.AddError('not allowed');   
        }
    }    
}