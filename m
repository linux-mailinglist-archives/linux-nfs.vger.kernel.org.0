Return-Path: <linux-nfs+bounces-11215-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A25FCA979E0
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 00:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6186188D63F
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Apr 2025 22:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7ED226C380;
	Tue, 22 Apr 2025 22:00:21 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2162701A1
	for <linux-nfs@vger.kernel.org>; Tue, 22 Apr 2025 22:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745359221; cv=none; b=RBSxTo7mbl8sHFKmcR80zuitw9FZOkMrPZ/XNs7kNu9Cz/tSQ11NL2LWqTCmgS9H5A2D2rqx1Ih9Rx/p2m/VWWA/zZj/l8rkhC/DZsnNfQkITrbLPJbLmolwS6BwVaJff+qhYqXlfJEariKsGfolISVyjB+4e3vA426Di/DbwkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745359221; c=relaxed/simple;
	bh=Qatgcbnt7BbL9J4M7FrMUwzjClIgz97BUSX6it++a3A=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=TUFZi3S36KdmqgtVq/M/t9akM01rkkzYjzZ3/CEkmb+v6/YddjaPXPfThtiFROKDbu5tpRi4sTuHZ35wxrtQ5lfw7bk2RPAsVnFZfYzxDZ5YL0LjhAA6BG71/Q82Sy+3x4l8RF6jnSyqnOAdCq4HiFXmW9NY4Xa5vCWKAGxxL2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1u7Lf4-0004sR-5k;
	Tue, 22 Apr 2025 22:00:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: trondmy@kernel.org
Cc: linux-nfs@vger.kernel.org, "Mike Snitzer" <snitzer@kernel.org>
Subject: Re: [PATCH] NFS/localio: Fix a race in nfs_local_open_fh()
In-reply-to: =?utf-8?q?=3C3d2d3ade569302f7d52307d71e0fe1c46fc95f32=2E1745261?=
 =?utf-8?q?446=2Egit=2Etrond=2Emyklebust=40hammerspace=2Ecom=3E?=
References: =?utf-8?q?=3C3d2d3ade569302f7d52307d71e0fe1c46fc95f32=2E17452614?=
 =?utf-8?q?46=2Egit=2Etrond=2Emyklebust=40hammerspace=2Ecom=3E?=
Date: Wed, 23 Apr 2025 08:00:13 +1000
Message-id: <174535921354.500591.6488717737987093498@noble.neil.brown.name>

On Tue, 22 Apr 2025, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> Once the clp->cl_uuid.lock has been dropped, another CPU could come in
> and free the struct nfsd_file that was just added. To prevent that from
> happening, take the RCU read lock before dropping the spin lock.

I think there is a race here but I think the better fix would be to use
nfs_local_file_get() to get an extra reference earlier.  That ensures we
won't lose the nfsd_file.

I'm working on a patch in this area which I hope to post soon.  It will
address this.

Thanks,
NeilBrown



>=20
> Fixes: 86e00412254a ("nfs: cache all open LOCALIO nfsd_file(s) in client")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/localio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> index 5c21caeae075..4ec952f9f47d 100644
> --- a/fs/nfs/localio.c
> +++ b/fs/nfs/localio.c
> @@ -278,6 +278,7 @@ nfs_local_open_fh(struct nfs_client *clp, const struct =
cred *cred,
>  		new =3D __nfs_local_open_fh(clp, cred, fh, nfl, mode);
>  		if (IS_ERR(new))
>  			return NULL;
> +		rcu_read_lock();
>  		/* try to swap in the pointer */
>  		spin_lock(&clp->cl_uuid.lock);
>  		nf =3D rcu_dereference_protected(*pnf, 1);
> @@ -287,7 +288,6 @@ nfs_local_open_fh(struct nfs_client *clp, const struct =
cred *cred,
>  			rcu_assign_pointer(*pnf, nf);
>  		}
>  		spin_unlock(&clp->cl_uuid.lock);
> -		rcu_read_lock();
>  	}
>  	nf =3D nfs_local_file_get(nf);
>  	rcu_read_unlock();
> --=20
> 2.49.0
>=20
>=20
>=20


