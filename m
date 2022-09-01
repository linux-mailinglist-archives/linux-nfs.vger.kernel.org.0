Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F276D5A9968
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Sep 2022 15:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbiIANve (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Sep 2022 09:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiIANvd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Sep 2022 09:51:33 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3FF51410
        for <linux-nfs@vger.kernel.org>; Thu,  1 Sep 2022 06:51:31 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w2so7169347edc.0
        for <linux-nfs@vger.kernel.org>; Thu, 01 Sep 2022 06:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=+ntuQ4CdqS1uTy+GDpRgoqoKsgwty3oVa3dne/n2iec=;
        b=rbOk1h6wkUWcw/H9gtHXmIOFrmDF4ZtoYvDdSk30WnUnmPKmcrsh3w+dUkAhNOx3lD
         5+2CVPijwIuRTOgm+4d1/iH5xZltxPAmxsejzXr6bomWZ+umaREIYciPADwXM4kddPKe
         RHYQxVJrgeQgi48EkZL0oT0XbmS9/jgePPbuR1PoL1p/VRK57RqjEFY9QXp2S0tLnVTd
         Ul9CQVylPFUhThL7wBTxz4mL2XkJZVZ9oM2Q1BZdS+0F1q+cStBtGMtLk4xTKRgUiZjr
         k5kv6Lkkp9f1266cKHf1GLD6au7GVBEaFyXdRaYpf+4yYhgo2ENGPF/UgYH/jHTMlodB
         3LBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=+ntuQ4CdqS1uTy+GDpRgoqoKsgwty3oVa3dne/n2iec=;
        b=7CHAb72G00K1jDWb7qP9yGadxrllnyST11jLchzHx9nWvms5SdXiM0bjY2Cdb6MqUC
         16/4QQdpRjJ7vBP3bm+jdaxEg5KdJykog5gfbV08y2jb3kva9JbA8v5zoke+YNKbDjNV
         xsHE3jx64K14trkNYcOjLNz15EfOspCglirmy24BJs8IZ9MCYg083/kcFLnViAGzfht/
         67/V0Mm99Q1SLePTmQNPj9C37sHLh7UNrUZNgdh5RBK2ksYNLm5OnUQefKSL+yqlitTo
         3l3hCw6DkcrfAsbTEkDPS02YhUamo/jVtrrJ26l1hTmPsoxXKDMmlggoSKaFmLX1kMre
         gxqw==
X-Gm-Message-State: ACgBeo0Y0MKqSfHowl6VWL/yNIr1BOcB/oL3GkmKfawWYbXAbcwW/3Dv
        VQshJZbbuDjcLcJ/EJQsWyYvlFSN+AhEW+KhNnpiJtqlIU4=
X-Google-Smtp-Source: AA6agR5i7+dt2sPvaoVuOIiZ7nm80TM7GtH6/GXSWa96jJGstXKA/TOIXfs1pTsMsy/9g/I3lQpitxG3LDGv+e50iGY=
X-Received: by 2002:a05:6402:4511:b0:43b:a182:8a0a with SMTP id
 ez17-20020a056402451100b0043ba1828a0amr29046944edb.410.1662040290130; Thu, 01
 Sep 2022 06:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyGkHd+wEHC5NwQGRuQsJie+aPu0RkWNrp_wFo4e+JcQgA@mail.gmail.com>
 <5c423fdf25e6cedb2dcdbb9c8665d6a9ab4ad4b1.camel@kernel.org>
In-Reply-To: <5c423fdf25e6cedb2dcdbb9c8665d6a9ab4ad4b1.camel@kernel.org>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 1 Sep 2022 09:51:18 -0400
Message-ID: <CAN-5tyEOTVDhR6FgP7nPVon76qhKkexaWB8AJ_iBVTp6iYOk1g@mail.gmail.com>
Subject: Re: Is this nfsd kernel oops known?
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Aug 30, 2022 at 1:49 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Tue, 2022-08-30 at 13:14 -0400, Olga Kornievskaia wrote:
> > Hi folks,
> >
> > Is this a known nfsd kernel oops in 6.0-rc1. Was running xfstests on
> > pre-rhel-9.1 client against 6.0-rc1 server when it panic-ed.
> >
> > [ 5554.769159] BUG: KASAN: null-ptr-deref in kernel_sendpage+0x60/0x220
> > [ 5554.770526] Read of size 8 at addr 0000000000000008 by task nfsd/2590
> > [ 5554.771899]
>
> No, I haven't seen this one. I'm guessing the page pointer passed to
> kernel_sendpage was probably NULL, so this may be a case where something
> walked off the end of the rq_pages array?
>
> Beyond that I can't tell much from just this stack trace. It might be
> nice to see what line of code kernel_sendpage+0x60 refers to on your
> kernel.

After getting debug symbols this is what gdb told me...

(gdb) l *(kernel_sendpage+0x60)
0xffffffff81cbd570 is in kernel_sendpage (./include/linux/page-flags.h:487).
482 TESTCLEARFLAG(LRU, lru, PF_HEAD)
483 PAGEFLAG(Active, active, PF_HEAD) __CLEARPAGEFLAG(Active, active, PF_HEAD)
484 TESTCLEARFLAG(Active, active, PF_HEAD)
485 PAGEFLAG(Workingset, workingset, PF_HEAD)
486 TESTCLEARFLAG(Workingset, workingset, PF_HEAD)
487 __PAGEFLAG(Slab, slab, PF_NO_TAIL)
488 __PAGEFLAG(SlobFree, slob_free, PF_NO_TAIL)
489 PAGEFLAG(Checked, checked, PF_NO_COMPOUND)   /* Used by some filesystems */
490
491 /* Xen */

I'm unable to complete a git bisect. Could somebody suggest what to do
when a git bisect midpoint results in an unbootable kernel? I can't
"skip" this point can I? I'm not sure if marking it "bad" makes sense
since it's not relevant to the actual problem.

However, what I believe I can determine is that NFSD changes are not
to blame because I have a git bisect point which lead to a failure and
which didn't have nfsd changes yet (see git bisect log below)

[aglo@ipa84 linux-nfs]$ git bisect log
git bisect start
# bad: [632de0656c63f11f3700d1a03cacfdb4b85ae98f] NFSD enforce
filehandle check for source file in COPY
git bisect bad 632de0656c63f11f3700d1a03cacfdb4b85ae98f
# good: [3d7cb6b04c3f3115719235cc6866b10326de34cd] Linux 5.19
git bisect good 3d7cb6b04c3f3115719235cc6866b10326de34cd
# good: [b44f2fd87919b5ae6e1756d4c7ba2cbba22238e1] Merge tag
'drm-next-2022-08-03' of git://anongit.freedesktop.org/drm/drm
git bisect good b44f2fd87919b5ae6e1756d4c7ba2cbba22238e1
# good: [6614a3c3164a5df2b54abb0b3559f51041cf705b] Merge tag
'mm-stable-2022-08-03' of
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect good 6614a3c3164a5df2b54abb0b3559f51041cf705b
# good: [eb5699ba31558bdb2cee6ebde3d0a68091e47dce] Merge tag
'mm-nonmm-stable-2022-08-06-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect good eb5699ba31558bdb2cee6ebde3d0a68091e47dce
# bad: [5e2e7383b57fa03ec2b00c82bb7f49a4a707c1f7] Merge tag
'pinctrl-v6.0-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
git bisect bad 5e2e7383b57fa03ec2b00c82bb7f49a4a707c1f7
# good: [507f811f205c17fd6f64e8d34d4bf91cd01b07a2] Merge tag
'pm-5.20-rc1-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect good 507f811f205c17fd6f64e8d34d4bf91cd01b07a2
# bad: [e394ff83bbca1c72427b1feb5c6b9d4dad832f01] Merge tag 'nfsd-6.0'
of git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
git bisect bad e394ff83bbca1c72427b1feb5c6b9d4dad832f01
# bad: [f30adc0d332fdfe5315cb98bd6a7ff0d5cf2aa38] Merge tag
'pull-work.iov_iter-rebased' of
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
git bisect bad f30adc0d332fdfe5315cb98bd6a7ff0d5cf2aa38
# bad: [8447d0e75099eb54eea9306c2d43ecfc956d09ed] remoteproc:
qcom_q6v5_pas: Do not fail if regulators are not found
git bisect bad 8447d0e75099eb54eea9306c2d43ecfc956d09ed

"Merge tag nfsd-6.0" was bad but so was "Merge tag
'pull-work.iov_iter-rebased'" which is before that. So something else
broke something in the kernel which is affecting NFSD.

Again if somebody could suggest how I could keep git bisecting where I
get non-bootable kernel I could continue...


>
> > [ 5554.772249] CPU: 1 PID: 2590 Comm: nfsd Not tainted 6.0.0-rc1+ #84
> > [ 5554.773575] Hardware name: VMware, Inc. VMware Virtual
> > Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
> > [ 5554.775952] Call Trace:
> > [ 5554.776500]  <TASK>
> > [ 5554.776977]  dump_stack_lvl+0x33/0x46
> > [ 5554.777792]  ? kernel_sendpage+0x60/0x220
> > [ 5554.778672]  print_report.cold.12+0x499/0x6b7
> > [ 5554.779628]  ? tcp_release_cb+0x46/0x200
> > [ 5554.780577]  ? kernel_sendpage+0x60/0x220
> > [ 5554.781516]  kasan_report+0xa3/0x120
> > [ 5554.782361]  ? inet_sendmsg+0xa0/0xa0
> > [ 5554.783217]  ? kernel_sendpage+0x60/0x220
> > [ 5554.784191]  kernel_sendpage+0x60/0x220
> > [ 5554.785247]  svc_tcp_sendmsg+0x206/0x2e0 [sunrpc]
> > [ 5554.787188]  ? svc_tcp_send_kvec.isra.20.constprop.29+0xa0/0xa0 [sunrpc]
> > [ 5554.789364]  ? refcount_dec_not_one+0xa0/0x120
> > [ 5554.790402]  ? refcount_warn_saturate+0x120/0x120
> > [ 5554.791495]  ? __rcu_read_unlock+0x4e/0x250
> > [ 5554.792575]  ? __mutex_lock_slowpath+0x10/0x10
> > [ 5554.793571]  ? tcp_release_cb+0x46/0x200
> > [ 5554.794443]  svc_tcp_sendto+0x14f/0x2e0 [sunrpc]
> > [ 5554.796182]  ? svc_addsock+0x370/0x370 [sunrpc]
> > [ 5554.797924]  ? svc_sock_secure_port+0x27/0x50 [sunrpc]
> > [ 5554.799848]  ? svc_recv+0xab0/0xfa0 [sunrpc]
> > [ 5554.801434]  svc_send+0x9c/0x260 [sunrpc]
> > [ 5554.802963]  nfsd+0x170/0x270 [nfsd]
> > [ 5554.804140]  ? nfsd_shutdown_threads+0xe0/0xe0 [nfsd]
> > [ 5554.805631]  kthread+0x160/0x190
> > [ 5554.806354]  ? kthread_complete_and_exit+0x20/0x20
> > [ 5554.807401]  ret_from_fork+0x1f/0x30
> > [ 5554.808206]  </TASK>
> > [ 5554.808699] ==================================================================
> > [ 5554.810486] Disabling lock debugging due to kernel taint
> > [ 5554.811772] BUG: kernel NULL pointer dereference, address: 0000000000000008
> > [ 5554.813236] #PF: supervisor read access in kernel mode
> > [ 5554.814345] #PF: error_code(0x0000) - not-present page
> > [ 5554.815462] PGD 0 P4D 0
> > [ 5554.816032] Oops: 0000 [#1] PREEMPT SMP KASAN PTI
> > [ 5554.817057] CPU: 1 PID: 2590 Comm: nfsd Tainted: G    B
> >  6.0.0-rc1+ #84
> > [ 5554.818677] Hardware name: VMware, Inc. VMware Virtual
> > Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
> > [ 5554.821028] RIP: 0010:kernel_sendpage+0x60/0x220
> > [ 5554.822138] Code: 24 a0 00 00 00 e8 a0 98 83 ff 49 83 bc 24 a0 00
> > 00 00 00 0f 84 9f 00 00 00 48 8d 43 08 48 89 c7 48 89 44 24 08 e8 80
> > 98 83 ff <4c> 8b 63 08 41 f6 c4 01 0f 85 ee 00 00 00 0f 1f 44 00 00 48
> > 89 df
> > [ 5554.826047] RSP: 0018:ffff888017ef7c38 EFLAGS: 00010296
> > [ 5554.827192] RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffffffffa3b173b6
> > [ 5554.828715] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffffffffa6b16260
> > [ 5554.830237] RBP: ffff8880057ac380 R08: fffffbfff4d62c4d R09: fffffbfff4d62c4d
> > [ 5554.831757] R10: ffffffffa6b16267 R11: fffffbfff4d62c4c R12: ffffffffa545e6a0
> > [ 5554.833341] R13: ffff8880057ac3a0 R14: 0000000000001000 R15: 0000000000000000
> > [ 5554.834881] FS:  0000000000000000(0000) GS:ffff888057c80000(0000)
> > knlGS:0000000000000000
> > [ 5554.836590] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 5554.837819] CR2: 0000000000000008 CR3: 000000000677e004 CR4: 00000000001706e0
> > [ 5554.839374] Call Trace:
> > [ 5554.839919]  <TASK>
> > [ 5554.840400]  svc_tcp_sendmsg+0x206/0x2e0 [sunrpc]
> > [ 5554.842066]  ? svc_tcp_send_kvec.isra.20.constprop.29+0xa0/0xa0 [sunrpc]
> > [ 5554.844194]  ? refcount_dec_not_one+0xa0/0x120
> > [ 5554.845239]  ? refcount_warn_saturate+0x120/0x120
> > [ 5554.846275]  ? __rcu_read_unlock+0x4e/0x250
> > [ 5554.847199]  ? __mutex_lock_slowpath+0x10/0x10
> > [ 5554.848171]  ? tcp_release_cb+0x46/0x200
> > [ 5554.849039]  svc_tcp_sendto+0x14f/0x2e0 [sunrpc]
> > [ 5554.850667]  ? svc_addsock+0x370/0x370 [sunrpc]
> > [ 5554.852285]  ? svc_sock_secure_port+0x27/0x50 [sunrpc]
> > [ 5554.854420]  ? svc_recv+0xab0/0xfa0 [sunrpc]
> > [ 5554.856187]  svc_send+0x9c/0x260 [sunrpc]
> > [ 5554.857773]  nfsd+0x170/0x270 [nfsd]
> > [ 5554.859009]  ? nfsd_shutdown_threads+0xe0/0xe0 [nfsd]
> > [ 5554.860602]  kthread+0x160/0x190
> > [ 5554.861400]  ? kthread_complete_and_exit+0x20/0x20
> > [ 5554.862452]  ret_from_fork+0x1f/0x30
> > [ 5554.863265]  </TASK>
> > [ 5554.863756] Modules linked in: rdma_ucm ib_uverbs rpcrdma rdma_cm
> > iw_cm ib_cm ib_core nfsd nfs_acl lockd grace ext4 mbcache jbd2 fuse
> > xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT
> > nf_reject_ipv4 nft_compat nf_tables nfnetlink tun bridge stp llc bnep
> > vmw_vsock_vmci_transport vsock intel_rapl_msr intel_rapl_common
> > snd_seq_midi snd_seq_midi_event crct10dif_pclmul crc32_pclmul
> > vmw_balloon ghash_clmulni_intel joydev pcspkr snd_ens1371
> > snd_ac97_codec ac97_bus snd_seq btusb btrtl btbcm btintel snd_pcm
> > snd_timer snd_rawmidi snd_seq_device bluetooth rfkill snd ecdh_generic
> > ecc soundcore vmw_vmci i2c_piix4 auth_rpcgss sunrpc ip_tables xfs
> > libcrc32c sr_mod cdrom sg crc32c_intel nvme serio_raw nvme_core t10_pi
> > crc64_rocksoft crc64 vmwgfx drm_ttm_helper ttm ahci drm_kms_helper
> > ata_generic syscopyarea sysfillrect sysimgblt fb_sys_fops vmxnet3
> > libahci ata_piix drm libata
> > [ 5554.880681] CR2: 0000000000000008
> > [ 5554.881539] ---[ end trace 0000000000000000 ]---
>
> --
> Jeff Layton <jlayton@kernel.org>
