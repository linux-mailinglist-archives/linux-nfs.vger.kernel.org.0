Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4675975A0B8
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jul 2023 23:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjGSVtE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jul 2023 17:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGSVtD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Jul 2023 17:49:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4332A1FD9
        for <linux-nfs@vger.kernel.org>; Wed, 19 Jul 2023 14:49:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3B9761844
        for <linux-nfs@vger.kernel.org>; Wed, 19 Jul 2023 21:49:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC954C433C7;
        Wed, 19 Jul 2023 21:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689803341;
        bh=dYyueskDOBj/F2mggU5PAwXSTaw+f/CVyA4AYKAPbB4=;
        h=Subject:From:To:Cc:Date:From;
        b=GHLonHwgVnrolXcnTYkU2cJGZcYBZhKHcacgBO6ggIwPTQlHAQLWO2J/CwS9lHwiS
         uetJ4hoBkDorqiBa/V+0u0z+ppycONw2T/h4rALcqsIrWox299adjwLveYa1MlLAk5
         CfQxCdn6XqP0hNoVuZKXSVUGVRIkKQpDW1BpP0AbRJ25Q1AjWAfy/aE+atDjmcwNXI
         Or01bygIyGHKIiJG3cllCSP87tcR2HYKJyzTgNvv+FSwE+EB1mTpilqmJct1RoOm0R
         BOTXMQGI4Cop91W9hqe9SZkEKtffRkDQCStodL7PPfnpYDEwCTcnHlbim+JIBG1JsG
         ZI2Nv3m4Ql/9Q==
Message-ID: <554d3bcc05c2e1e3624607c9fa543d6aea4cfadb.camel@kernel.org>
Subject: oops in nfsd-next branch
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Date:   Wed, 19 Jul 2023 17:48:59 -0400
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,

While doing some testing today with pynfs on a branch based on your
nfsd-next branch. I'm not sure which test triggers it, but it's one of
the v4.0 tests. It only takes a few mins before it crashes:

Jul 19 19:22:43 kdevops-nfsd kernel: BUG: unable to handle page fault for a=
ddress: ffffd8442d049108
Jul 19 19:22:43 kdevops-nfsd kernel: #PF: supervisor read access in kernel =
mode
Jul 19 19:22:43 kdevops-nfsd kernel: #PF: error_code(0x0000) - not-present =
page
Jul 19 19:22:43 kdevops-nfsd kernel: PGD 0 P4D 0=20
Jul 19 19:22:43 kdevops-nfsd kernel: Oops: 0000 [#1] PREEMPT SMP PTI
Jul 19 19:22:43 kdevops-nfsd kernel: CPU: 0 PID: 743 Comm: nfsd Not tainted=
 6.5.0-rc2+ #19
Jul 19 19:22:43 kdevops-nfsd kernel: Hardware name: QEMU Standard PC (Q35 +=
 ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
Jul 19 19:22:43 kdevops-nfsd kernel: RIP: 0010:kfree+0x4b/0x110
Jul 19 19:22:43 kdevops-nfsd kernel: Code: 80 48 01 d8 0f 82 d8 00 00 00 48=
 c7 c2 00 00 00 80 48 2b 15 9f d7 fb 00 48 01 d0 48 c1 e8 0c 48 c1 e0 06 48=
 03 05 7d d7 fb 00 <48> 8b 50 08 48 89 c7 f6 c2 01 0f 85 9f 00 00 >
Jul 19 19:22:43 kdevops-nfsd kernel: RSP: 0018:ffffb0858661bdc0 EFLAGS: 000=
10286
Jul 19 19:22:43 kdevops-nfsd kernel: RAX: ffffd8442d049100 RBX: 00000000812=
44052 RCX: ffff8a665e003008
Jul 19 19:22:43 kdevops-nfsd kernel: RDX: 0000759a40000000 RSI: ffffffffc0b=
13a45 RDI: 0000000081244052
Jul 19 19:22:43 kdevops-nfsd kernel: RBP: ffffb0858661be40 R08: ffff8a665e0=
03008 R09: ffffffff8ebdc4ec
Jul 19 19:22:43 kdevops-nfsd kernel: R10: 000000000000000e R11: 00000000000=
0001b R12: ffff8a6656f20150
Jul 19 19:22:43 kdevops-nfsd kernel: R13: ffff8a665e003008 R14: ffff8a6656f=
20100 R15: ffff8a6656f20980
Jul 19 19:22:43 kdevops-nfsd kernel: FS:  0000000000000000(0000) GS:ffff8a6=
7bfc00000(0000) knlGS:0000000000000000
Jul 19 19:22:43 kdevops-nfsd kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000=
00080050033
Jul 19 19:22:43 kdevops-nfsd kernel: CR2: ffffd8442d049108 CR3: 0000000277e=
1a001 CR4: 0000000000060ef0
Jul 19 19:22:43 kdevops-nfsd kernel: Call Trace:
Jul 19 19:22:43 kdevops-nfsd kernel:  <TASK>
Jul 19 19:22:43 kdevops-nfsd kernel:  ? __die+0x1f/0x70
Jul 19 19:22:43 kdevops-nfsd kernel:  ? page_fault_oops+0x159/0x450
Jul 19 19:22:43 kdevops-nfsd kernel:  ? fixup_exception+0x22/0x310
Jul 19 19:22:43 kdevops-nfsd kernel:  ? exc_page_fault+0x157/0x180
Jul 19 19:22:43 kdevops-nfsd kernel:  ? asm_exc_page_fault+0x22/0x30
Jul 19 19:22:43 kdevops-nfsd kernel:  ? nfsd_cache_lookup+0x3c5/0x770 [nfsd=
]
Jul 19 19:22:43 kdevops-nfsd kernel:  ? kfree+0x4b/0x110
Jul 19 19:22:43 kdevops-nfsd kernel:  nfsd_cache_lookup+0x3c5/0x770 [nfsd]
Jul 19 19:22:43 kdevops-nfsd kernel:  ? __pfx_nfsd+0x10/0x10 [nfsd]
Jul 19 19:22:43 kdevops-nfsd kernel:  nfsd_dispatch+0x62/0x1b0 [nfsd]
Jul 19 19:22:43 kdevops-nfsd kernel:  svc_process_common+0x3cb/0x6c0 [sunrp=
c]
Jul 19 19:22:43 kdevops-nfsd kernel:  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd=
]
Jul 19 19:22:43 kdevops-nfsd kernel:  ? __pfx_nfsd+0x10/0x10 [nfsd]
Jul 19 19:22:43 kdevops-nfsd kernel:  svc_process+0x12d/0x170 [sunrpc]
Jul 19 19:22:43 kdevops-nfsd kernel:  nfsd+0xd5/0x1a0 [nfsd]
Jul 19 19:22:43 kdevops-nfsd kernel:  kthread+0xf3/0x120
Jul 19 19:22:43 kdevops-nfsd kernel:  ? __pfx_kthread+0x10/0x10
Jul 19 19:22:43 kdevops-nfsd kernel:  ret_from_fork+0x30/0x50
Jul 19 19:22:43 kdevops-nfsd kernel:  ? __pfx_kthread+0x10/0x10
Jul 19 19:22:43 kdevops-nfsd kernel:  ret_from_fork_asm+0x1b/0x30
Jul 19 19:22:43 kdevops-nfsd kernel: RIP: 0000:0x0
Jul 19 19:22:43 kdevops-nfsd kernel: Code: Unable to access opcode bytes at=
 0xffffffffffffffd6.
Jul 19 19:22:43 kdevops-nfsd kernel: RSP: 0000:0000000000000000 EFLAGS: 000=
00000 ORIG_RAX: 0000000000000000
Jul 19 19:22:43 kdevops-nfsd kernel: RAX: 0000000000000000 RBX: 00000000000=
00000 RCX: 0000000000000000
Jul 19 19:22:43 kdevops-nfsd kernel: RDX: 0000000000000000 RSI: 00000000000=
00000 RDI: 0000000000000000
Jul 19 19:22:43 kdevops-nfsd kernel: RBP: 0000000000000000 R08: 00000000000=
00000 R09: 0000000000000000
Jul 19 19:22:43 kdevops-nfsd kernel: R10: 0000000000000000 R11: 00000000000=
00000 R12: 0000000000000000
Jul 19 19:22:43 kdevops-nfsd kernel: R13: 0000000000000000 R14: 00000000000=
00000 R15: 0000000000000000
Jul 19 19:22:43 kdevops-nfsd kernel:  </TASK>
Jul 19 19:22:43 kdevops-nfsd kernel: Modules linked in: 9p netfs nls_iso885=
9_1 nls_cp437 vfat fat kvm_intel joydev kvm cirrus psmouse drm_shmem_helper=
 irqbypass pcspkr virtio_net net_failover failover virtio_balloon >
Jul 19 19:22:43 kdevops-nfsd kernel: CR2: ffffd8442d049108
Jul 19 19:22:43 kdevops-nfsd kernel: ---[ end trace 0000000000000000 ]---
Jul 19 19:22:43 kdevops-nfsd kernel: RIP: 0010:kfree+0x4b/0x110
Jul 19 19:22:43 kdevops-nfsd kernel: Code: 80 48 01 d8 0f 82 d8 00 00 00 48=
 c7 c2 00 00 00 80 48 2b 15 9f d7 fb 00 48 01 d0 48 c1 e8 0c 48 c1 e0 06 48=
 03 05 7d d7 fb 00 <48> 8b 50 08 48 89 c7 f6 c2 01 0f 85 9f 00 00 >
Jul 19 19:22:43 kdevops-nfsd kernel: RSP: 0018:ffffb0858661bdc0 EFLAGS: 000=
10286
Jul 19 19:22:43 kdevops-nfsd kernel: RAX: ffffd8442d049100 RBX: 00000000812=
44052 RCX: ffff8a665e003008
Jul 19 19:22:43 kdevops-nfsd kernel: RDX: 0000759a40000000 RSI: ffffffffc0b=
13a45 RDI: 0000000081244052
Jul 19 19:22:43 kdevops-nfsd kernel: RBP: ffffb0858661be40 R08: ffff8a665e0=
03008 R09: ffffffff8ebdc4ec
Jul 19 19:22:43 kdevops-nfsd kernel: R10: 000000000000000e R11: 00000000000=
0001b R12: ffff8a6656f20150
Jul 19 19:22:43 kdevops-nfsd kernel: R13: ffff8a665e003008 R14: ffff8a6656f=
20100 R15: ffff8a6656f20980
Jul 19 19:22:43 kdevops-nfsd kernel: FS:  0000000000000000(0000) GS:ffff8a6=
7bfc00000(0000) knlGS:0000000000000000
Jul 19 19:22:43 kdevops-nfsd kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000=
00080050033
Jul 19 19:22:43 kdevops-nfsd kernel: CR2: ffffffffffffffd6 CR3: 0000000277e=
1a001 CR4: 0000000000060ef0
Jul 19 19:22:43 kdevops-nfsd kernel: note: nfsd[743] exited with irqs disab=
led
Jul 19 19:22:43 kdevops-nfsd kernel: note: nfsd[743] exited with preempt_co=
unt 1

faddr2line says:

$ ./scripts/faddr2line --list fs/nfsd/nfsd.ko nfsd_cache_lookup+0x3c5/0x770
nfsd_cacherep_free at /home/jlayton/git/kdevops/linux/fs/nfsd/nfscache.c:11=
6
 111 	}
 112 =09
 113 	static void nfsd_cacherep_free(struct nfsd_cacherep *rp)
 114 	{
 115 		kfree(rp->c_replvec.iov_base);
>116<		kmem_cache_free(drc_slab, rp);
 117 	}
 118 =09
 119 	static unsigned long
 120 	nfsd_cacherep_dispose(struct list_head *dispose)
 121 	{

(inlined by) nfsd_reply_cache_free_locked at /home/jlayton/git/kdevops/linu=
x/fs/nfsd/nfscache.c:153
 148 	static void
 149 	nfsd_reply_cache_free_locked(struct nfsd_drc_bucket *b, struct nfsd_c=
acherep *rp,
 150 					struct nfsd_net *nn)
 151 	{
 152 		nfsd_cacherep_unlink_locked(nn, b, rp);
>153<		nfsd_cacherep_free(rp);
 154 	}
 155 =09
 156 	static void
 157 	nfsd_reply_cache_free(struct nfsd_drc_bucket *b, struct nfsd_cacherep=
 *rp,
 158 				struct nfsd_net *nn)

(inlined by) nfsd_cache_lookup at /home/jlayton/git/kdevops/linux/fs/nfsd/n=
fscache.c:527
 522 		nfsd_stats_drc_mem_usage_add(nn, sizeof(*rp));
 523 		goto out;
 524 =09
 525 	found_entry:
 526 		/* We found a matching entry which is either in progress or done. */
>527<		nfsd_reply_cache_free_locked(NULL, rp, nn);
 528 		nfsd_stats_rc_hits_inc();
 529 		rtn =3D RC_DROPIT;
 530 		rp =3D found;
 531 =09
 532 		/* Request being processed */


...and a bisect landed here:


767b1d5badd6eb418e3f91f0cd8fa6d2894ff43a is the first bad commit
commit 767b1d5badd6eb418e3f91f0cd8fa6d2894ff43a
Author: Chuck Lever <chuck.lever@oracle.com>
Date:   Sun Jul 9 11:45:16 2023 -0400

    NFSD: Refactor nfsd_reply_cache_free_locked()
   =20
    To reduce contention on the bucket locks, we must avoid calling
    kfree() while each bucket lock is held.
   =20
    Start by refactoring nfsd_reply_cache_free_locked() into a helper
    that removes an entry from the bucket (and must therefore run under
    the lock) and a second helper that frees the entry (which does not
    need to hold the lock).
   =20
    For readability, rename the helpers nfsd_cacherep_<verb>.
   =20
    Reviewed-by: Jeff Layton <jlayton@kernel.org>
    Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

 fs/nfsd/nfscache.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

--=20
Jeff Layton <jlayton@kernel.org>
