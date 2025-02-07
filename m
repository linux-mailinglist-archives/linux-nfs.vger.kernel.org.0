Return-Path: <linux-nfs+bounces-9916-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB39CA2B9EA
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 04:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26C2D3A6C7E
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 03:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA37B1624D0;
	Fri,  7 Feb 2025 03:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bjtfMO8i"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C77E14B959;
	Fri,  7 Feb 2025 03:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738900048; cv=none; b=QCHNn8ZGZ4zVjGu3uxe2lLINwY0bnF1gHwCRVMszUI0qfjpXr8eb4157E22PSHJfm2XQ/MJ4OoVVIc3QQ03AnGlNd7cpY0T13TY6+D66nv4/F7QW/5wyN+HEGEiwdeGIci7NuhaOpaOobbE+hIxFvkJiE5TSX0DedjOBXZ3lYfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738900048; c=relaxed/simple;
	bh=mfAvD1KLK2zNBZevJCDlNQqDl0LzbkG/TricDd5hEFk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WH006k1NoHBOet5KXYTOljRxI97TVLV1DDp5TsPDoEalK3mDJWkj7SHCfhvDSkLOI3veWSM0MacBzVYRDWvpftSRM5WIvx0Srh+KZ+9dhYKDFvMzv/6IiQcP/wJKnG7ovER2e2rsqVmoDrpdoOFpf9goTVzoFh2rjyoGxf5okmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=bjtfMO8i; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738900047; x=1770436047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HA7fnd1LXmW0EobcGsbWtD8e5dI01IS7YM+4NUPsqic=;
  b=bjtfMO8i/FQ9zkXe8Kj3kj/jc79k5MUJLztqYpTHAAAh0B5uohabtjfX
   cCCkA1KNjbBUIEiIm/X6cOydn6mjpyq1I7P8YX2ws77GDrqNGVkzKbYJp
   aB4l7ii5mhCjIrGzs5QXlYLbMMbKuBLdfwua9T5YIwmG+M1lGMYGZ74Uk
   o=;
X-IronPort-AV: E=Sophos;i="6.13,266,1732579200"; 
   d="scan'208";a="375227648"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 03:47:26 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:21585]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.242:2525] with esmtp (Farcaster)
 id 918cb663-40ed-4d1d-b7f2-27eccac283e5; Fri, 7 Feb 2025 03:47:25 +0000 (UTC)
X-Farcaster-Flow-ID: 918cb663-40ed-4d1d-b7f2-27eccac283e5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 7 Feb 2025 03:47:24 +0000
Received: from 6c7e67bfbae3.amazon.com (10.118.243.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Feb 2025 03:47:20 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jlayton@kernel.org>
CC: <Dai.Ngo@oracle.com>, <chuck.lever@oracle.com>,
	<linux-kernel@vger.kernel.org>, <linux-nfs@vger.kernel.org>, <neilb@suse.de>,
	<netdev@vger.kernel.org>, <okorniev@redhat.com>,
	<syzbot+e34ad04f27991521104c@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>, <tom@talpey.com>, <kuniyu@amazon.com>
Subject: Re: [syzbot] [nfs?] [net?] WARNING in remove_proc_entry (7)
Date: Fri, 7 Feb 2025 12:47:12 +0900
Message-ID: <20250207034712.50026-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <ca9c66778d4d777a3f3028d865b9f340553df72f.camel@kernel.org>
References: <ca9c66778d4d777a3f3028d865b9f340553df72f.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB002.ant.amazon.com (10.13.139.179) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 06 Feb 2025 06:53:08 -0500
> On Thu, 2025-02-06 at 00:38 -0800, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    92514ef226f5 Merge tag 'for-6.14-rc1-tag' of git://git.ker..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=151e9318580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=c48f582603dcb16c
> > dashboard link: https://syzkaller.appspot.com/bug?extid=e34ad04f27991521104c
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=131e9318580000
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/b3df3b128344/disk-92514ef2.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/30f6f3763191/vmlinux-92514ef2.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/caeb03ac3f9c/bzImage-92514ef2.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+e34ad04f27991521104c@syzkaller.appspotmail.com
> > 
> > name 'nfsd'
> > WARNING: CPU: 1 PID: 6518 at fs/proc/generic.c:713 remove_proc_entry+0x268/0x470 fs/proc/generic.c:713
> > Modules linked in:
> > CPU: 1 UID: 0 PID: 6518 Comm: kworker/u8:8 Not tainted 6.14.0-rc1-syzkaller-00034-g92514ef226f5 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
> > Workqueue: netns cleanup_net
> > RIP: 0010:remove_proc_entry+0x268/0x470 fs/proc/generic.c:713
> > Code: 08 eb a2 e8 1a 9c 62 ff 48 c7 c7 20 7e 41 8e e8 4e c4 f2 08 e8 09 9c 62 ff 90 48 c7 c7 c0 db 81 8b 4c 89 e6 e8 29 76 23 ff 90 <0f> 0b 90 90 e9 72 ff ff ff e8 ea 9b 62 ff 49 8d be 98 00 00 00 48
> > RSP: 0018:ffffc9000bec7a80 EFLAGS: 00010286
> > RAX: 0000000000000000 RBX: 1ffff920017d8f52 RCX: ffffffff8179c889
> > RDX: ffff888031a35a00 RSI: ffffffff8179c896 RDI: 0000000000000001
> > RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
> > R10: 0000000000000001 R11: 00000000000ca440 R12: ffffffff8b8f7460
> > R13: dffffc0000000000 R14: ffff88807e22da00 R15: fffffbfff1cb7dc4
> > FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000000000 CR3: 00000000237ba000 CR4: 00000000003526f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  nfsd_net_exit+0x27/0x50 fs/nfsd/nfsctl.c:2259
> >  ops_exit_list+0xb0/0x180 net/core/net_namespace.c:172
> >  cleanup_net+0x5c6/0xbf0 net/core/net_namespace.c:652
> >  process_one_work+0x958/0x1b30 kernel/workqueue.c:3236
> >  process_scheduled_works kernel/workqueue.c:3317 [inline]
> >  worker_thread+0x6c8/0xf00 kernel/workqueue.c:3398
> >  kthread+0x3af/0x750 kernel/kthread.c:464
> >  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> >  </TASK>
> > 
> > 
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > 
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > 
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> > 
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing.
> > 
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> > 
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> > 
> > If you want to undo deduplication, reply with:
> > #syz undup
> 
> Thanks for the bug report. That warning pops if you try to remove a
> /proc entry and it doesn't exist.
> 
> My suspicion here is that the initial creation of that entry failed for
> some reason and the nfsd code just ignored that error.

This failure is common and triggered by fault injection during netns
initialisation.  You can see that in the syzbot's log:

https://syzkaller.appspot.com/x/log.txt?x=151e9318580000

I fixed a similar one in 24457f1be29f ("nfs: Handle error of
rpc_proc_register() in nfs_net_init().").


> In fact,
> nfsd_proc_stat_init() ignores the return code from svc_proc_register().
> If we fix that, then this probably would have failed gracefully at
> net_init time. I'll see about spinning up a patch to fix that.

