Return-Path: <linux-nfs+bounces-17506-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B962CFA89E
	for <lists+linux-nfs@lfdr.de>; Tue, 06 Jan 2026 20:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 03B653012C54
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Jan 2026 19:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C799E253932;
	Tue,  6 Jan 2026 18:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTPvjTex"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3256241663
	for <linux-nfs@vger.kernel.org>; Tue,  6 Jan 2026 18:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767724376; cv=none; b=KgJ9Yt63xC3jlWcr6XiYmUVNu1jyYmvkJhxslpH93KaH+MCwc2+oVEH3JSovBkqhwL4F7bcKaHmtVqtKoMb8wyBglx8MSROBK7BHST5J70PxYX7KtpNwYXznXQn9Bq1aU0UOY4clZ8WNqepoplekt5W+kI0GiTBQevD8ogk50tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767724376; c=relaxed/simple;
	bh=tmme4RHvjTzq2lGvbbrq9M4+0OwmONRQPYbR0UDMru0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LhFUf9Q7gOsOFL5zNkLRx2fRFmA0hrSgt/omDany+8Juf4xHDCmB/j/xeJ9P7+igPhHMTVIW7WR7U2spgbKxrQ7CBrS7093acji14ZQy1Wd/NQKXv89WhRooV06CCWhbTP8tzkgQzUDKktnx4BJ+p/tmnUS+i4wJf3MYZ2gA4YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTPvjTex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00608C116C6;
	Tue,  6 Jan 2026 18:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767724376;
	bh=tmme4RHvjTzq2lGvbbrq9M4+0OwmONRQPYbR0UDMru0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=YTPvjTexotsNpzPNaTr7BtaiZ1kmi+gsixmnyybpRBA22eunBdHYUb/AdV4M+Gvep
	 Ixme2bKHrrC0mjQzBzzEqt5l0Hz4MmOOkTnaEvhddPh4Mk25btRXSlmNDYgOckrA3T
	 vKAzuYNLhTyRmG/5JpEI+s8Dz/8D3PT3n2qjFHcFEw2i0GRCZs2dhcrLhQysllr6fm
	 O9HTBpuQi6O5TEziKs450gk/FSq1w3my7iZ+h/NidjXpiNlIFEw8bniiU4Xr5I8gI0
	 deyNuiGFyLo7/87e24jAX5kluGGN9zHVUZbI7oGEi696/3pY3D9EdnPQoehp08D8ip
	 qFFW4HXawwyDA==
Message-ID: <1df4bb7ff3e6fd607c1811d75fcd6dcb860e320e.camel@kernel.org>
Subject: Re: [PATCH] NFS: Fix directory delegation verifier checks
From: Trond Myklebust <trondmy@kernel.org>
To: "hch@infradead.ori" <hch@infradead.org>
Cc: "anna@kernel.org" <anna@kernel.org>, "linux-nfs@vger.kernel.org"
	 <linux-nfs@vger.kernel.org>
Date: Tue, 06 Jan 2026 13:32:54 -0500
In-Reply-To: <aVyp3SIddHB5sMhp@infradead.org>
References: <20251219201344.380279-1-anna@kernel.org>
	 <aUnHnlnDtwMJGP3u@infradead.org> <aUnq_d93Wo9e-oUD@infradead.org>
	 <53d40f4781783f9b79196bb30975b788be8bb969.camel@hammerspace.com>
	 <aVyp3SIddHB5sMhp@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-01-05 at 22:21 -0800, hch@infradead.ori wrote:
> On Wed, Dec 31, 2025 at 09:52:35PM +0000, Trond Myklebust wrote:
> > Does applying the following on top of Anna's patch fix the Oops?
>=20
> It does.=C2=A0 But now generic/633 crashes reliably:
>=20
> generic/633=C2=A0 2s ... [=C2=A0=C2=A0 58.670535] run fstests generic/633=
 at 2026-
> 01-02 02:00:17
> [=C2=A0=C2=A0 58.865568] process 'vfstest' launched '/dev/fd/4/file1' wit=
h NULL
> argv: empty string added
> [=C2=A0=C2=A0 58.897522] Oops: general protection fault, probably for non=
-
> canonical address 0xcccccccccccccd0c: 0000 [#1] SMP NOPTI
> [=C2=A0=C2=A0 58.898234] CPU: 0 UID: 0 PID: 3852 Comm: vfstest Tainted:
> G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 N=C2=A0 6.19.0-rc2+ #4535 PREEMPT(full)=20
> [=C2=A0=C2=A0 58.898829] Tainted: [N]=3DTEST
> [=C2=A0=C2=A0 58.899013] Hardware name: QEMU Standard PC (i440FX + PIIX, =
1996),
> BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [=C2=A0=C2=A0 58.899594] RIP: 0010:nfs_end_delegation_return+0xda/0x390
> [=C2=A0=C2=A0 58.899922] Code: 49 89 ce e8 58 be bf ff 48 8b 85 60 ff ff =
ff 4c
> 8d 68 80 49 39 c6 74 50 4c 8b 7c 24 08 48 8b 1c 24 4d 8b 65 60 4d 85
> e4 74 2e <49> 8b 44 24 40 a8 02 74 25 49 8b 44 24 40 f6 c4 02 75 1b
> 41 8b 47
> [=C2=A0=C2=A0 58.901063] RSP: 0018:ffffc90001947c90 EFLAGS: 00010286
> [=C2=A0=C2=A0 58.901419] RAX: ffff88811a3122c0 RBX: ffff888105268970 RCX:
> ffff888111a9a210
> [=C2=A0=C2=A0 58.901827] RDX: ffff8881039320c0 RSI: ffff888105268940 RDI:
> ffff888111a9a2b0
> [=C2=A0=C2=A0 58.902236] RBP: ffff888111a9a2b0 R08: 0000000000000000 R09:
> 0000000000000000
> [=C2=A0=C2=A0 58.902696] R10: ffffc90001947d48 R11: fefefefefefefeff R12:
> cccccccccccccccc
> [=C2=A0=C2=A0 58.903112] R13: ffff88811a312240 R14: ffff888111a9a210 R15:
> ffff888105268940
> [=C2=A0=C2=A0 58.903594] FS:=C2=A0 00007f04f92c6740(0000) GS:ffff8882b353=
d000(0000)
> knlGS:0000000000000000
> [=C2=A0=C2=A0 58.904125] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080=
050033
> [=C2=A0=C2=A0 58.904483] CR2: 000055c55fe522d8 CR3: 000000011a3f1004 CR4:
> 0000000000772ef0
> [=C2=A0=C2=A0 58.904927] PKRU: 55555554
> [=C2=A0=C2=A0 58.905132] Call Trace:
> [=C2=A0=C2=A0 58.905294]=C2=A0 <TASK>
> [=C2=A0=C2=A0 58.905434]=C2=A0 ? _raw_spin_unlock+0x13/0x30
> [=C2=A0=C2=A0 58.905689]=C2=A0 nfs4_proc_setattr+0xff/0x110
> [=C2=A0=C2=A0 58.905947]=C2=A0 nfs_setattr+0x1c8/0x410
> [=C2=A0=C2=A0 58.906175]=C2=A0 notify_change+0x373/0x510
> [=C2=A0=C2=A0 58.906415]=C2=A0 ? init_object+0x5a/0xc0
> [=C2=A0=C2=A0 58.906643]=C2=A0 ? chown_common+0x1ec/0x220
> [=C2=A0=C2=A0 58.906885]=C2=A0 chown_common+0x1ec/0x220
> [=C2=A0=C2=A0 58.907126]=C2=A0 do_fchownat+0xc3/0xf0
> [=C2=A0=C2=A0 58.907358]=C2=A0 __x64_sys_fchownat+0x1a/0x30
> [=C2=A0=C2=A0 58.907611]=C2=A0 do_syscall_64+0x50/0xf80
> [=C2=A0=C2=A0 58.907848]=C2=A0 entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [=C2=A0=C2=A0 58.908171] RIP: 0033:0x7f04f93c8e4a
> [=C2=A0=C2=A0 58.908390] Code: 48 8b 0d b1 6f 0e 00 f7 d8 64 89 01 48 83 =
c8 ff
> c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 04 01 00
> 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 7e 6f 0e 00 f7 d8 64
> 89 01 48
> [=C2=A0=C2=A0 58.909467] RSP: 002b:00007ffe4cd3ec98 EFLAGS: 00000246 ORIG=
_RAX:
> 0000000000000104
> [=C2=A0=C2=A0 58.909893] RAX: ffffffffffffffda RBX: 00007ffe4cd3ecb0 RCX:
> 00007f04f93c8e4a
> [=C2=A0=C2=A0 58.910336] RDX: 0000000000002710 RSI: 000055c54836500e RDI:
> 0000000000000003
> [=C2=A0=C2=A0 58.910872] RBP: 000055c55fd522a0 R08: 0000000000000100 R09:
> 0000000000000001
> [=C2=A0=C2=A0 58.911350] R10: 0000000000002710 R11: 0000000000000246 R12:
> 0000000000000006
> [=C2=A0=C2=A0 58.911797] R13: 0000000000002710 R14: 0000000000002710 R15:
> 000055c55fd52313
> [=C2=A0=C2=A0 58.912234]=C2=A0 </TASK>
> [=C2=A0=C2=A0 58.912373] Modules linked in: kvm_intel kvm irqbypass
> [=C2=A0=C2=A0 58.912717] ---[ end trace 0000000000000000 ]---
> [=C2=A0=C2=A0 58.913829] RIP: 0010:nfs_end_delegation_return+0xda/0x390
> [=C2=A0=C2=A0 58.914177] Code: 49 89 ce e8 58 be bf ff 48 8b 85 60 ff ff =
ff 4c
> 8d 68 80 49 39 c6 74 50 4c 8b 7c 24 08 48 8b 1c 24 4d 8b 65 60 4d 85
> e4 74 2e <49> 8b 44 24 40 a8 02 74 25 49 8b 44 24 40 f6 c4 02 75 1b
> 41 8b 47
> [=C2=A0=C2=A0 58.915541] RSP: 0018:ffffc90001947c90 EFLAGS: 00010286
> [=C2=A0=C2=A0 58.915871] RAX: ffff88811a3122c0 RBX: ffff888105268970 RCX:
> ffff888111a9a210
> [=C2=A0=C2=A0 58.916317] RDX: ffff8881039320c0 RSI: ffff888105268940 RDI:
> ffff888111a9a2b0
> [=C2=A0=C2=A0 58.916766] RBP: ffff888111a9a2b0 R08: 0000000000000000 R09:
> 0000000000000000
> [=C2=A0=C2=A0 58.917299] R10: ffffc90001947d48 R11: fefefefefefefeff R12:
> cccccccccccccccc
> [=C2=A0=C2=A0 58.917709] R13: ffff88811a312240 R14: ffff888111a9a210 R15:
> ffff888105268940
> [=C2=A0=C2=A0 58.918109] FS:=C2=A0 00007f04f92c6740(0000) GS:ffff8882b353=
d000(0000)
> knlGS:0000000000000000
> [=C2=A0=C2=A0 58.918560] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080=
050033
> [=C2=A0=C2=A0 58.918944] CR2: 00007fbf39569000 CR3: 000000011a3f1004 CR4:
> 0000000000772ef0
> [=C2=A0=C2=A0 58.919622] PKRU: 55555554

Sigh... One last patch on top of all the previous ones, but if we hit
another issue I think we need to consider just disabling directory
delegations on the client until all the remaining issues can be fixed
in the next release.

Anna, are you able to reproduce these bugs?

8<-----------------------------------------------------------------
From cbf97626edbf8c0b619d37aca8d6da77f46e69d6 Mon Sep 17 00:00:00 2001
Message-ID: <cbf97626edbf8c0b619d37aca8d6da77f46e69d6.1767719343.git.trond.=
myklebust@hammerspace.com>
From: Trond Myklebust <trond.myklebust@hammerspace.com>
Date: Tue, 6 Jan 2026 11:54:32 -0500
Subject: [PATCH] NFSv4.x: Directory delegations don't require any state
 recovery

The state recovery code in nfs_end_delegation_return() is intended to
allow regular files to recover cached open and lock state. It has no
function for directory delegations, and may cause corruption.

Fixes: 156b09482933 ("NFS: Request a directory delegation on ACCESS, CREATE=
, and UNLINK")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 2248e3ad089a..c9fa4c1f68fc 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -581,6 +581,10 @@ static int nfs_end_delegation_return(struct inode *ino=
de, struct nfs_delegation
 	if (delegation =3D=3D NULL)
 		return 0;
=20
+	/* Directory delegations don't require any state recovery */
+	if (!S_ISREG(inode->i_mode))
+		goto out_return;
+
 	if (!issync)
 		mode |=3D O_NONBLOCK;
 	/* Recall of any remaining application leases */
@@ -604,6 +608,7 @@ static int nfs_end_delegation_return(struct inode *inod=
e, struct nfs_delegation
 		goto out;
 	}
=20
+out_return:
 	err =3D nfs_do_return_delegation(inode, delegation, issync);
 out:
 	/* Refcount matched in nfs_start_delegation_return_locked() */
--=20
2.52.0


--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

