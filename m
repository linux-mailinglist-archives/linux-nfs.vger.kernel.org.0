Return-Path: <linux-nfs+bounces-11683-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36616AB549B
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 14:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEC7E19E2352
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 12:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650BB28DB67;
	Tue, 13 May 2025 12:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SYH1Rela"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A39242D6F
	for <linux-nfs@vger.kernel.org>; Tue, 13 May 2025 12:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747138943; cv=none; b=S+ZtzNX3m7LsyC0emanCSN+sA9HeWcG6lemuTBXVGeOHS2MFycunTJQtDqbx8/9vZMgsKuHATdCfjwcwq5IhgfW9nFCHkd5BRcgrsMLni5HQVA/Zj4LI49g5iOfLo0p/YlPg7S6EN6J5owNExNMtCeZLQYbFVFP/61EeeTwjvc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747138943; c=relaxed/simple;
	bh=3YbfeYjFKH3IJ2nqQzkl9zckrwJcT/qVhCY37SIrN+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M/clPf0/IYM4dEMbkHQIUROf1ZjYWLrbfnCWklO9pgIOYGnsJaIgHsmydiphxJtcWbIbd/lECy6X3U2+OfLR9Jyy4qE6rE65SIglizH/3eJVmUy9G/hlgTff4ZElN5/80dpLWJpqez0STtLw02t/qifRYgXZnOwk0DZJYA894gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SYH1Rela; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747138939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NT/xrfv5TBvzT3fT6ervznNFvl/oozjfVV92cittWdY=;
	b=SYH1Rela9FW8JjOnf5q/BLWD6qe1BHs98+DQLCq0cO1jgu7Mx2nI5yxvlp+cngUory2JiP
	btP6pSNWVbKSzqzf+dQ8mHU4RZarOOdCUX2AVz6DZ6Kv5NT5vFPVZaLAnZOPW76YQZGXg5
	SfW3mqIxNH2ZYbuc8CCxXTHtFZlr+lU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-MoWDOE8MPl26ge0BF8l44g-1; Tue,
 13 May 2025 08:22:15 -0400
X-MC-Unique: MoWDOE8MPl26ge0BF8l44g-1
X-Mimecast-MFC-AGG-ID: MoWDOE8MPl26ge0BF8l44g_1747138934
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D44E71801A14;
	Tue, 13 May 2025 12:22:13 +0000 (UTC)
Received: from [10.22.89.59] (unknown [10.22.89.59])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E95A21800359;
	Tue, 13 May 2025 12:22:10 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Li Lingfeng <lilingfeng3@huawei.com>
Cc: trondmy@kernel.org, anna@kernel.org, jlayton@kernel.org,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com,
 yangerkun@huawei.com, lilingfeng@huaweicloud.com
Subject: Re: [PATCH v2] nfs: handle failure of nfs_get_lock_context in unlock
 path
Date: Tue, 13 May 2025 08:20:54 -0400
Message-ID: <A447D4AD-9513-4128-945C-8161426D4C4A@redhat.com>
In-Reply-To: <20250513074226.3362070-1-lilingfeng3@huawei.com>
References: <20250513074226.3362070-1-lilingfeng3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 13 May 2025, at 3:42, Li Lingfeng wrote:

> When memory is insufficient, the allocation of nfs_lock_context in
> nfs_get_lock_context() fails and returns -ENOMEM. If we mistakenly trea=
t
> an nfs4_unlockdata structure (whose l_ctx member has been set to -ENOME=
M)
> as valid and proceed to execute rpc_run_task(), this will trigger a NUL=
L
> pointer dereference in nfs4_locku_prepare. For example:
>
> BUG: kernel NULL pointer dereference, address: 000000000000000c
> PGD 0 P4D 0
> Oops: Oops: 0000 [#1] SMP PTI
> CPU: 15 UID: 0 PID: 12 Comm: kworker/u64:0 Not tainted 6.15.0-rc2-dirty=
 #60
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc=
40
> Workqueue: rpciod rpc_async_schedule
> RIP: 0010:nfs4_locku_prepare+0x35/0xc2
> Code: 89 f2 48 89 fd 48 c7 c7 68 69 ef b5 53 48 8b 8e 90 00 00 00 48 89=
 f3
> RSP: 0018:ffffbbafc006bdb8 EFLAGS: 00010246
> RAX: 000000000000004b RBX: ffff9b964fc1fa00 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: fffffffffffffff4 RDI: ffff9ba53fddbf40
> RBP: ffff9ba539934000 R08: 0000000000000000 R09: ffffbbafc006bc38
> R10: ffffffffb6b689c8 R11: 0000000000000003 R12: ffff9ba539934030
> R13: 0000000000000001 R14: 0000000004248060 R15: ffffffffb56d1c30
> FS: 0000000000000000(0000) GS:ffff9ba5881f0000(0000) knlGS:00000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000000000c CR3: 000000093f244000 CR4: 00000000000006f0
> Call Trace:
>  <TASK>
>  __rpc_execute+0xbc/0x480
>  rpc_async_schedule+0x2f/0x40
>  process_one_work+0x232/0x5d0
>  worker_thread+0x1da/0x3d0
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0x10d/0x240
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x34/0x50
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
> Modules linked in:
> CR2: 000000000000000c
> ---[ end trace 0000000000000000 ]---
>
> Free the allocated nfs4_unlockdata when nfs_get_lock_context() fails an=
d
> return NULL to terminate subsequent rpc_run_task, preventing NULL point=
er
> dereference.
>
> Fixes: f30cb757f680 ("NFS: Always wait for I/O completion before unlock=
")
> Link: https://lore.kernel.org/all/21817f2c-2971-4568-9ae4-1ccc25f7f1ef@=
huawei.com/
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> ---
> Changes in v2:
>   Add a comment explaining that error handling for ctx acquisition fail=
ure
>   is unnecessary.
>
>  fs/nfs/nfs4proc.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 970f28dbf253..e52e2ac1ab39 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -7074,18 +7074,29 @@ static struct nfs4_unlockdata *nfs4_alloc_unloc=
kdata(struct file_lock *fl,
>  	struct nfs4_unlockdata *p;
>  	struct nfs4_state *state =3D lsp->ls_state;
>  	struct inode *inode =3D state->inode;
> +	struct nfs_lock_context *l_ctx;
>
>  	p =3D kzalloc(sizeof(*p), GFP_KERNEL);
>  	if (p =3D=3D NULL)
>  		return NULL;
> +	l_ctx =3D nfs_get_lock_context(ctx);
> +	if (!IS_ERR(l_ctx)) {
> +		p->l_ctx =3D l_ctx;
> +	} else {
> +		kfree(p);
> +		return NULL;
> +	}
>  	p->arg.fh =3D NFS_FH(inode);
>  	p->arg.fl =3D &p->fl;
>  	p->arg.seqid =3D seqid;
>  	p->res.seqid =3D seqid;
>  	p->lsp =3D lsp;
>  	/* Ensure we don't close file until we're done freeing locks! */
> +	/*
> +	 * Since the caller holds a reference to ctx, the refcount must be no=
n-zero.
> +	 * Therefore, error handling for failed ctx acquisition is unnecessar=
y here.
> +	 */

I think the additional comment is unnecessary, but otherwise this looks c=
orrect.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


