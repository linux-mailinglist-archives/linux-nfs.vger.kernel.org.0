Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AD4665468
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jan 2023 07:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjAKGN5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Jan 2023 01:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjAKGN4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Jan 2023 01:13:56 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADE9E35
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 22:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1673417624; bh=8Os73O8BpVYSUfL9D5rbqOw9ZoT/7Qhkc61BSbVpAIA=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=DKvT0V+2ta8hyT7sCISnEYjdkHrcaZqbkH7tinaSCQfyz173sd8ACZZrRHiIJcOHZ
         CddOsrwE4CH3KqlELPfHxZCVTWi4bESZVAlCkHzL1vfumKO7yp6+pid8A+XfwUICbN
         xDBdNlgwJIqtLPk4kon5nhyJXUf6VjCOMMFe93WHLEaGKXCNpAo7jpfToppmfipHTB
         MItrXTHoo1vXaa1srDa7Zoyft06ZT/bvdBMtNucRFK2qF+RFRgE+Q5wjA1TEiaKqH7
         0epJjDgVWPC9qCB1njkA0VrvU8Jv5HU2aJy7hbw/+oFKfcjSWgbacJaff4csa7vaRn
         wAx5TSxfD0HEA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.48.212]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSbx3-1pMKwr1zIX-00StEg; Wed, 11
 Jan 2023 07:13:44 +0100
Message-ID: <9ec87cfd9599f7003be625e8f98a67d11eb51fe2.camel@gmx.de>
Subject: Re: [PATCH v2 1/1] NFSD: fix WARN_ON_ONCE in __queue_delayed_work
From:   Mike Galbraith <efault@gmx.de>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com,
        jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 11 Jan 2023 07:13:42 +0100
In-Reply-To: <6b42a8201a43738be9e3b1735fc5f99426d45816.camel@gmx.de>
References: <1673412221-8037-1-git-send-email-dai.ngo@oracle.com>
         <6b42a8201a43738be9e3b1735fc5f99426d45816.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VwvSmOX10QAnoWWbDtvb/ihmuGGyB6d77rtnfU26TlIoqL+vKg5
 h5BPnkj5Ij+QPEYNUxVl0Fp+jMHRMcsxJNuNGmDUxdhVw/XBSDwCAOVpbEyxKDU/WxuQNvf
 BFHWLdSW8mUW2wXN1vRP080EGPnAMVSO1pz7ljQwlaEJGALwFbhUY2VjtpyWlshHzaGc1Z1
 TEtB9G8rtlCYg3pQzVyIw==
UI-OutboundReport: notjunk:1;M01:P0:TIk5Ft902Cc=;v6nIP7wACdq84sg7ExRysXBdeum
 /hBk9Q6/PEJvVZ8PC5vAzZC8cnU2OFNHWw6JPbc+2yOU0/89z1LhQwvT2EKvf5Luw4/DNzSVN
 gKiyQ02i4rWLZA0bIYjoxytBJskcl6pLVosasT9icWNr9BheOY8dswnwnt6uDAVG+EYBAOjD3
 AoMesJ5OT/GX2dl1wQwWwMs8yZ7V8iYB+SXi9ru7lV3bT2qzC1heY5NiVwIHVmCe5ZPo/paRr
 hn0YoaqbcqkPufLCHBIZKcNAtS7cjafnxsaEOJzd10aXFGoQa8qigl2Ulfp/UJ87kDU+FYVlI
 KnfJHA6o+zme5aA+WWvQzLX9EpKbBH4rz+9ITtRkY30TkfNJ7i6X5Qs2ZZy6lqXtLRwWtkNtm
 xmXEyiDHw4qGALk34HeCJ8zbcrPiigGcyf6M8bVkkZNhNDmFozY2nRTsBXWpJmA4Jl1Hh/ZWk
 ddTyrYYgzsITwCbc27oiK61ktXlmWSoVKNewthoEKfH42PrbRKMYY/iMO5yXbFBg08sfJ5H3I
 /i9QJynm1wEAnyxEE33YWkLwwz2hWEQAjqYDomwMV3E2TDVPTXraAu37aIf4oZkUEk3xlXBiO
 uiCcedKM2H+oYnkDkoY1do8TAZxqEdICZ3T5NM4wzgUG8lldVNgg6ZBpILvkP5sF5m1qxbubk
 J9r0W7BBIJkOYy29d0CyWhIEgT0/iuUxJlOwuRAr0mCjLSxHhTVEA/uuNDRMS56trHKU3x1XM
 qqYpvuPnqgFyRh3Sr8esTA+E7ZzXwd/P01iqkI5T8Wi+KH+OIVoE9rZ2/RUy1ngbiygm+zJ+a
 2/Kxzll2sqcCOlJyO/rllTL8xPCy+VL3gWiG+Fof32XvhBPrPYrmDLfvKHDvagR0C4rJ0MdAA
 tyG4t3jFApUcT1282PzIM3JftCh769jEcHd88lOn3QTYKvzJ0OooNq6xSQmd0sSvM58+GVdTK
 NTvNmA==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2023-01-11 at 06:57 +0100, Mike Galbraith wrote:
> The last two hunks don't apply to virgin source, but after wedging them
> in, reproducer no longer inspires box to moan, groan and brick.

Unless of course I actually boot the freshly installed f-ing kernel
before moving on to repro procedure <thwap>.  No brick, but 1 moan.

[   50.248802] __vm_enough_memory: pid: 4180, comm: min_free_kbytes, no en=
ough memory for the allocation
[   50.272784] __vm_enough_memory: pid: 2022, comm: plasmashell, no enough=
 memory for the allocation
[   50.273398] __vm_enough_memory: pid: 2022, comm: plasmashell, no enough=
 memory for the allocation
[   50.932149] __vm_enough_memory: pid: 4279, comm: min_free_kbytes, no en=
ough memory for the allocation
[   51.732046] __vm_enough_memory: pid: 4489, comm: QQmlThread, no enough =
memory for the allocation
[   51.732119] __vm_enough_memory: pid: 4363, comm: min_free_kbytes, no en=
ough memory for the allocation
[   51.733205] __vm_enough_memory: pid: 4489, comm: QQmlThread, no enough =
memory for the allocation
[   51.735339] __vm_enough_memory: pid: 4489, comm: QQmlThread, no enough =
memory for the allocation
[   51.736425] __vm_enough_memory: pid: 4489, comm: QQmlThread, no enough =
memory for the allocation
[   51.737616] __vm_enough_memory: pid: 4489, comm: QQmlThread, no enough =
memory for the allocation
[   51.816074] plasmashell[4413]: segfault at 0 ip 00007fd4cef2ce95 sp 000=
07ffd66c9c1a0 error 6 in swrast_dri.so[7fd4ce200000+16d2000] likely on CPU=
 1 (core 0, socket 0)
[   51.817541] Code: c7 86 f0 1a 00 00 00 00 00 00 c1 e9 03 f3 48 ab 4c 89=
 e7 e8 bd 76 a7 ff be 10 06 01 00 bf 01 00 00 00 e8 fe 30 46 ff 4c 89 e6 <=
48> 89 18 48 89 ef 49 89 c5 e8 4d 69 a7 ff 0f 1f 44 00 00 48 89 ef
[   54.930735] ------------[ cut here ]------------
[   54.931137] WARNING: CPU: 6 PID: 77 at kernel/workqueue.c:1499 __queue_=
work+0x33b/0x3d0
[   54.931747] Modules linked in: netconsole(E) rpcsec_gss_krb5(E) nfsv4(E=
) dns_resolver(E) nfs(E) fscache(E) netfs(E) af_packet(E) ip6table_mangle(=
E) ip6table_raw(E) iptable_raw(E) bridge(E) stp(E) llc(E) rfkill(E) nfnetl=
ink(E) ebtable_filter(E) ebtables(E) ip6table_filter(E) ip6_tables(E) ipta=
ble_filter(E) bpfilter(E) joydev(E) snd_hda_codec_generic(E) ledtrig_audio=
(E) intel_rapl_msr(E) intel_rapl_common(E) snd_hda_intel(E) snd_intel_dspc=
fg(E) snd_hda_codec(E) snd_hwdep(E) kvm_intel(E) snd_hda_core(E) snd_pcm(E=
) iTCO_wdt(E) intel_pmc_bxt(E) kvm(E) snd_timer(E) iTCO_vendor_support(E) =
irqbypass(E) snd(E) i2c_i801(E) pcspkr(E) lpc_ich(E) i2c_smbus(E) soundcor=
e(E) virtio_balloon(E) mfd_core(E) virtio_net(E) net_failover(E) failover(=
E) button(E) nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E) sch_fq_co=
del(E) fuse(E) sunrpc(E) configfs(E) ip_tables(E) x_tables(E) ext4(E) crc1=
6(E) mbcache(E) jbd2(E) hid_generic(E) usbhid(E) crct10dif_pclmul(E) qxl(E=
) crc32_pclmul(E) drm_ttm_helper(E)
[   54.931812]  crc32c_intel(E) ghash_clmulni_intel(E) ttm(E) sha512_ssse3=
(E) sha512_generic(E) drm_kms_helper(E) xhci_pci(E) ahci(E) syscopyarea(E)=
 sysfillrect(E) aesni_intel(E) sysimgblt(E) crypto_simd(E) xhci_hcd(E) lib=
ahci(E) virtio_blk(E) virtio_console(E) cryptd(E) serio_raw(E) libata(E) u=
sbcore(E) virtio_pci(E) virtio_pci_legacy_dev(E) usb_common(E) drm(E) virt=
io_pci_modern_dev(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_=
dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E) virtio_rng(E) =
virtio(E) virtio_ring(E) autofs4(E)
[   54.942372] CPU: 6 PID: 77 Comm: kswapd0 Kdump: loaded Tainted: G      =
      E      6.2.0.g7dd4b80-master #67
[   54.943162] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS re=
l-1.15.0-0-g2dd4b9b-rebuilt.opensuse.org 04/01/2014
[   54.944039] RIP: 0010:__queue_work+0x33b/0x3d0
[   54.944434] Code: 25 40 d3 02 00 f6 47 2c 20 74 18 e8 6f 6f 00 00 48 85=
 c0 74 0e 48 8b 40 20 48 3b 68 08 0f 84 f5 fc ff ff 0f 0b e9 fe fd ff ff <=
0f> 0b e9 ee fd ff ff 83 c9 02 49 8d 57 68 e9 d7 fd ff ff 80 3d 83
[   54.945938] RSP: 0018:ffff888100dd7c50 EFLAGS: 00010003
[   54.946573] RAX: ffff8881042ac350 RBX: ffffffff81fcc880 RCX: 0000000000=
000000
[   54.947176] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888100=
078000
[   54.947749] RBP: ffff88810713e800 R08: ffff888100400028 R09: ffff888100=
400000
[   54.948313] R10: 0000000000000000 R11: ffffffff8225d5c8 R12: 0000000000=
000008
[   54.948928] R13: 0000000000000006 R14: ffff8881042ac348 R15: ffff888103=
462400
[   54.949492] FS:  0000000000000000(0000) GS:ffff888277d80000(0000) knlGS=
:0000000000000000
[   54.950153] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   54.950617] CR2: 00007f8dff5ff9c8 CR3: 000000014ac78002 CR4: 0000000000=
170ee0
[   54.951174] Call Trace:
[   54.951389]  <TASK>
[   54.951575]  queue_work_on+0x24/0x30
[   54.951876]  nfsd4_state_shrinker_count+0x69/0x80 [nfsd]
[   54.952357]  shrink_slab.constprop.94+0x9d/0x370
[   54.952740]  shrink_node+0x1c5/0x420
[   54.953044]  balance_pgdat+0x25f/0x530
[   54.953359]  ? __pfx_autoremove_wake_function+0x10/0x10
[   54.953785]  kswapd+0x12c/0x360
[   54.954062]  ? __pfx_autoremove_wake_function+0x10/0x10
[   54.954483]  ? __pfx_kswapd+0x10/0x10
[   54.954787]  kthread+0xc0/0xe0
[   54.955053]  ? __pfx_kthread+0x10/0x10
[   54.955360]  ret_from_fork+0x29/0x50
[   54.955655]  </TASK>
[   54.955844] ---[ end trace 0000000000000000 ]---

