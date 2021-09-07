Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6644024F5
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Sep 2021 10:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239550AbhIGIS2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Sep 2021 04:18:28 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33040 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbhIGIS1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Sep 2021 04:18:27 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2349221F35;
        Tue,  7 Sep 2021 08:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631002641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=//Mc6TE0EM9syx6GPAn0jwF2If72XRdM9daXKaK/WFc=;
        b=a2hIrrOXJoUL1yA0fSfj5j8UoDqEa6s2MMLNPh0UR4INF0q2Y+ImwARnRqIFVTzxOWKUIk
        HnDMnklLNnGSN3KMWXOzsjDTtUPMvrqgTm1Ou/sb8l85IPlDulaFs5GCj2e0zePCPtQxGY
        p8RzJcatUUE8S2UcgGqwTyaM+7ppFcs=
Received: from suse.com (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 770AFA3B8F;
        Tue,  7 Sep 2021 08:17:20 +0000 (UTC)
Date:   Tue, 7 Sep 2021 09:17:18 +0100
From:   Mel Gorman <mgorman@suse.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH] SUNRPC: use congestion_wait() in svc_alloc_args()
Message-ID: <20210907081718.GG3828@suse.com>
References: <163090344807.19339.10071205771966144716@noble.neil.brown.name>
 <848A6498-CFF3-4C66-AE83-959F8221E930@oracle.com>
 <YTZ4E0Zh6F/WSpy0@casper.infradead.org>
 <163096695999.2518.10383290668057550257@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <163096695999.2518.10383290668057550257@noble.neil.brown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Sep 07, 2021 at 08:22:39AM +1000, NeilBrown wrote:
> On Tue, 07 Sep 2021, Matthew Wilcox wrote:
> > On Mon, Sep 06, 2021 at 03:46:34PM +0000, Chuck Lever III wrote:
> > > Hi Neil-
> > > 
> > > > On Sep 6, 2021, at 12:44 AM, NeilBrown <neilb@suse.de> wrote:
> > > > 
> > > > 
> > > > Many places that need to wait before retrying a memory allocation use
> > > > congestion_wait().  xfs_buf_alloc_pages() is a good example which
> > > > follows a similar pattern to that in svc_alloc_args().
> > > > 
> > > > It make sense to do the same thing in svc_alloc_args(); This will allow
> > > > the allocation to be retried sooner if some backing device becomes
> > > > non-congested before the timeout.
> > 
> > It's adorable that you believe this is still true.
> 
> always happy to be called "adorable" !!
> 
> > 
> > https://lore.kernel.org/linux-mm/20191231125908.GD6788@bombadil.infradead.org/
> > 
> > 
> Interesting ...  a few filesystems call clear_bdi_congested(), but not
> enough to make a difference.
> 
> At least my patch won't make things worse.  And when (not if !!)
> congestion_wait() gets fixed, sunrpc will immediately benefit.
> 
> I suspect that "congestion_wait()" needs to be replaced by several
> different interfaces.
> 
> Some callers want to wait until memory might be available, which should
> be tracked entirely by MM, not by filesystems.
> Other caller are really only interested in their own bdi making progress
> and should be allowed to specify that bdi.
> 

For the available memory side, I believe the interface would involve a
waitqueue combined with something like struct capture_control except it
has a waitqueue, a zone, an order, a struct page pointer and a list_head
that is declared on stack. Reclaimers for that zone would check if there
are any such waiters and if so, add a page that has just being reclaimed
and wake the waiter.

That then would be more event driven than time driven which is usually
what mm is meant to do. Despite congestion_wait being known to be broken
for a long time, I don't recall anyone trying to actually fix it.

> And in general, it seems that that waits aren't really interested in
> congestion being eased, but in progress being made.
> 
> reclaim_progress_wait()
> bdi_progress_wait()
> 
> ??
> 
> Even if we just provided
> 
>  void reclaim_progress_wait(void)
>  {
>         schedule_timeout_uninterruptible(HZ/20);
>  }
> 

reclaim_progress_wait at least would clarify that it's waiting on a page
but ultimately, it shouldn't be time based.

-- 
Mel Gorman
SUSE Labs
