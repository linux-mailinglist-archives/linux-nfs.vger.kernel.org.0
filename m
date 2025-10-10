Return-Path: <linux-nfs+bounces-15139-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2D9BCE635
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 21:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2900C19A56C7
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 19:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB5A2737F2;
	Fri, 10 Oct 2025 19:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbCmtgLB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A5C272813;
	Fri, 10 Oct 2025 19:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760124608; cv=none; b=kfPAAyTd0pICsA2kil1lzDTFKPsO3E0Aw3pDWyeKuIEbNjlIoHst6WO/FOu3n96hT3AFw/ttIEBwGYfnzk1+eRCylp9osy+XXD6UUrVnZ76Dql1jjz+qHJtc1Zr3qk//8a589olZrxWQa5oMt5C2jI1Cnah96i7ojuMo0nHdEo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760124608; c=relaxed/simple;
	bh=X6PD5rPNl+xPi+aiCBZrdWb4RCY92xvaYy4Yis8E/As=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KHXEUJg0CfuW815OMzNVgMVRxy3WzA0TGEEBk1eLBE/Uoj15G5hcQqICGZV+UXh3LYFzUzz32irVNnsOoUTKh/M9Ini1KIYf6r+gTYBpWraXMBQxU+ZNKN8A6P8M00RXTbQUg2t5RX2CzNmZeunX65Xg0TOeWfJD78EqkWfpfCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbCmtgLB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5919FC113D0;
	Fri, 10 Oct 2025 19:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760124607;
	bh=X6PD5rPNl+xPi+aiCBZrdWb4RCY92xvaYy4Yis8E/As=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=RbCmtgLBsW47obn4b0rZOnryO2it+q3cmspc1QLf6+VJjwZ4hMvP7pQpwMWgXGnnA
	 3o0PRElIGIyClX2335uaCo/f837V1iI+QHzcvwD8vinUCtM7j/aujJVS9P6Lavp7E/
	 +JerQ8P1bsWbR/zES8G/KTYjLs14wsGFXQbL37CfhT4V3y/0sQgj9WdKqEah0CN3+Z
	 V55WKNk/Q3QLOmJi01633FrQEKOnivxOQSxubQN/PEzmG2LrQoR6Qtm8iFtKDTwkLS
	 hLO4M7InGOdjzdEYQS7eoeqGNLUpKHYdy2San/C4odXzRqFmSaaLWu46RrYJoivPCB
	 7GlQJJNGe35Bg==
Message-ID: <0c8c170f9b6b49b6a7aad0a0a53457d52987fa22.camel@kernel.org>
Subject: Re: [PATCH v4] nfsd: remove long-standing revoked delegations by
 force
From: Jeff Layton <jlayton@kernel.org>
To: Li Lingfeng <lilingfeng3@huawei.com>, chuck.lever@oracle.com, 
	neil@brown.name, okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com, 
	yangerkun@huawei.com, lilingfeng@huaweicloud.com, zhangjian496@huawei.com, 
	bcodding@redhat.com
Date: Fri, 10 Oct 2025 15:30:05 -0400
In-Reply-To: <20251010034333.670068-1-lilingfeng3@huawei.com>
References: <20251010034333.670068-1-lilingfeng3@huawei.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-10 at 11:43 +0800, Li Lingfeng wrote:
> When file access conflicts occur between clients, the server recalls
> delegations. If the client holding delegation fails to return it after
> a recall, nfs4_laundromat adds the delegation to cl_revoked list.
> This causes subsequent SEQUENCE operations to set the
> SEQ4_STATUS_RECALLABLE_STATE_REVOKED flag, forcing the client to
> validate all delegations and return the revoked one.
>=20
> However, if the client fails to return the delegation like this:
> nfs4_laundromat                       nfsd4_delegreturn
>  unhash_delegation_locked
>  list_add // add dp to reaplist
>           // by dl_recall_lru
>  list_del_init // delete dp from
>                // reaplist
>                                        destroy_delegation
>                                         unhash_delegation_locked
>                                          // do nothing but return false
>  revoke_delegation
>  list_add // add dp to cl_revoked
>           // by dl_recall_lru
>=20
> The delegation will remain in the server's cl_revoked list while the
> client marks it revoked and won't find it upon detecting
> SEQ4_STATUS_RECALLABLE_STATE_REVOKED.
> This leads to a loop:
> the server persistently sets SEQ4_STATUS_RECALLABLE_STATE_REVOKED, and th=
e
> client repeatedly tests all delegations, severely impacting performance
> when numerous delegations exist.
>=20
> Since abnormal delegations are removed from flc_lease via nfs4_laundromat
> --> revoke_delegation --> destroy_unhashed_deleg -->
> nfs4_unlock_deleg_lease --> kernel_setlease, and do not block new open
> requests indefinitely, retaining such a delegation on the server is
> unnecessary.
>=20
> Reported-by: Zhang Jian <zhangjian496@huawei.com>
> Fixes: 3bd64a5ba171 ("nfsd4: implement SEQ4_STATUS_RECALLABLE_STATE_REVOK=
ED")
> Closes: https://lore.kernel.org/all/ff8debe9-6877-4cf7-ba29-fc98eae0ffa0@=
huawei.com/
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> ---
>   Changes in v2:
>   1) Set SC_STATUS_CLOSED unconditionally in destroy_delegation();
>   2) Determine whether to remove the delegation based on SC_STATUS_CLOSED=
,
>      rather than by timeout;
>   3) Modify the commit message.
>=20
>   Changes in v3:
>   1) Move variables used for traversal inside the if statement;
>   2) Add a comment to explain why we have to do this;
>   3) Move the second check of cl_revoked inside the if statement of
>      the first check.
>=20
>   Changes in v4:
>   Stuff dp onto a local list under the protect of cl_lock and put all
>   the items later.
>  fs/nfsd/nfs4state.c | 41 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 39 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 81fa7cc6c77b..30fed3845fa1 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1373,6 +1373,11 @@ static void destroy_delegation(struct nfs4_delegat=
ion *dp)
> =20
>  	spin_lock(&state_lock);
>  	unhashed =3D unhash_delegation_locked(dp, SC_STATUS_CLOSED);
> +	/*
> +	 * Unconditionally set SC_STATUS_CLOSED, regardless of whether the
> +	 * delegation is hashed, to mark the current delegation as invalid.
> +	 */
> +	dp->dl_stid.sc_status |=3D SC_STATUS_CLOSED;

I think we should just unconditionally apply status flags on every call
to unhash_delegation_locked() instead of special-casing it here.

>  	spin_unlock(&state_lock);
>  	if (unhashed)
>  		destroy_unhashed_deleg(dp);
> @@ -4507,8 +4512,40 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd=
4_compound_state *cstate,
>  	default:
>  		seq->status_flags =3D 0;
>  	}
> -	if (!list_empty(&clp->cl_revoked))
> -		seq->status_flags |=3D SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
> +	if (!list_empty(&clp->cl_revoked)) {
> +		struct list_head *pos, *next, reaplist;
> +		struct nfs4_delegation *dp;
> +
> +		/*
> +		 * Concurrent nfs4_laundromat() and nfsd4_delegreturn()
> +		 * may add a delegation to cl_revoked even after the
> +		 * client has returned it, causing persistent
> +		 * SEQ4_STATUS_RECALLABLE_STATE_REVOKED, disrupting normal
> +		 * operations.
> +		 * Remove delegations with SC_STATUS_CLOSED from cl_revoked
> +		 * to resolve.
> +		 */
> +		INIT_LIST_HEAD(&reaplist);
> +		spin_lock(&clp->cl_lock);
> +		list_for_each_safe(pos, next, &clp->cl_revoked) {
> +			dp =3D list_entry(pos, struct nfs4_delegation, dl_recall_lru);
> +			if (dp->dl_stid.sc_status & SC_STATUS_CLOSED) {
> +				list_del_init(&dp->dl_recall_lru);
> +				list_add(&dp->dl_recall_lru, &reaplist);
> +			}
> +		}
> +		spin_unlock(&clp->cl_lock);
> +
> +		while (!list_empty(&reaplist)) {
> +			dp =3D list_first_entry(&reaplist, struct nfs4_delegation,
> +						dl_recall_lru);
> +			list_del_init(&dp->dl_recall_lru);
> +			nfs4_put_stid(&dp->dl_stid);
> +		}
> +
> +		if (!list_empty(&clp->cl_revoked))
> +			seq->status_flags |=3D SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
> +	}
>  	if (atomic_read(&clp->cl_admin_revoked))
>  		seq->status_flags |=3D SEQ4_STATUS_ADMIN_STATE_REVOKED;
>  	trace_nfsd_seq4_status(rqstp, seq);

I'm not thrilled with this fix. It seems heavyweight, and it's also
less than ideal to not just release the delegation in the laundromat
when this happens. Given the race you described in the changelog, would
something like this fix the problem too?

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c9053ef4d79f..7977f94fdc1d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1347,13 +1347,14 @@ unhash_delegation_locked(struct nfs4_delegation *dp=
, unsigned short statusmask)
=20
        lockdep_assert_held(&state_lock);
=20
-       if (!delegation_hashed(dp))
-               return false;
-
        if (statusmask =3D=3D SC_STATUS_REVOKED &&
            dp->dl_stid.sc_client->cl_minorversion =3D=3D 0)
                statusmask =3D SC_STATUS_CLOSED;
        dp->dl_stid.sc_status |=3D statusmask;
+
+       if (!delegation_hashed(dp))
+               return false;
+
        if (statusmask & SC_STATUS_ADMIN_REVOKED)
                atomic_inc(&dp->dl_stid.sc_client->cl_admin_revoked);
=20
@@ -6899,7 +6900,13 @@ nfs4_laundromat(struct nfsd_net *nn)
                dp =3D list_first_entry(&reaplist, struct nfs4_delegation,
                                        dl_recall_lru);
                list_del_init(&dp->dl_recall_lru);
-               revoke_delegation(dp);
+               if (dp->dl_stid.sc_status & SC_STATUS_REVOKED)
+                       revoke_delegation(dp);
+               else if (dp->dl_stid.sc_status & SC_STATUS_CLOSED)
+                       destroy_unhashed_deleg(dp);
+               else
+                       pr_warn_once("nfsd: unexpected status when revoking=
 deleg: 0x%hx\n",
+                                    dp->dl_stid.sc_status);
        }
=20
        spin_lock(&nn->client_lock);

