Return-Path: <linux-nfs+bounces-2507-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1737388F0E6
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Mar 2024 22:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83BAD1F28263
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Mar 2024 21:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1C91514E3;
	Wed, 27 Mar 2024 21:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="YYLepP/q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5843C15380A
	for <linux-nfs@vger.kernel.org>; Wed, 27 Mar 2024 21:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711574847; cv=none; b=NST2t+q5V14wBqShH81XChfiHSPqvCtYcTORTuwD+S6GC3F/ZfICb2nkUn3O7fvrMNSnJ6hcTrluC4YDOul2KkJiNaZL1dj1VrVv7OdzILh6Obd3az6i187Ivo4HkqJH5JYek7hIVqOkf1+ExNHTADG2VR1p46Ro2WFV7kTm3IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711574847; c=relaxed/simple;
	bh=C/j887tj4udL31AqIBUo1u2n1jRjMfXxwuefa6/BV/Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nnqPghzm5VuFCCqrehkCUPzRnJ0mqaz2bv56rteCa/ydB0UFbuJFhFO0uDs0tzFqYnbrjWOtp4onc8NRaTC+AIR0tSz/Rb6W9iVUD1/qpITxomKvKSnPQ+AflgA1yDTd8nRciU0dHkRkIIuuSThMcQkpVp49C1yW6xM9yhxSFd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=YYLepP/q; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711574845; x=1743110845;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yB5eVj7R3bMwQK8+bTiRV53GmBh4sRlY3VaCYfMCADw=;
  b=YYLepP/qPZfTtWJKlGEQpGkrxjfOFIjWiHQfrLnEsXV9Ds3s8pZ5C7X1
   +SWjM1hWqds5wSno5XAsZ16gk2GB+Vib/MgZkbtPuUeqEQOfZ3bMFG0h2
   hgYiGHRQoppuL3+rtIgA/kEaOZiulJAwejJoiwXK3lSv5Vkmg9oE0yJNa
   Y=;
X-IronPort-AV: E=Sophos;i="6.07,160,1708387200"; 
   d="scan'208";a="714304046"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 21:27:20 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:55894]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.22:2525] with esmtp (Farcaster)
 id 7e1fe94b-f74a-48cc-b546-2d73f361e499; Wed, 27 Mar 2024 21:27:20 +0000 (UTC)
X-Farcaster-Flow-ID: 7e1fe94b-f74a-48cc-b546-2d73f361e499
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 27 Mar 2024 21:27:19 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.29) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Wed, 27 Mar 2024 21:27:17 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker
	<anna@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <linux-nfs@vger.kernel.org>, syzkaller
	<syzkaller@googlegroups.com>
Subject: [PATCH v1] nfs: Handle error of rpc_proc_register() in nfs_net_init().
Date: Wed, 27 Mar 2024 14:27:06 -0700
Message-ID: <20240327212706.27691-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA004.ant.amazon.com (10.13.139.91) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

syzkaller reported a warning [0] triggered while destroying immature
netns.

rpc_proc_register() was called in init_nfs_fs(), but its error
has been ignored since at least the initial commit 1da177e4c3f4
("Linux-2.6.12-rc2").

Recently, commit d47151b79e32 ("nfs: expose /proc/net/sunrpc/nfs
in net namespaces") converted the procfs to per-netns and made
the problem more visible.

Even when rpc_proc_register() fails, nfs_net_init() could succeed,
and thus nfs_net_exit() will be called while destroying the netns.

Then, remove_proc_entry() will be called for non-existing proc
directory and trigger the warning below.

Let's handle the error of rpc_proc_register() properly in nfs_net_init().

[0]:
name 'nfs'
WARNING: CPU: 1 PID: 1710 at fs/proc/generic.c:711 remove_proc_entry+0x1bb/0x2d0 fs/proc/generic.c:711
Modules linked in:
CPU: 1 PID: 1710 Comm: syz-executor.2 Not tainted 6.8.0-12822-gcd51db110a7e #12
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
RIP: 0010:remove_proc_entry+0x1bb/0x2d0 fs/proc/generic.c:711
Code: 41 5d 41 5e c3 e8 85 09 b5 ff 48 c7 c7 88 58 64 86 e8 09 0e 71 02 e8 74 09 b5 ff 4c 89 e6 48 c7 c7 de 1b 80 84 e8 c5 ad 97 ff <0f> 0b eb b1 e8 5c 09 b5 ff 48 c7 c7 88 58 64 86 e8 e0 0d 71 02 eb
RSP: 0018:ffffc9000c6d7ce0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff8880422b8b00 RCX: ffffffff8110503c
RDX: ffff888030652f00 RSI: ffffffff81105045 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: ffffffff81bb62cb R12: ffffffff84807ffc
R13: ffff88804ad6fcc0 R14: ffffffff84807ffc R15: ffffffff85741ff8
FS:  00007f30cfba8640(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff51afe8000 CR3: 000000005a60a005 CR4: 0000000000770ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 rpc_proc_unregister+0x64/0x70 net/sunrpc/stats.c:310
 nfs_net_exit+0x1c/0x30 fs/nfs/inode.c:2438
 ops_exit_list+0x62/0xb0 net/core/net_namespace.c:170
 setup_net+0x46c/0x660 net/core/net_namespace.c:372
 copy_net_ns+0x244/0x590 net/core/net_namespace.c:505
 create_new_namespaces+0x2ed/0x770 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0xae/0x160 kernel/nsproxy.c:228
 ksys_unshare+0x342/0x760 kernel/fork.c:3322
 __do_sys_unshare kernel/fork.c:3393 [inline]
 __se_sys_unshare kernel/fork.c:3391 [inline]
 __x64_sys_unshare+0x1f/0x30 kernel/fork.c:3391
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x4f/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x46/0x4e
RIP: 0033:0x7f30d0febe5d
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 73 9f 1b 00 f7 d8 64 89 01 48
RSP: 002b:00007f30cfba7cc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00000000004bbf80 RCX: 00007f30d0febe5d
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000006c020600
RBP: 00000000004bbf80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 000000000000000b R14: 00007f30d104c530 R15: 0000000000000000
 </TASK>

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 fs/nfs/inode.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index c709c296ea9a..dd224ba196ef 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2427,9 +2427,16 @@ EXPORT_SYMBOL_GPL(nfs_net_id);
 static int nfs_net_init(struct net *net)
 {
 	struct nfs_net *nn = net_generic(net, nfs_net_id);
+	int err;
 
 	nfs_clients_init(net);
-	rpc_proc_register(net, &nn->rpcstats);
+
+	err = rpc_proc_register(net, &nn->rpcstats);
+	if (err) {
+		nfs_clients_exit(net);
+		return err;
+	}
+
 	return nfs_fs_proc_net_init(net);
 }
 
-- 
2.30.2


