Return-Path: <linux-nfs+bounces-12789-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC99AE8D22
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Jun 2025 20:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522AD189E9DE
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Jun 2025 18:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2381CAA7B;
	Wed, 25 Jun 2025 18:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="h24kTBtL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [131.169.56.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED52C285C9E
	for <linux-nfs@vger.kernel.org>; Wed, 25 Jun 2025 18:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750877793; cv=none; b=qcTEjHPhCQW6vuCb6MWhxWKUZtohQjKS6+reRmdpEGmySliQbH81Olvc8jPa9IrtTAIHn5OUuu1/CD5ORD/wnqgFuGUw++fl54ViIVt2Den3UdeeAKXPjbOYiSUM7L/U9Aq6tyhJLPJtIWksbdW3iNp07WNKF7s7DdFcmsIbrhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750877793; c=relaxed/simple;
	bh=PopqO6xkAtVVzCGhj6F+epgDRrhGcridhsx1xnRqoIg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=W/pe+khEM9S6JIzF1LGWV4kiIj2TGKXF88IUG2uRsYuy2yAUX61LoDaM1/mlCtDM3NvnnyWARUskz0ibSG6PIfoi/v2glA9A1x/WYA8VB75FxtQe9xuWdXCVv+NOOsXrYlvua1MMqy9SutR8qR9n42dksIlQBgjI7NTExhaaUvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=h24kTBtL; arc=none smtp.client-ip=131.169.56.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [IPv6:2001:638:700:1038::1:a5])
	by smtp-o-2.desy.de (Postfix) with ESMTP id AA1B713F647
	for <linux-nfs@vger.kernel.org>; Wed, 25 Jun 2025 20:56:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de AA1B713F647
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1750877787; bh=+SKVQMQpSAGXIXIPWmom+X6qNAiPEnMWzXmjjQ6HaRU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=h24kTBtLtpWm9XYhM5GEZ7kN/rb3a+RPKGrG1Dcw0QobNf67W/oDjbB5FoALJEt1L
	 LZBk6X9PYxu+ya/1zrASUjUuVDrm3uLWESXBF8GENpw9uL4lF4FI+enI3P81uiH2zL
	 LpnHZ51e+XQUkEjJwubHNFsx2r7Q3ZYL3LwE9YCQ=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [IPv6:2001:638:700:1038::1:81])
	by smtp-buf-2.desy.de (Postfix) with ESMTP id A0864120043;
	Wed, 25 Jun 2025 20:56:27 +0200 (CEST)
Received: from c1722.mx.srv.dfn.de (c1722.mx.srv.dfn.de [194.95.239.47])
	by smtp-m-1.desy.de (Postfix) with ESMTP id 9518840044;
	Wed, 25 Jun 2025 20:56:27 +0200 (CEST)
Received: from smtp-intra-1.desy.de (smtp-intra-1.desy.de [131.169.56.82])
	by c1722.mx.srv.dfn.de (Postfix) with ESMTP id D233310A3CD;
	Wed, 25 Jun 2025 20:56:26 +0200 (CEST)
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
	by smtp-intra-1.desy.de (Postfix) with ESMTP id A19DF80046;
	Wed, 25 Jun 2025 20:56:26 +0200 (CEST)
Date: Wed, 25 Jun 2025 20:56:26 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Trond Myklebust <trondmy@kernel.org>
Cc: linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <166279785.14465613.1750877786582.JavaMail.zimbra@desy.de>
In-Reply-To: <ee51ca06ad923654520041652c478ae3938fcbcb.1750806992.git.trond.myklebust@hammerspace.com>
References: <ee51ca06ad923654520041652c478ae3938fcbcb.1750806992.git.trond.myklebust@hammerspace.com>
Subject: Re: [PATCH] NFSv4/flexfiles: Fix handling of NFS level errors in
 I/O
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 9.0.0_GA_4769 (ZimbraWebClient - FF140 (Linux)/9.0.0_GA_4769)
Thread-Topic: NFSv4/flexfiles: Fix handling of NFS level errors in I/O
Thread-Index: 7y4N4rT94u8FvK6CScvYpbhOjYqT4A==


(second attempt after linux-nfs@vger.kernel.org has rejected the first one.)

Splitting RPC level error from NFS errors returned by DS looks reasonable to me.

So, if it helps:

Reviewed-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>

Tigran.

----- Original Message -----
> From: "Trond Myklebust" <trondmy@kernel.org>
> To: "linux-nfs" <linux-nfs@vger.kernel.org>
> Sent: Wednesday, 25 June, 2025 01:17:12
> Subject: [PATCH] NFSv4/flexfiles: Fix handling of NFS level errors in I/O

> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> Allow the flexfiles error handling to recognise NFS level errors (as
> opposed to RPC level errors) and handle them separately. The main
> motivator is the NFSERR_PERM errors that get returned if the NFS client
> connects to the data server through a port number that is lower than
> 1024. In that case, the client should disconnect and retry a READ on a
> different data server, or it should retry a WRITE after reconnecting.
> 
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
> fs/nfs/flexfilelayout/flexfilelayout.c | 118 ++++++++++++++++++-------
> 1 file changed, 84 insertions(+), 34 deletions(-)
> 
> diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c
> b/fs/nfs/flexfilelayout/flexfilelayout.c
> index df4807460596..4bea008dbebd 100644
> --- a/fs/nfs/flexfilelayout/flexfilelayout.c
> +++ b/fs/nfs/flexfilelayout/flexfilelayout.c
> @@ -1105,6 +1105,7 @@ static void ff_layout_reset_read(struct nfs_pgio_header
> *hdr)
> }
> 
> static int ff_layout_async_handle_error_v4(struct rpc_task *task,
> +					   u32 op_status,
> 					   struct nfs4_state *state,
> 					   struct nfs_client *clp,
> 					   struct pnfs_layout_segment *lseg,
> @@ -1115,34 +1116,42 @@ static int ff_layout_async_handle_error_v4(struct
> rpc_task *task,
> 	struct nfs4_deviceid_node *devid = FF_LAYOUT_DEVID_NODE(lseg, idx);
> 	struct nfs4_slot_table *tbl = &clp->cl_session->fc_slot_table;
> 
> -	switch (task->tk_status) {
> -	case -NFS4ERR_BADSESSION:
> -	case -NFS4ERR_BADSLOT:
> -	case -NFS4ERR_BAD_HIGH_SLOT:
> -	case -NFS4ERR_DEADSESSION:
> -	case -NFS4ERR_CONN_NOT_BOUND_TO_SESSION:
> -	case -NFS4ERR_SEQ_FALSE_RETRY:
> -	case -NFS4ERR_SEQ_MISORDERED:
> +	switch (op_status) {
> +	case NFS4_OK:
> +	case NFS4ERR_NXIO:
> +		break;
> +	case NFSERR_PERM:
> +		if (!task->tk_xprt)
> +			break;
> +		xprt_force_disconnect(task->tk_xprt);
> +		goto out_retry;
> +	case NFS4ERR_BADSESSION:
> +	case NFS4ERR_BADSLOT:
> +	case NFS4ERR_BAD_HIGH_SLOT:
> +	case NFS4ERR_DEADSESSION:
> +	case NFS4ERR_CONN_NOT_BOUND_TO_SESSION:
> +	case NFS4ERR_SEQ_FALSE_RETRY:
> +	case NFS4ERR_SEQ_MISORDERED:
> 		dprintk("%s ERROR %d, Reset session. Exchangeid "
> 			"flags 0x%x\n", __func__, task->tk_status,
> 			clp->cl_exchange_flags);
> 		nfs4_schedule_session_recovery(clp->cl_session, task->tk_status);
> -		break;
> -	case -NFS4ERR_DELAY:
> +		goto out_retry;
> +	case NFS4ERR_DELAY:
> 		nfs_inc_stats(lseg->pls_layout->plh_inode, NFSIOS_DELAY);
> 		fallthrough;
> -	case -NFS4ERR_GRACE:
> +	case NFS4ERR_GRACE:
> 		rpc_delay(task, FF_LAYOUT_POLL_RETRY_MAX);
> -		break;
> -	case -NFS4ERR_RETRY_UNCACHED_REP:
> -		break;
> +		goto out_retry;
> +	case NFS4ERR_RETRY_UNCACHED_REP:
> +		goto out_retry;
> 	/* Invalidate Layout errors */
> -	case -NFS4ERR_PNFS_NO_LAYOUT:
> -	case -ESTALE:           /* mapped NFS4ERR_STALE */
> -	case -EBADHANDLE:       /* mapped NFS4ERR_BADHANDLE */
> -	case -EISDIR:           /* mapped NFS4ERR_ISDIR */
> -	case -NFS4ERR_FHEXPIRED:
> -	case -NFS4ERR_WRONG_TYPE:
> +	case NFS4ERR_PNFS_NO_LAYOUT:
> +	case NFS4ERR_STALE:
> +	case NFS4ERR_BADHANDLE:
> +	case NFS4ERR_ISDIR:
> +	case NFS4ERR_FHEXPIRED:
> +	case NFS4ERR_WRONG_TYPE:
> 		dprintk("%s Invalid layout error %d\n", __func__,
> 			task->tk_status);
> 		/*
> @@ -1155,6 +1164,11 @@ static int ff_layout_async_handle_error_v4(struct
> rpc_task *task,
> 		pnfs_destroy_layout(NFS_I(inode));
> 		rpc_wake_up(&tbl->slot_tbl_waitq);
> 		goto reset;
> +	default:
> +		break;
> +	}
> +
> +	switch (task->tk_status) {
> 	/* RPC connection errors */
> 	case -ENETDOWN:
> 	case -ENETUNREACH:
> @@ -1174,27 +1188,56 @@ static int ff_layout_async_handle_error_v4(struct
> rpc_task *task,
> 		nfs4_delete_deviceid(devid->ld, devid->nfs_client,
> 				&devid->deviceid);
> 		rpc_wake_up(&tbl->slot_tbl_waitq);
> -		fallthrough;
> +		break;
> 	default:
> -		if (ff_layout_avoid_mds_available_ds(lseg))
> -			return -NFS4ERR_RESET_TO_PNFS;
> -reset:
> -		dprintk("%s Retry through MDS. Error %d\n", __func__,
> -			task->tk_status);
> -		return -NFS4ERR_RESET_TO_MDS;
> +		break;
> 	}
> +
> +	if (ff_layout_avoid_mds_available_ds(lseg))
> +		return -NFS4ERR_RESET_TO_PNFS;
> +reset:
> +	dprintk("%s Retry through MDS. Error %d\n", __func__,
> +		task->tk_status);
> +	return -NFS4ERR_RESET_TO_MDS;
> +
> +out_retry:
> 	task->tk_status = 0;
> 	return -EAGAIN;
> }
> 
> /* Retry all errors through either pNFS or MDS except for -EJUKEBOX */
> static int ff_layout_async_handle_error_v3(struct rpc_task *task,
> +					   u32 op_status,
> 					   struct nfs_client *clp,
> 					   struct pnfs_layout_segment *lseg,
> 					   u32 idx)
> {
> 	struct nfs4_deviceid_node *devid = FF_LAYOUT_DEVID_NODE(lseg, idx);
> 
> +	switch (op_status) {
> +	case NFS_OK:
> +	case NFSERR_NXIO:
> +		break;
> +	case NFSERR_PERM:
> +		if (!task->tk_xprt)
> +			break;
> +		xprt_force_disconnect(task->tk_xprt);
> +		goto out_retry;
> +	case NFSERR_ACCES:
> +	case NFSERR_BADHANDLE:
> +	case NFSERR_FBIG:
> +	case NFSERR_IO:
> +	case NFSERR_NOSPC:
> +	case NFSERR_ROFS:
> +	case NFSERR_STALE:
> +		goto out_reset_to_pnfs;
> +	case NFSERR_JUKEBOX:
> +		nfs_inc_stats(lseg->pls_layout->plh_inode, NFSIOS_DELAY);
> +		goto out_retry;
> +	default:
> +		break;
> +	}
> +
> 	switch (task->tk_status) {
> 	/* File access problems. Don't mark the device as unavailable */
> 	case -EACCES:
> @@ -1218,6 +1261,7 @@ static int ff_layout_async_handle_error_v3(struct rpc_task
> *task,
> 		nfs4_delete_deviceid(devid->ld, devid->nfs_client,
> 				&devid->deviceid);
> 	}
> +out_reset_to_pnfs:
> 	/* FIXME: Need to prevent infinite looping here. */
> 	return -NFS4ERR_RESET_TO_PNFS;
> out_retry:
> @@ -1228,6 +1272,7 @@ static int ff_layout_async_handle_error_v3(struct rpc_task
> *task,
> }
> 
> static int ff_layout_async_handle_error(struct rpc_task *task,
> +					u32 op_status,
> 					struct nfs4_state *state,
> 					struct nfs_client *clp,
> 					struct pnfs_layout_segment *lseg,
> @@ -1246,10 +1291,11 @@ static int ff_layout_async_handle_error(struct rpc_task
> *task,
> 
> 	switch (vers) {
> 	case 3:
> -		return ff_layout_async_handle_error_v3(task, clp, lseg, idx);
> -	case 4:
> -		return ff_layout_async_handle_error_v4(task, state, clp,
> +		return ff_layout_async_handle_error_v3(task, op_status, clp,
> 						       lseg, idx);
> +	case 4:
> +		return ff_layout_async_handle_error_v4(task, op_status, state,
> +						       clp, lseg, idx);
> 	default:
> 		/* should never happen */
> 		WARN_ON_ONCE(1);
> @@ -1302,6 +1348,7 @@ static void ff_layout_io_track_ds_error(struct
> pnfs_layout_segment *lseg,
> 	switch (status) {
> 	case NFS4ERR_DELAY:
> 	case NFS4ERR_GRACE:
> +	case NFS4ERR_PERM:
> 		break;
> 	case NFS4ERR_NXIO:
> 		ff_layout_mark_ds_unreachable(lseg, idx);
> @@ -1334,7 +1381,8 @@ static int ff_layout_read_done_cb(struct rpc_task *task,
> 		trace_ff_layout_read_error(hdr, task->tk_status);
> 	}
> 
> -	err = ff_layout_async_handle_error(task, hdr->args.context->state,
> +	err = ff_layout_async_handle_error(task, hdr->res.op_status,
> +					   hdr->args.context->state,
> 					   hdr->ds_clp, hdr->lseg,
> 					   hdr->pgio_mirror_idx);
> 
> @@ -1507,7 +1555,8 @@ static int ff_layout_write_done_cb(struct rpc_task *task,
> 		trace_ff_layout_write_error(hdr, task->tk_status);
> 	}
> 
> -	err = ff_layout_async_handle_error(task, hdr->args.context->state,
> +	err = ff_layout_async_handle_error(task, hdr->res.op_status,
> +					   hdr->args.context->state,
> 					   hdr->ds_clp, hdr->lseg,
> 					   hdr->pgio_mirror_idx);
> 
> @@ -1556,8 +1605,9 @@ static int ff_layout_commit_done_cb(struct rpc_task *task,
> 		trace_ff_layout_commit_error(data, task->tk_status);
> 	}
> 
> -	err = ff_layout_async_handle_error(task, NULL, data->ds_clp,
> -					   data->lseg, data->ds_commit_index);
> +	err = ff_layout_async_handle_error(task, data->res.op_status,
> +					   NULL, data->ds_clp, data->lseg,
> +					   data->ds_commit_index);
> 
> 	trace_nfs4_pnfs_commit_ds(data, err);
> 	switch (err) {
> --
> 2.49.0

