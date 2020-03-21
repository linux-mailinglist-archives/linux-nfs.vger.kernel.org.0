Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B68A818E350
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Mar 2020 18:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbgCURZ4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 21 Mar 2020 13:25:56 -0400
Received: from s58.linuxpl.com ([5.9.16.239]:53870 "EHLO s58.linuxpl.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727015AbgCURZz (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 21 Mar 2020 13:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=belsznica.pl; s=x; h=Content-Type:MIME-Version:References:In-Reply-To:
        Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cBwuBlMjx0OsmZ/NCvv5tWUgvPQzKtB01us/73SxDJw=; b=tgVO+jIbsU+JlSyCNxS6ko1iz/
        g3VCgNExbZRbnZ4xWczdI2LGbDnEvUlZPYtEDYCk0RctyLEXI/tQvN2x80HixE0cy5plRmb2H/mPR
        cbi1A8P2FaV/CZZjxZoj4xAHutURdNy7YUwY0YwttWMqoHr2yaUkEFrazOwBlEgi7sjVj1o/ppacN
        jwN6musHnTm8NPLMYQxv0JU4HNp1qi2b+XoLTKv8x8jhh5hHDzbqiYB2VFHi/wLHo6ny/LYR8+MIN
        bte9PgDZ9YXnVofyKEEJc2xYMGuzKlFKEWSdFfcrpycDCzO9KshlyrQVsciDb6r764PLOPNVE1SMD
        pl2HllTQ==;
Received: from user-5-173-97-3.play-internet.pl ([5.173.97.3] helo=mordimer)
        by s58.linuxpl.com with esmtpa (Exim 4.92.3)
        (envelope-from <jasiu@belsznica.pl>)
        id 1jFhsf-00016p-Ah
        for linux-nfs@vger.kernel.org; Sat, 21 Mar 2020 18:25:53 +0100
Received: from mordimer (localhost [127.0.0.1])
        by mordimer (Postfix) with ESMTP id B493860192
        for <linux-nfs@vger.kernel.org>; Sat, 21 Mar 2020 18:25:52 +0100 (CET)
Date:   Sat, 21 Mar 2020 18:25:52 +0100
From:   Jan Psota <jasiu@belsznica.pl>
To:     linux-nfs@vger.kernel.org
Subject: Re: refcount underflow in nfsd41_destroy_cb
Message-ID: <20200321182552.0f68ad2a.jasiu@belsznica.pl>
In-Reply-To: <20200321154128.58eb8ef2.jasiu@belsznica.pl>
References: <CAHmME9ro8BPBTMfu8dEbGmkH7qHLdQ=CXGEOW2C7MR4bmT6T+w@mail.gmail.com>
        <20200321154128.58eb8ef2.jasiu@belsznica.pl>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Operating-System: Linux; Gentoo
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/9QWg5urlZxPxOKm+kYVP4rk"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--MP_/9QWg5urlZxPxOKm+kYVP4rk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi! 3-rd trace. If it is enough, so you want me not to send next, just
let me know.

--MP_/9QWg5urlZxPxOKm+kYVP4rk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=nfsd-trace3.txt

[53545.848242] ------------[ cut here ]------------
[53545.848246] refcount_t: underflow; use-after-free.
[53545.848283] WARNING: CPU: 0 PID: 22784 at lib/refcount.c:28 refcount_warn_saturate+0xd9/0xe0
[53545.848285] Modules linked in: md5 wireguard curve25519_x86_64 libcurve25519_generic libchacha20poly1305 chacha_x86_64 libchacha poly1305_x86_64 ip6_udp_tunnel udp_tunnel libblake2s blake2s_x86_64 libblake2s_generic xt_mac xt_nat xt_MASQUERADE xt_REDIRECT xt_owner xt_comment ipt_REJECT nf_reject_ipv4 xt_mark xt_hashlimit xt_multiport nfnetlink_log xt_NFLOG nf_log_ipv4 nf_log_common xt_LOG nf_nat_tftp nf_nat_sip nf_nat_h323 nf_nat_ftp nf_conntrack_tftp nf_conntrack_sip nf_conntrack_netlink nfnetlink nf_conntrack_h323 nf_conntrack_ftp nfsd auth_rpcgss nfs_acl lockd grace sunrpc cpufreq_ondemand msr bridge stp llc xt_tcpudp xt_conntrack iptable_mangle iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_raw iptable_filter ip_tables x_tables btrfs blake2b_generic xor raid6_pq libcrc32c zstd_compress zstd_decompress zlib_deflate zlib_inflate uas usb_storage snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel matroxfb_base snd_intel_dspcfg snd_hda_codec matroxfb_g
 450
[53545.848354]  snd_hda_core matroxfb_Ti3026 matroxfb_accel r8169 cfbfillrect cfbimgblt snd_hwdep e1000e realtek libphy cfbcopyarea snd_pcm mxm_wmi pcspkr matroxfb_DAC1064 g450_pll snd_timer matroxfb_misc input_leds atlantic fb snd wmi fbdev xhci_pci k10temp xhci_hcd i2c_piix4 ptp soundcore pps_core ohci_pci i2c_core ohci_hcd ehci_pci ehci_hcd acpi_cpufreq vhci_hcd usbip_core usbcore usb_common vhost_net vhost kvm_amd kvm irqbypass loop tun fuse it87 hwmon_vid hwmon
[53545.848402] CPU: 0 PID: 22784 Comm: kworker/u16:0 Not tainted 5.6.0-rc6 #1
[53545.848405] Hardware name: Gigabyte Technology Co., Ltd. GA-990FXA-UD5/GA-990FXA-UD5, BIOS F12 10/03/2013
[53545.848432] Workqueue: rpciod rpc_async_schedule [sunrpc]
[53545.848440] RIP: 0010:refcount_warn_saturate+0xd9/0xe0
[53545.848446] Code: ff 48 c7 c7 e8 ff d5 81 c6 05 cd 49 b5 00 01 e8 4d 04 cf ff 0f 0b c3 48 c7 c7 90 ff d5 81 c6 05 b9 49 b5 00 01 e8 37 04 cf ff <0f> 0b c3 0f 1f 40 00 8b 07 3d 00 00 00 c0 74 12 83 f8 01 74 46 8d
[53545.848449] RSP: 0018:ffffc900045efde0 EFLAGS: 00010282
[53545.848452] RAX: 0000000000000026 RBX: 0000000000000e81 RCX: 0000000000000007
[53545.848455] RDX: 0000000000000007 RSI: 0000000000000092 RDI: ffff88881fc187c0
[53545.848457] RBP: ffff8887ee7b2c70 R08: 00000000000004ef R09: 0000000000000001
[53545.848459] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8884f1a10510
[53545.848462] R13: ffff88815792f530 R14: 0000000000000001 R15: ffff8882343c1300
[53545.848465] FS:  0000000000000000(0000) GS:ffff88881fc00000(0000) knlGS:0000000000000000
[53545.848467] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[53545.848470] CR2: 0000000002600000 CR3: 0000000511560000 CR4: 00000000000006f0
[53545.848471] Call Trace:
[53545.848501]  nfsd41_destroy_cb+0x36/0x50 [nfsd]
[53545.848524]  rpc_free_task+0x3c/0x70 [sunrpc]
[53545.848544]  __rpc_execute+0x3a5/0x3c0 [sunrpc]
[53545.848552]  ? finish_task_switch+0x7f/0x250
[53545.848571]  rpc_async_schedule+0x2f/0x50 [sunrpc]
[53545.848578]  process_one_work+0x1ca/0x3c0
[53545.848584]  worker_thread+0x45/0x3d0
[53545.848590]  kthread+0xf3/0x130
[53545.848595]  ? process_one_work+0x3c0/0x3c0
[53545.848599]  ? kthread_park+0x80/0x80
[53545.848607]  ret_from_fork+0x1f/0x30
[53545.848613] ---[ end trace dfea44b545c7626a ]---

--MP_/9QWg5urlZxPxOKm+kYVP4rk--
