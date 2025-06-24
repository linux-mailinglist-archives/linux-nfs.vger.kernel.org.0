Return-Path: <linux-nfs+bounces-12734-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4A3AE7229
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Jun 2025 00:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17AB01BC28CA
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Jun 2025 22:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977F878F2B;
	Tue, 24 Jun 2025 22:16:02 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215C5182BC;
	Tue, 24 Jun 2025 22:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750803362; cv=none; b=Xaf02rR+4AZcnHC32h0hqVgposCW7u29FhzanQtBFHRJNGz3nbp4nZ8YAAMu0KGlBOtKTtCOIUJFPhfdUn/q1LDIo/nwu9goct6C97y5iFdAjJJimlY6POtI8PcgiCFejs0ct844kHtnlSo61X+hBEGKHSQg8DOVA5aoN84IKPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750803362; c=relaxed/simple;
	bh=razYr1e3o6cY9CMOfpwypwB3zJ252AOYeEy9dtVsivA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=afRgWzfnnhVU6h9cn/0E9ht+e4nAapGudeDqKDpow1p7exPw0xO+bBuLiwAZ8yEs0D8hsbqR15HMCVTYERTIq5WYr4O5bsWW3gJ5kxO6BdeHUJnQ9w0R6FxLkAR8wDoRJyds2Kj5+EtP/CLK3EA2SS6RktUrbcfEcUG0YPRxIe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uUBvk-0043lo-Ug;
	Tue, 24 Jun 2025 22:15:52 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Su Hui" <suhui@nfschina.com>, jlayton@kernel.org, okorniev@redhat.com,
 Dai.Ngo@oracle.com, tom@talpey.com, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] nfsd: Using guard() to simplify nfsd_cache_lookup()
In-reply-to: <cecf4793-d737-4501-a306-0c5a74daaf30@oracle.com>
References: <>, <cecf4793-d737-4501-a306-0c5a74daaf30@oracle.com>
Date: Wed, 25 Jun 2025 08:15:51 +1000
Message-id: <175080335129.2280845.12285110458405652015@noble.neil.brown.name>

On Wed, 25 Jun 2025, Chuck Lever wrote:
> On 6/23/25 8:19 PM, NeilBrown wrote:
> > On Mon, 23 Jun 2025, Su Hui wrote:
> >> Using guard() to replace *unlock* label. guard() makes lock/unlock code
> >> more clear. Change the order of the code to let all lock code in the
> >> same scope. No functional changes.
> >=20
> > While I agree that this code could usefully be cleaned up and that you
> > have made some improvements, I think the use of guard() is a nearly
> > insignificant part of the change.  You could easily do exactly the same
> > patch without using guard() but having and explicit spin_unlock() before
> > the new return.  That doesn't mean you shouldn't use guard(), but it
> > does mean that the comment explaining the change could be more usefully
> > focused on the "Change the order ..." part, and maybe explain what that
> > is important.
> >=20
> > I actually think there is room for other changes which would make the
> > code even better:
> > - Change nfsd_prune_bucket_locked() to nfsd_prune_bucket().  Have it
> >   take the lock when needed, then drop it, then call
> >   nfsd_cacherep_dispose() - and return the count.
> > - change nfsd_cache_insert to also skip updating the chain length stats
> >   when it finds a match - in that case the "entries" isn't a chain
> >   length. So just  lru_put_end(), return.  Have it return NULL if
> >   no match was found
> > - after the found_entry label don't use nfsd_reply_cache_free_locked(),
> >   just free rp.  It has never been included in any rbtree or list, so it
> >   doesn't need to be removed.
> > - I'd be tempted to have nfsd_cache_insert() take the spinlock itself
> >   and call it under rcu_read_lock() - and use RCU to free the cached
> >   items.=20
> > - put the chunk of code after the found_entry label into a separate
> >   function and instead just return RC_REPLY (and maybe rename that
> >   RC_CACHED).  Then in nfsd_dispatch(), if RC_CACHED was returned, call
> >   that function that has the found_entry code.
> >=20
> > I think that would make the code a lot easier to follow.  Would you like
> > to have a go at that - I suspect it would be several patches - or shall
> > I do it?
>=20
> I'm going to counsel some caution.
>=20
> nfsd_cache_lookup() is a hot path. Source code readability, though
> important, is not the priority in this area.
>=20
> I'm happy to consider changes to this function, but the bottom line is
> patches need to be accompanied by data that show that proposed code
> modifications do not negatively impact performance. (Plus the usual
> test results that show no impact to correctness).
>=20
> That data might include:
> - flame graphs that show a decrease in CPU utilization
> - objdump output showing a smaller instruction cache footprint
>   and/or short instruction path lengths
> - perf results showing better memory bandwidth
> - perf results showing better branch prediction
> - lockstat results showing less contention and/or shorter hold
>   time on locks held in this path
>=20
> Macro benchmark results are also welcome: equal or lower latency for
> NFSv3 operations, and equal or higher I/O throughput.
>=20
> The benefit for the scoped_guard construct is that it might make it more
> difficult to add code that returns from this function with a lock held.
> However, so far that hasn't been an issue.
>=20
> Thus I'm not sure there's a lot of strong technical justification for
> modification of this code path. But, you might know of one -- if so,
> please make sure that appears in the patch descriptions.
>=20
> What is more interesting to me is trying out more sophisticated abstract
> data types for the DRC hashtable. rhashtable is one alternative; so is
> Maple tree, which is supposed to handle lookups with more memory
> bandwidth efficiency than walking a linked list.
>=20

While I generally like rhashtable there is an awkwardness.  It doesn't
guarantee that an insert will always succeed.  If you get lots of new
records that hash to the same value, it will start failing insert
requests until is hash re-hashed the table with a new seed.  This is
intended to defeat collision attacks.  That means we would need to drop
requests sometimes.  Maybe that is OK.  The DRC could be the target of
collision attacks so maybe we really do want to drop requests if
rhashtable refuses to store them.

I think the other area that could use improvement is pruning old entries.
I would not include RC_INPROG entries in the lru at all - they are
always ignored, and will be added when they are switched to RCU_DONE.
I'd generally like to prune less often in larger batches, but removing
each of the batch from the rbtree could hold the lock for longer than we
would like.  I wonder if we could have an 'old' and a 'new' rbtree and
when the 'old' gets too old or the 'new' get too full, we extract 'old',
move 'new' to 'old', and outside the spinlock we free all of the moved
'old'.

But if we switched to rhashtable, we probably wouldn't need an lru -
just walk the entire table occasionally - there would be little conflict
with concurrent lookups.

But as you say, measuring would be useful.  Hopefully the DRC lookup
would be small contribution to the total request time, so we would need
to measure just want happens in the code to compare different versions.

NeilBrown


> Anyway, have fun, get creative, and let's see what comes up.
>=20
>=20
> >> Signed-off-by: Su Hui <suhui@nfschina.com>
> >> ---
> >>  fs/nfsd/nfscache.c | 99 ++++++++++++++++++++++------------------------
> >>  1 file changed, 48 insertions(+), 51 deletions(-)
> >>
> >> diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
> >> index ba9d326b3de6..2d92adf3e6b0 100644
> >> --- a/fs/nfsd/nfscache.c
> >> +++ b/fs/nfsd/nfscache.c
> >> @@ -489,7 +489,7 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp, unsign=
ed int start,
> >> =20
> >>  	if (type =3D=3D RC_NOCACHE) {
> >>  		nfsd_stats_rc_nocache_inc(nn);
> >> -		goto out;
> >> +		return rtn;
> >>  	}
> >> =20
> >>  	csum =3D nfsd_cache_csum(&rqstp->rq_arg, start, len);
> >> @@ -500,64 +500,61 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp, unsi=
gned int start,
> >>  	 */
> >>  	rp =3D nfsd_cacherep_alloc(rqstp, csum, nn);
> >>  	if (!rp)
> >> -		goto out;
> >> +		return rtn;
> >> =20
> >>  	b =3D nfsd_cache_bucket_find(rqstp->rq_xid, nn);
> >> -	spin_lock(&b->cache_lock);
> >> -	found =3D nfsd_cache_insert(b, rp, nn);
> >> -	if (found !=3D rp)
> >> -		goto found_entry;
> >> -	*cacherep =3D rp;
> >> -	rp->c_state =3D RC_INPROG;
> >> -	nfsd_prune_bucket_locked(nn, b, 3, &dispose);
> >> -	spin_unlock(&b->cache_lock);
> >> +	scoped_guard(spinlock, &b->cache_lock) {
> >> +		found =3D nfsd_cache_insert(b, rp, nn);
> >> +		if (found =3D=3D rp) {
> >> +			*cacherep =3D rp;
> >> +			rp->c_state =3D RC_INPROG;
> >> +			nfsd_prune_bucket_locked(nn, b, 3, &dispose);
> >> +			goto out;
> >> +		}
> >> +		/* We found a matching entry which is either in progress or done. */
> >> +		nfsd_reply_cache_free_locked(NULL, rp, nn);
> >> +		nfsd_stats_rc_hits_inc(nn);
> >> +		rtn =3D RC_DROPIT;
> >> +		rp =3D found;
> >> +
> >> +		/* Request being processed */
> >> +		if (rp->c_state =3D=3D RC_INPROG)
> >> +			goto out_trace;
> >> +
> >> +		/* From the hall of fame of impractical attacks:
> >> +		 * Is this a user who tries to snoop on the cache?
> >> +		 */
> >> +		rtn =3D RC_DOIT;
> >> +		if (!test_bit(RQ_SECURE, &rqstp->rq_flags) && rp->c_secure)
> >> +			goto out_trace;
> >> =20
> >> +		/* Compose RPC reply header */
> >> +		switch (rp->c_type) {
> >> +		case RC_NOCACHE:
> >> +			break;
> >> +		case RC_REPLSTAT:
> >> +			xdr_stream_encode_be32(&rqstp->rq_res_stream, rp->c_replstat);
> >> +			rtn =3D RC_REPLY;
> >> +			break;
> >> +		case RC_REPLBUFF:
> >> +			if (!nfsd_cache_append(rqstp, &rp->c_replvec))
> >> +				return rtn; /* should not happen */
> >> +			rtn =3D RC_REPLY;
> >> +			break;
> >> +		default:
> >> +			WARN_ONCE(1, "nfsd: bad repcache type %d\n", rp->c_type);
> >> +		}
> >> +
> >> +out_trace:
> >> +		trace_nfsd_drc_found(nn, rqstp, rtn);
> >> +		return rtn;
> >> +	}
> >> +out:
> >>  	nfsd_cacherep_dispose(&dispose);
> >> =20
> >>  	nfsd_stats_rc_misses_inc(nn);
> >>  	atomic_inc(&nn->num_drc_entries);
> >>  	nfsd_stats_drc_mem_usage_add(nn, sizeof(*rp));
> >> -	goto out;
> >> -
> >> -found_entry:
> >> -	/* We found a matching entry which is either in progress or done. */
> >> -	nfsd_reply_cache_free_locked(NULL, rp, nn);
> >> -	nfsd_stats_rc_hits_inc(nn);
> >> -	rtn =3D RC_DROPIT;
> >> -	rp =3D found;
> >> -
> >> -	/* Request being processed */
> >> -	if (rp->c_state =3D=3D RC_INPROG)
> >> -		goto out_trace;
> >> -
> >> -	/* From the hall of fame of impractical attacks:
> >> -	 * Is this a user who tries to snoop on the cache? */
> >> -	rtn =3D RC_DOIT;
> >> -	if (!test_bit(RQ_SECURE, &rqstp->rq_flags) && rp->c_secure)
> >> -		goto out_trace;
> >> -
> >> -	/* Compose RPC reply header */
> >> -	switch (rp->c_type) {
> >> -	case RC_NOCACHE:
> >> -		break;
> >> -	case RC_REPLSTAT:
> >> -		xdr_stream_encode_be32(&rqstp->rq_res_stream, rp->c_replstat);
> >> -		rtn =3D RC_REPLY;
> >> -		break;
> >> -	case RC_REPLBUFF:
> >> -		if (!nfsd_cache_append(rqstp, &rp->c_replvec))
> >> -			goto out_unlock; /* should not happen */
> >> -		rtn =3D RC_REPLY;
> >> -		break;
> >> -	default:
> >> -		WARN_ONCE(1, "nfsd: bad repcache type %d\n", rp->c_type);
> >> -	}
> >> -
> >> -out_trace:
> >> -	trace_nfsd_drc_found(nn, rqstp, rtn);
> >> -out_unlock:
> >> -	spin_unlock(&b->cache_lock);
> >> -out:
> >>  	return rtn;
> >>  }
> >> =20
> >> --=20
> >> 2.30.2
> >>
> >>
> >=20
>=20
>=20
> --=20
> Chuck Lever
>=20


