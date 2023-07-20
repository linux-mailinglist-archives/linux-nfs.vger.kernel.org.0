Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2607475B150
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jul 2023 16:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjGTOdN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jul 2023 10:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjGTOdM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Jul 2023 10:33:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507E0C6
        for <linux-nfs@vger.kernel.org>; Thu, 20 Jul 2023 07:33:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB30C61B05
        for <linux-nfs@vger.kernel.org>; Thu, 20 Jul 2023 14:33:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE1FC433C7;
        Thu, 20 Jul 2023 14:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689863590;
        bh=7wW52HVaiYbnpXYFxr7kG0bv3DN8oHcTCVmAmc12GJk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RuncUQio4jmlHJagA9QfAS0vr8ux0nton927YDEUxjEOUm7CEquYogDnvf6Z32Ru5
         lp1GzIKMyu4EToJWDownMVuEmLY0J8wXkDGhkePbZz3KrqMkzkCzz5UM8RkkOGQ/WN
         uw+IvfJSdc/1jkivVAg6qFVPS5DzhKxxgbi1wCvMYafkX6y+95Xrs2SCW9TESk/3hn
         ooaFDU5dISmcM/CH30f1e5svkcwqbkLROPfiWRFH8591+HWfMXHpSVexY2iQHGh35T
         djNzAsV7cAqhmGr4fhb6nPOOmjQvDrz4Pi96LuN3s8iUazNe1EVeuAhBSVP3mRboxK
         Bo2Aqb2oLYoJw==
Message-ID: <13c2e48545cec75980ad1f16dde18ccddf75c2f1.camel@kernel.org>
Subject: Re: oops in nfsd-next branch
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Thu, 20 Jul 2023 10:33:08 -0400
In-Reply-To: <E9A71D57-83DE-4E04-8CB8-073244B88392@oracle.com>
References: <554d3bcc05c2e1e3624607c9fa543d6aea4cfadb.camel@kernel.org>
         <E9A71D57-83DE-4E04-8CB8-073244B88392@oracle.com>
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

On Wed, 2023-07-19 at 23:46 +0000, Chuck Lever III wrote:
>=20
> > On Jul 19, 2023, at 5:48 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > Hi Chuck,
> >=20
> > While doing some testing today with pynfs on a branch based on your
> > nfsd-next branch. I'm not sure which test triggers it, but it's one of
> > the v4.0 tests.
>=20
> I've just started running pynfs on nfsd-next, haven't seen any
> crashes so far. I'll take a dive in tomorrow.
>=20
>=20
> > It only takes a few mins before it crashes:
> >=20
> > Jul 19 19:22:43 kdevops-nfsd kernel: BUG: unable to handle page fault f=
or address: ffffd8442d049108
> > Jul 19 19:22:43 kdevops-nfsd kernel: #PF: supervisor read access in ker=
nel mode
> > Jul 19 19:22:43 kdevops-nfsd kernel: #PF: error_code(0x0000) - not-pres=
ent page
> > Jul 19 19:22:43 kdevops-nfsd kernel: PGD 0 P4D 0=20
> > Jul 19 19:22:43 kdevops-nfsd kernel: Oops: 0000 [#1] PREEMPT SMP PTI
> > Jul 19 19:22:43 kdevops-nfsd kernel: CPU: 0 PID: 743 Comm: nfsd Not tai=
nted 6.5.0-rc2+ #19
> > Jul 19 19:22:43 kdevops-nfsd kernel: Hardware name: QEMU Standard PC (Q=
35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
> > Jul 19 19:22:43 kdevops-nfsd kernel: RIP: 0010:kfree+0x4b/0x110
> > Jul 19 19:22:43 kdevops-nfsd kernel: Code: 80 48 01 d8 0f 82 d8 00 00 0=
0 48 c7 c2 00 00 00 80 48 2b 15 9f d7 fb 00 48 01 d0 48 c1 e8 0c 48 c1 e0 0=
6 48 03 05 7d d7 fb 00 <48> 8b 50 08 48 89 c7 f6 c2 01 0f 85 9f 00 00 >
> > Jul 19 19:22:43 kdevops-nfsd kernel: RSP: 0018:ffffb0858661bdc0 EFLAGS:=
 00010286
> > Jul 19 19:22:43 kdevops-nfsd kernel: RAX: ffffd8442d049100 RBX: 0000000=
081244052 RCX: ffff8a665e003008
> > Jul 19 19:22:43 kdevops-nfsd kernel: RDX: 0000759a40000000 RSI: fffffff=
fc0b13a45 RDI: 0000000081244052
> > Jul 19 19:22:43 kdevops-nfsd kernel: RBP: ffffb0858661be40 R08: ffff8a6=
65e003008 R09: ffffffff8ebdc4ec
> > Jul 19 19:22:43 kdevops-nfsd kernel: R10: 000000000000000e R11: 0000000=
00000001b R12: ffff8a6656f20150
> > Jul 19 19:22:43 kdevops-nfsd kernel: R13: ffff8a665e003008 R14: ffff8a6=
656f20100 R15: ffff8a6656f20980
> > Jul 19 19:22:43 kdevops-nfsd kernel: FS:  0000000000000000(0000) GS:fff=
f8a67bfc00000(0000) knlGS:0000000000000000
> > Jul 19 19:22:43 kdevops-nfsd kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0=
000000080050033
> > Jul 19 19:22:43 kdevops-nfsd kernel: CR2: ffffd8442d049108 CR3: 0000000=
277e1a001 CR4: 0000000000060ef0
> > Jul 19 19:22:43 kdevops-nfsd kernel: Call Trace:
> > Jul 19 19:22:43 kdevops-nfsd kernel:  <TASK>
> > Jul 19 19:22:43 kdevops-nfsd kernel:  ? __die+0x1f/0x70
> > Jul 19 19:22:43 kdevops-nfsd kernel:  ? page_fault_oops+0x159/0x450
> > Jul 19 19:22:43 kdevops-nfsd kernel:  ? fixup_exception+0x22/0x310
> > Jul 19 19:22:43 kdevops-nfsd kernel:  ? exc_page_fault+0x157/0x180
> > Jul 19 19:22:43 kdevops-nfsd kernel:  ? asm_exc_page_fault+0x22/0x30
> > Jul 19 19:22:43 kdevops-nfsd kernel:  ? nfsd_cache_lookup+0x3c5/0x770 [=
nfsd]
> > Jul 19 19:22:43 kdevops-nfsd kernel:  ? kfree+0x4b/0x110
> > Jul 19 19:22:43 kdevops-nfsd kernel:  nfsd_cache_lookup+0x3c5/0x770 [nf=
sd]
> > Jul 19 19:22:43 kdevops-nfsd kernel:  ? __pfx_nfsd+0x10/0x10 [nfsd]
> > Jul 19 19:22:43 kdevops-nfsd kernel:  nfsd_dispatch+0x62/0x1b0 [nfsd]
> > Jul 19 19:22:43 kdevops-nfsd kernel:  svc_process_common+0x3cb/0x6c0 [s=
unrpc]
> > Jul 19 19:22:43 kdevops-nfsd kernel:  ? __pfx_nfsd_dispatch+0x10/0x10 [=
nfsd]
> > Jul 19 19:22:43 kdevops-nfsd kernel:  ? __pfx_nfsd+0x10/0x10 [nfsd]
> > Jul 19 19:22:43 kdevops-nfsd kernel:  svc_process+0x12d/0x170 [sunrpc]
> > Jul 19 19:22:43 kdevops-nfsd kernel:  nfsd+0xd5/0x1a0 [nfsd]
> > Jul 19 19:22:43 kdevops-nfsd kernel:  kthread+0xf3/0x120
> > Jul 19 19:22:43 kdevops-nfsd kernel:  ? __pfx_kthread+0x10/0x10
> > Jul 19 19:22:43 kdevops-nfsd kernel:  ret_from_fork+0x30/0x50
> > Jul 19 19:22:43 kdevops-nfsd kernel:  ? __pfx_kthread+0x10/0x10
> > Jul 19 19:22:43 kdevops-nfsd kernel:  ret_from_fork_asm+0x1b/0x30
> > Jul 19 19:22:43 kdevops-nfsd kernel: RIP: 0000:0x0
> > Jul 19 19:22:43 kdevops-nfsd kernel: Code: Unable to access opcode byte=
s at 0xffffffffffffffd6.
> > Jul 19 19:22:43 kdevops-nfsd kernel: RSP: 0000:0000000000000000 EFLAGS:=
 00000000 ORIG_RAX: 0000000000000000
> > Jul 19 19:22:43 kdevops-nfsd kernel: RAX: 0000000000000000 RBX: 0000000=
000000000 RCX: 0000000000000000
> > Jul 19 19:22:43 kdevops-nfsd kernel: RDX: 0000000000000000 RSI: 0000000=
000000000 RDI: 0000000000000000
> > Jul 19 19:22:43 kdevops-nfsd kernel: RBP: 0000000000000000 R08: 0000000=
000000000 R09: 0000000000000000
> > Jul 19 19:22:43 kdevops-nfsd kernel: R10: 0000000000000000 R11: 0000000=
000000000 R12: 0000000000000000
> > Jul 19 19:22:43 kdevops-nfsd kernel: R13: 0000000000000000 R14: 0000000=
000000000 R15: 0000000000000000
> > Jul 19 19:22:43 kdevops-nfsd kernel:  </TASK>
> > Jul 19 19:22:43 kdevops-nfsd kernel: Modules linked in: 9p netfs nls_is=
o8859_1 nls_cp437 vfat fat kvm_intel joydev kvm cirrus psmouse drm_shmem_he=
lper irqbypass pcspkr virtio_net net_failover failover virtio_balloon >
> > Jul 19 19:22:43 kdevops-nfsd kernel: CR2: ffffd8442d049108
> > Jul 19 19:22:43 kdevops-nfsd kernel: ---[ end trace 0000000000000000 ]-=
--
> > Jul 19 19:22:43 kdevops-nfsd kernel: RIP: 0010:kfree+0x4b/0x110
> > Jul 19 19:22:43 kdevops-nfsd kernel: Code: 80 48 01 d8 0f 82 d8 00 00 0=
0 48 c7 c2 00 00 00 80 48 2b 15 9f d7 fb 00 48 01 d0 48 c1 e8 0c 48 c1 e0 0=
6 48 03 05 7d d7 fb 00 <48> 8b 50 08 48 89 c7 f6 c2 01 0f 85 9f 00 00 >
> > Jul 19 19:22:43 kdevops-nfsd kernel: RSP: 0018:ffffb0858661bdc0 EFLAGS:=
 00010286
> > Jul 19 19:22:43 kdevops-nfsd kernel: RAX: ffffd8442d049100 RBX: 0000000=
081244052 RCX: ffff8a665e003008
> > Jul 19 19:22:43 kdevops-nfsd kernel: RDX: 0000759a40000000 RSI: fffffff=
fc0b13a45 RDI: 0000000081244052
> > Jul 19 19:22:43 kdevops-nfsd kernel: RBP: ffffb0858661be40 R08: ffff8a6=
65e003008 R09: ffffffff8ebdc4ec
> > Jul 19 19:22:43 kdevops-nfsd kernel: R10: 000000000000000e R11: 0000000=
00000001b R12: ffff8a6656f20150
> > Jul 19 19:22:43 kdevops-nfsd kernel: R13: ffff8a665e003008 R14: ffff8a6=
656f20100 R15: ffff8a6656f20980
> > Jul 19 19:22:43 kdevops-nfsd kernel: FS:  0000000000000000(0000) GS:fff=
f8a67bfc00000(0000) knlGS:0000000000000000
> > Jul 19 19:22:43 kdevops-nfsd kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0=
000000080050033
> > Jul 19 19:22:43 kdevops-nfsd kernel: CR2: ffffffffffffffd6 CR3: 0000000=
277e1a001 CR4: 0000000000060ef0
> > Jul 19 19:22:43 kdevops-nfsd kernel: note: nfsd[743] exited with irqs d=
isabled
> > Jul 19 19:22:43 kdevops-nfsd kernel: note: nfsd[743] exited with preemp=
t_count 1
> >=20
> > faddr2line says:
> >=20
> > $ ./scripts/faddr2line --list fs/nfsd/nfsd.ko nfsd_cache_lookup+0x3c5/0=
x770
> > nfsd_cacherep_free at /home/jlayton/git/kdevops/linux/fs/nfsd/nfscache.=
c:116
> > 111 }
> > 112=20
> > 113 static void nfsd_cacherep_free(struct nfsd_cacherep *rp)
> > 114 {
> > 115 kfree(rp->c_replvec.iov_base);
> > > 116< kmem_cache_free(drc_slab, rp);
> > 117 }
> > 118=20
> > 119 static unsigned long
> > 120 nfsd_cacherep_dispose(struct list_head *dispose)
> > 121 {
> >=20
> > (inlined by) nfsd_reply_cache_free_locked at /home/jlayton/git/kdevops/=
linux/fs/nfsd/nfscache.c:153
> > 148 static void
> > 149 nfsd_reply_cache_free_locked(struct nfsd_drc_bucket *b, struct nfsd=
_cacherep *rp,
> > 150 struct nfsd_net *nn)
> > 151 {
> > 152 nfsd_cacherep_unlink_locked(nn, b, rp);
> > > 153< nfsd_cacherep_free(rp);
> > 154 }
> > 155=20
> > 156 static void
> > 157 nfsd_reply_cache_free(struct nfsd_drc_bucket *b, struct nfsd_cacher=
ep *rp,
> > 158 struct nfsd_net *nn)
> >=20
> > (inlined by) nfsd_cache_lookup at /home/jlayton/git/kdevops/linux/fs/nf=
sd/nfscache.c:527
> > 522 nfsd_stats_drc_mem_usage_add(nn, sizeof(*rp));
> > 523 goto out;
> > 524=20
> > 525 found_entry:
> > 526 /* We found a matching entry which is either in progress or done. *=
/
> > > 527< nfsd_reply_cache_free_locked(NULL, rp, nn);
> > 528 nfsd_stats_rc_hits_inc();
> > 529 rtn =3D RC_DROPIT;
> > 530 rp =3D found;
> > 531=20
> > 532 /* Request being processed */
> >=20
> >=20
> > ...and a bisect landed here:
> >=20
> >=20
> > 767b1d5badd6eb418e3f91f0cd8fa6d2894ff43a is the first bad commit
> > commit 767b1d5badd6eb418e3f91f0cd8fa6d2894ff43a
> > Author: Chuck Lever <chuck.lever@oracle.com>
> > Date:   Sun Jul 9 11:45:16 2023 -0400
> >=20
> >    NFSD: Refactor nfsd_reply_cache_free_locked()
> >=20
> >    To reduce contention on the bucket locks, we must avoid calling
> >    kfree() while each bucket lock is held.
> >=20
> >    Start by refactoring nfsd_reply_cache_free_locked() into a helper
> >    that removes an entry from the bucket (and must therefore run under
> >    the lock) and a second helper that frees the entry (which does not
> >    need to hold the lock).
> >=20
> >    For readability, rename the helpers nfsd_cacherep_<verb>.
> >=20
> >    Reviewed-by: Jeff Layton <jlayton@kernel.org>
> >    Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >=20
> > fs/nfsd/nfscache.c | 26 +++++++++++++++++++-------
> > 1 file changed, 19 insertions(+), 7 deletions(-)
> >=20
> > --=20
> > Jeff Layton <jlayton@kernel.org>
>=20

So far, it seems to be surviving with this patch on top. c_replvec is
part of a union, so you need to ensure it actually holds a kvec.


diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index 6eb3d7bdfaf3..80621a709510 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -112,7 +112,8 @@ nfsd_cacherep_alloc(struct svc_rqst *rqstp, __wsum csum=
,
=20
 static void nfsd_cacherep_free(struct nfsd_cacherep *rp)
 {
-	kfree(rp->c_replvec.iov_base);
+	if (rp->c_type =3D=3D RC_REPLBUFF)
+		kfree(rp->c_replvec.iov_base);
 	kmem_cache_free(drc_slab, rp);
 }
=20
--=20
2.41.0


