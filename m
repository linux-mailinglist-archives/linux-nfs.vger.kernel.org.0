Return-Path: <linux-nfs+bounces-17008-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3EACB05D5
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Dec 2025 16:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46184301C97E
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Dec 2025 15:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA1D2FF177;
	Tue,  9 Dec 2025 15:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRs3p42R"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DC32D2384;
	Tue,  9 Dec 2025 15:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765293051; cv=none; b=JcejN0ZyUV5N7LCftnCitLXLyHw600fLl5dh65J0ESZKheTpal6oN/xTmG1B4UAAUYnO4GloZFY7+TvRspj8sYzot5ZtxxyYIBWmRw2uMHRkL1fhMBOAQSX8WzvEtol36EbP6T5/kpUzWgvWATedTjHOnXTZCtZUBNxlXgP/ho0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765293051; c=relaxed/simple;
	bh=Rjp8Cy0R+7pgc4SLM7DLr9rPmWk0dGcUYAeghpnz5yQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U+KcqFH+VLYGhIX68EJO8ZjQzwKlDNzSuaVnj9pJzvoGXjQnVWzTrLHqzqEAG4D7EF04LOxpPRWZ0xBBYRrcbihkwEyrPR5YFnBghVBljPv3IAfAsQPpEMqpZvh0eAhW4vpGYgD+ZzW66/5YxxBXvQB48JAWvzq4axuCXCL2hlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRs3p42R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9749DC4CEF5;
	Tue,  9 Dec 2025 15:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765293051;
	bh=Rjp8Cy0R+7pgc4SLM7DLr9rPmWk0dGcUYAeghpnz5yQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=PRs3p42RmK0PaqVpjPmMrMA6VEx0ej6pkikO7amb6SVCbF3NQtZVjG3tdQJWEFnOa
	 G5jBo+Xw96L3XEv/YgeuQWvQQNxQVOVYjcrAZYJj4f1Z8KzL3YtyDfg1RkC9SExlL/
	 y6otbvZlL/YQAZo8Yp9ydnnSspeUvsfNNYI5dp+LrKg6jjIzUl9J5mZ31AWjwg8nyR
	 +/r3WIcJqnBWRs72PUWTQmUryLlDYOHjWAtQvIdmavXdic6sMBSTcs4OnzFLrtO/RS
	 VdzVao2/E6DapHXZaZD7lzyyquBpKJaNOvGcn/oG+Dp2UE8Ol6MYm0KdUuT3YWLA27
	 27PxK3EVhD4NA==
Message-ID: <75db462529291ee8330a2a8e32cc75df4b33f71a.camel@kernel.org>
Subject: Re: [PATCH] nfs: pnfs: handle early layoutreturn failures gracefully
From: Trond Myklebust <trondmy@kernel.org>
To: Robert Milkowski <rmilkowski@gmail.com>
Cc: anna@kernel.org, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 09 Dec 2025 10:10:49 -0500
In-Reply-To: <20251209145330.28053-1-rmilkowski@gmail.com>
References: <20251209145330.28053-1-rmilkowski@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-09 at 14:53 +0000, Robert Milkowski wrote:
> pnfs_layoutreturn_before_put_layout_hdr() bumps the layout header
> refcount
> and sets NFS_LAYOUT_RETURN before prepare or rpc_run_task dispatch.
> If the
> layout driver fails prepare or rpc_run_task() fails to queue the
> call, we
> currently leak refs and leave waiters stuck on
> pnfs_prepare_to_retry_layoutget().
>=20
> Mirror the normal completion path for these early failures: warn and
> schedule pnfs_layoutreturn_retry_later(), free any reserved slot,
> drop
> refs/creds/inode, and clear the wait bit.
>=20
> Signed-off-by: Robert Milkowski <rmilkowski@gmail.com>
> ---
> =C2=A0fs/nfs/nfs4proc.c | 37 +++++++++++++++++++++++++------------
> =C2=A0fs/nfs/pnfs.c=C2=A0=C2=A0=C2=A0=C2=A0 | 21 +++++++++++++++++++--
> =C2=A02 files changed, 44 insertions(+), 14 deletions(-)
>=20
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 93c6ce04332b..6066a1c7227d 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -10132,25 +10132,34 @@ static void nfs4_layoutreturn_done(struct
> rpc_task *task, void *calldata)
> =C2=A0	rpc_restart_call_prepare(task);
> =C2=A0}
> =C2=A0
> -static void nfs4_layoutreturn_release(void *calldata)
> +static void nfs4_layoutreturn_cleanup(struct nfs4_layoutreturn *lrp,
> int status)
> =C2=A0{
> -	struct nfs4_layoutreturn *lrp =3D calldata;
> =C2=A0	struct pnfs_layout_hdr *lo =3D lrp->args.layout;
> =C2=A0
> -	if (lrp->rpc_status =3D=3D 0 || !lrp->inode)
> -		pnfs_layoutreturn_free_lsegs(
> -			lo, &lrp->args.stateid, &lrp->args.range,
> -			lrp->res.lrs_present ? &lrp->res.stateid :
> NULL);
> +	if (status =3D=3D 0 || !lrp->inode)
> +		pnfs_layoutreturn_free_lsegs(lo, &lrp->args.stateid,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 &lrp->args.range,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 lrp->res.lrs_present ?
> +					=C2=A0=C2=A0=C2=A0=C2=A0 &lrp->res.stateid :
> NULL);
> =C2=A0	else
> =C2=A0		pnfs_layoutreturn_retry_later(lo, &lrp-
> >args.stateid,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &lrp->args.range);
> -	nfs4_sequence_free_slot(&lrp->res.seq_res);
> +	if (lrp->res.seq_res.sr_slot)
> +		nfs4_sequence_free_slot(&lrp->res.seq_res);
> =C2=A0	if (lrp->ld_private.ops && lrp->ld_private.ops->free)
> =C2=A0		lrp->ld_private.ops->free(&lrp->ld_private);
> -	pnfs_put_layout_hdr(lrp->args.layout);
> -	nfs_iput_and_deactive(lrp->inode);
> +	pnfs_put_layout_hdr(lo);
> +	if (lrp->inode)
> +		nfs_iput_and_deactive(lrp->inode);
> =C2=A0	put_cred(lrp->cred);
> -	kfree(calldata);
> +	kfree(lrp);
> +}
> +
> +static void nfs4_layoutreturn_release(void *calldata)
> +{
> +	struct nfs4_layoutreturn *lrp =3D calldata;
> +
> +	nfs4_layoutreturn_cleanup(lrp, lrp->rpc_status);
> =C2=A0}
> =C2=A0
> =C2=A0static const struct rpc_call_ops nfs4_layoutreturn_call_ops =3D {
> @@ -10198,8 +10207,12 @@ int nfs4_proc_layoutreturn(struct
> nfs4_layoutreturn *lrp, unsigned int flags)
> =C2=A0		nfs4_init_sequence(&lrp->args.seq_args, &lrp-
> >res.seq_res, 1,
> =C2=A0				=C2=A0=C2=A0 0);
> =C2=A0	task =3D rpc_run_task(&task_setup_data);
> -	if (IS_ERR(task))
> -		return PTR_ERR(task);
> +	if (IS_ERR(task)) {
> +		status =3D PTR_ERR(task);
> +		trace_nfs4_layoutreturn(lrp->args.inode, &lrp-
> >args.stateid, status);
> +		nfs4_layoutreturn_cleanup(lrp, status);
> +		return status;
> +	}

NACK. The above introduces a use-after-free. There is no need to call
the release routine after a call to rpc_run_task().

> =C2=A0	if (!(flags & PNFS_FL_LAYOUTRETURN_ASYNC))
> =C2=A0		status =3D task->tk_status;
> =C2=A0	trace_nfs4_layoutreturn(lrp->args.inode, &lrp->args.stateid,
> status);
> diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
> index f157d43d1312..a489f43344b8 100644
> --- a/fs/nfs/pnfs.c
> +++ b/fs/nfs/pnfs.c
> @@ -1370,13 +1370,30 @@ pnfs_send_layoutreturn(struct pnfs_layout_hdr
> *lo,
> =C2=A0	lrp->args.ld_private =3D &lrp->ld_private;
> =C2=A0	lrp->clp =3D NFS_SERVER(ino)->nfs_client;
> =C2=A0	lrp->cred =3D cred;
> -	if (ld->prepare_layoutreturn)
> -		ld->prepare_layoutreturn(&lrp->args);
> +	if (ld->prepare_layoutreturn) {
> +		status =3D ld->prepare_layoutreturn(&lrp->args);
> +		if (status) {
> +			pr_warn_ratelimited("NFS: pNFS layoutreturn
> prepare failed (%d) for layout driver %s\n",
> +				status, ld->name ? ld->name :
> "unknown");
> +			goto out_prepare_fail;
> +		}
> +	}

This is also unnecessary. The existing code will cope just fine with
args->ld_private being unset.

> =C2=A0
> =C2=A0	status =3D nfs4_proc_layoutreturn(lrp, flags);
> =C2=A0out:
> =C2=A0	dprintk("<-- %s status: %d\n", __func__, status);
> =C2=A0	return status;
> +
> +out_prepare_fail:
> +	pnfs_layoutreturn_retry_later(lo, &lrp->args.stateid, &lrp-
> >args.range);
> +	if (lrp->ld_private.ops && lrp->ld_private.ops->free)
> +		lrp->ld_private.ops->free(&lrp->ld_private);
> +	if (lrp->inode)
> +		nfs_iput_and_deactive(lrp->inode);
> +	put_cred(cred);
> +	kfree(lrp);
> +	pnfs_put_layout_hdr(lo);
> +	return status;
> =C2=A0}
> =C2=A0
> =C2=A0/* Return true if layoutreturn is needed */
>=20
> base-commit: cb015814f8b6eebcbb8e46e111d108892c5e6821

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

