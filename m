Return-Path: <linux-nfs+bounces-13024-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E4CB03521
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 06:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53432176E36
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 04:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F08716FF37;
	Mon, 14 Jul 2025 04:23:31 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB0C6FC3
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 04:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752467011; cv=none; b=BNgFUGrIrdprNcGclwS0I2eIJO/F9Wew/f/idwy+3viuASOqER59wfSjr4aYQdQ+X3C8/2UmIXG9R7pdBXR2aoZozqX2903k/rAdcQwZ0W1jnO4Xj8Wu76Ez6BDDQX/NFDSDZsFaZBnR1NY5Fw2Bb5FBR6qm7uDu6c72gOl9x1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752467011; c=relaxed/simple;
	bh=WEJ9PMEb8stzHcdXhU10dI8+Y3sw2iHMwjLa+2E29k8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=YVRzAEfxejCU98P5kng9DJVkVSRRtW1x+HQbM24HE3N3XSFwUK7sToL7GNOlcbMWj00RpD8DdW226KjqfSr2vTNsM7jSZ3kHeaZO+BzqJntwN8Cd89Xgaiq9uJ422SNl5uuURCJWyJKqdnj6/rnUNGPEUFdqL1kL2sA2ztny7Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ubAiq-001wgY-Ql;
	Mon, 14 Jul 2025 04:23:26 +0000
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
Subject:
 Re: [for-6.16-final PATCH 9/9] nfs/localio: add localio_async_probe modparm
In-reply-to: <20250714031359.10192-10-snitzer@kernel.org>
References: <20250714031359.10192-1-snitzer@kernel.org>,
 <20250714031359.10192-10-snitzer@kernel.org>
Date: Mon, 14 Jul 2025 14:23:26 +1000
Message-id: <175246700631.2234665.18042187680516755344@noble.neil.brown.name>

On Mon, 14 Jul 2025, Mike Snitzer wrote:
> From: Mike Snitzer <snitzer@hammerspace.com>
>=20
> This knob influences the LOCALIO handshake so that it happens
> synchronously upon NFS client creation.. which reduces the window of
> opportunity for a bunch of IO to flood page cache and send out over to
> NFSD before LOCALIO handshake negotiates that the client and server
> are local.  The knob is:
>   echo N > /sys/module/nfs/parameters/localio_async_probe

I understand why you are adding this but ....  yuck.  Tuning knobs are
best avoided.

Maybe we could still do the probe async, but in mount wait for 200ms,
or for the probe to get a reply.   That should make everyone happy.

NeilBrown


>=20
> Fixes: 1ff4716f420b ("NFS: always probe for LOCALIO support asynchronously")
> Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
> ---
>  fs/nfs/localio.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> index e3ae003118cb..76ca9bd21d2e 100644
> --- a/fs/nfs/localio.c
> +++ b/fs/nfs/localio.c
> @@ -49,6 +49,11 @@ struct nfs_local_fsync_ctx {
>  static bool localio_enabled __read_mostly =3D true;
>  module_param(localio_enabled, bool, 0644);
> =20
> +static bool localio_async_probe __read_mostly =3D true;
> +module_param(localio_async_probe, bool, 0644);
> +MODULE_PARM_DESC(localio_async_probe,
> +		 "Probe for LOCALIO support asynchronously.");
> +
>  static bool localio_O_DIRECT_semantics __read_mostly =3D false;
>  module_param(localio_O_DIRECT_semantics, bool, 0644);
>  MODULE_PARM_DESC(localio_O_DIRECT_semantics,
> @@ -203,7 +208,10 @@ void nfs_local_probe_async_work(struct work_struct *wo=
rk)
> =20
>  void nfs_local_probe_async(struct nfs_client *clp)
>  {
> -	queue_work(nfsiod_workqueue, &clp->cl_local_probe_work);
> +	if (likely(localio_async_probe))
> +		queue_work(nfsiod_workqueue, &clp->cl_local_probe_work);
> +	else
> +		nfs_local_probe(clp);
>  }
>  EXPORT_SYMBOL_GPL(nfs_local_probe_async);
> =20
> --=20
> 2.44.0
>=20
>=20


