Return-Path: <linux-nfs+bounces-19884-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAegMFjVrmlhJAIAu9opvQ
	(envelope-from <linux-nfs+bounces-19884-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Mar 2026 15:12:40 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A4623A529
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Mar 2026 15:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 164B03007A54
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Mar 2026 14:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1D93CF680;
	Mon,  9 Mar 2026 14:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctcWF/ZD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985D63CF678;
	Mon,  9 Mar 2026 14:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773065555; cv=none; b=cpocsMJTheaHZU65EjpdmkiCLpvrnz+8q01fHRsCQpj1t1AZZR2KGFML6cQzRHhOb0IHgRu7FqVhuCLCW2CtaS4OvAKfwfJarqCR2xd1MBtqaiocXyrJa9xESfrxRegw58VmlG4u+OM0mVGzxtZvZz0iAXSyfTioylthh6vkELk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773065555; c=relaxed/simple;
	bh=EQOgYKFPmhDD+NDV+u/4t459Y/mlKzkysbh01evsqco=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tEX6PUn49ph+TM92Lp0GPndc0v6yhkLtbPkMu4by/NnTdJJQE4sZu4g78F7/PcmWGLP7UY3vZUQQY1ytHG2tuIy/27Rvn7JWzPN+L/Y3pz6c/7coA3EJ5+zKK4hd8r+ORb8rASUmePqgYHxWx49qqHBDBRBjkYKWkAYqW1FKFIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctcWF/ZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466EBC2BC86;
	Mon,  9 Mar 2026 14:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773065555;
	bh=EQOgYKFPmhDD+NDV+u/4t459Y/mlKzkysbh01evsqco=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ctcWF/ZDG3yl5SLxXjeE3JvvOlvlDOGWMJyvjmuL5jrInD/C/V3TPXyowOKx/fKvB
	 F6SSG+dtHIZBSXYFzQ1BeEiHr/a123ato0By0+XquUdRSHUMqKMCj5q0K+2nLypTGu
	 T9SV7PPTninQdbnkq4vCFdbOjnD4mLCPhWWVO0AuAh0JBI+RAoKcA0GjBdn6bhJ9Z0
	 x3a0ju5rzWw4y93dtkEe+guVvr6Kw1bkmfKw+kwNz8l40O/eXyKZwJrmUNekpO2iI3
	 DIS1bF1TrZBXrQzglE88cc3ZtHjoD+QkHaxyizHIyP6UIsSDbYcZ0IiMagKqjbyM9B
	 V4U0qEImw+mNg==
Message-ID: <c5c31ffa3557e0aab5c1a75d6ff69cb7c7806dc1.camel@kernel.org>
Subject: Re: [RFC PATCH] nfs: use nfsi->rwsem to protect traversal of the
 file lock list
From: Jeff Layton <jlayton@kernel.org>
To: Yang Erkun <yangerkun@huawei.com>, trondmy@kernel.org, anna@kernel.org, 
	chuck.lever@oracle.com
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yangerkun@huaweicloud.com, lilingfeng3@huawei.com,
 zhangjian496@h-partners.com, 	yi.zhang@huawei.com
Date: Mon, 09 Mar 2026 10:12:22 -0400
In-Reply-To: <20260226012203.3962997-1-yangerkun@huawei.com>
References: <20260226012203.3962997-1-yangerkun@huawei.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: D0A4623A529
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19884-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.933];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, 2026-02-26 at 09:22 +0800, Yang Erkun wrote:
> Lingfeng identified a bug and suggested two solutions, but both appear
> to have issues.
>=20
> Generally, we cannot release flc_lock while iterating over the file lock
> list to avoid use-after-free (UAF) problems with file locks. However,
> functions like nfs_delegation_claim_locks and nfs4_reclaim_locks cannot
> adhere to this rule because recover_lock or nfs4_lock_delegation_recall
> may take a long time. To resolve this, NFS switches to using nfsi->rwsem
> for the same protection, and nfs_reclaim_locks follows this approach.
> Although nfs_delegation_claim_locks uses so_delegreturn_mutex instead,
> this is inadequate since a single inode can have multiple nfs4_state
> instances. Therefore, the fix is to also use nfsi->rwsem in this case.
>=20
> Furthermore, after commit c69899a17ca4 ("NFSv4: Update of VFS byte range
> lock must be atomic with the stateid update"), the functions
> nfs4_locku_done and nfs4_lock_done also break this rule because they
> call locks_lock_inode_wait without holding nfsi->rwsem. Simply adding
> this protection could cause many deadlocks, so instead, the call to
> locks_lock_inode_wait is moved into _nfs4_proc_setlk. Regarding the bug
> fixed by commit c69899a17ca4 ("NFSv4: Update of VFS byte range
> lock must be atomic with the stateid update"), it has been resolved
> after commit 0460253913e5 ("NFSv4: nfs4_do_open() is incorrectly triggeri=
ng
> state recovery") because all slots are drained before calling
> nfs4_do_reclaim, which prevents concurrent stateid changes along this pat=
h.
> Also, nfs_delegation_claim_locks does not cause this concurrency either
> since when _nfs4_proc_setlk is called with NFS_DELEGATED_STATE, no RPC is
> sent, so nfs4_lock_done is not called. Therefore,
> nfs4_lock_delegation_recall from nfs_delegation_claim_locks is the first
> time the stateid is set.
>=20
> Reported-by: Li Lingfeng <lilingfeng3@huawei.com>
> Closes: https://lore.kernel.org/all/20250419085709.1452492-1-lilingfeng3@=
huawei.com/
> Closes: https://lore.kernel.org/all/20250715030559.2906634-1-lilingfeng3@=
huawei.com/
> Fixes: c69899a17ca4 ("NFSv4: Update of VFS byte range lock must be atomic=
 with the stateid update")
> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
> ---
>  fs/nfs/delegation.c     |  9 ++++++++-
>  fs/nfs/nfs4proc.c       | 22 +++++++++++-----------
>  include/linux/nfs_xdr.h |  1 -
>  3 files changed, 19 insertions(+), 13 deletions(-)
>=20
> diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
> index 122fb3f14ffb..9546d2195c25 100644
> --- a/fs/nfs/delegation.c
> +++ b/fs/nfs/delegation.c
> @@ -173,6 +173,7 @@ int nfs4_check_delegation(struct inode *inode, fmode_=
t type)
>  static int nfs_delegation_claim_locks(struct nfs4_state *state, const nf=
s4_stateid *stateid)
>  {
>  	struct inode *inode =3D state->inode;
> +	struct nfs_inode *nfsi =3D NFS_I(inode);
>  	struct file_lock *fl;
>  	struct file_lock_context *flctx =3D locks_inode_context(inode);
>  	struct list_head *list;
> @@ -182,6 +183,9 @@ static int nfs_delegation_claim_locks(struct nfs4_sta=
te *state, const nfs4_state
>  		goto out;
> =20
>  	list =3D &flctx->flc_posix;
> +
> +	/* Guard against reclaim and new lock/unlock calls */
> +	down_write(&nfsi->rwsem);
>  	spin_lock(&flctx->flc_lock);
>  restart:
>  	for_each_file_lock(fl, list) {
> @@ -189,8 +193,10 @@ static int nfs_delegation_claim_locks(struct nfs4_st=
ate *state, const nfs4_state
>  			continue;
>  		spin_unlock(&flctx->flc_lock);
>  		status =3D nfs4_lock_delegation_recall(fl, state, stateid);
> -		if (status < 0)
> +		if (status < 0) {
> +			up_write(&nfsi->rwsem);
>  			goto out;
> +		}
>  		spin_lock(&flctx->flc_lock);
>  	}
>  	if (list =3D=3D &flctx->flc_posix) {
> @@ -198,6 +204,7 @@ static int nfs_delegation_claim_locks(struct nfs4_sta=
te *state, const nfs4_state
>  		goto restart;
>  	}
>  	spin_unlock(&flctx->flc_lock);
> +	up_write(&nfsi->rwsem);
>  out:
>  	return status;
>  }
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 91bcf67bd743..9d6fbca8798b 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -7076,7 +7076,6 @@ static void nfs4_locku_done(struct rpc_task *task, =
void *data)
>  	switch (task->tk_status) {
>  		case 0:
>  			renew_lease(calldata->server, calldata->timestamp);
> -			locks_lock_inode_wait(calldata->lsp->ls_state->inode, &calldata->fl);
>  			if (nfs4_update_lock_stateid(calldata->lsp,
>  					&calldata->res.stateid))
>  				break;
> @@ -7344,11 +7343,6 @@ static void nfs4_lock_done(struct rpc_task *task, =
void *calldata)
>  	case 0:
>  		renew_lease(NFS_SERVER(d_inode(data->ctx->dentry)),
>  				data->timestamp);
> -		if (data->arg.new_lock && !data->cancelled) {
> -			data->fl.c.flc_flags &=3D ~(FL_SLEEP | FL_ACCESS);
> -			if (locks_lock_inode_wait(lsp->ls_state->inode, &data->fl) < 0)
> -				goto out_restart;
> -		}
>  		if (data->arg.new_lock_owner !=3D 0) {
>  			nfs_confirm_seqid(&lsp->ls_seqid, 0);
>  			nfs4_stateid_copy(&lsp->ls_stateid, &data->res.stateid);
> @@ -7459,11 +7453,10 @@ static int _nfs4_do_setlk(struct nfs4_state *stat=
e, int cmd, struct file_lock *f
>  	msg.rpc_argp =3D &data->arg;
>  	msg.rpc_resp =3D &data->res;
>  	task_setup_data.callback_data =3D data;
> -	if (recovery_type > NFS_LOCK_NEW) {
> -		if (recovery_type =3D=3D NFS_LOCK_RECLAIM)
> -			data->arg.reclaim =3D NFS_LOCK_RECLAIM;
> -	} else
> -		data->arg.new_lock =3D 1;
> +
> +	if (recovery_type =3D=3D NFS_LOCK_RECLAIM)
> +		data->arg.reclaim =3D NFS_LOCK_RECLAIM;
> +
>  	task =3D rpc_run_task(&task_setup_data);
>  	if (IS_ERR(task))
>  		return PTR_ERR(task);
> @@ -7573,6 +7566,13 @@ static int _nfs4_proc_setlk(struct nfs4_state *sta=
te, int cmd, struct file_lock
>  	up_read(&nfsi->rwsem);
>  	mutex_unlock(&sp->so_delegreturn_mutex);
>  	status =3D _nfs4_do_setlk(state, cmd, request, NFS_LOCK_NEW);
> +	if (status)
> +		goto out;
> +
> +	down_read(&nfsi->rwsem);
> +	request->c.flc_flags &=3D ~(FL_SLEEP | FL_ACCESS);
> +	status =3D locks_lock_inode_wait(state->inode, request);
> +	up_read(&nfsi->rwsem);
>  out:
>  	request->c.flc_flags =3D flags;
>  	return status;
> diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> index ff1f12aa73d2..9599ad15c3ad 100644
> --- a/include/linux/nfs_xdr.h
> +++ b/include/linux/nfs_xdr.h
> @@ -580,7 +580,6 @@ struct nfs_lock_args {
>  	struct nfs_lowner	lock_owner;
>  	unsigned char		block : 1;
>  	unsigned char		reclaim : 1;
> -	unsigned char		new_lock : 1;
>  	unsigned char		new_lock_owner : 1;
>  };
> =20

FWIW, I did point Claude at this too and it found no regressions. The
commit log was a bit hard to parse, Claude's summary is here:

This patch fixes a use-after-free bug in NFS file lock list traversal.
The core problem was that nfs_delegation_claim_locks released flctx-
>flc_lock during iteration (to call nfs4_lock_delegation_recall, which
can block on RPCs) and relied on so_delegreturn_mutex for protection =E2=80=
=94
but that mutex is per-state-owner, not per-inode, so multiple state
owners on the same inode could race.                               =20
                                                                           =
         =20
The fix uses nfsi->rwsem (per-inode) for proper protection, matching
the existing pattern in nfs4_reclaim_locks. It also moves
locks_lock_inode_wait out of RPC callbacks (nfs4_lock_done,
nfs4_locku_done) into the synchronous caller (_nfs4_proc_setlk) so it
can be called under nfsi->rwsem.                                     =20

--=20
Jeff Layton <jlayton@kernel.org>

