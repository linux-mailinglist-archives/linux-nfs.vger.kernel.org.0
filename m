Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7E134D977
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Mar 2021 23:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhC2VL7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Mar 2021 17:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhC2VLt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Mar 2021 17:11:49 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99A6C061574
        for <linux-nfs@vger.kernel.org>; Mon, 29 Mar 2021 14:11:48 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id w10so5895029pgh.5
        for <linux-nfs@vger.kernel.org>; Mon, 29 Mar 2021 14:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=AE6RRevfayyh3KJx7rJSBJRoSjIwwUw5t73Z3ZwIv/Y=;
        b=P9az7uRZ0x2aGSkIcohMTDDkG+jcrunAk3t2Z85qGY57mvd4js5BdvJlUJh4KzsCvJ
         pe6lLQ0NdwVh9sXufGp+b4tRmj/495CoV5i3roT1qRFYi4R3lhsiVSp3TOCnCZ5y3Syq
         AKmFMdrE5fHgPCMgtZw8o5TBpRyp46UM4U+0RXm2i0hiBkF3dn70OFkYVbXi+hnnlF9/
         6ML/jgYDmVIFKZDJRtd1F/kluwZka+XlQilSIUzohebcA/W4SEVNA8zLg4klI4V1k3JH
         QUYmRL8bTAybMWAySfmIkLyg8gK+H4soQXsuXyS8p4t1SwMweIv4IfnlrYAeIGWYkF0N
         GfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=AE6RRevfayyh3KJx7rJSBJRoSjIwwUw5t73Z3ZwIv/Y=;
        b=Qt2lQ3oOnhxweBshGSM2T01uvgTMcA/kNCYrm7q0t9Ucv67dRwwHtEF/Zo+vfaehvv
         xR1yCGAC5LLVnPez7jx1sHKoF8k9qBVeCY/iHcVZTqKgiYgPpzN61M8VETRgII3dvsAn
         bOhHsUJxCNA1HCs6Hx0mqh1VagxAUQNqjR2smfzNR+nd18XhgqXV2eiAoHhkFPn2AgpS
         mTyBg7KY+zS6nJtSHj9jHskQzd+JH7CCEPxcqjAVOceAGIbmqxvOj6rDkmdMpme7dhg7
         q7eK59baeaYUy4enHoElstEqhpm1RSfmFDI6yK3qWu2BLWe2EDhPKTak4aiZmAfUTU++
         qNfw==
X-Gm-Message-State: AOAM530m2uvswTD5x6XFIHF4HIJrEsA2qVCv9f+mGpqVQtMazkRqiorM
        Z9Giv8WaKmVeRCwgWZG4/Bu/ryioiin4pZQjqzU0ALkyhIQ=
X-Google-Smtp-Source: ABdhPJzj2q/Wq8ttEKmFU+hOeDzoT+A4xz/PB4gtPw3GlitxByhx0bk++p5WKn/XKtaRKdlisgOFoPbdNWcS6h66o6k=
X-Received: by 2002:a65:4308:: with SMTP id j8mr26227332pgq.349.1617052308407;
 Mon, 29 Mar 2021 14:11:48 -0700 (PDT)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 29 Mar 2021 17:11:37 -0400
Message-ID: <CAN-5tyHxeLknSxbRb92shQv3hsf146N9wsvEUQ4VEJRGhEXD_g@mail.gmail.com>
Subject: kernel ops from commit 6869c46bd960
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I'm on commit 20e0d860a4217b8e6a2f72852a5d6465e6104078 of your origin/testing

I just did mount -o vers=3,sec=sys <linux_server>:/ /mnt

Got the following oops.

I believe I bisected it to the following commit:
6869c46bd9607787f2f39dabf59da8f34dd3f513 "nfs: hornor timeo and
retrans option when mounting NFSv3"

cb76aa233c4d060b2daa8077a5dc0f414ca682c1 "SUNRPC: Ensure the transport
backchannel association"

[66946.322155] kernel BUG at fs/nfs/client.c:492!
[66946.323863] invalid opcode: 0000 [#1] SMP KASAN PTI
[66946.325630] CPU: 0 PID: 69573 Comm: mount.nfs Tainted: G        W
      5.12.0-rc4+ #86
[66946.328195] Hardware name: VMware, Inc. VMware Virtual
Platform/440BX Desktop Reference Platform, BIOS 6.00 07/22/2020
[66946.331367] RIP: 0010:nfs_init_timeout_values+0x104/0x110 [nfs]
[66946.333501] Code: 00 76 a3 49 c7 45 00 c0 27 09 00 bb c0 27 09 00
eb 94 e8 8f a8 f5 d7 41 bc 03 00 00 00 41 c7 45 18 02 00 00 00 e9 65
ff ff ff <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 b8 00
00 00
[66946.339146] RSP: 0018:ffff888017c17908 EFLAGS: 00010287
[66946.340624] RAX: 0000000000000000 RBX: ffffffffffffff9c RCX: ffffffffc15215a7
[66946.342576] RDX: dffffc0000000000 RSI: 0000000000000011 RDI: ffffffffc158d6a0
[66946.344483] RBP: 00000000ffffffff R08: 6d01a8c000000002 R09: 0000000000000000
[66946.346391] R10: 6d01a8c000000002 R11: 0000000000000000 R12: 00000000ffffffff
[66946.348367] R13: ffffffffc158d6a0 R14: 0000000000000011 R15: ffff888077a97820
[66946.350280] FS:  00007f50b9827880(0000) GS:ffff888059600000(0000)
knlGS:0000000000000000
[66946.352440] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[66946.354087] CR2: 000055aa60e6b000 CR3: 000000000d7e8004 CR4: 00000000001706f0
[66946.356261] Call Trace:
[66946.356943]  nfs_mount+0x297/0x470 [nfs]
[66946.358041]  ? mnt_xdr_dec_mountres+0x130/0x130 [nfs]
[66946.359515]  ? ip_map_cache_destroy+0x80/0x80 [sunrpc]
[66946.361471]  nfs_request_mount.constprop.17+0x205/0x310 [nfs]
[66946.363036]  ? nfs_show_stats+0x7d0/0x7d0 [nfs]
[66946.364352]  ? avc_has_extended_perms+0x760/0x760
[66946.365772]  nfs_try_get_tree+0x18d/0x490 [nfs]
[66946.367058]  ? nfs_get_tree_common+0x690/0x690 [nfs]
[66946.368447]  ? cred_has_capability+0xf4/0x1e0
[66946.369655]  ? _raw_spin_lock+0x7a/0xd0
[66946.370889]  ? _raw_write_lock_bh+0xe0/0xe0
[66946.372022]  ? __kmalloc_track_caller+0x136/0x450
[66946.373365]  ? try_module_get+0x40/0xe0
[66946.374440]  ? get_nfs_version+0x29/0x80 [nfs]
[66946.375711]  ? nfs_get_tree+0x7ca/0xa20 [nfs]
[66946.376982]  vfs_get_tree+0x45/0x120
[66946.377966]  path_mount+0x914/0xd30
[66946.378976]  ? __check_object_size+0x178/0x220
[66946.380201]  ? finish_automount+0x2f0/0x2f0
[66946.381304]  ? strncpy_from_user+0x1e4/0x250
[66946.382584]  ? getname_flags+0x10d/0x2a0
[66946.383642]  ? call_rcu+0x273/0x870
[66946.384675]  do_mount+0xcb/0xf0
[66946.385531]  ? path_mount+0xd30/0xd30
[66946.386524]  ? _copy_from_user+0x4c/0x90
[66946.387605]  ? copy_mount_options+0x59/0x100
[66946.388821]  __x64_sys_mount+0xf4/0x110
[66946.389860]  do_syscall_64+0x33/0x40
[66946.390865]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[66946.392225] RIP: 0033:0x7f50b8cb79ee
[66946.393215] Code: 48 8b 0d 9d f4 2b 00 f7 d8 64 89 01 48 83 c8 ff
c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6a f4 2b 00 f7 d8 64 89
01 48
[66946.398172] RSP: 002b:00007ffe53753188 EFLAGS: 00000246 ORIG_RAX:
00000000000000a5
[66946.400138] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f50b8cb79ee
[66946.402202] RDX: 000055aa60e4a2b0 RSI: 000055aa60e4a290 RDI: 000055aa60e484d0
[66946.404306] RBP: 00007ffe537533a0 R08: 000055aa60e4d180 R09: 000055aa60e4d170
[66946.406418] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f50b98277f8
[66946.408502] R13: 00007ffe537533a0 R14: 00007ffe53753280 R15: 000055aa60e4d140
[66946.410600] Modules linked in: nfsv3 nfs_acl
nfs_layout_nfsv41_files rpcsec_gss_krb5 nfsv4 dns_resolver nfs lockd
grace nfs_ssc fuse rfcomm xt_conntrack nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 ipt_REJECT nf_reject_ipv4 nft_counter nft_compat
nf_tables nfnetlink tun bridge stp llc vmw_vsock_vmci_transport vsock
bnep snd_seq_midi snd_seq_midi_event intel_rapl_msr intel_rapl_common
crct10dif_pclmul crc32_pclmul vmw_balloon ghash_clmulni_intel joydev
pcspkr btusb uvcvideo btrtl btbcm btintel videobuf2_vmalloc
snd_ens1371 videobuf2_memops videobuf2_v4l2 snd_ac97_codec ac97_bus
videobuf2_common snd_seq bluetooth videodev snd_pcm rfkill mc
ecdh_generic ecc snd_timer snd_rawmidi snd_seq_device snd soundcore
i2c_piix4 vmw_vmci auth_rpcgss sunrpc ip_tables xfs libcrc32c sr_mod
cdrom sg ata_generic crc32c_intel vmwgfx drm_kms_helper serio_raw
syscopyarea sysfillrect sysimgblt fb_sys_fops cec ttm nvme nvme_core
t10_pi ahci libahci ata_piix drm vmxnet3 libata
[66946.437026] ---[ end trace b2ce7b83b0ed50dc ]---
