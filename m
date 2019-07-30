Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 179287B485
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jul 2019 22:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbfG3UuA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Jul 2019 16:50:00 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:42837 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbfG3UuA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 Jul 2019 16:50:00 -0400
Received: by mail-vk1-f193.google.com with SMTP id 130so13152883vkn.9
        for <linux-nfs@vger.kernel.org>; Tue, 30 Jul 2019 13:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=7O0xpR9ISxJJt1qBQGL/TmB8JotWJ/Wmqn/qCFqoLEg=;
        b=RuKL3QCvAxuSPyEmAkggDveYyZDZfa+Cs9nwRALPU4eQJuEFlcGL0s+Nwo5F0q1Zwh
         7m4QunQqXVMHRq8DE7F4l/33fzbLV7Tu9ld3oG5VzxF+GbuyNVk6XHVOfc8KcSDfTqVQ
         0uihBlRC1CTr4jZYnHlEAowLwfi07jSG5gsL2hCz+YvkvIV7QHUUW81rZ9ASxP0aCws7
         aEstwhI1ztiR8BcfCOJ0P5sz5Wl9SweUuMCkooDVGt71lZ00joq9VFen/PC7X310yKK1
         hBbo0927Tx+/EoDgntTwT4bbXW59S0QKiqggaV0APsz5dXwacmCp9RbdELyahx0tJjgR
         03Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=7O0xpR9ISxJJt1qBQGL/TmB8JotWJ/Wmqn/qCFqoLEg=;
        b=r1AfSbbg1OIchKtudR/B3bjphlKacEI+bCoh1WLQEczEKkTgZC5Ds7jwENsDAloqZr
         mhakH1btFrjc9Y1xEApk+6EkTlSPGltyZ//raj+6l4SrTQS9RyLMGxvcLdAz60UMiuSk
         dA32rxo33u8W8Sfw3eBDnA69qKZqv/r8iZac0TgpltW2S8XWLmngKuuDBy+w4TwhTgUc
         /NuQtadcyBx8HwFDyaEx/K6hyXEYO2FETRRtNvYzOJwBYoNBzW89Ht4919yWoltKxqbV
         6M4FaIChP/nxov2wHZeIJBmO/4rhvElYzuE43DAuN0qYrBGDHL2wd7gX7DXtMQtMcdKv
         ua9g==
X-Gm-Message-State: APjAAAWEr0Tqn4TT3ocWX5opwF6DulbcZzUI17dvnn6vUqwUnpCvDzbv
        EZpblNhxrPzOoIuS+pwDXFqP5/xcNxjG1QSNYBvBUj9W
X-Google-Smtp-Source: APXvYqx8ClJlmWo4T7YJLLfnmyT2Z/7t+HCisErGtEZFm1EhS4XII6DLvGyEAAqMepNQFFdmwnZEaEG8MRe267vHWUI=
X-Received: by 2002:a1f:a043:: with SMTP id j64mr45223144vke.87.1564519799473;
 Tue, 30 Jul 2019 13:49:59 -0700 (PDT)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 30 Jul 2019 16:49:48 -0400
Message-ID: <CAN-5tyF7S1wU05Q6=L=0QSYr6pmAj67AcCxhRsLZFqHbGoJwgg@mail.gmail.com>
Subject: oops in 5.2-rc7
To:     trond.myklebust@hammerspace.com,
        Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I'm running into the following oops running nfstest_posix tests on
Trond's testing branch commit
d5b9216fd5114be4ed98ca9c1ecc5f164cd8cf5e.  I'll go ahead and see what
patch introduced this but for another data point 5.2-rc5 was OK.

unknown000C29789DA7 login: [ 2726.940822] BUG: kernel NULL pointer
dereference, address: 0000000000000040
[ 2726.946600] #PF: supervisor read access in kernel mode
[ 2726.949607] #PF: error_code(0x0000) - not-present page
[ 2726.952974] PGD 0 P4D 0
[ 2726.954779] Oops: 0000 [#1] SMP PTI
[ 2726.957452] CPU: 0 PID: 4556 Comm: python Not tainted 5.2.0-rc7+ #35
[ 2726.962258] Hardware name: VMware, Inc. VMware Virtual
Platform/440BX Desktop Reference Platform, BIOS 6.00 04/13/2018
[ 2726.969821] RIP: 0010:nfs4_do_setattr+0x18f/0x420 [nfsv4]
[ 2726.972969] Code: be 02 00 00 00 48 89 df 4c 89 fa e8 8b 93 01 00
84 c0 0f 85 30 01 00 00 48 8b 44 24 30 48 85 c0 0f 84 f7 00 00 00 48
8b 40 60 <48> 8b 40 40 f6 c4 02 0f 85 35 02 00 00 48 8b 7c 24 30 e8 0a
7a fa
[ 2726.982348] RSP: 0018:ffffa303c270bad0 EFLAGS: 00010286
[ 2726.984766] RAX: 0000000000000000 RBX: ffff93237ab4fd98 RCX: ffffa303c270bb08
[ 2726.988368] RDX: ffffa303c270bbb8 RSI: 0000000000000002 RDI: 0000000000000000
[ 2726.992911] RBP: ffffa303c270bc28 R08: ffff9323729f1200 R09: 0000000000000000
[ 2726.997324] R10: 0008000000000000 R11: ffffffffc08f1d40 R12: ffff9323790c6800
[ 2727.001705] R13: ffffa303c270bba0 R14: 00000001002508f0 R15: ffffa303c270bbb8
[ 2727.006000] FS:  00007f867f7fb580(0000) GS:ffff93237cc00000(0000)
knlGS:0000000000000000
[ 2727.010822] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2727.014354] CR2: 0000000000000040 CR3: 00000000031b0002 CR4: 00000000001606f0
[ 2727.018261] Call Trace:
[ 2727.019565]  nfs4_proc_setattr+0xb5/0x150 [nfsv4]
[ 2727.021728]  nfs_setattr+0xdf/0x1d0 [nfs]
[ 2727.023654]  notify_change+0x2cf/0x460
[ 2727.025865]  do_truncate+0x74/0xc0
[ 2727.027399]  path_openat+0xbe3/0xe40
[ 2727.029250]  do_filp_open+0x93/0x100
[ 2727.030883]  do_sys_open+0x186/0x220
[ 2727.032622]  do_syscall_64+0x55/0x1a0
[ 2727.034353]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 2727.039647] RIP: 0033:0x7f867effa2af
[ 2727.041899] Code: 52 89 f0 25 00 00 41 00 3d 00 00 41 00 74 44 8b
05 a6 d1 20 00 85 c0 75 65 89 f2 b8 01 01 00 00 48 89 fe bf 9c ff ff
ff 0f 05 <48> 3d 00 f0 ff ff 0f 87 9d 00 00 00 48 8b 4c 24 28 64 48 33
0c 25
[ 2727.053137] RSP: 002b:00007fff329ec520 EFLAGS: 00000246 ORIG_RAX:
0000000000000101
[ 2727.057740] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f867effa2af
[ 2727.061558] RDX: 0000000000000203 RSI: 000056124897a390 RDI: 00000000ffffff9c
[ 2727.064591] RBP: 00005612485692f0 R08: 00005612489e0c30 R09: 0000000000000003
[ 2727.067803] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f867878e500
[ 2727.071309] R13: 00007f867df88fc0 R14: 00005612485692f0 R15: 00007f867f7b3b48
[ 2727.074347] Modules linked in: cts rpcsec_gss_krb5 nfsv4
dns_resolver nfs lockd grace fuse rfcomm bridge stp llc nf_tables
nfnetlink bnep snd_seq_midi snd_seq_midi_event crct10dif_pclmul
crc32_pclmul ghash_clmulni_intel aesni_intel vmw_balloon glue_helper
crypto_simd cryptd btusb btrtl btbcm pcspkr btintel snd_ens1371
bluetooth snd_ac97_codec ac97_bus uvcvideo snd_seq videobuf2_vmalloc
videobuf2_memops rfkill videobuf2_v4l2 snd_pcm videodev ecdh_generic
snd_timer videobuf2_common ecc snd_rawmidi snd_seq_device snd
soundcore vmw_vmci i2c_piix4 auth_rpcgss sunrpc ip_tables xfs
libcrc32c sd_mod sr_mod cdrom vmwgfx ata_generic pata_acpi
drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm
crc32c_intel drm mptspi scsi_transport_spi mptscsih serio_raw i2c_core
e1000 ata_piix mptbase libata dm_mirror dm_region_hash dm_log dm_mod
[ 2727.104414] CR2: 0000000000000040
[ 2727.106856] ---[ end trace 67bd5a3a86242a9d ]---
