Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 253DA18DDC1
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Mar 2020 03:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgCUCvf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Mar 2020 22:51:35 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:60407 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727832AbgCUCve (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 20 Mar 2020 22:51:34 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 41030ef6
        for <linux-nfs@vger.kernel.org>;
        Sat, 21 Mar 2020 02:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :from:date:message-id:subject:to:cc:content-type; s=mail; bh=WBx
        UZktPmOc4dL5hhgPZOtNLKAo=; b=R03n82LpgqXHtpqUZb/4xMD3ku0CdWENFmV
        aYW3Aop1+jrytTro20jOZXspzNak3gAqOdVuvoduveRluxE5XDU0JanlWP+FO7ZE
        f0Hvayt+kDrAB/ZQG9vsx5JD3dsvSmQaJJs1cx6Ijarzk5LC2J0XzEH+E4Hm92TJ
        vooIsbRm4SMQmqGtTKf4L0eE88puSOdSdyr4thHScs39ICSovgveAbgNGENQxze3
        hESZ3z7FwujYNylmcOl9R4OURXm9+QHF0wYlSp6G+8wL7EwgeUFdj1SDSaFXwVKN
        TuA1wOrQarQ1Jj2gpvPQAlOYFwm9o5FpeWo0Bo28TusdGthqvgw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6e243bab (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-nfs@vger.kernel.org>;
        Sat, 21 Mar 2020 02:44:51 +0000 (UTC)
Received: by mail-il1-f180.google.com with SMTP id p12so7781290ilm.7
        for <linux-nfs@vger.kernel.org>; Fri, 20 Mar 2020 19:51:32 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1TAzCpyROFzN1ax4ZVN816z109ENl1oQewxHPgT1bLvEvWtWNk
        cO7KQE0Kvfg39yICcdQtuSrFGeV9fBd3FZpliWk=
X-Google-Smtp-Source: ADFU+vvx7Fp96fg/3H3Auvr3MWqEZaj+Q/EKwe3tukRcDmclcd8kuLU2B3rWxoSK+NWLgEZa2tzIiEJAMhUsBrx0AwY=
X-Received: by 2002:a92:358b:: with SMTP id c11mr10773979ilf.64.1584759091562;
 Fri, 20 Mar 2020 19:51:31 -0700 (PDT)
MIME-Version: 1.0
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 20 Mar 2020 20:51:20 -0600
X-Gmail-Original-Message-ID: <CAHmME9ro8BPBTMfu8dEbGmkH7qHLdQ=CXGEOW2C7MR4bmT6T+w@mail.gmail.com>
Message-ID: <CAHmME9ro8BPBTMfu8dEbGmkH7qHLdQ=CXGEOW2C7MR4bmT6T+w@mail.gmail.com>
Subject: refcount underflow in nfsd41_destroy_cb
To:     linux-nfs@vger.kernel.org
Cc:     Jan Psota <jasiu@belsznica.pl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

A user erroneously sent me a refcount UaF in NFS with 5.6-rc6. I
thought I should forward it onward here in case this is not already
known. The original reporter is CC'd in case you have any questions.

Regards,
Jason

-------8<------------------------

Mar 20 21:43:34 agro kernel: ------------[ cut here ]------------
Mar 20 21:43:34 agro kernel: refcount_t: underflow; use-after-free.
Mar 20 21:43:34 agro kernel: WARNING: CPU: 1 PID: 9334 at
lib/refcount.c:28 refcount_warn_saturate+0xd9/0xe0
Mar 20 21:43:34 agro kernel: Modules linked in: md5 wireguard
curve25519_x86_64 libcurve25519_generic libchacha20poly1305
chacha_x86_64 libchacha poly1305_x86_64 ip6_udp_tunnel udp_tunnel
libblake2s blake2s_x86_64 libblake2s_generic xt_mac xt_nat
xt_MASQUERADE xt_REDIRECT xt_owner xt_comment ipt_REJECT
nf_reject_ipv4 xt_mark xt_hashlimit xt_multiport nfnetlink_log
xt_NFLOG nf_log_ipv4 nf_log_common xt_LOG nf_nat_tftp nf_nat_sip
nf_nat_h323 nf_nat_ftp nf_conntrack_tftp nf_conntrack_sip
nf_conntrack_netlink nfnetlink nf_conntrack_h323 nf_conntrack_ftp nfsd
auth_rpcgss nfs_acl lockd grace sunrpc cpufreq_ondemand msr bridge stp
llc xt_tcpudp xt_conntrack iptable_mangle iptable_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_raw iptable_filter
ip_tables x_tables btrfs blake2b_generic xor raid6_pq libcrc32c
zstd_compress zstd_decompress zlib_deflate zlib_inflate uas
usb_storage snd_hda_codec_realtek snd_hda_codec_generic matroxfb_base
matroxfb_g450 matroxfb_Ti3026 snd_hda_int
 el matroxfb_accel
Mar 20 21:43:34 agro kernel:  snd_intel_dspcfg cfbfillrect cfbimgblt
atlantic snd_hda_codec r8169 cfbcopyarea e1000e snd_hda_core snd_hwdep
matroxfb_DAC1064 g450_pll matroxfb_misc ptp realtek fb snd_pcm libphy
snd_timer mxm_wmi xhci_pci pcspkr i2c_piix4 input_leds pps_core fbdev
k10temp ohci_pci snd xhci_hcd ohci_hcd ehci_pci soundcore i2c_core
ehci_hcd wmi acpi_cpufreq vhci_hcd usbip_core usbcore usb_common
vhost_net vhost kvm_amd kvm irqbypass loop tun fuse it87 hwmon_vid
hwmon
Mar 20 21:43:34 agro kernel: CPU: 1 PID: 9334 Comm: kworker/u16:3 Not
tainted 5.6.0-rc6 #1
Mar 20 21:43:34 agro kernel: Hardware name: Gigabyte Technology Co.,
Ltd. GA-990FXA-UD5/GA-990FXA-UD5, BIOS F12 10/03/2013
Mar 20 21:43:34 agro kernel: Workqueue: rpciod rpc_async_schedule [sunrpc]
Mar 20 21:43:34 agro kernel: RIP: 0010:refcount_warn_saturate+0xd9/0xe0
Mar 20 21:43:34 agro kernel: Code: ff 48 c7 c7 e8 ff d5 81 c6 05 cd 49
b5 00 01 e8 4d 04 cf ff 0f 0b c3 48 c7 c7 90 ff d5 81 c6 05 b9 49 b5
00 01 e8 37 04 cf ff <0f> 0b c3 0f 1f 40 00 8b 07 3d 00 00 00 c0 74 12
83 f8 01 74 46 8d
Mar 20 21:43:34 agro kernel: RSP: 0018:ffffc900010dfde0 EFLAGS: 00010282
Mar 20 21:43:34 agro kernel: RAX: 0000000000000026 RBX:
0000000000000e81 RCX: 0000000000000007
Mar 20 21:43:34 agro kernel: RDX: 0000000000000007 RSI:
0000000000000092 RDI: ffff88881fc587c0
Mar 20 21:43:34 agro kernel: RBP: ffff8887eeb40470 R08:
00000000000004d9 R09: 0000000000000001
Mar 20 21:43:34 agro kernel: R10: 0000000000000000 R11:
0000000000000001 R12: ffff8884f1e28510
Mar 20 21:43:34 agro kernel: R13: ffff88837dc49f30 R14:
0000000000000001 R15: ffff888780b8a840
Mar 20 21:43:34 agro kernel: FS:  0000000000000000(0000)
GS:ffff88881fc40000(0000) knlGS:0000000000000000
Mar 20 21:43:34 agro kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Mar 20 21:43:34 agro kernel: CR2: 000000000421efb0 CR3:
0000000510564000 CR4: 00000000000006e0
Mar 20 21:43:34 agro kernel: Call Trace:
Mar 20 21:43:34 agro kernel:  nfsd41_destroy_cb+0x36/0x50 [nfsd]
Mar 20 21:43:34 agro kernel:  rpc_free_task+0x3c/0x70 [sunrpc]
Mar 20 21:43:34 agro kernel:  __rpc_execute+0x3a5/0x3c0 [sunrpc]
Mar 20 21:43:34 agro kernel:  ? finish_task_switch+0x7f/0x250
Mar 20 21:43:34 agro kernel:  rpc_async_schedule+0x2f/0x50 [sunrpc]
Mar 20 21:43:34 agro kernel:  process_one_work+0x1ca/0x3c0
Mar 20 21:43:34 agro kernel:  worker_thread+0x45/0x3d0
Mar 20 21:43:34 agro kernel:  kthread+0xf3/0x130
Mar 20 21:43:34 agro kernel:  ? process_one_work+0x3c0/0x3c0
Mar 20 21:43:34 agro kernel:  ? kthread_park+0x80/0x80
Mar 20 21:43:34 agro kernel:  ret_from_fork+0x1f/0x30
Mar 20 21:43:34 agro kernel: ---[ end trace 99765c8e28c46274 ]---
