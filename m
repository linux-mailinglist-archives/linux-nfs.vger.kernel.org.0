Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4A3E18E245
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Mar 2020 16:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgCUPFP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 21 Mar 2020 11:05:15 -0400
Received: from s58.linuxpl.com ([5.9.16.239]:55267 "EHLO s58.linuxpl.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgCUPFO (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 21 Mar 2020 11:05:14 -0400
X-Greylist: delayed 1421 seconds by postgrey-1.27 at vger.kernel.org; Sat, 21 Mar 2020 11:05:12 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=belsznica.pl; s=x; h=Content-Type:MIME-Version:References:In-Reply-To:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/cRazp7Q+sF1lBUaNGpA8140OPFa8t7JDXLPvG+03IY=; b=JPlQAvTaEw/wcEM+8QgSXmQgd5
        8KqH0NvDk7AgbTPA406Xle1hYqE43nCO5edZSgLRwiJCShZooUkW+k1zjXVWhYQADYCRqJz8aPEzy
        JvMAJuZxJUdeGzNVsYQMvZJ91fpNJcplM5j9+Sfn4E22R3aUzCSiFLy76JX4+4eZrb/uCdWYoYyB8
        XF3uj3WUK28PyszPv1IsPqiXigFq9Qdejp+B9sfIrc/gjrTiYGdaFCSJbpwFt8KMGbAt5NB5vnNFi
        rhaJA4bstpIWRUXvJn7naxz6OpJ8elkxQpnYgfQuH3FhPnN1aGnc37TbURcn/0yzPS7UQkKgjrjOw
        GlqhPayQ==;
Received: from user-5-173-97-3.play-internet.pl ([5.173.97.3] helo=mordimer)
        by s58.linuxpl.com with esmtpa (Exim 4.92.3)
        (envelope-from <jasiu@belsznica.pl>)
        id 1jFfJZ-0001Dc-4y; Sat, 21 Mar 2020 15:41:29 +0100
Received: from mordimer (localhost [127.0.0.1])
        by mordimer (Postfix) with ESMTP id 093A160192;
        Sat, 21 Mar 2020 15:41:29 +0100 (CET)
Date:   Sat, 21 Mar 2020 15:41:28 +0100
From:   Jan Psota <jasiu@belsznica.pl>
To:     linux-nfs@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: refcount underflow in nfsd41_destroy_cb
Message-ID: <20200321154128.58eb8ef2.jasiu@belsznica.pl>
In-Reply-To: <CAHmME9ro8BPBTMfu8dEbGmkH7qHLdQ=CXGEOW2C7MR4bmT6T+w@mail.gmail.com>
References: <CAHmME9ro8BPBTMfu8dEbGmkH7qHLdQ=CXGEOW2C7MR4bmT6T+w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Operating-System: Linux; Gentoo
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/SmzOuljEzM+BfRM+Vr0OyEq"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--MP_/SmzOuljEzM+BfRM+Vr0OyEq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi! Previous and first trace for problem that Jason forwarded to you.

--MP_/SmzOuljEzM+BfRM+Vr0OyEq
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=nfsd-trace.txt

Mar 19 11:08:07 agro kernel: ------------[ cut here ]------------
Mar 19 11:08:07 agro kernel: refcount_t: underflow; use-after-free.
Mar 19 11:08:07 agro kernel: WARNING: CPU: 0 PID: 15539 at lib/refcount.c:28 refcount_warn_saturate+
0xd9/0xe0
Mar 19 11:08:07 agro kernel: Modules linked in: udp_diag inet_diag wireguard curve25519_x86_64 libcurve25519_generic libchacha20poly1305 chacha_x86_64 libchacha poly1305_x86_64 ip6_udp_tunnel udp_tunnel libblake2s blake2s_x86_64 libblake2s_generic md5 xt_mac xt_nat xt_MASQUERADE xt_REDIRECT xt_owner xt_comment ipt_REJECT nf_reject_ipv4 xt_mark xt_hashlimit iptable_raw xt_multiport nfnetlink_log xt_NFLOG nf_log_ipv4 nf_log_common xt_LOG nf_nat_tftp nf_nat_sip nf_nat_h323 nf_nat_ftp nf_conntrack_tftp nf_conntrack_sip nf_conntrack_netlink nfnetlink nf_conntrack_h323 nf_conntrack_ftp nfsd auth_rpcgss nfs_acl lockd grace sunrpc cpufreq_ondemand msr bridge stp llc xt_tcpudp xt_conntrack iptable_mangle iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_filter ip_tables x_tables btrfs blake2b_generic xor raid6_pq libcrc32c zstd_compress zstd_decompress zlib_deflate zlib_inflate hid_generic usbhid hid uas usb_storage snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel
  matroxfb_base
Mar 19 11:08:07 agro kernel:  snd_intel_dspcfg r8169 matroxfb_g450 matroxfb_Ti3026 matroxfb_accel e1000e cfbfillrect realtek snd_hda_codec libphy cfbimgblt cfbcopyarea matroxfb_DAC1064 g450_pll matroxfb_misc fb snd_hda_core atlantic mxm_wmi input_leds snd_hwdep xhci_pci pcspkr k10temp ptp xhci_hcd fbdev snd_pcm pps_core snd_timer snd wmi ohci_pci ohci_hcd i2c_piix4 ehci_pci ehci_hcd soundcore i2c_core acpi_cpufreq vhci_hcd usbip_core usbcore usb_common vhost_net vhost kvm_amd kvm irqbypass loop tun fuse it87 hwmon_vid hwmon
Mar 19 11:08:07 agro kernel: CPU: 0 PID: 15539 Comm: kworker/u16:1 Not tainted 5.6.0-rc6 #1
Mar 19 11:08:07 agro kernel: Hardware name: Gigabyte Technology Co., Ltd. GA-990FXA-UD5/GA-990FXA-UD5, BIOS F12 10/03/2013
Mar 19 11:08:07 agro kernel: Workqueue: rpciod rpc_async_schedule [sunrpc]
Mar 19 11:08:07 agro kernel: RIP: 0010:refcount_warn_saturate+0xd9/0xe0
Mar 19 11:08:07 agro kernel: Code: ff 48 c7 c7 e8 ff d5 81 c6 05 cd 49 b5 00 01 e8 4d 04 cf ff 0f 0b c3 48 c7 c7 90 ff d5 81 c6 05 b9 49 b5 00 01 e8 37 04 cf ff <0f> 0b c3 0f 1f 40 00 8b 07 3d 00 00 00 c0 74 12 83 f8 01 74 46 8d
Mar 19 11:08:07 agro kernel: RSP: 0018:ffffc9000056fde0 EFLAGS: 00010282
Mar 19 11:08:07 agro kernel: RAX: 0000000000000026 RBX: 0000000000000e81 RCX: 0000000000000007
Mar 19 11:08:07 agro kernel: RDX: 0000000000000007 RSI: 0000000000000092 RDI: ffff88881fc187c0
Mar 19 11:08:07 agro kernel: RBP: ffff8887f0394c70 R08: 00000000000015b7 R09: 0000000000000001
Mar 19 11:08:07 agro kernel: R10: 0000000000000000 R11: 0000000000000001 R12: ffff8885fec40510
Mar 19 11:08:07 agro kernel: R13: ffff888231700430 R14: 0000000000000001 R15: ffff888016454a80
Mar 19 11:08:07 agro kernel: FS:  0000000000000000(0000) GS:ffff88881fc00000(0000) knlGS:0000000000000000
Mar 19 11:08:07 agro kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Mar 19 11:08:07 agro kernel: CR2: 000000000319e728 CR3: 0000000611f86000 CR4: 00000000000006f0
Mar 19 11:08:07 agro kernel: Call Trace:
Mar 19 11:08:07 agro kernel:  nfsd41_destroy_cb+0x36/0x50 [nfsd]
Mar 19 11:08:07 agro kernel:  rpc_free_task+0x3c/0x70 [sunrpc]
Mar 19 11:08:07 agro kernel:  __rpc_execute+0x3a5/0x3c0 [sunrpc]
Mar 19 11:08:07 agro kernel:  ? finish_task_switch+0x7f/0x250
Mar 19 11:08:07 agro kernel:  rpc_async_schedule+0x2f/0x50 [sunrpc]
Mar 19 11:08:07 agro kernel:  process_one_work+0x1ca/0x3c0
Mar 19 11:08:07 agro kernel:  worker_thread+0x45/0x3d0
Mar 19 11:08:07 agro kernel:  kthread+0xf3/0x130
Mar 19 11:08:07 agro kernel:  ? process_one_work+0x3c0/0x3c0
Mar 19 11:08:07 agro kernel:  ? kthread_park+0x80/0x80
Mar 19 11:08:07 agro kernel:  ret_from_fork+0x1f/0x30
Mar 19 11:08:07 agro kernel: ---[ end trace 175a0f52bbff4924 ]---

--MP_/SmzOuljEzM+BfRM+Vr0OyEq--
