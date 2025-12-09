Return-Path: <linux-nfs+bounces-17010-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E01CB069C
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Dec 2025 16:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72C833071FB6
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Dec 2025 15:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711402773CC;
	Tue,  9 Dec 2025 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rigrcKOY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C741E8320;
	Tue,  9 Dec 2025 15:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765294437; cv=none; b=JU5Jp4QGIL76aRaou7O/9zKHL7CLkCXCLsTfx+3GH6Sjhj9VkcDb9hEUfr//c/HxCPowR3mahNAPkYsPMQ5XN5UUE43++fUf7T69rckISqRT/qtZo3ibQKXXualaKLQe5z4sYH6bOfU878nWQj7jVArWHgLKKwXI/dAVq9JMtXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765294437; c=relaxed/simple;
	bh=S02bSUqZWhhi63QAb1ZWwM4gZC4tl/l45wO836J/Jqk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VvW5TFytsalYuj/tkRqcvvi9hm/bxVAcAfuiQebGL82dmA4UsdlOY6gEjTLarSDeHbRNrXgh6//1M71JKD4EuWoASZx9pCYutypgP3srg3WxzWKrYPwvEeAk9UrUm0DWmHngC3nfSH7Kl416ezVaLVc1D72B5gTYyA7vXZFVIZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rigrcKOY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63280C4CEF5;
	Tue,  9 Dec 2025 15:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765294436;
	bh=S02bSUqZWhhi63QAb1ZWwM4gZC4tl/l45wO836J/Jqk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=rigrcKOYxECYB4YlBCLFy+N/QfoAronosfII/EocHBqh85oPBVwcVUecAq33LK4x+
	 UFtX0z+Gi4ZO5EEUrBKZjdmGjyUzDebKgopRnH1BPZaZaTV3fDV/m9NczLd+pHXJBP
	 Yt+sQVkLxfeJPEW4tAeNZ+a4ST4j57WWdiIqaOI3k3vn2pAT9ObNQ1UqTdMKSsnWgb
	 PvOkybkwSqs8kUKmQIL5nSkYN3dbgel6jTf3cAiWS8Aijk8Tv1N4fX3NM8JTBXVAv6
	 strp3qGsY0WmwgfJ/f4k3/eyXkxF7hEjNWO8D26NlhF4tr28Dt3CmEHj09dyC36W8o
	 vPUsokmFtchfQ==
Message-ID: <9799c4ac60c9732941fe4a67493a45eb9b2686ed.camel@kernel.org>
Subject: Re: [PATCH] pnfs/filelayout: handle data server op_status errors
From: Trond Myklebust <trondmy@kernel.org>
To: Robert Milkowski <rmilkowski@gmail.com>
Cc: anna@kernel.org, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 09 Dec 2025 10:33:55 -0500
In-Reply-To: <20251209135620.27492-1-rmilkowski@gmail.com>
References: <20251209135620.27492-1-rmilkowski@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-09 at 13:56 +0000, Robert Milkowski wrote:
> Data servers can return NFS-level status in op_status, but the file
> layout
> driver only looked at RPC transport errors. That means session
> errors,
> layout-invalidating statuses, and retry hints from the DS can be
> ignored,
> leading to missed session recovery, stale layouts, or failed retries.

The task->tk_status can carry NFS level status if there was no RPC
error. That's why we distinguish between task->tk_status and task-
>tk_rpc_status (the latter being guaranteed to only carry RPC errors).

IOW: is there any evidence of what you call out above?

>=20
> Pass the DS op_status into the async error handler and handle the
> same set
> of NFS status codes as flexfiles (see commit 38074de35b01,
> "NFSv4/flexfiles: Fix handling of NFS level errors in I/O"). Wire the
> read/write/commit callbacks to propagate op_status so the file layout
> driver
> can invalidate layouts, trigger session recovery, or retry as
> appropriate.
>=20
> Signed-off-by: Robert Milkowski <rmilkowski@gmail.com>
> ---
> =C2=A0fs/nfs/filelayout/filelayout.c | 54
> ++++++++++++++++++++++++++++++++--
> =C2=A01 file changed, 51 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nfs/filelayout/filelayout.c
> b/fs/nfs/filelayout/filelayout.c
> index 5c4551117c58..2808baa19f83 100644
> --- a/fs/nfs/filelayout/filelayout.c
> +++ b/fs/nfs/filelayout/filelayout.c
> @@ -121,6 +121,7 @@ static void filelayout_reset_read(struct
> nfs_pgio_header *hdr)
> =C2=A0}
> =C2=A0
> =C2=A0static int filelayout_async_handle_error(struct rpc_task *task,
> +					 u32 op_status,
> =C2=A0					 struct nfs4_state *state,
> =C2=A0					 struct nfs_client *clp,
> =C2=A0					 struct pnfs_layout_segment
> *lseg)
> @@ -130,6 +131,48 @@ static int filelayout_async_handle_error(struct
> rpc_task *task,
> =C2=A0	struct nfs4_deviceid_node *devid =3D
> FILELAYOUT_DEVID_NODE(lseg);
> =C2=A0	struct nfs4_slot_table *tbl =3D &clp->cl_session-
> >fc_slot_table;
> =C2=A0
> +	if (op_status) {
> +		switch (op_status) {
> +		case NFS4_OK:
> +		case NFS4ERR_NXIO:
> +			break;
> +		case NFS4ERR_BADSESSION:
> +		case NFS4ERR_BADSLOT:
> +		case NFS4ERR_BAD_HIGH_SLOT:
> +		case NFS4ERR_DEADSESSION:
> +		case NFS4ERR_CONN_NOT_BOUND_TO_SESSION:
> +		case NFS4ERR_SEQ_FALSE_RETRY:
> +		case NFS4ERR_SEQ_MISORDERED:
> +			dprintk("%s op_status %u, Reset session.
> Exchangeid "
> +				"flags 0x%x\n", __func__, op_status,
> +				clp->cl_exchange_flags);
> +			nfs4_schedule_session_recovery(clp-
> >cl_session,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op_status);
> +			goto out_retry;
> +		case NFS4ERR_DELAY:
> +		case NFS4ERR_GRACE:
> +		case NFS4ERR_RETRY_UNCACHED_REP:
> +			rpc_delay(task, FILELAYOUT_POLL_RETRY_MAX);
> +			goto out_retry;
> +		case NFS4ERR_ACCESS:
> +		case NFS4ERR_PNFS_NO_LAYOUT:
> +		case NFS4ERR_STALE:
> +		case NFS4ERR_BADHANDLE:
> +		case NFS4ERR_ISDIR:
> +		case NFS4ERR_FHEXPIRED:
> +		case NFS4ERR_WRONG_TYPE:
> +		case NFS4ERR_NOMATCHING_LAYOUT:
> +		case NFSERR_PERM:
> +			dprintk("%s Invalid layout op_status %u\n",
> __func__,
> +				op_status);
> +			pnfs_destroy_layout(NFS_I(inode));
> +			rpc_wake_up(&tbl->slot_tbl_waitq);
> +			goto reset;
> +		default:
> +			goto reset;
> +		}
> +	}
> +
> =C2=A0	if (task->tk_status >=3D 0)
> =C2=A0		return 0;
> =C2=A0
> @@ -196,6 +239,8 @@ static int filelayout_async_handle_error(struct
> rpc_task *task,
> =C2=A0			task->tk_status);
> =C2=A0		return -NFS4ERR_RESET_TO_MDS;
> =C2=A0	}
> +
> +out_retry:
> =C2=A0	task->tk_status =3D 0;
> =C2=A0	return -EAGAIN;
> =C2=A0}
> @@ -208,7 +253,8 @@ static int filelayout_read_done_cb(struct
> rpc_task *task,
> =C2=A0	int err;
> =C2=A0
> =C2=A0	trace_nfs4_pnfs_read(hdr, task->tk_status);
> -	err =3D filelayout_async_handle_error(task, hdr->args.context-
> >state,
> +	err =3D filelayout_async_handle_error(task, hdr-
> >res.op_status,
> +					=C2=A0=C2=A0=C2=A0 hdr->args.context-
> >state,
> =C2=A0					=C2=A0=C2=A0=C2=A0 hdr->ds_clp, hdr->lseg);
> =C2=A0
> =C2=A0	switch (err) {
> @@ -318,7 +364,8 @@ static int filelayout_write_done_cb(struct
> rpc_task *task,
> =C2=A0	int err;
> =C2=A0
> =C2=A0	trace_nfs4_pnfs_write(hdr, task->tk_status);
> -	err =3D filelayout_async_handle_error(task, hdr->args.context-
> >state,
> +	err =3D filelayout_async_handle_error(task, hdr-
> >res.op_status,
> +					=C2=A0=C2=A0=C2=A0 hdr->args.context-
> >state,
> =C2=A0					=C2=A0=C2=A0=C2=A0 hdr->ds_clp, hdr->lseg);
> =C2=A0
> =C2=A0	switch (err) {
> @@ -346,7 +393,8 @@ static int filelayout_commit_done_cb(struct
> rpc_task *task,
> =C2=A0	int err;
> =C2=A0
> =C2=A0	trace_nfs4_pnfs_commit_ds(data, task->tk_status);
> -	err =3D filelayout_async_handle_error(task, NULL, data-
> >ds_clp,
> +	err =3D filelayout_async_handle_error(task, data-
> >res.op_status,
> +					=C2=A0=C2=A0=C2=A0 NULL, data->ds_clp,
> =C2=A0					=C2=A0=C2=A0=C2=A0 data->lseg);
> =C2=A0
> =C2=A0	switch (err) {
>=20
> base-commit: cb015814f8b6eebcbb8e46e111d108892c5e6821

I'd be willing to take something like the above as a cleanup, assuming
that it replaces the existing handling of NFSv4.1 errors using task-
>tk_status instead of just adding new cases.

However I'd want to see evidence that the resulting patch has been
thoroughly tested before submission, because I currently have no way to
test it myself.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

