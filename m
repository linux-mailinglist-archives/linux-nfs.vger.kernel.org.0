Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B553B7EF9
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Sep 2019 18:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403840AbfISQWS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Sep 2019 12:22:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42628 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403833AbfISQWS (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 19 Sep 2019 12:22:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5F20A3082137;
        Thu, 19 Sep 2019 16:22:17 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-116-173.phx2.redhat.com [10.3.116.173])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D9CBE5D9CC;
        Thu, 19 Sep 2019 16:22:16 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 2955E1201F1; Thu, 19 Sep 2019 12:22:11 -0400 (EDT)
Date:   Thu, 19 Sep 2019 12:22:11 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     NeilBrown <neilb@suse.de>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] nfsd: give out fewer session slots as limit
 approaches
Message-ID: <20190919162211.GA333@pick.fieldses.org>
References: <1506345704-9486-1-git-send-email-bfields@redhat.com>
 <1506345704-9486-3-git-send-email-bfields@redhat.com>
 <87d0fx9jph.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0fx9jph.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 19 Sep 2019 16:22:17 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Sep 19, 2019 at 11:08:10AM +1000, NeilBrown wrote:
> On Mon, Sep 25 2017, J. Bruce Fields wrote:
> 
> > From: "J. Bruce Fields" <bfields@redhat.com>
> >
> > Instead of granting client's full requests until we hit our DRC size
> > limit and then failing CREATE_SESSIONs (and hence mounts) completely,
> > start granting clients smaller slot tables as we approach the limit.
> >
> > The factor chosen here is pretty much arbitrary.
> 
> Hi Bruce....
>  I've been looking at this patch - and the various add-ons that fix it :-(

It's got to be some kind of record.  Sorry....

>  There seems to be another problem though.
>  Prior to this patch, avail would never exceed
>     nfsd_drc_max_mem - nfsd_drc_mem_used
>  since this patch, avail will never be less than slotsize, so it could
>  exceed the above.
>  This means that 'num' will never be less than 1 (i.e. never zero).
>  num * slotsize might exceed
>     nfsd_drc_max_mem - nfsd_drc_mem_used
>  and then nfsd_drc_mem_used would exceed nfsd_drc_max_mem
> 
>  When that happens, the next call to nfsd4_get_drc_mem() will evaluate
> 
> 	total_avail = nfsd_drc_max_mem - nfsd_drc_mem_used;
> 
>  which will be very large (unsigned long) indeed.  Maybe not the intention.

That all sounds correct.

>  I would have sent a patch to fix this, except that it bothers me that
>  nfsd4_get_drc_mem() could ever return 0 (it cannot at the moment, but
>  would after a "fix").  That would result in check_forechannel_attrs()
>  returning nfserr_jukebox, and the client retrying indefinitely (which
>  is exactly the symptom I have reported by a customer with a 4.12
>  kernel).
>  This isn't nice behaviour.
> 
>  Given that the server makes no attempt to reclaim slot memory for
>  clients, would NFS4ERR_RESOURCE be a better error here?

NFSv4 is confusing here: RESOURCE seems like it should be the right
error for this kind of thing, but it was actually just mean to be for
compounds that are too complicated in some way.  And since NFSv4.1
(which added negotiated limits on compounds), it's not supposed to be
used at all.

Looking....  Oh, I overlooked this before:

	https://tools.ietf.org/html/rfc5661#page-522

	The server creates the session by recording the parameter values
	used (including whether the CREATE_SESSION4_FLAG_PERSIST flag is
	set and has been accepted by the server) and allocating space
	for the session reply cache (if there is not enough space, the
	server returns NFS4ERR_NOSPC).

So, slightly odd use of NOSPC, but that's the right error there.

>  Also, I'd like to suggest that the '1/3' heuristic be change to 1/16.
>  Assuming 30 slots get handed out normally (which my testing shows -
>  about 2k each, with an upper limit of 64k):
>    When 90 slots left, we hand out
>     30 (now 60 left)
>     20 (now 40 left)
>     13 (now 27 left)
>      9 (now 18 left)
>      6 (now 12 left)
>      4 (now 8 left)
>      2 (now 6 left)
>      2 (now 4 left)
>      1
>      1
>      1
>      1
>  which is a rapid decline as clients are added.
>  With 16, we hand out 30 at a time until 480 slots are left (30Meg)
>  then: 30 28 26 24 23 21 20 19 18 6 15 15 14 13 12 11 10 10 9 9 8 8 7 7
>     6 6 5 5 5 5 4 4 4 3 3 3 3 3 3 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1 1 1 1
>     1 1
>  slots per session
> 
>  Am I convincing?
> 
> To make it more concrete: this is what I'm thinking of.  Which bits do
> you like?

Except for the error return, it looks good to me.

--b.

> 
> Thanks,
> NeilBrown
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 7857942c5ca6..5d11ceaee998 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1573,11 +1573,15 @@ static u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs *ca)
>  	total_avail = nfsd_drc_max_mem - nfsd_drc_mem_used;
>  	avail = min((unsigned long)NFSD_MAX_MEM_PER_SESSION, total_avail);
>  	/*
> -	 * Never use more than a third of the remaining memory,
> +	 * Never use more than a 1/16 of the remaining memory,
>  	 * unless it's the only way to give this client a slot:
>  	 */
> -	avail = clamp_t(unsigned long, avail, slotsize, total_avail/3);
> +	avail = clamp_t(unsigned long, avail, slotsize, total_avail/16);
>  	num = min_t(int, num, avail / slotsize);
> +	if (nfsd_drc_mem_used + num * slotsize > nfsd_drc_max_mem)
> +		/* Completely out of space - sorry */
> +		num = 0;
> +
>  	nfsd_drc_mem_used += num * slotsize;
>  	spin_unlock(&nfsd_drc_lock);
>  
> @@ -3172,7 +3176,7 @@ static __be32 check_forechannel_attrs(struct nfsd4_channel_attrs *ca, struct nfs
>  	 */
>  	ca->maxreqs = nfsd4_get_drc_mem(ca);
>  	if (!ca->maxreqs)
> -		return nfserr_jukebox;
> +		return nfserr_resource;
>  
>  	return nfs_ok;
>  }


