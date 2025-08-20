Return-Path: <linux-nfs+bounces-13808-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFC4B2E853
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 00:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D440E683EEE
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Aug 2025 22:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E622DC32B;
	Wed, 20 Aug 2025 22:47:48 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8DD2D24A8
	for <linux-nfs@vger.kernel.org>; Wed, 20 Aug 2025 22:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755730068; cv=none; b=qvyF5dER+P0lUIqMf41O5b3rgMgwXtmILE1v1dCoXGKH5VMAujafagbhXpSx/RD/3zcB7I0TQJyjyW1uTMjj6o3gezcvsD8a0U+pTt2psn3ruhpZqRys2iAXB8XzgpGrJugaWtByWHZN3WLJ74/AmUZnxjZ9PRVVrcT9ERkVB4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755730068; c=relaxed/simple;
	bh=bFrwpmy9beLfOJYBfTtajC+ywqwXFNZPBCnoHiQcays=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Q/qg6na3tUAA8Z5DUV6si+AI4A7Y6NfmAY18RNXdEdN654IkkEyEqr1EHZLkpNCVUjS3TOjPkdtW/Sd/YDP6ZLNYyMqBV5ULL1mzkkbp+W5D1G26Hkm8DRPHaulBjI1GHHY/Ay18PgZPKogAlMJWXLz0eJSyExMF7c0lOsNn1j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uoraf-006Vq5-LY;
	Wed, 20 Aug 2025 22:47:35 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Subject: Re: [PATCH v1 1/2] NFSD: Delay adding new entries to LRU
In-reply-to: <20250820142532.89623-2-cel@kernel.org>
References: <20250820142532.89623-1-cel@kernel.org>,
 <20250820142532.89623-2-cel@kernel.org>
Date: Thu, 21 Aug 2025 08:47:35 +1000
Message-id: <175573005510.2234665.16962394280504152867@noble.neil.brown.name>

On Thu, 21 Aug 2025, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Neil Brown observes:
> > I would not include RC_INPROG entries in the lru at all - they are
> > always ignored, and will be added when they are switched to
> > RCU_DONE.
>=20
> I also removed a stale comment.
>=20
> Suggested-by: NeilBrown <neil@brown.name>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfscache.c | 6 ------
>  1 file changed, 6 deletions(-)
>=20
> diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
> index ba9d326b3de6..6c06cf24b5c7 100644
> --- a/fs/nfsd/nfscache.c
> +++ b/fs/nfsd/nfscache.c
> @@ -237,10 +237,6 @@ void nfsd_reply_cache_shutdown(struct nfsd_net *nn)
> =20
>  }
> =20
> -/*
> - * Move cache entry to end of LRU list, and queue the cleaner to run if it=
's
> - * not already scheduled.
> - */
>  static void
>  lru_put_end(struct nfsd_drc_bucket *b, struct nfsd_cacherep *rp)
>  {
> @@ -453,8 +449,6 @@ nfsd_cache_insert(struct nfsd_drc_bucket *b, struct nfs=
d_cacherep *key,
>  				nn->longest_chain_cachesize,
>  				atomic_read(&nn->num_drc_entries));
>  	}
> -
> -	lru_put_end(b, ret);
>  	return ret;

A result of this change is that entries in the lru never have
    ->c_state =3D=3D RC_INPROG
They are always RC_DONE.

So this can be added to the patch:

--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -272,12 +272,6 @@ nfsd_prune_bucket_locked(struct nfsd_net *nn, struct nfs=
d_drc_bucket *b,
=20
 	/* The bucket LRU is ordered oldest-first. */
 	list_for_each_entry_safe(rp, tmp, &b->lru_head, c_lru) {
-		/*
-		 * Don't free entries attached to calls that are still
-		 * in-progress, but do keep scanning the list.
-		 */
-		if (rp->c_state =3D=3D RC_INPROG)
-			continue;
=20
 		if (atomic_read(&nn->num_drc_entries) <=3D nn->max_drc_entries &&
 		    time_before(expiry, rp->c_timestamp))


With that added:

Reviewed-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown


>  }
> =20
> --=20
> 2.50.0
>=20
>=20


