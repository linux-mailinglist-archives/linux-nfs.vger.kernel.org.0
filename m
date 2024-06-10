Return-Path: <linux-nfs+bounces-3626-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D56C902122
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jun 2024 14:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12BB41C2319C
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jun 2024 12:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7764AEC8;
	Mon, 10 Jun 2024 12:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIaIEckc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA90F1F171
	for <linux-nfs@vger.kernel.org>; Mon, 10 Jun 2024 12:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718020939; cv=none; b=TXUVeQa5sfar0Hp03KgWXyiZ+nBR7ji6Zv1UB3g58U50KZvTCUq0lz/o4jmjgZiTHqIeg2G+eGoJN1TECdW2b/IUyeO4Z4WLsLP8/fqtZc9+ktArFXtbyuGzf6SW9qTug/4pk70bh3x5IYePbay3JPyAOF/rxgd2bK4wUqowHlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718020939; c=relaxed/simple;
	bh=vnJbkO9vx2RQGshoJbS4fsOQs2c5ctQIdVywqPnmXPg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aAWK6uAjcdQT0kNv2yGABNQ3OdtWTHhcl3BnHOBxbTlyR5LnQTiuFVHrB3Z44jyTMvMFoeGn86Zb+D32PsCv/WN6OVy0gvaxD0C0jmoCbBi/X/PvYbv0vvXRcJJpflExgh5qXCyAYg+iqyWUsV6HAIzbbyeCpBuchnwEVBjnoTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIaIEckc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFB1C2BBFC;
	Mon, 10 Jun 2024 12:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718020939;
	bh=vnJbkO9vx2RQGshoJbS4fsOQs2c5ctQIdVywqPnmXPg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=SIaIEckc8JraqHmC9ZfXvs7vGW7iMm7seIbrnNj6It5oMuRdXh94+kJvOxc/HVNLl
	 E1Ujd8cA4nhQY2WzFGL1U4yIPsvhhfx8Chgr4ET/6X5qRbsIYk0F9MRdVK6zWU6BE/
	 W5kSUSIzXGgmxRC9OjtZxFfkhj/fw5PMQQ+Hor2bXafNowtcPBlAXbhJpf2J/pfijC
	 67siG4Yoi8TzbvM8LOzXwNByWeERWhRDihWZn6p/XkQE/i9IDglB7nlyh9yCXqLCd3
	 5WKVySy1m0rOKjT6HTqfBbqcY0LEXF1ZsoG9lyqgwWukpgPW/pRMnRUHSjTHCjSXd1
	 gU7RTiNuScPow==
Message-ID: <28ac0f056e15c57a3d45cc7155580eb4494afc04.camel@kernel.org>
Subject: Re: [for-6.11 PATCH 01/29] nfs: pass nfs_client to nfs_initiate_pgio
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, Trond Myklebust
	 <trondmy@hammerspace.com>, snitzer@hammerspace.com
Date: Mon, 10 Jun 2024 08:02:17 -0400
In-Reply-To: <20240607142646.20924-2-snitzer@kernel.org>
References: <20240607142646.20924-1-snitzer@kernel.org>
	 <20240607142646.20924-2-snitzer@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-06-07 at 10:26 -0400, Mike Snitzer wrote:
> From: Weston Andros Adamson <dros@primarydata.com>
>=20
> The nfs_client is needed for localio support.
>=20
> Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
> Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
> =C2=A0fs/nfs/filelayout/filelayout.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 4 ++--
> =C2=A0fs/nfs/flexfilelayout/flexfilelayout.c |=C2=A0 6 ++++--
> =C2=A0fs/nfs/internal.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 5 +++--
> =C2=A0fs/nfs/pagelist.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 10 ++++++----
> =C2=A04 files changed, 15 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/nfs/filelayout/filelayout.c
> b/fs/nfs/filelayout/filelayout.c
> index 29d84dc66ca3..43e16e9e0176 100644
> --- a/fs/nfs/filelayout/filelayout.c
> +++ b/fs/nfs/filelayout/filelayout.c
> @@ -486,7 +486,7 @@ filelayout_read_pagelist(struct nfs_pgio_header
> *hdr)
> =C2=A0	hdr->mds_offset =3D offset;
> =C2=A0
> =C2=A0	/* Perform an asynchronous read to ds */
> -	nfs_initiate_pgio(ds_clnt, hdr, hdr->cred,
> +	nfs_initiate_pgio(ds->ds_clp, ds_clnt, hdr, hdr->cred,
> =C2=A0			=C2=A0 NFS_PROTO(hdr->inode),
> &filelayout_read_call_ops,
> =C2=A0			=C2=A0 0, RPC_TASK_SOFTCONN);
> =C2=A0	return PNFS_ATTEMPTED;
> @@ -528,7 +528,7 @@ filelayout_write_pagelist(struct nfs_pgio_header
> *hdr, int sync)
> =C2=A0	hdr->args.offset =3D filelayout_get_dserver_offset(lseg,
> offset);
> =C2=A0
> =C2=A0	/* Perform an asynchronous write */
> -	nfs_initiate_pgio(ds_clnt, hdr, hdr->cred,
> +	nfs_initiate_pgio(ds->ds_clp, ds_clnt, hdr, hdr->cred,
> =C2=A0			=C2=A0 NFS_PROTO(hdr->inode),
> &filelayout_write_call_ops,
> =C2=A0			=C2=A0 sync, RPC_TASK_SOFTCONN);
> =C2=A0	return PNFS_ATTEMPTED;
> diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c
> b/fs/nfs/flexfilelayout/flexfilelayout.c
> index 24188af56d5b..327f1a5c9fbe 100644
> --- a/fs/nfs/flexfilelayout/flexfilelayout.c
> +++ b/fs/nfs/flexfilelayout/flexfilelayout.c
> @@ -1803,7 +1803,8 @@ ff_layout_read_pagelist(struct nfs_pgio_header
> *hdr)
> =C2=A0	hdr->mds_offset =3D offset;
> =C2=A0
> =C2=A0	/* Perform an asynchronous read to ds */
> -	nfs_initiate_pgio(ds_clnt, hdr, ds_cred, ds->ds_clp-
> >rpc_ops,
> +	nfs_initiate_pgio(ds->ds_clp, ds_clnt, hdr, ds_cred,
> +			=C2=A0 ds->ds_clp->rpc_ops,
> =C2=A0			=C2=A0 vers =3D=3D 3 ? &ff_layout_read_call_ops_v3 :
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &ff_layout_read_call_ops_v4,
> =C2=A0			=C2=A0 0, RPC_TASK_SOFTCONN);
> @@ -1871,7 +1872,8 @@ ff_layout_write_pagelist(struct nfs_pgio_header
> *hdr, int sync)
> =C2=A0	hdr->args.offset =3D offset;
> =C2=A0
> =C2=A0	/* Perform an asynchronous write */
> -	nfs_initiate_pgio(ds_clnt, hdr, ds_cred, ds->ds_clp-
> >rpc_ops,
> +	nfs_initiate_pgio(ds->ds_clp, ds_clnt, hdr, ds_cred,
> +			=C2=A0 ds->ds_clp->rpc_ops,
> =C2=A0			=C2=A0 vers =3D=3D 3 ? &ff_layout_write_call_ops_v3 :
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &ff_layout_write_call_ops_v4,
> =C2=A0			=C2=A0 sync, RPC_TASK_SOFTCONN);
> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> index 9f0f4534744b..a9c0c29f7804 100644
> --- a/fs/nfs/internal.h
> +++ b/fs/nfs/internal.h
> @@ -306,8 +306,9 @@ extern const struct nfs_pageio_ops
> nfs_pgio_rw_ops;
> =C2=A0struct nfs_pgio_header *nfs_pgio_header_alloc(const struct
> nfs_rw_ops *);
> =C2=A0void nfs_pgio_header_free(struct nfs_pgio_header *);
> =C2=A0int nfs_generic_pgio(struct nfs_pageio_descriptor *, struct
> nfs_pgio_header *);
> -int nfs_initiate_pgio(struct rpc_clnt *clnt, struct nfs_pgio_header
> *hdr,
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct cred *cred, const struct
> nfs_rpc_ops *rpc_ops,
> +int nfs_initiate_pgio(struct nfs_client *clp, struct rpc_clnt
> *rpc_clnt,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nfs_pgio_header *hdr, const stru=
ct cred
> *cred,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct nfs_rpc_ops *rpc_ops,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct rpc_call_ops *call_op=
s, int how,
> int flags);
> =C2=A0void nfs_free_request(struct nfs_page *req);
> =C2=A0struct nfs_pgio_mirror *
> diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
> index 6efb5068c116..d9b795c538cd 100644
> --- a/fs/nfs/pagelist.c
> +++ b/fs/nfs/pagelist.c
> @@ -844,8 +844,9 @@ static void nfs_pgio_prepare(struct rpc_task
> *task, void *calldata)
> =C2=A0		rpc_exit(task, err);
> =C2=A0}
> =C2=A0
> -int nfs_initiate_pgio(struct rpc_clnt *clnt, struct nfs_pgio_header
> *hdr,
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct cred *cred, const struct
> nfs_rpc_ops *rpc_ops,
> +int nfs_initiate_pgio(struct nfs_client *clp, struct rpc_clnt
> *rpc_clnt,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nfs_pgio_header *hdr, const stru=
ct cred
> *cred,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct nfs_rpc_ops *rpc_ops,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct rpc_call_ops *call_op=
s, int how,
> int flags)
> =C2=A0{
> =C2=A0	struct rpc_task *task;
> @@ -855,7 +856,7 @@ int nfs_initiate_pgio(struct rpc_clnt *clnt,
> struct nfs_pgio_header *hdr,
> =C2=A0		.rpc_cred =3D cred,
> =C2=A0	};
> =C2=A0	struct rpc_task_setup task_setup_data =3D {
> -		.rpc_client =3D clnt,
> +		.rpc_client =3D rpc_clnt,
> =C2=A0		.task =3D &hdr->task,
> =C2=A0		.rpc_message =3D &msg,
> =C2=A0		.callback_ops =3D call_ops,
> @@ -1070,7 +1071,8 @@ static int nfs_generic_pg_pgios(struct
> nfs_pageio_descriptor *desc)
> =C2=A0	if (ret =3D=3D 0) {
> =C2=A0		if (NFS_SERVER(hdr->inode)->nfs_client-
> >cl_minorversion)
> =C2=A0			task_flags =3D RPC_TASK_MOVEABLE;
> -		ret =3D nfs_initiate_pgio(NFS_CLIENT(hdr->inode),
> +		ret =3D nfs_initiate_pgio(NFS_SERVER(hdr->inode)-
> >nfs_client,
> +					NFS_CLIENT(hdr->inode),
> =C2=A0					hdr,
> =C2=A0					hdr->cred,
> =C2=A0					NFS_PROTO(hdr->inode),

My first inclination was that this is redundant since the nfs_client
has a pointer to the rpc_client in it, but in the pNFS situation I
suppose they aren't necessary the same thing, so I guess you have to do
it this way.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

