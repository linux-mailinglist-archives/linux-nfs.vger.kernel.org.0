Return-Path: <linux-nfs+bounces-20823-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHcJMd1Z3WnYcwkAu9opvQ
	(envelope-from <linux-nfs+bounces-20823-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Apr 2026 23:02:21 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED67B3F3569
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Apr 2026 23:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2BB9308EA1D
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Apr 2026 20:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BA61BBBE5;
	Mon, 13 Apr 2026 20:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLs6bFXh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47091A275
	for <linux-nfs@vger.kernel.org>; Mon, 13 Apr 2026 20:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776113734; cv=none; b=H9sYa3Z0HSd1VjFXaDjbsLX1k0W6KnSmqcpB+9QOMfU7GUYfSStgI8JNj89kxo1/E7A8RQDLzWSt85te/C2P7oGefxdMjRxVo8Gc0AOlVV0pt3CzJor0N6XULnAVYpShJBZlLVsSV0uUJ0sZJIfEXI9/KsZU5l4x10n8hLKaXAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776113734; c=relaxed/simple;
	bh=8Q35ZKvlkbKD/pR2UDsjPcQ6LaRsAcIP/uQWPXt37uY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jxQiIQqd4oUAizvGELaRykw3HXZ4ePVgYW5ibDrCAdkXyAhtO99aEaZdIzsfl+sYysG5uZCO+wes8j1IkhiLx24V9Y2t9rajiZrsiRBMdBWFciMkGMXBOzWStvcTSTXr9CDkxFXsV1FEpuCLIBoBuSpU33Tlo8qPfKvhYstud4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLs6bFXh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8D9C2BCAF;
	Mon, 13 Apr 2026 20:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776113734;
	bh=8Q35ZKvlkbKD/pR2UDsjPcQ6LaRsAcIP/uQWPXt37uY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=NLs6bFXhV8RAdYRkoHc1ubzDosWm/M1QePBpH+OPO3Kv/01887bWSRu9F2pykimSU
	 TzHnBevwtUQBqOujSwn5gdBsrtb/3FajMfMaRF0HKyhj2r6eN/PyZ9yOQlP7IUCVyz
	 Vk6DKvExpItKIQFxgzduU8NO5lu8Gw4dep5QJu8AJqwj2s53s77Pwbvgfyb6eiwKy1
	 eRWZZUE6140Pk225QOpjnVIjSo9HteYFdy7P4794w58Zka5bFahpt4+1be5eCDj9XT
	 9PwBkxfkNU7EUI/F+UubnrfRMTIPYHoRsF9sbJhCLdL2FxVq2QFfENt2OvK/YE9zQo
	 10lZRU9WGUssA==
Message-ID: <3f2666aec2649cc8cf2fc0524612b73936b3b17b.camel@kernel.org>
Subject: Re: [PATCH v2 1/1] NFS: fix writeback in presence of errors
From: Trond Myklebust <trondmy@kernel.org>
To: Olga Kornievskaia <okorniev@redhat.com>, anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Date: Mon, 13 Apr 2026 13:55:34 -0700
In-Reply-To: <20260325180050.55186-1-okorniev@redhat.com>
References: <20260325180050.55186-1-okorniev@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20823-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trondmy@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ED67B3F3569
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Olga,

On Wed, 2026-03-25 at 14:00 -0400, Olga Kornievskaia wrote:
> After running xfstest generic/751, in certain conditions, can have
> a writeback IO stuck while experiencing one of the two patterns.
>=20
> Pattern#1: writeback IO experiences ENOSPC on an offset smaller
> than the filesize. Example,
> write offset=3D0 len=3D4096 how=3Dunstable OK
> write offset=3D8192 len=3D4096 how=3Dunstable OK
> write offset=3D12288 len=3D4096 how=3Dunstable ENOSPC
> write offset=3D4096 len=3D4096 how=3Dunstable ENOSPC
> client sends a commit and receives a verifier which is different
> from the last successful write. It marks pages dirty and writeback
> retries. But it again send writes unstable and gets into the same
> pattern, running into the ENOSPC error and sending a commit because
> writes were sent at unstable.
>=20
> Pattern#2: an unstable write followed by a short write and ENOSPC.
> write offset=3D0 len=3D4096 how=3Dunstable OK
> write offset=3D4096 len=3D4096 how=3Dunstable returns OK but count=3D100
> write offset=3D4197 len=3D3996 how=3Dstable returns ENOSPC
> client send a commit and receives a verifier different from
> the last unstable write. The same behaviour is retried in a loop.
>=20
> Instead, this patch proposes to identify those conditions and mark
> requests to be done synchronously instead. Previous solution tried
> to mark it in the nfs_page, however that's not persistent thus
> instead mark it in the nfs_open_context.
>=20
> Furthermore, the same problem occurs during localio code path so
> recognize that IO needs to be done sync in that case as well.
>=20
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
> =C2=A0fs/nfs/localio.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 +++++++++=
+
> =C2=A0fs/nfs/pagelist.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +++
> =C2=A0fs/nfs/write.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 9 +++++++++
> =C2=A0include/linux/nfs_fs.h |=C2=A0 1 +
> =C2=A04 files changed, 23 insertions(+)
>=20
> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> index 4c7d16a99ed6..d4f04534966a 100644
> --- a/fs/nfs/localio.c
> +++ b/fs/nfs/localio.c
> @@ -883,6 +883,13 @@ static void nfs_local_call_write(struct
> work_struct *work)
> =C2=A0		/* Break on completion, errors, or short writes */
> =C2=A0		if (nfs_local_pgio_done(iocb, status) || status < 0
> ||
> =C2=A0		=C2=A0=C2=A0=C2=A0 (size_t)status < iov_iter_count(&iocb-
> >iters[i])) {
> +			if ((size_t)status < iov_iter_count(&iocb-
> >iters[i])) {

Can we please do something to avoid 2 calls to iov_iter_count() here?

> +				struct nfs_lock_context *ctx =3D
> +					iocb->hdr->req-
> >wb_lock_context;
> +
> +				set_bit(NFS_CONTEXT_WRITE_SYNC,
> +					&ctx->open_context->flags);
> +			}
> =C2=A0			nfs_local_write_iocb_done(iocb);
> =C2=A0			break;
> =C2=A0		}
> @@ -901,6 +908,9 @@ static void nfs_local_do_write(struct
> nfs_local_kiocb *iocb,
> =C2=A0		__func__, hdr->args.count, hdr->args.offset,
> =C2=A0		(hdr->args.stable =3D=3D NFS_UNSTABLE) ?=C2=A0 "unstable" :
> "stable");
> =C2=A0
> +	if (test_bit(NFS_CONTEXT_WRITE_SYNC,
> +		=C2=A0=C2=A0=C2=A0=C2=A0 &hdr->req->wb_lock_context->open_context-
> >flags))
> +		hdr->args.stable =3D NFS_FILE_SYNC;
> =C2=A0	switch (hdr->args.stable) {
> =C2=A0	default:
> =C2=A0		break;
> diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
> index a9373de891c9..4a87b2fdb2e6 100644
> --- a/fs/nfs/pagelist.c
> +++ b/fs/nfs/pagelist.c
> @@ -1186,6 +1186,9 @@ static int __nfs_pageio_add_request(struct
> nfs_pageio_descriptor *desc,
> =C2=A0
> =C2=A0	nfs_page_group_lock(req);
> =C2=A0
> +	if (test_bit(NFS_CONTEXT_WRITE_SYNC,
> +		=C2=A0=C2=A0=C2=A0=C2=A0 &req->wb_lock_context->open_context->flags))
> +		desc->pg_ioflags |=3D FLUSH_STABLE;
> =C2=A0	subreq =3D req;
> =C2=A0	subreq_size =3D subreq->wb_bytes;
> =C2=A0	for(;;) {
> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> index 1ed4b3590b1a..ddae197d2d3f 100644
> --- a/fs/nfs/write.c
> +++ b/fs/nfs/write.c
> @@ -927,9 +927,13 @@ static void nfs_write_completion(struct
> nfs_pgio_header *hdr)
> =C2=A0			goto remove_req;
> =C2=A0		}
> =C2=A0		if (nfs_write_need_commit(hdr)) {
> +			struct nfs_open_context *ctx =3D
> +				hdr->req->wb_lock_context-
> >open_context;
> +
> =C2=A0			/* Reset wb_nio, since the write was
> successful. */
> =C2=A0			req->wb_nio =3D 0;
> =C2=A0			memcpy(&req->wb_verf, &hdr->verf.verifier,
> sizeof(req->wb_verf));
> +			clear_bit(NFS_CONTEXT_WRITE_SYNC, &ctx-
> >flags);
> =C2=A0			nfs_mark_request_commit(req, hdr->lseg,
> &cinfo,
> =C2=A0				hdr->ds_commit_idx);
> =C2=A0			goto next;
> @@ -1553,7 +1557,10 @@ static void nfs_writeback_result(struct
> rpc_task *task,
> =C2=A0
> =C2=A0	if (resp->count < argp->count) {
> =C2=A0		static unsigned long=C2=A0=C2=A0=C2=A0 complain;
> +		struct nfs_open_context *ctx =3D
> +			hdr->req->wb_lock_context->open_context;
> =C2=A0
> +		set_bit(NFS_CONTEXT_WRITE_SYNC, &ctx->flags);
> =C2=A0		/* This a short write! */
> =C2=A0		nfs_inc_stats(hdr->inode, NFSIOS_SHORTWRITE);
> =C2=A0
> @@ -1837,6 +1844,8 @@ static void nfs_commit_release_pages(struct
> nfs_commit_data *data)
> =C2=A0		/* We have a mismatch. Write the page again */
> =C2=A0		dprintk(" mismatch\n");
> =C2=A0		nfs_mark_request_dirty(req);
> +		set_bit(NFS_CONTEXT_WRITE_SYNC,
> +			&req->wb_lock_context->open_context->flags);
> =C2=A0		atomic_long_inc(&NFS_I(data->inode)-
> >redirtied_pages);
> =C2=A0	next:
> =C2=A0		nfs_unlock_and_release_request(req);
> diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
> index 8dd79a3f3d66..4623262da3c0 100644
> --- a/include/linux/nfs_fs.h
> +++ b/include/linux/nfs_fs.h
> @@ -109,6 +109,7 @@ struct nfs_open_context {
> =C2=A0#define NFS_CONTEXT_BAD			(2)
> =C2=A0#define NFS_CONTEXT_UNLOCK	(3)
> =C2=A0#define NFS_CONTEXT_FILE_OPEN		(4)
> +#define NFS_CONTEXT_WRITE_SYNC		(5)
> =C2=A0
> =C2=A0	struct nfs4_threshold	*mdsthreshold;
> =C2=A0	struct list_head list;

Otherwise, the rest looks good to me.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

