Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC902B7FD0
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Sep 2019 19:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389030AbfISRRf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Sep 2019 13:17:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60768 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388943AbfISRRf (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 19 Sep 2019 13:17:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EA27E300D219;
        Thu, 19 Sep 2019 17:17:34 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-116-173.phx2.redhat.com [10.3.116.173])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 03C1A60872;
        Thu, 19 Sep 2019 17:17:34 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id E42761201F1; Thu, 19 Sep 2019 13:17:30 -0400 (EDT)
Date:   Thu, 19 Sep 2019 13:17:30 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     NeilBrown <neilb@suse.de>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] nfsd: give out fewer session slots as limit
 approaches
Message-ID: <20190919171730.GB333@pick.fieldses.org>
References: <1506345704-9486-1-git-send-email-bfields@redhat.com>
 <1506345704-9486-3-git-send-email-bfields@redhat.com>
 <87d0fx9jph.fsf@notabene.neil.brown.name>
 <20190919162211.GA333@pick.fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919162211.GA333@pick.fieldses.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 19 Sep 2019 17:17:34 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Sep 19, 2019 at 12:22:11PM -0400, J. Bruce Fields wrote:
> Looking....  Oh, I overlooked this before:
> 
> 	https://tools.ietf.org/html/rfc5661#page-522
> 
> 	The server creates the session by recording the parameter values
> 	used (including whether the CREATE_SESSION4_FLAG_PERSIST flag is
> 	set and has been accepted by the server) and allocating space
> 	for the session reply cache (if there is not enough space, the
> 	server returns NFS4ERR_NOSPC).
> 
> So, slightly odd use of NOSPC, but that's the right error there.

Looking back some more... last year Manjunath Patil sent a patch that
fixed that and I somehow ignored the part where he actually cited that
spec language and said, no, ENOSPC isn't for that:

	https://lore.kernel.org/linux-nfs/20180622175416.GA7119@fieldses.org/

But, Trond seems to disagree with the spec here anyway:

	There are a range of errors which we may need to handle by
	destroying the session, and then creating a new one (mainly the
	ones where the client and server slot handling get out of sync).
	That's why returning NFS4ERR_NOSPC in response to CREATE_SESSION
	is unhelpful, and is why the only sane response by the client
	will be to treat is as a temporary error.

Other todo's from that thread:

	- The protocol allows us to recall existing slots from clients.
	  We can use that when we get close to the limit.  Trond wrote
	  patches to do that some time ago, though said he'd take a
	  different approach now:

		https://lore.kernel.org/linux-nfs/CAABAsM6vDOaudUZYWH23oGiWGqX5Bd1YbCDnL6L=pxzMXgZzaw@mail.gmail.com/

	- I seem to recall the client is asking for rather large slots.
	  It could be a careful look at the xdr code would show we don't
	  need as much?

	- Maybe we should just keep allowing small sessions (1 slot?)
	  even past the limit.  Worst case the subsequent kmalloc fails.

--b.

> 
> >  Also, I'd like to suggest that the '1/3' heuristic be change to 1/16.
> >  Assuming 30 slots get handed out normally (which my testing shows -
> >  about 2k each, with an upper limit of 64k):
> >    When 90 slots left, we hand out
> >     30 (now 60 left)
> >     20 (now 40 left)
> >     13 (now 27 left)
> >      9 (now 18 left)
> >      6 (now 12 left)
> >      4 (now 8 left)
> >      2 (now 6 left)
> >      2 (now 4 left)
> >      1
> >      1
> >      1
> >      1
> >  which is a rapid decline as clients are added.
> >  With 16, we hand out 30 at a time until 480 slots are left (30Meg)
> >  then: 30 28 26 24 23 21 20 19 18 6 15 15 14 13 12 11 10 10 9 9 8 8 7 7
> >     6 6 5 5 5 5 4 4 4 3 3 3 3 3 3 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1 1 1 1
> >     1 1
> >  slots per session
> > 
> >  Am I convincing?
> > 
> > To make it more concrete: this is what I'm thinking of.  Which bits do
> > you like?
> 
> Except for the error return, it looks good to me.
> 
> --b.
> 
> > 
> > Thanks,
> > NeilBrown
> > 
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 7857942c5ca6..5d11ceaee998 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -1573,11 +1573,15 @@ static u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs *ca)
> >  	total_avail = nfsd_drc_max_mem - nfsd_drc_mem_used;
> >  	avail = min((unsigned long)NFSD_MAX_MEM_PER_SESSION, total_avail);
> >  	/*
> > -	 * Never use more than a third of the remaining memory,
> > +	 * Never use more than a 1/16 of the remaining memory,
> >  	 * unless it's the only way to give this client a slot:
> >  	 */
> > -	avail = clamp_t(unsigned long, avail, slotsize, total_avail/3);
> > +	avail = clamp_t(unsigned long, avail, slotsize, total_avail/16);
> >  	num = min_t(int, num, avail / slotsize);
> > +	if (nfsd_drc_mem_used + num * slotsize > nfsd_drc_max_mem)
> > +		/* Completely out of space - sorry */
> > +		num = 0;
> > +
> >  	nfsd_drc_mem_used += num * slotsize;
> >  	spin_unlock(&nfsd_drc_lock);
> >  
> > @@ -3172,7 +3176,7 @@ static __be32 check_forechannel_attrs(struct nfsd4_channel_attrs *ca, struct nfs
> >  	 */
> >  	ca->maxreqs = nfsd4_get_drc_mem(ca);
> >  	if (!ca->maxreqs)
> > -		return nfserr_jukebox;
> > +		return nfserr_resource;
> >  
> >  	return nfs_ok;
> >  }
> 
> 

