Return-Path: <linux-nfs+bounces-3629-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E299021CE
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jun 2024 14:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22D961F20FCF
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jun 2024 12:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DF37FBC3;
	Mon, 10 Jun 2024 12:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbvVJUs6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5697FBBD
	for <linux-nfs@vger.kernel.org>; Mon, 10 Jun 2024 12:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718023417; cv=none; b=OB64rixVnbJi1U71vNnQLDn5J1y2al/0uMVeIxY2Xm2ocmzW70+P8bCilJlx3fJJXWbItp8GBj9TaIGdAOngVv6JBTsDNGJ8q0cpED4qr8uM7ij7iXxCRX9wMfbik4uA4WulOYt7Iy95jQkOs0EKT6IICW5PevQokQvZNHLGmBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718023417; c=relaxed/simple;
	bh=TjK776rZxRNAU0jUoyYVZL99YtpGSDoIp6eJj8tc1yI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XYAmnno3eTMeydYiF04YtZV3li+5QSmR42F8KB9GJlwPmZtk6EizJSCNi6qxWtST3LTg1d6+lnaxCrgtsYstaFGel8GcuYJB0WNwCTk7j1iC8DyF7UYJReteIyimeTb0evCJn3Lo8yOZP2EedU9S98qLoFqVZHZsjunGkzoI9jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbvVJUs6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DD1C2BBFC;
	Mon, 10 Jun 2024 12:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718023416;
	bh=TjK776rZxRNAU0jUoyYVZL99YtpGSDoIp6eJj8tc1yI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=VbvVJUs6CABox3DYIbHB9ytJ1WBo+fxCm1gV9Aa1ClabNjMxbUkmBvO5DODrIMAUL
	 Rj4ppyZ3vx38ZTGfyBIaHUX69JKbyu+eRuKrQw1cKI60YgyfBiu3yvJR3G/iEjzgEu
	 KUnaeXmAl1rkcu3HiogQqA1TgkMoUH9AT/NSeeUADP1qP7VYZAM0TWTKDFyb/IVI4S
	 o19q7M8qNLkNYZy4VTBy8l69fMbhTxvP0jW8vzj63+FRcXtgk9/k5C84eVG/SijoDx
	 b6edPXse+fGTZ0lJkOl7WfUUjMsV3TBH14ss3F/X2f7xwKf6tyboSAJ5o05cAGgysx
	 Fz+nTpEZKbKUg==
Message-ID: <3ed173a9370c6d386f4c48cc133eb61511e291d0.camel@kernel.org>
Subject: Re: [for-6.11 PATCH 10/29] nfs/nfsd: add "local io" support
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, Trond Myklebust
	 <trondmy@hammerspace.com>, snitzer@hammerspace.com
Date: Mon, 10 Jun 2024 08:43:34 -0400
In-Reply-To: <20240607142646.20924-11-snitzer@kernel.org>
References: <20240607142646.20924-1-snitzer@kernel.org>
	 <20240607142646.20924-11-snitzer@kernel.org>
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
> Add client support for bypassing NFS for localhost reads, writes, and com=
mits.
>=20
> This is only useful when the client and the server are running on the sam=
e
> host and in the same container.
>=20
> This has dynamic binding with the nfsd module. Local i/o will only work i=
f
> nfsd is already loaded.
>=20
> [snitm: rebase accounted for commit d8b26071e65e8 ("NFSD: simplify struct=
 nfsfh")
> =C2=A0and commit 7c98f7cb8fda ("remove call_{read,write}_iter() functions=
")]
>=20
> Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
> Signed-off-by: Jeff Layton <jeff.layton@primarydata.com>
> Signed-off-by: Peng Tao <tao.peng@primarydata.com>
> Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
> =C2=A0fs/nfs/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0fs/nfs/client.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 12 +
> =C2=A0fs/nfs/filelayout/filelayout.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 6 +-
> =C2=A0fs/nfs/flexfilelayout/flexfilelayout.c |=C2=A0=C2=A0 6 +-
> =C2=A0fs/nfs/inode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 5 +
> =C2=A0fs/nfs/internal.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 32 +-
> =C2=A0fs/nfs/localio.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 933 +++++++++++++++++++++++++
> =C2=A0fs/nfs/nfstrace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 29 +
> =C2=A0fs/nfs/pagelist.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 12 +-
> =C2=A0fs/nfs/pnfs_nfs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0fs/nfs/write.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 14 +-
> =C2=A0fs/nfsd/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0fs/nfsd/filecache.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 2 +-
> =C2=A0fs/nfsd/localio.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 179 +++++
> =C2=A0fs/nfsd/trace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +-
> =C2=A0fs/nfsd/vfs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +
> =C2=A0include/linux/nfs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 6 +
> =C2=A0include/linux/nfs_fs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0include/linux/nfs_fs_sb.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0include/linux/nfs_xdr.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A020 files changed, 1240 insertions(+), 18 deletions(-)
> =C2=A0create mode 100644 fs/nfs/localio.c
> =C2=A0create mode 100644 fs/nfsd/localio.c
>=20
> diff --git a/fs/nfs/Makefile b/fs/nfs/Makefile
> index 5f6db37f461e..af64cf5ea420 100644
> --- a/fs/nfs/Makefile
> +++ b/fs/nfs/Makefile
> @@ -9,7 +9,7 @@ CFLAGS_nfstrace.o +=3D -I$(src)
> =C2=A0nfs-y=C2=A0			:=3D client.o dir.o file.o getroot.o inode.o super.o =
\
> =C2=A0			=C2=A0=C2=A0 io.o direct.o pagelist.o read.o symlink.o unlink.o =
\
> =C2=A0			=C2=A0=C2=A0 write.o namespace.o mount_clnt.o nfstrace.o \
> -			=C2=A0=C2=A0 export.o sysfs.o fs_context.o
> +			=C2=A0=C2=A0 export.o sysfs.o fs_context.o localio.o
> =C2=A0nfs-$(CONFIG_ROOT_NFS)	+=3D nfsroot.o
> =C2=A0nfs-$(CONFIG_SYSCTL)	+=3D sysctl.o
> =C2=A0nfs-$(CONFIG_NFS_FSCACHE) +=3D fscache.o
> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> index dd3278dcfca8..288de750fd3b 100644
> --- a/fs/nfs/client.c
> +++ b/fs/nfs/client.c
> @@ -170,6 +170,7 @@ struct nfs_client *nfs_alloc_client(const struct nfs_=
client_initdata *cl_init)
> =C2=A0	}
> =C2=A0
> =C2=A0	INIT_LIST_HEAD(&clp->cl_superblocks);
> +	INIT_LIST_HEAD(&clp->cl_local_addrs);
> =C2=A0	clp->cl_rpcclient =3D ERR_PTR(-EINVAL);
> =C2=A0
> =C2=A0	clp->cl_flags =3D cl_init->init_flags;
> @@ -183,6 +184,7 @@ struct nfs_client *nfs_alloc_client(const struct nfs_=
client_initdata *cl_init)
> =C2=A0
> =C2=A0	clp->cl_principal =3D "*";
> =C2=A0	clp->cl_xprtsec =3D cl_init->xprtsec;
> +	nfs_probe_local_addr(clp);
> =C2=A0	return clp;
> =C2=A0
> =C2=A0error_cleanup:
> @@ -236,10 +238,19 @@ static void pnfs_init_server(struct nfs_server *ser=
ver)
> =C2=A0 */
> =C2=A0void nfs_free_client(struct nfs_client *clp)
> =C2=A0{
> +	struct nfs_local_addr *addr, *tmp;
> +
> +	nfs_local_disable(clp);
> +
> =C2=A0	/* -EIO all pending I/O */
> =C2=A0	if (!IS_ERR(clp->cl_rpcclient))
> =C2=A0		rpc_shutdown_client(clp->cl_rpcclient);
> =C2=A0
> +	list_for_each_entry_safe(addr, tmp, &clp->cl_local_addrs, cl_addrs) {
> +		list_del(&addr->cl_addrs);
> +		kfree(addr);
> +	}
> +
> =C2=A0	put_net(clp->cl_net);
> =C2=A0	put_nfs_version(clp->cl_nfs_mod);
> =C2=A0	kfree(clp->cl_hostname);
> @@ -427,6 +438,7 @@ struct nfs_client *nfs_get_client(const struct nfs_cl=
ient_initdata *cl_init)
> =C2=A0			list_add_tail(&new->cl_share_link,
> =C2=A0					&nn->nfs_client_list);
> =C2=A0			spin_unlock(&nn->nfs_client_lock);
> +			nfs_local_probe(new);
> =C2=A0			return rpc_ops->init_client(new, cl_init);
> =C2=A0		}
> =C2=A0
> diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayou=
t.c
> index d66f2efbd92f..bd8c717c31d2 100644
> --- a/fs/nfs/filelayout/filelayout.c
> +++ b/fs/nfs/filelayout/filelayout.c
> @@ -489,7 +489,7 @@ filelayout_read_pagelist(struct nfs_pageio_descriptor=
 *desc,
> =C2=A0	/* Perform an asynchronous read to ds */
> =C2=A0	nfs_initiate_pgio(desc, ds->ds_clp, ds_clnt, hdr, hdr->cred,
> =C2=A0			=C2=A0 NFS_PROTO(hdr->inode), &filelayout_read_call_ops,
> -			=C2=A0 0, RPC_TASK_SOFTCONN);
> +			=C2=A0 0, RPC_TASK_SOFTCONN, NULL);
> =C2=A0	return PNFS_ATTEMPTED;
> =C2=A0}
> =C2=A0
> @@ -532,7 +532,7 @@ filelayout_write_pagelist(struct nfs_pageio_descripto=
r *desc,
> =C2=A0	/* Perform an asynchronous write */
> =C2=A0	nfs_initiate_pgio(desc, ds->ds_clp, ds_clnt, hdr, hdr->cred,
> =C2=A0			=C2=A0 NFS_PROTO(hdr->inode), &filelayout_write_call_ops,
> -			=C2=A0 sync, RPC_TASK_SOFTCONN);
> +			=C2=A0 sync, RPC_TASK_SOFTCONN, NULL);
> =C2=A0	return PNFS_ATTEMPTED;
> =C2=A0}
> =C2=A0
> @@ -1014,7 +1014,7 @@ static int filelayout_initiate_commit(struct nfs_co=
mmit_data *data, int how)
> =C2=A0	return nfs_initiate_commit(ds->ds_clp, ds_clnt, data,
> =C2=A0				=C2=A0=C2=A0 NFS_PROTO(data->inode),
> =C2=A0				=C2=A0=C2=A0 &filelayout_commit_call_ops, how,
> -				=C2=A0=C2=A0 RPC_TASK_SOFTCONN);
> +				=C2=A0=C2=A0 RPC_TASK_SOFTCONN, NULL);
> =C2=A0out_err:
> =C2=A0	pnfs_generic_prepare_to_resend_writes(data);
> =C2=A0	pnfs_generic_commit_release(data);
> diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayo=
ut/flexfilelayout.c
> index d7e9e5ef4085..ce6cb5d82427 100644
> --- a/fs/nfs/flexfilelayout/flexfilelayout.c
> +++ b/fs/nfs/flexfilelayout/flexfilelayout.c
> @@ -1808,7 +1808,7 @@ ff_layout_read_pagelist(struct nfs_pageio_descripto=
r *desc,
> =C2=A0			=C2=A0 ds->ds_clp->rpc_ops,
> =C2=A0			=C2=A0 vers =3D=3D 3 ? &ff_layout_read_call_ops_v3 :
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &ff_layout_read_call_ops_v4,
> -			=C2=A0 0, RPC_TASK_SOFTCONN);
> +			=C2=A0 0, RPC_TASK_SOFTCONN, NULL);
> =C2=A0	put_cred(ds_cred);
> =C2=A0	return PNFS_ATTEMPTED;
> =C2=A0
> @@ -1878,7 +1878,7 @@ ff_layout_write_pagelist(struct nfs_pageio_descript=
or *desc,
> =C2=A0			=C2=A0 ds->ds_clp->rpc_ops,
> =C2=A0			=C2=A0 vers =3D=3D 3 ? &ff_layout_write_call_ops_v3 :
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &ff_layout_write_call_ops_v4,
> -			=C2=A0 sync, RPC_TASK_SOFTCONN);
> +			=C2=A0 sync, RPC_TASK_SOFTCONN, NULL);
> =C2=A0	put_cred(ds_cred);
> =C2=A0	return PNFS_ATTEMPTED;
> =C2=A0
> @@ -1953,7 +1953,7 @@ static int ff_layout_initiate_commit(struct nfs_com=
mit_data *data, int how)
> =C2=A0	ret =3D nfs_initiate_commit(ds->ds_clp, ds_clnt, data, ds->ds_clp-=
>rpc_ops,
> =C2=A0				=C2=A0=C2=A0 vers =3D=3D 3 ? &ff_layout_commit_call_ops_v3 :
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &ff_layout_commit_call_op=
s_v4,
> -				=C2=A0=C2=A0 how, RPC_TASK_SOFTCONN);
> +				=C2=A0=C2=A0 how, RPC_TASK_SOFTCONN, NULL);
> =C2=A0	put_cred(ds_cred);
> =C2=A0	return ret;
> =C2=A0out_err:
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index acef52ecb1bb..4f88b860494f 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -39,6 +39,7 @@
> =C2=A0#include <linux/slab.h>
> =C2=A0#include <linux/compat.h>
> =C2=A0#include <linux/freezer.h>
> +#include <linux/file.h>
> =C2=A0#include <linux/uaccess.h>
> =C2=A0#include <linux/iversion.h>
> =C2=A0
> @@ -1053,6 +1054,7 @@ struct nfs_open_context *alloc_nfs_open_context(str=
uct dentry *dentry,
> =C2=A0	ctx->lock_context.open_context =3D ctx;
> =C2=A0	INIT_LIST_HEAD(&ctx->list);
> =C2=A0	ctx->mdsthreshold =3D NULL;
> +	ctx->local_filp =3D NULL;
> =C2=A0	return ctx;
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(alloc_nfs_open_context);
> @@ -1084,6 +1086,8 @@ static void __put_nfs_open_context(struct nfs_open_=
context *ctx, int is_sync)
> =C2=A0	nfs_sb_deactive(sb);
> =C2=A0	put_rpccred(rcu_dereference_protected(ctx->ll_cred, 1));
> =C2=A0	kfree(ctx->mdsthreshold);
> +	if (!IS_ERR_OR_NULL(ctx->local_filp))
> +		fput(ctx->local_filp);
> =C2=A0	kfree_rcu(ctx, rcu_head);
> =C2=A0}
> =C2=A0
> @@ -2495,6 +2499,7 @@ static int __init init_nfs_fs(void)
> =C2=A0	if (err)
> =C2=A0		goto out1;
> =C2=A0
> +	nfs_local_init();
> =C2=A0	err =3D register_nfs_fs();
> =C2=A0	if (err)
> =C2=A0		goto out0;
> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> index 873c2339b78a..67b348447a40 100644
> --- a/fs/nfs/internal.h
> +++ b/fs/nfs/internal.h
> @@ -204,6 +204,12 @@ struct nfs_mount_request {
> =C2=A0	struct net		*net;
> =C2=A0};
> =C2=A0
> +struct nfs_local_addr {
> +	struct list_head	cl_addrs;
> +	struct sockaddr_storage	address;
> +	size_t			addrlen;
> +};
> +
> =C2=A0extern int nfs_mount(struct nfs_mount_request *info, int timeo, int=
 retrans);
> =C2=A0extern void nfs_umount(const struct nfs_mount_request *info);
> =C2=A0
> @@ -309,7 +315,8 @@ int nfs_generic_pgio(struct nfs_pageio_descriptor *, =
struct nfs_pgio_header *);
> =C2=A0int nfs_initiate_pgio(struct nfs_pageio_descriptor *, struct nfs_cl=
ient *clp,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct rpc_clnt *rpc_clnt, struct =
nfs_pgio_header *hdr,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct cred *cred, const str=
uct nfs_rpc_ops *rpc_ops,
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct rpc_call_ops *call_ops, in=
t how, int flags);
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct rpc_call_ops *call_ops, in=
t how, int flags,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct file *localio);
> =C2=A0void nfs_free_request(struct nfs_page *req);
> =C2=A0struct nfs_pgio_mirror *
> =C2=A0nfs_pgio_current_mirror(struct nfs_pageio_descriptor *desc);
> @@ -450,6 +457,26 @@ extern void nfs_set_cache_invalid(struct inode *inod=
e, unsigned long flags);
> =C2=A0extern bool nfs_check_cache_invalid(struct inode *, unsigned long);
> =C2=A0extern int nfs_wait_bit_killable(struct wait_bit_key *key, int mode=
);
> =C2=A0
> +/* localio.c */
> +extern void nfs_local_init(void);
> +extern void nfs_local_enable(struct nfs_client *);
> +extern void nfs_local_disable(struct nfs_client *);
> +extern void nfs_local_probe(struct nfs_client *);
> +extern struct file *nfs_local_open_fh(struct nfs_client *, const struct =
cred *,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nfs_fh *, const fmode_t);
> +extern struct file *nfs_local_file_open(struct nfs_client *clp,
> +					const struct cred *cred,
> +					struct nfs_fh *fh,
> +					struct nfs_open_context *ctx);
> +extern int nfs_local_doio(struct nfs_client *, struct file *,
> +			=C2=A0 struct nfs_pgio_header *,
> +			=C2=A0 const struct rpc_call_ops *);
> +extern int nfs_local_commit(struct nfs_client *, struct file *,
> +			=C2=A0=C2=A0=C2=A0 struct nfs_commit_data *,
> +			=C2=A0=C2=A0=C2=A0 const struct rpc_call_ops *, int);
> +extern void nfs_probe_local_addr(struct nfs_client *clnt);
> +extern bool nfs_server_is_local(const struct nfs_client *clp);
> +
> =C2=A0/* super.c */
> =C2=A0extern const struct super_operations nfs_sops;
> =C2=A0bool nfs_auth_info_match(const struct nfs_auth_info *, rpc_authflav=
or_t);
> @@ -530,7 +557,8 @@ extern int nfs_initiate_commit(struct nfs_client *clp=
,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nfs_commit_data *dat=
a,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct nfs_rpc_ops *n=
fs_ops,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct rpc_call_ops *=
call_ops,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int how, int flags);
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int how, int flags,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct file *localio);
> =C2=A0extern void nfs_init_commit(struct nfs_commit_data *data,
> =C2=A0			=C2=A0=C2=A0=C2=A0 struct list_head *head,
> =C2=A0			=C2=A0=C2=A0=C2=A0 struct pnfs_layout_segment *lseg,
> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> new file mode 100644
> index 000000000000..5c69eb0fe7b6
> --- /dev/null
> +++ b/fs/nfs/localio.c
> @@ -0,0 +1,933 @@
> +/*
> + *=C2=A0 linux/fs/nfs/localio.c
> + *
> + *=C2=A0 Copyright (C) 2014=C2=A0 Weston Andros Adamson <dros@primarydat=
a.com>
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/errno.h>
> +#include <linux/vfs.h>
> +#include <linux/file.h>
> +#include <linux/inet.h>
> +#include <linux/sunrpc/addr.h>
> +#include <linux/inetdevice.h>
> +#include <net/addrconf.h>
> +#include <linux/module.h>
> +#include <linux/bvec.h>
> +
> +#include <linux/nfs.h>
> +#include <linux/nfs_fs.h>
> +#include <linux/nfs_xdr.h>
> +
> +#include <uapi/linux/if_arp.h>
> +
> +#include "internal.h"
> +#include "pnfs.h"
> +#include "nfstrace.h"
> +
> +#define NFSDBG_FACILITY		NFSDBG_VFS
> +
> +extern int nfsd_open_local_fh(struct rpc_clnt *rpc_clnt,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct cred *cred,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct nfs_fh *nfs_fh, const fmo=
de_t fmode,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct file **pfilp);
> +/*
> + * The localio code needs to call into nfsd to do the filehandle -> stru=
ct path
> + * mapping, but cannot be statically linked, because that will make the =
nfs
> + * module depend on the nfsd module.
> + *
> + * Instead, do dynamic linking to the nfsd module. This way the nfs modu=
le
> + * will only hold a reference on nfsd when it's actually in use. This al=
so
> + * allows some sanity checking, like giving up on localio if nfsd isn't =
loaded.
> + */
> +
> +struct nfs_local_open_ctx {
> +	spinlock_t lock;
> +	nfs_to_nfsd_open_t open_f;
> +	atomic_t refcount;
> +};
> +
> +struct nfs_local_kiocb {
> +	struct kiocb		kiocb;
> +	struct bio_vec		*bvec;
> +	struct nfs_pgio_header	*hdr;
> +	struct work_struct	work;
> +};
> +
> +struct nfs_local_fsync_ctx {
> +	struct file		*filp;
> +	struct nfs_commit_data	*data;
> +	struct work_struct	work;
> +	struct kref		kref;
> +};
> +static void nfs_local_fsync_work(struct work_struct *work);
> +
> +/*
> + * We need to translate between nfs status return values and
> + * the local errno values which may not be the same.
> + */
> +static struct {
> +	__u32 stat;
> +	int errno;
> +} nfs_errtbl[] =3D {
> +	{ NFS4_OK,		0		},
> +	{ NFS4ERR_PERM,		-EPERM		},
> +	{ NFS4ERR_NOENT,	-ENOENT		},
> +	{ NFS4ERR_IO,		-EIO		},
> +	{ NFS4ERR_NXIO,		-ENXIO		},
> +	{ NFS4ERR_FBIG,		-E2BIG		},
> +	{ NFS4ERR_STALE,	-EBADF		},
> +	{ NFS4ERR_ACCESS,	-EACCES		},
> +	{ NFS4ERR_EXIST,	-EEXIST		},
> +	{ NFS4ERR_XDEV,		-EXDEV		},
> +	{ NFS4ERR_MLINK,	-EMLINK		},
> +	{ NFS4ERR_NOTDIR,	-ENOTDIR	},
> +	{ NFS4ERR_ISDIR,	-EISDIR		},
> +	{ NFS4ERR_INVAL,	-EINVAL		},
> +	{ NFS4ERR_FBIG,		-EFBIG		},
> +	{ NFS4ERR_NOSPC,	-ENOSPC		},
> +	{ NFS4ERR_ROFS,		-EROFS		},
> +	{ NFS4ERR_NAMETOOLONG,	-ENAMETOOLONG	},
> +	{ NFS4ERR_NOTEMPTY,	-ENOTEMPTY	},
> +	{ NFS4ERR_DQUOT,	-EDQUOT		},
> +	{ NFS4ERR_STALE,	-ESTALE		},
> +	{ NFS4ERR_STALE,	-EOPENSTALE	},
> +	{ NFS4ERR_DELAY,	-ETIMEDOUT	},
> +	{ NFS4ERR_DELAY,	-ERESTARTSYS	},
> +	{ NFS4ERR_DELAY,	-EAGAIN		},
> +	{ NFS4ERR_DELAY,	-ENOMEM		},
> +	{ NFS4ERR_IO,		-ETXTBSY	},
> +	{ NFS4ERR_IO,		-EBUSY		},
> +	{ NFS4ERR_BADHANDLE,	-EBADHANDLE	},
> +	{ NFS4ERR_BAD_COOKIE,	-EBADCOOKIE	},
> +	{ NFS4ERR_NOTSUPP,	-EOPNOTSUPP	},
> +	{ NFS4ERR_TOOSMALL,	-ETOOSMALL	},
> +	{ NFS4ERR_SERVERFAULT,	-ESERVERFAULT	},
> +	{ NFS4ERR_SERVERFAULT,	-ENFILE		},
> +	{ NFS4ERR_IO,		-EREMOTEIO	},
> +	{ NFS4ERR_IO,		-EUCLEAN	},
> +	{ NFS4ERR_PERM,		-ENOKEY		},
> +	{ NFS4ERR_BADTYPE,	-EBADTYPE	},
> +	{ NFS4ERR_SYMLINK,	-ELOOP		},
> +	{ NFS4ERR_DEADLOCK,	-EDEADLK	},
> +};
> +
> +/*
> + * Convert an NFS error code to a local one.
> + * This one is used jointly by NFSv2 and NFSv3.
> + */
> +static __u32
> +nfs4errno(int errno)
> +{
> +	unsigned int i;
> +	for (i =3D 0; i < ARRAY_SIZE(nfs_errtbl); i++) {
> +		if (nfs_errtbl[i].errno =3D=3D errno)
> +			return nfs_errtbl[i].stat;
> +	}
> +	/* If we cannot translate the error, the recovery routines should
> +	 * handle it.
> +	 * Note: remaining NFSv4 error codes have values > 10000, so should
> +	 * not conflict with native Linux error codes.
> +	 */
> +	return NFS4ERR_SERVERFAULT;
> +}
> +
> +static struct nfs_local_open_ctx __local_open_ctx __read_mostly;
> +
> +static bool localio_enabled __read_mostly =3D true;
> +module_param(localio_enabled, bool, 0644);
> +
> +bool nfs_server_is_local(const struct nfs_client *clp)
> +{
> +	return test_bit(NFS_CS_LOCAL_IO, &clp->cl_flags) !=3D 0 &&
> +		localio_enabled;
> +}
> +EXPORT_SYMBOL_GPL(nfs_server_is_local);
> +
> +void
> +nfs_local_init(void)
> +{
> +	struct nfs_local_open_ctx *ctx =3D &__local_open_ctx;
> +
> +	ctx->open_f =3D NULL;
> +	spin_lock_init(&ctx->lock);
> +	atomic_set(&ctx->refcount, 0);
> +}
> +
> +static bool
> +nfs_local_get_lookup_ctx(void)
> +{
> +	struct nfs_local_open_ctx *ctx =3D &__local_open_ctx;
> +	nfs_to_nfsd_open_t fn =3D NULL;
> +
> +	spin_lock(&ctx->lock);
> +	if (ctx->open_f =3D=3D NULL) {
> +		spin_unlock(&ctx->lock);
> +
> +		fn =3D symbol_request(nfsd_open_local_fh);
> +		if (!fn)
> +			return false;
> +
> +		spin_lock(&ctx->lock);
> +		/* catch race */
> +		if (ctx->open_f =3D=3D NULL) {
> +			ctx->open_f =3D fn;
> +			fn =3D NULL;
> +		}
> +	}
> +	atomic_inc(&ctx->refcount);
> +	spin_unlock(&ctx->lock);
> +	if (fn)
> +		symbol_put(nfsd_open_local_fh);
> +	return true;
> +}
> +
> +static void
> +nfs_local_put_lookup_ctx(void)
> +{
> +	struct nfs_local_open_ctx *ctx =3D &__local_open_ctx;
> +	nfs_to_nfsd_open_t fn;
> +
> +	if (atomic_dec_and_lock(&ctx->refcount, &ctx->lock)) {
> +		fn =3D ctx->open_f;
> +		ctx->open_f =3D NULL;
> +		spin_unlock(&ctx->lock);
> +		if (fn)
> +			symbol_put(nfsd_open_local_fh);
> +		dprintk("destroy lookup context\n");
> +	}
> +}
> +
> +/*
> + * nfs_local_enable - attempt to enable local i/o for an nfs_client
> + */
> +void
> +nfs_local_enable(struct nfs_client *clp)
> +{
> +	if (nfs_local_get_lookup_ctx()) {
> +		dprintk("enabled local i/o\n");
> +		set_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(nfs_local_enable);
> +
> +/*
> + * nfs_local_disable - disable local i/o for an nfs_client
> + */
> +void
> +nfs_local_disable(struct nfs_client *clp)
> +{
> +	if (test_and_clear_bit(NFS_CS_LOCAL_IO, &clp->cl_flags)) {
> +		dprintk("disabled local i/o\n");
> +		nfs_local_put_lookup_ctx();
> +	}
> +}
> +
> +/*
> + * nfs_local_probe - probe local i/o support for an nfs_client
> + */
> +void
> +nfs_local_probe(struct nfs_client *clp)
> +{
> +	struct sockaddr_in *sin;
> +	struct sockaddr_in6 *sin6;
> +	struct nfs_local_addr *addr;
> +	struct sockaddr *sap;
> +	bool enable =3D false;
> +
> +	switch (clp->cl_addr.ss_family) {
> +	case AF_INET:
> +		sin =3D (struct sockaddr_in *)&clp->cl_addr;
> +		if (ipv4_is_loopback(sin->sin_addr.s_addr)) {
> +			dprintk("%s: detected IPv4 loopback address\n",
> +				__func__);
> +			enable =3D true;
> +		}
> +		break;
> +	case AF_INET6:
> +		sin6 =3D (struct sockaddr_in6 *)&clp->cl_addr;
> +		if (memcmp(&sin6->sin6_addr, &in6addr_loopback,
> +		=C2=A0=C2=A0=C2=A0 sizeof(struct in6_addr)) =3D=3D 0) {
> +			dprintk("%s: detected IPv6 loopback address\n",
> +				__func__);
> +			enable =3D true;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (enable)
> +		goto out;
> +
> +	list_for_each_entry(addr, &clp->cl_local_addrs, cl_addrs) {
> +		sap =3D (struct sockaddr *)&addr->address;
> +		if (rpc_cmp_addr((struct sockaddr *)&clp->cl_addr, sap)) {
> +			dprintk("%s: detected local server.\n", __func__);
> +			enable =3D true;
> +			break;
> +		}
> +	}
> +
> +out:
> +	if (enable)
> +		nfs_local_enable(clp);
> +}
> +
> +/*
> + * nfs_local_open_fh - open a local filehandle
> + *
> + * Returns a pointer to a struct file or an ERR_PTR
> + */
> +struct file *
> +nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
> +		=C2=A0 struct nfs_fh *fh, const fmode_t mode)
> +{
> +	struct nfs_local_open_ctx *ctx =3D &__local_open_ctx;
> +	struct file *filp;
> +	int status;
> +
> +	if (mode & ~(FMODE_READ | FMODE_WRITE))
> +		return ERR_PTR(-EINVAL);
> +
> +	status =3D ctx->open_f(clp->cl_rpcclient, cred, fh, mode, &filp);
> +	if (status < 0) {
> +		dprintk("%s: open local file failed error=3D%d\n",
> +				__func__, status);
> +		trace_nfs_local_open_fh(fh, mode, status);
> +		switch (status) {
> +		case -ENXIO:
> +			nfs_local_disable(clp);
> +			fallthrough;
> +		case -ETIMEDOUT:
> +			status =3D -EAGAIN;
> +		}
> +		filp =3D ERR_PTR(status);
> +	}
> +	return filp;
> +}
> +EXPORT_SYMBOL_GPL(nfs_local_open_fh);
> +
> +static struct bio_vec *
> +nfs_bvec_alloc_and_import_pagevec(struct page **pagevec,
> +		unsigned int npages, gfp_t flags)
> +{
> +	struct bio_vec *bvec, *p;
> +
> +	bvec =3D kmalloc_array(npages, sizeof(*bvec), flags);
> +	if (bvec !=3D NULL) {
> +		for (p =3D bvec; npages > 0; p++, pagevec++, npages--) {
> +			p->bv_page =3D *pagevec;
> +			p->bv_len =3D PAGE_SIZE;
> +			p->bv_offset =3D 0;
> +		}
> +	}
> +	return bvec;
> +}
> +
> +static void
> +nfs_local_iocb_free(struct nfs_local_kiocb *iocb)
> +{
> +	kfree(iocb->bvec);
> +	kfree(iocb);
> +}
> +
> +static struct nfs_local_kiocb *
> +nfs_local_iocb_alloc(struct nfs_pgio_header *hdr, struct file *filp,
> +		gfp_t flags)
> +{
> +	struct nfs_local_kiocb *iocb;
> +
> +	iocb =3D kmalloc(sizeof(*iocb), flags);
> +	if (iocb =3D=3D NULL)
> +		return NULL;
> +	iocb->bvec =3D nfs_bvec_alloc_and_import_pagevec(hdr->page_array.pageve=
c,
> +			hdr->page_array.npages, flags);
> +	if (iocb->bvec =3D=3D NULL) {
> +		kfree(iocb);
> +		return NULL;
> +	}
> +	init_sync_kiocb(&iocb->kiocb, filp);
> +	iocb->kiocb.ki_pos =3D hdr->args.offset;
> +	iocb->hdr =3D hdr;
> +	/* FIXME: NFS_IOHDR_ODIRECT isn't ever set */
> +	if (test_bit(NFS_IOHDR_ODIRECT, &hdr->flags))
> +		iocb->kiocb.ki_flags |=3D IOCB_DIRECT|IOCB_DSYNC;
> +	iocb->kiocb.ki_flags &=3D ~IOCB_APPEND;
> +	return iocb;
> +}
> +
> +static void
> +nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, in=
t dir)
> +{
> +	struct nfs_pgio_header *hdr =3D iocb->hdr;
> +
> +	if (hdr->args.pgbase !=3D 0) {
> +		iov_iter_bvec(i, dir, iocb->bvec,
> +				hdr->page_array.npages,
> +				hdr->args.count + hdr->args.pgbase);
> +		iov_iter_advance(i, hdr->args.pgbase);
> +	} else
> +		iov_iter_bvec(i, dir, iocb->bvec,
> +				hdr->page_array.npages, hdr->args.count);
> +}
> +
> +static void
> +nfs_local_hdr_release(struct nfs_pgio_header *hdr,
> +		const struct rpc_call_ops *call_ops)
> +{
> +	call_ops->rpc_call_done(&hdr->task, hdr);
> +	call_ops->rpc_release(hdr);
> +}
> +
> +static void
> +nfs_local_pgio_init(struct nfs_pgio_header *hdr,
> +		const struct rpc_call_ops *call_ops)
> +{
> +	hdr->task.tk_ops =3D call_ops;
> +	if (!hdr->task.tk_start)
> +		hdr->task.tk_start =3D ktime_get();
> +}
> +
> +static void
> +nfs_local_pgio_done(struct nfs_pgio_header *hdr, long status)
> +{
> +	if (status >=3D 0) {
> +		hdr->res.count =3D status;
> +		hdr->res.op_status =3D NFS4_OK;
> +		hdr->task.tk_status =3D 0;
> +	} else {
> +		hdr->res.op_status =3D nfs4errno(status);
> +		hdr->task.tk_status =3D status;
> +	}
> +}
> +
> +static void
> +nfs_local_pgio_release(struct nfs_local_kiocb *iocb)
> +{
> +	struct nfs_pgio_header *hdr =3D iocb->hdr;
> +
> +	fput(iocb->kiocb.ki_filp);
> +	nfs_local_iocb_free(iocb);
> +	nfs_local_hdr_release(hdr, hdr->task.tk_ops);
> +}
> +
> +static void
> +nfs_local_read_aio_complete_work(struct work_struct *work)
> +{
> +	struct nfs_local_kiocb *iocb =3D container_of(work,
> +			struct nfs_local_kiocb, work);
> +
> +	nfs_local_pgio_release(iocb);
> +}
> +
> +/*
> + * Complete the I/O from iocb->kiocb.ki_complete()
> + *
> + * Note that this function can be called from a bottom half context,
> + * hence we need to queue the fput() etc to a workqueue
> + */
> +static void
> +nfs_local_pgio_complete(struct nfs_local_kiocb *iocb)
> +{
> +	queue_work(nfsiod_workqueue, &iocb->work);
> +}
> +
> +static void
> +nfs_local_read_done(struct nfs_local_kiocb *iocb, long status)
> +{
> +	struct nfs_pgio_header *hdr =3D iocb->hdr;
> +	struct file *filp =3D iocb->kiocb.ki_filp;
> +
> +	nfs_local_pgio_done(hdr, status);
> +
> +	if (hdr->res.count !=3D hdr->args.count ||
> +	=C2=A0=C2=A0=C2=A0 hdr->args.offset + hdr->res.count >=3D i_size_read(f=
ile_inode(filp)))
> +		hdr->res.eof =3D true;
> +
> +	dprintk("%s: read %ld bytes eof %d.\n", __func__,
> +			status > 0 ? status : 0, hdr->res.eof);
> +}
> +
> +static void
> +nfs_local_read_aio_complete(struct kiocb *kiocb, long ret)
> +{
> +	struct nfs_local_kiocb *iocb =3D container_of(kiocb,
> +			struct nfs_local_kiocb, kiocb);
> +
> +	nfs_local_read_done(iocb, ret);
> +	nfs_local_pgio_complete(iocb);
> +}
> +
> +static int
> +nfs_do_local_read(struct nfs_pgio_header *hdr, struct file *filp,
> +		const struct rpc_call_ops *call_ops)
> +{
> +	struct nfs_local_kiocb *iocb;
> +	struct iov_iter iter;
> +	ssize_t status;
> +
> +	dprintk("%s: vfs_read count=3D%u pos=3D%llu\n",
> +		__func__, hdr->args.count, hdr->args.offset);
> +
> +	iocb =3D nfs_local_iocb_alloc(hdr, filp, GFP_KERNEL);
> +	if (iocb =3D=3D NULL)
> +		return -ENOMEM;
> +	nfs_local_iter_init(&iter, iocb, READ);
> +
> +	nfs_local_pgio_init(hdr, call_ops);
> +	hdr->res.eof =3D false;
> +
> +	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
> +		INIT_WORK(&iocb->work, nfs_local_read_aio_complete_work);
> +		iocb->kiocb.ki_complete =3D nfs_local_read_aio_complete;
> +	}
> +
> +	status =3D filp->f_op->read_iter(&iocb->kiocb, &iter);
> +	if (status !=3D -EIOCBQUEUED) {
> +		nfs_local_read_done(iocb, status);
> +		nfs_local_pgio_release(iocb);
> +	}
> +	return 0;
> +}
> +
> +static void
> +nfs_copy_boot_verifier(struct nfs_write_verifier *verifier, struct inode=
 *inode)
> +{
> +	struct nfs_client *clp =3D NFS_SERVER(inode)->nfs_client;
> +	u32 *verf =3D (u32 *)verifier->data;
> +	int seq =3D 0;
> +
> +	do {
> +		read_seqbegin_or_lock(&clp->cl_boot_lock, &seq);
> +		verf[0] =3D (u32)clp->cl_nfssvc_boot.tv_sec;
> +		verf[1] =3D (u32)clp->cl_nfssvc_boot.tv_nsec;
> +	} while (need_seqretry(&clp->cl_boot_lock, seq));
> +	done_seqretry(&clp->cl_boot_lock, seq);
> +}
> +
> +static void
> +nfs_reset_boot_verifier(struct inode *inode)
> +{
> +	struct nfs_client *clp =3D NFS_SERVER(inode)->nfs_client;
> +
> +	write_seqlock(&clp->cl_boot_lock);
> +	ktime_get_real_ts64(&clp->cl_nfssvc_boot);
> +	write_sequnlock(&clp->cl_boot_lock);
> +}
> +
> +static void
> +nfs_set_local_verifier(struct inode *inode,
> +		struct nfs_writeverf *verf,
> +		enum nfs3_stable_how how)
> +{
> +
> +	nfs_copy_boot_verifier(&verf->verifier, inode);
> +	verf->committed =3D how;
> +}
> +
> +static void
> +nfs_get_vfs_attr(struct file *filp, struct nfs_fattr *fattr)
> +{
> +	struct kstat stat;
> +
> +	if (fattr !=3D NULL && vfs_getattr(&filp->f_path, &stat,
> +					 STATX_INO |
> +					 STATX_ATIME |
> +					 STATX_MTIME |
> +					 STATX_CTIME |
> +					 STATX_SIZE |
> +					 STATX_BLOCKS,
> +					 AT_STATX_SYNC_AS_STAT) =3D=3D 0) {
> +		fattr->valid =3D NFS_ATTR_FATTR_FILEID |
> +			NFS_ATTR_FATTR_CHANGE |
> +			NFS_ATTR_FATTR_SIZE |
> +			NFS_ATTR_FATTR_ATIME |
> +			NFS_ATTR_FATTR_MTIME |
> +			NFS_ATTR_FATTR_CTIME |
> +			NFS_ATTR_FATTR_SPACE_USED;
> +		fattr->fileid =3D stat.ino;
> +		fattr->size =3D stat.size;
> +		fattr->atime =3D stat.atime;
> +		fattr->mtime =3D stat.mtime;
> +		fattr->ctime =3D stat.ctime;
> +		fattr->change_attr =3D nfs_timespec_to_change_attr(&fattr->ctime);
> +		fattr->du.nfs3.used =3D stat.blocks << 9;
> +	}
> +}
> +
> +static void
> +nfs_local_write_done(struct nfs_local_kiocb *iocb, long status)
> +{
> +	struct nfs_pgio_header *hdr =3D iocb->hdr;
> +
> +	dprintk("%s: wrote %ld bytes.\n", __func__, status > 0 ? status : 0);
> +
> +	/* Handle short writes as if they are ENOSPC */
> +	if (status > 0 && status < hdr->args.count) {
> +		hdr->mds_offset +=3D status;
> +		hdr->args.offset +=3D status;
> +		hdr->args.pgbase +=3D status;
> +		hdr->args.count -=3D status;
> +		nfs_set_pgio_error(hdr, -ENOSPC, hdr->args.offset);
> +		status =3D -ENOSPC;
> +	}
> +	if (status < 0)
> +		nfs_reset_boot_verifier(hdr->inode);
> +	nfs_local_pgio_done(hdr, status);
> +}
> +
> +static void
> +nfs_local_write_aio_complete_work(struct work_struct *work)
> +{
> +	struct nfs_local_kiocb *iocb =3D container_of(work,
> +			struct nfs_local_kiocb, work);
> +
> +	nfs_get_vfs_attr(iocb->kiocb.ki_filp, iocb->hdr->res.fattr);
> +	nfs_local_pgio_release(iocb);
> +}
> +
> +static void
> +nfs_local_write_aio_complete(struct kiocb *kiocb, long ret)
> +{
> +	struct nfs_local_kiocb *iocb =3D container_of(kiocb,
> +			struct nfs_local_kiocb, kiocb);
> +
> +	nfs_local_write_done(iocb, ret);
> +	nfs_local_pgio_complete(iocb);
> +}
> +
> +static int
> +nfs_do_local_write(struct nfs_pgio_header *hdr, struct file *filp,
> +		const struct rpc_call_ops *call_ops)
> +{
> +	struct nfs_local_kiocb *iocb;
> +	struct iov_iter iter;
> +	ssize_t status;
> +
> +	dprintk("%s: vfs_write count=3D%u pos=3D%llu %s\n",
> +		__func__, hdr->args.count, hdr->args.offset,
> +		(hdr->args.stable =3D=3D NFS_UNSTABLE) ?=C2=A0 "unstable" : "stable");
> +
> +	iocb =3D nfs_local_iocb_alloc(hdr, filp, GFP_NOIO);
> +	if (iocb =3D=3D NULL)
> +		return -ENOMEM;
> +	nfs_local_iter_init(&iter, iocb, WRITE);
> +
> +	switch (hdr->args.stable) {
> +	default:
> +		break;
> +	case NFS_DATA_SYNC:
> +		iocb->kiocb.ki_flags |=3D IOCB_DSYNC;
> +		break;
> +	case NFS_FILE_SYNC:
> +		iocb->kiocb.ki_flags |=3D IOCB_DSYNC|IOCB_SYNC;
> +	}
> +	nfs_local_pgio_init(hdr, call_ops);
> +
> +	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
> +		INIT_WORK(&iocb->work, nfs_local_write_aio_complete_work);
> +		iocb->kiocb.ki_complete =3D nfs_local_write_aio_complete;
> +	}
> +
> +	nfs_set_local_verifier(hdr->inode, hdr->res.verf, hdr->args.stable);
> +
> +	file_start_write(filp);
> +	status =3D filp->f_op->write_iter(&iocb->kiocb, &iter);
> +	file_end_write(filp);
> +	if (status !=3D -EIOCBQUEUED) {
> +		nfs_local_write_done(iocb, status);
> +		nfs_get_vfs_attr(filp, hdr->res.fattr);
> +		nfs_local_pgio_release(iocb);
> +	}
> +	return 0;
> +}
> +
> +static struct file *
> +nfs_local_file_open_cached(struct nfs_client *clp, const struct cred *cr=
ed,
> +			=C2=A0=C2=A0 struct nfs_fh *fh, struct nfs_open_context *ctx)
> +{
> +	struct file *filp =3D ctx->local_filp;
> +
> +	if (!filp) {
> +		struct file *new =3D nfs_local_open_fh(clp, cred, fh, ctx->mode);
> +		if (IS_ERR_OR_NULL(new))
> +			return NULL;
> +		/* try to put this one in the slot */
> +		filp =3D cmpxchg(&ctx->local_filp, NULL, new);
> +		if (filp !=3D NULL)
> +			fput(new);
> +		else
> +			filp =3D new;
> +	}
> +	return get_file(filp);
> +}
> +
> +struct file *
> +nfs_local_file_open(struct nfs_client *clp, const struct cred *cred,
> +		=C2=A0=C2=A0=C2=A0 struct nfs_fh *fh, struct nfs_open_context *ctx)
> +{
> +	if (!nfs_server_is_local(clp))
> +		return NULL;
> +	return nfs_local_file_open_cached(clp, cred, fh, ctx);
> +}
> +
> +int
> +nfs_local_doio(struct nfs_client *clp, struct file *filp,
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nfs_pgio_header *hdr,
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct rpc_call_ops *call_op=
s)
> +{
> +	int status =3D 0;
> +
> +	if (!hdr->args.count)
> +		goto out_fput;
> +	/* Don't support filesystems without read_iter/write_iter */
> +	if (!filp->f_op->read_iter || !filp->f_op->write_iter) {
> +		nfs_local_disable(clp);
> +		status =3D -EAGAIN;
> +		goto out_fput;
> +	}
> +
> +	switch (hdr->rw_mode) {
> +	case FMODE_READ:
> +		status =3D nfs_do_local_read(hdr, filp, call_ops);
> +		break;
> +	case FMODE_WRITE:
> +		status =3D nfs_do_local_write(hdr, filp, call_ops);
> +		break;
> +	default:
> +		dprintk("%s: invalid mode: %d\n", __func__,
> +			hdr->rw_mode);
> +		status =3D -EINVAL;
> +	}
> +out_fput:
> +	if (status !=3D 0) {
> +		fput(filp);
> +		hdr->task.tk_status =3D status;
> +		nfs_local_hdr_release(hdr, call_ops);
> +	}
> +	return status;
> +}
> +
> +static void
> +nfs_local_init_commit(struct nfs_commit_data *data,
> +		const struct rpc_call_ops *call_ops)
> +{
> +	data->task.tk_ops =3D call_ops;
> +}
> +
> +static int
> +nfs_local_run_commit(struct file *filp, struct nfs_commit_data *data)
> +{
> +	loff_t start =3D data->args.offset;
> +	loff_t end =3D LLONG_MAX;
> +
> +	if (data->args.count > 0) {
> +		end =3D start + data->args.count - 1;
> +		if (end < start)
> +			end =3D LLONG_MAX;
> +	}
> +
> +	dprintk("%s: commit %llu - %llu\n", __func__, start, end);
> +	return vfs_fsync_range(filp, start, end, 0);
> +}
> +
> +static void
> +nfs_local_commit_done(struct nfs_commit_data *data, int status)
> +{
> +	if (status >=3D 0) {
> +		nfs_set_local_verifier(data->inode,
> +				data->res.verf,
> +				NFS_FILE_SYNC);
> +		data->res.op_status =3D NFS4_OK;
> +		data->task.tk_status =3D 0;
> +	} else {
> +		nfs_reset_boot_verifier(data->inode);
> +		data->res.op_status =3D nfs4errno(status);
> +		data->task.tk_status =3D status;
> +	}
> +}
> +
> +static void
> +nfs_local_release_commit_data(struct file *filp,
> +		struct nfs_commit_data *data,
> +		const struct rpc_call_ops *call_ops)
> +{
> +	fput(filp);
> +	call_ops->rpc_call_done(&data->task, data);
> +	call_ops->rpc_release(data);
> +}
> +
> +static struct nfs_local_fsync_ctx *
> +nfs_local_fsync_ctx_alloc(struct nfs_commit_data *data, struct file *fil=
p,
> +		gfp_t flags)
> +{
> +	struct nfs_local_fsync_ctx *ctx =3D kmalloc(sizeof(*ctx), flags);
> +
> +	if (ctx !=3D NULL) {
> +		ctx->filp =3D filp;
> +		ctx->data =3D data;
> +		INIT_WORK(&ctx->work, nfs_local_fsync_work);
> +		kref_init(&ctx->kref);
> +	}
> +	return ctx;
> +}
> +
> +static void
> +nfs_local_fsync_ctx_kref_free(struct kref *kref)
> +{
> +	kfree(container_of(kref, struct nfs_local_fsync_ctx, kref));
> +}
> +
> +static void
> +nfs_local_fsync_ctx_put(struct nfs_local_fsync_ctx *ctx)
> +{
> +	kref_put(&ctx->kref, nfs_local_fsync_ctx_kref_free);
> +}
> +
> +static void
> +nfs_local_fsync_ctx_free(struct nfs_local_fsync_ctx *ctx)
> +{
> +	nfs_local_release_commit_data(ctx->filp, ctx->data,
> +			ctx->data->task.tk_ops);
> +	nfs_local_fsync_ctx_put(ctx);
> +}
> +
> +static void
> +nfs_local_fsync_work(struct work_struct *work)
> +{
> +	struct nfs_local_fsync_ctx *ctx;
> +	int status;
> +
> +	ctx =3D container_of(work, struct nfs_local_fsync_ctx, work);
> +
> +	status =3D nfs_local_run_commit(ctx->filp, ctx->data);
> +	nfs_local_commit_done(ctx->data, status);
> +	nfs_local_fsync_ctx_free(ctx);
> +}
> +
> +int
> +nfs_local_commit(struct nfs_client *clp, struct file *filp,
> +		 struct nfs_commit_data *data,
> +		 const struct rpc_call_ops *call_ops, int how)
> +{
> +	struct nfs_local_fsync_ctx *ctx;
> +
> +	ctx =3D nfs_local_fsync_ctx_alloc(data, filp, GFP_KERNEL);
> +	if (!ctx) {
> +		nfs_local_commit_done(data, -ENOMEM);
> +		nfs_local_release_commit_data(filp, data, call_ops);
> +		return -ENOMEM;
> +	}
> +
> +	nfs_local_init_commit(data, call_ops);
> +	kref_get(&ctx->kref);
> +	queue_work(nfsiod_workqueue, &ctx->work);
> +	if (how & FLUSH_SYNC)
> +		flush_work(&ctx->work);
> +	nfs_local_fsync_ctx_put(ctx);
> +	return 0;
> +}
> +
> +static int
> +nfs_client_add_addr(struct nfs_client *clnt, char *buf, gfp_t flags)
> +{
> +	struct nfs_local_addr *addr;
> +	struct sockaddr *sap;
> +
> +	dprintk("%s: adding new local IP %s\n", __func__, buf);
> +	addr =3D kmalloc(sizeof(*addr), flags);
> +	if (!addr) {
> +		printk(KERN_WARNING "NFS: cannot alloc new addr\n");
> +		return -ENOMEM;
> +	}
> +	sap =3D (struct sockaddr *)&addr->address;
> +	addr->addrlen =3D rpc_pton(clnt->cl_net, buf, strlen(buf),
> +				sap, sizeof(addr->address));
> +	if (!addr->addrlen) {
> +		printk(KERN_WARNING "NFS: cannot parse new addr %s\n",
> +				buf);
> +		kfree(addr);
> +		return -EINVAL;
> +	}
> +	list_add(&addr->cl_addrs, &clnt->cl_local_addrs);
> +
> +	return 0;
> +}
> +
> +static int
> +nfs_client_add_v4_addr(struct nfs_client *clnt, struct in_device *indev,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *buf, size_t buflen)
> +{
> +	struct in_ifaddr *ifa;
> +	int ret;
> +
> +	in_dev_for_each_ifa_rtnl(ifa, indev) {
> +		snprintf(buf, buflen, "%pI4", &ifa->ifa_local);
> +		ret =3D nfs_client_add_addr(clnt, buf, GFP_KERNEL);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +#if IS_ENABLED(CONFIG_IPV6)
> +static int
> +nfs_client_add_v6_addr(struct nfs_client *clnt, struct inet6_dev *in6dev=
,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *buf, size_t buflen)
> +{
> +	struct inet6_ifaddr *ifp;
> +	int ret =3D 0;
> +
> +	read_lock_bh(&in6dev->lock);
> +	list_for_each_entry(ifp, &in6dev->addr_list, if_list) {
> +		rpc_ntop6_addr_noscopeid(&ifp->addr, buf, buflen);
> +		ret =3D nfs_client_add_addr(clnt, buf, GFP_ATOMIC);
> +		if (ret < 0)
> +			goto out;
> +	}
> +out:
> +	read_unlock_bh(&in6dev->lock);
> +	return ret;
> +}
> +#else /* CONFIG_IPV6 */
> +static int
> +nfs_client_add_v6_addr(struct nfs_client *clnt, struct inet6_dev *in6dev=
,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *buf, size_t buflen)
> +{
> +	return 0;
> +}
> +#endif
> +
> +/* Find out all local IP addresses. Ignore errors
> + * because local IO can be optional.
> + */
> +void
> +nfs_probe_local_addr(struct nfs_client *clnt)
> +{
> +	struct net_device *dev;
> +	struct in_device *indev;
> +	struct inet6_dev *in6dev;
> +	char buf[INET6_ADDRSTRLEN + IPV6_SCOPE_ID_LEN];
> +	size_t buflen =3D sizeof(buf);
> +
> +	rtnl_lock();
> +
> +	for_each_netdev(clnt->cl_net, dev) {
> +		if (dev->type =3D=3D ARPHRD_LOOPBACK ||
> +		=C2=A0=C2=A0=C2=A0 !(dev->flags & IFF_UP))
> +			continue;
> +		indev =3D __in_dev_get_rtnl(dev);
> +		if (indev &&
> +		=C2=A0=C2=A0=C2=A0 nfs_client_add_v4_addr(clnt, indev, buf, buflen) < =
0)
> +			break;
> +		in6dev =3D __in6_dev_get(dev);
> +		if (in6dev &&
> +		=C2=A0=C2=A0=C2=A0 nfs_client_add_v6_addr(clnt, in6dev, buf, buflen) <=
 0)
> +			break;
> +	}
> +
> +	rtnl_unlock();
> +}
> diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
> index 1e710654af11..45d4086cdeb1 100644
> --- a/fs/nfs/nfstrace.h
> +++ b/fs/nfs/nfstrace.h
> @@ -1681,6 +1681,35 @@ TRACE_EVENT(nfs_mount_path,
> =C2=A0	TP_printk("path=3D'%s'", __get_str(path))
> =C2=A0);
> =C2=A0
> +TRACE_EVENT(nfs_local_open_fh,
> +		TP_PROTO(
> +			const struct nfs_fh *fh,
> +			fmode_t fmode,
> +			int error
> +		),
> +
> +		TP_ARGS(fh, fmode, error),
> +
> +		TP_STRUCT__entry(
> +			__field(int, error)
> +			__field(u32, fhandle)
> +			__field(unsigned int, fmode)
> +		),
> +
> +		TP_fast_assign(
> +			__entry->error =3D error;
> +			__entry->fhandle =3D nfs_fhandle_hash(fh);
> +			__entry->fmode =3D (__force unsigned int)fmode;
> +		),
> +
> +		TP_printk(
> +			"error=3D%d fhandle=3D0x%08x mode=3D%s",
> +			__entry->error,
> +			__entry->fhandle,
> +			show_fs_fmode_flags(__entry->fmode)
> +		)
> +);
> +
> =C2=A0DECLARE_EVENT_CLASS(nfs_xdr_event,
> =C2=A0		TP_PROTO(
> =C2=A0			const struct xdr_stream *xdr,
> diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
> index 3786d767e2ff..9210a1821ec9 100644
> --- a/fs/nfs/pagelist.c
> +++ b/fs/nfs/pagelist.c
> @@ -848,7 +848,8 @@ int nfs_initiate_pgio(struct nfs_pageio_descriptor *d=
esc,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nfs_client *clp, struct rpc=
_clnt *rpc_clnt,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nfs_pgio_header *hdr, const=
 struct cred *cred,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct nfs_rpc_ops *rpc_ops,
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct rpc_call_ops *call_ops, in=
t how, int flags)
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct rpc_call_ops *call_ops, in=
t how, int flags,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct file *localio)
> =C2=A0{
> =C2=A0	struct rpc_task *task;
> =C2=A0	struct rpc_message msg =3D {
> @@ -878,10 +879,16 @@ int nfs_initiate_pgio(struct nfs_pageio_descriptor =
*desc,
> =C2=A0		hdr->args.count,
> =C2=A0		(unsigned long long)hdr->args.offset);
> =C2=A0
> +	if (localio) {
> +		nfs_local_doio(clp, localio, hdr, call_ops);
> +		goto out;
> +	}
> +
> =C2=A0	task =3D rpc_run_task(&task_setup_data);
> =C2=A0	if (IS_ERR(task))
> =C2=A0		return PTR_ERR(task);
> =C2=A0	rpc_put_task(task);
> +out:
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(nfs_initiate_pgio);
> @@ -1080,7 +1087,8 @@ static int nfs_generic_pg_pgios(struct nfs_pageio_d=
escriptor *desc)
> =C2=A0					NFS_PROTO(hdr->inode),
> =C2=A0					desc->pg_rpc_callops,
> =C2=A0					desc->pg_ioflags,
> -					RPC_TASK_CRED_NOREF | task_flags);
> +					RPC_TASK_CRED_NOREF | task_flags,
> +					NULL);
> =C2=A0	}
> =C2=A0	return ret;
> =C2=A0}
> diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
> index b29b50c2c933..ac3c5e6d4c5e 100644
> --- a/fs/nfs/pnfs_nfs.c
> +++ b/fs/nfs/pnfs_nfs.c
> @@ -538,7 +538,7 @@ pnfs_generic_commit_pagelist(struct inode *inode, str=
uct list_head *mds_pages,
> =C2=A0					=C2=A0=C2=A0=C2=A0 NFS_CLIENT(inode), data,
> =C2=A0					=C2=A0=C2=A0=C2=A0 NFS_PROTO(data->inode),
> =C2=A0					=C2=A0=C2=A0=C2=A0 data->mds_ops, how,
> -					=C2=A0=C2=A0=C2=A0 RPC_TASK_CRED_NOREF);
> +					=C2=A0=C2=A0=C2=A0 RPC_TASK_CRED_NOREF, NULL);
> =C2=A0		} else {
> =C2=A0			nfs_init_commit(data, NULL, data->lseg, cinfo);
> =C2=A0			initiate_commit(data, how);
> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> index c9cfa1308264..ba0b36b15bc1 100644
> --- a/fs/nfs/write.c
> +++ b/fs/nfs/write.c
> @@ -1672,7 +1672,8 @@ int nfs_initiate_commit(struct nfs_client *clp,
> =C2=A0			struct nfs_commit_data *data,
> =C2=A0			const struct nfs_rpc_ops *nfs_ops,
> =C2=A0			const struct rpc_call_ops *call_ops,
> -			int how, int flags)
> +			int how, int flags,
> +			struct file *localio)
> =C2=A0{
> =C2=A0	struct rpc_task *task;
> =C2=A0	int priority =3D flush_task_priority(how);
> @@ -1691,6 +1692,7 @@ int nfs_initiate_commit(struct nfs_client *clp,
> =C2=A0		.flags =3D RPC_TASK_ASYNC | flags,
> =C2=A0		.priority =3D priority,
> =C2=A0	};
> +	int status =3D 0;
> =C2=A0
> =C2=A0	if (nfs_server_capable(data->inode, NFS_CAP_MOVEABLE))
> =C2=A0		task_setup_data.flags |=3D RPC_TASK_MOVEABLE;
> @@ -1701,13 +1703,19 @@ int nfs_initiate_commit(struct nfs_client *clp,
> =C2=A0
> =C2=A0	dprintk("NFS: initiated commit call\n");
> =C2=A0
> +	if (localio) {
> +		nfs_local_commit(clp, localio, data, call_ops, how);
> +		goto out;
> +	}
> +
> =C2=A0	task =3D rpc_run_task(&task_setup_data);
> =C2=A0	if (IS_ERR(task))
> =C2=A0		return PTR_ERR(task);
> =C2=A0	if (how & FLUSH_SYNC)
> =C2=A0		rpc_wait_for_completion_task(task);
> =C2=A0	rpc_put_task(task);
> -	return 0;
> +out:
> +	return status;
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(nfs_initiate_commit);
> =C2=A0
> @@ -1819,7 +1827,7 @@ nfs_commit_list(struct inode *inode, struct list_he=
ad *head, int how,
> =C2=A0	return nfs_initiate_commit(NFS_SERVER(inode)->nfs_client,
> =C2=A0				=C2=A0=C2=A0 NFS_CLIENT(inode), data, NFS_PROTO(inode),
> =C2=A0				=C2=A0=C2=A0 data->mds_ops, how,
> -				=C2=A0=C2=A0 RPC_TASK_CRED_NOREF | task_flags);
> +				=C2=A0=C2=A0 RPC_TASK_CRED_NOREF | task_flags, NULL);
> =C2=A0}
> =C2=A0
> =C2=A0/*
> diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
> index b8736a82e57c..702f277394f1 100644
> --- a/fs/nfsd/Makefile
> +++ b/fs/nfsd/Makefile
> @@ -13,7 +13,7 @@ nfsd-y			+=3D trace.o
> =C2=A0nfsd-y=C2=A0			+=3D nfssvc.o nfsctl.o nfsfh.o vfs.o \
> =C2=A0			=C2=A0=C2=A0 export.o auth.o lockd.o nfscache.o \
> =C2=A0			=C2=A0=C2=A0 stats.o filecache.o nfs3proc.o nfs3xdr.o \
> -			=C2=A0=C2=A0 netlink.o
> +			=C2=A0=C2=A0 netlink.o localio.o

Isn't there a Kconfig option this should be behind?

> =C2=A0nfsd-$(CONFIG_NFSD_V2) +=3D nfsproc.o nfsxdr.o
> =C2=A0nfsd-$(CONFIG_NFSD_V2_ACL) +=3D nfs2acl.o
> =C2=A0nfsd-$(CONFIG_NFSD_V3_ACL) +=3D nfs3acl.o
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index ad9083ca144b..99631fa56662 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -52,7 +52,7 @@
> =C2=A0#define NFSD_FILE_CACHE_UP		=C2=A0=C2=A0=C2=A0=C2=A0 (0)
> =C2=A0
> =C2=A0/* We only care about NFSD_MAY_READ/WRITE for this cache */
> -#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE)
> +#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE|NFSD_MAY_LOCALI=
O)
> =C2=A0
> =C2=A0static DEFINE_PER_CPU(unsigned long, nfsd_file_cache_hits);
> =C2=A0static DEFINE_PER_CPU(unsigned long, nfsd_file_acquisitions);
> diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> new file mode 100644
> index 000000000000..ff68454a4017
> --- /dev/null
> +++ b/fs/nfsd/localio.c
> @@ -0,0 +1,179 @@
> +/*
> + * NFS server support for local clients to bypass network stack
> + *
> + * Copyright (C) 2014 Weston Andros Adamson <dros@primarydata.com>
> + */
> +
> +#include <linux/exportfs.h>
> +#include <linux/sunrpc/svcauth_gss.h>
> +#include <linux/sunrpc/clnt.h>
> +#include <linux/nfs.h>
> +#include <linux/string.h>
> +
> +#include "nfsd.h"
> +#include "vfs.h"
> +#include "netns.h"
> +#include "filecache.h"
> +
> +#define NFSDDBG_FACILITY		NFSDDBG_FH
> +
> +static void
> +nfsd_local_fakerqst_destroy(struct svc_rqst *rqstp)
> +{
> +	if (rqstp->rq_client)
> +		auth_domain_put(rqstp->rq_client);
> +	if (rqstp->rq_cred.cr_group_info)
> +		put_group_info(rqstp->rq_cred.cr_group_info);
> +	kfree(rqstp->rq_cred.cr_principal);
> +	kfree(rqstp->rq_xprt);
> +	kfree(rqstp);
> +}
> +
> +static struct svc_rqst *
> +nfsd_local_fakerqst_create(struct rpc_clnt *rpc_clnt, const struct cred =
*cred)
> +{
> +	struct svc_rqst *rqstp;
> +	struct net *net =3D rpc_net_ns(rpc_clnt);
> +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> +	int status;
> +
> +	if (!nn->nfsd_serv) {
> +		dprintk("%s: localio denied. Server not running\n", __func__);
> +		return ERR_PTR(-ENXIO);
> +	}
> +

Note that the above check is racy. The nfsd_serv can go away at any
time since you're not holding the (global) nfsd_mutex (I assume?).

> +	rqstp =3D kzalloc(sizeof(*rqstp), GFP_KERNEL);
> +	if (!rqstp)
> +		return ERR_PTR(-ENOMEM);
> +
> +	rqstp->rq_xprt =3D kzalloc(sizeof(*rqstp->rq_xprt), GFP_KERNEL);
> +	if (!rqstp->rq_xprt) {
> +		status =3D -ENOMEM;
> +		goto out_err;
> +	}
> +
> +	rqstp->rq_xprt->xpt_net =3D net;
> +	__set_bit(RQ_SECURE, &rqstp->rq_flags);
> +	rqstp->rq_proc =3D 1;
> +	rqstp->rq_vers =3D 3;
> +	rqstp->rq_prot =3D IPPROTO_TCP;
> +	rqstp->rq_server =3D nn->nfsd_serv;
> +

I suspect you need to carry a reference of some sort so that the
nfsd_serv doesn't go away out from under you while this is running,
since this is not operating in nfsd thread context.

Typically, every nfsd thread holds a reference to the serv (in serv-
>sv_nrthreads), so that when you shut down all of the threads, it goes
away. The catch is that that refcount is currently under the protection
of the global nfsd_mutex and I doubt you want to take that in this
codepath.



> +	/* Note: we're connecting to ourself, so source addr =3D=3D peer addr *=
/
> +	rqstp->rq_addrlen =3D rpc_peeraddr(rpc_clnt,
> +			(struct sockaddr *)&rqstp->rq_addr,
> +			sizeof(rqstp->rq_addr));
> +
> +	if (!rpcauth_map_to_svc_cred(rpc_clnt->cl_auth, cred,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 &rqstp->rq_cred)) {
> +		dprintk("%s :map cred failed\n", __func__);
> +		status =3D -EINVAL;
> +		goto out_err;
> +	}
> +
> +	/*
> +	 * set up enough for svcauth_unix_set_client to be able to wait
> +	 * for the cache downcall. Note that we do _not_ want to allow the
> +	 * request to be deferred for later revisit since this rqst and xprt
> +	 * are not set up to run inside of the normal svc_rqst engine.
> +	 */
> +	INIT_LIST_HEAD(&rqstp->rq_xprt->xpt_deferred);
> +	kref_init(&rqstp->rq_xprt->xpt_ref);
> +	spin_lock_init(&rqstp->rq_xprt->xpt_lock);
> +	rqstp->rq_chandle.thread_wait =3D 5 * HZ;
> +
> +	status =3D svcauth_unix_set_client(rqstp);
> +	switch (status) {
> +	case SVC_OK:
> +		break;
> +	case SVC_DENIED:
> +		status =3D -ENXIO;
> +		dprintk("%s: client %pISpc denied localio access\n",
> +				__func__, (struct sockaddr *)&rqstp->rq_addr);
> +		goto out_err;
> +	default:
> +		status =3D -ETIMEDOUT;
> +		dprintk("%s: client %pISpc temporarily denied localio access\n",
> +				__func__, (struct sockaddr *)&rqstp->rq_addr);
> +		goto out_err;
> +	}
> +
> +	return rqstp;
> +
> +out_err:
> +	nfsd_local_fakerqst_destroy(rqstp);
> +	return ERR_PTR(status);
> +}
> +
> +/*
> + * nfsd_open_local_fh - lookup a local filehandle @nfs_fh and map to @fi=
le
> + *
> + * This function maps a local fh to a path on a local filesystem.
> + * This is useful when the nfs client has the local server mounted - it =
can
> + * avoid all the NFS overhead with reads, writes and commits.
> + *
> + * on successful return, caller is responsible for calling path_put. Als=
o
> + * note that this is called from nfs.ko via find_symbol() to avoid an ex=
plicit
> + * dependency on knfsd. So, there is no forward declaration in a header =
file
> + * for it.
> + */
> +int nfsd_open_local_fh(struct rpc_clnt *rpc_clnt,
> +			 const struct cred *cred,
> +			 const struct nfs_fh *nfs_fh,
> +			 const fmode_t fmode,
> +			 struct file **pfilp)
> +{
> +	const struct cred *save_cred;
> +	struct svc_rqst *rqstp;
> +	struct svc_fh fh;
> +	struct nfsd_file *nf;
> +	int status =3D 0;
> +	int mayflags =3D NFSD_MAY_LOCALIO;
> +	__be32 beres;
> +
> +	/* Save creds before calling into nfsd */
> +	save_cred =3D get_current_cred();
> +
> +	rqstp =3D nfsd_local_fakerqst_create(rpc_clnt, cred);
> +	if (IS_ERR(rqstp)) {
> +		status =3D PTR_ERR(rqstp);
> +		goto out_revertcred;
> +	}
> +
> +	/* nfs_fh -> svc_fh */
> +	if (nfs_fh->size > NFS4_FHSIZE) {
> +		status =3D -EINVAL;
> +		goto out;
> +	}
> +	fh_init(&fh, NFS4_FHSIZE);
> +	fh.fh_handle.fh_size =3D nfs_fh->size;
> +	memcpy(fh.fh_handle.fh_raw, nfs_fh->data, nfs_fh->size);
> +
> +	if (fmode & FMODE_READ)
> +		mayflags |=3D NFSD_MAY_READ;
> +	if (fmode & FMODE_WRITE)
> +		mayflags |=3D NFSD_MAY_WRITE;
> +
> +	beres =3D nfsd_file_acquire(rqstp, &fh, mayflags, &nf);
> +	if (beres) {
> +		status =3D nfs_stat_to_errno(be32_to_cpu(beres));
> +		dprintk("%s: fh_verify failed %d\n", __func__, status);
> +		goto out_fh_put;
> +	}
> +
> +	*pfilp =3D get_file(nf->nf_file);
> +
> +	nfsd_file_put(nf);
> +out_fh_put:
> +	fh_put(&fh);
> +
> +out:
> +	nfsd_local_fakerqst_destroy(rqstp);
> +out_revertcred:
> +	revert_creds(save_cred);
> +	return status;
> +}
> +EXPORT_SYMBOL_GPL(nfsd_open_local_fh);
> +
> +/* Compile time type checking, not used by anything */
> +static nfs_to_nfsd_open_t __maybe_unused nfsd_open_local_fh_typecheck =
=3D nfsd_open_local_fh;
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 77bbd23aa150..9c0610fdd11c 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -86,7 +86,8 @@ DEFINE_NFSD_XDR_ERR_EVENT(cant_encode);
> =C2=A0		{ NFSD_MAY_NOT_BREAK_LEASE,	"NOT_BREAK_LEASE" },	\
> =C2=A0		{ NFSD_MAY_BYPASS_GSS,		"BYPASS_GSS" },		\
> =C2=A0		{ NFSD_MAY_READ_IF_EXEC,	"READ_IF_EXEC" },	\
> -		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" })
> +		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" },	\
> +		{ NFSD_MAY_LOCALIO,		"LOCALIO" })
> =C2=A0
> =C2=A0TRACE_EVENT(nfsd_compound,
> =C2=A0	TP_PROTO(
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index 57cd70062048..91c50649a8c7 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -36,6 +36,8 @@
> =C2=A0#define NFSD_MAY_CREATE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE)
> =C2=A0#define NFSD_MAY_REMOVE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE|NFSD_MAY_TRU=
NC)
> =C2=A0
> +#define NFSD_MAY_LOCALIO		0x800000
> +
> =C2=A0struct nfsd_file;
> =C2=A0
> =C2=A0/*
> @@ -158,6 +160,12 @@ __be32		nfsd_permission(struct svc_rqst *, struct sv=
c_export *,
> =C2=A0
> =C2=A0void		nfsd_filp_close(struct file *fp);
> =C2=A0
> +int		nfsd_open_local_fh(struct rpc_clnt *rpc_clnt,
> +				=C2=A0=C2=A0 const struct cred *cred,
> +				=C2=A0=C2=A0 const struct nfs_fh *nfs_fh,
> +				=C2=A0=C2=A0 const fmode_t fmode,
> +				=C2=A0=C2=A0 struct file **pfilp);
> +
> =C2=A0static inline int fh_want_write(struct svc_fh *fh)
> =C2=A0{
> =C2=A0	int ret;
> diff --git a/include/linux/nfs.h b/include/linux/nfs.h
> index b94f51d17bc5..80843764fad3 100644
> --- a/include/linux/nfs.h
> +++ b/include/linux/nfs.h
> @@ -8,6 +8,8 @@
> =C2=A0#ifndef _LINUX_NFS_H
> =C2=A0#define _LINUX_NFS_H
> =C2=A0
> +#include <linux/cred.h>
> +#include <linux/sunrpc/auth.h>
> =C2=A0#include <linux/sunrpc/msg_prot.h>
> =C2=A0#include <linux/string.h>
> =C2=A0#include <linux/errno.h>
> @@ -109,6 +111,10 @@ static inline int nfs_stat_to_errno(enum nfs_stat st=
atus)
> =C2=A0	return nfs_common_errtbl[i].errno;
> =C2=A0}
> =C2=A0
> +typedef int (*nfs_to_nfsd_open_t)(struct rpc_clnt *, const struct cred *=
,
> +				=C2=A0 const struct nfs_fh *, const fmode_t,
> +				=C2=A0 struct file **);
> +
> =C2=A0#ifdef CONFIG_CRC32
> =C2=A0/**
> =C2=A0 * nfs_fhandle_hash - calculate the crc32 hash for the filehandle
> diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
> index 039898d70954..a0bb947fdd1d 100644
> --- a/include/linux/nfs_fs.h
> +++ b/include/linux/nfs_fs.h
> @@ -96,6 +96,8 @@ struct nfs_open_context {
> =C2=A0	struct list_head list;
> =C2=A0	struct nfs4_threshold	*mdsthreshold;
> =C2=A0	struct rcu_head	rcu_head;
> +
> +	struct file *local_filp;
> =C2=A0};
> =C2=A0
> =C2=A0struct nfs_open_dir_context {
> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> index 82a6f66fe1d0..6b603b0247f1 100644
> --- a/include/linux/nfs_fs_sb.h
> +++ b/include/linux/nfs_fs_sb.h
> @@ -49,12 +49,14 @@ struct nfs_client {
> =C2=A0#define NFS_CS_DS		7		/* - Server is a DS */
> =C2=A0#define NFS_CS_REUSEPORT	8		/* - reuse src port on reconnect */
> =C2=A0#define NFS_CS_PNFS		9		/* - Server used for pnfs */
> +#define NFS_CS_LOCAL_IO		10		/* - client is local */
> =C2=A0	struct sockaddr_storage	cl_addr;	/* server identifier */
> =C2=A0	size_t			cl_addrlen;
> =C2=A0	char *			cl_hostname;	/* hostname of server */
> =C2=A0	char *			cl_acceptor;	/* GSSAPI acceptor name */
> =C2=A0	struct list_head	cl_share_link;	/* link in global client list */
> =C2=A0	struct list_head	cl_superblocks;	/* List of nfs_server structs */
> +	struct list_head	cl_local_addrs;	/* List of local addresses */
> =C2=A0

Is the above needed? I thought you weren't tracking addresses now and
were using the new RPC protocol to determine locality?

OIC, this goes away in patch #20...



> =C2=A0	struct rpc_clnt *	cl_rpcclient;
> =C2=A0	const struct nfs_rpc_ops *rpc_ops;	/* NFS protocol vector */
> diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> index d09b9773b20c..764513a61601 100644
> --- a/include/linux/nfs_xdr.h
> +++ b/include/linux/nfs_xdr.h
> @@ -1605,6 +1605,7 @@ enum {
> =C2=A0	NFS_IOHDR_RESEND_PNFS,
> =C2=A0	NFS_IOHDR_RESEND_MDS,
> =C2=A0	NFS_IOHDR_UNSTABLE_WRITES,
> +	NFS_IOHDR_ODIRECT,
> =C2=A0};
> =C2=A0
> =C2=A0struct nfs_io_completion;

--=20
Jeff Layton <jlayton@kernel.org>

