Return-Path: <linux-nfs+bounces-12394-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7E9AD7CED
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jun 2025 23:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 524403A35E2
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jun 2025 21:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E242DCBF6;
	Thu, 12 Jun 2025 21:08:34 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708C72139B0
	for <linux-nfs@vger.kernel.org>; Thu, 12 Jun 2025 21:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749762514; cv=none; b=Tv73UF0TOShvcaZhay/d1dDpr3fsbJTI1BEXRhVFBgzGeoiHSDbuJ8Juuo6K1+VNE1X/mYpFqPlR5Mjz/Hd/4r9SKqgFIC7qn5yTH3zlJSXZjvOajyyKKaUghSn/e6m49TEmA5/ozyQuh/ctyBqv4wzmWFXVEMUR6QhAd0ye7Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749762514; c=relaxed/simple;
	bh=yuBTQ6WiTrDaU4CchSedx0qrGzFBNNBHaQ/8F3M6QTc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jKMaMxqii9Mw1yAZTzl51cwGj8ExtTgqK08JRYn/8Olx0N+nQ6poeu3IQuotPbO2UyWfL/kGVlSwz5Uiy0beeBhHBvWsUoGQdqG6cVzOgtJTArmsP7jtCwAU6wS4UWx8cVT/FiZ3BHWjJxYLjYYcIHpjjvCH/ZpYOSqS1JRiLE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-86d01ff56ebso203478839f.1
        for <linux-nfs@vger.kernel.org>; Thu, 12 Jun 2025 14:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749762511; x=1750367311;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gk29RHFC4M3kIeA0h8yMNCoYnyK1cf68Px8okUDLfg8=;
        b=OnSFz15//mEdNSCGT973JIy2utvBX8GC73aWifyaQ2lDHc3bfFe/a+epWmkgbwjO54
         qqi4Gqkqg2FQKKSgcJOnA3uU2WEY3plHKhj3zg/m1NZuxBxJ/ubsjMM+/n2Bcwu6sMRB
         rnhYjkbv91430hWx05DesPK5y+lDAs7djJy/VgBIc0GtqzSycQOE2GipepSp4ZtD3gXR
         lBpUiozPRk/b6D8K3VEWbVq/U604l0lD/lMwEnw8e8+NL0sTiMgAOxWNbXstzvtTiAdX
         mPGm31UDMNF7YZLW8dZgxJ0auMD371437RRHhvOj4BULnANfZq8f5n6+qYE2wolscmEy
         szpw==
X-Forwarded-Encrypted: i=1; AJvYcCUZK3cLf3yOuLuOkKnJ7LqKAg68lmDfdJN5CzlHrSChriD5YoOeXNGmPFHJChqaTqt2sN2SuoxCBPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFplPpScZtnWgqsZL47alboZfxTclZWiWn+tiBJRT2lxrylJxk
	Nfhk32FZA7ITUD/LE8Gkb3f1Sp/7kFCWjukfCgjsjRBKvWGswQ3F09LqHIXhvo2SHfYMVBMZIQx
	Dn80qV5qinrgJL1jBaVfwwUr3Kz4RJpTqtJ4UsfZN0PAtkRKaYS+B3Uv1xdQ=
X-Google-Smtp-Source: AGHT+IFpRSV+o0VdZ2ADjEv8JE9Vhcg9FBZTlorBv5/RMH8DkJw5J7xlEfMsvL2YQ9KhggeWJ6cmRI1zG7FfczeFGTz7wfOW7AZz
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2782:b0:3dd:b7da:5256 with SMTP id
 e9e14a558f8ab-3de00bce3e1mr5539445ab.19.1749762511554; Thu, 12 Jun 2025
 14:08:31 -0700 (PDT)
Date: Thu, 12 Jun 2025 14:08:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <684b41cf.a00a0220.1eb5f5.0109.GAE@google.com>
Subject: [syzbot] [net?] [nfs?] WARNING in remove_proc_entry (8)
From: syzbot <syzbot+a4cc4ac22daa4a71b87c@syzkaller.appspotmail.com>
To: Dai.Ngo@oracle.com, anna@kernel.org, chuck.lever@oracle.com, 
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jlayton@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, neil@brown.name, netdev@vger.kernel.org, 
	okorniev@redhat.com, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tom@talpey.com, trondmy@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2c4a1f3fe03e Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1432610c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c4c8362784bb7796
dashboard link: https://syzkaller.appspot.com/bug?extid=a4cc4ac22daa4a71b87c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1126ed70580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cd1ec81a3ab8/disk-2c4a1f3f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/992d9b6a25bf/vmlinux-2c4a1f3f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/85a9bf583faa/bzImage-2c4a1f3f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a4cc4ac22daa4a71b87c@syzkaller.appspotmail.com

WARNING: CPU: 0 PID: 6182 at fs/proc/generic.c:727 remove_proc_entry+0x45e/0x530 fs/proc/generic.c:727
Modules linked in:
CPU: 0 UID: 0 PID: 6182 Comm: syz.1.75 Not tainted 6.16.0-rc1-syzkaller-00010-g2c4a1f3fe03e #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:remove_proc_entry+0x45e/0x530 fs/proc/generic.c:727
Code: 3c 02 00 0f 85 85 00 00 00 48 8b 93 d8 00 00 00 4d 89 f0 4c 89 e9 48 c7 c6 40 ba a2 8b 48 c7 c7 60 b9 a2 8b e8 33 81 1d ff 90 <0f> 0b 90 90 e9 5f fe ff ff e8 04 69 5e ff 90 48 b8 00 00 00 00 00
RSP: 0018:ffffc90003e5fb08 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88804e6568c0 RCX: ffffffff817a92c8
RDX: ffff88803046da00 RSI: ffffffff817a92d5 RDI: 0000000000000001
RBP: ffff8880353bde80 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff8880353bddc0
R13: ffff8880353bdea4 R14: ffff88802556cae4 R15: dffffc0000000000
FS:  0000555562486500(0000) GS:ffff888124962000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c0024fb070 CR3: 000000006b39a000 CR4: 00000000003526f0
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
RIP: 0033:0x7f239858e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd08ac9b18 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007f23987b5fa0 RCX: 00007f239858e929
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000040000080
RBP: 00007f2398610b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f23987b5fa0 R14: 00007f23987b5fa0 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

