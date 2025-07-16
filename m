Return-Path: <linux-nfs+bounces-13095-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C98B06B11
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 03:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 610057AE851
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 01:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6409D42049;
	Wed, 16 Jul 2025 01:22:15 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01F12E3700
	for <linux-nfs@vger.kernel.org>; Wed, 16 Jul 2025 01:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752628935; cv=none; b=VIaSoOrnYBFOGRG0Sz99iL6sNex4p1C/QDiqQijCJ4hIXGxaca0BTLv6KU3uBJvpoIDT7xLZtaiN4esX/l21L4CAKUP5PkntfkVcE0Vir5ma6jI4inXYduu8L9g6VkVhfOre6UKw94vuBRKEqMdNrEnGfwe14iZUTPybBE52kII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752628935; c=relaxed/simple;
	bh=heK9lgY8ovgKLCtnHHTk9eOpJ+Ymhpfg+NuXqjoyw+k=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=BOMl5t1hbWXyHrvd7wCdyvWTrel+WqmGCDzZJM8yWb6TFB9Z+zCZ3ZgAgdBjVYDt/J5H41Xj3Z6REY2YQ/yrrvGbV/3w4h1Ng+/CRpR75R/pUwnATWOnjOW7z0ffHVnmWrF1wkCs+wRL6Tx5wmFDv0hkiyiFSqu4pVrim9s5Bfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ubqqW-002ANt-RU;
	Wed, 16 Jul 2025 01:22:10 +0000
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
Subject: Re: [PATCH 2/3] NFS/localio: nfs_uuid_put() fix the wait for file
 unlink events
In-reply-to: =?utf-8?q?=3C5d191a4f112055a6b79881a2dade9c0721f91830=2E1752618?=
 =?utf-8?q?161=2Egit=2Etrond=2Emyklebust=40hammerspace=2Ecom=3E?=
References: <cover.1752618161.git.trond.myklebust@hammerspace.com>, 
 =?utf-8?q?=3C5d191a4f112055a6b79881a2dade9c0721f91830=2E1752618161=2Egit=2E?=
 =?utf-8?q?trond=2Emyklebust=40hammerspace=2Ecom=3E?=
Date: Wed, 16 Jul 2025 11:22:10 +1000
Message-id: <175262893035.2234665.1735173020338594784@noble.neil.brown.name>

On Wed, 16 Jul 2025, Trond Myklebust wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> No reference to nfl is held when waiting in nfs_uuid_put(), so not only
> must the event condition check if the first entry in the list has
> changed, it must also check if the nfl->nfs_uuid field is still NULL,
> in case the old entry was replaced.

As no reference is held to nfl, it cannot be safe to check if
nfl->nfs_uuid is still NULL.  It could be freed and the memory reused
for anything.

At this point, with nfs_uuid->net set to NULL, nothing can be added to
nfs_uuid->files.  Things can only be removed.
So if list_first_entry_or_null stops being nfl, then we know that nfl
has been removed from the list and cannot possibly be added again.
This must have been done by nfs_close_local_fh() which set ->nfs_uuid to
NULL so that  nfs_uuid_put() decided to wait.

>=20
> Also change the event variable to be nfs_uuid, for the same reason that
> no reference is held to nfl.

The event variable is never dereferenced so we don't need to hold a
reference to it.  The address is hashed to choose a wait queue - that is
all it is used for.

So it is perfectly safe to wait on &nfl->nfs_uuid or to wake it up
without a reference to nfl.  All that matters is that the waker and the
waiter use the same address.

So I believe this patch is wrong.  The extra test on nfl->nfs_uuid is
incorrect and not needed.  The change to the event variable is not needed
except that they must both be the same (which is what my earlier patch
did).

Thanks,
NeilBrown


>=20
> Acked-by: Mike Snitzer <snitzer@kernel.org>
> Tested-by: Mike Snitzer <snitzer@kernel.org>
> Fixes: 21fb44034695 ("nfs_localio: protect race between nfs_uuid_put() and =
nfs_close_local_fh()")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs_common/nfslocalio.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
> index 64949c46c174..d157fdc068d7 100644
> --- a/fs/nfs_common/nfslocalio.c
> +++ b/fs/nfs_common/nfslocalio.c
> @@ -177,12 +177,13 @@ static bool nfs_uuid_put(nfs_uuid_t *nfs_uuid)
>  			/* nfs_close_local_fh() is doing the
>  			 * close and we must wait. until it unlinks
>  			 */
> -			wait_var_event_spinlock(nfl,
> -						list_first_entry_or_null(
> -							&nfs_uuid->files,
> -							struct nfs_file_localio,
> -							list) !=3D nfl,
> -						&nfs_uuid->lock);
> +			wait_var_event_spinlock(
> +				nfs_uuid,
> +				list_first_entry_or_null(
> +					&nfs_uuid->files,
> +					struct nfs_file_localio, list) !=3D nfl ||
> +					rcu_access_pointer(nfl->nfs_uuid),
> +				&nfs_uuid->lock);
>  			continue;
>  		}
> =20
> @@ -338,7 +339,7 @@ void nfs_close_local_fh(struct nfs_file_localio *nfl)
>  	 */
>  	spin_lock(&nfs_uuid->lock);
>  	list_del_init(&nfl->list);
> -	wake_up_var_locked(&nfl->nfs_uuid, &nfs_uuid->lock);
> +	wake_up_var_locked(nfs_uuid, &nfs_uuid->lock);
>  	spin_unlock(&nfs_uuid->lock);
>  }
>  EXPORT_SYMBOL_GPL(nfs_close_local_fh);
> --=20
> 2.50.1
>=20
>=20


