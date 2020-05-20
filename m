Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A7C1DBB8D
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2020 19:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgETRdZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 May 2020 13:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETRdY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 May 2020 13:33:24 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF41C061A0E
        for <linux-nfs@vger.kernel.org>; Wed, 20 May 2020 10:33:24 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id x20so4944286ejb.11
        for <linux-nfs@vger.kernel.org>; Wed, 20 May 2020 10:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BPbSPreNceEf1uBxjAvjt+EBFneTVdu8kmd6U+vp8Pg=;
        b=Sw2WHm0S4DMLl5uedhvl9fYtpyHbFMx5+xIzH7Ry4k2L5STWa+mobk4rKIa+FAXXG5
         20GUJFy8Wg43+uhp3vlfexeGs6FFGyAlAlyt/LfOWfEpii3i0GScewJ9sHknvHKYFUC2
         vwimjBaXetSDh96ISwKikqBpTdi4mtZJ+91tQWL1KHM3r3Mk915O5uNNlAOPSjC8258s
         Ohi4B5jYqsEGQxOMLGU4ZrZ+5r0s5a4/+WBeSQaMOS7YBcfmxVfwfQIBK9SqSJuxvABg
         q4KunkuK6qNZe5GehQt24y8U0sqQjqcMXbdZPT6j9ijxBXdPgYwuxj4D/LfNghdPDPOq
         6EIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BPbSPreNceEf1uBxjAvjt+EBFneTVdu8kmd6U+vp8Pg=;
        b=IUx2GGyNSi5+DOirbpHYrEqhrrINR6L4m2bmSJ/TP11FbfUt5Xxnx7nFB4qb/KzcZD
         Bu248vyaTB/Qoso9zfMWMY+VYVRqhg7/TA2NjDDMtU3FWvVm0RWKGdqU7hnFKRqwHp3Q
         mzA6FCZ1cn4PJUDVlRpLU5cyzzje7Zg7X+/2RjuW08xAOwHxvxf+Sc5Js6Vi/CKzyTL6
         Prg2LSTW3yd6al3hV9PII43wFYu8zgKvAr3yxSHUdj4C0dEApWJ4MCaxWp7GV9ORyUED
         FQRHHjEiVLgeDQCCwnbrsyeq029C/o8/jMvsbLY7WjUviQCPVubg/Afa2x5SBveikW3a
         J39w==
X-Gm-Message-State: AOAM532idEBSCiaxueM6p+CVTxJif2Vmw1+F3leVJmW/vDhUwBAQuY+Y
        CWiygWDlznPeBJkrdX8TSH2lFPyMdhsMPHAarI/53njq
X-Google-Smtp-Source: ABdhPJwcCmSB79B7UiJaM9qudHjoNoII1JoBFfJsTOnLZuCxlFUt4L3LTzWUv9TAMALdtmdJcv9EIb5hZSiHljCZI3s=
X-Received: by 2002:a17:906:9157:: with SMTP id y23mr181784ejw.0.1589996002612;
 Wed, 20 May 2020 10:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyH=QiviyLQcmzBJpcejNTyXUKPenu3-rUeHOLLut9fX2A@mail.gmail.com>
 <4A13A8B1-C8DC-434F-936E-627D38DFA86E@oracle.com>
In-Reply-To: <4A13A8B1-C8DC-434F-936E-627D38DFA86E@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 20 May 2020 13:33:11 -0400
Message-ID: <CAN-5tyFSmvHEi9tBz=fvXGcbNhNU4Ogfrff2JnTxHZD88369dA@mail.gmail.com>
Subject: Re: kernel oops in rdma in 5.7-rc5
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, May 20, 2020 at 11:29 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>
>
>
> > On May 20, 2020, at 11:19 AM, Olga Kornievskaia <aglo@umich.edu> wrote:
> >
> > Hi Chuck,
> >
> > I was running some tests on latest in Trond's origin/testing and got
> > the following oops. Is this known?
>
> It is a known issue, but it's been difficult to reproduce. I think it
> can happen when the server disconnects unexpectedly. I have some rather
> fresh patches that might prevent this crash. But because it's so
> intermittent it's not yet clear they are 100% effective. Thus I'd like
> to let them marinate for a while longer.
>
> Do you encounter this crash frequently? If it's a true and royal pain
> I can push what I have to a topic branch on linux-git.

Disclaimer I haven't tested rdma on softroce (or hardware for that
matter) in a long time so I'm not sure if it's a recent problem.

If you are not ready to push out the patches, can I get a tar from you
(again not sure I really need it)?

I'm not sure how easily it's reproduced. My first oops was when
running "nfstest_io", ever since I couldn't even mount and the client
oops-ed every time until I rebooted the server.
The set up is linux-to-linux (soft roce) running: ./nfstest_io -d
/mnt/data -v all -s 1583972683450 -n 10 -r 3600 -e --createlog
--logdir /home/aglo/logs/lock-eagain

After rebooting the system, i can mount, start another nfstest_io run
and it's been running ok for 40mins now (before I hit it in less than
30mins).

My server is currently somewhat dated 5.5-rc5.

>
>
> > [ 2116.066790] CPU: 1 PID: 429 Comm: kworker/u256:3 Not tainted 5.7.0-rc5 #16
> > [ 2116.070852] Hardware name: VMware, Inc. VMware Virtual
> > Platform/440BX Desktop Reference Platform, BIOS 6.00 04/13/2018
> > [ 2116.077145] Workqueue: rpciod rpc_async_schedule [sunrpc]
> > [ 2116.080990] RIP: 0010:ib_drain_rq+0x7/0x80 [ib_core]
> > [ 2116.084088] Code: c6 48 c7 c7 c8 b1 cf c0 31 c0 c6 05 57 85 04 00
> > 01 e8 0d c9 3c e4 0f 0b e9 00 ff ff ff 66 0f 1f 44 00 00 0f 1f 44 00
> > 00 55 53 <48> 8b 07 48 89 fb 48 8b 40 30 48 85 c0 74 53 e8 85 34 f3 e4
> > 48 8b
> > [ 2116.094874] RSP: 0018:ffffae1bc07e7d80 EFLAGS: 00010292
> > [ 2116.098270] RAX: ffff99006ffdb800 RBX: ffff99006fff2c00 RCX: 0000000000000000
> > [ 2116.102803] RDX: 0000000000000000 RSI: 0000000000000207 RDI: 0000000000000000
> > [ 2116.107521] RBP: ffff990071110800 R08: 0000000000000000 R09: ffff990031b10000
> > [ 2116.111567] R10: 0000000000000000 R11: 000000000000477d R12: ffff99006ffdb800
> > [ 2116.115771] R13: ffff99006fff2c00 R14: ffff990071110e40 R15: 0000000000000001
> > [ 2116.119860] FS:  0000000000000000(0000) GS:ffff99007be40000(0000)
> > knlGS:0000000000000000
> > [ 2116.124401] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 2116.127864] CR2: 0000000000000000 CR3: 00000000788a2003 CR4: 00000000001606e0
> > [ 2116.131983] Call Trace:
> > [ 2116.136671]  rpcrdma_xprt_disconnect+0x52/0x2b0 [rpcrdma]
> > [ 2116.140171]  ? call_transmit+0xa0/0xa0 [sunrpc]
> > [ 2116.142819]  xprt_rdma_close+0x17/0x80 [rpcrdma]
> > [ 2116.145496]  xprt_connect+0x17b/0x1e0 [sunrpc]
> > [ 2116.148116]  ? call_transmit+0xa0/0xa0 [sunrpc]
> > [ 2116.150834]  __rpc_execute+0x80/0x430 [sunrpc]
> > [ 2116.153994]  ? try_to_wake_up+0x62/0x5e0
> > [ 2116.156374]  rpc_async_schedule+0x29/0x40 [sunrpc]
> > [ 2116.159099]  process_one_work+0x172/0x380
> > [ 2116.161591]  worker_thread+0x49/0x3f0
> > [ 2116.163707]  kthread+0xf8/0x130
> > [ 2116.165512]  ? max_active_store+0x80/0x80
> > [ 2116.167892]  ? kthread_bind+0x10/0x10
> > [ 2116.170231]  ret_from_fork+0x35/0x40
> > [ 2116.172468] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4
> > dns_resolver nfs lockd grace fscache ib_isert iscsi_target_mod ib_srpt
> > target_core_mod rpcrdma ib_srp ib_iser scsi_transport_srp libiscsi
> > ib_ipoib scsi_transport_iscsi rdma_rxe ib_umad ip6_udp_tunnel
> > udp_tunnel rdma_ucm rdma_cm iw_cm ib_cm ib_uverbs ib_core tcp_lp
> > nls_utf8 isofs rfcomm fuse xt_CHECKSUM xt_MASQUERADE tun bridge stp
> > llc ip6t_rpfilter ipt_REJECT nf_reject_ipv4 ip6t_REJECT nf_reject_ipv6
> > xt_conntrack ip_set nfnetlink ebtable_nat ebtable_broute ip6table_nat
> > ip6table_mangle ip6table_security ip6table_raw iptable_nat nf_nat
> > nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle
> > iptable_security iptable_raw ebtable_filter ebtables ip6table_filter
> > ip6_tables iptable_filter vsock_loopback
> > vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock bnep
> > sunrpc snd_seq_midi snd_seq_midi_event intel_rapl_msr
> > intel_rapl_common crc32_pclmul snd_ens1371 snd_ac97_codec
> > ghash_clmulni_intel ac97_bus snd_rawmidi snd_seq
> > [ 2116.172559]  btusb btrtl btbcm btintel bluetooth snd_seq_device
> > uvcvideo snd_pcm videobuf2_vmalloc videobuf2_memops aesni_intel
> > videobuf2_v4l2 vmw_balloon videobuf2_common videodev crypto_simd
> > cryptd glue_helper snd_timer snd vmw_vmci mc joydev pcspkr
> > ecdh_generic ecc rfkill sg soundcore i2c_piix4 ip_tables xfs libcrc32c
> > sd_mod t10_pi sr_mod crc_t10dif cdrom crct10dif_generic ata_generic
> > pata_acpi crct10dif_pclmul crct10dif_common vmwgfx crc32c_intel
> > drm_kms_helper serio_raw syscopyarea sysfillrect sysimgblt fb_sys_fops
> > ttm e1000 ata_piix drm libata mptspi scsi_transport_spi mptscsih
> > mptbase dm_mirror dm_region_hash dm_log dm_mod
> > [ 2116.259736] CR2: 0000000000000000
> > [ 2116.266264] ---[ end trace f10e2bf40bcc51ad ]---
>
> --
> Chuck Lever
>
>
>
