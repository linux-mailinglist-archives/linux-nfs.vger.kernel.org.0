Return-Path: <linux-nfs+bounces-17567-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D1ECFEE25
	for <lists+linux-nfs@lfdr.de>; Wed, 07 Jan 2026 17:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 615223366808
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jan 2026 16:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACD53590B3;
	Wed,  7 Jan 2026 15:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mf3tdAz5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8502927991E
	for <linux-nfs@vger.kernel.org>; Wed,  7 Jan 2026 15:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767798477; cv=none; b=Jtv7Mq7Ur7yJiXz3Aui5C7ytQuNcIlfdIlK0PcKLaxG7ffu5nrxKaLTRpycHSlT53Ok1J0HoLa0A66ijOSEMhohlrHj7J69nJGHhl2iAhGEZNxVYZK3+tOfOKjBd3jEwksvs6rSzucm1HmY82ZdW2+rFuqYyDjzGthV4CGoURfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767798477; c=relaxed/simple;
	bh=sYLvV3EeHfiY0NoBAs21p/wcWRferPjqy29TNZlDS4A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lBk4chbHTO6CilQT9jJWm0MDyhzXRQ0TXqIkwykF7GhZJ9Q6h18tMdfmWPtKHKNqzl6dkiZf+JagAQ6V6F0MUoncpBppDBp9QX208dXirAbzOVQW2o9vnni2eCwIBRYt4/zva6e3czK19QHc3QBKU4m5QAvsEl7sNJh3cX+vG5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mf3tdAz5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC945C4CEF1;
	Wed,  7 Jan 2026 15:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767798477;
	bh=sYLvV3EeHfiY0NoBAs21p/wcWRferPjqy29TNZlDS4A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=mf3tdAz5yIrMVaGgo14V1jGOG8ZO93tE1Jvtduld55Ngf6pEEbIIon7VlAZOAML+K
	 g5TV+LrNF9cHwl4PMoPUKAR6Q/hJnqgJMOqS5Sh8fPyUa0EEeSKvdodzydIJ6EWGg/
	 u8lcqSlDClFnsJ3ov2S/IcyhJBQPgFw4+Uehnt6jaTC9TKdj5EnZRuPsjirEp7q4jo
	 ntZWpHqGnLvaL1nT1nVaHbreIt03QRD0qsu/FCQOTRPIjNQaBqhCFZxErtqp7GHA/r
	 ppIq4suDyx6f2pfeYZ4/q+wLNooaP/z2OhBbWWHt+Un3+1RTSSR1fr1suV5dfiJO7A
	 XOMSZmmJIlpMA==
Message-ID: <d8ddd23a18985ae360855931f185d0e24c466310.camel@kernel.org>
Subject: Re: [PATCH] NFS: Fix directory delegation verifier checks
From: Trond Myklebust <trondmy@kernel.org>
To: "hch@infradead.ori" <hch@infradead.org>
Cc: "anna@kernel.org" <anna@kernel.org>, "linux-nfs@vger.kernel.org"
	 <linux-nfs@vger.kernel.org>
Date: Wed, 07 Jan 2026 10:07:55 -0500
In-Reply-To: <aV3ttYmT2vAtPDws@infradead.org>
References: <20251219201344.380279-1-anna@kernel.org>
	 <aUnHnlnDtwMJGP3u@infradead.org> <aUnq_d93Wo9e-oUD@infradead.org>
	 <53d40f4781783f9b79196bb30975b788be8bb969.camel@hammerspace.com>
	 <aVyp3SIddHB5sMhp@infradead.org>
	 <1df4bb7ff3e6fd607c1811d75fcd6dcb860e320e.camel@kernel.org>
	 <aV3ttYmT2vAtPDws@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-01-06 at 21:23 -0800, hch@infradead.ori wrote:
> On Tue, Jan 06, 2026 at 01:32:54PM -0500, Trond Myklebust wrote:
> > Sigh... One last patch on top of all the previous ones, but if we
> > hit
> > another issue I think we need to consider just disabling directory
> > delegations on the client until all the remaining issues can be
> > fixed
> > in the next release.
>=20
> This still crashe=D1=95 generic/633:
>=20
> generic/633=C2=A0 4s ... [=C2=A0=C2=A0 73.075526] run fstests generic/633=
 at 2026-
> 01-07 05:21:37
> [=C2=A0=C2=A0 73.286318] process 'vfstest' launched '/dev/fd/4/file1' wit=
h NULL
> argv: empty string added
> [=C2=A0=C2=A0 73.314625] Oops: general protection fault, probably for non=
-
> canonical address 0xcccccccccccccd50: 0000 [#1] SMP NOPTI
> [=C2=A0=C2=A0 73.315391] CPU: 1 UID: 0 PID: 100 Comm: kworker/u8:3 Tainte=
d:
> G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 N=C2=A0 6.19.0-rc4+ #4540 PREEMPT(full)=20
> [=C2=A0=C2=A0 73.316043] Tainted: [N]=3DTEST
> [=C2=A0=C2=A0 73.316229] Hardware name: QEMU Standard PC (i440FX + PIIX, =
1996),
> BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [=C2=A0=C2=A0 73.316786] Workqueue: rpciod rpc_async_schedule
> [=C2=A0=C2=A0 73.317066] RIP: 0010:nfs_inode_find_state_and_recover+0x9c/=
0x260
> [=C2=A0=C2=A0 73.317430] Code: 01 0f 85 83 00 00 00 49 8b 84 24 80 00 00 =
00 4c
> 8d 60 80 48 39 c3 0f 84 68 01 00 00 4d 8b 7c 24 60 4d 85 ff 74 e1 48
> 8b 7d 00 <49> 39 bf 84 00 00 00 75 af 8b 4d 08 41 39 8f 8c 00 00 00
> 75 a3 48
> [=C2=A0=C2=A0 73.318513] RSP: 0018:ffffc900001bfd00 EFLAGS: 00010286
> [=C2=A0=C2=A0 73.318868] RAX: ffff88810cfb98e0 RBX: ffff8881d68d8c50 RCX:
> 0000000000000000
> [=C2=A0=C2=A0 73.319354] RDX: ffff88810330a0c0 RSI: ffff88811a86d914 RDI:
> b6162427695ded30
> [=C2=A0=C2=A0 73.319832] RBP: ffff88811a86d918 R08: ffff88810c685100 R09:
> ffff88810c685130
> [=C2=A0=C2=A0 73.320270] R10: 0000000000000003 R11: fefefefefefefeff R12:
> ffff88810cfb9860
> [=C2=A0=C2=A0 73.320698] R13: ffff8881179b2800 R14: 0000000000000000 R15:
> cccccccccccccccc
> [=C2=A0=C2=A0 73.321135] FS:=C2=A0 0000000000000000(0000) GS:ffff8882b363=
d000(0000)
> knlGS:0000000000000000
> [=C2=A0=C2=A0 73.321640] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080=
050033
> [=C2=A0=C2=A0 73.321994] CR2: 0000559277cef238 CR3: 0000000161792002 CR4:
> 0000000000772ef0
> [=C2=A0=C2=A0 73.322422] PKRU: 55555554
> [=C2=A0=C2=A0 73.322592] Call Trace:
> [=C2=A0=C2=A0 73.322749]=C2=A0 <TASK>
> [=C2=A0=C2=A0 73.322889]=C2=A0 nfs4_delegreturn_done+0x1b7/0x380
> [=C2=A0=C2=A0 73.323173]=C2=A0 ? __pfx_rpc_exit_task+0x10/0x10
> [=C2=A0=C2=A0 73.323475]=C2=A0 rpc_exit_task+0x5c/0x170
> [=C2=A0=C2=A0 73.323755]=C2=A0 __rpc_execute+0xb1/0x490
> [=C2=A0=C2=A0 73.324000]=C2=A0 rpc_async_schedule+0x2a/0x40
> [=C2=A0=C2=A0 73.324257]=C2=A0 process_one_work+0x16c/0x330
> [=C2=A0=C2=A0 73.324515]=C2=A0 worker_thread+0x254/0x3a0
> [=C2=A0=C2=A0 73.324762]=C2=A0 ? __pfx_worker_thread+0x10/0x10
> [=C2=A0=C2=A0 73.325042]=C2=A0 kthread+0x117/0x230
> [=C2=A0=C2=A0 73.325303]=C2=A0 ? __pfx_kthread+0x10/0x10
> [=C2=A0=C2=A0 73.325557]=C2=A0 ? __pfx_kthread+0x10/0x10
> [=C2=A0=C2=A0 73.325812]=C2=A0 ret_from_fork+0x1b6/0x200
> [=C2=A0=C2=A0 73.326045]=C2=A0 ? __pfx_kthread+0x10/0x10
> [=C2=A0=C2=A0 73.326278]=C2=A0 ret_from_fork_asm+0x1a/0x30
> [=C2=A0=C2=A0 73.326535]=C2=A0 </TASK>
> [=C2=A0=C2=A0 73.326681] Modules linked in: kvm_intel kvm irqbypass
> [=C2=A0=C2=A0 73.327046] ---[ end trace 0000000000000000 ]---

Thanks for doing all this testing, Christoph. I really appreciate it.
The previous patch was incomplete. This is incremental to yesterday's
patch, but I'll squash them together in the testing branch, since
they're both about blocking state recovery in the non-regular file
case.

8<-----------------------------------------------------------------
From 534676d290af6fae6ad1b067b81c13523340bc83 Mon Sep 17 00:00:00 2001
Message-ID: <534676d290af6fae6ad1b067b81c13523340bc83.1767798220.git.trond.=
myklebust@hammerspace.com>
From: Trond Myklebust <trond.myklebust@hammerspace.com>
Date: Wed, 7 Jan 2026 10:01:58 -0500
Subject: [PATCH] NFSv4.x: Directory delegations don't require any state
 recovery (part 2)

This patch will be squashed with part 1.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4state.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 01179f7de322..dba51c622cf3 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1445,6 +1445,8 @@ void nfs_inode_find_state_and_recover(struct inode *i=
node,
 	struct nfs4_state *state;
 	bool found =3D false;
=20
+	if (!S_ISREG(inode->i_mode))
+		goto out;
 	rcu_read_lock();
 	list_for_each_entry_rcu(ctx, &nfsi->open_files, list) {
 		state =3D ctx->state;
@@ -1466,7 +1468,7 @@ void nfs_inode_find_state_and_recover(struct inode *i=
node,
 			found =3D true;
 	}
 	rcu_read_unlock();
-
+out:
 	nfs_inode_find_delegation_state_and_recover(inode, stateid);
 	if (found)
 		nfs4_schedule_state_manager(clp);
@@ -1478,6 +1480,8 @@ static void nfs4_state_mark_open_context_bad(struct n=
fs4_state *state, int err)
 	struct nfs_inode *nfsi =3D NFS_I(inode);
 	struct nfs_open_context *ctx;
=20
+	if (!S_ISREG(inode->i_mode))
+		return;
 	rcu_read_lock();
 	list_for_each_entry_rcu(ctx, &nfsi->open_files, list) {
 		if (ctx->state !=3D state)
--=20
2.52.0


