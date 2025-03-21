Return-Path: <linux-nfs+bounces-10737-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 284DCA6BCF1
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Mar 2025 15:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C5193B1421
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Mar 2025 14:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AF078F29;
	Fri, 21 Mar 2025 14:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poaUTE/u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA934C85
	for <linux-nfs@vger.kernel.org>; Fri, 21 Mar 2025 14:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567308; cv=none; b=A2JHcevLNqDQtCNO3TS1DZDnxz4PjienpuBTQ4B2YsRU7vl7ymajyxoNj2ubHZj6dkv0VkY+Hy0ffPIGOOldp7aMOqoFiyXDKkJ1EueSorBK3FF5EbOhu6XiT4NqdXWcfm+eXrFboJoq4xjJj6o7FScGAkkDtU+YLggRkaiy2kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567308; c=relaxed/simple;
	bh=5OOKoPS66au6Bchz7i8tTtwkvo32LodZmz/CAuUF6Qc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pKWQBepGM8VjoYzEiutuZS3ys1rjJKDX3Ki/irDyBv282EYqsCFMBSrXuRMCP7Ug/OKVhPCzxbgQ/Q0poU9w37CXW0tFDyoPy/Uahf+x1r1TQT2GEbV9VTPSeWtL+ROC/GQ1K1zLJDA8M6JTgFgxPCVSAFnoTolM9WAdANG0Qmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poaUTE/u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B17C4CEE3;
	Fri, 21 Mar 2025 14:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742567308;
	bh=5OOKoPS66au6Bchz7i8tTtwkvo32LodZmz/CAuUF6Qc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=poaUTE/uyL0WJMKczQjcts235BZBK22f9Bqahfq5Q6kbjGWCokCq0IUEFG9C2glpj
	 zlObtRyTDAMGVpPa3mZLpO1GrAKdJV3fWfcagFleTRjbiM0FqPP7zyOsl1l2v/xrKj
	 BpzUuORwdz6X1c4pTeKcdudwTijicKlydR3x7fVjghYmPrC3BrfDzmGP4uDDz5fAnu
	 S7gdzhUwRQ83mY0uzumY0hjdQlqQ+WfljyKwj/aqkTivuwjOrNv2Q52eS3nN747GZz
	 SyZ3Yc+eyw4bsCQNJlwvOgEV9dgzXN50uaaXa4Fbk4BQLnj2anxTHSdwu3H6BW1808
	 HI3aERIosljLw==
Message-ID: <c50797895e967be97f58c041d368c245b748d9b0.camel@kernel.org>
Subject: Re: [PATCH RFC v2 3/4] pNFS/flexfiles: Treat ENETUNREACH errors as
 fatal in containers
From: Jeff Layton <jlayton@kernel.org>
To: trondmy@kernel.org, linux-nfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 21 Mar 2025 10:28:26 -0400
In-Reply-To: <ec593b842e52f0b3966b8a2073ea3fb3f9666fd6.1742502819.git.trond.myklebust@hammerspace.com>
References: <cover.1742502819.git.trond.myklebust@hammerspace.com>
	 <ec593b842e52f0b3966b8a2073ea3fb3f9666fd6.1742502819.git.trond.myklebust@hammerspace.com>
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

On Thu, 2025-03-20 at 16:40 -0400, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> Propagate the NFS_MOUNT_NETUNREACH_FATAL flag to work with the pNFS
> flexfiles client. In these circumstances, the client needs to treat the
> ENETDOWN and ENETUNREACH errors as fatal, and should abandon the
> attempted I/O.
>=20
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/flexfilelayout/flexfilelayout.c | 23 +++++++++++++++++++++--
>  fs/nfs/nfs3client.c                    |  2 ++
>  fs/nfs/nfs4client.c                    |  5 +++++
>  include/linux/nfs4.h                   |  1 +
>  4 files changed, 29 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayo=
ut/flexfilelayout.c
> index 98b45b636be3..f89fdba7289d 100644
> --- a/fs/nfs/flexfilelayout/flexfilelayout.c
> +++ b/fs/nfs/flexfilelayout/flexfilelayout.c
> @@ -1154,10 +1154,14 @@ static int ff_layout_async_handle_error_v4(struct=
 rpc_task *task,
>  		rpc_wake_up(&tbl->slot_tbl_waitq);
>  		goto reset;
>  	/* RPC connection errors */
> +	case -ENETDOWN:
> +	case -ENETUNREACH:
> +		if (test_bit(NFS_CS_NETUNREACH_FATAL, &clp->cl_flags))
> +			return -NFS4ERR_FATAL_IOERROR;
> +		fallthrough;
>  	case -ECONNREFUSED:
>  	case -EHOSTDOWN:
>  	case -EHOSTUNREACH:
> -	case -ENETUNREACH:
>  	case -EIO:
>  	case -ETIMEDOUT:
>  	case -EPIPE:
> @@ -1183,6 +1187,7 @@ static int ff_layout_async_handle_error_v4(struct r=
pc_task *task,
> =20
>  /* Retry all errors through either pNFS or MDS except for -EJUKEBOX */
>  static int ff_layout_async_handle_error_v3(struct rpc_task *task,
> +					   struct nfs_client *clp,
>  					   struct pnfs_layout_segment *lseg,
>  					   u32 idx)
>  {
> @@ -1200,6 +1205,11 @@ static int ff_layout_async_handle_error_v3(struct =
rpc_task *task,
>  	case -EJUKEBOX:
>  		nfs_inc_stats(lseg->pls_layout->plh_inode, NFSIOS_DELAY);
>  		goto out_retry;
> +	case -ENETDOWN:
> +	case -ENETUNREACH:
> +		if (test_bit(NFS_CS_NETUNREACH_FATAL, &clp->cl_flags))
> +			return -NFS4ERR_FATAL_IOERROR;
> +		fallthrough;
>  	default:
>  		dprintk("%s DS connection error %d\n", __func__,
>  			task->tk_status);
> @@ -1234,7 +1244,7 @@ static int ff_layout_async_handle_error(struct rpc_=
task *task,
> =20
>  	switch (vers) {
>  	case 3:
> -		return ff_layout_async_handle_error_v3(task, lseg, idx);
> +		return ff_layout_async_handle_error_v3(task, clp, lseg, idx);
>  	case 4:
>  		return ff_layout_async_handle_error_v4(task, state, clp,
>  						       lseg, idx);
> @@ -1337,6 +1347,9 @@ static int ff_layout_read_done_cb(struct rpc_task *=
task,
>  		return task->tk_status;
>  	case -EAGAIN:
>  		goto out_eagain;
> +	case -NFS4ERR_FATAL_IOERROR:
> +		task->tk_status =3D -EIO;
> +		return 0;
>  	}
> =20
>  	return 0;
> @@ -1507,6 +1520,9 @@ static int ff_layout_write_done_cb(struct rpc_task =
*task,
>  		return task->tk_status;
>  	case -EAGAIN:
>  		return -EAGAIN;
> +	case -NFS4ERR_FATAL_IOERROR:
> +		task->tk_status =3D -EIO;
> +		return 0;
>  	}
> =20
>  	if (hdr->res.verf->committed =3D=3D NFS_FILE_SYNC ||
> @@ -1551,6 +1567,9 @@ static int ff_layout_commit_done_cb(struct rpc_task=
 *task,
>  	case -EAGAIN:
>  		rpc_restart_call_prepare(task);
>  		return -EAGAIN;
> +	case -NFS4ERR_FATAL_IOERROR:
> +		task->tk_status =3D -EIO;
> +		return 0;
>  	}
> =20
>  	ff_layout_set_layoutcommit(data->inode, data->lseg, data->lwb);
> diff --git a/fs/nfs/nfs3client.c b/fs/nfs/nfs3client.c
> index b0c8a39c2bbd..0d7310c1ee0c 100644
> --- a/fs/nfs/nfs3client.c
> +++ b/fs/nfs/nfs3client.c
> @@ -120,6 +120,8 @@ struct nfs_client *nfs3_set_ds_client(struct nfs_serv=
er *mds_srv,
> =20
>  	if (mds_srv->flags & NFS_MOUNT_NORESVPORT)
>  		__set_bit(NFS_CS_NORESVPORT, &cl_init.init_flags);
> +	if (test_bit(NFS_CS_NETUNREACH_FATAL, &mds_clp->cl_flags))
> +		__set_bit(NFS_CS_NETUNREACH_FATAL, &cl_init.init_flags);
> =20
>  	__set_bit(NFS_CS_DS, &cl_init.init_flags);
> =20
> diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> index 8f7d40844cdc..9bfb88d791ab 100644
> --- a/fs/nfs/nfs4client.c
> +++ b/fs/nfs/nfs4client.c
> @@ -939,6 +939,9 @@ static int nfs4_set_client(struct nfs_server *server,
>  		__set_bit(NFS_CS_TSM_POSSIBLE, &cl_init.init_flags);
>  	server->port =3D rpc_get_port((struct sockaddr *)addr);
> =20
> +	if (server->options & NFS_MOUNT_NETUNREACH_FATAL)

^^^

That should be checking server->flags.

With that fix in place, this patchset seems to do the right thing. It
takes roughly a minute or two for the RPCs to expire, but they do
eventually expire now.

Nice work!


> +		__set_bit(NFS_CS_NETUNREACH_FATAL, &cl_init.init_flags);
> +
>  	/* Allocate or find a client reference we can use */
>  	clp =3D nfs_get_client(&cl_init);
>  	if (IS_ERR(clp))
> @@ -1013,6 +1016,8 @@ struct nfs_client *nfs4_set_ds_client(struct nfs_se=
rver *mds_srv,
> =20
>  	if (mds_srv->flags & NFS_MOUNT_NORESVPORT)
>  		__set_bit(NFS_CS_NORESVPORT, &cl_init.init_flags);
> +	if (test_bit(NFS_CS_NETUNREACH_FATAL, &mds_clp->cl_flags))
> +		__set_bit(NFS_CS_NETUNREACH_FATAL, &cl_init.init_flags);
> =20
>  	__set_bit(NFS_CS_PNFS, &cl_init.init_flags);
>  	cl_init.max_connect =3D NFS_MAX_TRANSPORTS;
> diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
> index 5fa60fe441b5..d8cad844870a 100644
> --- a/include/linux/nfs4.h
> +++ b/include/linux/nfs4.h
> @@ -300,6 +300,7 @@ enum nfsstat4 {
>  /* error codes for internal client use */
>  #define NFS4ERR_RESET_TO_MDS   12001
>  #define NFS4ERR_RESET_TO_PNFS  12002
> +#define NFS4ERR_FATAL_IOERROR  12003
> =20
>  static inline bool seqid_mutating_err(u32 err)
>  {

--=20
Jeff Layton <jlayton@kernel.org>

