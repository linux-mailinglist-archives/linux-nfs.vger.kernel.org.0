Return-Path: <linux-nfs+bounces-3282-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588C78C94C0
	for <lists+linux-nfs@lfdr.de>; Sun, 19 May 2024 15:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3A50280D0C
	for <lists+linux-nfs@lfdr.de>; Sun, 19 May 2024 13:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6160446DC;
	Sun, 19 May 2024 13:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2XfCJRO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22ADA2EAE6
	for <linux-nfs@vger.kernel.org>; Sun, 19 May 2024 13:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716124518; cv=none; b=S0rPPO6rD7fBvTsYfCTyy3HoyXk1pohwMBfUU36fOUnJARCBSIA6vNlfJly7shp0vsQjj9uJGUUIPtXUgHr8Vkng6J3JROWOZX4NXG3bQBjoBVB/WLScxlGJB1fgQfK9I+rC9dyi/Bwu0iTJybZcxnPBQad93dYJYETi2yqNFX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716124518; c=relaxed/simple;
	bh=xgQJ6eXncxC6ZmjTHN5ixvYDJTk6yP+O7LBbYWhk0QI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=QY2hOvFZMQGjjp27z4C5F6QjYZOEYRjy2mw0FL0kcRfojX752t9HMqftaID3snYNxxkox7cBnLE3vJhvvSbJpSCimjGCFo4SG7tipd0woae4uia6JxqsQfA2i3HHH7j/A182isZlMcY9x31q00uhZoCeYAuxhPKXQAVl77x7Hjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2XfCJRO; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6a8691d736cso13070896d6.0
        for <linux-nfs@vger.kernel.org>; Sun, 19 May 2024 06:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716124516; x=1716729316; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YxGogxmp6ecV2QRx5AYwS+cYynDZO7hZ7tBBW+keoa4=;
        b=f2XfCJROTbvtB4mTUIGjSkw4jI9/wq3z3CX9V/mEWjZ6FnQphRDP2u0BLMGuSqy/92
         VZs9/ceUSg3RBJRO+l1QjcQo3w371E8D5r+cjo/h0h+SYPQe7Sg6u7Ii/yIWJv9f6U96
         F6IMN63h6cGRCNqUzOVh6aCRMHhlAShPO+ey3NzP8AajZODIiwgUZGNigmo/iwDbo2my
         qn6Z3Ut7SPuPOO19I06NFP0Y4b7P27syI/2qiQ2rYP3K4jbC/xHHByPHRfACz9anJ2k5
         /+fiEU8JzpJqpbSv7euOOZBDxgnP2QFV0PlIatqBCJ++aCaHz7z1X32NMXBU1nQXMC2Y
         3O7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716124516; x=1716729316;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YxGogxmp6ecV2QRx5AYwS+cYynDZO7hZ7tBBW+keoa4=;
        b=e63allOxjSKKBIe99o1fHIHNLtxPd1zWxwFiL8YLWmZQJ1Uefh4nC15APAVFdKOPso
         av2p4AAgie+AUAb+JWzZ41wmZgW2nXAeyhiLCkTgXg/NECOEN77uguJxyxDs9rr1WoIR
         MaVEmEhPhF7Pmx7RQoyib5a1lMNTfsWtmU9YWmQvrfcatJKe4ts/vYY97WevUnI0g25Y
         B3KAhBJueKLXK4lUDiFA3IgJNMDi3GZjfKGMcVqEITHEfTIoYvJR1MRJffAV2mBi/Gy+
         iTrOwMcgaj+9v5HWuakeVDDzo1OyLSqMTb/c9KkUKoyCoCAdpHFRlSY0xCeSigSkPD7C
         4/tA==
X-Forwarded-Encrypted: i=1; AJvYcCXow+MHMAFcwx7LJYmBa0iPl8GIX3CzfDUgbs5f4TI8YMJJWkA3KBPeH7B3GxhtPgd4SCYfCKBqkxzs+Qn8/Xqz7uzahQDm7xUP
X-Gm-Message-State: AOJu0Yw4SpwoSKcZhrKVDIik5Pu5z5FoVoImSjtMBueeKGbygym/F0uz
	LviKX1JaKy90Diky8PZwbLRkj7oDHrzVtsFekki2BwnNi1vQRAwpkbMnW81kot/Jm8MNjecNPXM
	p06EtubA2ZH+QxtRDIioLdZl7cSbueqSO4W1gjQ==
X-Google-Smtp-Source: AGHT+IFu6g5hJtFlUvNvt+NACUgxx+vwMW6EFqb943xh8rhgP9Ud5l9zfMxuOnuEnT6a9Yuo/ViauOGramqCWFl+34I=
X-Received: by 2002:a05:6214:d09:b0:6a0:b93f:e678 with SMTP id
 6a1803df08f44-6a84202cf90mr75815166d6.10.1716124515751; Sun, 19 May 2024
 06:15:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK2bqVJoT3yy2m0OmTnqH9EAKkj6O1iTk42EyyMtvvxKh6YDKg@mail.gmail.com>
 <CAK2bqV+FA-bcBXeOAT93Y=-6fyXOP38yoYgH_4O+waygWLbnEg@mail.gmail.com>
In-Reply-To: <CAK2bqV+FA-bcBXeOAT93Y=-6fyXOP38yoYgH_4O+waygWLbnEg@mail.gmail.com>
From: Chris Rankin <rankincj@gmail.com>
Date: Sun, 19 May 2024 14:15:04 +0100
Message-ID: <CAK2bqVJ+GgWtjvy4wGzGqAvwoCrH2Hmo6W5oT6wu_0LXzUV3VA@mail.gmail.com>
Subject: Re: [BUG] Linux 6.8.10 NPE
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

FWIW the problem appears to be with linux-6.8/fs/nfsd/stats.c#L38:

        struct nfsd_net *nn = net_generic(net, nfsd_net_id);

although the value of the "net" variable looks reasonable.

Cheers,
Chris

On Sun, 19 May 2024 at 13:26, Chris Rankin <rankincj@gmail.com> wrote:
>
> Hi,
>
> CC after emailing both linux-kernel and stable.
>
> Cheers,
> Chris
>
> ---------- Forwarded message ---------
> From: Chris Rankin <rankincj@gmail.com>
> Date: Sat, 18 May 2024 at 13:53
> Subject: [BUG] Linux 6.8.10 NPE
> To: LKML <linux-kernel@vger.kernel.org>, Linux Stable <stable@vger.kernel.org>
>
> Hi,
>
> I am using vanilla Linux 6.8.10, and I've just noticed this BUG in my
> dmesg log. I have no idea what triggered it, and especially since I
> have not even mounted any NFS filesystems?!
>
> Cheers,
> Chris
>
> [ 9114.607417] BUG: kernel NULL pointer dereference, address: 0000000000000068
> [ 9114.613082] #PF: supervisor read access in kernel mode
> [ 9114.616929] #PF: error_code(0x0000) - not-present page
> [ 9114.620775] PGD 0 P4D 0
> [ 9114.622013] Oops: 0000 [#16] PREEMPT SMP PTI
> [ 9114.624987] CPU: 2 PID: 16501 Comm: sadc Tainted: G      D   I
>   6.8.10 #1
> [ 9114.630993] Hardware name: Gigabyte Technology Co., Ltd.
> EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
> [ 9114.638561] RIP: 0010:nfsd_show+0x39/0x18e [nfsd]
> [ 9114.642026] Code: fb 48 83 ec 10 48 8b 47 70 8b 2d 34 9b 03 00 48
> 8b 80 b0 00 00 00 4c 8b a0 60 02 00 00 e8 99 84 f2 df 49 8b 84 24 f8
> 0b 00 00 <48> 8b 2c e8 e8 6d c0 f2 df 48 8d bd 00 03 00 00 e8 8f ff ff
> ff 48
> [ 9114.659472] RSP: 0018:ffffc9000b1afcf8 EFLAGS: 00010202
> [ 9114.663405] RAX: 0000000000000000 RBX: ffff88810cd5de80 RCX: 0000000000001000
> [ 9114.669239] RDX: ffff88813f45b900 RSI: 0000000000000001 RDI: ffff88810cd5de80
> [ 9114.675069] RBP: 000000000000000d R08: 0000000000400cc0 R09: 00000000ffffffff
> [ 9114.680905] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffffa11e51e0
> [ 9114.686737] R13: ffffc9000b1afef8 R14: ffff88810cd5de80 R15: ffffffff81a2a520
> [ 9114.692586] FS:  00007f3637e49740(0000) GS:ffff888343c80000(0000)
> knlGS:0000000000000000
> [ 9114.699370] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 9114.703809] CR2: 0000000000000068 CR3: 000000027a18c000 CR4: 00000000000006f0
> [ 9114.709642] Call Trace:
> [ 9114.710798]  <TASK>
> [ 9114.711602]  ? __die_body+0x1a/0x5c
> [ 9114.713802]  ? page_fault_oops+0x321/0x36e
> [ 9114.716636]  ? exc_page_fault+0x105/0x117
> [ 9114.719348]  ? asm_exc_page_fault+0x22/0x30
> [ 9114.722237]  ? nfsd_show+0x39/0x18e [nfsd]
> [ 9114.725103]  ? nfsd_show+0x31/0x18e [nfsd]
> [ 9114.727954]  seq_read_iter+0x171/0x353
> [ 9114.730410]  seq_read+0xe0/0x108
> [ 9114.732350]  ? startup_64+0x1/0x60
> [ 9114.734458]  proc_reg_read+0x8c/0xa7
> [ 9114.736746]  vfs_read+0xa6/0x1bf
> [ 9114.738685]  ? __do_sys_newfstat+0x34/0x5c
> [ 9114.741486]  ksys_read+0x74/0xc0
> [ 9114.743418]  do_syscall_64+0x6c/0xdc
> [ 9114.745695]  entry_SYSCALL_64_after_hwframe+0x60/0x68
> [ 9114.749449] RIP: 0033:0x7f3638039cc1
> [ 9114.751752] Code: 00 48 8b 15 59 81 0d 00 f7 d8 64 89 02 b8 ff ff
> ff ff eb bd e8 b0 aa 01 00 f3 0f 1e fa 80 3d 85 03 0e 00 00 74 13 31
> c0 0f 05 <48> 3d 00 f0 ff ff 77 4f c3 66 0f 1f 44 00 00 55 48 89 e5 48
> 83 ec
> [ 9114.769198] RSP: 002b:00007ffec523c288 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000000
> [ 9114.775499] RAX: ffffffffffffffda RBX: 000055619e0982e0 RCX: 00007f3638039cc1
> [ 9114.781332] RDX: 0000000000000400 RSI: 000055619e0a3b70 RDI: 0000000000000004
> [ 9114.787166] RBP: 00007ffec523c2c0 R08: 0000000000000001 R09: 0000000000000000
> [ 9114.792997] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f3638111050
> [ 9114.798830] R13: 00007f3638110f00 R14: 0000000000000000 R15: 000055619e0982e0
> [ 9114.804668]  </TASK>
> [ 9114.805559] Modules linked in: udf usb_storage snd_seq_dummy
> rpcrdma rdma_cm iw_cm ib_cm ib_core nf_nat_ftp nf_conntrack_ftp
> cfg80211 af_packet nf_conntrack_netbios_ns nf_conntrack_broadcast
> nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet
> nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat
> nf_tables ebtable_nat ebtable_broute ip6table_nat ip6table_mangle
> ip6table_raw ip6table_security iptable_nat nf_nat nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_mangle iptable_raw
> iptable_security ebtable_filter ebtables ip6table_filter ip6_tables
> iptable_filter ip_tables x_tables it87 hwmon_vid bnep binfmt_misc
> snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi
> snd_hda_intel uvcvideo btusb uvc btintel btbcm videobuf2_vmalloc
> snd_intel_dspcfg videobuf2_memops bluetooth videobuf2_v4l2
> snd_hda_codec videodev snd_usb_audio intel_powerclamp coretemp
> snd_virtuoso snd_hda_core kvm_intel snd_oxygen_lib videobuf2_common
> ecdh_generic snd_usbmidi_lib snd_mpu401_uart snd_hwdep mc snd_rawmidi
> [ 9114.805644]  input_leds joydev led_class snd_seq rfkill kvm ecc
> snd_seq_device gpio_ich pktcdvd snd_pcm iTCO_wdt r8169 irqbypass
> i2c_i801 snd_hrtimer realtek snd_timer mdio_devres intel_cstate snd
> libphy acpi_cpufreq i2c_smbus pcspkr intel_uncore psmouse lpc_ich
> i7core_edac mxm_wmi soundcore tiny_power_button button nfsd
> auth_rpcgss nfs_acl lockd grace sunrpc dm_mod loop fuse dax configfs
> nfnetlink zram zsmalloc ext4 crc32c_generic crc16 mbcache jbd2 amdgpu
> video amdxcp i2c_algo_bit mfd_core drm_ttm_helper ttm hid_microsoft
> drm_exec gpu_sched drm_suballoc_helper drm_buddy drm_display_helper
> sr_mod usbhid sd_mod cdrom drm_kms_helper ahci pata_jmicron libahci
> drm uhci_hcd libata ehci_pci ehci_hcd xhci_pci firewire_ohci xhci_hcd
> firewire_core scsi_mod crc32c_intel sha512_ssse3 usbcore
> drm_panel_orientation_quirks sha256_ssse3 cec serio_raw sha1_ssse3
> rc_core crc_itu_t bsg usb_common scsi_common wmi msr [last unloaded:
> sg]
> [ 9114.974386] CR2: 0000000000000068
> [ 9114.976469] ---[ end trace 0000000000000000 ]---
> [ 9114.979859] RIP: 0010:nfsd_show+0x39/0x18e [nfsd]
> [ 9114.983413] Code: fb 48 83 ec 10 48 8b 47 70 8b 2d 34 9b 03 00 48
> 8b 80 b0 00 00 00 4c 8b a0 60 02 00 00 e8 99 84 f2 df 49 8b 84 24 f8
> 0b 00 00 <48> 8b 2c e8 e8 6d c0 f2 df 48 8d bd 00 03 00 00 e8 8f ff ff
> ff 48
> [ 9115.000909] RSP: 0018:ffffc90002edfcf8 EFLAGS: 00010202
> [ 9115.004850] RAX: 0000000000000000 RBX: ffff88813fee9780 RCX: 0000000000001000
> [ 9115.010725] RDX: ffff88810b474740 RSI: 0000000000000001 RDI: ffff88813fee9780
> [ 9115.016621] RBP: 000000000000000d R08: 0000000000400cc0 R09: 00000000ffffffff
> [ 9115.022507] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffffa11e51e0
> [ 9115.028414] R13: ffffc90002edfef8 R14: ffff88813fee9780 R15: ffffffff81a2a520
> [ 9115.034338] FS:  00007f3637e49740(0000) GS:ffff888343c00000(0000)
> knlGS:0000000000000000
> [ 9115.041191] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 9115.045739] CR2: 00007f7171a17ef0 CR3: 000000027a18c000 CR4: 00000000000006f0

