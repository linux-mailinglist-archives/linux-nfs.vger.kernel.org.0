Return-Path: <linux-nfs+bounces-17276-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3933CCD79B7
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Dec 2025 02:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5E33300A343
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Dec 2025 01:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF251F63D9;
	Tue, 23 Dec 2025 01:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CGZoRyZN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0205D19CCFC
	for <linux-nfs@vger.kernel.org>; Tue, 23 Dec 2025 01:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766451970; cv=none; b=Erys3p+TKp3haC4aOjAQUc1SxgqGSLe587lGrm8XWT0vzDuuwundqLifSWZoktdl2JQALeuRx4liejktol6hCy3TBjFww8yy6/nicuwogALyp/jHyi3sAbbxuUrF8Ekfh2NXfPaH0JGFWDQ8TSAa5/b8nth6OcjC6BIjkP9ifwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766451970; c=relaxed/simple;
	bh=FJVekBLKYeadXjTrEJ4bFVTJSrqwawNGv1TGC8m5yLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsxI4r1z9kH4kjzQ7SHZbPBKzlVurwJnUi5cYsoK/geR/xz1dOZiWXmsDKUV8JY5gP32gb7l1NHIqLyBnVl8xpEWkXV0pJTSW8rduEORH3F1MLQstX+DqCgY33EK8vpRa3DGcF3D1BjT8dNt/4GC8tCMgheCTi0B4vlW6GzSpTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CGZoRyZN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=G7HmJIqvHZc32PdEXeghlsYyyssdeHE3NxaMijfgEmg=; b=CGZoRyZN38V+8p9iWlKJhyo1MZ
	bGzUwQDieOW9qWkx3HWJHL1P3ZN+3KpRwuRV44TMKjtGyoKZBSRVn/iZF2ghLFwBwRsbNYS1FNGeQ
	lwOuuBCsArddgtSB/WN+aP1WMu1rpP6GKAFIHFITrLP1yxXQTOCKylTPe/kiGuqF3fChLr9LXq6Hm
	dTKNZE8vz6bvIvTDSlAe/zFJFTgwx2eAOCdNwxCJ9RFMA02jlMqj0dxsZv2tIq5Z/KfntsJtpdYkb
	gOdA/ywfV9jt+BC7saEAhM+nUtXX9iR0W9zfJ89ySfr08cdjVWCWAUQecr/QbLLVul+12xPWhLdMo
	6CHhIL6g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXqqj-0000000EKWv-485G;
	Tue, 23 Dec 2025 01:06:06 +0000
Date: Mon, 22 Dec 2025 17:06:05 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Subject: Re: [PATCH] NFS: Fix directory delegation verifier checks
Message-ID: <aUnq_d93Wo9e-oUD@infradead.org>
References: <20251219201344.380279-1-anna@kernel.org>
 <aUnHnlnDtwMJGP3u@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUnHnlnDtwMJGP3u@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Dec 22, 2025 at 02:35:10PM -0800, Christoph Hellwig wrote:
> I wish I could actually review this, but I don't actually understand
> the lookup revalidation logic enough for that.  But it does fix the
> problem I saw, so at least:

Actually - I have to take this back.  This patch makes generic/786
when run on NFS v4.2 go from just failing with:

"Server reported failure (1)"

to actually crashing the kernel:

[   30.195133] run fstests generic/786 at 2025-12-23 01:04:02
[   36.956689] Oops: general protection fault, probably for non-canonical address 0xcccccccccccccd0c: 0000 [#1] SMP NOPTI
[   36.958741] CPU: 0 UID: 0 PID: 3837 Comm: locktest Tainted: G                 N  6.19.0-rc2+ #4523 PREEMPT(full) 
[   36.960855] Tainted: [N]=TEST
[   36.961443] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   36.963167] RIP: 0010:nfs_end_delegation_return+0xda/0x390
[   36.964321] Code: 49 89 ce e8 18 c1 bf ff 48 8b 85 60 ff ff ff 4c 8d 68 80 49 39 c6 74 50 4c 8b 7c 24 08 48 8b 1c 24 4d 8b 65 60 4d 85 e4 74 2e <49> 8b 44 24 40 a8 02 74 25 49 8b 44 24 40 f6 c4 02 75 1b 41 8b 47
[   36.967856] RSP: 0018:ffffc900018e7cc0 EFLAGS: 00010286
[   36.968862] RAX: ffff88810efc5e20 RBX: ffff888104fa6970 RCX: ffff888112570170
[   36.970200] RDX: ffff888105780040 RSI: ffff8881189120e8 RDI: ffff888112570210
[   36.971676] RBP: ffff888112570210 R08: 0000000000000000 R09: 0000000000000000
[   36.973041] R10: ffffc900018e7d78 R11: fefefefefefefeff R12: cccccccccccccccc
[   36.974313] R13: ffff88810efc5da0 R14: ffff888112570170 R15: ffff888104fa6940
[   36.975635] FS:  00007f0df5dc4740(0000) GS:ffff8882b3544000(0000) knlGS:0000000000000000
[   36.977106] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   36.978187] CR2: 00007f0df5e26450 CR3: 0000000118e1b001 CR4: 0000000000772ef0
[   36.979629] PKRU: 55555554
[   36.980205] Call Trace:
[   36.980706]  <TASK>
[   36.981131]  ? nfs_clear_verifier_delegated+0x50/0x70
[   36.982109]  nfs4_proc_setattr+0xff/0x110
[   36.982894]  nfs_setattr+0x1c8/0x410
[   36.983634]  notify_change+0x373/0x510
[   36.984376]  ? chmod_common+0xad/0x160
[   36.985055]  chmod_common+0xad/0x160
[   36.985702]  __x64_sys_chmod+0x56/0xb0
[   36.986388]  do_syscall_64+0x50/0xf80
[   36.987097]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   36.988171] RIP: 0033:0x7f0df5ec6707
[   36.988880] Code: 73 01 c3 48 8b 0d f1 76 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 5a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 c1 76 0e 00 f7 d8 64 89 02 b8
[   36.992424] RSP: 002b:00007fff3cd5bad8 EFLAGS: 00000206 ORIG_RAX: 000000000000005a
[   36.993747] RAX: ffffffffffffffda RBX: 0000558071f19b90 RCX: 00007f0df5ec6707
[   36.995045] RDX: 0000000000000008 RSI: 00000000000001fd RDI: 00007fff3cd5cbc0
[   36.996499] RBP: 0000000000000000 R08: 00000000000001fd R09: 0000000000000000
[   36.997855] R10: 0000000000000003 R11: 0000000000000206 R12: 0000000000000035
[   36.999218] R13: 0000000000000007 R14: 0000000000000000 R15: 0000558071f1ebc0
[   37.000618]  </TASK>
[   37.001039] Modules linked in: kvm_intel kvm irqbypass
[   37.002029] ---[ end trace 0000000000000000 ]---
[   37.003342] RIP: 0010:nfs_end_delegation_return+0xda/0x390
[   37.004372] Code: 49 89 ce e8 18 c1 bf ff 48 8b 85 60 ff ff ff 4c 8d 68 80 49 39 c6 74 50 4c 8b 7c 24 08 48 8b 1c 24 4d 8b 65 60 4d 85 e4 74 2e <49> 8b 44 24 40 a8 02 74 25 49 8b 44 24 40 f6 c4 02 75 1b 41 8b 47
[   37.007875] RSP: 0018:ffffc900018e7cc0 EFLAGS: 00010286
[   37.008902] RAX: ffff88810efc5e20 RBX: ffff888104fa6970 RCX: ffff888112570170
[   37.010307] RDX: ffff888105780040 RSI: ffff8881189120e8 RDI: ffff888112570210
[   37.011702] RBP: ffff888112570210 R08: 0000000000000000 R09: 0000000000000000
[   37.012975] R10: ffffc900018e7d78 R11: fefefefefefefeff R12: cccccccccccccccc
[   37.014271] R13: ffff88810efc5da0 R14: ffff888112570170 R15: ffff888104fa6940
[   37.015600] FS:  00007f0df5dc4740(0000) GS:ffff8882b3544000(0000) knlGS:0000000000000000
[   37.017070] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.018190] CR2: 00007f0df5e26450 CR3: 0000000118e1b002 CR4: 0000000000772ef0
[   37.019525] PKRU: 55555554
[   37.020028] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:287
[   37.021516] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 3837, name: locktest
[   37.022851] preempt_count: 0, expected: 0
[   37.023565] RCU nest depth: 1, expected: 0
[   37.024235] CPU: 0 UID: 0 PID: 3837 Comm: locktest Tainted: G      D          N  6.19.0-rc2+ #4523 PREEMPT(full) 
[   37.024240] Tainted: [D]=DIE, [N]=TEST
[   37.024241] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   37.024242] Call Trace:
[   37.024243]  <TASK>
[   37.024244]  dump_stack_lvl+0x4b/0x70
[   37.024250]  __might_resched.cold+0xd3/0x10e
[   37.024255]  mutex_lock+0x19/0x80
[   37.024259]  sched_mm_cid_exit+0x51/0x1e0
[   37.024263]  do_exit+0xb0/0xa40
[   37.024265]  ? __x64_sys_chmod+0x56/0xb0
[   37.024269]  make_task_dead+0x87/0x90
[   37.024271]  rewind_stack_and_make_dead+0x16/0x20
[   37.024275] RIP: 0033:0x7f0df5ec6707
[   37.024277] Code: 73 01 c3 48 8b 0d f1 76 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 5a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 c1 76 0e 00 f7 d8 64 89 02 b8
[   37.024278] RSP: 002b:00007fff3cd5bad8 EFLAGS: 00000206 ORIG_RAX: 000000000000005a
[   37.024280] RAX: ffffffffffffffda RBX: 0000558071f19b90 RCX: 00007f0df5ec6707
[   37.024281] RDX: 0000000000000008 RSI: 00000000000001fd RDI: 00007fff3cd5cbc0
[   37.024282] RBP: 0000000000000000 R08: 00000000000001fd R09: 0000000000000000
[   37.024283] R10: 0000000000000003 R11: 0000000000000206 R12: 0000000000000035
[   37.024284] R13: 0000000000000007 R14: 0000000000000000 R15: 0000558071f1ebc0
[   37.024286]  </TASK>
[   37.024761] ------------[ cut here ]------------
[   37.041739] Voluntary context switch within RCU read-side critical section!
[   37.041740] WARNING: kernel/rcu/tree_plugin.h:332 at rcu_note_context_switch+0x39b/0x5e0, CPU#0: locktest/3837
[   37.043557] Modules linked in: kvm_intel kvm irqbypass
[   37.044135] CPU: 0 UID: 0 PID: 3837 Comm: locktest Tainted: G      D W        N  6.19.0-rc2+ #4523 PREEMPT(full) 
[   37.045192] Tainted: [D]=DIE, [W]=WARN, [N]=TEST
[   37.045680] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   37.046655] RIP: 0010:rcu_note_context_switch+0x39b/0x5e0
[   37.047211] Code: ef e8 f9 a7 34 01 c6 45 11 00 48 8b 55 28 4c 89 ef 48 89 c6 b9 01 00 00 00 e8 91 97 ff ff e9 d6 fc ff ff 48 8d 3d 25 4f 86 02 <67> 48 0f b9 3a e9 a6 fc ff ff 4c 8b 6d 20 4c 89 ef e8 bf a7 34 01
[   37.049166] RSP: 0018:ffffc900018e7c18 EFLAGS: 00010002
[   37.049714] RAX: 0000000000000001 RBX: ffff888105780040 RCX: 0000000000000000
[   37.050451] RDX: 0000000000000001 RSI: ffffffff8304f78e RDI: ffffffff83c34c20
[   37.051193] RBP: ffff888237c2a300 R08: ffff88810c4208f7 R09: 0000000000000002
[   37.051957] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
[   37.052702] R13: ffffffff846e55c0 R14: ffff888105780040 R15: ffffffff82608cb0
[   37.053437] FS:  0000000000000000(0000) GS:ffff8882b3544000(0000) knlGS:0000000000000000
[   37.054272] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.054876] CR2: 00007f0df5e26450 CR3: 000000000325a003 CR4: 0000000000772ef0
[   37.055627] PKRU: 55555554
[   37.055892] Call Trace:
[   37.056138]  <TASK>
[   37.056349]  ? _raw_spin_unlock_irqrestore+0x1d/0x40
[   37.056819]  ? __pfx_rpc_wait_bit_killable+0x10/0x10
[   37.057291]  __schedule+0xa1/0xe30
[   37.057622]  ? preempt_count_add+0x73/0xb0
[   37.058013]  ? __pfx_rpc_wait_bit_killable+0x10/0x10
[   37.058494]  schedule+0x29/0xe0
[   37.058839]  rpc_wait_bit_killable+0xc/0x60
[   37.059285]  __wait_on_bit+0x2c/0x90
[   37.059740]  out_of_line_wait_on_bit+0x8e/0xb0
[   37.060210]  ? __pfx_wake_bit_function+0x10/0x10
[   37.060700]  nfs4_do_close+0x289/0x310
[   37.061101]  __put_nfs_open_context+0xc9/0x140
[   37.061572]  nfs_file_release+0x38/0x50
[   37.061980]  ? security_file_release+0x17/0x30
[   37.062442]  __fput+0xf2/0x2b0
[   37.062773]  task_work_run+0x57/0xa0
[   37.063153]  do_exit+0x273/0xa40
[   37.063524]  ? __x64_sys_chmod+0x56/0xb0
[   37.063937]  make_task_dead+0x87/0x90
[   37.064331]  rewind_stack_and_make_dead+0x16/0x20
[   37.064819] RIP: 0033:0x7f0df5ec6707
[   37.065200] Code: Unable to access opcode bytes at 0x7f0df5ec66dd.
[   37.065828] RSP: 002b:00007fff3cd5bad8 EFLAGS: 00000206 ORIG_RAX: 000000000000005a
[   37.066601] RAX: ffffffffffffffda RBX: 0000558071f19b90 RCX: 00007f0df5ec6707
[   37.067328] RDX: 0000000000000008 RSI: 00000000000001fd RDI: 00007fff3cd5cbc0
[   37.068095] RBP: 0000000000000000 R08: 00000000000001fd R09: 0000000000000000
[   37.068848] R10: 0000000000000003 R11: 0000000000000206 R12: 0000000000000035
[   37.069585] R13: 0000000000000007 R14: 0000000000000000 R15: 0000558071f1ebc0
[   37.070319]  </TASK>
[   37.070560] ---[ end trace 0000000000000000 ]---


