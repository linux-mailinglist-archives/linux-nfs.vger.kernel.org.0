Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF3C1DB7F6
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2020 17:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgETPT4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 May 2020 11:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETPT4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 May 2020 11:19:56 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C72C061A0E
        for <linux-nfs@vger.kernel.org>; Wed, 20 May 2020 08:19:56 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id se13so4273763ejb.9
        for <linux-nfs@vger.kernel.org>; Wed, 20 May 2020 08:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=a+mOeNxuKgTTqQ+aYKTh0lMNfNjS8SY+jsU4q58nU2c=;
        b=rzgaXfQV0bQ0NzoMg/eRWjZfczSfqx9fa7COpgae090kzc9WR/C1frsYiuBJeicHrO
         1U0shUczFjjD/gJCvIdEsvw/VbszkUJxnD/h3jmri1+NNwloOURUM1NKP0Ag4Udc3SPg
         kTUjICvrbG8eMDU6r8wb0ETt2lC3ZENyt2RehEeGmzlgSHzMZadj40BF+s0rg8U6SEsD
         jMWC70D52QGeJ7dcmsLvjTljxCAVCisWDofln3GAX1VvvVZH7Zq8/P/lC63KucY82Ea/
         RM4lle22+CWx5VJTA98lA914MDbuk/gwHqXz5/TVr5R0rKNnOfdyzol8yUd5p9Ee60LR
         sXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=a+mOeNxuKgTTqQ+aYKTh0lMNfNjS8SY+jsU4q58nU2c=;
        b=MhlJYnIZjE1OAhwf8soUJFpk2O/J+UBmu+/q9fIc0jbK+cx4P4k8tFhHO4AD9AOjvc
         jupy+dXt57l0VSzBlR8ga1Kz0HupnfZPKyxvhIVCJJjHjYgrmgMN1OjEP8IRhzdTEWLy
         3onReTUjOCYrjCRN+zSHkmjH1OYKUf7z2lGkOsmVSl+K9wPyfHzGBrmVEKHxt60jMmol
         0zf2CPl5M/8sKaolVGBKGDVprD4YMmzqPIa4TwCPWHne5ZcMIvREVpBXRgphrks5yIoU
         47sQhVA23acmM9u9PziTLpYm9aWyNtF6psqLO5HdhLbNIES9teVBrzdI+Z2d37lqNzst
         XFfg==
X-Gm-Message-State: AOAM532jzFV+OmgJgaW12mk+Bp+kvaTh5p25OCrfdgV1HlVCeGCXPs/J
        LrzvrETrCZnkQKiWGRN90bL9O335j5GRnAhfvSAL8EDT
X-Google-Smtp-Source: ABdhPJy+kZcWZzbeVhY60SUDadQw2VAxhPfJP2VFV+6WrcMe2o/nlYheO1lXa1EkwGJnosfnIUiiP06U1f0eim9U528=
X-Received: by 2002:a17:906:858b:: with SMTP id v11mr3987135ejx.348.1589987994638;
 Wed, 20 May 2020 08:19:54 -0700 (PDT)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 20 May 2020 11:19:43 -0400
Message-ID: <CAN-5tyH=QiviyLQcmzBJpcejNTyXUKPenu3-rUeHOLLut9fX2A@mail.gmail.com>
Subject: kernel oops in rdma in 5.7-rc5
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,

I was running some tests on latest in Trond's origin/testing and got
the following oops. Is this known?

[ 2116.066790] CPU: 1 PID: 429 Comm: kworker/u256:3 Not tainted 5.7.0-rc5 #16
[ 2116.070852] Hardware name: VMware, Inc. VMware Virtual
Platform/440BX Desktop Reference Platform, BIOS 6.00 04/13/2018
[ 2116.077145] Workqueue: rpciod rpc_async_schedule [sunrpc]
[ 2116.080990] RIP: 0010:ib_drain_rq+0x7/0x80 [ib_core]
[ 2116.084088] Code: c6 48 c7 c7 c8 b1 cf c0 31 c0 c6 05 57 85 04 00
01 e8 0d c9 3c e4 0f 0b e9 00 ff ff ff 66 0f 1f 44 00 00 0f 1f 44 00
00 55 53 <48> 8b 07 48 89 fb 48 8b 40 30 48 85 c0 74 53 e8 85 34 f3 e4
48 8b
[ 2116.094874] RSP: 0018:ffffae1bc07e7d80 EFLAGS: 00010292
[ 2116.098270] RAX: ffff99006ffdb800 RBX: ffff99006fff2c00 RCX: 0000000000000000
[ 2116.102803] RDX: 0000000000000000 RSI: 0000000000000207 RDI: 0000000000000000
[ 2116.107521] RBP: ffff990071110800 R08: 0000000000000000 R09: ffff990031b10000
[ 2116.111567] R10: 0000000000000000 R11: 000000000000477d R12: ffff99006ffdb800
[ 2116.115771] R13: ffff99006fff2c00 R14: ffff990071110e40 R15: 0000000000000001
[ 2116.119860] FS:  0000000000000000(0000) GS:ffff99007be40000(0000)
knlGS:0000000000000000
[ 2116.124401] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2116.127864] CR2: 0000000000000000 CR3: 00000000788a2003 CR4: 00000000001606e0
[ 2116.131983] Call Trace:
[ 2116.136671]  rpcrdma_xprt_disconnect+0x52/0x2b0 [rpcrdma]
[ 2116.140171]  ? call_transmit+0xa0/0xa0 [sunrpc]
[ 2116.142819]  xprt_rdma_close+0x17/0x80 [rpcrdma]
[ 2116.145496]  xprt_connect+0x17b/0x1e0 [sunrpc]
[ 2116.148116]  ? call_transmit+0xa0/0xa0 [sunrpc]
[ 2116.150834]  __rpc_execute+0x80/0x430 [sunrpc]
[ 2116.153994]  ? try_to_wake_up+0x62/0x5e0
[ 2116.156374]  rpc_async_schedule+0x29/0x40 [sunrpc]
[ 2116.159099]  process_one_work+0x172/0x380
[ 2116.161591]  worker_thread+0x49/0x3f0
[ 2116.163707]  kthread+0xf8/0x130
[ 2116.165512]  ? max_active_store+0x80/0x80
[ 2116.167892]  ? kthread_bind+0x10/0x10
[ 2116.170231]  ret_from_fork+0x35/0x40
[ 2116.172468] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4
dns_resolver nfs lockd grace fscache ib_isert iscsi_target_mod ib_srpt
target_core_mod rpcrdma ib_srp ib_iser scsi_transport_srp libiscsi
ib_ipoib scsi_transport_iscsi rdma_rxe ib_umad ip6_udp_tunnel
udp_tunnel rdma_ucm rdma_cm iw_cm ib_cm ib_uverbs ib_core tcp_lp
nls_utf8 isofs rfcomm fuse xt_CHECKSUM xt_MASQUERADE tun bridge stp
llc ip6t_rpfilter ipt_REJECT nf_reject_ipv4 ip6t_REJECT nf_reject_ipv6
xt_conntrack ip_set nfnetlink ebtable_nat ebtable_broute ip6table_nat
ip6table_mangle ip6table_security ip6table_raw iptable_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle
iptable_security iptable_raw ebtable_filter ebtables ip6table_filter
ip6_tables iptable_filter vsock_loopback
vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock bnep
sunrpc snd_seq_midi snd_seq_midi_event intel_rapl_msr
intel_rapl_common crc32_pclmul snd_ens1371 snd_ac97_codec
ghash_clmulni_intel ac97_bus snd_rawmidi snd_seq
[ 2116.172559]  btusb btrtl btbcm btintel bluetooth snd_seq_device
uvcvideo snd_pcm videobuf2_vmalloc videobuf2_memops aesni_intel
videobuf2_v4l2 vmw_balloon videobuf2_common videodev crypto_simd
cryptd glue_helper snd_timer snd vmw_vmci mc joydev pcspkr
ecdh_generic ecc rfkill sg soundcore i2c_piix4 ip_tables xfs libcrc32c
sd_mod t10_pi sr_mod crc_t10dif cdrom crct10dif_generic ata_generic
pata_acpi crct10dif_pclmul crct10dif_common vmwgfx crc32c_intel
drm_kms_helper serio_raw syscopyarea sysfillrect sysimgblt fb_sys_fops
ttm e1000 ata_piix drm libata mptspi scsi_transport_spi mptscsih
mptbase dm_mirror dm_region_hash dm_log dm_mod
[ 2116.259736] CR2: 0000000000000000
[ 2116.266264] ---[ end trace f10e2bf40bcc51ad ]---
