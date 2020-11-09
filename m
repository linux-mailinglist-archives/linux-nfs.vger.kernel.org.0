Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347E72AC8E7
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Nov 2020 23:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbgKIWzl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Nov 2020 17:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbgKIWzk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Nov 2020 17:55:40 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0617FC0613CF
        for <linux-nfs@vger.kernel.org>; Mon,  9 Nov 2020 14:55:39 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id za3so14702719ejb.5
        for <linux-nfs@vger.kernel.org>; Mon, 09 Nov 2020 14:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=S4c8Ma3+Uxm6zEjW2tpsxMYhfMTv7kr8O/sSeQwvLHw=;
        b=ZCITuMjNNWzmnmRBnkMQyaKqvia4zRTvrc/FVTXFd1ZnDZSgpGL9R/3DtVIcWzgICp
         LlWvf/7LwB00dsiLIFbSaZGsLo4//k85IMCF/Gn8g8t0j/xIxmK2F9FmBaA1cFp9v8EV
         tFkiW+b7gW/emGyTlU3K3HmHP2B+bhdvkM9oBf2rEceEjk9OUU8XJlQvc7SK8pA+uDkm
         QZBuohLm3F/txaxWaseSzz57fDIhkd7z3ch5RWPngWmIFNvSP+splhTcR2JPZYKGIhrE
         tD/6zgbqVFIt2J9bFsJCxlsH1V5umGurUzRa5cW4/nsrfASv6aoW/iPQF3DrbbLjMz9E
         QpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=S4c8Ma3+Uxm6zEjW2tpsxMYhfMTv7kr8O/sSeQwvLHw=;
        b=BiFBZO3OXcQYPtvaFfb9+8ivHrjYhspMSN20p7zQch6yY0KgfGUqRSpLgXGnnwaO9c
         5iegzqsGMdZRlO7iv51ymhxm/m5l5W6RnmIQxRv+IOBxLTTXEBodxQMxPsxBEzLDINOJ
         v/C6TH/4RDD3OLxwFqLiO0J4paqnIjh8CI5DKCfhxqKrSwenkfEY6521Qw5+o1iIOgoc
         KjnIWSnMwlSJSTC4F+XtJHmVBX1o/RMBJ0D8jssojz4GhDutJmNIzXeOYMvW2gD2Ye2Q
         L+f7B1NdcIcZTu5eDodsNKppaSJJ5GGtWOrPc/5EIPufuRWs7+dlPCQCDdC88TBUgV6N
         VZag==
X-Gm-Message-State: AOAM531Epc1fNxOL0yIKIuRtCADkTKGn2j87rdPHczp5Oc9tTynh6FqI
        +6o2FOfazxi+mlSvymJxZx3DPV+Bd//6ArydWcg3Q5vw0KA=
X-Google-Smtp-Source: ABdhPJyp31zTUWQ2V2wL+f4WGxEs/tJVohTvghmTgD0AHzQ+kZ5vSPugfo3v4AtkPUt8nl97+v7UTcaY8UUq8Y8N6Lg=
X-Received: by 2002:a17:906:1246:: with SMTP id u6mr17089929eja.432.1604962534872;
 Mon, 09 Nov 2020 14:55:34 -0800 (PST)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 9 Nov 2020 17:55:23 -0500
Message-ID: <CAN-5tyENFaKb=CUZCxkeAqhS7jsFswwaGkPyC0W9h_OJyVrEmw@mail.gmail.com>
Subject: kernel oops in generic/013 on an rdma mount (over either soft roce or iwarp)
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,

generic/013 on 5.10-rc3 under both soft RoCE and iWarp produce the
following kernel oops.
Are you aware of it? 5.9 ran fine. In 5.10-rc1/rc2 both soft RoCE and
iWarp were broken (outside of nfs) so can't test. I'll see what I can
find out more but wanted to run it by you first. Thank you.

[  126.767318] run fstests generic/013 at 2020-11-09 17:03:25
[  126.931805] BUG: unable to handle page fault for address: ffffa085363bb010
[  126.935622] #PF: supervisor write access in kernel mode
[  126.938202] #PF: error_code(0x0003) - permissions violation
[  126.941042] PGD 3fe02067 P4D 3fe02067 PUD 3fe06067 PMD 74e77063 PTE
80000000763bb061
[  126.944882] Oops: 0003 [#1] SMP PTI
[  126.946985] CPU: 0 PID: 2924 Comm: fsstress Not tainted 5.10.0-rc3+ #32
[  126.950482] Hardware name: VMware, Inc. VMware Virtual
Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
[  126.955680] RIP: 0010:rpcrdma_convert_iovs.isra.32+0x125/0x190 [rpcrdma]
[  126.959175] Code: 03 74 70 83 f9 05 74 6b 49 8b 45 18 48 85 c0 74
43 49 8b 4d 10 89 c2 89 ce 81 e6 ff 0f 00 00 85 c0 74 31 bf 00 10 00
00 89 f8 <49> 89 48 10 29 f0 49 c7 40 08 00 00 00 00 39 d0 0f 47 c2 49
83 c0
[  126.968901] RSP: 0018:ffffc32703137a68 EFLAGS: 00010286
[  126.971423] RAX: 0000000000001000 RBX: 0000000000000000 RCX: ffffa08542daf000
[  126.974807] RDX: 00000000f34df06c RSI: 0000000000000000 RDI: 0000000000001000
[  126.978224] RBP: 0000000000000000 R08: ffffa085363bb000 R09: 0000000000001000
[  126.982701] R10: ffffeef9c0006f48 R11: ffffa0853ffd60c0 R12: 000000000000cb35
[  126.986327] R13: ffffa0853628a060 R14: ffffa08534f195d0 R15: ffffa0851e213358
[  126.989769] FS:  00007fab74973740(0000) GS:ffffa0853be00000(0000)
knlGS:0000000000000000
[  126.993803] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  126.996953] CR2: ffffa085363bb010 CR3: 0000000074fd0002 CR4: 00000000001706f0
[  127.000593] Call Trace:
[  127.001907]  rpcrdma_marshal_req+0x4b9/0xb30 [rpcrdma]
[  127.004789]  ? lock_timer_base+0x67/0x80
[  127.006710]  xprt_rdma_send_request+0x48/0xd0 [rpcrdma]
[  127.009257]  xprt_transmit+0x130/0x3f0 [sunrpc]
[  127.011499]  ? rpc_clnt_swap_deactivate+0x30/0x30 [sunrpc]
[  127.014225]  ?
rpc_wake_up_task_on_wq_queue_action_locked+0x230/0x230 [sunrpc]
[  127.017848]  call_transmit+0x63/0x70 [sunrpc]
[  127.019973]  __rpc_execute+0x75/0x3e0 [sunrpc]
[  127.022135]  ? xprt_iter_get_helper+0x17/0x30 [sunrpc]
[  127.024793]  rpc_run_task+0x153/0x170 [sunrpc]
[  127.027098]  nfs4_call_sync_custom+0xb/0x30 [nfsv4]
[  127.029617]  nfs4_do_call_sync+0x69/0x90 [nfsv4]
[  127.032001]  _nfs42_proc_listxattrs+0x143/0x200 [nfsv4]
[  127.034766]  nfs42_proc_listxattrs+0x8e/0xc0 [nfsv4]
[  127.037160]  nfs4_listxattr+0x1b8/0x210 [nfsv4]
[  127.039454]  ? __check_object_size+0x162/0x180
[  127.041606]  listxattr+0xd1/0xf0
[  127.043163]  path_listxattr+0x5f/0xb0
[  127.044969]  do_syscall_64+0x33/0x40
[  127.047200]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  127.049644] RIP: 0033:0x7fab74296c8b
[  127.051440] Code: f0 ff ff 73 01 c3 48 8b 0d fa 21 2c 00 f7 d8 64
89 01 48 83 c8 ff c3 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 c2 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cd 21 2c 00 f7 d8 64 89
01 48
[  127.060978] RSP: 002b:00007fffcddc4a38 EFLAGS: 00000202 ORIG_RAX:
00000000000000c2
[  127.064848] RAX: ffffffffffffffda RBX: 000000000000002a RCX: 00007fab74296c8b
[  127.068244] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000674440
[  127.071642] RBP: 00000000000001f4 R08: 0000000000000000 R09: 00007fffcddc4687
[  127.075214] R10: 0000000000000004 R11: 0000000000000202 R12: 000000000000002a
[  127.078667] R13: 0000000000403e60 R14: 0000000000000000 R15: 0000000000000000
[  127.082783] Modules linked in: cts rpcsec_gss_krb5 nfsv4
dns_resolver nfs lockd grace nfs_ssc rpcrdma rdma_rxe ip6_udp_tunnel
udp_tunnel rdma_ucm rdma_cm iw_cm ib_cm ib_uverbs ib_core nls_utf8
isofs fuse rfcomm nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 tun bridge stp llc
ip6_tables nft_compat ip_set nf_tables nfnetlink bnep
vmw_vsock_vmci_transport vsock snd_seq_midi snd_seq_midi_event
intel_rapl_msr intel_rapl_common crct10dif_pclmul crc32_pclmul
vmw_balloon ghash_clmulni_intel joydev btusb btrtl pcspkr btbcm
btintel uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2
videobuf2_common videodev snd_ens1371 bluetooth snd_ac97_codec
ac97_bus rfkill mc snd_seq snd_pcm ecdh_generic ecc snd_timer
snd_rawmidi snd_seq_device snd soundcore vmw_vmci i2c_piix4
auth_rpcgss sunrpc ip_tables xfs libcrc32c sr_mod cdrom sg ata_generic
vmwgfx drm_kms_helper nvme crc32c_intel serio_raw
[  127.082841]  syscopyarea sysfillrect sysimgblt fb_sys_fops
nvme_core t10_pi cec vmxnet3 ata_piix ahci libahci ttm libata drm
[  127.132635] CR2: ffffa085363bb010
[  127.134527] ---[ end trace 912ce02a00d98fdf ]---
