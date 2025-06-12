Return-Path: <linux-nfs+bounces-12398-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4724DAD7DEE
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jun 2025 23:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21453165424
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jun 2025 21:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A147D22F384;
	Thu, 12 Jun 2025 21:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzrTy/zf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B53C2D5419
	for <linux-nfs@vger.kernel.org>; Thu, 12 Jun 2025 21:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749765180; cv=none; b=LhXsESjMjKOSJ0RQgCrHdwr/TUy3EXvWIRcmClpwUv2I5oW7RtZwk0OLnobtxMWhRwOV4c0C7fGaU42/7nqmtACuAH3X9jXHCi/AuIIasCxh0Lg9reMQOSYH7ckc0aiQOeoSshaVJXzrs5tjDP5bX6qGHWyX3jVJO/kanuD+s6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749765180; c=relaxed/simple;
	bh=KFu32siuH59QVA5tsMUTr3S4GaqJdkLfDxtLWXijCa0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qqzf3CB8DvJAU0ly/+k7uL+VZiqrHUPxstePyIbpQxUci+q/bFRA0vt4CF49pYzhWElpV79nkfi4FxHHbwc4gZ37FDGIG0f0whmdxut9IX7i9NLtZupUefAP0xjZKtv56BepfxlRXxhAqQY+SHwr14653l9A6D40UonRRp3hA+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzrTy/zf; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b2fd091f826so1142020a12.1
        for <linux-nfs@vger.kernel.org>; Thu, 12 Jun 2025 14:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749765178; x=1750369978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NyaZvcbP+bGXrzNs+AHHidDaTb+FE0tR/1OQOLic31g=;
        b=ZzrTy/zfbewdOnB0QDL/QbLCwOXYdsyeQPvETT/1hau5JBY3XEY5dEA4vRcfSRufoA
         3npQawGadujXks1xFt+WQzTMpKJxBhjEpCwg9tBW89hxRdOSPz9C09yd9hLja3uYyq47
         xlBab7AbbRmDKDzcxCIefmPIIouYsUnPusjbAe3nRsaFcnoV1yMedo9BSyEILwDdcViR
         9H/d07oBg1rgBY61p9f0CkEY/ZXdIlmZd0w82kuGVbylvH8qoCBdHm2tBUNjuRdTfrC/
         xVxMM7QE4gLFApRQsY9eTuuKXh4z0JBOXezgFsuRdl+KyEGECH9+EDZzb7Plr6OEivRh
         Pu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749765178; x=1750369978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NyaZvcbP+bGXrzNs+AHHidDaTb+FE0tR/1OQOLic31g=;
        b=YjESetVGO/Cq3E/Dvg1N7HHypAFz2KunrrdbCVhw+aZowoEuFnLFNUcgQpZekWy7C+
         tObsau+eOliVshiBaY1DeKiTa9HHM7Sp6311mFZlJi1+x2gBQn9dwSkmgQRQix5/q+ES
         9nWlQGgKZNwowYL8LEgxU3VhXdUPg7vMvETn0YAbyT8fTzOHJHGLVyW/1Tj0GWZfPVoD
         RztK8LAApOgPldiWfRGm8SVrdVU4920i+39suT1Lur7LoXz7RG0udK24SKD9pkOkIg8F
         /1bXu4uJOuCr5z+lkhYEb32qPdF2Av4P9LYUyGihSQr1umQqp9XMgf5IVlGSjWQdI9BI
         EtXg==
X-Forwarded-Encrypted: i=1; AJvYcCUKmTEETtffiu1AXhhkJg3Nhm5sQbthIC59hPSY7IpE/mbThz2aRbMCJJPt+jLC07SeYY/8pQ1+aE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuWk7GB4daeRXL98EwjLcw1KOnHXar6jhczxDWk0b85f/TEaD5
	HeQDGaWUVtWZFazNK4EQeRHTzbNBwUv321KXuq0X25lDxte3rbYhKP4=
X-Gm-Gg: ASbGncsms9bkBwp+zvED7tLpU153oSqZYxzXKFAhGkUqMnVp3WAW4IOkDr1Kks+u9Rp
	zdt7vKpP4xnEEzDupt6SZkgCiIw0SBZ1bpgUTyn2fUU84Dkmr46kGbQLSK6/U/ZfGLvZ6hUTqND
	TcUThkGVI8/X+sB1M2ZQFsifVyg8oOakyBXmlW4GCi6wCnjOMpa2l2Z2x0xo1392AyyoOhom/Rr
	pSeH7QusPYRkLJ3lnCpEEqSeCX1rgxqI+XWenuHgtz4OPVAuZZUDLf29vk12vs850ztsZl1jeR0
	cP9EoIrM0cQb2L9PVmGMeASGKEDjG104zlcEigTf7gCMnNzkrg==
X-Google-Smtp-Source: AGHT+IGpzZMZh88H18MYPUEGd0JP+8gTdSAk+rCZCMRSnAtmL3qMGvbCwWbowaahhhLunC6Ts7Y5Bg==
X-Received: by 2002:a05:6a21:9987:b0:1ee:ab52:b8cc with SMTP id adf61e73a8af0-21faefd2666mr151498637.21.1749765177709;
        Thu, 12 Jun 2025 14:52:57 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe163a498sm204348a12.15.2025.06.12.14.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 14:52:57 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	linux-nfs@vger.kernel.org,
	syzbot+a4cc4ac22daa4a71b87c@syzkaller.appspotmail.com
Subject: [PATCH v1] nfs: Clean up /proc/net/rpc/nfs when nfs_fs_proc_net_init() fails.
Date: Thu, 12 Jun 2025 14:52:50 -0700
Message-ID: <20250612215254.4155863-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

syzbot reported a warning below [1] following a fault injection in
nfs_fs_proc_net_init(). [0]

When nfs_fs_proc_net_init() fails, /proc/net/rpc/nfs is not removed.

Later, rpc_proc_exit() tries to remove /proc/net/rpc, and the warning
is logged as the directory is not empty.

Let's handle the error of nfs_fs_proc_net_init() properly.

[0]:
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
CPU: 1 UID: 0 PID: 6120 Comm: syz.2.27 Not tainted 6.16.0-rc1-syzkaller-00010-g2c4a1f3fe03e #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
  dump_stack_lvl (lib/dump_stack.c:123)
 should_fail_ex (lib/fault-inject.c:73 lib/fault-inject.c:174)
 should_failslab (mm/failslab.c:46)
 kmem_cache_alloc_noprof (mm/slub.c:4178 mm/slub.c:4204)
 __proc_create (fs/proc/generic.c:427)
 proc_create_reg (fs/proc/generic.c:554)
 proc_create_net_data (fs/proc/proc_net.c:120)
 nfs_fs_proc_net_init (fs/nfs/client.c:1409)
 nfs_net_init (fs/nfs/inode.c:2600)
 ops_init (net/core/net_namespace.c:138)
 setup_net (net/core/net_namespace.c:443)
 copy_net_ns (net/core/net_namespace.c:576)
 create_new_namespaces (kernel/nsproxy.c:110)
 unshare_nsproxy_namespaces (kernel/nsproxy.c:218 (discriminator 4))
 ksys_unshare (kernel/fork.c:3123)
 __x64_sys_unshare (kernel/fork.c:3190)
 do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
 </TASK>

[1]:
remove_proc_entry: removing non-empty directory 'net/rpc', leaking at least 'nfs'
 WARNING: CPU: 1 PID: 6120 at fs/proc/generic.c:727 remove_proc_entry+0x45e/0x530 fs/proc/generic.c:727
Modules linked in:
CPU: 1 UID: 0 PID: 6120 Comm: syz.2.27 Not tainted 6.16.0-rc1-syzkaller-00010-g2c4a1f3fe03e #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
 RIP: 0010:remove_proc_entry+0x45e/0x530 fs/proc/generic.c:727
Code: 3c 02 00 0f 85 85 00 00 00 48 8b 93 d8 00 00 00 4d 89 f0 4c 89 e9 48 c7 c6 40 ba a2 8b 48 c7 c7 60 b9 a2 8b e8 33 81 1d ff 90 <0f> 0b 90 90 e9 5f fe ff ff e8 04 69 5e ff 90 48 b8 00 00 00 00 00
RSP: 0018:ffffc90003637b08 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88805f534140 RCX: ffffffff817a92c8
RDX: ffff88807da99e00 RSI: ffffffff817a92d5 RDI: 0000000000000001
RBP: ffff888033431ac0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff888033431a00
R13: ffff888033431ae4 R14: ffff888033184724 R15: dffffc0000000000
FS:  0000555580328500(0000) GS:ffff888124a62000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f71733743e0 CR3: 000000007f618000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
  sunrpc_exit_net+0x46/0x90 net/sunrpc/sunrpc_syms.c:76
  ops_exit_list net/core/net_namespace.c:200 [inline]
  ops_undo_list+0x2eb/0xab0 net/core/net_namespace.c:253
  setup_net+0x2e1/0x510 net/core/net_namespace.c:457
  copy_net_ns+0x2a6/0x5f0 net/core/net_namespace.c:574
  create_new_namespaces+0x3ea/0xa90 kernel/nsproxy.c:110
  unshare_nsproxy_namespaces+0xc0/0x1f0 kernel/nsproxy.c:218
  ksys_unshare+0x45b/0xa40 kernel/fork.c:3121
  __do_sys_unshare kernel/fork.c:3192 [inline]
  __se_sys_unshare kernel/fork.c:3190 [inline]
  __x64_sys_unshare+0x31/0x40 kernel/fork.c:3190
  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
  do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa1a6b8e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff3a090368 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007fa1a6db5fa0 RCX: 00007fa1a6b8e929
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000040000080
RBP: 00007fa1a6c10b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa1a6db5fa0 R14: 00007fa1a6db5fa0 R15: 0000000000000001
 </TASK>

Fixes: d47151b79e32 ("nfs: expose /proc/net/sunrpc/nfs in net namespaces")
Reported-by: syzbot+a4cc4ac22daa4a71b87c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a4cc4ac22daa4a71b87c
Tested-by: syzbot+a4cc4ac22daa4a71b87c@syzkaller.appspotmail.com
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 fs/nfs/inode.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 8ab7868807a7..a2fa6bc4d74e 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2589,15 +2589,26 @@ EXPORT_SYMBOL_GPL(nfs_net_id);
 static int nfs_net_init(struct net *net)
 {
 	struct nfs_net *nn = net_generic(net, nfs_net_id);
+	int err;
 
 	nfs_clients_init(net);
 
 	if (!rpc_proc_register(net, &nn->rpcstats)) {
-		nfs_clients_exit(net);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto err_proc_rpc;
 	}
 
-	return nfs_fs_proc_net_init(net);
+	err = nfs_fs_proc_net_init(net);
+	if (err)
+		goto err_proc_nfs;
+
+	return 0;
+
+err_proc_nfs:
+	rpc_proc_unregister(net, "nfs");
+err_proc_rpc:
+	nfs_clients_exit(net);
+	return err;
 }
 
 static void nfs_net_exit(struct net *net)
-- 
2.49.0


