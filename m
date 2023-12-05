Return-Path: <linux-nfs+bounces-334-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5984E8056E0
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Dec 2023 15:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA17AB20AAA
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Dec 2023 14:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8969161FBD;
	Tue,  5 Dec 2023 14:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MjQ+Jf5E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC46690
	for <linux-nfs@vger.kernel.org>; Tue,  5 Dec 2023 06:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701785486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KxJkSsBedrNuXqcV+NySXJvU0FOTB7EemD88DBz5qUM=;
	b=MjQ+Jf5EqqRdlB5Hzmaf8Ue1tCtQLakj1s6rJtSwQwuuTdfxZkdtEjeLo6rOQU8OoJDcu6
	fOeFDpeHJUIjGAWviIKyDiycUlhh4a+HnDfzdnHiXmUKYnYT2SF2eZGaHGR0VqmRzfISe7
	ltQ2FQtvosU63EhTZUcxGrnrT31GkaU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-RdFvgVRBN6S-zznDywziXQ-1; Tue,
 05 Dec 2023 09:10:56 -0500
X-MC-Unique: RdFvgVRBN6S-zznDywziXQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CADBD3C28657;
	Tue,  5 Dec 2023 14:10:55 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.32.220])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A3332166B31;
	Tue,  5 Dec 2023 14:10:55 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 039E2EB05D;
	Tue,  5 Dec 2023 09:10:55 -0500 (EST)
From: Scott Mayhew <smayhew@redhat.com>
To: trond.myklebust@hammerspace.com,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH RFC 0/1] Use parent's objective cred in nfs_access_login_time()
Date: Tue,  5 Dec 2023 09:10:53 -0500
Message-ID: <20231205141054.1759563-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

We have a customer occasionally hitting a panic in cred_fscmp():

crash> bt
PID: 564685   TASK: ffff8a3016c2d8c0  CPU: 39   COMMAND: "ifind"
 #0 [ffffa8548626b850] machine_kexec at ffffffffa3a77497
 #1 [ffffa8548626b8a8] __crash_kexec at ffffffffa3bec25a
 #2 [ffffa8548626b968] crash_kexec at ffffffffa3bed4e8
 #3 [ffffa8548626b970] oops_end at ffffffffa3a2e8ab
 #4 [ffffa8548626b990] exc_general_protection at ffffffffa465ed6c
 #5 [ffffa8548626ba30] asm_exc_general_protection at ffffffffa4800ac2
    [exception RIP: cred_fscmp+0x53]
    RIP: ffffffffa3b3b4e3  RSP: ffffa8548626bae0  RFLAGS: 00010286
    RAX: 0000000000000001  RBX: ffff8ab810ba19c0  RCX: ffffffffa565ed90
    RDX: 6b6b6b6b6b6b6b6b  RSI: ffff8ab810ba19c0  RDI: ffff8a25a2c5b940
    RBP: ffff8a28290976e8   R8: 0000000000000050   R9: 0000000000000013
    R10: ffff8a84d3734400  R11: ffff8a840c5a78c8  R12: ffffa8548626bb80
    R13: 0000000000000081  R14: ffff8a1e00b91dc0  R15: ffff8a1e41229dc0
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #6 [ffffa8548626bae0] nfs_access_get_cached at ffffffffc172f198 [nfs]
 #7 [ffffa8548626bb30] nfs_do_access at ffffffffc172fedf [nfs]
 #8 [ffffa8548626bbc8] nfs_permission at ffffffffc17301f3 [nfs]
 #9 [ffffa8548626bbf0] inode_permission at ffffffffa3e32410
#10 [ffffa8548626bc20] link_path_walk at ffffffffa3e37426
#11 [ffffa8548626bc80] path_lookupat at ffffffffa3e37b0e
#12 [ffffa8548626bcb8] filename_lookup at ffffffffa3e38f2f
#13 [ffffa8548626bdd8] vfs_statx at ffffffffa3e2ad9d
#14 [ffffa8548626be30] vfs_fstatat at ffffffffa3e2b1b4
#15 [ffffa8548626be58] __do_sys_newlstat at ffffffffa3e2b523
#16 [ffffa8548626bf10] do_syscall_64 at ffffffffa465e18c
#17 [ffffa8548626bf50] entry_SYSCALL_64_after_hwframe at ffffffffa48000aa
    RIP: 00007f592f74ef5a  RSP: 00007f59242eeae8  RFLAGS: 00000246
    RAX: ffffffffffffffda  RBX: 00007f59242eedf0  RCX: 00007f592f74ef5a
    RDX: 00007f59242eedf0  RSI: 00007f59242eedf0  RDI: 00007f58d89812d0
    RBP: 00007f59242eebb0   R8: 0000000000000001   R9: 00007f58d8983c90
    R10: 0000000000000004  R11: 0000000000000246  R12: 00007f58d81101c0
    R13: 00007f59242eedf0  R14: 00007f59242efb08  R15: 0000000000000000
    ORIG_RAX: 0000000000000006  CS: 0033  SS: 002b

The instruction we crashed on was:
/usr/src/debug/kernel-5.14.0-378.el9/linux-5.14.0-378.el9.x86_64/kernel/cred.c: 651
0xffffffffa3b3b4e3 <cred_fscmp+0x53>:   movslq 0x4(%rdx),%rsi

We were trying to access group_info->ngroups:
crash> group_info.ngroups -o
struct group_info {
  [0x4] int ngroups;
}

But RDX has POISON_FREE instead of the address of a struct group_info.

RDX was populated slightly earlier:
/usr/src/debug/kernel-5.14.0-378.el9/linux-5.14.0-378.el9.x86_64/kernel/cred.c: 640
0xffffffffa3b3b4bf <cred_fscmp+0x2f>:   mov    $0x1,%eax
0xffffffffa3b3b4c4 <cred_fscmp+0x34>:   jb     0xffffffffa3b3b524 <cred_fscmp+0x94>
0xffffffffa3b3b4c6 <cred_fscmp+0x36>:   mov    0x98(%rdi),%rdx <----- HERE
0xffffffffa3b3b4cd <cred_fscmp+0x3d>:   mov    0x98(%rsi),%rcx

So RDI has the address of the struct cred we were comparing:
crash> cred.group_info -o
struct cred {
  [0x98] struct group_info *group_info;
}

Looking at the disassembly of nfs_access_get_cached to see how RDI gets populated:

/usr/src/debug/kernel-5.14.0-378.el9/linux-5.14.0-378.el9.x86_64/fs/nfs/dir.c: 2965
0xffffffffc172f19c <nfs_access_get_cached+0x3c>:        mov    %r14,%r15
0xffffffffc172f19f <nfs_access_get_cached+0x3f>:        mov    0xae8(%r14),%r14 <----- parent
/usr/src/debug/kernel-5.14.0-378.el9/linux-5.14.0-378.el9.x86_64/fs/nfs/dir.c: 2966
0xffffffffc172f1a6 <nfs_access_get_cached+0x46>:        mov    0xcd8(%r14),%rdi <----- parent's cred

So R15 has the address of a task_struct, R14 has the address of its parent task_struct, and RDI has the cred from the parent's task_struct.

crash> task_struct.real_parent -o
struct task_struct {
   [0xae8] struct task_struct *real_parent;
}
crash> task_struct.cred -o
struct task_struct {
   [0xcd8] const struct cred *cred;
}

Looking at the parent of the panic task:

crash> task -R real_parent ffff8a3016c2d8c0
PID: 564685   TASK: ffff8a3016c2d8c0  CPU: 39   COMMAND: "ifind"
  real_parent = 0xffff8a1e41229dc0,

That matches the value in R15 in the exception frame, so we need to look at the next parent:

crash> task -R real_parent 0xffff8a1e41229dc0
PID: 2083     TASK: ffff8a1e41229dc0  CPU: 19   COMMAND: "cvlaunchd"
  real_parent = 0xffff8a1e00b91dc0,

That matches the value in R14 in the exception frame, so let's look at the cred:

crash> task -R cred 0xffff8a1e00b91dc0
PID: 1        TASK: ffff8a1e00b91dc0  CPU: 4    COMMAND: "systemd"
  cred = 0xffff8acc795371c0,

That does NOT match the value in RDI in the exception frame.

The value in RDI is indeed a struct cred, but contrast its refcount

crash> cred.usage ffff8a25a2c5b940
  usage = {
    counter = 0x3
  },
  
with the refcount of the actual cred

crash> cred.usage 0xffff8acc795371c0
  usage = {
    counter = 0xad
  },

It appears that the cred in RDI was freed,  possibly via:

do_faccessat()
  old_cred = access_override_creds();
    override_cred->non_rcu = 1;
  ...
  revert_creds(old_cred);
    put_cred(override);
      __put_cred
        if (cred->non_rcu)
          put_cred_rcu(&cred->rcu);

and subsequently re-used.

Note in particular this comment in access_override_creds():

        /*
         * The new set of credentials can *only* be used in
         * task-synchronous circumstances, and does not need
         * RCU freeing, unless somebody then takes a separate
         * reference to it.
         *
         * NOTE! This is _only_ true because this credential
         * is used purely for override_creds() that installs
         * it as the subjective cred. Other threads will be
         * accessing ->real_cred, not the subjective cred.
         *
         * If somebody _does_ make a copy of this (using the
         * 'get_current_cred()' function), that will clear the
         * non_rcu field, because now that other user may be
         * expecting RCU freeing. But normal thread-synchronous
         * cred accesses will keep things non-RCY.
         */

So it seems that nfs_access_login_time() should be using parent->real_cred.

-Scott

Scott Mayhew (1):
  NFS: Use parent's objective cred in nfs_access_login_time()

 fs/nfs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.41.0


