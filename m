Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 189C3B80F7
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Sep 2019 20:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388051AbfISSlk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Sep 2019 14:41:40 -0400
Received: from fieldses.org ([173.255.197.46]:52098 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732532AbfISSlj (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 19 Sep 2019 14:41:39 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 790741506; Thu, 19 Sep 2019 14:41:39 -0400 (EDT)
Date:   Thu, 19 Sep 2019 14:41:39 -0400
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     NeilBrown <neilb@suse.de>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] nfsd: give out fewer session slots as limit
 approaches
Message-ID: <20190919184139.GG26654@fieldses.org>
References: <1506345704-9486-1-git-send-email-bfields@redhat.com>
 <1506345704-9486-3-git-send-email-bfields@redhat.com>
 <87d0fx9jph.fsf@notabene.neil.brown.name>
 <20190919162211.GA333@pick.fieldses.org>
 <20190919171730.GB333@pick.fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919171730.GB333@pick.fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Sep 19, 2019 at 01:17:30PM -0400, J. Bruce Fields wrote:
> 	- Maybe we should just keep allowing small sessions (1 slot?)
> 	  even past the limit.  Worst case the subsequent kmalloc fails.

So to be clear, I think that's what I'd do for now instead of trying to
find a better error return.

And probably put the 1/3->1/16 change in a separate patch.

--b.

> 
> --b.
> 
> > 
> > >  Also, I'd like to suggest that the '1/3' heuristic be change to 1/16.
> > >  Assuming 30 slots get handed out normally (which my testing shows -
> > >  about 2k each, with an upper limit of 64k):
> > >    When 90 slots left, we hand out
> > >     30 (now 60 left)
> > >     20 (now 40 left)
> > >     13 (now 27 left)
> > >      9 (now 18 left)
> > >      6 (now 12 left)
> > >      4 (now 8 left)
> > >      2 (now 6 left)
> > >      2 (now 4 left)
> > >      1
> > >      1
> > >      1
> > >      1
> > >  which is a rapid decline as clients are added.
> > >  With 16, we hand out 30 at a time until 480 slots are left (30Meg)
> > >  then: 30 28 26 24 23 21 20 19 18 6 15 15 14 13 12 11 10 10 9 9 8 8 7 7
> > >     6 6 5 5 5 5 4 4 4 3 3 3 3 3 3 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1 1 1 1
> > >     1 1
> > >  slots per session
> > > 
> > >  Am I convincing?
> > > 
> > > To make it more concrete: this is what I'm thinking of.  Which bits do
> > > you like?
> > 
> > Except for the error return, it looks good to me.
> > 
> > --b.
> > 
> > > 
> > > Thanks,
> > > NeilBrown
> > > 
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index 7857942c5ca6..5d11ceaee998 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -1573,11 +1573,15 @@ static u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs *ca)
> > >  	total_avail = nfsd_drc_max_mem - nfsd_drc_mem_used;
> > >  	avail = min((unsigned long)NFSD_MAX_MEM_PER_SESSION, total_avail);
> > >  	/*
> > > -	 * Never use more than a third of the remaining memory,
> > > +	 * Never use more than a 1/16 of the remaining memory,
> > >  	 * unless it's the only way to give this client a slot:
> > >  	 */
> > > -	avail = clamp_t(unsigned long, avail, slotsize, total_avail/3);
> > > +	avail = clamp_t(unsigned long, avail, slotsize, total_avail/16);
> > >  	num = min_t(int, num, avail / slotsize);
> > > +	if (nfsd_drc_mem_used + num * slotsize > nfsd_drc_max_mem)
> > > +		/* Completely out of space - sorry */
> > > +		num = 0;
> > > +
> > >  	nfsd_drc_mem_used += num * slotsize;
> > >  	spin_unlock(&nfsd_drc_lock);
> > >  
> > > @@ -3172,7 +3176,7 @@ static __be32 check_forechannel_attrs(struct nfsd4_channel_attrs *ca, struct nfs
> > >  	 */
> > >  	ca->maxreqs = nfsd4_get_drc_mem(ca);
> > >  	if (!ca->maxreqs)
> > > -		return nfserr_jukebox;
> > > +		return nfserr_resource;
> > >  
> > >  	return nfs_ok;
> > >  }
> > 
> > 
