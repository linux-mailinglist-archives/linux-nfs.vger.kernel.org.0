Return-Path: <linux-nfs+bounces-21110-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLsSFEZh7mnQswAAu9opvQ
	(envelope-from <linux-nfs+bounces-21110-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Apr 2026 21:02:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 982AE46ACE3
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Apr 2026 21:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D0793007E1B
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Apr 2026 19:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34E726B75B;
	Sun, 26 Apr 2026 19:02:26 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1903C1DF25C
	for <linux-nfs@vger.kernel.org>; Sun, 26 Apr 2026 19:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777230146; cv=none; b=DI7I5BwWfA4xw6tiv5RQpI0Om+kNn3f0ALohAGYL2Sapp0MniSjmBQP+Rcy+KVyMCOMXKGq4XELXoit4wZwVYcaOMAxK16kdxocvN1pN2j8BpDRCd4BoPJ+5f5XrTODeVyXKDtYdukJ/4u+XPb1wLuIbQeKSUCYLtKDhi9dk0E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777230146; c=relaxed/simple;
	bh=nsnS5kVmgUe4N7BhSfgQjH9V+srJSYQH6F2ZnVDLXqk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=nEwKwrz0a3/kE2LYq2IVCx+sMckPeMOuOOUELV+2AbfnfrrYRsXGoIz0Z+eLcD+6xHefetAnWS2gM/sybCgFDMx2Hz/2EmZGlNvXBvnv5MSQCR5IgFkcOGFsFisMBmWCJAWmz6mhA2fLE7pAVusE9Qh7UDWcKux3bgEc7Avvek0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7dcdeac07b1so12804430a34.3
        for <linux-nfs@vger.kernel.org>; Sun, 26 Apr 2026 12:02:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777230144; x=1777834944;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ApE86KdB73UZze872ESq1+IlKWsMYblfjrS0boasGw=;
        b=P8jPaBK4HY2Wu/5EMxeYC2tg5O3iMCCVY8oDKHzILdqKnWZcfa8JJ80KMPVRMckWCc
         LGifEA6H06DdkygsYwlzwliRQk/Q/LAtk9XUu5xpIN9pCUup7cRD/xkvwsrz34ZSMyXH
         EplbShtlLE40GXxFqfJ00lDRCP/jbztoLT83pGVZdg9euptBlZs2wwTNJYc3tYEWoKX8
         caS/s0U1koMNBWfn+mzjIR0ZinakPohHXqbK0qqQjonI9MqNNT4BUnX4ejlHYFy8lQSY
         BWnVf+bYuG2svB7b4klCAQ/2+F7Wu7ZeCxUrv375Zs03p7AwmSinvmRCZT9Gs4LO1ZkS
         nmvg==
X-Forwarded-Encrypted: i=1; AFNElJ9eplqefqiXZ/XUuIS4FGF+CCGBM31Msv0egoDrjV0MToAqs79byAVYbEOTPO+aRdPAQ6vVBw6349c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnhsNi2fqNMaVnIzzS5oYoOng1Fonh9J32RrR/F+RLVlr5LZnF
	deVAyXDb5GVMRiOnbouG+YsggOPaXCIZ2oQPO1a9n6vpUdtb+rJaH+4VoomizRWyoPZky0UTJUj
	ScIQ7eGYNy4kxWk/TGsT4usy+tVVyRgWCMbja1iXePDS8tggdisxlTX1X1Ns=
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:620:b0:694:a362:4b86 with SMTP id
 006d021491bc7-694a3624ce5mr11481191eaf.22.1777230144106; Sun, 26 Apr 2026
 12:02:24 -0700 (PDT)
Date: Sun, 26 Apr 2026 12:02:24 -0700
In-Reply-To: <20260426-dontcache-v3-0-79eb37da9547@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69ee6140.170a0220.11de9.0011.GAE@google.com>
Subject: [syzbot ci] Re: mm: improve write performance with RWF_DONTCACHE
From: syzbot ci <syzbot+ciecac32dcb1f4d0d7@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axboe@kernel.dk, axelrasmussen@google.com, 
	baohua@kernel.org, brauner@kernel.org, chuck.lever@oracle.com, 
	david@kernel.org, hch@infradead.org, jack@suse.cz, jlayton@kernel.org, 
	kasong@tencent.com, liam.howlett@oracle.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, ljs@kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, mhocko@suse.com, 
	qi.zheng@linux.dev, ritesh.list@gmail.com, rostedt@goodmis.org, 
	rppt@kernel.org, shakeel.butt@linux.dev, snitzer@kernel.org, 
	surenb@google.com, vbabka@kernel.org, viro@zeniv.linux.org.uk, 
	weixugc@google.com, willy@infradead.org, yuanchu@google.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 982AE46ACE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21110-lists,linux-nfs=lfdr.de,ciecac32dcb1f4d0d7];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,kernel.dk,google.com,kernel.org,oracle.com,infradead.org,suse.cz,tencent.com,vger.kernel.org,kvack.org,efficios.com,suse.com,linux.dev,gmail.com,goodmis.org,zeniv.linux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[35];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-nfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlesource.com:url,appspotmail.com:email,syzbot.org:url]

syzbot ci has tested the following series

[v3] mm: improve write performance with RWF_DONTCACHE
https://lore.kernel.org/all/20260426-dontcache-v3-0-79eb37da9547@kernel.org
* [PATCH v3 1/4] mm: add NR_DONTCACHE_DIRTY node page counter
* [PATCH v3 2/4] mm: kick writeback flusher for IOCB_DONTCACHE with targeted dirty tracking
* [PATCH v3 3/4] testing: add nfsd-io-bench NFS server benchmark suite
* [PATCH v3 4/4] testing: add dontcache-bench local filesystem benchmark suite

and found the following issue:
WARNING in __mod_memcg_lruvec_state

Full report is available here:
https://ci.syzbot.org/series/e53aef43-ac7a-4cb7-8714-bb927aaee659

***

WARNING in __mod_memcg_lruvec_state

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      27d128c1cff64c3b8012cc56dd5a1391bb4f1821
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/c10ddd10-bb16-48c2-90fb-3625d3b258aa/config
syz repro: https://ci.syzbot.org/findings/1e8993c1-818b-4ddf-b90b-30f051b3a9d6/syz_repro

------------[ cut here ]------------
__mod_memcg_lruvec_state: missing stat item 21
WARNING: mm/memcontrol.c:911 at __mod_memcg_lruvec_state+0x1f3/0x360 mm/memcontrol.c:911, CPU#0: syz.0.17/5831
Modules linked in:
CPU: 0 UID: 0 PID: 5831 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:__mod_memcg_lruvec_state+0x1fc/0x360 mm/memcontrol.c:911
Code: 00 11 85 c0 74 31 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d e9 95 2e 72 09 cc 48 8d 3d 7d c4 fd 0d 48 c7 c6 5d b4 f5 8d 89 da <67> 48 0f b9 3a eb d5 90 0f 0b 90 eb 90 e8 02 22 fb fe eb c8 48 8d
RSP: 0018:ffffc900039e7520 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000015 RCX: dffffc0000000000
RDX: 0000000000000015 RSI: ffffffff8df5b45d RDI: ffffffff90363d90
RBP: 0000000000000001 R08: ffffffff82388833 R09: ffffffff8e95cd60
R10: dffffc0000000000 R11: fffff940008c3f49 R12: ffff8881026eee80
R13: 00000000000000ff R14: 0000000000000001 R15: ffff888173a80e00
FS:  00007f5f76bca6c0(0000) GS:ffff88818dc95000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d77c624128 CR3: 0000000171fde000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 mod_memcg_lruvec_state+0xa7/0x220 mm/memcontrol.c:941
 mod_lruvec_state mm/memcontrol.c:964 [inline]
 lruvec_stat_mod_folio+0x239/0x3e0 mm/memcontrol.c:984
 folio_account_dirtied mm/page-writeback.c:2634 [inline]
 __folio_mark_dirty+0x633/0xec0 mm/page-writeback.c:2692
 mark_buffer_dirty+0x261/0x410 fs/buffer.c:1110
 block_commit_write+0x15d/0x270 fs/buffer.c:2115
 block_write_end+0x6e/0xb0 fs/buffer.c:2191
 ext4_write_end+0x27d/0xa30 fs/ext4/inode.c:1458
 ext4_da_write_end+0x86/0xcb0 fs/ext4/inode.c:3296
 generic_perform_write+0x620/0x8f0 mm/filemap.c:4350
 ext4_buffered_write_iter+0xcb/0x370 fs/ext4/file.c:316
 ext4_file_write_iter+0x298/0x1bd0 fs/ext4/file.c:-1
 do_iter_readv_writev+0x619/0x8c0 fs/read_write.c:-1
 vfs_writev+0x33c/0x990 fs/read_write.c:1059
 do_pwritev fs/read_write.c:1155 [inline]
 __do_sys_pwritev2 fs/read_write.c:1213 [inline]
 __se_sys_pwritev2+0x184/0x2a0 fs/read_write.c:1204
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5f75d9cdd9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5f76bca028 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
RAX: ffffffffffffffda RBX: 00007f5f76015fa0 RCX: 00007f5f75d9cdd9
RDX: 0000000000000001 RSI: 00002000000001c0 RDI: 0000000000000004
RBP: 00007f5f75e32d69 R08: 0000000000000001 R09: 0000000000000081
R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f5f76016038 R14: 00007f5f76015fa0 R15: 00007fffe7503ad8
 </TASK>
----------------
Code disassembly (best guess):
   0:	00 11                	add    %dl,(%rcx)
   2:	85 c0                	test   %eax,%eax
   4:	74 31                	je     0x37
   6:	48 83 c4 08          	add    $0x8,%rsp
   a:	5b                   	pop    %rbx
   b:	41 5c                	pop    %r12
   d:	41 5d                	pop    %r13
   f:	41 5e                	pop    %r14
  11:	41 5f                	pop    %r15
  13:	5d                   	pop    %rbp
  14:	e9 95 2e 72 09       	jmp    0x9722eae
  19:	cc                   	int3
  1a:	48 8d 3d 7d c4 fd 0d 	lea    0xdfdc47d(%rip),%rdi        # 0xdfdc49e
  21:	48 c7 c6 5d b4 f5 8d 	mov    $0xffffffff8df5b45d,%rsi
  28:	89 da                	mov    %ebx,%edx
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	eb d5                	jmp    0x6
  31:	90                   	nop
  32:	0f 0b                	ud2
  34:	90                   	nop
  35:	eb 90                	jmp    0xffffffc7
  37:	e8 02 22 fb fe       	call   0xfefb223e
  3c:	eb c8                	jmp    0x6
  3e:	48                   	rex.W
  3f:	8d                   	.byte 0x8d


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

To test a patch for this bug, please reply with `#syz test`
(should be on a separate line).

The patch should be attached to the email.
Note: arguments like custom git repos and branches are not supported.

