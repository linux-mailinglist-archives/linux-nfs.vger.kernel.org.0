Return-Path: <linux-nfs+bounces-7219-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5113B9A1D47
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 10:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C0B01C260C9
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 08:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAB81D517A;
	Thu, 17 Oct 2024 08:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zX9CnBmu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1A71D3634
	for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2024 08:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729154081; cv=none; b=of0mXw4OsAcs2W1rU4/vX6UiK2oXZBJceyH4brJvYV8ERtacmW6IiM32QfdQ2qEj7UjB3IuJtKeSJXTxVRfQnuuT/J/7PFfl6YPKrsiqWJGzgYjK2vYl4+ZBF7jng+fzIowGyN6Q3R5+622YEyF4YFpDTJkwwbOKk8wN73ZoBOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729154081; c=relaxed/simple;
	bh=JFw1tNMI2PF3EtH06MZbSqXJomeAqR7Qc+lcgVHrMKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PvL0w+kQR9StCw/Pc1dUGpLc/8LOLjryyxQLXp1hrTuZturCDXRyENrkLlMumXyOf9mJrkW9XUH2RyOXPtEOt4ptvNfp2xaHpOtsY5Ti7r5KYEswlXAdrbovA0lscAbjHL3kgD4rl13X2AxeOlT/ev/bdempns1tIv59sAZ0dGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zX9CnBmu; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539fe02c386so1820729e87.0
        for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2024 01:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729154075; x=1729758875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4rzI4EBqQr0g2VscDmIT5VBJo5hzfGIB6Cx2jf+N5jQ=;
        b=zX9CnBmuRjG4ssVoMbwoNRCkq9AbWGYAKaSJ82ZNqDPCYZdrBTmmAp3WLHil0Hf/tI
         wSYQ+WK/3ZcXmr9fAkvqHsAzXrKEQcSZkZ/wxzYtJ46WlH4oVOPFrwFFJADk+pq+eChU
         OXAydfaEvcZw1Jtv/CwFrurZ6t2nvM+411KqJzBOPFxaIFPi1c0A+JE9J1zKxWTuZ+dz
         0tA1P1vdC6cdghwo0jwwUU0SHRoUnbvLASLquun7Z8Lg9mpCI14j5ouy0FefmNWq92EQ
         +eJ8b8Z71qwSGUze6cOxBgiQYxv/RXW7/rYBmj/Sae8cckBoKnJEOm3P/+ztn5VjvfrM
         yA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729154075; x=1729758875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4rzI4EBqQr0g2VscDmIT5VBJo5hzfGIB6Cx2jf+N5jQ=;
        b=kOWn5Yv3dfKswRq7OCk5/0w071Mzxl0mqfAeS7SJJeVDZP+4iXd5c0cg9i6amibTwR
         jeS/R793tpPY/Xi0HzDbCcF0Y8FpDQ5V7pjsxv9HcGvyWQPVUqApvk/p/u43/JHV55+H
         5dZRKyWB3MDoY9GyGzGCxHCeqiZK8CyDInsgfMHI6VF4ggn8p9FQGh+S3c+ZCsBtThTZ
         0aM5O5ATkkYie6aZIVtGa9dkrScvgNXFPOUj01fvPkuxc57DjqBCqfUVCNzzi9QP8tAY
         SarcX6+KjZUouneZkRR4Cma/ilScXxzICdmiA9BYY0j3uJpfAfWw08+1vX/yXajUPtS6
         5yKw==
X-Forwarded-Encrypted: i=1; AJvYcCVIsxc3q3Q78bdwQt2pJ9iWxuhPcJurqH83kG96aA85WiKE1DxrB8GQWg33nB9tfDN3WisCHlr7ZwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRyqNk/davfS9etc9m4ebgjFxMwp2E/asbOWIhCFAFV5ubzeHb
	MhqQKiJkqgwKP59Ocfq5uxKAJOlpb1euqGmar0nmbpPT7O5/TAGq0zFRvX6VPFe5RpQrQdTwAvS
	NBm8TVlzFfxlSOGZD6iU1LBwJEWwUwnYotbxA
X-Google-Smtp-Source: AGHT+IFHRSwfOjXhPmsp2w6mf2WIdtfJ4h+URmXwZlVdBCjC61f/MTIV9CQTIEynwR9T7gzl0tPCl8ifkO8YgjBI1ds=
X-Received: by 2002:a05:651c:220d:b0:2fb:6110:c5a6 with SMTP id
 38308e7fff4ca-2fb6d9eaaddmr7696851fa.8.1729154074311; Thu, 17 Oct 2024
 01:34:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66eaf3f1.050a0220.252d9a.0019.GAE@google.com> <18e1d9caf56a56fadabd6abb82c63e0ba0c3dc34.camel@kernel.org>
 <172680104122.17050.16032356795670302194@noble.neil.brown.name>
 <96DE704B-2EB0-43D5-B34C-3323840F1BB2@oracle.com> <e5d19ed12bffaac5d6ac41d54836451b87b8fc2a.camel@kernel.org>
 <A94A566D-8A64-45EA-9B0C-4C5BD7064A56@oracle.com>
In-Reply-To: <A94A566D-8A64-45EA-9B0C-4C5BD7064A56@oracle.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 17 Oct 2024 10:34:22 +0200
Message-ID: <CACT4Y+bBJvjTNNGBGrArzPvk1UeXtET0MgH82XOx=2v4YfkO5A@mail.gmail.com>
Subject: Re: [syzbot] [nfs?] KASAN: slab-use-after-free Read in rhashtable_walk_enter
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, 
	syzbot <syzbot+24cd636199753ac5e0ca@syzkaller.appspotmail.com>, 
	Dai Ngo <dai.ngo@oracle.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>, Olga Kornievskaia <okorniev@redhat.com>, 
	"syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>, Tom Talpey <tom@talpey.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 22 Sept 2024 at 21:30, 'Chuck Lever III' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
>
>
> > On Sep 20, 2024, at 3:13=E2=80=AFPM, Jeff Layton <jlayton@kernel.org> w=
rote:
> >
> > On Fri, 2024-09-20 at 18:51 +0000, Chuck Lever III wrote:
> >>
> >>> On Sep 19, 2024, at 10:57=E2=80=AFPM, NeilBrown <neilb@suse.de> wrote=
:
> >>>
> >>> On Thu, 19 Sep 2024, Jeff Layton wrote:
> >>>> On Wed, 2024-09-18 at 08:38 -0700, syzbot wrote:
> >>>>> Hello,
> >>>>>
> >>>>> syzbot found the following issue on:
> >>>>>
> >>>>> HEAD commit:    a430d95c5efa Merge tag 'lsm-pr-20240911' of git://g=
it.kern..
> >>>>> git tree:       upstream
> >>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D17c7469=
f980000
> >>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Da69c66e=
868285a9d
> >>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=3D24cd63619=
9753ac5e0ca
> >>>>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils=
 for Debian) 2.40
> >>>>>
> >>>>> Unfortunately, I don't have any reproducer for this issue yet.
> >>>>>
> >>>>> Downloadable assets:
> >>>>> disk image: https://storage.googleapis.com/syzbot-assets/7f3aff905e=
91/disk-a430d95c.raw.xz
> >>>>> vmlinux: https://storage.googleapis.com/syzbot-assets/a468ce8431f0/=
vmlinux-a430d95c.xz
> >>>>> kernel image: https://storage.googleapis.com/syzbot-assets/80d4f115=
0155/bzImage-a430d95c.xz
> >>>>>
> >>>>> IMPORTANT: if you fix the issue, please add the following tag to th=
e commit:
> >>>>> Reported-by: syzbot+24cd636199753ac5e0ca@syzkaller.appspotmail.com
> >>>>>
> >>>>> svc: failed to register nfsdv3 RPC service (errno 111).
> >>>>> svc: failed to register nfsaclv3 RPC service (errno 111).
> >>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>> BUG: KASAN: slab-use-after-free in list_add include/linux/list.h:16=
9 [inline]
> >>>>> BUG: KASAN: slab-use-after-free in rhashtable_walk_enter+0x333/0x37=
0 lib/rhashtable.c:684
> >>>>> Read of size 8 at addr ffff8880773fa010 by task syz.2.11924/9970
> >>>>>
> >>>>> CPU: 0 UID: 0 PID: 9970 Comm: syz.2.11924 Not tainted 6.11.0-syzkal=
ler-02574-ga430d95c5efa #0
> >>>>> Hardware name: Google Google Compute Engine/Google Compute Engine, =
BIOS Google 08/06/2024
> >>>>> Call Trace:
> >>>>> <TASK>
> >>>>> __dump_stack lib/dump_stack.c:93 [inline]
> >>>>> dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
> >>>>> print_address_description mm/kasan/report.c:377 [inline]
> >>>>> print_report+0xc3/0x620 mm/kasan/report.c:488
> >>>>> kasan_report+0xd9/0x110 mm/kasan/report.c:601
> >>>>> list_add include/linux/list.h:169 [inline]
> >>>>> rhashtable_walk_enter+0x333/0x370 lib/rhashtable.c:684
> >>>>> rhltable_walk_enter include/linux/rhashtable.h:1262 [inline]
> >>>>> __nfsd_file_cache_purge+0xad/0x490 fs/nfsd/filecache.c:805
> >>>>> nfsd_file_cache_shutdown+0xcf/0x480 fs/nfsd/filecache.c:897
> >>>>> nfsd_shutdown_generic fs/nfsd/nfssvc.c:329 [inline]
> >>>>> nfsd_shutdown_generic fs/nfsd/nfssvc.c:323 [inline]
> >>>>> nfsd_startup_net fs/nfsd/nfssvc.c:444 [inline]
> >>>>> nfsd_svc+0x6d4/0x970 fs/nfsd/nfssvc.c:817
> >>>>> nfsd_nl_threads_set_doit+0x52c/0xbc0 fs/nfsd/nfsctl.c:1714
> >>>>> genl_family_rcv_msg_doit+0x202/0x2f0 net/netlink/genetlink.c:1115
> >>>>> genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
> >>>>> genl_rcv_msg+0x565/0x800 net/netlink/genetlink.c:1210
> >>>>> netlink_rcv_skb+0x165/0x410 net/netlink/af_netlink.c:2550
> >>>>> genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
> >>>>> netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
> >>>>> netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1357
> >>>>> netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
> >>>>> sock_sendmsg_nosec net/socket.c:730 [inline]
> >>>>> __sock_sendmsg net/socket.c:745 [inline]
> >>>>> ____sys_sendmsg+0x9ae/0xb40 net/socket.c:2603
> >>>>> ___sys_sendmsg+0x135/0x1e0 net/socket.c:2657
> >>>>> __sys_sendmsg+0x117/0x1f0 net/socket.c:2686
> >>>>> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >>>>> do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
> >>>>> entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >>>>> RIP: 0033:0x7fd947f7def9
> >>>>> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 4=
8 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01=
 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> >>>>> RSP: 002b:00007fd948e38038 EFLAGS: 00000246 ORIG_RAX: 0000000000000=
02e
> >>>>> RAX: ffffffffffffffda RBX: 00007fd948135f80 RCX: 00007fd947f7def9
> >>>>> RDX: 0000000000000004 RSI: 0000000020000280 RDI: 0000000000000003
> >>>>> RBP: 00007fd947ff0b76 R08: 0000000000000000 R09: 0000000000000000
> >>>>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> >>>>> R13: 0000000000000000 R14: 00007fd948135f80 R15: 00007ffc6cab9d78
> >>>>> </TASK>
> >>>>>
> >>>>> Allocated by task 8716:
> >>>>> kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
> >>>>> kasan_save_track+0x14/0x30 mm/kasan/common.c:68
> >>>>> poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
> >>>>> __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
> >>>>> kasan_kmalloc include/linux/kasan.h:211 [inline]
> >>>>> __do_kmalloc_node mm/slub.c:4159 [inline]
> >>>>> __kmalloc_node_track_caller_noprof+0x20f/0x440 mm/slub.c:4178
> >>>>> kmalloc_reserve+0xef/0x2c0 net/core/skbuff.c:609
> >>>>> __alloc_skb+0x164/0x380 net/core/skbuff.c:678
> >>>>> alloc_skb include/linux/skbuff.h:1322 [inline]
> >>>>> nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:748 [inline]
> >>>>> nsim_dev_trap_report drivers/net/netdevsim/dev.c:805 [inline]
> >>>>> nsim_dev_trap_report_work+0x2a4/0xc80 drivers/net/netdevsim/dev.c:8=
50
> >>>>> process_one_work+0x958/0x1ad0 kernel/workqueue.c:3231
> >>>>> process_scheduled_works kernel/workqueue.c:3312 [inline]
> >>>>> worker_thread+0x6c8/0xf00 kernel/workqueue.c:3393
> >>>>> kthread+0x2c1/0x3a0 kernel/kthread.c:389
> >>>>> ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
> >>>>> ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> >>>>>
> >>>>> Freed by task 8716:
> >>>>> kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
> >>>>> kasan_save_track+0x14/0x30 mm/kasan/common.c:68
> >>>>> kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
> >>>>> poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
> >>>>> __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
> >>>>> kasan_slab_free include/linux/kasan.h:184 [inline]
> >>>>> slab_free_hook mm/slub.c:2250 [inline]
> >>>>> slab_free mm/slub.c:4474 [inline]
> >>>>> kfree+0x12a/0x3b0 mm/slub.c:4595
> >>>>> skb_kfree_head net/core/skbuff.c:1086 [inline]
> >>>>> skb_free_head+0x108/0x1d0 net/core/skbuff.c:1098
> >>>>> skb_release_data+0x75d/0x990 net/core/skbuff.c:1125
> >>>>> skb_release_all net/core/skbuff.c:1190 [inline]
> >>>>> __kfree_skb net/core/skbuff.c:1204 [inline]
> >>>>> consume_skb net/core/skbuff.c:1436 [inline]
> >>>>> consume_skb+0xbf/0x100 net/core/skbuff.c:1430
> >>>>> nsim_dev_trap_report drivers/net/netdevsim/dev.c:821 [inline]
> >>>>> nsim_dev_trap_report_work+0x878/0xc80 drivers/net/netdevsim/dev.c:8=
50
> >>>>> process_one_work+0x958/0x1ad0 kernel/workqueue.c:3231
> >>>>> process_scheduled_works kernel/workqueue.c:3312 [inline]
> >>>>> worker_thread+0x6c8/0xf00 kernel/workqueue.c:3393
> >>>>> kthread+0x2c1/0x3a0 kernel/kthread.c:389
> >>>>> ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
> >>>>> ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> >>>>>
> >>>>> The buggy address belongs to the object at ffff8880773fa000
> >>>>> which belongs to the cache kmalloc-4k of size 4096
> >>>>> The buggy address is located 16 bytes inside of
> >>>>> freed 4096-byte region [ffff8880773fa000, ffff8880773fb000)
> >>>>>
> >>>>> The buggy address belongs to the physical page:
> >>>>> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:=
0x773f8
> >>>>> head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincou=
nt:0
> >>>>> flags: 0xfff00000000040(head|node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> >>>>> page_type: 0xfdffffff(slab)
> >>>>> raw: 00fff00000000040 ffff88801ac42140 ffffea0001e63600 dead0000000=
00002
> >>>>> raw: 0000000000000000 0000000000040004 00000001fdffffff 00000000000=
00000
> >>>>> head: 00fff00000000040 ffff88801ac42140 ffffea0001e63600 dead000000=
000002
> >>>>> head: 0000000000000000 0000000000040004 00000001fdffffff 0000000000=
000000
> >>>>> head: 00fff00000000003 ffffea0001dcfe01 ffffffffffffffff 0000000000=
000000
> >>>>> head: 0000000700000008 0000000000000000 00000000ffffffff 0000000000=
000000
> >>>>> page dumped because: kasan: bad access detected
> >>>>> page_owner tracks the page as allocated
> >>>>> page last allocated via order 3, migratetype Unmovable, gfp_mask 0x=
d2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid=
 5240, tgid 5240 (syz-executor), ts 74499202771, free_ts 74134964798
> >>>>> set_page_owner include/linux/page_owner.h:32 [inline]
> >>>>> post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1500
> >>>>> prep_new_page mm/page_alloc.c:1508 [inline]
> >>>>> get_page_from_freelist+0x1351/0x2e50 mm/page_alloc.c:3446
> >>>>> __alloc_pages_noprof+0x22b/0x2460 mm/page_alloc.c:4702
> >>>>> __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
> >>>>> alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
> >>>>> alloc_slab_page+0x4e/0xf0 mm/slub.c:2319
> >>>>> allocate_slab mm/slub.c:2482 [inline]
> >>>>> new_slab+0x84/0x260 mm/slub.c:2535
> >>>>> ___slab_alloc+0xdac/0x1870 mm/slub.c:3721
> >>>>> __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3811
> >>>>> __slab_alloc_node mm/slub.c:3864 [inline]
> >>>>> slab_alloc_node mm/slub.c:4026 [inline]
> >>>>> __do_kmalloc_node mm/slub.c:4158 [inline]
> >>>>> __kmalloc_noprof+0x379/0x410 mm/slub.c:4171
> >>>>> kmalloc_noprof include/linux/slab.h:694 [inline]
> >>>>> tomoyo_realpath_from_path+0xbf/0x710 security/tomoyo/realpath.c:251
> >>>>> tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
> >>>>> tomoyo_path_number_perm+0x245/0x5b0 security/tomoyo/file.c:723
> >>>>> security_file_ioctl+0x9b/0x240 security/security.c:2908
> >>>>> __do_sys_ioctl fs/ioctl.c:901 [inline]
> >>>>> __se_sys_ioctl fs/ioctl.c:893 [inline]
> >>>>> __x64_sys_ioctl+0xbb/0x210 fs/ioctl.c:893
> >>>>> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >>>>> do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
> >>>>> entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >>>>> page last free pid 5233 tgid 5233 stack trace:
> >>>>> reset_page_owner include/linux/page_owner.h:25 [inline]
> >>>>> free_pages_prepare mm/page_alloc.c:1101 [inline]
> >>>>> free_unref_folios+0x9e9/0x1390 mm/page_alloc.c:2667
> >>>>> folios_put_refs+0x560/0x760 mm/swap.c:1039
> >>>>> free_pages_and_swap_cache+0x36d/0x510 mm/swap_state.c:332
> >>>>> __tlb_batch_free_encoded_pages+0xf9/0x290 mm/mmu_gather.c:136
> >>>>> tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
> >>>>> tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
> >>>>> tlb_flush_mmu mm/mmu_gather.c:373 [inline]
> >>>>> tlb_finish_mmu+0x168/0x7b0 mm/mmu_gather.c:465
> >>>>> unmap_region+0x342/0x420 mm/mmap.c:2441
> >>>>> do_vmi_align_munmap+0x1107/0x19c0 mm/mmap.c:2754
> >>>>> do_vmi_munmap+0x231/0x410 mm/mmap.c:2830
> >>>>> __vm_munmap+0x142/0x330 mm/mmap.c:3109
> >>>>> __do_sys_munmap mm/mmap.c:3126 [inline]
> >>>>> __se_sys_munmap mm/mmap.c:3123 [inline]
> >>>>> __x64_sys_munmap+0x61/0x90 mm/mmap.c:3123
> >>>>> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >>>>> do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
> >>>>> entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >>>>>
> >>>>> Memory state around the buggy address:
> >>>>> ffff8880773f9f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >>>>> ffff8880773f9f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >>>>>> ffff8880773fa000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >>>>>                        ^
> >>>>> ffff8880773fa080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >>>>> ffff8880773fa100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>
> >>>>>
> >>>>> ---
> >>>>> This report is generated by a bot. It may contain errors.
> >>>>> See https://goo.gl/tpsmEJ for more information about syzbot.
> >>>>> syzbot engineers can be reached at syzkaller@googlegroups.com.
> >>>>>
> >>>>> syzbot will keep track of this issue. See:
> >>>>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >>>>>
> >>>>> If the report is already addressed, let syzbot know by replying wit=
h:
> >>>>> #syz fix: exact-commit-title
> >>>>>
> >>>>> If you want to overwrite report's subsystems, reply with:
> >>>>> #syz set subsystems: new-subsystem
> >>>>> (See the list of subsystem names on the web dashboard)
> >>>>>
> >>>>> If the report is a duplicate of another one, reply with:
> >>>>> #syz dup: exact-subject-of-another-report
> >>>>>
> >>>>> If you want to undo deduplication, reply with:
> >>>>> #syz undup
> >>>>
> >>>> So we're tearing down the server and cleaning out the nfsd_file hash=
,
> >>>> and we hit a UAF. That probably means that we freed a nfsd_file with=
out
> >>>> removing it from the hash? Maybe we should add a WARN_ON() in
> >>>> nfsd_file_slab_free that checks whether the item is still hashed?
> >>>>
> >>>> It is strange though. struct nfsd_file is 112 bytes on my machine, b=
ut
> >>>> the warning is about a 4k allocation. I guess that just means that t=
he
> >>>> page got recycled into a different slabcache.
> >>>
> >>> The code that is crashing hasn't come close to touching anything that=
 is
> >>> thought to be an nfsd_file.
> >>> The error is detected in the list_add() in rhashtable_walk_enter() wh=
en
> >>> the new on-stack iterator is being attached to the bucket_table that =
is being
> >>> iterated.  So that bucket_table must (now) be an invalid address.
> >>>
> >>> The handling of NFSD_FILE_CACHE_UP is strange.  nfsd_file_cache_init(=
)
> >>> sets it, but doesn't clear it on failure.  So if nfsd_file_cache_init=
()
> >>> fails for some reason, nfsd_file_cache_shutdown() would still try to
> >>> clean up if it was called.
> >>>
> >>> So suppose nfsd_startup_generic() is called.  It increments nfsd_user=
s
> >>> from 0 so continues to nfsd_file_cache_init() which fails for some
> >>> reason after initialising nfsd_file_rhltable and then destroying it.
> >>> This will leave nfsd_file_rhltable.tbl as a pointer to a large
> >>> allocation which has been freed.  nfsd_startup_generic() will then
> >>> decrement nfsd_users back to zero, but NFSD_FILE_CACHE_UP will still =
be
> >>> set.
> >>>
> >>> When nfsd_startup_generic() is called again, nfsd_file_cache_init() w=
ill
> >>> skip initialisation because NFSD_FILE_CACHE_UP is set.  When
> >>> nfsd_file_cache_shutdown() is then called it will clean up an rhltabl=
e
> >>> that has already been destroyed.  We get exactly the reported symptom=
.
> >>>
> >>> I *think* nfsd_file_cache_init() can only fail with -ENOMEM and I wou=
ld
> >>> expect to see a warning when that happened.  In any case
> >>> nfsd_file_cache_init() uses pr_err() for any failure except
> >>> rhltable_init(), and that only fails if the params are inconsistent.
> >>>
> >>> So I think there are problems with NFSD_FILE_CACHE_UP settings and I
> >>> think they could trigger this bug if a kmalloc failed, but I don't th=
ink
> >>> that a kmalloc failed and I think there must be some other explanatio=
n
> >>> here.
> >>
> >> Also, the FILE_CACHE_UP logic has been around for several releases.
> >> Why is this UAF showing up only now? The "unable to register"
> >> messages suggest a possible reason.
> >>
> >
> > Good point. I didn't notice those. 111 is ECONNREFUSED, so it sounds
> > like rpcbind isn't up in this situation. Maybe that's a hint toward a
> > reproducer?
>
> I've enabled KASAN, shut down NFSD, and disabled rpcbind.
> Using the /proc/fs/nfsd/threads interface, I can reproduce
> the "unable to register" messages, but not the KASAN splat.
>
> I think Neil's analysis above is correct or very close. I
> don't have nfsdctl set up here, but my guess is that the
> syzbot is abusing the new netlink command API, causing
> nfsd_file_cache_init() to fail somehow and the error
> flow is leaving the kernel vulnerable to a UAF.


Based on the fact that it happened 8 times and no reproducer so far:
1. Likely to be a true bug in nsfd
2. LIkely to be a hard to trigger race condition
3. The fact that alloc/free frequently don't match access tack
suggests that the access happens long after the free (pointer left in
some global structure)

I also found one with matching stacks here:
https://syzkaller.appspot.com/text?tag=3DCrashLog&x=3D128bd39f980000

It looks like the object is freed during creation:

[ 3239.085992][ T8199] __kmem_cache_create_args(nfsd_file) failed with erro=
r -22
[ 3239.117916][ T8199] CPU: 1 UID: 0 PID: 8199 Comm: syz.1.6492 Not
tainted 6.12.0-rc1-syzkaller-00031-ge32cde8d2bd7 #0
[ 3239.129138][ T8199] Hardware name: Google Google Compute
Engine/Google Compute Engine, BIOS Google 09/13/2024
[ 3239.139255][ T8199] Call Trace:
[ 3239.142756][ T8199]  <TASK>
[ 3239.145753][ T8199]  dump_stack_lvl+0x16c/0x1f0
[ 3239.150510][ T8199]  __kmem_cache_create_args+0x130/0x3c0
[ 3239.156126][ T8199]  nfsd_file_cache_init+0x126/0x4d0
[ 3239.161408][ T8199]  ? net_generic+0xf4/0x2a0
[ 3239.165992][ T8199]  nfsd_svc+0x5db/0x940
[ 3239.170309][ T8199]  nfsd_nl_threads_set_doit+0x535/0xbe0
[ 3239.175933][ T8199]  genl_family_rcv_msg_doit+0x202/0x2f0
[ 3239.181560][ T8199]  ? __pfx_genl_family_rcv_msg_doit+0x10/0x10
[ 3239.187720][ T8199]  ? bpf_lsm_capable+0x9/0x10
[ 3239.192470][ T8199]  ? security_capable+0x7e/0x260
[ 3239.197482][ T8199]  genl_rcv_msg+0x565/0x800
[ 3239.202063][ T8199]  ? __pfx_genl_rcv_msg+0x10/0x10
[ 3239.207201][ T8199]  ? __pfx_nfsd_nl_threads_set_doit+0x10/0x10
[ 3239.213336][ T8199]  netlink_rcv_skb+0x165/0x410
[ 3239.218144][ T8199]  ? __pfx_genl_rcv_msg+0x10/0x10
[ 3239.223301][ T8199]  ? __pfx_netlink_rcv_skb+0x10/0x10
[ 3239.228636][ T8199]  ? down_read+0xc9/0x330
[ 3239.233012][ T8199]  ? __pfx_down_read+0x10/0x10
[ 3239.237833][ T8199]  ? netlink_deliver_tap+0x1ae/0xcf0
[ 3239.243429][ T8199]  genl_rcv+0x28/0x40
[ 3239.247447][ T8199]  netlink_unicast+0x53c/0x7f0
[ 3239.252257][ T8199]  ? __pfx_netlink_unicast+0x10/0x10
[ 3239.257579][ T8199]  ? __phys_addr_symbol+0x30/0x80
[ 3239.262641][ T8199]  ? __check_object_size+0x488/0x710
[ 3239.267972][ T8199]  netlink_sendmsg+0x8b8/0xd70
[ 3239.272776][ T8199]  ? __pfx_netlink_sendmsg+0x10/0x10
[ 3239.278115][ T8199]  ____sys_sendmsg+0x9ae/0xb40
[ 3239.282921][ T8199]  ? copy_msghdr_from_user+0x10b/0x160
[ 3239.288434][ T8199]  ? __pfx_____sys_sendmsg+0x10/0x10
[ 3239.293765][ T8199]  ? netlink_recvmsg+0x81c/0xf30
[ 3239.298736][ T8199]  ? __pfx___lock_acquire+0x10/0x10
[ 3239.303989][ T8199]  ___sys_sendmsg+0x135/0x1e0
[ 3239.308715][ T8199]  ? __pfx____sys_sendmsg+0x10/0x10
[ 3239.313976][ T8199]  ? lock_acquire+0x2f/0xb0
[ 3239.318521][ T8199]  ? __fget_files+0x40/0x3f0
[ 3239.323155][ T8199]  ? fdget+0x176/0x210
[ 3239.327348][ T8199]  __sys_sendmsg+0x117/0x1f0
[ 3239.331985][ T8199]  ? __pfx___sys_sendmsg+0x10/0x10
[ 3239.337153][ T8199]  ? __x64_sys_futex+0x1e1/0x4c0
[ 3239.342236][ T8199]  do_syscall_64+0xcd/0x250
[ 3239.346787][ T8199]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[ 3239.352716][ T8199] RIP: 0033:0x7fd3c577dff9
[ 3239.357157][ T8199] Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f
1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b
4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8
64 89 01 48
[ 3239.376798][ T8199] RSP: 002b:00007fd3c65a7038 EFLAGS: 00000246
ORIG_RAX: 000000000000002e
[ 3239.385282][ T8199] RAX: ffffffffffffffda RBX: 00007fd3c5935f80
RCX: 00007fd3c577dff9
[ 3239.393282][ T8199] RDX: 0000000000008004 RSI: 0000000020000140
RDI: 0000000000000006
[ 3239.401287][ T8199] RBP: 00007fd3c57f0296 R08: 0000000000000000
R09: 0000000000000000
[ 3239.409291][ T8199] R10: 0000000000000000 R11: 0000000000000246
R12: 0000000000000000
[ 3239.417296][ T8199] R13: 0000000000000000 R14: 00007fd3c5935f80
R15: 00007ffca7d46f08
[ 3239.425314][ T8199]  </TASK>
[ 3239.605040][ T8199] nfsd: unable to create nfsd_file_slab
[ 3242.331528][ T8252] netlink: zone id is out of range
[ 3242.353608][ T8252] netlink: zone id is out of range
[ 3242.375964][ T8252] netlink: zone id is out of range
[ 3242.381340][ T8252] netlink: zone id is out of range
[ 3242.432868][ T8252] netlink: zone id is out of range
[ 3242.506182][ T8252] netlink: zone id is out of range
[ 3242.529087][ T8252] netlink: zone id is out of range
[ 3242.574253][ T8252] netlink: zone id is out of range
[ 3245.016756][ T8292] sock: sock_set_timeout: `syz.3.6511' (pid 8292)
tries to set negative timeout
[ 3245.419913][ T8295] svc: failed to register nfsdv3 RPC service (errno 11=
1).
[ 3245.467727][ T8295] svc: failed to register nfsaclv3 RPC service (errno =
111).
[ 3245.693668][ T8295]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 3245.701818][ T8295] BUG: KASAN: slab-use-after-free in
rhashtable_walk_enter+0x333/0x370
[ 3245.710150][ T8295] Read of size 8 at addr ffff8880301ac010 by task
syz.1.6512/8295
[ 3245.718011][ T8295]
[ 3245.720376][ T8295] CPU: 1 UID: 0 PID: 8295 Comm: syz.1.6512 Not
tainted 6.12.0-rc1-syzkaller-00031-ge32cde8d2bd7 #0
[ 3245.731118][ T8295] Hardware name: Google Google Compute
Engine/Google Compute Engine, BIOS Google 09/13/2024
[ 3245.741404][ T8295] Call Trace:
[ 3245.744728][ T8295]  <TASK>
[ 3245.747702][ T8295]  dump_stack_lvl+0x116/0x1f0
[ 3245.752629][ T8295]  print_report+0xc3/0x620
[ 3245.757152][ T8295]  ? __virt_addr_valid+0x5e/0x590
[ 3245.762261][ T8295]  ? __phys_addr+0xc6/0x150
[ 3245.766862][ T8295]  kasan_report+0xd9/0x110
[ 3245.771374][ T8295]  ? rhashtable_walk_enter+0x333/0x370
[ 3245.776919][ T8295]  ? rhashtable_walk_enter+0x333/0x370
[ 3245.782467][ T8295]  rhashtable_walk_enter+0x333/0x370
[ 3245.787843][ T8295]  __nfsd_file_cache_purge+0xad/0x470
[ 3245.793299][ T8295]  ? __pfx___nfsd_file_cache_purge+0x10/0x10
[ 3245.799445][ T8295]  ? lockdep_hardirqs_on+0x7c/0x110
[ 3245.804721][ T8295]  ? enable_work+0x246/0x340
[ 3245.809637][ T8295]  ? __pfx_enable_work+0x10/0x10
[ 3245.814651][ T8295]  nfsd_file_cache_shutdown+0xcf/0x4e0
[ 3245.820203][ T8295]  nfsd_svc+0x6a9/0x940
[ 3245.824435][ T8295]  nfsd_nl_threads_set_doit+0x535/0xbe0
[ 3245.830066][ T8295]  genl_family_rcv_msg_doit+0x202/0x2f0
[ 3245.835692][ T8295]  ? __pfx_genl_family_rcv_msg_doit+0x10/0x10
[ 3245.841845][ T8295]  ? bpf_lsm_capable+0x9/0x10
[ 3245.846733][ T8295]  ? security_capable+0x7e/0x260
[ 3245.851836][ T8295]  genl_rcv_msg+0x565/0x800
[ 3245.856427][ T8295]  ? __pfx_genl_rcv_msg+0x10/0x10
[ 3245.861530][ T8295]  ? __pfx_nfsd_nl_threads_set_doit+0x10/0x10
[ 3245.867684][ T8295]  netlink_rcv_skb+0x165/0x410
[ 3245.872559][ T8295]  ? __pfx_genl_rcv_msg+0x10/0x10
[ 3245.877679][ T8295]  ? __pfx_netlink_rcv_skb+0x10/0x10
[ 3245.883041][ T8295]  ? down_read+0xc9/0x330
[ 3245.887446][ T8295]  ? __pfx_down_read+0x10/0x10
[ 3245.892295][ T8295]  ? netlink_deliver_tap+0x1ae/0xcf0
[ 3245.897649][ T8295]  genl_rcv+0x28/0x40
[ 3245.901698][ T8295]  netlink_unicast+0x53c/0x7f0
[ 3245.906584][ T8295]  ? __pfx_netlink_unicast+0x10/0x10
[ 3245.912041][ T8295]  ? __phys_addr_symbol+0x30/0x80
[ 3245.917161][ T8295]  ? __check_object_size+0x488/0x710
[ 3245.922542][ T8295]  netlink_sendmsg+0x8b8/0xd70
[ 3245.927393][ T8295]  ? __pfx_netlink_sendmsg+0x10/0x10
[ 3245.932758][ T8295]  ____sys_sendmsg+0x9ae/0xb40
[ 3245.937616][ T8295]  ? copy_msghdr_from_user+0x10b/0x160
[ 3245.943164][ T8295]  ? __pfx_____sys_sendmsg+0x10/0x10
[ 3245.948531][ T8295]  ? netlink_recvmsg+0x81c/0xf30
[ 3245.953535][ T8295]  ? __pfx___lock_acquire+0x10/0x10
[ 3245.958906][ T8295]  ___sys_sendmsg+0x135/0x1e0
[ 3245.963667][ T8295]  ? __pfx____sys_sendmsg+0x10/0x10
[ 3245.968960][ T8295]  ? lock_acquire+0x2f/0xb0
[ 3245.973562][ T8295]  ? __fget_files+0x40/0x3f0
[ 3245.978240][ T8295]  ? fdget+0x176/0x210
[ 3245.982379][ T8295]  __sys_sendmsg+0x117/0x1f0
[ 3245.987050][ T8295]  ? __pfx___sys_sendmsg+0x10/0x10
[ 3245.992252][ T8295]  ? __x64_sys_futex+0x1e1/0x4c0
[ 3245.997285][ T8295]  do_syscall_64+0xcd/0x250
[ 3246.001884][ T8295]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[ 3246.007856][ T8295] RIP: 0033:0x7fd3c577dff9
[ 3246.012333][ T8295] Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f
1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b
4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8
64 89 01 48
[ 3246.032094][ T8295] RSP: 002b:00007fd3c65a7038 EFLAGS: 00000246
ORIG_RAX: 000000000000002e
[ 3246.040597][ T8295] RAX: ffffffffffffffda RBX: 00007fd3c5935f80
RCX: 00007fd3c577dff9
[ 3246.048626][ T8295] RDX: 0000000000008004 RSI: 0000000020000140
RDI: 0000000000000003
[ 3246.056739][ T8295] RBP: 00007fd3c57f0296 R08: 0000000000000000
R09: 0000000000000000
[ 3246.064770][ T8295] R10: 0000000000000000 R11: 0000000000000246
R12: 0000000000000000
[ 3246.072801][ T8295] R13: 0000000000000000 R14: 00007fd3c5935f80
R15: 00007ffca7d46f08
[ 3246.080840][ T8295]  </TASK>
[ 3246.083901][ T8295]
[ 3246.086354][ T8295] Allocated by task 8199:
[ 3246.090716][ T8295]  kasan_save_stack+0x33/0x60
[ 3246.095449][ T8295]  kasan_save_track+0x14/0x30
[ 3246.100192][ T8295]  __kasan_kmalloc+0xaa/0xb0
[ 3246.104861][ T8295]  __kmalloc_node_noprof+0x211/0x440
[ 3246.110263][ T8295]  __kvmalloc_node_noprof+0xad/0x1a0
[ 3246.115630][ T8295]  bucket_table_alloc.isra.0+0x86/0x460
[ 3246.121336][ T8295]  rhashtable_init_noprof+0x43b/0x7d0
[ 3246.126797][ T8295]  rhltable_init_noprof+0x20/0x60
[ 3246.131899][ T8295]  nfsd_file_cache_init+0xd2/0x4d0
[ 3246.137089][ T8295]  nfsd_svc+0x5db/0x940
[ 3246.141306][ T8295]  nfsd_nl_threads_set_doit+0x535/0xbe0
[ 3246.147008][ T8295]  genl_family_rcv_msg_doit+0x202/0x2f0
[ 3246.152628][ T8295]  genl_rcv_msg+0x565/0x800
[ 3246.157209][ T8295]  netlink_rcv_skb+0x165/0x410
[ 3246.162039][ T8295]  genl_rcv+0x28/0x40
[ 3246.166089][ T8295]  netlink_unicast+0x53c/0x7f0
[ 3246.170946][ T8295]  netlink_sendmsg+0x8b8/0xd70
[ 3246.175774][ T8295]  ____sys_sendmsg+0x9ae/0xb40
[ 3246.180605][ T8295]  ___sys_sendmsg+0x135/0x1e0
[ 3246.185447][ T8295]  __sys_sendmsg+0x117/0x1f0
[ 3246.190110][ T8295]  do_syscall_64+0xcd/0x250
[ 3246.194685][ T8295]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[ 3246.200643][ T8295]
[ 3246.203001][ T8295] Freed by task 8199:
[ 3246.207011][ T8295]  kasan_save_stack+0x33/0x60
[ 3246.211840][ T8295]  kasan_save_track+0x14/0x30
[ 3246.216587][ T8295]  kasan_save_free_info+0x3b/0x60
[ 3246.221674][ T8295]  __kasan_slab_free+0x51/0x70
[ 3246.226594][ T8295]  kfree+0x14f/0x4b0
[ 3246.230547][ T8295]  kvfree+0x47/0x50
[ 3246.234426][ T8295]  rhashtable_free_and_destroy+0x16c/0x990
[ 3246.240316][ T8295]  nfsd_file_cache_init+0x3e0/0x4d0
[ 3246.245587][ T8295]  nfsd_svc+0x5db/0x940
[ 3246.249802][ T8295]  nfsd_nl_threads_set_doit+0x535/0xbe0
[ 3246.255425][ T8295]  genl_family_rcv_msg_doit+0x202/0x2f0
[ 3246.261048][ T8295]  genl_rcv_msg+0x565/0x800
[ 3246.265634][ T8295]  netlink_rcv_skb+0x165/0x410
[ 3246.270463][ T8295]  genl_rcv+0x28/0x40
[ 3246.274539][ T8295]  netlink_unicast+0x53c/0x7f0
[ 3246.279369][ T8295]  netlink_sendmsg+0x8b8/0xd70
[ 3246.284200][ T8295]  ____sys_sendmsg+0x9ae/0xb40
[ 3246.289023][ T8295]  ___sys_sendmsg+0x135/0x1e0
[ 3246.293760][ T8295]  __sys_sendmsg+0x117/0x1f0
[ 3246.298430][ T8295]  do_syscall_64+0xcd/0x250
[ 3246.303005][ T8295]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[ 3246.308966][ T8295]
[ 3246.311330][ T8295] The buggy address belongs to the object at
ffff8880301ac000
[ 3246.311330][ T8295]  which belongs to the cache kmalloc-4k of size 4096
[ 3246.325434][ T8295] The buggy address is located 16 bytes inside of
[ 3246.325434][ T8295]  freed 4096-byte region [ffff8880301ac000,
ffff8880301ad000)
[ 3246.339289][ T8295]
[ 3246.341654][ T8295] The buggy address belongs to the physical page:
[ 3246.348116][ T8295] page: refcount:1 mapcount:0
mapping:0000000000000000 index:0x0 pfn:0x301a8
[ 3246.356987][ T8295] head: order:3 mapcount:0 entire_mapcount:0
nr_pages_mapped:0 pincount:0
[ 3246.365630][ T8295] flags:
0xfff00000000040(head|node=3D0|zone=3D1|lastcpupid=3D0x7ff)
[ 3246.373252][ T8295] page_type: f5(slab)
[ 3246.377291][ T8295] raw: 00fff00000000040 ffff88801ac42140
ffffea0000db9800 dead000000000002
[ 3246.385938][ T8295] raw: 0000000000000000 0000000000040004
00000001f5000000 0000000000000000
[ 3246.394589][ T8295] head: 00fff00000000040 ffff88801ac42140
ffffea0000db9800 dead000000000002
[ 3246.403325][ T8295] head: 0000000000000000 0000000000040004
00000001f5000000 0000000000000000
[ 3246.412047][ T8295] head: 00fff00000000003 ffffea0000c06a01
ffffffffffffffff 0000000000000000
[ 3246.420777][ T8295] head: 0000000000000008 0000000000000000
00000000ffffffff 0000000000000000
[ 3246.429501][ T8295] page dumped because: kasan: bad access detected
[ 3246.435995][ T8295] page_owner tracks the page as allocated
[ 3246.441746][ T8295] page last allocated via order 3, migratetype
Unmovable, gfp_mask
0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC),
pid 21493, tgid 21493 (syz.0.3187), ts 1292101106947, free_ts
1292053895765
[ 3246.462737][ T8295]  post_alloc_hook+0x2d1/0x350
[ 3246.467575][ T8295]  get_page_from_freelist+0x101e/0x3070
[ 3246.473199][ T8295]  __alloc_pages_noprof+0x223/0x25c0
[ 3246.478567][ T8295]  alloc_pages_mpol_noprof+0x2c9/0x610
[ 3246.484105][ T8295]  new_slab+0x2ba/0x3f0
[ 3246.488335][ T8295]  ___slab_alloc+0xd1d/0x16f0
[ 3246.493128][ T8295]  __slab_alloc.constprop.0+0x56/0xb0
[ 3246.498579][ T8295]  __kmalloc_noprof+0x379/0x410
[ 3246.503511][ T8295]  tomoyo_realpath_from_path+0xbf/0x710
[ 3246.509162][ T8295]  tomoyo_check_open_permission+0x2a7/0x3b0
[ 3246.515145][ T8295]  tomoyo_file_open+0xcf/0x100
[ 3246.519975][ T8295]  security_file_open+0x64c/0x9d0
[ 3246.525092][ T8295]  do_dentry_open+0x57c/0x1530
[ 3246.530014][ T8295]  vfs_open+0x82/0x3f0
[ 3246.534177][ T8295]  path_openat+0x1e6a/0x2d60
[ 3246.538831][ T8295]  do_filp_open+0x1dc/0x430
[ 3246.543412][ T8295] page last free pid 12198 tgid 12198 stack trace:
[ 3246.549952][ T8295]  free_unref_page+0x5f4/0xdc0
[ 3246.554884][ T8295]  __put_partials+0x14c/0x170
[ 3246.559637][ T8295]  qlist_free_all+0x4e/0x120
[ 3246.564302][ T8295]  kasan_quarantine_reduce+0x192/0x1e0
[ 3246.569924][ T8295]  __kasan_slab_alloc+0x69/0x90
[ 3246.574848][ T8295]  kmem_cache_alloc_node_noprof+0x153/0x310
[ 3246.580821][ T8295]  __alloc_skb+0x2b3/0x380
[ 3246.585351][ T8295]  alloc_skb_with_frags+0xe4/0x850
[ 3246.590526][ T8295]  sock_alloc_send_pskb+0x7f1/0x980
[ 3246.595806][ T8295]  mld_newpack.isra.0+0x1d4/0x7e0
[ 3246.600904][ T8295]  add_grhead+0x299/0x340
[ 3246.605299][ T8295]  add_grec+0x111e/0x1670
[ 3246.609696][ T8295]  mld_ifc_work+0x41f/0xca0
[ 3246.614273][ T8295]  process_one_work+0x958/0x1b30
[ 3246.619294][ T8295]  worker_thread+0x6c8/0xf00
[ 3246.623964][ T8295]  kthread+0x2c1/0x3a0
[ 3246.628104][ T8295]
[ 3246.630461][ T8295] Memory state around the buggy address:
[ 3246.636132][ T8295]  ffff8880301abf00: fc fc fc fc fc fc fc fc fc
fc fc fc fc fc fc fc
[ 3246.644246][ T8295]  ffff8880301abf80: fc fc fc fc fc fc fc fc fc
fc fc fc fc fc fc fc
[ 3246.652375][ T8295] >ffff8880301ac000: fa fb fb fb fb fb fb fb fb
fb fb fb fb fb fb fb
[ 3246.660488][ T8295]                          ^
[ 3246.665151][ T8295]  ffff8880301ac080: fb fb fb fb fb fb fb fb fb
fb fb fb fb fb fb fb
[ 3246.673265][ T8295]  ffff8880301ac100: fb fb fb fb fb fb fb fb fb
fb fb fb fb fb fb fb
[ 3246.681390][ T8295]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

