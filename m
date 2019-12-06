Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6530A1154CB
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2019 17:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfLFQCl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Dec 2019 11:02:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:59266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbfLFQCk (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 6 Dec 2019 11:02:40 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22B232173E;
        Fri,  6 Dec 2019 16:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575648159;
        bh=uN49J2KjPjCG2q1vrkZZhYout9vUnOgmq5AHuzL7OmY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dhBUf+ww+91PA7OIoUovoazx+Zee9VhrqKOW7tvxd09vcuMDCb5ZqA/Xh//Y8mUTG
         f8gBztw7LPmmF9Ptmm0dmheqcx1kCMIhpl7Rnx+bubZ6acaSfZrRnn8cc8pKCVsolB
         Q0ieCCicDMxk1sWnpr3m9eetaba0Ru77BQMujAis=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DB9F435206AB; Fri,  6 Dec 2019 08:02:38 -0800 (PST)
Date:   Fri, 6 Dec 2019 08:02:38 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     madhuparnabhowmik04@gmail.com
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        joel@joelfernandes.org, linux-nfs@vger.kernel.org,
        rcu@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: nfs: dir.c: Fix sparse error
Message-ID: <20191206160238.GE2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191206151640.10966-1-madhuparnabhowmik04@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206151640.10966-1-madhuparnabhowmik04@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Dec 06, 2019 at 08:46:40PM +0530, madhuparnabhowmik04@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> 
> This patch fixes the following errors:
> fs/nfs/dir.c:2353:14: error: incompatible types in comparison expression (different address spaces):
> fs/nfs/dir.c:2353:14:    struct list_head [noderef] <asn:4> *
> fs/nfs/dir.c:2353:14:    struct list_head *
> 
> caused due to directly accessing the prev pointer of
> a RCU protected list.
> Accessing the pointer using the macro list_prev_rcu() fixes this error.
> 
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> ---
>  fs/nfs/dir.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index e180033e35cf..2035254cc283 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -2350,7 +2350,7 @@ static int nfs_access_get_cached_rcu(struct inode *inode, const struct cred *cre
>  	rcu_read_lock();
>  	if (nfsi->cache_validity & NFS_INO_INVALID_ACCESS)
>  		goto out;
> -	lh = rcu_dereference(nfsi->access_cache_entry_lru.prev);
> +	lh = rcu_dereference(list_prev_rcu(&nfsi->access_cache_entry_lru));

And as noted in the earlier email, what is preventing concurrent
insertions into  and deletions from this list?

o	This use of list_move_tail() is OK because it does not poison.
	Though it isn't being all that friendly to lockless access to
	->prev -- no WRITE_ONCE() in list_move_tail().

o	The use of list_add_tail() is not safe with RCU readers, though
	they do at least partially compensate via use of smp_wmb()
	in nfs_access_add_cache() before calling nfs_access_add_rbtree().

o	The list_del() near the end of nfs_access_add_rbtree() will
	poison the ->prev pointer.  I don't see how this is safe given the
	possibility of a concurrent call to nfs_access_get_cached_rcu().

>  	cache = list_entry(lh, struct nfs_access_entry, lru);
>  	if (lh == &nfsi->access_cache_entry_lru ||
>  	    cred != cache->cred)

And a few lines below here, it really does dereference the pointer
obtained from ->prev!

So how to really fix this?  Here is one possibility, but we of course
need to get the NFS developers' and maintainers' thoughts:

o	Create a list that is safe for bidirectional RCU traversal.
	This can use list_head, and would need these functions,
	give or take the exact names:

	list_add_tail_rcuprev():  This is like list_add_tail_rcu(),
	but also has smp_store_release() for ->prev.  (As in there is
	also a __list_add_rcuprev() helper that actually contains the
	additional smp_store_release().)

	list_del_rcuprev():  This can be exactly __list_del_entry(),
	but with the assignment to ->prev in __list_del() becoming
	WRITE_ONCE().  And it looks like callers to __list_del_entry()
	and __list_del() might need some attention!  And these might
	result in additional users of *_rcuprev().

	list_prev_rcu() as in your first patch, but with READ_ONCE().
	Otherwise DEC Alpha can fail.  And more subtle compiler issues
	can appear on other architectures.

	Note that list_move_tail() will be OK give or take *_ONCE().
	It might be better to define a list_move_tail_rcuprev(), given
	the large number of users of list_move_tail() -- some of these
	users might not like even the possibility of added overhead due
	to volatile accesses.  ;-)

Or am I missing something subtle here?

							Thanx, Paul
