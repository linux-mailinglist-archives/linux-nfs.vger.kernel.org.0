Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1FC1B95A8
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2019 18:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbfITQ2W (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Sep 2019 12:28:22 -0400
Received: from fieldses.org ([173.255.197.46]:53552 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727833AbfITQ2W (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 20 Sep 2019 12:28:22 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 922BC1506; Fri, 20 Sep 2019 12:28:21 -0400 (EDT)
Date:   Fri, 20 Sep 2019 12:28:21 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.de>
Cc:     "J. Bruce Fields" <bfields@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2 - vers2] nfsd: handle drc over-allocation gracefully.
Message-ID: <20190920162821.GG13260@fieldses.org>
References: <1506345704-9486-1-git-send-email-bfields@redhat.com>
 <1506345704-9486-3-git-send-email-bfields@redhat.com>
 <87d0fx9jph.fsf@notabene.neil.brown.name>
 <20190919162211.GA333@pick.fieldses.org>
 <20190919171730.GB333@pick.fieldses.org>
 <20190919184139.GG26654@fieldses.org>
 <877e63a3yg.fsf@notabene.neil.brown.name>
 <8736gra34j.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8736gra34j.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Sep 20, 2019 at 04:33:16PM +1000, NeilBrown wrote:
> 
> Currently, if there are more clients than allowed for by the
> space allocation in set_max_drc(), we fail a SESSION_CREATE
> request with NFS4ERR_DELAY.
> This means that the client retries indefinitely, which isn't
> a user-friendly response.
> 
> The RFC requires NFS4ERR_NOSPC, but that would at best result in a
> clean failure on the client, which is not much more friendly.
> 
> The current space allocation is a best-guess and doesn't provide any
> guarantees, we could still run out of space when trying to allocate
> drc space.
> 
> So fail more gracefully - always give out at least one slot.
> If all clients used all the space in all slots, we might start getting
> memory pressure, but that is possible anyway.
> 
> So ensure 'num' is always at least 1, and remove the test for it
> being zero.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4state.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> Sorry, but I was confused about clamp_t().
> If the 'max' is smaller than the 'min', then the 'max' wins, so
> 'avail' will never be more than total_avail/3.
> I might have believed the comment here instead of the code there.
> 
> So the current code cannot overflow, but I think we agree that
> failure is not good.  So this patch avoids failure.

Ah, got it, looks good.  Applying for 5.4.

--b.

> NeilBrown
> 
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 7857942c5ca6..084a30d77359 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1570,14 +1570,25 @@ static u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs *ca)
>  	unsigned long avail, total_avail;
>  
>  	spin_lock(&nfsd_drc_lock);
> -	total_avail = nfsd_drc_max_mem - nfsd_drc_mem_used;
> +	if (nfsd_drc_max_mem > nfsd_drc_mem_used)
> +		total_avail = nfsd_drc_max_mem - nfsd_drc_mem_used;
> +	else
> +		/* We have handed out more space than we chose in
> +		 * set_max_drc() to allow.  That isn't really a
> +		 * problem as long as that doesn't make us thing we
> +		 * have lots more due to integer overflow.
> +		 */
> +		total_avail = 0;
>  	avail = min((unsigned long)NFSD_MAX_MEM_PER_SESSION, total_avail);
>  	/*
>  	 * Never use more than a third of the remaining memory,
> -	 * unless it's the only way to give this client a slot:
> +	 * unless it's the only way to give this client a slot.
> +	 * Give the client one slot even that would require
> +	 * over-allocation, it is better than failure.
>  	 */
>  	avail = clamp_t(unsigned long, avail, slotsize, total_avail/3);
>  	num = min_t(int, num, avail / slotsize);
> +	num = max_t(int, num, 1);
>  	nfsd_drc_mem_used += num * slotsize;
>  	spin_unlock(&nfsd_drc_lock);
>  
> @@ -3169,10 +3180,10 @@ static __be32 check_forechannel_attrs(struct nfsd4_channel_attrs *ca, struct nfs
>  	 * performance.  When short on memory we therefore prefer to
>  	 * decrease number of slots instead of their size.  Clients that
>  	 * request larger slots than they need will get poor results:
> +	 * Note that we always allow at least one slot, because our
> +	 * accounting is soft and provides no guarantees either way.
>  	 */
>  	ca->maxreqs = nfsd4_get_drc_mem(ca);
> -	if (!ca->maxreqs)
> -		return nfserr_jukebox;
>  
>  	return nfs_ok;
>  }
> -- 
> 2.23.0
> 


