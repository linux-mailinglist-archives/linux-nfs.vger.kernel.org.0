Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEB92AC933
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Nov 2020 00:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbgKIXRf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Nov 2020 18:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgKIXRf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Nov 2020 18:17:35 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2CEC0613CF
        for <linux-nfs@vger.kernel.org>; Mon,  9 Nov 2020 15:17:33 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id o23so14773686ejn.11
        for <linux-nfs@vger.kernel.org>; Mon, 09 Nov 2020 15:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3KHHf2YPbazr3DXK8rcw4UavCGogyA5UnAWTunp/h+c=;
        b=iFDGtwaIIBeB5KxBeGIxy3EagPwuug4ajmio98S8d+bRgRaW5noEEHrZcehrQhepaa
         aktsN6ENCThaapR97gzkjHvBrddAFeeQjCWQC23QXAaATl5xwJVPjLUBnm85OhLdbY7g
         di4NvrNoS3is9g130i7Lozsf+1uUp7VExPc9mqo6lip5/MtdUY0liUA2q1C/el/fKHx4
         +grWswyno9bt/ysdK9+CYWuNWGNHe4s7SPFbSL+JuqBa7F9U8wCDn4w/VmnVbl14IIbM
         EE2DzPyXhNNLNE3iZK2PC6Kkh9W42NSuPCO400phH553iMG4TBtwl8fr3qZoq7Tnlvee
         6A/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3KHHf2YPbazr3DXK8rcw4UavCGogyA5UnAWTunp/h+c=;
        b=E2lEoT4MLAdUlrfjBuACTkpTwRQpgU75Q2DaiA8S/s8JgqkDKdSvExcBMXTOzgkli2
         9S4j9kDMYnAYeuPlIxQ9nWHhLEq5Mb5kEVaBG8yHLnqsGgjI4P81hM4FhDUBb2edA6Qh
         Sgf9DXocMe9Ymw+IprxO4dHFM9LPqT3/u24DGtZWPaSLOybA4NQX9Iwpn1hyAh3C2Igw
         YEXG8NNbSmOKPD44SZ2uhOCE+bZ1cM7TVLza2wRj2Btv9O4q09CacQdolrRdpkGmvn7T
         hbSxQKSWX3PC5aofP3cTBs9UOswsEGHA2N643l0Usmn5Gcq4Lq76lhLk/ZfzvIWSOVHG
         6Lqg==
X-Gm-Message-State: AOAM533XfPOGA+nyoEM5/E4KnqiL0GLbs5r37M2SIjdAW7luZMYAO8jT
        9bxpM05ObfYgBIPQfxfsePz7pliHCGLdAx/kfcWO1HelTak=
X-Google-Smtp-Source: ABdhPJz6RUPCB50kyS98gAKaq76QKckzGt6Uq2SNwjAXijuAN4QunchPqAkTcATk/MoeHA533so6A1FL0nz6Ry72RMM=
X-Received: by 2002:a17:907:4302:: with SMTP id nh2mr17002374ejb.451.1604963852185;
 Mon, 09 Nov 2020 15:17:32 -0800 (PST)
MIME-Version: 1.0
References: <CAN-5tyENFaKb=CUZCxkeAqhS7jsFswwaGkPyC0W9h_OJyVrEmw@mail.gmail.com>
 <98BAC3EC-35C5-449F-8476-4B740632DC7C@oracle.com> <CAN-5tyGKXJCWxzDnPfT0v70Ry7QNvSCKRnwyU360aW6nJvN-aA@mail.gmail.com>
In-Reply-To: <CAN-5tyGKXJCWxzDnPfT0v70Ry7QNvSCKRnwyU360aW6nJvN-aA@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 9 Nov 2020 18:17:20 -0500
Message-ID: <CAN-5tyFsGBJ3aJC0XVfTOAR219d6jukYZPLvmUGgRFYkraB88A@mail.gmail.com>
Subject: Re: kernel oops in generic/013 on an rdma mount (over either soft
 roce or iwarp)
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 9, 2020 at 6:07 PM Olga Kornievskaia <aglo@umich.edu> wrote:
>
> On Mon, Nov 9, 2020 at 6:01 PM Chuck Lever <chuck.lever@oracle.com> wrote:
> >
> >
> >
> > > On Nov 9, 2020, at 5:55 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
> > >
> > > Hi Chuck,
> > >
> > > generic/013 on 5.10-rc3 under both soft RoCE and iWarp produce the
> > > following kernel oops.
> > > Are you aware of it? 5.9 ran fine. In 5.10-rc1/rc2 both soft RoCE and
> > > iWarp were broken (outside of nfs) so can't test. I'll see what I can
> > > find out more but wanted to run it by you first. Thank you.
> >
> > Could be this:
> >
> > https://lore.kernel.org/linux-nfs/160416263202.2615192.7554388264467271587.stgit@manet.1015granger.net/T/#u
>
> So what does that mean: are you planning to post this patch? That
> patch never ended in even 5.10-rc3?

Which those changes applied, I get the following oops:

[   54.501538] run fstests generic/013 at 2020-11-09 18:10:16
[   65.555863] general protection fault, probably for non-canonical
address 0x28fb180000000: 0000 [#1] SMP PTI
[   65.562715] CPU: 0 PID: 490 Comm: kworker/0:1H Not tainted 5.10.0-rc3+ #32
[   65.566089] Hardware name: VMware, Inc. VMware Virtual
Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
[   65.571259] Workqueue: ib-comp-wq ib_cq_poll_work [ib_core]
[   65.574099] RIP: 0010:rpcrdma_complete_rqst+0x294/0x400 [rpcrdma]
[   65.577254] Code: 4c 63 c2 48 c1 f9 06 48 c1 e1 0c 48 03 0d c4 88
ed e9 48 01 f1 49 83 f8 08 0f 82 68 ff ff ff 48 8b 30 48 8d 79 08 48
83 e7 f8 <48> 89 31 4a 8b 74 00 f8 4a 89 74 01 f8 48 29 f9 48 89 c6 48
29 ce
[   65.587561] RSP: 0018:ffffadbcc18efdd8 EFLAGS: 00010202
[   65.590890] RAX: ffff98a1ddbd208c RBX: ffff98a1b0c20fc0 RCX: 00028fb180000000
[   65.594829] RDX: 0000000000000008 RSI: 0100000000003178 RDI: 00028fb180000008
[   65.598956] RBP: ffff98a1ba249200 R08: 0000000000000008 R09: 0000000000000008
[   65.602641] R10: ffff98a1b0c20fb8 R11: 0000000000000008 R12: ffff98a1f44b8010
[   65.607044] R13: 0000000000000000 R14: 0000000000000078 R15: 0000000000001000
[   65.611062] FS:  0000000000000000(0000) GS:ffff98a1fbe00000(0000)
knlGS:0000000000000000
[   65.615928] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   65.620071] CR2: 00007f048c00b668 CR3: 0000000005bde005 CR4: 00000000001706f0
[   65.623661] Call Trace:
[   65.624907]  __ib_process_cq+0x89/0x150 [ib_core]
[   65.627238]  ib_cq_poll_work+0x26/0x80 [ib_core]
[   65.629623]  process_one_work+0x1a4/0x340
[   65.632506]  ? process_one_work+0x340/0x340
[   65.634627]  worker_thread+0x30/0x370
[   65.636395]  ? process_one_work+0x340/0x340
[   65.639333]  kthread+0x116/0x130
[   65.642022]  ? kthread_park+0x80/0x80
[   65.645183]  ret_from_fork+0x22/0x30
[   65.647019] Modules linked in: cts rpcsec_gss_krb5 nfsv4
dns_resolver nfs lockd grace nfs_ssc rpcrdma rdma_ucm rdma_cm iw_cm
ib_cm ib_uverbs siw ib_core nls_utf8 isofs fuse rfcomm nft_fib_inet
nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4
nf_reject_ipv6 nft_reject nft_ct nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 tun bridge stp llc ip6_tables nft_compat ip_set
nf_tables nfnetlink bnep vmw_vsock_vmci_transport vsock snd_seq_midi
snd_seq_midi_event intel_rapl_msr intel_rapl_common crct10dif_pclmul
crc32_pclmul vmw_balloon ghash_clmulni_intel btusb btrtl btbcm btintel
pcspkr joydev uvcvideo snd_ens1371 videobuf2_vmalloc snd_ac97_codec
videobuf2_memops ac97_bus videobuf2_v4l2 videobuf2_common bluetooth
snd_seq videodev rfkill snd_pcm mc ecdh_generic ecc snd_timer
snd_rawmidi snd_seq_device snd soundcore vmw_vmci i2c_piix4
auth_rpcgss sunrpc ip_tables xfs libcrc32c sr_mod cdrom sg
crc32c_intel ata_generic serio_raw vmwgfx nvme drm_kms_helper
syscopyarea sysfillrect sysimgblt
[   65.647074]  nvme_core t10_pi fb_sys_fops ata_piix ahci libahci
vmxnet3 cec ttm libata drm
[   65.705629] ---[ end trace acdae4b270638f48 ]---


>
> >
> >
> >
> >
> > >
> > > [  126.767318] run fstests generic/013 at 2020-11-09 17:03:25
> > > [  126.931805] BUG: unable to handle page fault for address: ffffa085363bb010
> > > [  126.935622] #PF: supervisor write access in kernel mode
> > > [  126.938202] #PF: error_code(0x0003) - permissions violation
> > > [  126.941042] PGD 3fe02067 P4D 3fe02067 PUD 3fe06067 PMD 74e77063 PTE
> > > 80000000763bb061
> > > [  126.944882] Oops: 0003 [#1] SMP PTI
> > > [  126.946985] CPU: 0 PID: 2924 Comm: fsstress Not tainted 5.10.0-rc3+ #32
> > > [  126.950482] Hardware name: VMware, Inc. VMware Virtual
> > > Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
> > > [  126.955680] RIP: 0010:rpcrdma_convert_iovs.isra.32+0x125/0x190 [rpcrdma]
> > > [  126.959175] Code: 03 74 70 83 f9 05 74 6b 49 8b 45 18 48 85 c0 74
> > > 43 49 8b 4d 10 89 c2 89 ce 81 e6 ff 0f 00 00 85 c0 74 31 bf 00 10 00
> > > 00 89 f8 <49> 89 48 10 29 f0 49 c7 40 08 00 00 00 00 39 d0 0f 47 c2 49
> > > 83 c0
> > > [  126.968901] RSP: 0018:ffffc32703137a68 EFLAGS: 00010286
> > > [  126.971423] RAX: 0000000000001000 RBX: 0000000000000000 RCX: ffffa08542daf000
> > > [  126.974807] RDX: 00000000f34df06c RSI: 0000000000000000 RDI: 0000000000001000
> > > [  126.978224] RBP: 0000000000000000 R08: ffffa085363bb000 R09: 0000000000001000
> > > [  126.982701] R10: ffffeef9c0006f48 R11: ffffa0853ffd60c0 R12: 000000000000cb35
> > > [  126.986327] R13: ffffa0853628a060 R14: ffffa08534f195d0 R15: ffffa0851e213358
> > > [  126.989769] FS:  00007fab74973740(0000) GS:ffffa0853be00000(0000)
> > > knlGS:0000000000000000
> > > [  126.993803] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [  126.996953] CR2: ffffa085363bb010 CR3: 0000000074fd0002 CR4: 00000000001706f0
> > > [  127.000593] Call Trace:
> > > [  127.001907]  rpcrdma_marshal_req+0x4b9/0xb30 [rpcrdma]
> > > [  127.004789]  ? lock_timer_base+0x67/0x80
> > > [  127.006710]  xprt_rdma_send_request+0x48/0xd0 [rpcrdma]
> > > [  127.009257]  xprt_transmit+0x130/0x3f0 [sunrpc]
> > > [  127.011499]  ? rpc_clnt_swap_deactivate+0x30/0x30 [sunrpc]
> > > [  127.014225]  ?
> > > rpc_wake_up_task_on_wq_queue_action_locked+0x230/0x230 [sunrpc]
> > > [  127.017848]  call_transmit+0x63/0x70 [sunrpc]
> > > [  127.019973]  __rpc_execute+0x75/0x3e0 [sunrpc]
> > > [  127.022135]  ? xprt_iter_get_helper+0x17/0x30 [sunrpc]
> > > [  127.024793]  rpc_run_task+0x153/0x170 [sunrpc]
> > > [  127.027098]  nfs4_call_sync_custom+0xb/0x30 [nfsv4]
> > > [  127.029617]  nfs4_do_call_sync+0x69/0x90 [nfsv4]
> > > [  127.032001]  _nfs42_proc_listxattrs+0x143/0x200 [nfsv4]
> > > [  127.034766]  nfs42_proc_listxattrs+0x8e/0xc0 [nfsv4]
> > > [  127.037160]  nfs4_listxattr+0x1b8/0x210 [nfsv4]
> > > [  127.039454]  ? __check_object_size+0x162/0x180
> > > [  127.041606]  listxattr+0xd1/0xf0
> > > [  127.043163]  path_listxattr+0x5f/0xb0
> > > [  127.044969]  do_syscall_64+0x33/0x40
> > > [  127.047200]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > [  127.049644] RIP: 0033:0x7fab74296c8b
> > > [  127.051440] Code: f0 ff ff 73 01 c3 48 8b 0d fa 21 2c 00 f7 d8 64
> > > 89 01 48 83 c8 ff c3 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 c2 00 00
> > > 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cd 21 2c 00 f7 d8 64 89
> > > 01 48
> > > [  127.060978] RSP: 002b:00007fffcddc4a38 EFLAGS: 00000202 ORIG_RAX:
> > > 00000000000000c2
> > > [  127.064848] RAX: ffffffffffffffda RBX: 000000000000002a RCX: 00007fab74296c8b
> > > [  127.068244] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000674440
> > > [  127.071642] RBP: 00000000000001f4 R08: 0000000000000000 R09: 00007fffcddc4687
> > > [  127.075214] R10: 0000000000000004 R11: 0000000000000202 R12: 000000000000002a
> > > [  127.078667] R13: 0000000000403e60 R14: 0000000000000000 R15: 0000000000000000
> > > [  127.082783] Modules linked in: cts rpcsec_gss_krb5 nfsv4
> > > dns_resolver nfs lockd grace nfs_ssc rpcrdma rdma_rxe ip6_udp_tunnel
> > > udp_tunnel rdma_ucm rdma_cm iw_cm ib_cm ib_uverbs ib_core nls_utf8
> > > isofs fuse rfcomm nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
> > > nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
> > > nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 tun bridge stp llc
> > > ip6_tables nft_compat ip_set nf_tables nfnetlink bnep
> > > vmw_vsock_vmci_transport vsock snd_seq_midi snd_seq_midi_event
> > > intel_rapl_msr intel_rapl_common crct10dif_pclmul crc32_pclmul
> > > vmw_balloon ghash_clmulni_intel joydev btusb btrtl pcspkr btbcm
> > > btintel uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2
> > > videobuf2_common videodev snd_ens1371 bluetooth snd_ac97_codec
> > > ac97_bus rfkill mc snd_seq snd_pcm ecdh_generic ecc snd_timer
> > > snd_rawmidi snd_seq_device snd soundcore vmw_vmci i2c_piix4
> > > auth_rpcgss sunrpc ip_tables xfs libcrc32c sr_mod cdrom sg ata_generic
> > > vmwgfx drm_kms_helper nvme crc32c_intel serio_raw
> > > [  127.082841]  syscopyarea sysfillrect sysimgblt fb_sys_fops
> > > nvme_core t10_pi cec vmxnet3 ata_piix ahci libahci ttm libata drm
> > > [  127.132635] CR2: ffffa085363bb010
> > > [  127.134527] ---[ end trace 912ce02a00d98fdf ]---
> >
> > --
> > Chuck Lever
> >
> >
> >
