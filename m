Return-Path: <linux-nfs+bounces-3854-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F989097AE
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Jun 2024 12:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C32CB2119B
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Jun 2024 10:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6ECE1CAA9;
	Sat, 15 Jun 2024 10:39:21 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D09282F4
	for <linux-nfs@vger.kernel.org>; Sat, 15 Jun 2024 10:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718447961; cv=none; b=L8LD2tJnNrU7lmP5rrx1nsd2iAvsmIF7eArZushhfWsdwXOzf9wOAw3HivNqfL6Fgwrt1S9HcLscGLgoHIEr+U/1vit2a1O5A4Ud+MQp74+ofKDhiG9F8WeylEonDrKGSrRIMF7NrLojEdRUpZ0ZLLbVakl3Y3FVMdiiXC9Fg6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718447961; c=relaxed/simple;
	bh=1DPEdGU2FZIDxzfeaBWgeXWOaPkbA0CfAkvMbgwVn6s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oince804cse4h6VMssY3/0Jp1hkg3KfQzxSRHN8Pg6NCcvWxaJsI6HOtZgyw+pvFsnSJ/i3TKjpdsrUfRX/0+LvPS9Kn6oUv3UhxnxEY02moL61VNhCNLzDhLbwtIUiqKr2cfAG4fyiBPRW/RNNyGCG/v+kGdPfFmt1UhHGD6hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-375beb12e67so28281055ab.3
        for <linux-nfs@vger.kernel.org>; Sat, 15 Jun 2024 03:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718447959; x=1719052759;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZKpeRtZQ/N1/ixlPFk9kWWY3CcSnO5A5LzYfoRpvtTE=;
        b=gb3LfhOsdQ1/fcmI/mVRtRB74z+bDcXEW8LefsL46lKBR8ZpxrsiT/Fy2Lt/nVy5Dt
         Qb2N6akWgTaZwvcDndwrNpatlxuksT7hIP+NxR+mvW/bcOPqjWe8iVn3rVL2dTGriNg6
         uK4vRxtIK6v0eqa/3Xa6mOpioy5smPMGgaQ/jiHpdftS344bm8N5fmpVO/1syks4o7xI
         neNgwTAojmNm1UxFGZvP4w0ZYWmfj3Z8llMXTDWqCsTMMKaHigT0yMVPiuapi7wSHBUW
         9coi2sbgWONNvnDivCaU67yVPywT4bVwL/xNkT8g0EicTKsIUZvO00Tqu8kjq+jRXTX1
         pCDw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ9kg/wLbjy884ZJlzPbJk3eLrJQLg1qzUUdanCHhfOpk7L3pu8DMF7Xj+ploZd9jovd95/yzcdfPnyCfBf9CyCxYI4vMJ1Cqy
X-Gm-Message-State: AOJu0Ywvn0tTYsrIrH5FPC/Nf0kCnewdheGudgweBt+20XPjerP8lh3a
	m4UZtHS+IHZB0J5SmH9sJFyPnNMSUJ02krosQ9CF/Al8ylfjg5W5pq+O8Gy6yVUaEoG/A49B80O
	rKnMiB0wWFm3fiDdhYZzlf1sanCHbr1vhg/m/8D+FF+iVJukl3l3+LUQ=
X-Google-Smtp-Source: AGHT+IE4tJZTc44BMkwrqpmHb27MzbZxBg4YjVSKjONhqOUYyQJUYRNvkcDCA7fk9VTmY3PpIXfFA+mJhmgNfs/SfyDn4xqeitvV
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19cc:b0:375:ae14:145b with SMTP id
 e9e14a558f8ab-375e1014777mr3007625ab.6.1718447959578; Sat, 15 Jun 2024
 03:39:19 -0700 (PDT)
Date: Sat, 15 Jun 2024 03:39:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000322bec061aeb58a3@google.com>
Subject: [syzbot] [nfs?] INFO: task hung in nfsd_nl_listener_get_doit
From: syzbot <syzbot+4207adf14e7c0981d28d@syzkaller.appspotmail.com>
To: Dai.Ngo@oracle.com, chuck.lever@oracle.com, jlayton@kernel.org, 
	kolga@netapp.com, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	neilb@suse.de, syzkaller-bugs@googlegroups.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cea2a26553ac mailmap: Add my outdated addresses to the map..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=169fd8ee980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa0ce06dcc735711
dashboard link: https://syzkaller.appspot.com/bug?extid=4207adf14e7c0981d28d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1f7ce933512f/disk-cea2a265.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0ce3b9940616/vmlinux-cea2a265.xz
kernel image: https://storage.googleapis.com/syzbot-assets/19e24094ea37/bzImage-cea2a265.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4207adf14e7c0981d28d@syzkaller.appspotmail.com

INFO: task syz-executor.1:17770 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc3-syzkaller-00022-gcea2a26553ac #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.1  state:D stack:23800 pid:17770 tgid:17767 ppid:11381  flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 nfsd_nl_listener_get_doit+0x115/0x5d0 fs/nfsd/nfsctl.c:2124
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb16/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e5/0x430 net/netlink/af_netlink.c:2564
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x7ec/0x980 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8db/0xcb0 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x223/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
 ___sys_sendmsg net/socket.c:2639 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f24ed27cea9
RSP: 002b:00007f24ee0080c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f24ed3b3f80 RCX: 00007f24ed27cea9
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000005
RBP: 00007f24ed2ebff4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

