Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DA65A6B49
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Aug 2022 19:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbiH3Rwz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Aug 2022 13:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiH3RwZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 Aug 2022 13:52:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FC76050B
        for <linux-nfs@vger.kernel.org>; Tue, 30 Aug 2022 10:49:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4177D61463
        for <linux-nfs@vger.kernel.org>; Tue, 30 Aug 2022 17:49:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445FAC433D6;
        Tue, 30 Aug 2022 17:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661881745;
        bh=3id+N2tbN+UYzRteYPt3Zk4lWM/vmuFXld7Xah+p0nI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rEd18UY2lPBh3CZLvbCnawxcCrN0qtcjqcCjpVs9omwSxnQiYBrRiF8nXOQSbjGwU
         Bc6Oy7eeLjbPdd8UBZYyfYhl3ea8n/dyGBK2AjKzdrn7yUbCppFhjmtOOr+lQ34G5u
         6LDB3qQLFIwRnXIc9SVr8FFyyCO/5pQDjYlXzTrIh9rASDoXZwORHYR1s58d3M6M7x
         YC/NfSNs+CSrb/DrkFpdbqybbqJmKa0ZKCwt47q+WJZ5nAp+8loJRW9Mve+A1JtAsM
         V8WcjTQ5SJ2mBiID2b6n38ElOVhOP1Q2w/xd8WJapRWmxq/LNPG1TmMfGyLMYk0wkS
         BdPtf5AjkRLxA==
Message-ID: <5c423fdf25e6cedb2dcdbb9c8665d6a9ab4ad4b1.camel@kernel.org>
Subject: Re: Is this nfsd kernel oops known?
From:   Jeff Layton <jlayton@kernel.org>
To:     Olga Kornievskaia <aglo@umich.edu>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Date:   Tue, 30 Aug 2022 13:49:03 -0400
In-Reply-To: <CAN-5tyGkHd+wEHC5NwQGRuQsJie+aPu0RkWNrp_wFo4e+JcQgA@mail.gmail.com>
References: <CAN-5tyGkHd+wEHC5NwQGRuQsJie+aPu0RkWNrp_wFo4e+JcQgA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2022-08-30 at 13:14 -0400, Olga Kornievskaia wrote:
> Hi folks,
>=20
> Is this a known nfsd kernel oops in 6.0-rc1. Was running xfstests on
> pre-rhel-9.1 client against 6.0-rc1 server when it panic-ed.
>=20
> [ 5554.769159] BUG: KASAN: null-ptr-deref in kernel_sendpage+0x60/0x220
> [ 5554.770526] Read of size 8 at addr 0000000000000008 by task nfsd/2590
> [ 5554.771899]

No, I haven't seen this one. I'm guessing the page pointer passed to
kernel_sendpage was probably NULL, so this may be a case where something
walked off the end of the rq_pages array?

Beyond that I can't tell much from just this stack trace. It might be
nice to see what line of code kernel_sendpage+0x60 refers to on your
kernel.

> [ 5554.772249] CPU: 1 PID: 2590 Comm: nfsd Not tainted 6.0.0-rc1+ #84
> [ 5554.773575] Hardware name: VMware, Inc. VMware Virtual
> Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
> [ 5554.775952] Call Trace:
> [ 5554.776500]  <TASK>
> [ 5554.776977]  dump_stack_lvl+0x33/0x46
> [ 5554.777792]  ? kernel_sendpage+0x60/0x220
> [ 5554.778672]  print_report.cold.12+0x499/0x6b7
> [ 5554.779628]  ? tcp_release_cb+0x46/0x200
> [ 5554.780577]  ? kernel_sendpage+0x60/0x220
> [ 5554.781516]  kasan_report+0xa3/0x120
> [ 5554.782361]  ? inet_sendmsg+0xa0/0xa0
> [ 5554.783217]  ? kernel_sendpage+0x60/0x220
> [ 5554.784191]  kernel_sendpage+0x60/0x220
> [ 5554.785247]  svc_tcp_sendmsg+0x206/0x2e0 [sunrpc]
> [ 5554.787188]  ? svc_tcp_send_kvec.isra.20.constprop.29+0xa0/0xa0 [sunrp=
c]
> [ 5554.789364]  ? refcount_dec_not_one+0xa0/0x120
> [ 5554.790402]  ? refcount_warn_saturate+0x120/0x120
> [ 5554.791495]  ? __rcu_read_unlock+0x4e/0x250
> [ 5554.792575]  ? __mutex_lock_slowpath+0x10/0x10
> [ 5554.793571]  ? tcp_release_cb+0x46/0x200
> [ 5554.794443]  svc_tcp_sendto+0x14f/0x2e0 [sunrpc]
> [ 5554.796182]  ? svc_addsock+0x370/0x370 [sunrpc]
> [ 5554.797924]  ? svc_sock_secure_port+0x27/0x50 [sunrpc]
> [ 5554.799848]  ? svc_recv+0xab0/0xfa0 [sunrpc]
> [ 5554.801434]  svc_send+0x9c/0x260 [sunrpc]
> [ 5554.802963]  nfsd+0x170/0x270 [nfsd]
> [ 5554.804140]  ? nfsd_shutdown_threads+0xe0/0xe0 [nfsd]
> [ 5554.805631]  kthread+0x160/0x190
> [ 5554.806354]  ? kthread_complete_and_exit+0x20/0x20
> [ 5554.807401]  ret_from_fork+0x1f/0x30
> [ 5554.808206]  </TASK>
> [ 5554.808699] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ 5554.810486] Disabling lock debugging due to kernel taint
> [ 5554.811772] BUG: kernel NULL pointer dereference, address: 00000000000=
00008
> [ 5554.813236] #PF: supervisor read access in kernel mode
> [ 5554.814345] #PF: error_code(0x0000) - not-present page
> [ 5554.815462] PGD 0 P4D 0
> [ 5554.816032] Oops: 0000 [#1] PREEMPT SMP KASAN PTI
> [ 5554.817057] CPU: 1 PID: 2590 Comm: nfsd Tainted: G    B
>  6.0.0-rc1+ #84
> [ 5554.818677] Hardware name: VMware, Inc. VMware Virtual
> Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
> [ 5554.821028] RIP: 0010:kernel_sendpage+0x60/0x220
> [ 5554.822138] Code: 24 a0 00 00 00 e8 a0 98 83 ff 49 83 bc 24 a0 00
> 00 00 00 0f 84 9f 00 00 00 48 8d 43 08 48 89 c7 48 89 44 24 08 e8 80
> 98 83 ff <4c> 8b 63 08 41 f6 c4 01 0f 85 ee 00 00 00 0f 1f 44 00 00 48
> 89 df
> [ 5554.826047] RSP: 0018:ffff888017ef7c38 EFLAGS: 00010296
> [ 5554.827192] RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffffffffa=
3b173b6
> [ 5554.828715] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffffffffa=
6b16260
> [ 5554.830237] RBP: ffff8880057ac380 R08: fffffbfff4d62c4d R09: fffffbfff=
4d62c4d
> [ 5554.831757] R10: ffffffffa6b16267 R11: fffffbfff4d62c4c R12: ffffffffa=
545e6a0
> [ 5554.833341] R13: ffff8880057ac3a0 R14: 0000000000001000 R15: 000000000=
0000000
> [ 5554.834881] FS:  0000000000000000(0000) GS:ffff888057c80000(0000)
> knlGS:0000000000000000
> [ 5554.836590] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 5554.837819] CR2: 0000000000000008 CR3: 000000000677e004 CR4: 000000000=
01706e0
> [ 5554.839374] Call Trace:
> [ 5554.839919]  <TASK>
> [ 5554.840400]  svc_tcp_sendmsg+0x206/0x2e0 [sunrpc]
> [ 5554.842066]  ? svc_tcp_send_kvec.isra.20.constprop.29+0xa0/0xa0 [sunrp=
c]
> [ 5554.844194]  ? refcount_dec_not_one+0xa0/0x120
> [ 5554.845239]  ? refcount_warn_saturate+0x120/0x120
> [ 5554.846275]  ? __rcu_read_unlock+0x4e/0x250
> [ 5554.847199]  ? __mutex_lock_slowpath+0x10/0x10
> [ 5554.848171]  ? tcp_release_cb+0x46/0x200
> [ 5554.849039]  svc_tcp_sendto+0x14f/0x2e0 [sunrpc]
> [ 5554.850667]  ? svc_addsock+0x370/0x370 [sunrpc]
> [ 5554.852285]  ? svc_sock_secure_port+0x27/0x50 [sunrpc]
> [ 5554.854420]  ? svc_recv+0xab0/0xfa0 [sunrpc]
> [ 5554.856187]  svc_send+0x9c/0x260 [sunrpc]
> [ 5554.857773]  nfsd+0x170/0x270 [nfsd]
> [ 5554.859009]  ? nfsd_shutdown_threads+0xe0/0xe0 [nfsd]
> [ 5554.860602]  kthread+0x160/0x190
> [ 5554.861400]  ? kthread_complete_and_exit+0x20/0x20
> [ 5554.862452]  ret_from_fork+0x1f/0x30
> [ 5554.863265]  </TASK>
> [ 5554.863756] Modules linked in: rdma_ucm ib_uverbs rpcrdma rdma_cm
> iw_cm ib_cm ib_core nfsd nfs_acl lockd grace ext4 mbcache jbd2 fuse
> xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT
> nf_reject_ipv4 nft_compat nf_tables nfnetlink tun bridge stp llc bnep
> vmw_vsock_vmci_transport vsock intel_rapl_msr intel_rapl_common
> snd_seq_midi snd_seq_midi_event crct10dif_pclmul crc32_pclmul
> vmw_balloon ghash_clmulni_intel joydev pcspkr snd_ens1371
> snd_ac97_codec ac97_bus snd_seq btusb btrtl btbcm btintel snd_pcm
> snd_timer snd_rawmidi snd_seq_device bluetooth rfkill snd ecdh_generic
> ecc soundcore vmw_vmci i2c_piix4 auth_rpcgss sunrpc ip_tables xfs
> libcrc32c sr_mod cdrom sg crc32c_intel nvme serio_raw nvme_core t10_pi
> crc64_rocksoft crc64 vmwgfx drm_ttm_helper ttm ahci drm_kms_helper
> ata_generic syscopyarea sysfillrect sysimgblt fb_sys_fops vmxnet3
> libahci ata_piix drm libata
> [ 5554.880681] CR2: 0000000000000008
> [ 5554.881539] ---[ end trace 0000000000000000 ]---

--=20
Jeff Layton <jlayton@kernel.org>
