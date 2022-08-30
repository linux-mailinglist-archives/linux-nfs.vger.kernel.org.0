Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A57F5A6C01
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Aug 2022 20:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiH3SW2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Aug 2022 14:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiH3SW2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 Aug 2022 14:22:28 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840055007F
        for <linux-nfs@vger.kernel.org>; Tue, 30 Aug 2022 11:22:26 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z8so6538769edb.6
        for <linux-nfs@vger.kernel.org>; Tue, 30 Aug 2022 11:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=nY9j7s1eOmoQMpjEDY3Kj3SGs5GseBtXIjZHEPsZkMw=;
        b=PyMRuDm4a2zfREmv8dyQb7TEWVgXJmmHCCW8kcR5/nDbSrbxLopESg/H0uBPH7CyQ8
         GppXuXMTo+q+u5Gxi0b8jql2U4c5JlrQADYZ2lJXXX4dvNi4vJorgy92SMUuW9mQqE01
         5XvUdDzZWBhGUVHr5hM3L3heAaWcljCj/iZvxon3xC8CcqcxIs+hPpd4QU2hHcL7kgpB
         M54PJ4VZgrw2WgVg9+khczochWFMYXU0abYiJdT8tiw5YgJLfAv2ihb0LbY4U5NsMeW1
         ZuP18lWlADn/iduzfMWxtl6Drp4mTKlnllmA7hoZ4e2XMjVcsSVG+3vvhOt+KODtSZU6
         nqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=nY9j7s1eOmoQMpjEDY3Kj3SGs5GseBtXIjZHEPsZkMw=;
        b=bfa79V9xcYuIulUkCbNGAoZsiTuyNg2pRmRBgC+UEEfkDsXNmKCaYFX/U3sRICwKQK
         OuLMAs76uEXMMgSy5y7JpRqnZ0y1t91hVCd4DCApB7TKS271n0b9i8nDrAXDPd9Ww6rH
         SENnu9GAKX0zjFOQ7fUfO+WesOrjFFr8iNgMrYvfZdVlMxQyArtIKvhH5NwPumwalCYT
         Feo7YZK/S/lYUjXsn79dYPNLBWQ0MigsskvxXItsb1DjwJceE7NdCOZDKtbb2Uf55a6D
         H7lnT2SmRrtfttI98tEPSumMXgG5+sIVMyACSTYfJea0Z9Hh3w81rTpwEJK9LhRWomBl
         8vtA==
X-Gm-Message-State: ACgBeo3Zzx+jJI/TIC0Iv12lnKtNJ8W3bs1ywDsY2XmDnUadZA4iPrbs
        Inn619OFwwtsqSfhqLZ/lhwuttIXNz3775DKWaA=
X-Google-Smtp-Source: AA6agR5Zho0eDWXESayuCWk/tNC+nFLclYE56BP14iNaBXroXoUnTqrCTX6j2ol9irVaqnGZ84Bhl/K8W5Xa86RAjzI=
X-Received: by 2002:a05:6402:5ca:b0:445:c80a:3c2 with SMTP id
 n10-20020a05640205ca00b00445c80a03c2mr21625588edx.247.1661883744514; Tue, 30
 Aug 2022 11:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyGkHd+wEHC5NwQGRuQsJie+aPu0RkWNrp_wFo4e+JcQgA@mail.gmail.com>
 <5c423fdf25e6cedb2dcdbb9c8665d6a9ab4ad4b1.camel@kernel.org>
In-Reply-To: <5c423fdf25e6cedb2dcdbb9c8665d6a9ab4ad4b1.camel@kernel.org>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 30 Aug 2022 14:22:13 -0400
Message-ID: <CAN-5tyGqK1NsWP42+ZX-wpBrd=u2g9mQB8PZiRQqWTvp-B+6qQ@mail.gmail.com>
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

Ok I reproduced it again.

This time I updated to Chuck's 'for-next' branch at commit
deb33fa8542eaf554e78a725cb8b922ac06978a4 (hopefully that means I'm
'current').

client: 5.14.0-148 running generic/138 test.

On the network trace the last thing is a client sending a READ to the server.

Embarrassingly I'm unable to get the line number of kernel_sendpage.
So I think this must be in vmlinux but when I gdb vmlinux it doesn't
have any debugging symbols even though my configuration turns on
debugging. I can get you the line for the svc_tcp_sendmsg+0x206 but I
know that doesn't help. What Kconfig I need to have debug symbols for
kernel_sendpage (I have CONFIG_DEBUG_KERNEL but I have
CONFIG_DEBUG_INFO_NONE=y so is that it should I choose something else
here)?

Also another piece, when I tested with a server running 5.19-rc6
(which was based on Trond's tree for 6.0), the server didn't panic.
Not sure if that helps.

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
