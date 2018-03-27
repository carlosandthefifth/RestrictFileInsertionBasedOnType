trigger FeedCommentTrigger on FeedComment (after insert) {
    
    List <FeedComment> Fs = trigger.new;
    List <ID> fcIds = new List <ID>();
    for (FeedComment fc : Fs) {
        fcIds.add(fc.FeedItemId);
    }
    
    List <FeedItem> Feeds = [SELECT ContentType from FeedItem where id in :fcIds];
    integer i = 0;
    for (FeedItem F : Feeds) {
        if (F.ContentType != 'PDF') Fs[i].AddError('not allowed');   
        i++;
    }

    
}