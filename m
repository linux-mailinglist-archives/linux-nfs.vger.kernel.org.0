Return-Path: <linux-nfs+bounces-13096-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C009B06B29
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 03:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F8A3A43BF
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 01:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C45155C88;
	Wed, 16 Jul 2025 01:31:32 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9BC2F50
	for <linux-nfs@vger.kernel.org>; Wed, 16 Jul 2025 01:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752629492; cv=none; b=VXWvpXSj0XGtke4eSCtAsrRN1y4CO3z+0iSjELpJHusEZQEOLMsSZLBI6ZEIzg0nq3FnRSrPSHOIycTbd32hbuBQREF2V5mJkOYCEwr5PUQiyIkiwG9o4DrBFYc0SzFVGW99hT+gp4j+aLcVsBRNC5Wi9CjD6wMGZPNq0x3jKqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752629492; c=relaxed/simple;
	bh=5XbMs7gYm3SYo+s9tIushJXSOC80ucJZyGysRt8ksKw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=EwZaRcgVDCDNfwNqHQcaXkmANT+ofKwfQzCodHZYdDX0dJ8HPz7MvAeNd9G+ZDTG9eEef0yWCqGybMUk/cTve8k7D1IQuTJqxraLbKiXeQ8LPRRX3ULOAi01vUPyoe7OPZGwWqlj1Hycm4KVTsc4Cb9u52VTDGRjIwW0N+1wQsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ubqzW-002APQ-Oh;
	Wed, 16 Jul 2025 01:31:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Trond Myklebust" <trondmy@kernel.org>
Cc: "Anna Schumaker" <anna.schumaker@oracle.com>,
 "Mike Snitzer" <snitzer@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 3/3] NFS/localio: nfs_uuid_put() fix the wake up after
 unlinking the file
In-reply-to: =?utf-8?q?=3C2d9b6631ff2256320208250fbec9bc6e0918377e=2E1752618?=
 =?utf-8?q?161=2Egit=2Etrond=2Emyklebust=40hammerspace=2Ecom=3E?=
References: <cover.1752618161.git.trond.myklebust@hammerspace.com>, 
 =?utf-8?q?=3C2d9b6631ff2256320208250fbec9bc6e0918377e=2E1752618161=2Egit=2E?=
 =?utf-8?q?trond=2Emyklebust=40hammerspace=2Ecom=3E?=
Date: Wed, 16 Jul 2025 11:31:28 +1000
Message-id: <175262948827.2234665.1891349021754495573@noble.neil.brown.name>

On Wed, 16 Jul 2025, Trond Myklebust wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> After setting nfl->nfs_uuid to NULL, dereferences of nfl should be
> avoided, since there are no further guarantees that the memory is still
> allocated.

nfl is not being dereferenced here.  The difference between using "nfl"
and "&nfl->nfs_uuid" as the event variable is simply some address
arithmetic.  As long as both are the same it doesn't matter which is
used.


> Also change the wake_up_var_locked() to be a regular wake_up_var(),
> since nfs_close_local_fh() cannot retake the nfs_uuid->lock after
> dropping it.

The point of wake_up_var_locked() is to document why wake_up_var() is
safe.  In general you need a barrier between an assignment and a
wake_up_var().  I would like to eventually remove all wake_up_var()
calls, replacing them with other calls which document why the wakeup is
safe (e.g.  store_release_wake_up(), atomic_dec_and_wake_up()).  In this
case it is safe because both the waker and the waiter hold the same
spinlock.  I would like that documentation to remain.

Also the change from RCU_INIT_POINTER() to rcu_assign_pointer() is not
documented and not needed.  The primary purpose of rcu_assign_pointer()
is to include a barer so that anything that the new value points to will
be visible to a concurrent reader that uses rcu_dereference_pointer().
As NULL doesn't point to anything, no possible barrier is needed and
RCU_INIT_POINTER() is the correct interface to use.

So I think this patch is unnecessary and while it doesn't change
behaviour in any important way, it does make the intention of the code a
little less clear.

Thanks,
NeilBrown


>=20
> Acked-by: Mike Snitzer <snitzer@kernel.org>
> Tested-by: Mike Snitzer <snitzer@kernel.org>
> Fixes: 21fb44034695 ("nfs_localio: protect race between nfs_uuid_put() and =
nfs_close_local_fh()")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs_common/nfslocalio.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
> index d157fdc068d7..27ad5263e400 100644
> --- a/fs/nfs_common/nfslocalio.c
> +++ b/fs/nfs_common/nfslocalio.c
> @@ -199,8 +199,8 @@ static bool nfs_uuid_put(nfs_uuid_t *nfs_uuid)
>  		/* Now we can allow racing nfs_close_local_fh() to
>  		 * skip the locking.
>  		 */
> -		RCU_INIT_POINTER(nfl->nfs_uuid, NULL);
> -		wake_up_var_locked(&nfl->nfs_uuid, &nfs_uuid->lock);
> +		rcu_assign_pointer(nfl->nfs_uuid, NULL);
> +		wake_up_var(nfl);
>  	}
> =20
>  	/* Remove client from nn->local_clients */
> @@ -321,8 +321,7 @@ void nfs_close_local_fh(struct nfs_file_localio *nfl)
>  		 */
>  		spin_unlock(&nfs_uuid->lock);
>  		rcu_read_unlock();
> -		wait_var_event(&nfl->nfs_uuid,
> -			       rcu_access_pointer(nfl->nfs_uuid) =3D=3D NULL);
> +		wait_var_event(nfl, rcu_access_pointer(nfl->nfs_uuid) =3D=3D NULL);
>  		return;
>  	}
>  	/* tell nfs_uuid_put() to wait for us */
> --=20
> 2.50.1
>=20
>=20


