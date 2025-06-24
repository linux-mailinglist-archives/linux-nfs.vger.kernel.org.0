Return-Path: <linux-nfs+bounces-12678-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC1BAE587A
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Jun 2025 02:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 777151B64A5A
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Jun 2025 00:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25DC1DA21;
	Tue, 24 Jun 2025 00:19:27 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AACA2D;
	Tue, 24 Jun 2025 00:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750724367; cv=none; b=YPA6eTdybKNtfd4w6UwUUuXMhJBMXWrSAXjtR2ad1QHKp4NnGNYGEneGLWS+GMesL1WhzBvH1Fqr1RvmY5z7wpW5r+lmge02fswYLbaYN+UCBi5aOW9UF8xjQy07pMu21ASYH6HsmUYwv8eDloppbTxaTTJqZxGXKRiq+XQ5FQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750724367; c=relaxed/simple;
	bh=PavnqtiwB/fsXssZwmJ6jM960QXao6ToQorgMfbx6B8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=RTLCx9tVGU/f2zW7gWAdgfcqJBnde5aN91HcW8Gu3AcDDt+kbxt2nrys04z5m+A1cfSOD8lASouH0LMoEF5Pmq9tH6NkoGJ+LwfJSm5RYTRIMVHLVgtZxf2AUmZOxVnrKlvczEAVPaxtRIIfGGn57oMpm9hFj1sktYeyspANsV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uTrNf-003YDs-0I;
	Tue, 24 Jun 2025 00:19:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Su Hui" <suhui@nfschina.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, okorniev@redhat.com,
 Dai.Ngo@oracle.com, tom@talpey.com, "Su Hui" <suhui@nfschina.com>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] nfsd: Using guard() to simplify nfsd_cache_lookup()
In-reply-to: <20250623122226.3720564-1-suhui@nfschina.com>
References: <20250623122226.3720564-1-suhui@nfschina.com>
Date: Tue, 24 Jun 2025 10:19:16 +1000
Message-id: <175072435698.2280845.12079422273351211469@noble.neil.brown.name>

On Mon, 23 Jun 2025, Su Hui wrote:
> Using guard() to replace *unlock* label. guard() makes lock/unlock code
> more clear. Change the order of the code to let all lock code in the
> same scope. No functional changes.

While I agree that this code could usefully be cleaned up and that you
have made some improvements, I think the use of guard() is a nearly
insignificant part of the change.  You could easily do exactly the same
patch without using guard() but having and explicit spin_unlock() before
the new return.  That doesn't mean you shouldn't use guard(), but it
does mean that the comment explaining the change could be more usefully
focused on the "Change the order ..." part, and maybe explain what that
is important.

I actually think there is room for other changes which would make the
code even better:
- Change nfsd_prune_bucket_locked() to nfsd_prune_bucket().  Have it
  take the lock when needed, then drop it, then call
  nfsd_cacherep_dispose() - and return the count.
- change nfsd_cache_insert to also skip updating the chain length stats
  when it finds a match - in that case the "entries" isn't a chain
  length. So just  lru_put_end(), return.  Have it return NULL if
  no match was found
- after the found_entry label don't use nfsd_reply_cache_free_locked(),
  just free rp.  It has never been included in any rbtree or list, so it
  doesn't need to be removed.
- I'd be tempted to have nfsd_cache_insert() take the spinlock itself
  and call it under rcu_read_lock() - and use RCU to free the cached
  items.=20
- put the chunk of code after the found_entry label into a separate
  function and instead just return RC_REPLY (and maybe rename that
  RC_CACHED).  Then in nfsd_dispatch(), if RC_CACHED was returned, call
  that function that has the found_entry code.

I think that would make the code a lot easier to follow.  Would you like
to have a go at that - I suspect it would be several patches - or shall
I do it?

Thanks,
NeilBrown



>=20
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  fs/nfsd/nfscache.c | 99 ++++++++++++++++++++++------------------------
>  1 file changed, 48 insertions(+), 51 deletions(-)
>=20
> diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
> index ba9d326b3de6..2d92adf3e6b0 100644
> --- a/fs/nfsd/nfscache.c
> +++ b/fs/nfsd/nfscache.c
> @@ -489,7 +489,7 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp, unsigned =
int start,
> =20
>  	if (type =3D=3D RC_NOCACHE) {
>  		nfsd_stats_rc_nocache_inc(nn);
> -		goto out;
> +		return rtn;
>  	}
> =20
>  	csum =3D nfsd_cache_csum(&rqstp->rq_arg, start, len);
> @@ -500,64 +500,61 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp, unsigne=
d int start,
>  	 */
>  	rp =3D nfsd_cacherep_alloc(rqstp, csum, nn);
>  	if (!rp)
> -		goto out;
> +		return rtn;
> =20
>  	b =3D nfsd_cache_bucket_find(rqstp->rq_xid, nn);
> -	spin_lock(&b->cache_lock);
> -	found =3D nfsd_cache_insert(b, rp, nn);
> -	if (found !=3D rp)
> -		goto found_entry;
> -	*cacherep =3D rp;
> -	rp->c_state =3D RC_INPROG;
> -	nfsd_prune_bucket_locked(nn, b, 3, &dispose);
> -	spin_unlock(&b->cache_lock);
> +	scoped_guard(spinlock, &b->cache_lock) {
> +		found =3D nfsd_cache_insert(b, rp, nn);
> +		if (found =3D=3D rp) {
> +			*cacherep =3D rp;
> +			rp->c_state =3D RC_INPROG;
> +			nfsd_prune_bucket_locked(nn, b, 3, &dispose);
> +			goto out;
> +		}
> +		/* We found a matching entry which is either in progress or done. */
> +		nfsd_reply_cache_free_locked(NULL, rp, nn);
> +		nfsd_stats_rc_hits_inc(nn);
> +		rtn =3D RC_DROPIT;
> +		rp =3D found;
> +
> +		/* Request being processed */
> +		if (rp->c_state =3D=3D RC_INPROG)
> +			goto out_trace;
> +
> +		/* From the hall of fame of impractical attacks:
> +		 * Is this a user who tries to snoop on the cache?
> +		 */
> +		rtn =3D RC_DOIT;
> +		if (!test_bit(RQ_SECURE, &rqstp->rq_flags) && rp->c_secure)
> +			goto out_trace;
> =20
> +		/* Compose RPC reply header */
> +		switch (rp->c_type) {
> +		case RC_NOCACHE:
> +			break;
> +		case RC_REPLSTAT:
> +			xdr_stream_encode_be32(&rqstp->rq_res_stream, rp->c_replstat);
> +			rtn =3D RC_REPLY;
> +			break;
> +		case RC_REPLBUFF:
> +			if (!nfsd_cache_append(rqstp, &rp->c_replvec))
> +				return rtn; /* should not happen */
> +			rtn =3D RC_REPLY;
> +			break;
> +		default:
> +			WARN_ONCE(1, "nfsd: bad repcache type %d\n", rp->c_type);
> +		}
> +
> +out_trace:
> +		trace_nfsd_drc_found(nn, rqstp, rtn);
> +		return rtn;
> +	}
> +out:
>  	nfsd_cacherep_dispose(&dispose);
> =20
>  	nfsd_stats_rc_misses_inc(nn);
>  	atomic_inc(&nn->num_drc_entries);
>  	nfsd_stats_drc_mem_usage_add(nn, sizeof(*rp));
> -	goto out;
> -
> -found_entry:
> -	/* We found a matching entry which is either in progress or done. */
> -	nfsd_reply_cache_free_locked(NULL, rp, nn);
> -	nfsd_stats_rc_hits_inc(nn);
> -	rtn =3D RC_DROPIT;
> -	rp =3D found;
> -
> -	/* Request being processed */
> -	if (rp->c_state =3D=3D RC_INPROG)
> -		goto out_trace;
> -
> -	/* From the hall of fame of impractical attacks:
> -	 * Is this a user who tries to snoop on the cache? */
> -	rtn =3D RC_DOIT;
> -	if (!test_bit(RQ_SECURE, &rqstp->rq_flags) && rp->c_secure)
> -		goto out_trace;
> -
> -	/* Compose RPC reply header */
> -	switch (rp->c_type) {
> -	case RC_NOCACHE:
> -		break;
> -	case RC_REPLSTAT:
> -		xdr_stream_encode_be32(&rqstp->rq_res_stream, rp->c_replstat);
> -		rtn =3D RC_REPLY;
> -		break;
> -	case RC_REPLBUFF:
> -		if (!nfsd_cache_append(rqstp, &rp->c_replvec))
> -			goto out_unlock; /* should not happen */
> -		rtn =3D RC_REPLY;
> -		break;
> -	default:
> -		WARN_ONCE(1, "nfsd: bad repcache type %d\n", rp->c_type);
> -	}
> -
> -out_trace:
> -	trace_nfsd_drc_found(nn, rqstp, rtn);
> -out_unlock:
> -	spin_unlock(&b->cache_lock);
> -out:
>  	return rtn;
>  }
> =20
> --=20
> 2.30.2
>=20
>=20


