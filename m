Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDB265EE8D
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jan 2023 15:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbjAEOOm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Jan 2023 09:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbjAEOOb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Jan 2023 09:14:31 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A536D5C91C;
        Thu,  5 Jan 2023 06:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1672928057; bh=QZvkLfwbqo/VHSvWpSYCdzj/6SULM/r+4PdRkEgCVlc=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=MB/DvK36w8h37qv/qvaV/iqaJCuRzaJh/c+FR68WYw0dFsSIWOsbs5Gsh2NjRoqE0
         oiYH6KEwXgpgWst7jhrmIDxyCjbVlKfr7Uvt8thEo4WxXi9FP1AJcbFWJiWdeo2lyq
         iAw7df9EDYKO96nzy4PsnCzhKBpvxVRTSsY26edaanVk/A3k2MMQBOP14fi9SNvSeF
         XHolTIIEMc+TFySMarhKY02isulMDspSlUXY8JgQlK8EPCMp1eHrIxfSrf/Kj8KpuQ
         p39++wBiE7DqU+4Wi4ano2tzOQzjyModgc6IMbhpQNo+G+AnZXcUJ1J+kyeV9hL4to
         bSOCXNK57dLfQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.50.140]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4b1o-1pBmql1Kqc-001id9; Thu, 05
 Jan 2023 15:14:17 +0100
Message-ID: <4248c08afe38f7f0a68a9c1985799c1194cc616e.camel@gmx.de>
Subject: summary: regression: nfs mount (even idle) eventually hangs server
From:   Mike Galbraith <efault@gmx.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Dai Ngo <dai.ngo@oracle.com>
Date:   Thu, 05 Jan 2023 15:14:16 +0100
In-Reply-To: <65ed34338c69cb034295f2c9cbe0af684d65d30f.camel@gmx.de>
References: <65ed34338c69cb034295f2c9cbe0af684d65d30f.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IRnqzms7YqU/eIpC1H1S+f/q/F8F1Vl2VtCk7MW6BgrOcaYCzgj
 yEw+hDc3p6YFzpyJyqTHWAA0HxkE5KvwjhVExLlPSDFhUMoXUfxEXbTDMstBaL8v3euPqJM
 nDBAWij7s5cTagBIskEFFLkYMfQa7ukrFlyBdiQDhl4m9C05Hh/vY0JL7k1fDEYUQfOPp9f
 +NhFxY5cOaHU3JQd1aw/Q==
UI-OutboundReport: notjunk:1;M01:P0:rUiZ7reu6Ws=;mmCYm56WCki7Q9nvk2f3vgyRgJs
 6BZcMfJhVASz4o3MsUbM0eUH29lrEME4PaK9wVUL8K2XVwacqTY1ifChYLF27k9jp1LzCu5jp
 pHbyjc5OXqBVBjs90Nh/bmBFHtl0m4agIC5rpdu6Q6sqBBLEKEG4uJHeuC2mLbJ3sbZc2ASR+
 o9VJ0gqUQR/RiAtcrqNMJkJJwPv2negLqbJY2VVyD8R3Cmd9Ur7a+2enFamOy3wgEZNQCTCfw
 I/FlNwjjdGva+okVAKG715k4VUV039qmZrYMHq7Hjzy5v3nB8Kz9UA40DWjFUGJxOji81kgeU
 1xgmHJ1H0e4k4NgHfFL6ObuQEwuVhrRMmLV9YbxOX97AIDD/45yBtf+B8/3IfHUdE/oX5g8v2
 NWfLQ1pyjR9RgHaxhtvPKoFSRdsNWzO4lNxGrl380S7k+jkI4dtft8roNTjnnx/6372ytpxyg
 jY9f+G5ndv6S0UNhECRLI+CNL5Q5VP98/h5+2V6YiinWBNnQCIrg144zJIoYD0XUmVTNEo20w
 0J6oKUFO3PzIJ6JLhvJ0X/dVuQ3/zzaXADRra/X3fB0Q58ZoK+O3QtkFtyAd9XTKg3nFjxvLb
 FO7sjRMDB7XVUJialvok2aUiG45p02LtU424b2iyoIcFLY/hR5qDcF3WBb0cR2VTz83sJyYwL
 iOlSvRW2F5kRbVilljyF4zMTFBqyTSVAVgCe1vLRx9+hqhdnNkRu0JmY8zJlSbEJUfwHueG0P
 B0AwgDdqwELAnRUA6SURNOre4wikc2XEbgpezZOd7bbPWoUJFQvjz4tdQXhbfo/m6AcL8vXM2
 IostDyw6q4reqKiAIf7qoINjg+cfJWaUaqqlRTv+c6XsX0PMGW2N3OIDQ01PRFwA8gnTcF9CY
 ysE4AEf387tv7K8BG1mWdpv0ie8dkEfePuZPsVy4bf+Vbniqj7C6O+F0vkoMKDq8xWnEqmVF6
 75LIpmbBP59HLtZ73o821GOYlcY=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Executive summary:
44df6f439a17 is the seeming culprit, as taking it and its 3959066b697b
dependency back to 6.1 introduces the problem there, and reverting same
in master cures it.

Reproducer:
mount box:/$pick_a_spot /mnt (server may even mount itself)
find /mnt -type f -exec md5sum {} \;
As that executes, run LTP testcases/bin/min_free_kbytes (or likely any
similar memory hog) on server.  Abbreviated spew below should follow in
short order, and brick server.

Here it just works, real box, VM or even cute little raspberry pi 4b.

Abbreviated workqueue spew:
> [ 1171.959773] ------------[ cut here ]------------
> [ 1171.959792] WARNING: CPU: 4 PID: 81 at kernel/workqueue.c:1654 __queue=
_delayed_work+0x6a/0x90
> [ 1171.959804] Modules linked in: netconsole(E) af_packet(E) hid_logitech=
_hidpp(E) joydev(E) usblp(E) hid_logitech_dj(E) ip6table_mangle(E) ip6table=
_raw(E) iptable_raw(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) iscsi_boot_sys=
fs(E) rfkill(E) nfnetlink(E) ebtable_filter(E) ebtables(E) ip6table_filter(=
E) ip6_tables(E) iptable_filter(E) bpfilter(E) intel_rapl_msr(E) intel_rapl=
_common(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_realte=
k(E) snd_hda_codec_generic(E) ledtrig_audio(E) coretemp(E) snd_hda_codec_hd=
mi(E) iTCO_wdt(E) snd_hda_intel(E) at24(E) nls_iso8859_1(E) kvm_intel(E) in=
tel_pmc_bxt(E) snd_intel_dspcfg(E) regmap_i2c(E) mei_hdcp(E) nls_cp437(E) i=
TCO_vendor_support(E) snd_hda_codec(E) snd_hwdep(E) kvm(E) snd_hda_core(E) =
irqbypass(E) r8169(E) pcspkr(E) snd_pcm(E) realtek(E) i2c_i801(E) mei_me(E)=
 snd_timer(E) mdio_devres(E) snd(E) lpc_ich(E) i2c_smbus(E) libphy(E) sound=
core(E) mfd_core(E) mei(E) fan(E) thermal(E) intel_smartconnect(E) nfsd(E) =
auth_rpcgss(E) nfs_acl(E)
> [ 1171.959869]=C2=A0 lockd(E) sch_fq_codel(E) grace(E) fuse(E) sunrpc(E) =
configfs(E) ip_tables(E) x_tables(E) uas(E) usb_storage(E) hid_generic(E) u=
sbhid(E) nouveau(E) drm_ttm_helper(E) ttm(E) i2c_algo_bit(E) drm_display_he=
lper(E) crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) drm_kms_=
helper(E) sha512_ssse3(E) ahci(E) sha512_generic(E) xhci_pci(E) syscopyarea=
(E) aesni_intel(E) sysfillrect(E) libahci(E) ehci_pci(E) sysimgblt(E) crypt=
o_simd(E) xhci_hcd(E) ehci_hcd(E) cryptd(E) drm(E) libata(E) cec(E) usbcore=
(E) usb_common(E) rc_core(E) video(E) wmi(E) button(E) sd_mod(E) t10_pi(E) =
crc64_rocksoft_generic(E) crc64_rocksoft(E) crc64(E) vfat(E) fat(E) virtio_=
blk(E) virtio_mmio(E) virtio(E) virtio_ring(E) ext4(E) crc32c_intel(E) crc1=
6(E) mbcache(E) jbd2(E) loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rda=
c(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E) efiva=
rfs(E) autofs4(E)
> [ 1171.959962] CPU: 4 PID: 81 Comm: kswapd0 Kdump: loaded Tainted: G=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 E=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 6.1.0.g6feb57c-master #41
> [ 1171.959969] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 0=
9/23/2013
> [ 1171.959972] RIP: 0010:__queue_delayed_work+0x6a/0x90
> [ 1171.959981] Code: 50 48 01 c1 83 ff 08 48 89 4a 30 75 2c 4c 89 c7 e9 1=
b b1 07 00 e9 46 e8 ff ff 0f 0b eb cc 0f 0b 48 81 7a 38 20 32 0a 81 74 aa <=
0f> 0b 48 8b 42 28 48 85 c0 74 a8 0f 0b eb a4 89 fe 4c 89 c7 e9 1d
> [ 1171.959988] RSP: 0018:ffff8881010a7c78 EFLAGS: 00010003
> [ 1171.959992] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000=
0000000
> [ 1171.959997] RDX: ffff88818016b748 RSI: ffff88810a0bae00 RDI: 000000000=
0000008
> [ 1171.960001] RBP: ffff88818016b748 R08: 0000000000000000 R09: 000000000=
0000000
> [ 1171.960005] R10: 0000000000000000 R11: 000000000354f7fb R12: 000000000=
0000008
> [ 1171.960010] R13: ffff88810a0bae00 R14: 0000000000000000 R15: ffff88818=
016b710
> [ 1171.960015] FS:=C2=A0 0000000000000000(0000) GS:ffff88840ed00000(0000)=
 knlGS:0000000000000000
> [ 1171.960019] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1171.960022] CR2: 00007f39558dc000 CR3: 00000001b893a002 CR4: 000000000=
01706e0
> [ 1171.960026] Call Trace:
> [ 1171.960033]=C2=A0 <TASK>
> [ 1171.960038]=C2=A0 mod_delayed_work_on+0x49/0x70
> [ 1171.960049]=C2=A0 nfsd4_state_shrinker_count+0x24/0x50 [nfsd]
> [ 1171.960113]=C2=A0 shrink_slab.constprop.94+0x9d/0x370
> [ 1171.960122]=C2=A0 shrink_node+0x1c5/0x420
> [ 1171.960129]=C2=A0 balance_pgdat+0x25f/0x530
> [ 1171.960137]=C2=A0 ? __pfx_autoremove_wake_function+0x10/0x10
> [ 1171.960143]=C2=A0 kswapd+0x12c/0x360
> [ 1171.960149]=C2=A0 ? __pfx_autoremove_wake_function+0x10/0x10
> [ 1171.960155]=C2=A0 ? __pfx_kswapd+0x10/0x10
> [ 1171.960161]=C2=A0 kthread+0xc0/0xe0
> [ 1171.960167]=C2=A0 ? __pfx_kthread+0x10/0x10
> [ 1171.960172]=C2=A0 ret_from_fork+0x29/0x50
> [ 1171.960180]=C2=A0 </TASK>
> [ 1171.960184] ---[ end trace 0000000000000000 ]---
> [ 1171.960190] ------------[ cut here ]------------
> [ 1171.960193] WARNING: CPU: 4 PID: 81 at kernel/workqueue.c:1656 __queue=
_delayed_work+0x5a/0x90
> [ 1171.960202] Modules linked in: netconsole(E) af_packet(E) hid_logitech=
_hidpp(E) joydev(E) usblp(E) hid_logitech_dj(E) ip6table_mangle(E) ip6table=
_raw(E) iptable_raw(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) iscsi_boot_sys=
fs(E) rfkill(E) nfnetlink(E) ebtable_filter(E) ebtables(E) ip6table_filter(=
E) ip6_tables(E) iptable_filter(E) bpfilter(E) intel_rapl_msr(E) intel_rapl=
_common(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_realte=
k(E) snd_hda_codec_generic(E) ledtrig_audio(E) coretemp(E) snd_hda_codec_hd=
mi(E) iTCO_wdt(E) snd_hda_intel(E) at24(E) nls_iso8859_1(E) kvm_intel(E) in=
tel_pmc_bxt(E) snd_intel_dspcfg(E) regmap_i2c(E) mei_hdcp(E) nls_cp437(E) i=
TCO_vendor_support(E) snd_hda_codec(E) snd_hwdep(E) kvm(E) snd_hda_core(E) =
irqbypass(E) r8169(E) pcspkr(E) snd_pcm(E) realtek(E) i2c_i801(E) mei_me(E)=
 snd_timer(E) mdio_devres(E) snd(E) lpc_ich(E) i2c_smbus(E) libphy(E) sound=
core(E) mfd_core(E) mei(E) fan(E) thermal(E) intel_smartconnect(E) nfsd(E) =
auth_rpcgss(E) nfs_acl(E)
> [ 1171.960259]=C2=A0 lockd(E) sch_fq_codel(E) grace(E) fuse(E) sunrpc(E) =
configfs(E) ip_tables(E) x_tables(E) uas(E) usb_storage(E) hid_generic(E) u=
sbhid(E) nouveau(E) drm_ttm_helper(E) ttm(E) i2c_algo_bit(E) drm_display_he=
lper(E) crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) drm_kms_=
helper(E) sha512_ssse3(E) ahci(E) sha512_generic(E) xhci_pci(E) syscopyarea=
(E) aesni_intel(E) sysfillrect(E) libahci(E) ehci_pci(E) sysimgblt(E) crypt=
o_simd(E) xhci_hcd(E) ehci_hcd(E) cryptd(E) drm(E) libata(E) cec(E) usbcore=
(E) usb_common(E) rc_core(E) video(E) wmi(E) button(E) sd_mod(E) t10_pi(E) =
crc64_rocksoft_generic(E) crc64_rocksoft(E) crc64(E) vfat(E) fat(E) virtio_=
blk(E) virtio_mmio(E) virtio(E) virtio_ring(E) ext4(E) crc32c_intel(E) crc1=
6(E) mbcache(E) jbd2(E) loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rda=
c(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E) efiva=
rfs(E) autofs4(E)
> [ 1171.960352] CPU: 4 PID: 81 Comm: kswapd0 Kdump: loaded Tainted: G=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0 E=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 6.1.0.g6feb57c-master #41
> [ 1171.960358] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 0=
9/23/2013
> [ 1171.960363] RIP: 0010:__queue_delayed_work+0x5a/0x90
> [ 1171.960369] Code: 8b 05 0a 47 16 01 4c 8d 42 20 48 89 72 48 89 7a 50 4=
8 01 c1 83 ff 08 48 89 4a 30 75 2c 4c 89 c7 e9 1b b1 07 00 e9 46 e8 ff ff <=
0f> 0b eb cc 0f 0b 48 81 7a 38 20 32 0a 81 74 aa 0f 0b 48 8b 42 28
> [ 1171.960377] RSP: 0018:ffff8881010a7c78 EFLAGS: 00010003
> [ 1171.960383] RAX: ffff88818016b750 RBX: 0000000000000000 RCX: 000000000=
0000000
> [ 1171.960388] RDX: ffff88818016b748 RSI: ffff88810a0bae00 RDI: 000000000=
0000008
> [ 1171.960394] RBP: ffff88818016b748 R08: 0000000000000000 R09: 000000000=
0000000
> [ 1171.960453] R10: 0000000000000000 R11: 000000000354f7fb R12: 000000000=
0000008
> [ 1171.960459] R13: ffff88810a0bae00 R14: 0000000000000000 R15: ffff88818=
016b710
> [ 1171.960463] FS:=C2=A0 0000000000000000(0000) GS:ffff88840ed00000(0000)=
 knlGS:0000000000000000
> [ 1171.960468] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1171.960473] CR2: 00007f39558dc000 CR3: 00000001b893a002 CR4: 000000000=
01706e0
> [ 1171.960478] Call Trace:
> [ 1171.960481]=C2=A0 <TASK>
> [ 1171.960484]=C2=A0 mod_delayed_work_on+0x49/0x70
> [ 1171.960492]=C2=A0 nfsd4_state_shrinker_count+0x24/0x50 [nfsd]
> [ 1171.960542]=C2=A0 shrink_slab.constprop.94+0x9d/0x370
> [ 1171.960550]=C2=A0 shrink_node+0x1c5/0x420
> [ 1171.960557]=C2=A0 balance_pgdat+0x25f/0x530
> [ 1171.960564]=C2=A0 ? __pfx_autoremove_wake_function+0x10/0x10
> [ 1171.960571]=C2=A0 kswapd+0x12c/0x360
> [ 1171.960578]=C2=A0 ? __pfx_autoremove_wake_function+0x10/0x10
> [ 1171.960583]=C2=A0 ? __pfx_kswapd+0x10/0x10
> [ 1171.960589]=C2=A0 kthread+0xc0/0xe0
> [ 1171.960594]=C2=A0 ? __pfx_kthread+0x10/0x10
> [ 1171.960599]=C2=A0 ret_from_fork+0x29/0x50
> [ 1171.960607]=C2=A0 </TASK>
> [ 1171.960611] ---[ end trace 0000000000000000 ]---
> [ 1171.960617] ------------[ cut here ]------------
> [ 1171.960620] WARNING: CPU: 4 PID: 81 at kernel/workqueue.c:1499 __queue=
_work+0x33b/0x3d0
> [ 1171.960628] Modules linked in: netconsole(E) af_packet(E) hid_logitech=
_hidpp(E) joydev(E) usblp(E) hid_logitech_dj(E) ip6table_mangle(E) ip6table=
_raw(E) iptable_raw(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) iscsi_boot_sys=
fs(E) rfkill(E) nfnetlink(E) ebtable_filter(E) ebtables(E) ip6table_filter(=
E) ip6_tables(E) iptable_filter(E) bpfilter(E) intel_rapl_msr(E) intel_rapl=
_common(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_realte=
k(E) snd_hda_codec_generic(E) ledtrig_audio(E) coretemp(E) snd_hda_codec_hd=
mi(E) iTCO_wdt(E) snd_hda_intel(E) at24(E) nls_iso8859_1(E) kvm_intel(E) in=
tel_pmc_bxt(E) snd_intel_dspcfg(E) regmap_i2c(E) mei_hdcp(E) nls_cp437(E) i=
TCO_vendor_support(E) snd_hda_codec(E) snd_hwdep(E) kvm(E) snd_hda_core(E) =
irqbypass(E) r8169(E) pcspkr(E) snd_pcm(E) realtek(E) i2c_i801(E) mei_me(E)=
 snd_timer(E) mdio_devres(E) snd(E) lpc_ich(E) i2c_smbus(E) libphy(E) sound=
core(E) mfd_core(E) mei(E) fan(E) thermal(E) intel_smartconnect(E) nfsd(E) =
auth_rpcgss(E) nfs_acl(E)
> [ 1171.960687]=C2=A0 lockd(E) sch_fq_codel(E) grace(E) fuse(E) sunrpc(E) =
configfs(E) ip_tables(E) x_tables(E) uas(E) usb_storage(E) hid_generic(E) u=
sbhid(E) nouveau(E) drm_ttm_helper(E) ttm(E) i2c_algo_bit(E) drm_display_he=
lper(E) crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) drm_kms_=
helper(E) sha512_ssse3(E) ahci(E) sha512_generic(E) xhci_pci(E) syscopyarea=
(E) aesni_intel(E) sysfillrect(E) libahci(E) ehci_pci(E) sysimgblt(E) crypt=
o_simd(E) xhci_hcd(E) ehci_hcd(E) cryptd(E) drm(E) libata(E) cec(E) usbcore=
(E) usb_common(E) rc_core(E) video(E) wmi(E) button(E) sd_mod(E) t10_pi(E) =
crc64_rocksoft_generic(E) crc64_rocksoft(E) crc64(E) vfat(E) fat(E) virtio_=
blk(E) virtio_mmio(E) virtio(E) virtio_ring(E) ext4(E) crc32c_intel(E) crc1=
6(E) mbcache(E) jbd2(E) loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rda=
c(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E) efiva=
rfs(E) autofs4(E)
> [ 1171.960775] CPU: 4 PID: 81 Comm: kswapd0 Kdump: loaded Tainted: G=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0 E=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 6.1.0.g6feb57c-master #41
> [ 1171.960781] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 0=
9/23/2013
> [ 1171.960787] RIP: 0010:__queue_work+0x33b/0x3d0
> [ 1171.960793] Code: 25 40 d3 02 00 f6 47 2c 20 74 18 e8 6f 6f 00 00 48 8=
5 c0 74 0e 48 8b 40 20 48 3b 68 08 0f 84 f5 fc ff ff 0f 0b e9 fe fd ff ff <=
0f> 0b e9 ee fd ff ff 83 c9 02 49 8d 57 68 e9 d7 fd ff ff 80 3d f3
> [ 1171.960801] RSP: 0018:ffff8881010a7c38 EFLAGS: 00010003
> [ 1171.960807] RAX: ffff88818016b750 RBX: ffffffff81fcc880 RCX: 000000000=
0000000
> [ 1171.960811] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88810=
0078000
> [ 1171.960816] RBP: ffff88810a0bae00 R08: ffff888100400028 R09: ffff88810=
0400000
> [ 1171.960821] R10: 0000000000000000 R11: ffffffff8225d5c8 R12: 000000000=
0000008
> [ 1171.960826] R13: 0000000000000004 R14: ffff88818016b748 R15: ffff88812=
0a5e000
> [ 1171.960831] FS:=C2=A0 0000000000000000(0000) GS:ffff88840ed00000(0000)=
 knlGS:0000000000000000
> [ 1171.960838] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1171.960842] CR2: 00007f39558dc000 CR3: 00000001b893a002 CR4: 000000000=
01706e0
> [ 1171.960848] Call Trace:
> [ 1171.960853]=C2=A0 <TASK>
> [ 1171.960857]=C2=A0 mod_delayed_work_on+0x49/0x70
> [ 1171.960864]=C2=A0 nfsd4_state_shrinker_count+0x24/0x50 [nfsd]
> [ 1171.960912]=C2=A0 shrink_slab.constprop.94+0x9d/0x370
> [ 1171.960919]=C2=A0 shrink_node+0x1c5/0x420
> [ 1171.960926]=C2=A0 balance_pgdat+0x25f/0x530
> [ 1171.960932]=C2=A0 ? __pfx_autoremove_wake_function+0x10/0x10
> [ 1171.960939]=C2=A0 kswapd+0x12c/0x360
> [ 1171.960945]=C2=A0 ? __pfx_autoremove_wake_function+0x10/0x10
> [ 1171.960950]=C2=A0 ? __pfx_kswapd+0x10/0x10
> [ 1171.960956]=C2=A0 kthread+0xc0/0xe0
> [ 1171.960961]=C2=A0 ? __pfx_kthread+0x10/0x10
> [ 1171.960965]=C2=A0 ret_from_fork+0x29/0x50
> [ 1171.960973]=C2=A0 </TASK>
> [ 1171.960976] ---[ end trace 0000000000000000 ]---

