Return-Path: <linux-nfs+bounces-13023-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A5AB0351E
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 06:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02A02177509
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 04:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392861519B4;
	Mon, 14 Jul 2025 04:19:39 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704836FC3
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 04:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752466779; cv=none; b=LoO8KZyC9IkAccP5K3A62pluIFp/ERuCK37p5Q2VJJ4saek+u8IvR6dZ7FVmg06PLXzTclj0e8mbrxqvnLRpd6rJhClRDGFRJvUfLDIZexc7SppbR8vm+aLim1Ir/bIcu5QV/U5b2fUEMOnyaOOS1nF/DtyRm8hEnn/jMWYRqmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752466779; c=relaxed/simple;
	bh=FZtcySGPvHMS3lhdM0C72lYHXHjo/zmgXXRb9Sb+hyk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=bah9zBQGU1l/TfMz8LWfNd37/7IPOxvwUMNpYamQdFFahAgoYmZNPdORvtn7oWQsxkVo/MBSiZP3iaT22X+c4Q43uGUnGs1OO6oBuVetA/vjrFwSiH7B5/BPdIe1/7GHHrvXx7jHnSh9+itNIyruWNh5iD9CYySSUJIfAMBzvvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ubAf6-001wff-Aa;
	Mon, 14 Jul 2025 04:19:34 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Mike Snitzer" <snitzer@kernel.org>
Cc: "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 linux-nfs@vger.kernel.org
Subject: Re: [for-6.16-final PATCH 8/9] nfs/localio: avoid bouncing LOCALIO if
 nfs_client_is_local()
In-reply-to: <20250714031359.10192-9-snitzer@kernel.org>
References: <20250714031359.10192-1-snitzer@kernel.org>,
 <20250714031359.10192-9-snitzer@kernel.org>
Date: Mon, 14 Jul 2025 14:19:33 +1000
Message-id: <175246677378.2234665.12729957094794033029@noble.neil.brown.name>

On Mon, 14 Jul 2025, Mike Snitzer wrote:
> From: Mike Snitzer <snitzer@hammerspace.com>
>=20
> Previously nfs_local_probe() was made to disable and then attempt to
> re-enable LOCALIO (via LOCALIO protocol handshake) if/when it was
> called and LOCALIO already enabled.
>=20
> Vague memory for _why_ this was the case is that this was useful
> if/when a local NFS server were to be restarted with a local NFS
> client connected to it.
>=20
> But as it happens this causes an absurd amount of LOCALIO flapping
> which has a side-effect of too much IO being needlessly sent to NFSD
> (using RPC over the loopback network interface).  This is the
> definition of "serious performance loss" (that negates the point of
> having LOCALIO).
>=20
> So remove this mis-optimization for re-enabling LOCALIO if/when an NFS
> server is restarted (which is an extremely rare thing to do).  Will
> revisit testing that scenario again but in the meantime this patch
> restores the full benefit of LOCALIO.
>=20
> Fixes: 56bcd0f07fdb ("nfs: implement client support for NFS_LOCALIO_PROGRAM=
")
> Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>

Reviewed-by: NeilBrown <neil@brown.name>

I cannot see any justification for probing if localio is currently
thought to be working.  If for some reason it doesn't work, then when we
notice that is a good time to disable - which it what this patch does.

However...

> ---
>  fs/nfs/localio.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> index a4bacd9a5052..e3ae003118cb 100644
> --- a/fs/nfs/localio.c
> +++ b/fs/nfs/localio.c
> @@ -180,10 +180,8 @@ static void nfs_local_probe(struct nfs_client *clp)
>  		return;
>  	}
> =20
> -	if (nfs_client_is_local(clp)) {
> -		/* If already enabled, disable and re-enable */
> -		nfs_localio_disable_client(clp);
> -	}
> +	if (nfs_client_is_local(clp))
> +		return;
> =20
>  	if (!nfs_uuid_begin(&clp->cl_uuid))
>  		return;
> @@ -241,7 +239,8 @@ __nfs_local_open_fh(struct nfs_client *clp, const struc=
t cred *cred,
>  		case -ENOMEM:
>  		case -ENXIO:
>  		case -ENOENT:
> -			/* Revalidate localio, will disable if unsupported */
> +			/* Revalidate localio */
> +			nfs_localio_disable_client(clp);
>  			nfs_local_probe(clp);

Shouldn't that be nfs_local_probe_async() ????  I wonder why that wasn't
changed in=20
  Commit 1ff4716f420b ("NFS: always probe for LOCALIO support asynchronously")

Thanks,
NeilBrown

