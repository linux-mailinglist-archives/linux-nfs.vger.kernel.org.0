Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109092B0885
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Nov 2020 16:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgKLPhf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Nov 2020 10:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbgKLPhe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Nov 2020 10:37:34 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DE8C0613D1
        for <linux-nfs@vger.kernel.org>; Thu, 12 Nov 2020 07:37:34 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id o21so8473663ejb.3
        for <linux-nfs@vger.kernel.org>; Thu, 12 Nov 2020 07:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=reOQbJ1qPoAx9wt7wKjEUdQJNv2dYpaJ5HDEPBIj45Y=;
        b=CXjjXlHOrBqbmdqViUcGBcOWLEqy+fnLH8blGDGNugW5/915Xt8CDSbK0sRK5jFSsD
         qPatRBEqQnZ0iDCEkgyprdc2kx3crX7ocjjDO+pbvLMgE9athlsYcyupWu0mx0mimP6a
         koio9zlb5ZZkR70BN1bXFVWf1rM4UmNAqe1MjOiT90lbPBNN9zcIvCi58zhrQSfwr6uz
         mRM7b9KruxGFVRyD3dd64Ty2cQoe7KcRAtUT6It5r2WoCxpGfiT/RCXQL+GAgzqvBl8a
         Jnml0aJem2N4NLPCf/qWiPO5iJ5ZP1M58qv7RCeHf6rT3Ohvl3RfscahDap0kKq0q1MN
         p+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=reOQbJ1qPoAx9wt7wKjEUdQJNv2dYpaJ5HDEPBIj45Y=;
        b=arwkurMgmEkQdfZydxzYqrOGVlLxLBd0wXqJ+EDflw8fgk1HKqxWhNx6PbPpLo3Q5t
         WJo/CN4MpWXLs378jFFUFz3BTC5xToAaVQNcWAkN511A4E3mF7FAz57QEnWhIEzwXJ9h
         w1C4ehowElM35mEhzAqsHE9VoixvOSFv1muZlt5V9Qsc5uW22PbynrrCDc69FTVFgTcE
         xN/3y46N2+XseyVFsVGfLCxgSS01Eq4mzy7o+XGShk6magJlPDZQz366XbJmHU28J+B+
         n0pXUeuNaP4zJIkE2YY4ZWtFBkunKp7HwHwA89jW1+NK6Pr1BZh3jltl4gS1Pxhjy3HO
         /M3w==
X-Gm-Message-State: AOAM532moUf34tJ69++OHuJFZt58aA/PiNNcYK0tYj79+5ecmIP/fdXH
        WMFmUnGFrZ8Or4teiJeBBtKxZUW0GcDgvxGne0s=
X-Google-Smtp-Source: ABdhPJy35/jTaT8WQ01dZ7vlpQAt9ACllj9BsFYyDruE2+A8xJf7c4IbDdOFJP7znd2NMzG8H9ty/a23+MQ5sf1sfQE=
X-Received: by 2002:a17:906:ccc5:: with SMTP id ot5mr31907088ejb.248.1605195453044;
 Thu, 12 Nov 2020 07:37:33 -0800 (PST)
MIME-Version: 1.0
References: <CAN-5tyENFaKb=CUZCxkeAqhS7jsFswwaGkPyC0W9h_OJyVrEmw@mail.gmail.com>
 <98BAC3EC-35C5-449F-8476-4B740632DC7C@oracle.com> <CAN-5tyGKXJCWxzDnPfT0v70Ry7QNvSCKRnwyU360aW6nJvN-aA@mail.gmail.com>
 <CAN-5tyFsGBJ3aJC0XVfTOAR219d6jukYZPLvmUGgRFYkraB88A@mail.gmail.com>
 <576A90AD-278A-4738-B437-162C8B931FE0@oracle.com> <CAN-5tyF1mUQ3bgx_5i2SJH=BQ1MH0omHkQq6SmaZw7sS5U_1GA@mail.gmail.com>
 <C452338F-A32A-4F35-BB9C-08104DB91960@oracle.com> <CAN-5tyH0ujGDgowBZi6ykZ52ZFqW7GZJekhb6-oZEuq0XrpaUw@mail.gmail.com>
 <71766FD5-E726-474A-95D8-A86CB6E6AF55@oracle.com> <CAN-5tyGPjbbqybxxBty5VV3ZXvSp4kg+zOS_VV5QnNjpM2F4VA@mail.gmail.com>
 <83E3FB9A-B096-4965-8E2C-9124A8052EBB@oracle.com>
In-Reply-To: <83E3FB9A-B096-4965-8E2C-9124A8052EBB@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 12 Nov 2020 10:37:21 -0500
Message-ID: <CAN-5tyFTbe1jLt=sxsiEBy-u_RN8-bbH13iTsaYPfHj_bEXO_Q@mail.gmail.com>
Subject: Re: kernel oops in generic/013 on an rdma mount (over either soft
 roce or iwarp)
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Nov 12, 2020 at 10:28 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>
>
>
> > On Nov 11, 2020, at 4:42 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
> >
> > On Tue, Nov 10, 2020 at 1:25 PM Chuck Lever <chuck.lever@oracle.com> wrote:
> >
> >> Start by identifying what NFS operation is failing, and what configuration
> >> of chunks it is using.
> >
> > This happens after decoding LIST_XATTRS reply. It's a send only reply.
> > I can't tell if the real problem is in the nfs4_xdr_dec_listxattrs()
> > and it's overwritting memory that messes with rpcrdma_complete_rqst()
> > or it's the rdma problem.
> >
> > Running it with Kasan shows the following:
> >
> > [  538.505743] BUG: KASAN: wild-memory-access in
> > rpcrdma_complete_rqst+0x41b/0x680 [rpcrdma]
> > [  538.512019] Write of size 8 at addr 0005088000000000 by task kworker/1:1H/493
> > [  538.517285]
> > [  538.518219] CPU: 1 PID: 493 Comm: kworker/1:1H Not tainted 5.10.0-rc3+ #33
> > [  538.521811] Hardware name: VMware, Inc. VMware Virtual
> > Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
> > [  538.529220] Workqueue: ib-comp-wq ib_cq_poll_work [ib_core]
> > [  538.532722] Call Trace:
> > [  538.534366]  dump_stack+0x7c/0xa2
> > [  538.536473]  ? rpcrdma_complete_rqst+0x41b/0x680 [rpcrdma]
> > [  538.539514]  ? rpcrdma_complete_rqst+0x41b/0x680 [rpcrdma]
> > [  538.542817]  kasan_report.cold.9+0x6a/0x7c
> > [  538.545952]  ? rpcrdma_complete_rqst+0x41b/0x680 [rpcrdma]
> > [  538.551001]  check_memory_region+0x198/0x200
> > [  538.553763]  memcpy+0x38/0x60
> > [  538.555612]  rpcrdma_complete_rqst+0x41b/0x680 [rpcrdma]
> > [  538.558974]  ? rpcrdma_reset_cwnd+0x70/0x70 [rpcrdma]
> > [  538.562162]  ? ktime_get+0x4f/0xb0
> > [  538.564072]  ? rpcrdma_reply_handler+0x4ca/0x640 [rpcrdma]
> > [  538.567066]  __ib_process_cq+0xa7/0x1f0 [ib_core]
> > [  538.569905]  ib_cq_poll_work+0x31/0xb0 [ib_core]
> > [  538.573151]  process_one_work+0x387/0x680
> > [  538.575798]  worker_thread+0x57/0x5a0
> > [  538.577917]  ? process_one_work+0x680/0x680
> > [  538.581095]  kthread+0x1c8/0x1f0
> > [  538.583271]  ? kthread_parkme+0x40/0x40
> > [  538.585637]  ret_from_fork+0x22/0x30
> > [  538.587688] ==================================================================
> > [  538.591920] Disabling lock debugging due to kernel taint
> > [  538.595267] general protection fault, probably for non-canonical
> > address 0x5088000000000: 0000 [#1] SMP KASAN PTI
> > [  538.601982] CPU: 1 PID: 3623 Comm: fsstress Tainted: G    B
> >    5.10.0-rc3+ #33
> > [  538.609032] Hardware name: VMware, Inc. VMware Virtual
> > Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
> > [  538.619678] RIP: 0010:memcpy_orig+0xf5/0x10f
> > [  538.623892] Code: 00 00 00 00 00 83 fa 04 72 1b 8b 0e 44 8b 44 16
> > fc 89 0f 44 89 44 17 fc c3 66 90 66 2e 0f 1f 84 00 00 00 00 00 83 ea
> > 01 72 19 <0f> b6 0e 74 12 4c 0f b6 46 01 4c 0f b6 0c 16 44 88 47 01 44
> > 88 0c
> > [  538.636726] RSP: 0018:ffff888018707628 EFLAGS: 00010202
> > [  538.641125] RAX: ffff888009098855 RBX: 0000000000000008 RCX: ffffffffc19eca2d
> > [  538.645793] RDX: 0000000000000001 RSI: 0005088000000000 RDI: ffff888009098855
> > [  538.650290] RBP: 0000000000000000 R08: ffffed100121310b R09: ffffed100121310b
> > [  538.654879] R10: ffff888009098856 R11: ffffed100121310a R12: ffff888018707788
> > [  538.658700] R13: ffff888009098858 R14: ffff888009098857 R15: 0000000000000002
> > [  538.662871] FS:  00007f12be1c8740(0000) GS:ffff88805ca40000(0000)
> > knlGS:0000000000000000
> > [  538.667424] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  538.670768] CR2: 00007f12be1c7000 CR3: 000000005c37a004 CR4: 00000000001706e0
> > [  538.675865] Call Trace:
> > [  538.677376]  nfs4_xdr_dec_listxattrs+0x31d/0x3c0 [nfsv4]
> > [  538.681151]  ? nfs4_xdr_dec_read_plus+0x360/0x360 [nfsv4]
> > [  538.684232]  ? xdr_inline_decode+0x1e/0x260 [sunrpc]
> > [  538.687114]  call_decode+0x365/0x390 [sunrpc]
> > [  538.689626]  ? rpc_decode_header+0x770/0x770 [sunrpc]
> > [  538.692410]  ? var_wake_function+0x80/0x80
> > [  538.694634]  ?
> > xprt_request_retransmit_after_disconnect.isra.15+0x5e/0x80 [sunrpc]
> > [  538.698920]  ? rpc_decode_header+0x770/0x770 [sunrpc]
> > [  538.701578]  ? rpc_decode_header+0x770/0x770 [sunrpc]
> > [  538.704252]  __rpc_execute+0x11c/0x6e0 [sunrpc]
> > [  538.706829]  ? trace_event_raw_event_xprt_cong_event+0x270/0x270 [sunrpc]
> > [  538.710654]  ? rpc_make_runnable+0x54/0xe0 [sunrpc]
> > [  538.713416]  rpc_run_task+0x29c/0x2c0 [sunrpc]
> > [  538.715806]  nfs4_call_sync_custom+0xc/0x40 [nfsv4]
> > [  538.718551]  nfs4_do_call_sync+0x114/0x160 [nfsv4]
> > [  538.721571]  ? nfs4_call_sync_custom+0x40/0x40 [nfsv4]
> > [  538.724333]  ? __alloc_pages_nodemask+0x200/0x410
> > [  538.726794]  ? kasan_unpoison_shadow+0x30/0x40
> > [  538.729147]  ? __kasan_kmalloc.constprop.8+0xc1/0xd0
> > [  538.731733]  _nfs42_proc_listxattrs+0x1f6/0x2f0 [nfsv4]
> > [  538.734504]  ? nfs42_offload_cancel_done+0x50/0x50 [nfsv4]
> > [  538.737173]  ? __kernel_text_address+0xe/0x30
> > [  538.739400]  ? unwind_get_return_address+0x2f/0x50
> > [  538.741727]  ? create_prof_cpu_mask+0x20/0x20
> > [  538.744141]  ? stack_trace_consume_entry+0x80/0x80
> > [  538.746585]  ? _raw_spin_lock+0x7a/0xd0
> > [  538.748477]  nfs42_proc_listxattrs+0xf4/0x150 [nfsv4]
> > [  538.750920]  ? nfs42_proc_setxattr+0x150/0x150 [nfsv4]
> > [  538.753557]  ? nfs4_xattr_cache_list+0x91/0x120 [nfsv4]
> > [  538.756313]  nfs4_listxattr+0x34d/0x3d0 [nfsv4]
> > [  538.758506]  ? _nfs4_proc_access+0x260/0x260 [nfsv4]
> > [  538.760859]  ? __ia32_sys_rename+0x40/0x40
> > [  538.762897]  ? selinux_quota_on+0xf0/0xf0
> > [  538.764827]  ? __check_object_size+0x178/0x220
> > [  538.767063]  ? kasan_unpoison_shadow+0x30/0x40
> > [  538.769233]  ? security_inode_listxattr+0x53/0x60
> > [  538.771962]  listxattr+0x5b/0xf0
> > [  538.773980]  path_listxattr+0xa1/0x100
> > [  538.776147]  ? listxattr+0xf0/0xf0
> > [  538.778064]  do_syscall_64+0x33/0x40
> > [  538.780714]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > [  538.783440] RIP: 0033:0x7f12bdaebc8b
> > [  538.785341] Code: f0 ff ff 73 01 c3 48 8b 0d fa 21 2c 00 f7 d8 64
> > 89 01 48 83 c8 ff c3 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 c2 00 00
> > 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cd 21 2c 00 f7 d8 64 89
> > 01 48
> > [  538.794845] RSP: 002b:00007ffc7947cff8 EFLAGS: 00000206 ORIG_RAX:
> > 00000000000000c2
> > [  538.798985] RAX: ffffffffffffffda RBX: 0000000001454650 RCX: 00007f12bdaebc8b
> > [  538.802840] RDX: 0000000000000018 RSI: 000000000145c150 RDI: 0000000001454650
> > [  538.807093] RBP: 000000000145c150 R08: 00007f12bddaeba0 R09: 00007ffc7947cc46
> > [  538.811487] R10: 0000000000000000 R11: 0000000000000206 R12: 00000000000002dd
> > [  538.816713] R13: 0000000000000018 R14: 0000000000000018 R15: 0000000000000000
> > [  538.820437] Modules linked in: rpcrdma rdma_rxe ip6_udp_tunnel
> > udp_tunnel rdma_ucm rdma_cm iw_cm ib_cm ib_uverbs ib_core cts
> > rpcsec_gss_krb5 nfsv4 dns_resolver nfs lockd grace nfs_ssc nls_utf8
> > isofs fuse rfcomm nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
> > nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
> > nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 tun bridge stp llc
> > ip6_tables nft_compat ip_set nf_tables nfnetlink bnep
> > vmw_vsock_vmci_transport vsock snd_seq_midi snd_seq_midi_event
> > intel_rapl_msr intel_rapl_common crct10dif_pclmul crc32_pclmul
> > vmw_balloon ghash_clmulni_intel joydev pcspkr btusb uvcvideo btrtl
> > btbcm btintel videobuf2_vmalloc videobuf2_memops videobuf2_v4l2
> > videobuf2_common snd_ens1371 snd_ac97_codec ac97_bus snd_seq snd_pcm
> > videodev bluetooth mc rfkill ecdh_generic ecc snd_timer snd_rawmidi
> > snd_seq_device snd soundcore vmw_vmci i2c_piix4 auth_rpcgss sunrpc
> > ip_tables xfs libcrc32c sr_mod cdrom sg crc32c_intel ata_generic
> > serio_raw nvme vmwgfx drm_kms_helper
> > [  538.820577]  syscopyarea sysfillrect sysimgblt fb_sys_fops cec
> > nvme_core t10_pi ata_piix ahci libahci ttm vmxnet3 drm libata
> > [  538.869541] ---[ end trace 4abb2d95a72e9aab ]---
>
> I'm running a v5.10-rc3 client now with the fix applied and
> KASAN enabled. I traced my xfstests run and I'm definitely
> exercising the LISTXATTRS path:
>
> # trace-cmd report -F rpc_request | grep LISTXATTR | wc -l
> 462
>
> No crash or KASAN splat. I'm still missing something.
>
> I sometimes apply small patches from the mailing list by hand
> editing the modified file. Are you sure you applied my fix
> correctly?

Again I think the difference is the SoftRoce vs hardware (I still have
no ability to test this on hardware). I ran tcp mount with KASAN and
generic/013 doesn't trigger anything. Something about softRoCE (or
iWarp) that either reveals a problem about the NFS code or perhaps
it's softRoCE but KASAN is typically good in identifying the
problematic spot.

>
>
> --
> Chuck Lever
>
>
>
