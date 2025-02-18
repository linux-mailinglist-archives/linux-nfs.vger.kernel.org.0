Return-Path: <linux-nfs+bounces-10180-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E16BA3A957
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 21:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E77DC7A27E7
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 20:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109F52144CF;
	Tue, 18 Feb 2025 20:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czVagdTa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBB82144CC
	for <linux-nfs@vger.kernel.org>; Tue, 18 Feb 2025 20:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910439; cv=none; b=lhu5Bbt6PKwgIRjm4ftpOjkt7hDrp3PPuVHOU6xJoezWaLAjWbVWXx51z/aPPdh17gm9T6RfWSqCl1Sa50q8HwoOniDQrnuyu71niNnT2HO3AHtEw3tP/1Te2h1gAigKUPzuYME6hjoPT1FiIjm7jOTNg1QEW87O58Iz2LaWkrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910439; c=relaxed/simple;
	bh=tCH3qOzddToM7368OENl5+1wcTGhw4fxmBQKlwWi5Oo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dwCoL8KS4gfvcgoNfild3Ez+fqX67c6bwrYB3N44k7oYuBoeCWd8RCtKjzaebvNyjgFJPFJXsXnynpi/NvrDLCEVWnFVAbEVDYWmZMLYKbpdngV2X+14oLorV4/NOfd/q+1/j7nIA5Yixj2Zj4AWgIuMN21IOxRCVsjmfTrV9uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czVagdTa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D96C4CEE4;
	Tue, 18 Feb 2025 20:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910436;
	bh=tCH3qOzddToM7368OENl5+1wcTGhw4fxmBQKlwWi5Oo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=czVagdTaB4ifCnZ7wDlA82lfwbz42AIcFt0hmBW3KE1rrutE8+N/1A3KmMG7Jy1mh
	 Znl6mtgY9IzLUd9maG+F3/D3vg2+AaQiZML0MHrHzlzviTFXOQdswNB0a+gzXOB1rb
	 XJNfXjZuhX+d+IfbSEKbnZgi+5YHjRSuwzqpnaKmbxs+oq3cHXe5ZswakM9ucrambO
	 jU34snlZTQvUV4K5yMThlca8t3BJP9EExB26FB6yc0M+Z1Yhr4XVE7d0Jtl9nMhI/e
	 TWFVpzApDPI5yNqaKqKvisqtLnWJJkH0nmeLKWgXieUcPB92/GpqyZ+96fm4kzmGV+
	 DIEHpYEZT5LzA==
Message-ID: <873bd6625529442989754e38e27e23286505bcfe.camel@kernel.org>
Subject: Re: [PATCH v2 6/7] nfsd: filecache: don't repeatedly add/remove
 files on the lru list
From: Jeff Layton <jlayton@kernel.org>
To: cel@kernel.org, Neil Brown <neilb@suse.de>, Olga Kornievskaia	
 <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Date: Tue, 18 Feb 2025 15:27:14 -0500
In-Reply-To: <20250218153937.6125-7-cel@kernel.org>
References: <20250218153937.6125-1-cel@kernel.org>
	 <20250218153937.6125-7-cel@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-02-18 at 10:39 -0500, cel@kernel.org wrote:
> From: NeilBrown <neilb@suse.de>
>=20
> There is no need to remove a file from the lru every time we access it,
> and then add it back.  It is sufficient to set the REFERENCED flag every
> time we put the file.  The order in the lru of REFERENCED files is
> largely irrelevant as they will all be moved to the end.
>=20
> With this patch, files are added only when they are allocated (if
> want_gc) and they are removed only by the list_lru_(shrink_)walk
> callback or when forcibly removing a file.
>=20
> This should reduce contention on the list_lru spinlock(s) and reduce
> memory traffic a little.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/filecache.c | 47 ++++++++++++++++-----------------------------
>  1 file changed, 17 insertions(+), 30 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 0d621833a9f2..56935349f0e4 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -319,15 +319,14 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
>  		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
>  }
> =20
> -static bool nfsd_file_lru_add(struct nfsd_file *nf)
> +static void nfsd_file_lru_add(struct nfsd_file *nf)
>  {
> -	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> -	set_bit(NFSD_FILE_RECENT, &nf->nf_flags);
> -	if (list_lru_add_obj(&nfsd_file_lru, &nf->nf_lru)) {
> +	refcount_inc(&nf->nf_ref);
> +	if (list_lru_add_obj(&nfsd_file_lru, &nf->nf_lru))
>  		trace_nfsd_file_lru_add(nf);
> -		return true;
> -	}
> -	return false;
> +	else
> +		WARN_ON(1);
> +	nfsd_file_schedule_laundrette();
>  }
> =20
>  static bool nfsd_file_lru_remove(struct nfsd_file *nf)
> @@ -363,16 +362,10 @@ nfsd_file_put(struct nfsd_file *nf)
> =20
>  	if (test_bit(NFSD_FILE_GC, &nf->nf_flags) &&
>  	    test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> -		/*
> -		 * If this is the last reference (nf_ref =3D=3D 1), then try to
> -		 * transfer it to the LRU.
> -		 */
> -		if (refcount_dec_not_one(&nf->nf_ref))
> -			return;
> -
> -		if (nfsd_file_lru_add(nf))
> -			return;
> +		set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> +		set_bit(NFSD_FILE_RECENT, &nf->nf_flags);
>  	}
> +
>  	if (refcount_dec_and_test(&nf->nf_ref))
>  		nfsd_file_free(nf);
>  }
> @@ -516,13 +509,12 @@ nfsd_file_lru_cb(struct list_head *item, struct lis=
t_lru_one *lru,
>  	}
> =20
>  	/*
> -	 * Put the reference held on behalf of the LRU. If it wasn't the last
> -	 * one, then just remove it from the LRU and ignore it.
> +	 * Put the reference held on behalf of the LRU if it is the last
> +	 * reference, else rotate.
>  	 */
> -	if (!refcount_dec_and_test(&nf->nf_ref)) {
> +	if (!refcount_dec_if_one(&nf->nf_ref)) {
>  		trace_nfsd_file_gc_in_use(nf);
> -		list_lru_isolate(lru, &nf->nf_lru);
> -		return LRU_REMOVED;
> +		return LRU_ROTATE;
>  	}
> =20
>  	/* Refcount went to zero. Unhash it and queue it to the dispose list */
> @@ -1062,16 +1054,8 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struc=
t net *net,
>  	nf =3D nfsd_file_lookup_locked(net, current_cred(), inode, need, want_g=
c);
>  	rcu_read_unlock();
> =20
> -	if (nf) {
> -		/*
> -		 * If the nf is on the LRU then it holds an extra reference
> -		 * that must be put if it's removed. It had better not be
> -		 * the last one however, since we should hold another.
> -		 */
> -		if (nfsd_file_lru_remove(nf))
> -			refcount_dec(&nf->nf_ref);
> +	if (nf)
>  		goto wait_for_construction;
> -	}
> =20
>  	new =3D nfsd_file_alloc(net, inode, need, want_gc);
>  	if (!new) {
> @@ -1165,6 +1149,9 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct=
 net *net,
>  	 */
>  	if (status !=3D nfs_ok || inode->i_nlink =3D=3D 0)
>  		nfsd_file_unhash(nf);
> +	else if (want_gc)
> +		nfsd_file_lru_add(nf);
> +
>  	clear_and_wake_up_bit(NFSD_FILE_PENDING, &nf->nf_flags);
>  	if (status =3D=3D nfs_ok)
>  		goto out;

Reviewed-by: Jeff Layton <jlayton@kernel.org>

