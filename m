Return-Path: <linux-nfs+bounces-3284-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FB08C9533
	for <lists+linux-nfs@lfdr.de>; Sun, 19 May 2024 17:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B99F51C20B6B
	for <lists+linux-nfs@lfdr.de>; Sun, 19 May 2024 15:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FD71E87F;
	Sun, 19 May 2024 15:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTiRCeYV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D6011CB8
	for <linux-nfs@vger.kernel.org>; Sun, 19 May 2024 15:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716133902; cv=none; b=TCfx5sEqm8PedBowUrEbTfeXqobm84+gR+J9jQZgaXHw6156PeEGS4WsF0m/3LbARo+bVO7+Jn2II+IPpSk46deTqn1bHKGKm1UMsi9jFrOzIqts7gL2Itli6e5/YbgniVXU1Ft9BwpO9mBhjziEKruWs/vQJzGTXYkb7/ljgfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716133902; c=relaxed/simple;
	bh=BrAxniHZC132eVOZ+khGqg/S9XTzgVFZoChHh7iaN9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FayM/qxwat2k3A7DSnnB847HJwucx01jhTxSXascLmIAFwQ4iNATahg1Cwq5nqepz0KkQjdsJA5jsnawkEWOI07lglCDJ0QkID9RZ0P/AKTz9zuCV36OV1XUSd44S0B/7qULUR/PQLIxdiuv+pm81fE6BakF6GoAbUyHtNAUp/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTiRCeYV; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-43df14d8a27so10645261cf.2
        for <linux-nfs@vger.kernel.org>; Sun, 19 May 2024 08:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716133900; x=1716738700; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C2rFpL5AqGNCQgUGL1HU+5KYVGBOFPDXhhtMIu00qS8=;
        b=CTiRCeYVPg6L6H7oly7E7zUEC1PDEiA4bf/bZIlhZz7SPXIJF4WoxGNa94hXVapOk7
         haXix+daYV5GrFxr7Nkjb3HfEa9f8b19nYwzDUvA3+Nou/6k+SnUHjFjILuECD8+beCx
         xYAWMUHLU41v4la1/AwIOYjOjhLVeGvEL4SQ9t5quwTg4QvviNgE2DePofkGpml4qfjX
         WZX7YXYcS4VCKNf4bO3IeERYqPNE3KiiD3b6r/uLWT/Je19M7fxm+v78mNyHb6QuRCR9
         qySLIufeywMTqTKq4UQdX8TYzML3OTa7RFoHZ3y7YTAp1XuNs2KPUc5qrxGZEpEZ5BmJ
         qPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716133900; x=1716738700;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C2rFpL5AqGNCQgUGL1HU+5KYVGBOFPDXhhtMIu00qS8=;
        b=Ln5fo/0ab/B7ZyS9dYxOqB52eNDxh4YjBeg6LmThZsdaLG3JIWndimyXNt0G7xg81D
         t9U3awoTXy1mq8HyQqCN3OuTmlCbaFTT4pCGGeenvo2ynaJe9Uumbv1zYCtKdsxQCYhK
         WAqhNWw2/KJx1FHZL4m/Ae/WyfPVJPiD3LhPWbYvLE17as8aLBMxpwuYFieJdw7uuvXH
         xULV4II8Gra5dyxjn+CAOxdksxe1/jVTNCemUChfXgf1kRD92BStX2wpZoYkbAj6hobl
         3rvQOSn0ObRsYSR28nico6liL8uzUBtrtKgXITLiUVr7jkQkfcImaUMMygiDwOnwOr5z
         30jg==
X-Forwarded-Encrypted: i=1; AJvYcCV5tc7pruwI8NqX5ANo4tfaF+8yCvp01zWgID8rkN/oQjn7jvO+pUOnNQTTQDUCRIY4mK1cDFAip/XOJqfUmWLZ+9mk4/lolcw4
X-Gm-Message-State: AOJu0YzLEMh1I2MvJ1Z3ZhELaJlz6lJoHuOhztkCx8SG5cVwB5+gbLY1
	STVKQLTNUPG2p9A349qEgp7WcEff4LP4sCM6+PmdPxLczEhmtYN9y2VW5GxUe+nbMAcptJVkwfW
	lrS23rWX0yiQ1631+uyWlRzYiNOV6JBArfdKFVQ==
X-Google-Smtp-Source: AGHT+IGbpQZEovrKWOEDRquF4WligNseZ46B23wq3jyE1lfERQIz4H5Iqx1CUYmE0NQY9mPTy8hiEWc1nwOjUGHWF8M=
X-Received: by 2002:a05:6214:3110:b0:6aa:4b82:493a with SMTP id
 6a1803df08f44-6aa4b824ee5mr8582846d6.24.1716133899630; Sun, 19 May 2024
 08:51:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK2bqVJoT3yy2m0OmTnqH9EAKkj6O1iTk42EyyMtvvxKh6YDKg@mail.gmail.com>
 <CAK2bqV+FA-bcBXeOAT93Y=-6fyXOP38yoYgH_4O+waygWLbnEg@mail.gmail.com>
 <CAK2bqVJ+GgWtjvy4wGzGqAvwoCrH2Hmo6W5oT6wu_0LXzUV3VA@mail.gmail.com> <0309145a87db46a4e56b83d64d2f5273990a08d7.camel@kernel.org>
In-Reply-To: <0309145a87db46a4e56b83d64d2f5273990a08d7.camel@kernel.org>
From: Chris Rankin <rankincj@gmail.com>
Date: Sun, 19 May 2024 16:51:28 +0100
Message-ID: <CAK2bqVLaki4Jqq67jWcW+fedDYJRk5xrsgNZq5TH4iBTu8AvMg@mail.gmail.com>
Subject: Re: [BUG] Linux 6.8.10 NPE
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

nfsd_show+0x39/0x18e:

net_generic at /home/chris/LINUX/linux-6.8/include/net/netns/generic.h:47
 42         struct net_generic *ng;
 43         void *ptr;
 44
 45         rcu_read_lock();
 46         ng = rcu_dereference(net->gen);
>47<        ptr = ng->ptr[id];
 48         rcu_read_unlock();
 49
 50         return ptr;
 51     }
 52     #endif

(inlined by) nfsd_show at /home/chris/LINUX/linux-6.8/fs/nfsd/stats.c:38
 33     };
 34
 35     static int nfsd_show(struct seq_file *seq, void *v)
 36     {
 37         struct net *net = pde_data(file_inode(seq->file));
>38<        struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 39         int i;
 40
 41         seq_printf(seq, "rc %lld %lld %lld\nfh %lld 0 0 0 0\nio
%lld %lld\n",
 42
percpu_counter_sum_positive(&nn->counter[NFSD_STATS_RC_HITS]),
 43
percpu_counter_sum_positive(&nn->counter[NFSD_STATS_RC_MISSES]),

On Sun, 19 May 2024 at 15:58, Jeff Layton <jlayton@kernel.org> wrote:
>
> On Sun, 2024-05-19 at 14:15 +0100, Chris Rankin wrote:
> > FWIW the problem appears to be with linux-6.8/fs/nfsd/stats.c#L38:
> >
> >         struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> >
> > although the value of the "net" variable looks reasonable.
> >
> > Cheers,
> > Chris
> >
> > On Sun, 19 May 2024 at 13:26, Chris Rankin <rankincj@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > CC after emailing both linux-kernel and stable.
> > >
> > > Cheers,
> > > Chris
> > >
> > > ---------- Forwarded message ---------
> > > From: Chris Rankin <rankincj@gmail.com>
> > > Date: Sat, 18 May 2024 at 13:53
> > > Subject: [BUG] Linux 6.8.10 NPE
> > > To: LKML <linux-kernel@vger.kernel.org>, Linux Stable <stable@vger.kernel.org>
> > >
> > > Hi,
> > >
> > > I am using vanilla Linux 6.8.10, and I've just noticed this BUG in my
> > > dmesg log. I have no idea what triggered it, and especially since I
> > > have not even mounted any NFS filesystems?!
> > >
> > > Cheers,
> > > Chris
> > >
> > > [ 9114.607417] BUG: kernel NULL pointer dereference, address: 0000000000000068
> > > [ 9114.613082] #PF: supervisor read access in kernel mode
> > > [ 9114.616929] #PF: error_code(0x0000) - not-present page
> > > [ 9114.620775] PGD 0 P4D 0
> > > [ 9114.622013] Oops: 0000 [#16] PREEMPT SMP PTI
> > > [ 9114.624987] CPU: 2 PID: 16501 Comm: sadc Tainted: G      D   I
> > >   6.8.10 #1
> > > [ 9114.630993] Hardware name: Gigabyte Technology Co., Ltd.
> > > EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
> > > [ 9114.638561] RIP: 0010:nfsd_show+0x39/0x18e [nfsd]
> > > [ 9114.642026] Code: fb 48 83 ec 10 48 8b 47 70 8b 2d 34 9b 03 00 48
> > > 8b 80 b0 00 00 00 4c 8b a0 60 02 00 00 e8 99 84 f2 df 49 8b 84 24 f8
> > > 0b 00 00 <48> 8b 2c e8 e8 6d c0 f2 df 48 8d bd 00 03 00 00 e8 8f ff ff
> > > ff 48
> > > [ 9114.659472] RSP: 0018:ffffc9000b1afcf8 EFLAGS: 00010202
> > > [ 9114.663405] RAX: 0000000000000000 RBX: ffff88810cd5de80 RCX: 0000000000001000
> > > [ 9114.669239] RDX: ffff88813f45b900 RSI: 0000000000000001 RDI: ffff88810cd5de80
> > > [ 9114.675069] RBP: 000000000000000d R08: 0000000000400cc0 R09: 00000000ffffffff
> > > [ 9114.680905] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffffa11e51e0
> > > [ 9114.686737] R13: ffffc9000b1afef8 R14: ffff88810cd5de80 R15: ffffffff81a2a520
> > > [ 9114.692586] FS:  00007f3637e49740(0000) GS:ffff888343c80000(0000)
> > > knlGS:0000000000000000
> > > [ 9114.699370] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [ 9114.703809] CR2: 0000000000000068 CR3: 000000027a18c000 CR4: 00000000000006f0
> > > [ 9114.709642] Call Trace:
> > > [ 9114.710798]  <TASK>
> > > [ 9114.711602]  ? __die_body+0x1a/0x5c
> > > [ 9114.713802]  ? page_fault_oops+0x321/0x36e
> > > [ 9114.716636]  ? exc_page_fault+0x105/0x117
> > > [ 9114.719348]  ? asm_exc_page_fault+0x22/0x30
> > > [ 9114.722237]  ? nfsd_show+0x39/0x18e [nfsd]
> > > [ 9114.725103]  ? nfsd_show+0x31/0x18e [nfsd]
> > > [ 9114.727954]  seq_read_iter+0x171/0x353
> > > [ 9114.730410]  seq_read+0xe0/0x108
> > > [ 9114.732350]  ? startup_64+0x1/0x60
> > > [ 9114.734458]  proc_reg_read+0x8c/0xa7
> > > [ 9114.736746]  vfs_read+0xa6/0x1bf
> > > [ 9114.738685]  ? __do_sys_newfstat+0x34/0x5c
> > > [ 9114.741486]  ksys_read+0x74/0xc0
> > > [ 9114.743418]  do_syscall_64+0x6c/0xdc
> > > [ 9114.745695]  entry_SYSCALL_64_after_hwframe+0x60/0x68
> > > [ 9114.749449] RIP: 0033:0x7f3638039cc1
> > > [ 9114.751752] Code: 00 48 8b 15 59 81 0d 00 f7 d8 64 89 02 b8 ff ff
> > > ff ff eb bd e8 b0 aa 01 00 f3 0f 1e fa 80 3d 85 03 0e 00 00 74 13 31
> > > c0 0f 05 <48> 3d 00 f0 ff ff 77 4f c3 66 0f 1f 44 00 00 55 48 89 e5 48
> > > 83 ec
> > > [ 9114.769198] RSP: 002b:00007ffec523c288 EFLAGS: 00000246 ORIG_RAX:
> > > 0000000000000000
> > > [ 9114.775499] RAX: ffffffffffffffda RBX: 000055619e0982e0 RCX: 00007f3638039cc1
> > > [ 9114.781332] RDX: 0000000000000400 RSI: 000055619e0a3b70 RDI: 0000000000000004
> > > [ 9114.787166] RBP: 00007ffec523c2c0 R08: 0000000000000001 R09: 0000000000000000
> > > [ 9114.792997] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f3638111050
> > > [ 9114.798830] R13: 00007f3638110f00 R14: 0000000000000000 R15: 000055619e0982e0
> > > [ 9114.804668]  </TASK>
> > > [ 9114.805559] Modules linked in: udf usb_storage snd_seq_dummy
> > > rpcrdma rdma_cm iw_cm ib_cm ib_core nf_nat_ftp nf_conntrack_ftp
> > > cfg80211 af_packet nf_conntrack_netbios_ns nf_conntrack_broadcast
> > > nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet
> > > nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat
> > > nf_tables ebtable_nat ebtable_broute ip6table_nat ip6table_mangle
> > > ip6table_raw ip6table_security iptable_nat nf_nat nf_conntrack
> > > nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_mangle iptable_raw
> > > iptable_security ebtable_filter ebtables ip6table_filter ip6_tables
> > > iptable_filter ip_tables x_tables it87 hwmon_vid bnep binfmt_misc
> > > snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi
> > > snd_hda_intel uvcvideo btusb uvc btintel btbcm videobuf2_vmalloc
> > > snd_intel_dspcfg videobuf2_memops bluetooth videobuf2_v4l2
> > > snd_hda_codec videodev snd_usb_audio intel_powerclamp coretemp
> > > snd_virtuoso snd_hda_core kvm_intel snd_oxygen_lib videobuf2_common
> > > ecdh_generic snd_usbmidi_lib snd_mpu401_uart snd_hwdep mc snd_rawmidi
> > > [ 9114.805644]  input_leds joydev led_class snd_seq rfkill kvm ecc
> > > snd_seq_device gpio_ich pktcdvd snd_pcm iTCO_wdt r8169 irqbypass
> > > i2c_i801 snd_hrtimer realtek snd_timer mdio_devres intel_cstate snd
> > > libphy acpi_cpufreq i2c_smbus pcspkr intel_uncore psmouse lpc_ich
> > > i7core_edac mxm_wmi soundcore tiny_power_button button nfsd
> > > auth_rpcgss nfs_acl lockd grace sunrpc dm_mod loop fuse dax configfs
> > > nfnetlink zram zsmalloc ext4 crc32c_generic crc16 mbcache jbd2 amdgpu
> > > video amdxcp i2c_algo_bit mfd_core drm_ttm_helper ttm hid_microsoft
> > > drm_exec gpu_sched drm_suballoc_helper drm_buddy drm_display_helper
> > > sr_mod usbhid sd_mod cdrom drm_kms_helper ahci pata_jmicron libahci
> > > drm uhci_hcd libata ehci_pci ehci_hcd xhci_pci firewire_ohci xhci_hcd
> > > firewire_core scsi_mod crc32c_intel sha512_ssse3 usbcore
> > > drm_panel_orientation_quirks sha256_ssse3 cec serio_raw sha1_ssse3
> > > rc_core crc_itu_t bsg usb_common scsi_common wmi msr [last unloaded:
> > > sg]
> > > [ 9114.974386] CR2: 0000000000000068
> > > [ 9114.976469] ---[ end trace 0000000000000000 ]---
> > > [ 9114.979859] RIP: 0010:nfsd_show+0x39/0x18e [nfsd]
> > > [ 9114.983413] Code: fb 48 83 ec 10 48 8b 47 70 8b 2d 34 9b 03 00 48
> > > 8b 80 b0 00 00 00 4c 8b a0 60 02 00 00 e8 99 84 f2 df 49 8b 84 24 f8
> > > 0b 00 00 <48> 8b 2c e8 e8 6d c0 f2 df 48 8d bd 00 03 00 00 e8 8f ff ff
> > > ff 48
> > > [ 9115.000909] RSP: 0018:ffffc90002edfcf8 EFLAGS: 00010202
> > > [ 9115.004850] RAX: 0000000000000000 RBX: ffff88813fee9780 RCX: 0000000000001000
> > > [ 9115.010725] RDX: ffff88810b474740 RSI: 0000000000000001 RDI: ffff88813fee9780
> > > [ 9115.016621] RBP: 000000000000000d R08: 0000000000400cc0 R09: 00000000ffffffff
> > > [ 9115.022507] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffffa11e51e0
> > > [ 9115.028414] R13: ffffc90002edfef8 R14: ffff88813fee9780 R15: ffffffff81a2a520
> > > [ 9115.034338] FS:  00007f3637e49740(0000) GS:ffff888343c00000(0000)
> > > knlGS:0000000000000000
> > > [ 9115.041191] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [ 9115.045739] CR2: 00007f7171a17ef0 CR3: 000000027a18c000 CR4: 00000000000006f0
>
>
> Can you run faddr2line against that kmod and tell us where it failed?
> Something like this, with a non-stripped kmod:
>
>     $ scripts/faddr2line --list fs/nfsd/nfsd.ko nfsd_show+0x39/0x18e
>
> Thanks,
> --
> Jeff Layton <jlayton@kernel.org>

