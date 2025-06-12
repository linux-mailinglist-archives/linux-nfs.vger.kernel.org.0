Return-Path: <linux-nfs+bounces-12395-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B83AEAD7D41
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jun 2025 23:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9103218925F0
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jun 2025 21:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB70214225;
	Thu, 12 Jun 2025 21:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/feUPbQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14A4189BB0;
	Thu, 12 Jun 2025 21:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749762975; cv=none; b=OeytKvh7qBJjnNzbLj1dukVqPB7v+S+/eI1EydkEf1uTf+afHk+cEbWjlMYgYSMjftlye2eu7BGw19tWYYYD8Q+EtQQ0kV89o3VBB2aVyaLMMPr8TPxm/zLLeUJs6LNK9FtFkS7TPtadd7O7NK/jlaF91Gew2pTycDqG0md3QS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749762975; c=relaxed/simple;
	bh=wwi/478CFjtr+iIOgLvYO1hnkG8AIF7oYR+KlU0yDv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BOTf56v2sP2NI94Z7TrZU28WZUiOb02I4h6eBdG7hPMnfutpLvs0oAuN7Vy4N/wiatWeh6UWlBkbepoyS1A/3TErPJalcOUhm/60K73y8Y/d0Rr94SP8JUCCWMyo9JWcGvCxv55JMKkqyp/0PzQEYeJkoIrJeIZeSNMPL+VZLZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/feUPbQ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-313a001d781so1351684a91.3;
        Thu, 12 Jun 2025 14:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749762973; x=1750367773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yz8jAmvk6HR1S346M8M0MCZ/MwPYa5CohBqE1ndryfw=;
        b=K/feUPbQdviTPjCkFWvnLz3jDr+xeZyxczJKPTK4/bMCbshkSXZIcT1y/C4VdLqWjJ
         RxBgEMtdw4TOJLEFDik8iBplCEIVCkqV4L+HJKFePjTuJVwrt+zk0VUq1wwPySH2keQc
         JKQVdnTfxEEh/Vn+1fHsMkO1Kqp9M2f3z+Ek3LGigJTQXGKt8JyCII7hyIqU1cllrcO1
         ouQKHGLRIKW441Qdxo8042mkrz4v9Y7+quLoku+LjoD6mS5/5Aej4nNLXctmIZivA+us
         gqkyL17QS5SJfNHGbagAD25KFzNINdOEyUuGJdJr6OIJZqCrt66YhLQXk2oGKoe7m2fD
         yM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749762973; x=1750367773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yz8jAmvk6HR1S346M8M0MCZ/MwPYa5CohBqE1ndryfw=;
        b=s8UEA1UlHKHUZqR6Xdzz1h9eRfR4Aenk3Sjx6s8OqZxB3JJhr4ODkWAK2Qk7Lq0/is
         2NgH+WB9i3sFnuYHzha9Izksl05moPYnyfiWQNBwZAwztzn1X7PzUk9BoKmA5z5YCjKV
         SkdZLwuYHC1raXnbBTym37yGY8FmORgBF7vvvlpHepumn3/E/2HnnDqxQB6r9PoHQlfb
         t4XxuMphw3NeEPS/CaS7AEUuB5aFlx0alkX+juECQiOWqKU0iDW9Te9Q05UNrl7tYS2C
         m02iSVs87Oc3RVZ9FhPF09JJNQQj/jZV2cuj612lPy5qJ4yWWEO+iZdMi48IlCDT3xEl
         K5tw==
X-Forwarded-Encrypted: i=1; AJvYcCV4zeAiLT9KQXi3xIlZmjKe1Xsaw5X85ZQdRo3XStPgq7HKResMVdYGWi300ez+hw8waOVQd7ItvZDh@vger.kernel.org, AJvYcCWN/JV0UZLrDLoMJWNxSGcEa+v+eeAqlc/81kseUSwmTQ07w+lVDBdXRrisoT8O1c6Nq4FHmT65@vger.kernel.org, AJvYcCXf6KWnpXygJPEOwm3htleH9iZuA8waYZEGZFhatGOK/1DdxO5x5sB0y5X5EFWKRnzt1sKQPY5o0azYPHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW18jEQLKwx86ic4Cxv262Ggg8lrWln4D+FrZbR7pvYuRthKfs
	QvP9k06Leu4j9N0ATJvCSZKAbw4iSyYwhgyVeSVeCqXtFixL5E6sRs4=
X-Gm-Gg: ASbGncvMoxcAJDZoXh0TKxOi0Lg9dWX/XgIaaKvI/i2o8/G/QNAeP4vxBwJBaKm6YjE
	XJtyEzbAyevphLJTk83b4LIseZgm4sZCsr34BbWYsYOcsD8h+hRR3Klm/lU+GoWG0CPePusvrZL
	A3zWMhY2hCgTLN4FQ8u9LlSdvG4+PmnWMfX+mzJ9FspWUeTAim3qiqyt5Vm48TZ1PNLIyG0b7Mn
	MdJaQhFXTpHH9QY2lfJmIELf1IANOx1FUM6J5dqrMCCDlyodZnFovhnR9adxLvKIPGWCiLN6PqR
	JSq4GZHX7mjO6HzpLjUdyeORfVbIHaLaNpAWLtg=
X-Google-Smtp-Source: AGHT+IEdd9VIoEdJjhncVucyV8vZEYfWcdRmdn0rJv62MJ1or0RV9uQZBDuxBlKoadzf7A7Udvpnyw==
X-Received: by 2002:a17:90b:28ce:b0:312:26d9:d5b2 with SMTP id 98e67ed59e1d1-313d9943c0fmr1224262a91.0.1749762972946;
        Thu, 12 Jun 2025 14:16:12 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d8a1810sm1868955ad.58.2025.06.12.14.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 14:16:12 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: syzbot+a4cc4ac22daa4a71b87c@syzkaller.appspotmail.com
Cc: Dai.Ngo@oracle.com,
	anna@kernel.org,
	chuck.lever@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jlayton@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	neil@brown.name,
	netdev@vger.kernel.org,
	okorniev@redhat.com,
	pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com,
	tom@talpey.com,
	trondmy@kernel.org
Subject: Re: [syzbot] [net?] [nfs?] WARNING in remove_proc_entry (8)
Date: Thu, 12 Jun 2025 14:16:04 -0700
Message-ID: <20250612211610.4129612-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <684b41cf.a00a0220.1eb5f5.0109.GAE@google.com>
References: <684b41cf.a00a0220.1eb5f5.0109.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: syzbot <syzbot+a4cc4ac22daa4a71b87c@syzkaller.appspotmail.com>
Date: Thu, 12 Jun 2025 14:08:31 -0700
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    2c4a1f3fe03e Merge tag 'bpf-fixes' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1432610c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c4c8362784bb7796
> dashboard link: https://syzkaller.appspot.com/bug?extid=a4cc4ac22daa4a71b87c
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1126ed70580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/cd1ec81a3ab8/disk-2c4a1f3f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/992d9b6a25bf/vmlinux-2c4a1f3f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/85a9bf583faa/bzImage-2c4a1f3f.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+a4cc4ac22daa4a71b87c@syzkaller.appspotmail.com
> 
> WARNING: CPU: 0 PID: 6182 at fs/proc/generic.c:727 remove_proc_entry+0x45e/0x530 fs/proc/generic.c:727
> Modules linked in:
> CPU: 0 UID: 0 PID: 6182 Comm: syz.1.75 Not tainted 6.16.0-rc1-syzkaller-00010-g2c4a1f3fe03e #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> RIP: 0010:remove_proc_entry+0x45e/0x530 fs/proc/generic.c:727
> Code: 3c 02 00 0f 85 85 00 00 00 48 8b 93 d8 00 00 00 4d 89 f0 4c 89 e9 48 c7 c6 40 ba a2 8b 48 c7 c7 60 b9 a2 8b e8 33 81 1d ff 90 <0f> 0b 90 90 e9 5f fe ff ff e8 04 69 5e ff 90 48 b8 00 00 00 00 00
> RSP: 0018:ffffc90003e5fb08 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: ffff88804e6568c0 RCX: ffffffff817a92c8
> RDX: ffff88803046da00 RSI: ffffffff817a92d5 RDI: 0000000000000001
> RBP: ffff8880353bde80 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000001 R12: ffff8880353bddc0
> R13: ffff8880353bdea4 R14: ffff88802556cae4 R15: dffffc0000000000
> FS:  0000555562486500(0000) GS:ffff888124962000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000c0024fb070 CR3: 000000006b39a000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  sunrpc_exit_net+0x46/0x90 net/sunrpc/sunrpc_syms.c:76
>  ops_exit_list net/core/net_namespace.c:200 [inline]
>  ops_undo_list+0x2eb/0xab0 net/core/net_namespace.c:253
>  setup_net+0x2e1/0x510 net/core/net_namespace.c:457
>  copy_net_ns+0x2a6/0x5f0 net/core/net_namespace.c:574
>  create_new_namespaces+0x3ea/0xa90 kernel/nsproxy.c:110
>  unshare_nsproxy_namespaces+0xc0/0x1f0 kernel/nsproxy.c:218
>  ksys_unshare+0x45b/0xa40 kernel/fork.c:3121
>  __do_sys_unshare kernel/fork.c:3192 [inline]
>  __se_sys_unshare kernel/fork.c:3190 [inline]
>  __x64_sys_unshare+0x31/0x40 kernel/fork.c:3190
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f239858e929
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffd08ac9b18 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
> RAX: ffffffffffffffda RBX: 00007f23987b5fa0 RCX: 00007f239858e929
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000040000080
> RBP: 00007f2398610b39 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f23987b5fa0 R14: 00007f23987b5fa0 R15: 0000000000000001
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

#syz test

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 8ab7868807a7..19277e050c09 100644
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
+		goto err_proc_rpc;
+		err = -ENOMEM;
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

