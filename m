Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B54E618E414
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Mar 2020 20:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbgCUTvA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 21 Mar 2020 15:51:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34762 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgCUTvA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 21 Mar 2020 15:51:00 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02LJh0OF183514;
        Sat, 21 Mar 2020 19:50:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=FkYDoPbxAdFj3OjJ/2q9cQl6ed4npbXs12ybaG2zVNs=;
 b=Ifu9A8BQgfMXYQwg3qGWBSgFuCQPuSWRWa8AESMFH6/GlRPUMtXwmYx1NIcnBb/HiUGp
 wBbQyJyK0R6c4ekis9eSLuzKDQNTG91PbrBMObXTJZWAg2lD7X0TjJ4Ay9eO2vnxh9ER
 7Qs7GMGaP05zjJi9f2/veKAU9lm6csrk+RJ0lS+8S752XcF1rW+NimkW0Dm9Jj/cToSC
 R5CQ3DbMbusN3HdxZqNO9R4ymrhpn4CddW69oyF1pEV+LPCuMqr0+N1+k2NMyBw7myKL
 7H1Gjvt2YVc4XFSWX1ICawmhjqd1T6XgQGl/a64x21Rph4/8nccAxdZcPnt/zRxmYukU rw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2ywabqsg6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Mar 2020 19:50:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02LJo3ct113904;
        Sat, 21 Mar 2020 19:50:55 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2ywar1t47r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Mar 2020 19:50:55 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02LJoqiT031723;
        Sat, 21 Mar 2020 19:50:52 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 21 Mar 2020 12:50:51 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: refcount underflow in nfsd41_destroy_cb
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAHmME9ro8BPBTMfu8dEbGmkH7qHLdQ=CXGEOW2C7MR4bmT6T+w@mail.gmail.com>
Date:   Sat, 21 Mar 2020 15:50:50 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <44C9D860-4F51-46B1-88A3-D10DDEF4BD8E@oracle.com>
References: <CAHmME9ro8BPBTMfu8dEbGmkH7qHLdQ=CXGEOW2C7MR4bmT6T+w@mail.gmail.com>
To:     Jan Psota <jasiu@belsznica.pl>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9567 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 suspectscore=2
 malwarescore=0 spamscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003210117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9567 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=2
 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1011 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003210117
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 20, 2020, at 10:51 PM, Jason A. Donenfeld <Jason@zx2c4.com> =
wrote:
>=20
> Hello,
>=20
> A user erroneously sent me a refcount UaF in NFS with 5.6-rc6. I
> thought I should forward it onward here in case this is not already
> known. The original reporter is CC'd in case you have any questions.

Jan, how are you reproducing this?


> Regards,
> Jason
>=20
> -------8<------------------------
>=20
> Mar 20 21:43:34 agro kernel: ------------[ cut here ]------------
> Mar 20 21:43:34 agro kernel: refcount_t: underflow; use-after-free.
> Mar 20 21:43:34 agro kernel: WARNING: CPU: 1 PID: 9334 at
> lib/refcount.c:28 refcount_warn_saturate+0xd9/0xe0
> Mar 20 21:43:34 agro kernel: Modules linked in: md5 wireguard
> curve25519_x86_64 libcurve25519_generic libchacha20poly1305
> chacha_x86_64 libchacha poly1305_x86_64 ip6_udp_tunnel udp_tunnel
> libblake2s blake2s_x86_64 libblake2s_generic xt_mac xt_nat
> xt_MASQUERADE xt_REDIRECT xt_owner xt_comment ipt_REJECT
> nf_reject_ipv4 xt_mark xt_hashlimit xt_multiport nfnetlink_log
> xt_NFLOG nf_log_ipv4 nf_log_common xt_LOG nf_nat_tftp nf_nat_sip
> nf_nat_h323 nf_nat_ftp nf_conntrack_tftp nf_conntrack_sip
> nf_conntrack_netlink nfnetlink nf_conntrack_h323 nf_conntrack_ftp nfsd
> auth_rpcgss nfs_acl lockd grace sunrpc cpufreq_ondemand msr bridge stp
> llc xt_tcpudp xt_conntrack iptable_mangle iptable_nat nf_nat
> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_raw iptable_filter
> ip_tables x_tables btrfs blake2b_generic xor raid6_pq libcrc32c
> zstd_compress zstd_decompress zlib_deflate zlib_inflate uas
> usb_storage snd_hda_codec_realtek snd_hda_codec_generic matroxfb_base
> matroxfb_g450 matroxfb_Ti3026 snd_hda_int
> el matroxfb_accel
> Mar 20 21:43:34 agro kernel:  snd_intel_dspcfg cfbfillrect cfbimgblt
> atlantic snd_hda_codec r8169 cfbcopyarea e1000e snd_hda_core snd_hwdep
> matroxfb_DAC1064 g450_pll matroxfb_misc ptp realtek fb snd_pcm libphy
> snd_timer mxm_wmi xhci_pci pcspkr i2c_piix4 input_leds pps_core fbdev
> k10temp ohci_pci snd xhci_hcd ohci_hcd ehci_pci soundcore i2c_core
> ehci_hcd wmi acpi_cpufreq vhci_hcd usbip_core usbcore usb_common
> vhost_net vhost kvm_amd kvm irqbypass loop tun fuse it87 hwmon_vid
> hwmon
> Mar 20 21:43:34 agro kernel: CPU: 1 PID: 9334 Comm: kworker/u16:3 Not
> tainted 5.6.0-rc6 #1
> Mar 20 21:43:34 agro kernel: Hardware name: Gigabyte Technology Co.,
> Ltd. GA-990FXA-UD5/GA-990FXA-UD5, BIOS F12 10/03/2013
> Mar 20 21:43:34 agro kernel: Workqueue: rpciod rpc_async_schedule =
[sunrpc]
> Mar 20 21:43:34 agro kernel: RIP: =
0010:refcount_warn_saturate+0xd9/0xe0
> Mar 20 21:43:34 agro kernel: Code: ff 48 c7 c7 e8 ff d5 81 c6 05 cd 49
> b5 00 01 e8 4d 04 cf ff 0f 0b c3 48 c7 c7 90 ff d5 81 c6 05 b9 49 b5
> 00 01 e8 37 04 cf ff <0f> 0b c3 0f 1f 40 00 8b 07 3d 00 00 00 c0 74 12
> 83 f8 01 74 46 8d
> Mar 20 21:43:34 agro kernel: RSP: 0018:ffffc900010dfde0 EFLAGS: =
00010282
> Mar 20 21:43:34 agro kernel: RAX: 0000000000000026 RBX:
> 0000000000000e81 RCX: 0000000000000007
> Mar 20 21:43:34 agro kernel: RDX: 0000000000000007 RSI:
> 0000000000000092 RDI: ffff88881fc587c0
> Mar 20 21:43:34 agro kernel: RBP: ffff8887eeb40470 R08:
> 00000000000004d9 R09: 0000000000000001
> Mar 20 21:43:34 agro kernel: R10: 0000000000000000 R11:
> 0000000000000001 R12: ffff8884f1e28510
> Mar 20 21:43:34 agro kernel: R13: ffff88837dc49f30 R14:
> 0000000000000001 R15: ffff888780b8a840
> Mar 20 21:43:34 agro kernel: FS:  0000000000000000(0000)
> GS:ffff88881fc40000(0000) knlGS:0000000000000000
> Mar 20 21:43:34 agro kernel: CS:  0010 DS: 0000 ES: 0000 CR0: =
0000000080050033
> Mar 20 21:43:34 agro kernel: CR2: 000000000421efb0 CR3:
> 0000000510564000 CR4: 00000000000006e0
> Mar 20 21:43:34 agro kernel: Call Trace:
> Mar 20 21:43:34 agro kernel:  nfsd41_destroy_cb+0x36/0x50 [nfsd]
> Mar 20 21:43:34 agro kernel:  rpc_free_task+0x3c/0x70 [sunrpc]
> Mar 20 21:43:34 agro kernel:  __rpc_execute+0x3a5/0x3c0 [sunrpc]
> Mar 20 21:43:34 agro kernel:  ? finish_task_switch+0x7f/0x250
> Mar 20 21:43:34 agro kernel:  rpc_async_schedule+0x2f/0x50 [sunrpc]
> Mar 20 21:43:34 agro kernel:  process_one_work+0x1ca/0x3c0
> Mar 20 21:43:34 agro kernel:  worker_thread+0x45/0x3d0
> Mar 20 21:43:34 agro kernel:  kthread+0xf3/0x130
> Mar 20 21:43:34 agro kernel:  ? process_one_work+0x3c0/0x3c0
> Mar 20 21:43:34 agro kernel:  ? kthread_park+0x80/0x80
> Mar 20 21:43:34 agro kernel:  ret_from_fork+0x1f/0x30
> Mar 20 21:43:34 agro kernel: ---[ end trace 99765c8e28c46274 ]---

--
Chuck Lever



