Return-Path: <linux-nfs+bounces-18208-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SE1NCZ7wb2m+UQAAu9opvQ
	(envelope-from <linux-nfs+bounces-18208-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jan 2026 22:16:14 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2784C157
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jan 2026 22:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A7F1254DC9B
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jan 2026 20:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD393A4ADB;
	Tue, 20 Jan 2026 20:17:28 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2881737F8A2
	for <linux-nfs@vger.kernel.org>; Tue, 20 Jan 2026 20:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768940248; cv=none; b=LuDhKsZCWAp04lpfjH3xD4mH6bWQwtkYa7q51Zi4+VRe1jb8xu4+1oTHQBtR49YEYU1LuA+rqfrhXj7D9oZzD5XAsUSr8MmimsVbAVxWRuQ+kYTTZ2LH65dswhNYhJsXsjTPN7KzaoQDA45CgXmrZV/85TBv5dlROTkKpc+Exs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768940248; c=relaxed/simple;
	bh=El5jxZ07HsbFkZEJzysjYGQBL6lEICg4Qv2KfKEW6g8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WhFHgWGH6RR0p0T4JUEbzazbRllEZirBC0QkJsm5PiC0HKbzMIEoUuuoKEgLzDPQeQ6o+txeTnG5TdBk/UN82eRaC7ewAKTtYxCwveIxBN63TU0257lfA2ByYFVNGw97CTPe4cPmazq95UAfdqq50y0B0Ke5Nov3WCZ9cnycHY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-65f6d0bd852so14238959eaf.3
        for <linux-nfs@vger.kernel.org>; Tue, 20 Jan 2026 12:17:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768940245; x=1769545045;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kihzd8J+sFleTYdT1AUyJ6Rg8kcEG1pR/xOLyTyK9LE=;
        b=vgnj+Y6mGOZWG04SEcJTGrOZcJu40kszvi3rwsVDyhpGWcOb+F90jVn3vGGBxxJD/d
         ArUhTQgzL3ebJlM+6b3UhGV92KZL1rFLafRguICZ/RyDwxoT/Ds+sBe/6sie8Qdwxlcf
         FEo4tt0nzgDe/6qSVH127Yx18+gbXroi4PTB9QXoiXUd8eB6O+SioY/hJqdqYGQAhYNc
         FhCAdTkeHDCgqe2uFs+8JIaY4jRZRNuE57gCeAyL/B2KQ/eSvf0/qjxh99Hj8Bm4RCNi
         5D90i24j0JRadnI9julRubGYUCPeiKS2d0KlCNzjD26eBy2QN3fm/kQ/dX9CtcJFP9Sx
         xRvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZ9CGC2ARwfvWwTSiET2codNaMwhSPzIEWaHgMCBKjK8/3a6pByGwpposiYk1xYPndzSVmb+nxEAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLqJGO+ipioOCzFhcfxMLbxuOhEU6qaY/mZZnoG8R2v2OWoHs5
	SeJTnwcgz/wvr0oDT7yMSYtayyCGcsoPaIPwI236XD/7rJc0UOIN5WEC0NQF4cA7taxHYp8wV6x
	SPeutvgafXe3BSiIALTuAL6IiY/qKFaBPiG5HzGgL8Rfx+n2NLULZhC9qY0E=
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:160f:b0:659:9a49:8ec2 with SMTP id
 006d021491bc7-662b00c7211mr1223310eaf.70.1768940245054; Tue, 20 Jan 2026
 12:17:25 -0800 (PST)
Date: Tue, 20 Jan 2026 12:17:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <696fe2d5.050a0220.706b.0002.GAE@google.com>
Subject: [syzbot] [nfs?] INFO: task hung in expkey_flush
From: syzbot <syzbot+b6a0f8e7fb5f9c959ddd@syzkaller.appspotmail.com>
To: Dai.Ngo@oracle.com, chuck.lever@oracle.com, jlayton@kernel.org, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, neil@brown.name, 
	okorniev@redhat.com, syzkaller-bugs@googlegroups.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=ae589cd0a6acd9be];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : No valid SPF, No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-18208-lists,linux-nfs=lfdr.de,b6a0f8e7fb5f9c959ddd];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[linux-nfs];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,appspotmail.com:email,storage.googleapis.com:url,syzkaller.appspot.com:url,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,goo.gl:url]
X-Rspamd-Queue-Id: DF2784C157
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    983d014aafb1 kernel: modules: Add SPDX license identifier ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=100bfdfa580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae589cd0a6acd9be
dashboard link: https://syzkaller.appspot.com/bug?extid=b6a0f8e7fb5f9c959ddd
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8a294469166c/disk-983d014a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f9504a6df5a7/vmlinux-983d014a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/88a1d939d6af/bzImage-983d014a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b6a0f8e7fb5f9c959ddd@syzkaller.appspotmail.com

INFO: task syz.1.1468:12715 blocked for more than 143 seconds.
      Tainted: G             L      syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.1468      state:D stack:26952 pid:12715 tgid:12702 ppid:5835   task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x1139/0x6150 kernel/sched/core.c:6863
 __schedule_loop kernel/sched/core.c:6945 [inline]
 schedule+0xe7/0x3a0 kernel/sched/core.c:6960
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7017
 __mutex_lock_common kernel/locking/mutex.c:692 [inline]
 __mutex_lock+0xc69/0x1ca0 kernel/locking/mutex.c:776
 expkey_flush+0x20/0x90 fs/nfsd/export.c:250
 write_flush.constprop.0+0x2af/0x3d0 net/sunrpc/cache.c:1550
 pde_write fs/proc/inode.c:330 [inline]
 proc_reg_write+0x240/0x330 fs/proc/inode.c:342
 do_loop_readv_writev fs/read_write.c:850 [inline]
 do_loop_readv_writev fs/read_write.c:835 [inline]
 vfs_writev+0x5df/0xde0 fs/read_write.c:1059
 do_writev+0x132/0x340 fs/read_write.c:1103
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb96ed8f7c9
RSP: 002b:00007fb96cfb4038 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00007fb96efe6180 RCX: 00007fb96ed8f7c9
RDX: 000000000000000a RSI: 0000200000000240 RDI: 000000000000000c
RBP: 00007fb96ee13f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fb96efe6218 R14: 00007fb96efe6180 R15: 00007fff264f2848
 </TASK>
INFO: task syz.0.1500:12841 blocked for more than 143 seconds.
      Tainted: G             L      syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.1500      state:D stack:24856 pid:12841 tgid:12839 ppid:5826   task_flags:0x400140 flags:0x00080006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x1139/0x6150 kernel/sched/core.c:6863
 __schedule_loop kernel/sched/core.c:6945 [inline]
 schedule+0xe7/0x3a0 kernel/sched/core.c:6960
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7017
 __mutex_lock_common kernel/locking/mutex.c:692 [inline]
 __mutex_lock+0xc69/0x1ca0 kernel/locking/mutex.c:776
 nfsd_shutdown_threads+0x5b/0xf0 fs/nfsd/nfssvc.c:575
 nfsd_umount+0x3b/0x60 fs/nfsd/nfsctl.c:1353
 deactivate_locked_super+0xc1/0x1a0 fs/super.c:474
 deactivate_super fs/super.c:507 [inline]
 deactivate_super+0xde/0x100 fs/super.c:503
 cleanup_mnt+0x225/0x450 fs/namespace.c:1318
 task_work_run+0x150/0x240 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:44 [inline]
 exit_to_user_mode_loop+0xfb/0x540 kernel/entry/common.c:75
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:159 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:194 [inline]
 do_syscall_64+0x4ee/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f44b698f7c9
RSP: 002b:00007f44b78ff038 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffec RBX: 00007f44b6be5fa0 RCX: 00007f44b698f7c9
RDX: 0000200000000580 RSI: 00002000000001c0 RDI: 0000000000000000
RBP: 00007f44b6a13f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f44b6be6038 R14: 00007f44b6be5fa0 R15: 00007ffd112c8918
 </TASK>
INFO: task syz.0.1500:12844 blocked for more than 143 seconds.
      Tainted: G             L      syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.1500      state:D stack:27336 pid:12844 tgid:12839 ppid:5826   task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x1139/0x6150 kernel/sched/core.c:6863
 __schedule_loop kernel/sched/core.c:6945 [inline]
 schedule+0xe7/0x3a0 kernel/sched/core.c:6960
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7017
 rwsem_down_write_slowpath+0x521/0x1310 kernel/locking/rwsem.c:1185
 __down_write_common kernel/locking/rwsem.c:1317 [inline]
 __down_write kernel/locking/rwsem.c:1326 [inline]
 down_write+0x1d6/0x200 kernel/locking/rwsem.c:1591
 __super_lock fs/super.c:57 [inline]
 super_lock+0x17d/0x3f0 fs/super.c:121
 super_lock_excl fs/super.c:146 [inline]
 grab_super+0xab/0x420 fs/super.c:531
 sget_fc+0x612/0xc20 fs/super.c:801
 vfs_get_super fs/super.c:1319 [inline]
 get_tree_keyed+0x59/0x1d0 fs/super.c:1361
 vfs_get_tree+0x8e/0x330 fs/super.c:1751
 fc_mount fs/namespace.c:1199 [inline]
 do_new_mount_fc fs/namespace.c:3636 [inline]
 do_new_mount fs/namespace.c:3712 [inline]
 path_mount+0x7bf/0x23a0 fs/namespace.c:4022
 do_mount fs/namespace.c:4035 [inline]
 __do_sys_mount fs/namespace.c:4224 [inline]
 __se_sys_mount fs/namespace.c:4201 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:4201
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f44b698f7c9
RSP: 002b:00007f44b78de038 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f44b6be6090 RCX: 00007f44b698f7c9
RDX: 0000200000000100 RSI: 00002000000000c0 RDI: 0000000000000000
RBP: 00007f44b6a13f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000007 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f44b6be6128 R14: 00007f44b6be6090 R15: 00007ffd112c8918
 </TASK>
INFO: task syz.3.1556:13091 blocked for more than 144 seconds.
      Tainted: G             L      syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.1556      state:D stack:24936 pid:13091 tgid:13088 ppid:7203   task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x1139/0x6150 kernel/sched/core.c:6863
 __schedule_loop kernel/sched/core.c:6945 [inline]
 schedule+0xe7/0x3a0 kernel/sched/core.c:6960
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7017
 __mutex_lock_common kernel/locking/mutex.c:692 [inline]
 __mutex_lock+0xc69/0x1ca0 kernel/locking/mutex.c:776
 nfsd_nl_threads_set_doit+0x687/0xbc0 fs/nfsd/nfsctl.c:1596
 genl_family_rcv_msg_doit+0x209/0x2f0 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x55c/0x800 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x8c8/0xdd0 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0xa5d/0xc30 net/socket.c:2592
 ___sys_sendmsg+0x134/0x1d0 net/socket.c:2646
 __sys_sendmsg+0x16d/0x220 net/socket.c:2678
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f62dd58f7c9
RSP: 002b:00007f62de4b2038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f62dd7e6180 RCX: 00007f62dd58f7c9
RDX: 0000000000004000 RSI: 0000200000000480 RDI: 0000000000000005
RBP: 00007f62dd613f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f62dd7e6218 R14: 00007f62dd7e6180 R15: 00007ffea1c1dd18
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_exp_gp_kthr/18:
 #0: ffff8880b843add8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested kernel/sched/core.c:647 [inline]
 #0: ffff8880b843add8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x7e/0x130 kernel/sched/core.c:632
1 lock held by khungtaskd/31:
 #0: ffffffff8e3c9520 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8e3c9520 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #0: ffffffff8e3c9520 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x36/0x1c0 kernel/locking/lockdep.c:6775
1 lock held by dhcpcd/5495:
 #0: ffffffff90145da8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #0: ffffffff90145da8 (rtnl_mutex){+.+.}-{4:4}, at: devinet_ioctl+0x26d/0x1f30 net/ipv4/devinet.c:1120
2 locks held by getty/6359:
 #0: ffff8880326480a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000ee0b2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x41b/0x1510 drivers/tty/n_tty.c:2211
2 locks held by syz-executor/11006:
 #0: ffff88805871a0e0 (&type->s_umount_key#53){++++}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff88805871a0e0 (&type->s_umount_key#53){++++}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff88805871a0e0 (&type->s_umount_key#53){++++}-{4:4}, at: deactivate_super fs/super.c:506 [inline]
 #0: ffff88805871a0e0 (&type->s_umount_key#53){++++}-{4:4}, at: deactivate_super+0xd6/0x100 fs/super.c:503
 #1: ffffffff8e801588 (nfsd_mutex){+.+.}-{4:4}, at: nfsd_shutdown_threads+0x5b/0xf0 fs/nfsd/nfssvc.c:575
2 locks held by kworker/u8:21/11345:
 #0: ffff88801d3ae148 ((wq_completion)iou_exit){+.+.}-{0:0}, at: process_one_work+0x128d/0x1b20 kernel/workqueue.c:3232
 #1: ffffc9000bb87c90 ((work_completion)(&ctx->exit_work)){+.+.}-{0:0}, at: process_one_work+0x914/0x1b20 kernel/workqueue.c:3233
2 locks held by syz.1.1468/12708:
 #0: ffffffff901ec4d0 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8e801588 (nfsd_mutex){+.+.}-{4:4}, at: nfsd_nl_threads_set_doit+0x687/0xbc0 fs/nfsd/nfsctl.c:1596
3 locks held by syz.1.1468/12715:
 #0: ffff888030f48638 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x2a2/0x370 fs/file.c:1255
 #1: ffff888020b2c420 (sb_writers#3){.+.+}-{0:0}, at: do_writev+0x132/0x340 fs/read_write.c:1103
 #2: ffffffff8e801588 (nfsd_mutex){+.+.}-{4:4}, at: expkey_flush+0x20/0x90 fs/nfsd/export.c:250
2 locks held by syz.0.1500/12841:
 #0: ffff88805d9bc0e0 (&type->s_umount_key#53){++++}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff88805d9bc0e0 (&type->s_umount_key#53){++++}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff88805d9bc0e0 (&type->s_umount_key#53){++++}-{4:4}, at: deactivate_super fs/super.c:506 [inline]
 #0: ffff88805d9bc0e0 (&type->s_umount_key#53){++++}-{4:4}, at: deactivate_super+0xd6/0x100 fs/super.c:503
 #1: ffffffff8e801588 (nfsd_mutex){+.+.}-{4:4}, at: nfsd_shutdown_threads+0x5b/0xf0 fs/nfsd/nfssvc.c:575
1 lock held by syz.0.1500/12844:
 #0: ffff88805d9bc0e0 (&type->s_umount_key#53){++++}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff88805d9bc0e0 (&type->s_umount_key#53){++++}-{4:4}, at: super_lock+0x17d/0x3f0 fs/super.c:121
2 locks held by syz-executor/12933:
 #0: ffff88805b64c0e0 (&type->s_umount_key#53){++++}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff88805b64c0e0 (&type->s_umount_key#53){++++}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff88805b64c0e0 (&type->s_umount_key#53){++++}-{4:4}, at: deactivate_super fs/super.c:506 [inline]
 #0: ffff88805b64c0e0 (&type->s_umount_key#53){++++}-{4:4}, at: deactivate_super+0xd6/0x100 fs/super.c:503
 #1: ffffffff8e801588 (nfsd_mutex){+.+.}-{4:4}, at: nfsd_shutdown_threads+0x5b/0xf0 fs/nfsd/nfssvc.c:575
2 locks held by syz.3.1556/13091:
 #0: ffffffff901ec4d0 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8e801588 (nfsd_mutex){+.+.}-{4:4}, at: nfsd_nl_threads_set_doit+0x687/0xbc0 fs/nfsd/nfsctl.c:1596
2 locks held by syz-executor/13321:
 #0: ffff888020fd00e0 (&type->s_umount_key#53){++++}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff888020fd00e0 (&type->s_umount_key#53){++++}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff888020fd00e0 (&type->s_umount_key#53){++++}-{4:4}, at: deactivate_super fs/super.c:506 [inline]
 #0: ffff888020fd00e0 (&type->s_umount_key#53){++++}-{4:4}, at: deactivate_super+0xd6/0x100 fs/super.c:503
 #1: ffffffff8e801588 (nfsd_mutex){+.+.}-{4:4}, at: nfsd_shutdown_threads+0x5b/0xf0 fs/nfsd/nfssvc.c:575
2 locks held by syz-executor/13337:
 #0: ffff88807c07e0e0 (&type->s_umount_key#53){++++}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff88807c07e0e0 (&type->s_umount_key#53){++++}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff88807c07e0e0 (&type->s_umount_key#53){++++}-{4:4}, at: deactivate_super fs/super.c:506 [inline]
 #0: ffff88807c07e0e0 (&type->s_umount_key#53){++++}-{4:4}, at: deactivate_super+0xd6/0x100 fs/super.c:503
 #1: ffffffff8e801588 (nfsd_mutex){+.+.}-{4:4}, at: nfsd_shutdown_threads+0x5b/0xf0 fs/nfsd/nfssvc.c:575
2 locks held by syz-executor/13419:
 #0: ffff8880773760e0 (&type->s_umount_key#53){++++}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff8880773760e0 (&type->s_umount_key#53){++++}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff8880773760e0 (&type->s_umount_key#53){++++}-{4:4}, at: deactivate_super fs/super.c:506 [inline]
 #0: ffff8880773760e0 (&type->s_umount_key#53){++++}-{4:4}, at: deactivate_super+0xd6/0x100 fs/super.c:503
 #1: ffffffff8e801588 (nfsd_mutex){+.+.}-{4:4}, at: nfsd_shutdown_threads+0x5b/0xf0 fs/nfsd/nfssvc.c:575
2 locks held by syz-executor/13551:
 #0: ffff88802bf220e0 (&type->s_umount_key#53){++++}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff88802bf220e0 (&type->s_umount_key#53){++++}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff88802bf220e0 (&type->s_umount_key#53){++++}-{4:4}, at: deactivate_super fs/super.c:506 [inline]
 #0: ffff88802bf220e0 (&type->s_umount_key#53){++++}-{4:4}, at: deactivate_super+0xd6/0x100 fs/super.c:503
 #1: ffffffff8e801588 (nfsd_mutex){+.+.}-{4:4}, at: nfsd_shutdown_threads+0x5b/0xf0 fs/nfsd/nfssvc.c:575
2 locks held by syz-executor/13792:
 #0: ffff88804bb560e0 (&type->s_umount_key#53){++++}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff88804bb560e0 (&type->s_umount_key#53){++++}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff88804bb560e0 (&type->s_umount_key#53){++++}-{4:4}, at: deactivate_super fs/super.c:506 [inline]
 #0: ffff88804bb560e0 (&type->s_umount_key#53){++++}-{4:4}, at: deactivate_super+0xd6/0x100 fs/super.c:503
 #1: ffffffff8e801588 (nfsd_mutex){+.+.}-{4:4}, at: nfsd_shutdown_threads+0x5b/0xf0 fs/nfsd/nfssvc.c:575
2 locks held by syz-executor/14032:
 #0: ffff88807c7300e0 (&type->s_umount_key#53){++++}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff88807c7300e0 (&type->s_umount_key#53){++++}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff88807c7300e0 (&type->s_umount_key#53){++++}-{4:4}, at: deactivate_super fs/super.c:506 [inline]
 #0: ffff88807c7300e0 (&type->s_umount_key#53){++++}-{4:4}, at: deactivate_super+0xd6/0x100 fs/super.c:503
 #1: ffffffff8e801588 (nfsd_mutex){+.+.}-{4:4}, at: nfsd_shutdown_threads+0x5b/0xf0 fs/nfsd/nfssvc.c:575
2 locks held by syz-executor/14097:
 #0: ffff888040f180e0 (&type->s_umount_key#53){++++}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff888040f180e0 (&type->s_umount_key#53){++++}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff888040f180e0 (&type->s_umount_key#53){++++}-{4:4}, at: deactivate_super fs/super.c:506 [inline]
 #0: ffff888040f180e0 (&type->s_umount_key#53){++++}-{4:4}, at: deactivate_super+0xd6/0x100 fs/super.c:503
 #1: ffffffff8e801588 (nfsd_mutex){+.+.}-{4:4}, at: nfsd_shutdown_threads+0x5b/0xf0 fs/nfsd/nfssvc.c:575
2 locks held by syz-executor/14164:
 #0: ffff888031f180e0 (&type->s_umount_key#53){++++}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff888031f180e0 (&type->s_umount_key#53){++++}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff888031f180e0 (&type->s_umount_key#53){++++}-{4:4}, at: deactivate_super fs/super.c:506 [inline]
 #0: ffff888031f180e0 (&type->s_umount_key#53){++++}-{4:4}, at: deactivate_super+0xd6/0x100 fs/super.c:503
 #1: ffffffff8e801588 (nfsd_mutex){+.+.}-{4:4}, at: nfsd_shutdown_threads+0x5b/0xf0 fs/nfsd/nfssvc.c:575
2 locks held by syz-executor/14216:
 #0: ffff8880403960e0 (&type->s_umount_key#53){++++}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff8880403960e0 (&type->s_umount_key#53){++++}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff8880403960e0 (&type->s_umount_key#53){++++}-{4:4}, at: deactivate_super fs/super.c:506 [inline]
 #0: ffff8880403960e0 (&type->s_umount_key#53){++++}-{4:4}, at: deactivate_super+0xd6/0x100 fs/super.c:503
 #1: ffffffff8e801588 (nfsd_mutex){+.+.}-{4:4}, at: nfsd_shutdown_threads+0x5b/0xf0 fs/nfsd/nfssvc.c:575
2 locks held by syz-executor/14279:
 #0: ffff88814135c0e0 (&type->s_umount_key#53){++++}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff88814135c0e0 (&type->s_umount_key#53){++++}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff88814135c0e0 (&type->s_umount_key#53){++++}-{4:4}, at: deactivate_super fs/super.c:506 [inline]
 #0: ffff88814135c0e0 (&type->s_umount_key#53){++++}-{4:4}, at: deactivate_super+0xd6/0x100 fs/super.c:503
 #1: ffffffff8e801588 (nfsd_mutex){+.+.}-{4:4}, at: nfsd_shutdown_threads+0x5b/0xf0 fs/nfsd/nfssvc.c:575
2 locks held by syz-executor/14330:
 #0: ffff88804776a0e0 (&type->s_umount_key#53){++++}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff88804776a0e0 (&type->s_umount_key#53){++++}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff88804776a0e0 (&type->s_umount_key#53){++++}-{4:4}, at: deactivate_super fs/super.c:506 [inline]
 #0: ffff88804776a0e0 (&type->s_umount_key#53){++++}-{4:4}, at: deactivate_super+0xd6/0x100 fs/super.c:503
 #1: ffffffff8e801588 (nfsd_mutex){+.+.}-{4:4}, at: nfsd_shutdown_threads+0x5b/0xf0 fs/nfsd/nfssvc.c:575
2 locks held by syz-executor/14397:
 #0: ffff8880a406c0e0 (&type->s_umount_key#53){++++}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff8880a406c0e0 (&type->s_umount_key#53){++++}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff8880a406c0e0 (&type->s_umount_key#53){++++}-{4:4}, at: deactivate_super fs/super.c:506 [inline]
 #0: ffff8880a406c0e0 (&type->s_umount_key#53){++++}-{4:4}, at: deactivate_super+0xd6/0x100 fs/super.c:503
 #1: ffffffff8e801588 (nfsd_mutex){+.+.}-{4:4}, at: nfsd_shutdown_threads+0x5b/0xf0 fs/nfsd/nfssvc.c:575
2 locks held by syz-executor/14398:
 #0: ffff8880791f00e0 (&type->s_umount_key#53){++++}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff8880791f00e0 (&type->s_umount_key#53){++++}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff8880791f00e0 (&type->s_umount_key#53){++++}-{4:4}, at: deactivate_super fs/super.c:506 [inline]
 #0: ffff8880791f00e0 (&type->s_umount_key#53){++++}-{4:4}, at: deactivate_super+0xd6/0x100 fs/super.c:503
 #1: ffffffff8e801588 (nfsd_mutex){+.+.}-{4:4}, at: nfsd_shutdown_threads+0x5b/0xf0 fs/nfsd/nfssvc.c:575
2 locks held by syz-executor/14452:
 #0: ffff88807a0040e0 (&type->s_umount_key#53){++++}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff88807a0040e0 (&type->s_umount_key#53){++++}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff88807a0040e0 (&type->s_umount_key#53){++++}-{4:4}, at: deactivate_super fs/super.c:506 [inline]
 #0: ffff88807a0040e0 (&type->s_umount_key#53){++++}-{4:4}, at: deactivate_super+0xd6/0x100 fs/super.c:503
 #1: ffffffff8e801588 (nfsd_mutex){+.+.}-{4:4}, at: nfsd_shutdown_threads+0x5b/0xf0 fs/nfsd/nfssvc.c:575
2 locks held by syz-executor/14700:
 #0: ffff88805dc8cec0 (&hdev->req_lock){+.+.}-{4:4}, at: hci_dev_do_close+0x26/0xc0 net/bluetooth/hci_core.c:499
 #1: ffff88805dc8c0c0 (&hdev->lock){+.+.}-{4:4}, at: hci_dev_close_sync+0x3af/0x1260 net/bluetooth/hci_sync.c:5315
4 locks held by kworker/u8:45/14791:
 #0: ffff88801badf148 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x128d/0x1b20 kernel/workqueue.c:3232
 #1: ffffc9000b387c90 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0x914/0x1b20 kernel/workqueue.c:3233
 #2: ffffffff9012f2d0 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0xad/0x830 net/core/net_namespace.c:670
 #3: ffffffff90145da8 (rtnl_mutex){+.+.}-{4:4}, at: cfg80211_pernet_exit+0x17/0x120 net/wireless/core.c:1693
4 locks held by kworker/u8:46/14802:
 #0: ffff88813ff69948 ((wq_completion)events_unbound#2){+.+.}-{0:0}, at: process_one_work+0x128d/0x1b20 kernel/workqueue.c:3232
 #1: ffffc9000b637c90 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work+0x914/0x1b20 kernel/workqueue.c:3233
 #2: ffffffff90145da8 (rtnl_mutex){+.+.}-{4:4}, at: linkwatch_event+0x51/0xc0 net/core/link_watch.c:303
 #3: ffffffff8e3d4c78 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock+0x284/0x3c0 kernel/rcu/tree_exp.h:311
3 locks held by kworker/u8:48/14896:
 #0: ffff8880b843add8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested kernel/sched/core.c:647 [inline]
 #0: ffff8880b843add8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x7e/0x130 kernel/sched/core.c:632
 #1: ffff8880b8424608 (psi_seq){-.-.}-{0:0}, at: psi_sched_switch kernel/sched/stats.h:225 [inline]
 #1: ffff8880b8424608 (psi_seq){-.-.}-{0:0}, at: __schedule+0x19b1/0x6150 kernel/sched/core.c:6857
 #2: ffff888048ee0788 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: class_wiphy_constructor include/net/cfg80211.h:6363 [inline]
 #2: ffff888048ee0788 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: cfg80211_wiphy_work+0x99/0x560 net/wireless/core.c:424
2 locks held by syz-executor/15014:
 #0: ffffffff90894028 (&ops->srcu#2){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:185 [inline]
 #0: ffffffff90894028 (&ops->srcu#2){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:277 [inline]
 #0: ffffffff90894028 (&ops->srcu#2){.+.+}-{0:0}, at: rtnl_link_ops_get+0x113/0x2c0 net/core/rtnetlink.c:574
 #1: ffffffff90145da8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #1: ffffffff90145da8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
 #1: ffffffff90145da8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x5f6/0x1f50 net/core/rtnetlink.c:4071

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 31 Comm: khungtaskd Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x27b/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:161 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x133/0x180 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:346 [inline]
 watchdog+0xe66/0x1180 kernel/hung_task.c:515
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x983/0xb10 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:82
Code: 96 61 02 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 73 77 14 00 fb f4 <e9> cc 35 03 00 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
RSP: 0018:ffffffff8e007df8 EFLAGS: 000002c6
RAX: 000000000037260d RBX: 0000000000000000 RCX: ffffffff8b75e6d9
RDX: 0000000000000000 RSI: ffffffff8dacbd06 RDI: ffffffff8bf2b780
RBP: fffffbfff1c12f68 R08: 0000000000000001 R09: ffffed101708673d
R10: ffff8880b84339eb R11: ffffffff8e098670 R12: 0000000000000000
R13: ffffffff8e097b40 R14: ffffffff908901d0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881248f9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000564b58107138 CR3: 000000000e184000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
 default_idle+0x13/0x20 arch/x86/kernel/process.c:767
 default_idle_call+0x6c/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:191 [inline]
 do_idle+0x38d/0x510 kernel/sched/idle.c:332
 cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:430
 rest_init+0x16b/0x2b0 init/main.c:757
 start_kernel+0x3ef/0x4d0 init/main.c:1206
 x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:310
 x86_64_start_kernel+0x130/0x190 arch/x86/kernel/head64.c:291
 common_startup_64+0x13e/0x148
 </TASK>


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

