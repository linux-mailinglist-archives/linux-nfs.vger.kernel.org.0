Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 253307CA3B
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jul 2019 19:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfGaRY3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Jul 2019 13:24:29 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:47024 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfGaRY3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 31 Jul 2019 13:24:29 -0400
Received: by mail-vs1-f66.google.com with SMTP id r3so46690783vsr.13
        for <linux-nfs@vger.kernel.org>; Wed, 31 Jul 2019 10:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kx5wxXJ51/zYLK0cenUyBttcZmGgEo9Qwx1vmwD9abo=;
        b=otrivYjyKJcB7ltzOVaAtYltAe13J2hdkl0PQE81EfVdpE+mA1Cf4L1+FUxDbWD8PX
         F5l8HUkdBjCr6wTJ8sTOWyioHuPzng1cEgRGc/9vqRA7IAtb945BSAeuqVCQFOsz42mo
         sllHJGafsN3avi8+fOcLtZhYupvuve1DkDMElIJ5t3N+pjnTTtsK32J86yF/qMstapcO
         Rst4qs6OorBNYSuYbmXZao7g4c+pfIjUyVl/GTCQFxo0w8txYESiqcABEOhIO0PCVNOR
         0iK0v8nzIovs2Ydi6vHc3DCvgzRhh0rig2z6lk2TBW7rHL4HC1QNGy5I+ye5iuJM0Edi
         oRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kx5wxXJ51/zYLK0cenUyBttcZmGgEo9Qwx1vmwD9abo=;
        b=HE7fouL8GqvOLSfRSz0hkB0CopYptA/Rszo4+N3ELiNnbyecpJLAGSG9H0DMR/uuSI
         I4/gYdtqDXKCI7d5QzYeNeP8CU/PN+0n9zNSjqGpJap5VxobMvpz9ux+aWdj53KCbFpw
         jPXcsRkefYrNBDbeEAETW1wzpkvqPXLKkpxx+69U77MHBrHJpcY/Q8Cr8VNQoPE2jp6d
         ZbGEnoj7C3u1BEX5KFm6z4ypxfofpjgA675qA+L4ky0sTYcMzGyjCXPwDBFxJEJmDP7E
         POgrpzKwolMm2PnFS3M/W3Btq2KSsuHS36fRnMmD1+5uKdW9IKyd+dSfSL7R9r2pddt7
         Hulw==
X-Gm-Message-State: APjAAAVLNQAwEYiSDV6xead6HYsp2KxiWIci/uvDN4gjzFdv5uGf7pV4
        pM4ZEGDs5qRHBdBaLahHdWvMqi87zmciGgC61iQ=
X-Google-Smtp-Source: APXvYqzWiks3fSW1gtC0+C+5z8nCUgvFc/nP/gLMsd65LSirTGQ4lG4q1lFUhzDSSDw2PDlX3/ff/msoV7cWUVEVhjE=
X-Received: by 2002:a67:79d4:: with SMTP id u203mr77836234vsc.85.1564593868029;
 Wed, 31 Jul 2019 10:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyF7S1wU05Q6=L=0QSYr6pmAj67AcCxhRsLZFqHbGoJwgg@mail.gmail.com>
In-Reply-To: <CAN-5tyF7S1wU05Q6=L=0QSYr6pmAj67AcCxhRsLZFqHbGoJwgg@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 31 Jul 2019 13:24:16 -0400
Message-ID: <CAN-5tyGn9YT1pnBPeiWKC9BskgKT9TjBhYxA0UGBi5qMdmji1w@mail.gmail.com>
Subject: Re: oops in 5.2-rc7
To:     trond.myklebust@hammerspace.com,
        Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Trond,

The following commit causes this oops

commit 814f415609a351e859caee6d6c8749655b204720 (HEAD -> 07312019-deleteme-1)
Author: Trond Myklebust <trond.myklebust@hammerspace.com>
Date:   Thu Jun 27 06:41:45 2019 -0400

    NFSv4: Handle the special Linux file open access mode

    According to the open() manpage, Linux reserves the access mode 3
    to mean "check for read and write permission on the file and return
    a file descriptor that can't be used for reading or writing."

    Currently, the NFSv4 code will ask the server to open the file,
    and will use an incorrect share access mode of 0. Since it has
    an incorrect share access mode, the client later forgets to send
    a corresponding close, meaning it can leak stateids on the server.

    Fixes: ce4ef7c0a8a05 ("NFS: Split out NFS v4 file operations")
    Cc: stable@vger.kernel.org # 3.6+
    Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

On Tue, Jul 30, 2019 at 4:49 PM Olga Kornievskaia <aglo@umich.edu> wrote:
>
> I'm running into the following oops running nfstest_posix tests on
> Trond's testing branch commit
> d5b9216fd5114be4ed98ca9c1ecc5f164cd8cf5e.  I'll go ahead and see what
> patch introduced this but for another data point 5.2-rc5 was OK.
>
> unknown000C29789DA7 login: [ 2726.940822] BUG: kernel NULL pointer
> dereference, address: 0000000000000040
> [ 2726.946600] #PF: supervisor read access in kernel mode
> [ 2726.949607] #PF: error_code(0x0000) - not-present page
> [ 2726.952974] PGD 0 P4D 0
> [ 2726.954779] Oops: 0000 [#1] SMP PTI
> [ 2726.957452] CPU: 0 PID: 4556 Comm: python Not tainted 5.2.0-rc7+ #35
> [ 2726.962258] Hardware name: VMware, Inc. VMware Virtual
> Platform/440BX Desktop Reference Platform, BIOS 6.00 04/13/2018
> [ 2726.969821] RIP: 0010:nfs4_do_setattr+0x18f/0x420 [nfsv4]
> [ 2726.972969] Code: be 02 00 00 00 48 89 df 4c 89 fa e8 8b 93 01 00
> 84 c0 0f 85 30 01 00 00 48 8b 44 24 30 48 85 c0 0f 84 f7 00 00 00 48
> 8b 40 60 <48> 8b 40 40 f6 c4 02 0f 85 35 02 00 00 48 8b 7c 24 30 e8 0a
> 7a fa
> [ 2726.982348] RSP: 0018:ffffa303c270bad0 EFLAGS: 00010286
> [ 2726.984766] RAX: 0000000000000000 RBX: ffff93237ab4fd98 RCX: ffffa303c270bb08
> [ 2726.988368] RDX: ffffa303c270bbb8 RSI: 0000000000000002 RDI: 0000000000000000
> [ 2726.992911] RBP: ffffa303c270bc28 R08: ffff9323729f1200 R09: 0000000000000000
> [ 2726.997324] R10: 0008000000000000 R11: ffffffffc08f1d40 R12: ffff9323790c6800
> [ 2727.001705] R13: ffffa303c270bba0 R14: 00000001002508f0 R15: ffffa303c270bbb8
> [ 2727.006000] FS:  00007f867f7fb580(0000) GS:ffff93237cc00000(0000)
> knlGS:0000000000000000
> [ 2727.010822] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2727.014354] CR2: 0000000000000040 CR3: 00000000031b0002 CR4: 00000000001606f0
> [ 2727.018261] Call Trace:
> [ 2727.019565]  nfs4_proc_setattr+0xb5/0x150 [nfsv4]
> [ 2727.021728]  nfs_setattr+0xdf/0x1d0 [nfs]
> [ 2727.023654]  notify_change+0x2cf/0x460
> [ 2727.025865]  do_truncate+0x74/0xc0
> [ 2727.027399]  path_openat+0xbe3/0xe40
> [ 2727.029250]  do_filp_open+0x93/0x100
> [ 2727.030883]  do_sys_open+0x186/0x220
> [ 2727.032622]  do_syscall_64+0x55/0x1a0
> [ 2727.034353]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 2727.039647] RIP: 0033:0x7f867effa2af
> [ 2727.041899] Code: 52 89 f0 25 00 00 41 00 3d 00 00 41 00 74 44 8b
> 05 a6 d1 20 00 85 c0 75 65 89 f2 b8 01 01 00 00 48 89 fe bf 9c ff ff
> ff 0f 05 <48> 3d 00 f0 ff ff 0f 87 9d 00 00 00 48 8b 4c 24 28 64 48 33
> 0c 25
> [ 2727.053137] RSP: 002b:00007fff329ec520 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000101
> [ 2727.057740] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f867effa2af
> [ 2727.061558] RDX: 0000000000000203 RSI: 000056124897a390 RDI: 00000000ffffff9c
> [ 2727.064591] RBP: 00005612485692f0 R08: 00005612489e0c30 R09: 0000000000000003
> [ 2727.067803] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f867878e500
> [ 2727.071309] R13: 00007f867df88fc0 R14: 00005612485692f0 R15: 00007f867f7b3b48
> [ 2727.074347] Modules linked in: cts rpcsec_gss_krb5 nfsv4
> dns_resolver nfs lockd grace fuse rfcomm bridge stp llc nf_tables
> nfnetlink bnep snd_seq_midi snd_seq_midi_event crct10dif_pclmul
> crc32_pclmul ghash_clmulni_intel aesni_intel vmw_balloon glue_helper
> crypto_simd cryptd btusb btrtl btbcm pcspkr btintel snd_ens1371
> bluetooth snd_ac97_codec ac97_bus uvcvideo snd_seq videobuf2_vmalloc
> videobuf2_memops rfkill videobuf2_v4l2 snd_pcm videodev ecdh_generic
> snd_timer videobuf2_common ecc snd_rawmidi snd_seq_device snd
> soundcore vmw_vmci i2c_piix4 auth_rpcgss sunrpc ip_tables xfs
> libcrc32c sd_mod sr_mod cdrom vmwgfx ata_generic pata_acpi
> drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm
> crc32c_intel drm mptspi scsi_transport_spi mptscsih serio_raw i2c_core
> e1000 ata_piix mptbase libata dm_mirror dm_region_hash dm_log dm_mod
> [ 2727.104414] CR2: 0000000000000040
> [ 2727.106856] ---[ end trace 67bd5a3a86242a9d ]---
