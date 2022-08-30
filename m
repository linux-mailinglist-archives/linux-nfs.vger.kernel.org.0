Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761D05A695C
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Aug 2022 19:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiH3ROn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Aug 2022 13:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiH3ROk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 Aug 2022 13:14:40 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C161FBB91C
        for <linux-nfs@vger.kernel.org>; Tue, 30 Aug 2022 10:14:36 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id se27so15801102ejb.8
        for <linux-nfs@vger.kernel.org>; Tue, 30 Aug 2022 10:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=Llr3eP4F5tnsKKeNjA+8BDoOH22ncSnMiVv16zSO8hQ=;
        b=Qn2f2QTIPv8j69HlRyZnF7xsCGSFyNVg+MyHbXSS6TmEXr+yVdXiLjOWOsRzMU3yrG
         fH+jXPh8lG3JVaMG/7/1P2dvJPuA7vYP0IxOtex3X7giLlHnYZvBbamhTJqH8zE+8APL
         q5pWP7gCmDzgbEtkhc6QPGN6sQM0PofTI0YurGDqmeBvNkgpxE0bIx1lQ71pflfWbIXQ
         yEXl9m6+iNp6rpSUJda31cnbTZmvrzSf5anTYay3hbPkPcucaf+HH9BONsBBTgUlFFWc
         DQht8cGL8p8wkGlEWTbnQ6LGR1Sq3Vo0UoFtkXjJiFAXekdO4GXX3Ber3ToDkUL7+aAY
         nK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=Llr3eP4F5tnsKKeNjA+8BDoOH22ncSnMiVv16zSO8hQ=;
        b=FQwK7rWraMvB1h760Xe7dt8v+wgGXqgPi6SFEli69id14hyjTnszKum4m7Az/NmZEU
         zNMZsVC2qur94ptUJkSyEmwGk5sP9JxOuOlNfrSQjyf34STQG+AV+JA+rqEusiIAYgKE
         UO/t6G5lY3V+XeRi7wlmwfP4kXyB2qYH2pKf2huN4pQCx5RNVx1Kofw4qLjkzTW967Hk
         aLZjAGhxY4+o5GpyQKV740NwVqA3LZYsMoFB43tSaI4NuG5qez9iVi3vaMexxQu+RL+J
         Ah+eGsc0y5yd8UPCnvu5z/N+8D0/ZFKxF9gtk32KBgr8WTeCLDnRnrCoBjDk1HpHr6Je
         onSw==
X-Gm-Message-State: ACgBeo3PtwRAGBJhZa6+0oYJl/dFFNVjhHWb3JBt7rFU22NNno3iyrY+
        q43J4INCunRGm6o7o7ozm1EwKbHDyKnpyfpC37k=
X-Google-Smtp-Source: AA6agR4h8aWEGVncqc1YZ9Bi6Lp65LvaBHk/TdmLviBxBG36qxG+mWlY92qwlBAd0X211iCtgVQB4JyK8lTv0nK9nKg=
X-Received: by 2002:a17:907:2d12:b0:731:6a4e:ceb0 with SMTP id
 gs18-20020a1709072d1200b007316a4eceb0mr18022366ejc.115.1661879673787; Tue, 30
 Aug 2022 10:14:33 -0700 (PDT)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 30 Aug 2022 13:14:22 -0400
Message-ID: <CAN-5tyGkHd+wEHC5NwQGRuQsJie+aPu0RkWNrp_wFo4e+JcQgA@mail.gmail.com>
Subject: Is this nfsd kernel oops known?
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
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

Hi folks,

Is this a known nfsd kernel oops in 6.0-rc1. Was running xfstests on
pre-rhel-9.1 client against 6.0-rc1 server when it panic-ed.

[ 5554.769159] BUG: KASAN: null-ptr-deref in kernel_sendpage+0x60/0x220
[ 5554.770526] Read of size 8 at addr 0000000000000008 by task nfsd/2590
[ 5554.771899]
[ 5554.772249] CPU: 1 PID: 2590 Comm: nfsd Not tainted 6.0.0-rc1+ #84
[ 5554.773575] Hardware name: VMware, Inc. VMware Virtual
Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
[ 5554.775952] Call Trace:
[ 5554.776500]  <TASK>
[ 5554.776977]  dump_stack_lvl+0x33/0x46
[ 5554.777792]  ? kernel_sendpage+0x60/0x220
[ 5554.778672]  print_report.cold.12+0x499/0x6b7
[ 5554.779628]  ? tcp_release_cb+0x46/0x200
[ 5554.780577]  ? kernel_sendpage+0x60/0x220
[ 5554.781516]  kasan_report+0xa3/0x120
[ 5554.782361]  ? inet_sendmsg+0xa0/0xa0
[ 5554.783217]  ? kernel_sendpage+0x60/0x220
[ 5554.784191]  kernel_sendpage+0x60/0x220
[ 5554.785247]  svc_tcp_sendmsg+0x206/0x2e0 [sunrpc]
[ 5554.787188]  ? svc_tcp_send_kvec.isra.20.constprop.29+0xa0/0xa0 [sunrpc]
[ 5554.789364]  ? refcount_dec_not_one+0xa0/0x120
[ 5554.790402]  ? refcount_warn_saturate+0x120/0x120
[ 5554.791495]  ? __rcu_read_unlock+0x4e/0x250
[ 5554.792575]  ? __mutex_lock_slowpath+0x10/0x10
[ 5554.793571]  ? tcp_release_cb+0x46/0x200
[ 5554.794443]  svc_tcp_sendto+0x14f/0x2e0 [sunrpc]
[ 5554.796182]  ? svc_addsock+0x370/0x370 [sunrpc]
[ 5554.797924]  ? svc_sock_secure_port+0x27/0x50 [sunrpc]
[ 5554.799848]  ? svc_recv+0xab0/0xfa0 [sunrpc]
[ 5554.801434]  svc_send+0x9c/0x260 [sunrpc]
[ 5554.802963]  nfsd+0x170/0x270 [nfsd]
[ 5554.804140]  ? nfsd_shutdown_threads+0xe0/0xe0 [nfsd]
[ 5554.805631]  kthread+0x160/0x190
[ 5554.806354]  ? kthread_complete_and_exit+0x20/0x20
[ 5554.807401]  ret_from_fork+0x1f/0x30
[ 5554.808206]  </TASK>
[ 5554.808699] ==================================================================
[ 5554.810486] Disabling lock debugging due to kernel taint
[ 5554.811772] BUG: kernel NULL pointer dereference, address: 0000000000000008
[ 5554.813236] #PF: supervisor read access in kernel mode
[ 5554.814345] #PF: error_code(0x0000) - not-present page
[ 5554.815462] PGD 0 P4D 0
[ 5554.816032] Oops: 0000 [#1] PREEMPT SMP KASAN PTI
[ 5554.817057] CPU: 1 PID: 2590 Comm: nfsd Tainted: G    B
 6.0.0-rc1+ #84
[ 5554.818677] Hardware name: VMware, Inc. VMware Virtual
Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
[ 5554.821028] RIP: 0010:kernel_sendpage+0x60/0x220
[ 5554.822138] Code: 24 a0 00 00 00 e8 a0 98 83 ff 49 83 bc 24 a0 00
00 00 00 0f 84 9f 00 00 00 48 8d 43 08 48 89 c7 48 89 44 24 08 e8 80
98 83 ff <4c> 8b 63 08 41 f6 c4 01 0f 85 ee 00 00 00 0f 1f 44 00 00 48
89 df
[ 5554.826047] RSP: 0018:ffff888017ef7c38 EFLAGS: 00010296
[ 5554.827192] RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffffffffa3b173b6
[ 5554.828715] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffffffffa6b16260
[ 5554.830237] RBP: ffff8880057ac380 R08: fffffbfff4d62c4d R09: fffffbfff4d62c4d
[ 5554.831757] R10: ffffffffa6b16267 R11: fffffbfff4d62c4c R12: ffffffffa545e6a0
[ 5554.833341] R13: ffff8880057ac3a0 R14: 0000000000001000 R15: 0000000000000000
[ 5554.834881] FS:  0000000000000000(0000) GS:ffff888057c80000(0000)
knlGS:0000000000000000
[ 5554.836590] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5554.837819] CR2: 0000000000000008 CR3: 000000000677e004 CR4: 00000000001706e0
[ 5554.839374] Call Trace:
[ 5554.839919]  <TASK>
[ 5554.840400]  svc_tcp_sendmsg+0x206/0x2e0 [sunrpc]
[ 5554.842066]  ? svc_tcp_send_kvec.isra.20.constprop.29+0xa0/0xa0 [sunrpc]
[ 5554.844194]  ? refcount_dec_not_one+0xa0/0x120
[ 5554.845239]  ? refcount_warn_saturate+0x120/0x120
[ 5554.846275]  ? __rcu_read_unlock+0x4e/0x250
[ 5554.847199]  ? __mutex_lock_slowpath+0x10/0x10
[ 5554.848171]  ? tcp_release_cb+0x46/0x200
[ 5554.849039]  svc_tcp_sendto+0x14f/0x2e0 [sunrpc]
[ 5554.850667]  ? svc_addsock+0x370/0x370 [sunrpc]
[ 5554.852285]  ? svc_sock_secure_port+0x27/0x50 [sunrpc]
[ 5554.854420]  ? svc_recv+0xab0/0xfa0 [sunrpc]
[ 5554.856187]  svc_send+0x9c/0x260 [sunrpc]
[ 5554.857773]  nfsd+0x170/0x270 [nfsd]
[ 5554.859009]  ? nfsd_shutdown_threads+0xe0/0xe0 [nfsd]
[ 5554.860602]  kthread+0x160/0x190
[ 5554.861400]  ? kthread_complete_and_exit+0x20/0x20
[ 5554.862452]  ret_from_fork+0x1f/0x30
[ 5554.863265]  </TASK>
[ 5554.863756] Modules linked in: rdma_ucm ib_uverbs rpcrdma rdma_cm
iw_cm ib_cm ib_core nfsd nfs_acl lockd grace ext4 mbcache jbd2 fuse
xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT
nf_reject_ipv4 nft_compat nf_tables nfnetlink tun bridge stp llc bnep
vmw_vsock_vmci_transport vsock intel_rapl_msr intel_rapl_common
snd_seq_midi snd_seq_midi_event crct10dif_pclmul crc32_pclmul
vmw_balloon ghash_clmulni_intel joydev pcspkr snd_ens1371
snd_ac97_codec ac97_bus snd_seq btusb btrtl btbcm btintel snd_pcm
snd_timer snd_rawmidi snd_seq_device bluetooth rfkill snd ecdh_generic
ecc soundcore vmw_vmci i2c_piix4 auth_rpcgss sunrpc ip_tables xfs
libcrc32c sr_mod cdrom sg crc32c_intel nvme serio_raw nvme_core t10_pi
crc64_rocksoft crc64 vmwgfx drm_ttm_helper ttm ahci drm_kms_helper
ata_generic syscopyarea sysfillrect sysimgblt fb_sys_fops vmxnet3
libahci ata_piix drm libata
[ 5554.880681] CR2: 0000000000000008
[ 5554.881539] ---[ end trace 0000000000000000 ]---
