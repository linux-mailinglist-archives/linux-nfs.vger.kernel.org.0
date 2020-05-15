Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C0B1D5C04
	for <lists+linux-nfs@lfdr.de>; Sat, 16 May 2020 00:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgEOWBr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Fri, 15 May 2020 18:01:47 -0400
Received: from fieldses.org ([173.255.197.46]:37482 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgEOWBr (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 15 May 2020 18:01:47 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id C6B4CAAA; Fri, 15 May 2020 18:01:46 -0400 (EDT)
Date:   Fri, 15 May 2020 18:01:46 -0400
To:     Jan Psota <jasiu@belsznica.pl>
Cc:     linux-nfs@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: refcount underflow in nfsd41_destroy_cb
Message-ID: <20200515220146.GA1669@fieldses.org>
References: <CAHmME9ro8BPBTMfu8dEbGmkH7qHLdQ=CXGEOW2C7MR4bmT6T+w@mail.gmail.com>
 <20200321154128.58eb8ef2.jasiu@belsznica.pl>
 <20200511012348.0ff190bc.jasiu@belsznica.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200511012348.0ff190bc.jasiu@belsznica.pl>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, May 11, 2020 at 01:23:48AM +0200, Jan Psota wrote:
> Hi!
> Today's nfsd trace in attachment. My NFS-root-ed client worked on
> qemu-5.0.0 and tap interface (qemu has nothing to do with that effect
> - on another server, physical machine client is connected through gigabit
> ethernet). Error appeared on intensive NFS operations (Gentoo Linux on
> client was installing Libre Office from binary package, moving files
> from /var/tmp/portage to root filesystem).
> 
> Server /proc/version:
> 	Linux version 5.7.0-rc2 (root@mordimer)
> 	(gcc version 9.3.0 (Gentoo 9.3.0 p2), GNU ld (Gentoo 2.34 p1) 2.34.0)
> 	#1 SMP PREEMPT Tue Apr 21 21:52:13 CEST 2020
> 
> server /proc/cmdline:
> 	BOOT_IMAGE=/vmlinuz root=/dev/md0p4 panic=30 rw
> 	md=0,/dev/sda,/dev/sdb rootdelay=1 ipv6.disable=1
> 
> Client side errors were only some:
> 	nfs: server 192.168.2.1 not responding, still trying
> 	nfs: server 192.168.2.1 OK
> but it is normal.

> [17957.413775] ------------[ cut here ]------------
> [17957.413804] refcount_t: underflow; use-after-free.

Looks like this is in the !cb->cb_need restart case of nfsd4_cb_release,
which is ->release method of nfsd4_cb_ops.

So, an rpc task for a callback is being freed and decrementing
clp->cl_cb_inflight, and discovering that cl_cb_inflight is already less
than or equal to 0.  Either we've got unbalanced increments and
decrements of cl_cb_inflight, or clp has already been freed out from
under us.

I'm looking but can't quite see yet how that can happen.

--b.


> [17957.413835] WARNING: CPU: 1 PID: 26127 at lib/refcount.c:28 refcount_warn_saturate+0xd8/0xe0
> [17957.413872] Modules linked in: md5 nfsd auth_rpcgss nfs_acl lockd grace sunrpc fuse vhost_net vhost vhost_iotlb xt_mac xt_socket nf_socket_ipv4 xt_MASQUERADE xt_REDIRECT xt_TPROXY nf_tproxy_ipv4 xt_comment ipt_REJECT nf_reject_ipv4 xt_mark xt_multiport nfnetlink_log xt_NFLOG nf_log_ipv4 nf_log_common xt_LOG nf_nat_tftp nf_nat_sip nf_nat_h323 nf_nat_ftp nf_conntrack_tftp nf_conntrack_sip nf_conntrack_netlink nfnetlink nf_conntrack_h323 nf_conntrack_ftp tun bridge stp llc xt_tcpudp xt_conntrack iptable_mangle iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_raw iptable_filter ip_tables x_tables rc_it913x_v1 it913x_fe hid_generic usbhid hid dvb_usb_it913x dvb_usb_v2 dvb_core videobuf2_vmalloc videobuf2_memops videobuf2_common rc_core btrfs blake2b_generic xor raid6_pq libcrc32c zlib_deflate zlib_inflate snd_hda_codec_realtek snd_hda_codec_generic x86_pkg_temp_thermal kvm_intel kvm ppdev irqbypass i915 crct10dif_pclmul crc32_pclmul sr_mod intel_cstate iosf_mbi
> [17957.413896]  intel_rapl_perf input_leds drm_kms_helper snd_hda_intel syscopyarea snd_intel_dspcfg sysfillrect pcspkr cdrom sysimgblt i2c_i801 fb_sys_fops intel_gtt r8169 snd_hda_codec i2c_algo_bit ehci_pci cfbfillrect cfbimgblt ehci_hcd realtek lpc_ich mei_me cfbcopyarea snd_hda_core usbcore libphy sky2 fb snd_hwdep mei mfd_core usb_common fbdev thermal parport_pc parport video sch_fq_codel snd_pcm_oss snd_mixer_oss snd_pcm snd_timer drm snd drm_panel_orientation_quirks soundcore agpgart backlight i2c_core coretemp hwmon
> [17957.414516] CPU: 1 PID: 26127 Comm: kworker/u4:2 Not tainted 5.7.0-rc2 #1
> [17957.414545] Hardware name: MSI MS-7788/H61M-P20 (G3) (MS-7788), BIOS V1.9 01/10/2013
> [17957.414587] Workqueue: rpciod rpc_async_schedule [sunrpc]
> [17957.414612] RIP: 0010:refcount_warn_saturate+0xd8/0xe0
> [17957.414633] Code: ff 48 c7 c7 f0 7a d7 81 c6 05 d1 35 d7 00 01 e8 5b 9b d0 ff 0f 0b c3 48 c7 c7 98 7a d7 81 c6 05 bd 35 d7 00 01 e8 45 9b d0 ff <0f> 0b c3 0f 1f 44 00 00 8b 07 3d 00 00 00 c0 74 12 83 f8 01 74 46
> [17957.414716] RSP: 0018:ffffc90000bafde0 EFLAGS: 00010282
> [17957.414738] RAX: 0000000000000026 RBX: 0000000000000e81 RCX: 0000000000000007
> [17957.414767] RDX: 0000000000000007 RSI: 0000000000000092 RDI: ffff888216718800
> [17957.414798] RBP: ffff8881c5270c70 R08: 0000000000000338 R09: ffffc90010054024
> [17957.414828] R10: 0000000000aaaaaa R11: 0000000000000000 R12: ffff88805b0a0510
> [17957.414857] R13: ffff888011707b30 R14: 0000000000000001 R15: ffff888130c9d000
> [17957.414889] FS:  0000000000000000(0000) GS:ffff888216700000(0000) knlGS:0000000000000000
> [17957.414924] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [17957.414948] CR2: 00005600ba4586e8 CR3: 000000015a210004 CR4: 00000000001626e0
> [17957.414978] Call Trace:
> [17957.414996]  nfsd41_destroy_cb+0x2c/0x40 [nfsd]
> [17957.415020]  rpc_free_task+0x31/0x50 [sunrpc]
> [17957.415042]  __rpc_execute+0x38f/0x3a0 [sunrpc]
> [17957.415063]  ? pick_next_task_fair+0x295/0x2b0
> [17957.415082]  ? finish_task_switch+0x70/0x230
> [17957.415103]  rpc_async_schedule+0x24/0x40 [sunrpc]
> [17957.416404]  process_one_work+0x1cd/0x3c0
> [17957.417680]  worker_thread+0x45/0x3c0
> [17957.418947]  kthread+0x10b/0x150
> [17957.420195]  ? process_one_work+0x3c0/0x3c0
> [17957.421420]  ? kthread_park+0x80/0x80
> [17957.422620]  ret_from_fork+0x1f/0x30
> [17957.423790] ---[ end trace d52e90aa624996f1 ]---

