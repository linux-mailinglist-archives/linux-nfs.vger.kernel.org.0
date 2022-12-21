Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7028652F11
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Dec 2022 11:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbiLUKAW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 21 Dec 2022 05:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbiLUJ7y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 21 Dec 2022 04:59:54 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569C99588;
        Wed, 21 Dec 2022 01:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1671616578; bh=b4nA65ccPuOouxAeD/YL9AeskkW6B0T7lNO/lBfb21I=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=JxNmP2x8l13P/ra4B6xSm+X0BhZlM8lUYIgYP6O4E6eoO+aET/NywyQABY4E24CUy
         rUuFB+8ZplfXzdONqSqIt3dBVDUaI5DiowgpgZ+d5mQNnOjfxkcLCg5olbfSe9YG07
         OMsZTJyE1dEo1bYT40uBIjYgrjsQ/InH7GszmGDNPVKiMh+qYRkjKQWydNctQRENQq
         2h5in2WkOC4qM5ls1muOISFBKeRwxXc+r1wCVJDnwQoowahUWSImksL+LtTlSkEMlO
         4B4glTkHSsEshDQ7ON5z5Foi8+MSxxn5vSc0FGMupAUamws+jUFUwxj1102JgTdkna
         lJLwQtzB0So7w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([212.114.172.145]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MqJqN-1oTwWo41z9-00nRjg; Wed, 21
 Dec 2022 10:56:18 +0100
Message-ID: <360f3dcfb6cfbefdbcc42fc84c660995142a8645.camel@gmx.de>
Subject: Re: regression: nfs mount (even idle) eventually hangs server
From:   Mike Galbraith <efault@gmx.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 21 Dec 2022 10:56:17 +0100
In-Reply-To: <65ed34338c69cb034295f2c9cbe0af684d65d30f.camel@gmx.de>
References: <65ed34338c69cb034295f2c9cbe0af684d65d30f.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SejSxPHURc/yedxCp5QfxeVzqB+Nj3WisLH2FAv4LATUBGZRiBc
 YGW0MJRj+bFYevaHwLaVmie/HMeyTnBO5j9VjDWogFsunCu3rVZ4VxHhpPaACtLywQgwSYR
 0lOdsfXQVEnvDXzimfq4nNFaqiRtIPwGmNruVazkEoA8QN+3O1pm1eNSV0gnUCYWclFw1KF
 LbThUMgvk9ZxQP7nRH9og==
UI-OutboundReport: notjunk:1;M01:P0:iUl45DmsLf4=;Mdt0g6dfWxBnReiPvc+V8Rtwecm
 J57nuG7wCYDr/mrsk4A35XWIGMbbSa9kTCB3GKeeamNe+fghSDwlVa3QAjN7cyf99w+qbGI/h
 IV8YqT3Drx9gJdCvqkKgeAeSnwzsB5ZLen+SKkX//hVGCFygSnoyDBnSjc9Crd9LuVQcDnLQW
 WdU0bVSVtW6el5px53eCxeL9L5BlEs2fXXTihX/374Fr2J2jCTt9k0iYLwoqOCdpJ+63NT6y0
 +JmT533k8T25RjuVQkk9R3RlTctvANLm18wPEU/Zn5OhiTkrbYtOjQB0M88HGp/Fxw2FRTwJE
 Qqil7BNxynH0b6Q1RmjDOfdqRgSDvN37SdaaNz0kmZlR16MWMIp3SOpk2whvTBEqUzJKQBRLe
 LYBPSYoKmD1ZBwDJW7Xv5uIwsJFPOc64ba1e/GOf/h3Q1H8NzOZi8b/WRbqaQuYPkhSRnExOD
 OArynAH2LUPHoyjPQ4ohYd/U8A9suwnFhkJacpm3siHV82lENRVkRF718eZTZPWNTMY5YUVt5
 7lXssJqMKLGaLh4XIpUbRlzhgW+V172KPKS3x0nNpjgz7ag2L6NKlCXJm0LG23TkfxAdybd60
 YktTGiz11uLvw4MugtEuyVGETtKX4lntTmZplMrZdU50X9VUn36J8Zmxbf+wPCNsjvIFnva3c
 RFITWjlLLwN7D4WUDR8o05ha1qDhGjghjB0nlI/RIjDHAnpy7UzvRBCeMqu5XwEiH1vptTOiA
 iPu2Eco4c3EQfpj0BjyKnVjFc/LWi9j7v2Goon9yVk57d7XuLVtrFKvoSuVd7TLzL0wmPFtFP
 6Aq80RwwyPr1YTxidhWsmBMJVxS5v0uyKE5G/owNa6tr0UljeQhpITHq/rLrowQmFNauN3x5V
 /oFM8Fmn/Fh379yDo+ALpryYawJ5hVHM04JDV2GSDYCS9kkGvVPxAPOOxo2Y4qxtRvsB3S10m
 kUucDeb6Ihm7ZoHWo1gVm5o+W9U=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

(forgotten CC)

On Wed, 2022-12-21 at 09:59 +0100, Mike Galbraith wrote:
> scenario: /home/mikeg of desktop box mounted by lappy, lappy sitting
> idle with user mikeg not even logged in.=C2=A0 Reclaim inducing activity
> on
> desktop box eventually leads to spew below.=C2=A0 I've hung the box thre=
e
> times in two days, twice with light client side activity, and below
> with none, ie with the mount point allegedly merely existing. Sans
> nfs
> mount, box seems perfectly fine. 6.1 didn't reproduce either, so it
> would appear to be a merge window bug.
>
> [ 1171.959773] ------------[ cut here ]------------
> [ 1171.959792] WARNING: CPU: 4 PID: 81 at kernel/workqueue.c:1654
> __queue_delayed_work+0x6a/0x90
> [ 1171.959804] Modules linked in: netconsole(E) af_packet(E)
> hid_logitech_hidpp(E) joydev(E) usblp(E) hid_logitech_dj(E)
> ip6table_mangle(E) ip6table_raw(E) iptable_raw(E) bridge(E) stp(E)
> llc(E) iscsi_ibft(E) iscsi_boot_sysfs(E) rfkill(E) nfnetlink(E)
> ebtable_filter(E) ebtables(E) ip6table_filter(E) ip6_tables(E)
> iptable_filter(E) bpfilter(E) intel_rapl_msr(E) intel_rapl_common(E)
> x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_realtek(E)
> snd_hda_codec_generic(E) ledtrig_audio(E) coretemp(E)
> snd_hda_codec_hdmi(E) iTCO_wdt(E) snd_hda_intel(E) at24(E)
> nls_iso8859_1(E) kvm_intel(E) intel_pmc_bxt(E) snd_intel_dspcfg(E)
> regmap_i2c(E) mei_hdcp(E) nls_cp437(E) iTCO_vendor_support(E)
> snd_hda_codec(E) snd_hwdep(E) kvm(E) snd_hda_core(E) irqbypass(E)
> r8169(E) pcspkr(E) snd_pcm(E) realtek(E) i2c_i801(E) mei_me(E)
> snd_timer(E) mdio_devres(E) snd(E) lpc_ich(E) i2c_smbus(E) libphy(E)
> soundcore(E) mfd_core(E) mei(E) fan(E) thermal(E)
> intel_smartconnect(E) nfsd(E) auth_rpcgss(E) nfs_acl(E)
> [ 1171.959869]=C2=A0 lockd(E) sch_fq_codel(E) grace(E) fuse(E) sunrpc(E)
> configfs(E) ip_tables(E) x_tables(E) uas(E) usb_storage(E)
> hid_generic(E) usbhid(E) nouveau(E) drm_ttm_helper(E) ttm(E)
> i2c_algo_bit(E) drm_display_helper(E) crct10dif_pclmul(E)
> crc32_pclmul(E) ghash_clmulni_intel(E) drm_kms_helper(E)
> sha512_ssse3(E) ahci(E) sha512_generic(E) xhci_pci(E) syscopyarea(E)
> aesni_intel(E) sysfillrect(E) libahci(E) ehci_pci(E) sysimgblt(E)
> crypto_simd(E) xhci_hcd(E) ehci_hcd(E) cryptd(E) drm(E) libata(E)
> cec(E) usbcore(E) usb_common(E) rc_core(E) video(E) wmi(E) button(E)
> sd_mod(E) t10_pi(E) crc64_rocksoft_generic(E) crc64_rocksoft(E)
> crc64(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) virtio(E)
> virtio_ring(E) ext4(E) crc32c_intel(E) crc16(E) mbcache(E) jbd2(E)
> loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E)
> scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E)
> efivarfs(E) autofs4(E)
> [ 1171.959962] CPU: 4 PID: 81 Comm: kswapd0 Kdump: loaded Tainted:
> G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 E=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.1.0.g6feb57c-master #41
> [ 1171.959969] Hardware name: MEDION MS-7848/MS-7848, BIOS
> M7848W08.20C 09/23/2013
> [ 1171.959972] RIP: 0010:__queue_delayed_work+0x6a/0x90
> [ 1171.959981] Code: 50 48 01 c1 83 ff 08 48 89 4a 30 75 2c 4c 89 c7
> e9 1b b1 07 00 e9 46 e8 ff ff 0f 0b eb cc 0f 0b 48 81 7a 38 20 32 0a
> 81 74 aa <0f> 0b 48 8b 42 28 48 85 c0 74 a8 0f 0b eb a4 89 fe 4c 89
> c7 e9 1d
> [ 1171.959988] RSP: 0018:ffff8881010a7c78 EFLAGS: 00010003
> [ 1171.959992] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
> 0000000000000000
> [ 1171.959997] RDX: ffff88818016b748 RSI: ffff88810a0bae00 RDI:
> 0000000000000008
> [ 1171.960001] RBP: ffff88818016b748 R08: 0000000000000000 R09:
> 0000000000000000
> [ 1171.960005] R10: 0000000000000000 R11: 000000000354f7fb R12:
> 0000000000000008
> [ 1171.960010] R13: ffff88810a0bae00 R14: 0000000000000000 R15:
> ffff88818016b710
> [ 1171.960015] FS:=C2=A0 0000000000000000(0000) GS:ffff88840ed00000(0000=
)
> knlGS:0000000000000000
> [ 1171.960019] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1171.960022] CR2: 00007f39558dc000 CR3: 00000001b893a002 CR4:
> 00000000001706e0
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
> [ 1171.960193] WARNING: CPU: 4 PID: 81 at kernel/workqueue.c:1656
> __queue_delayed_work+0x5a/0x90
> [ 1171.960202] Modules linked in: netconsole(E) af_packet(E)
> hid_logitech_hidpp(E) joydev(E) usblp(E) hid_logitech_dj(E)
> ip6table_mangle(E) ip6table_raw(E) iptable_raw(E) bridge(E) stp(E)
> llc(E) iscsi_ibft(E) iscsi_boot_sysfs(E) rfkill(E) nfnetlink(E)
> ebtable_filter(E) ebtables(E) ip6table_filter(E) ip6_tables(E)
> iptable_filter(E) bpfilter(E) intel_rapl_msr(E) intel_rapl_common(E)
> x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_realtek(E)
> snd_hda_codec_generic(E) ledtrig_audio(E) coretemp(E)
> snd_hda_codec_hdmi(E) iTCO_wdt(E) snd_hda_intel(E) at24(E)
> nls_iso8859_1(E) kvm_intel(E) intel_pmc_bxt(E) snd_intel_dspcfg(E)
> regmap_i2c(E) mei_hdcp(E) nls_cp437(E) iTCO_vendor_support(E)
> snd_hda_codec(E) snd_hwdep(E) kvm(E) snd_hda_core(E) irqbypass(E)
> r8169(E) pcspkr(E) snd_pcm(E) realtek(E) i2c_i801(E) mei_me(E)
> snd_timer(E) mdio_devres(E) snd(E) lpc_ich(E) i2c_smbus(E) libphy(E)
> soundcore(E) mfd_core(E) mei(E) fan(E) thermal(E)
> intel_smartconnect(E) nfsd(E) auth_rpcgss(E) nfs_acl(E)
> [ 1171.960259]=C2=A0 lockd(E) sch_fq_codel(E) grace(E) fuse(E) sunrpc(E)
> configfs(E) ip_tables(E) x_tables(E) uas(E) usb_storage(E)
> hid_generic(E) usbhid(E) nouveau(E) drm_ttm_helper(E) ttm(E)
> i2c_algo_bit(E) drm_display_helper(E) crct10dif_pclmul(E)
> crc32_pclmul(E) ghash_clmulni_intel(E) drm_kms_helper(E)
> sha512_ssse3(E) ahci(E) sha512_generic(E) xhci_pci(E) syscopyarea(E)
> aesni_intel(E) sysfillrect(E) libahci(E) ehci_pci(E) sysimgblt(E)
> crypto_simd(E) xhci_hcd(E) ehci_hcd(E) cryptd(E) drm(E) libata(E)
> cec(E) usbcore(E) usb_common(E) rc_core(E) video(E) wmi(E) button(E)
> sd_mod(E) t10_pi(E) crc64_rocksoft_generic(E) crc64_rocksoft(E)
> crc64(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) virtio(E)
> virtio_ring(E) ext4(E) crc32c_intel(E) crc16(E) mbcache(E) jbd2(E)
> loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E)
> scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E)
> efivarfs(E) autofs4(E)
> [ 1171.960352] CPU: 4 PID: 81 Comm: kswapd0 Kdump: loaded Tainted:
> G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0 E=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 6.1.0.g6feb57c-master #41
> [ 1171.960358] Hardware name: MEDION MS-7848/MS-7848, BIOS
> M7848W08.20C 09/23/2013
> [ 1171.960363] RIP: 0010:__queue_delayed_work+0x5a/0x90
> [ 1171.960369] Code: 8b 05 0a 47 16 01 4c 8d 42 20 48 89 72 48 89 7a
> 50 48 01 c1 83 ff 08 48 89 4a 30 75 2c 4c 89 c7 e9 1b b1 07 00 e9 46
> e8 ff ff <0f> 0b eb cc 0f 0b 48 81 7a 38 20 32 0a 81 74 aa 0f 0b 48
> 8b 42 28
> [ 1171.960377] RSP: 0018:ffff8881010a7c78 EFLAGS: 00010003
> [ 1171.960383] RAX: ffff88818016b750 RBX: 0000000000000000 RCX:
> 0000000000000000
> [ 1171.960388] RDX: ffff88818016b748 RSI: ffff88810a0bae00 RDI:
> 0000000000000008
> [ 1171.960394] RBP: ffff88818016b748 R08: 0000000000000000 R09:
> 0000000000000000
> [ 1171.960453] R10: 0000000000000000 R11: 000000000354f7fb R12:
> 0000000000000008
> [ 1171.960459] R13: ffff88810a0bae00 R14: 0000000000000000 R15:
> ffff88818016b710
> [ 1171.960463] FS:=C2=A0 0000000000000000(0000) GS:ffff88840ed00000(0000=
)
> knlGS:0000000000000000
> [ 1171.960468] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1171.960473] CR2: 00007f39558dc000 CR3: 00000001b893a002 CR4:
> 00000000001706e0
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
> [ 1171.960620] WARNING: CPU: 4 PID: 81 at kernel/workqueue.c:1499
> __queue_work+0x33b/0x3d0
> [ 1171.960628] Modules linked in: netconsole(E) af_packet(E)
> hid_logitech_hidpp(E) joydev(E) usblp(E) hid_logitech_dj(E)
> ip6table_mangle(E) ip6table_raw(E) iptable_raw(E) bridge(E) stp(E)
> llc(E) iscsi_ibft(E) iscsi_boot_sysfs(E) rfkill(E) nfnetlink(E)
> ebtable_filter(E) ebtables(E) ip6table_filter(E) ip6_tables(E)
> iptable_filter(E) bpfilter(E) intel_rapl_msr(E) intel_rapl_common(E)
> x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_realtek(E)
> snd_hda_codec_generic(E) ledtrig_audio(E) coretemp(E)
> snd_hda_codec_hdmi(E) iTCO_wdt(E) snd_hda_intel(E) at24(E)
> nls_iso8859_1(E) kvm_intel(E) intel_pmc_bxt(E) snd_intel_dspcfg(E)
> regmap_i2c(E) mei_hdcp(E) nls_cp437(E) iTCO_vendor_support(E)
> snd_hda_codec(E) snd_hwdep(E) kvm(E) snd_hda_core(E) irqbypass(E)
> r8169(E) pcspkr(E) snd_pcm(E) realtek(E) i2c_i801(E) mei_me(E)
> snd_timer(E) mdio_devres(E) snd(E) lpc_ich(E) i2c_smbus(E) libphy(E)
> soundcore(E) mfd_core(E) mei(E) fan(E) thermal(E)
> intel_smartconnect(E) nfsd(E) auth_rpcgss(E) nfs_acl(E)
> [ 1171.960687]=C2=A0 lockd(E) sch_fq_codel(E) grace(E) fuse(E) sunrpc(E)
> configfs(E) ip_tables(E) x_tables(E) uas(E) usb_storage(E)
> hid_generic(E) usbhid(E) nouveau(E) drm_ttm_helper(E) ttm(E)
> i2c_algo_bit(E) drm_display_helper(E) crct10dif_pclmul(E)
> crc32_pclmul(E) ghash_clmulni_intel(E) drm_kms_helper(E)
> sha512_ssse3(E) ahci(E) sha512_generic(E) xhci_pci(E) syscopyarea(E)
> aesni_intel(E) sysfillrect(E) libahci(E) ehci_pci(E) sysimgblt(E)
> crypto_simd(E) xhci_hcd(E) ehci_hcd(E) cryptd(E) drm(E) libata(E)
> cec(E) usbcore(E) usb_common(E) rc_core(E) video(E) wmi(E) button(E)
> sd_mod(E) t10_pi(E) crc64_rocksoft_generic(E) crc64_rocksoft(E)
> crc64(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) virtio(E)
> virtio_ring(E) ext4(E) crc32c_intel(E) crc16(E) mbcache(E) jbd2(E)
> loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E)
> scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E)
> efivarfs(E) autofs4(E)
> [ 1171.960775] CPU: 4 PID: 81 Comm: kswapd0 Kdump: loaded Tainted:
> G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0 E=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 6.1.0.g6feb57c-master #41
> [ 1171.960781] Hardware name: MEDION MS-7848/MS-7848, BIOS
> M7848W08.20C 09/23/2013
> [ 1171.960787] RIP: 0010:__queue_work+0x33b/0x3d0
> [ 1171.960793] Code: 25 40 d3 02 00 f6 47 2c 20 74 18 e8 6f 6f 00 00
> 48 85 c0 74 0e 48 8b 40 20 48 3b 68 08 0f 84 f5 fc ff ff 0f 0b e9 fe
> fd ff ff <0f> 0b e9 ee fd ff ff 83 c9 02 49 8d 57 68 e9 d7 fd ff ff
> 80 3d f3
> [ 1171.960801] RSP: 0018:ffff8881010a7c38 EFLAGS: 00010003
> [ 1171.960807] RAX: ffff88818016b750 RBX: ffffffff81fcc880 RCX:
> 0000000000000000
> [ 1171.960811] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> ffff888100078000
> [ 1171.960816] RBP: ffff88810a0bae00 R08: ffff888100400028 R09:
> ffff888100400000
> [ 1171.960821] R10: 0000000000000000 R11: ffffffff8225d5c8 R12:
> 0000000000000008
> [ 1171.960826] R13: 0000000000000004 R14: ffff88818016b748 R15:
> ffff888120a5e000
> [ 1171.960831] FS:=C2=A0 0000000000000000(0000) GS:ffff88840ed00000(0000=
)
> knlGS:0000000000000000
> [ 1171.960838] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1171.960842] CR2: 00007f39558dc000 CR3: 00000001b893a002 CR4:
> 00000000001706e0
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
> [ 1171.961009] ------------[ cut here ]------------
> [ 1171.961013] WARNING: CPU: 4 PID: 81 at kernel/workqueue.c:1499
> __queue_work+0x33b/0x3d0
> [ 1171.961022] Modules linked in: netconsole(E) af_packet(E)
> hid_logitech_hidpp(E) joydev(E) usblp(E) hid_logitech_dj(E)
> ip6table_mangle(E) ip6table_raw(E) iptable_raw(E) bridge(E) stp(E)
> llc(E) iscsi_ibft(E) iscsi_boot_sysfs(E) rfkill(E) nfnetlink(E)
> ebtable_filter(E) ebtables(E) ip6table_filter(E) ip6_tables(E)
> iptable_filter(E) bpfilter(E) intel_rapl_msr(E) intel_rapl_common(E)
> x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_realtek(E)
> snd_hda_codec_generic(E) ledtrig_audio(E) coretemp(E)
> snd_hda_codec_hdmi(E) iTCO_wdt(E) snd_hda_intel(E) at24(E)
> nls_iso8859_1(E) kvm_intel(E) intel_pmc_bxt(E) snd_intel_dspcfg(E)
> regmap_i2c(E) mei_hdcp(E) nls_cp437(E) iTCO_vendor_support(E)
> snd_hda_codec(E) snd_hwdep(E) kvm(E) snd_hda_core(E) irqbypass(E)
> r8169(E) pcspkr(E) snd_pcm(E) realtek(E) i2c_i801(E) mei_me(E)
> snd_timer(E) mdio_devres(E) snd(E) lpc_ich(E) i2c_smbus(E) libphy(E)
> soundcore(E) mfd_core(E) mei(E) fan(E) thermal(E)
> intel_smartconnect(E) nfsd(E) auth_rpcgss(E) nfs_acl(E)
> [ 1171.961079]=C2=A0 lockd(E) sch_fq_codel(E) grace(E) fuse(E) sunrpc(E)
> configfs(E) ip_tables(E) x_tables(E) uas(E) usb_storage(E)
> hid_generic(E) usbhid(E) nouveau(E) drm_ttm_helper(E) ttm(E)
> i2c_algo_bit(E) drm_display_helper(E) crct10dif_pclmul(E)
> crc32_pclmul(E) ghash_clmulni_intel(E) drm_kms_helper(E)
> sha512_ssse3(E) ahci(E) sha512_generic(E) xhci_pci(E) syscopyarea(E)
> aesni_intel(E) sysfillrect(E) libahci(E) ehci_pci(E) sysimgblt(E)
> crypto_simd(E) xhci_hcd(E) ehci_hcd(E) cryptd(E) drm(E) libata(E)
> cec(E) usbcore(E) usb_common(E) rc_core(E) video(E) wmi(E) button(E)
> sd_mod(E) t10_pi(E) crc64_rocksoft_generic(E) crc64_rocksoft(E)
> crc64(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) virtio(E)
> virtio_ring(E) ext4(E) crc32c_intel(E) crc16(E) mbcache(E) jbd2(E)
> loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E)
> scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E)
> efivarfs(E) autofs4(E)
> [ 1171.961171] CPU: 4 PID: 81 Comm: kswapd0 Kdump: loaded Tainted:
> G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0 E=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 6.1.0.g6feb57c-master #41
> [ 1171.961177] Hardware name: MEDION MS-7848/MS-7848, BIOS
> M7848W08.20C 09/23/2013
> [ 1171.961183] RIP: 0010:__queue_work+0x33b/0x3d0
> [ 1171.961189] Code: 25 40 d3 02 00 f6 47 2c 20 74 18 e8 6f 6f 00 00
> 48 85 c0 74 0e 48 8b 40 20 48 3b 68 08 0f 84 f5 fc ff ff 0f 0b e9 fe
> fd ff ff <0f> 0b e9 ee fd ff ff 83 c9 02 49 8d 57 68 e9 d7 fd ff ff
> 80 3d f3
> [ 1171.961195] RSP: 0018:ffff8881010a7c38 EFLAGS: 00010003
> [ 1171.961200] RAX: ffff8881ecf4b350 RBX: ffffffff81fcc880 RCX:
> 0000000000000000
> [ 1171.961207] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> ffff888100078000
> [ 1171.961212] RBP: ffff88810a0bae00 R08: ffff888100400028 R09:
> ffff888100400000
> [ 1171.961217] R10: 0000000000000000 R11: ffffffff8225d5c8 R12:
> 0000000000000008
> [ 1171.961222] R13: 0000000000000004 R14: ffff8881ecf4b348 R15:
> ffff888120a5e000
> [ 1171.961226] FS:=C2=A0 0000000000000000(0000) GS:ffff88840ed00000(0000=
)
> knlGS:0000000000000000
> [ 1171.961232] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1171.961237] CR2: 00007f39558dc000 CR3: 00000001b893a002 CR4:
> 00000000001706e0
> [ 1171.961242] Call Trace:
> [ 1171.961245]=C2=A0 <TASK>
> [ 1171.961249]=C2=A0 mod_delayed_work_on+0x49/0x70
> [ 1171.961256]=C2=A0 nfsd4_state_shrinker_count+0x24/0x50 [nfsd]
> [ 1171.961306]=C2=A0 shrink_slab.constprop.94+0x9d/0x370
> [ 1171.961314]=C2=A0 shrink_node+0x1c5/0x420
> [ 1171.961320]=C2=A0 balance_pgdat+0x25f/0x530
> [ 1171.961326]=C2=A0 ? __pfx_autoremove_wake_function+0x10/0x10
> [ 1171.961332]=C2=A0 kswapd+0x12c/0x360
> [ 1171.961338]=C2=A0 ? __pfx_autoremove_wake_function+0x10/0x10
> [ 1171.961344]=C2=A0 ? __pfx_kswapd+0x10/0x10
> [ 1171.961349]=C2=A0 kthread+0xc0/0xe0
> [ 1171.961354]=C2=A0 ? __pfx_kthread+0x10/0x10
> [ 1171.961359]=C2=A0 ret_from_fork+0x29/0x50
> [ 1171.961367]=C2=A0 </TASK>
> [ 1171.961370] ---[ end trace 0000000000000000 ]---
> [ 1171.961382] ------------[ cut here ]------------
> [ 1171.961386] WARNING: CPU: 4 PID: 81 at kernel/workqueue.c:1499
> __queue_work+0x33b/0x3d0
> [ 1171.961395] Modules linked in: netconsole(E) af_packet(E)
> hid_logitech_hidpp(E) joydev(E) usblp(E) hid_logitech_dj(E)
> ip6table_mangle(E) ip6table_raw(E) iptable_raw(E) bridge(E) stp(E)
> llc(E) iscsi_ibft(E) iscsi_boot_sysfs(E) rfkill(E) nfnetlink(E)
> ebtable_filter(E) ebtables(E) ip6table_filter(E) ip6_tables(E)
> iptable_filter(E) bpfilter(E) intel_rapl_msr(E) intel_rapl_common(E)
> x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_realtek(E)
> snd_hda_codec_generic(E) ledtrig_audio(E) coretemp(E)
> snd_hda_codec_hdmi(E) iTCO_wdt(E) snd_hda_intel(E) at24(E)
> nls_iso8859_1(E) kvm_intel(E) intel_pmc_bxt(E) snd_intel_dspcfg(E)
> regmap_i2c(E) mei_hdcp(E) nls_cp437(E) iTCO_vendor_support(E)
> snd_hda_codec(E) snd_hwdep(E) kvm(E) snd_hda_core(E) irqbypass(E)
> r8169(E) pcspkr(E) snd_pcm(E) realtek(E) i2c_i801(E) mei_me(E)
> snd_timer(E) mdio_devres(E) snd(E) lpc_ich(E) i2c_smbus(E) libphy(E)
> soundcore(E) mfd_core(E) mei(E) fan(E) thermal(E)
> intel_smartconnect(E) nfsd(E) auth_rpcgss(E) nfs_acl(E)
> [ 1171.961451]=C2=A0 lockd(E) sch_fq_codel(E) grace(E) fuse(E) sunrpc(E)
> configfs(E) ip_tables(E) x_tables(E) uas(E) usb_storage(E)
> hid_generic(E) usbhid(E) nouveau(E) drm_ttm_helper(E) ttm(E)
> i2c_algo_bit(E) drm_display_helper(E) crct10dif_pclmul(E)
> crc32_pclmul(E) ghash_clmulni_intel(E) drm_kms_helper(E)
> sha512_ssse3(E) ahci(E) sha512_generic(E) xhci_pci(E) syscopyarea(E)
> aesni_intel(E) sysfillrect(E) libahci(E) ehci_pci(E) sysimgblt(E)
> crypto_simd(E) xhci_hcd(E) ehci_hcd(E) cryptd(E) drm(E) libata(E)
> cec(E) usbcore(E) usb_common(E) rc_core(E) video(E) wmi(E) button(E)
> sd_mod(E) t10_pi(E) crc64_rocksoft_generic(E) crc64_rocksoft(E)
> crc64(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) virtio(E)
> virtio_ring(E) ext4(E) crc32c_intel(E) crc16(E) mbcache(E) jbd2(E)
> loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E)
> scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E)
> efivarfs(E) autofs4(E)
> [ 1171.961542] CPU: 4 PID: 81 Comm: kswapd0 Kdump: loaded Tainted:
> G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0 E=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 6.1.0.g6feb57c-master #41
> [ 1171.961548] Hardware name: MEDION MS-7848/MS-7848, BIOS
> M7848W08.20C 09/23/2013
> [ 1171.961552] RIP: 0010:__queue_work+0x33b/0x3d0
> [ 1171.961561] Code: 25 40 d3 02 00 f6 47 2c 20 74 18 e8 6f 6f 00 00
> 48 85 c0 74 0e 48 8b 40 20 48 3b 68 08 0f 84 f5 fc ff ff 0f 0b e9 fe
> fd ff ff <0f> 0b e9 ee fd ff ff 83 c9 02 49 8d 57 68 e9 d7 fd ff ff
> 80 3d f3
> [ 1171.961568] RSP: 0018:ffff8881010a7c38 EFLAGS: 00010003
> [ 1171.961572] RAX: ffff888198393b50 RBX: ffffffff81fcc880 RCX:
> 0000000000000000
> [ 1171.961578] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> ffff888100078000
> [ 1171.961583] RBP: ffff88810a0bae00 R08: ffff888100400028 R09:
> ffff888100400000
> [ 1171.961589] R10: 0000000000000000 R11: ffffffff8225d5c8 R12:
> 0000000000000008
> [ 1171.961593] R13: 0000000000000004 R14: ffff888198393b48 R15:
> ffff888120a5e000
> [ 1171.961598] FS:=C2=A0 0000000000000000(0000) GS:ffff88840ed00000(0000=
)
> knlGS:0000000000000000
> [ 1171.961602] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1171.961606] CR2: 00007f39558dc000 CR3: 00000001b893a002 CR4:
> 00000000001706e0
> [ 1171.961612] Call Trace:
> [ 1171.961615]=C2=A0 <TASK>
> [ 1171.961619]=C2=A0 mod_delayed_work_on+0x49/0x70
> [ 1171.961625]=C2=A0 nfsd4_state_shrinker_count+0x24/0x50 [nfsd]
> [ 1171.961674]=C2=A0 shrink_slab.constprop.94+0x9d/0x370
> [ 1171.961681]=C2=A0 shrink_node+0x1c5/0x420
> [ 1171.961687]=C2=A0 balance_pgdat+0x25f/0x530
> [ 1171.961693]=C2=A0 ? __pfx_autoremove_wake_function+0x10/0x10
> [ 1171.961700]=C2=A0 kswapd+0x12c/0x360
> [ 1171.961706]=C2=A0 ? __pfx_autoremove_wake_function+0x10/0x10
> [ 1171.961712]=C2=A0 ? __pfx_kswapd+0x10/0x10
> [ 1171.961718]=C2=A0 kthread+0xc0/0xe0
> [ 1171.961723]=C2=A0 ? __pfx_kthread+0x10/0x10
> [ 1171.961728]=C2=A0 ret_from_fork+0x29/0x50
> [ 1171.961735]=C2=A0 </TASK>
> [ 1171.961738] ---[ end trace 0000000000000000 ]---
> [ 1171.961752] ------------[ cut here ]------------
> [ 1171.961757] WARNING: CPU: 4 PID: 81 at kernel/workqueue.c:1499
> __queue_work+0x33b/0x3d0
> [ 1171.961765] Modules linked in: netconsole(E) af_packet(E)
> hid_logitech_hidpp(E) joydev(E) usblp(E) hid_logitech_dj(E)
> ip6table_mangle(E) ip6table_raw(E) iptable_raw(E) bridge(E) stp(E)
> llc(E) iscsi_ibft(E) iscsi_boot_sysfs(E) rfkill(E) nfnetlink(E)
> ebtable_filter(E) ebtables(E) ip6table_filter(E) ip6_tables(E)
> iptable_filter(E) bpfilter(E) intel_rapl_msr(E) intel_rapl_common(E)
> x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_realtek(E)
> snd_hda_codec_generic(E) ledtrig_audio(E) coretemp(E)
> snd_hda_codec_hdmi(E) iTCO_wdt(E) snd_hda_intel(E) at24(E)
> nls_iso8859_1(E) kvm_intel(E) intel_pmc_bxt(E) snd_intel_dspcfg(E)
> regmap_i2c(E) mei_hdcp(E) nls_cp437(E) iTCO_vendor_support(E)
> snd_hda_codec(E) snd_hwdep(E) kvm(E) snd_hda_core(E) irqbypass(E)
> r8169(E) pcspkr(E) snd_pcm(E) realtek(E) i2c_i801(E) mei_me(E)
> snd_timer(E) mdio_devres(E) snd(E) lpc_ich(E) i2c_smbus(E) libphy(E)
> soundcore(E) mfd_core(E) mei(E) fan(E) thermal(E)
> intel_smartconnect(E) nfsd(E) auth_rpcgss(E) nfs_acl(E)
> [ 1171.961822]=C2=A0 lockd(E) sch_fq_codel(E) grace(E) fuse(E) sunrpc(E)
> configfs(E) ip_tables(E) x_tables(E) uas(E) usb_storage(E)
> hid_generic(E) usbhid(E) nouveau(E) drm_ttm_helper(E) ttm(E)
> i2c_algo_bit(E) drm_display_helper(E) crct10dif_pclmul(E)
> crc32_pclmul(E) ghash_clmulni_intel(E) drm_kms_helper(E)
> sha512_ssse3(E) ahci(E) sha512_generic(E) xhci_pci(E) syscopyarea(E)
> aesni_intel(E) sysfillrect(E) libahci(E) ehci_pci(E) sysimgblt(E)
> crypto_simd(E) xhci_hcd(E) ehci_hcd(E) cryptd(E) drm(E) libata(E)
> cec(E) usbcore(E) usb_common(E) rc_core(E) video(E) wmi(E) button(E)
> sd_mod(E) t10_pi(E) crc64_rocksoft_generic(E) crc64_rocksoft(E)
> crc64(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) virtio(E)
> virtio_ring(E) ext4(E) crc32c_intel(E) crc16(E) mbcache(E) jbd2(E)
> loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E)
> scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E)
> efivarfs(E) autofs4(E)
> [ 1171.961911] CPU: 4 PID: 81 Comm: kswapd0 Kdump: loaded Tainted:
> G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0 E=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 6.1.0.g6feb57c-master #41
> [ 1171.961917] Hardware name: MEDION MS-7848/MS-7848, BIOS
> M7848W08.20C 09/23/2013
> [ 1171.961921] RIP: 0010:__queue_work+0x33b/0x3d0
> [ 1171.961927] Code: 25 40 d3 02 00 f6 47 2c 20 74 18 e8 6f 6f 00 00
> 48 85 c0 74 0e 48 8b 40 20 48 3b 68 08 0f 84 f5 fc ff ff 0f 0b e9 fe
> fd ff ff <0f> 0b e9 ee fd ff ff 83 c9 02 49 8d 57 68 e9 d7 fd ff ff
> 80 3d f3
> [ 1171.961934] RSP: 0018:ffff8881010a7c38 EFLAGS: 00010003
> [ 1171.961939] RAX: ffff8881058ad350 RBX: ffffffff81fcc880 RCX:
> 0000000000000000
> [ 1171.961947] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> ffff888100078000
> [ 1171.961951] RBP: ffff88810a0bae00 R08: ffff888100400028 R09:
> ffff888100400000
> [ 1171.961955] R10: 0000000000000000 R11: ffffffff8225d5c8 R12:
> 0000000000000008
> [ 1171.961959] R13: 0000000000000004 R14: ffff8881058ad348 R15:
> ffff888120a5e000
> [ 1171.961964] FS:=C2=A0 0000000000000000(0000) GS:ffff88840ed00000(0000=
)
> knlGS:0000000000000000
> [ 1171.961969] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1171.961973] CR2: 00007f39558dc000 CR3: 00000001b893a002 CR4:
> 00000000001706e0
> [ 1171.961978] Call Trace:
> [ 1171.961982]=C2=A0 <TASK>
> [ 1171.961986]=C2=A0 mod_delayed_work_on+0x49/0x70
> [ 1171.961993]=C2=A0 nfsd4_state_shrinker_count+0x24/0x50 [nfsd]
> [ 1171.962041]=C2=A0 shrink_slab.constprop.94+0x9d/0x370
> [ 1171.962049]=C2=A0 shrink_node+0x1c5/0x420
> [ 1171.962055]=C2=A0 balance_pgdat+0x25f/0x530
> [ 1171.962063]=C2=A0 ? __pfx_autoremove_wake_function+0x10/0x10
> [ 1171.962069]=C2=A0 kswapd+0x12c/0x360
> [ 1171.962074]=C2=A0 ? __pfx_autoremove_wake_function+0x10/0x10
> [ 1171.962080]=C2=A0 ? __pfx_kswapd+0x10/0x10
> [ 1171.962085]=C2=A0 kthread+0xc0/0xe0
> [ 1171.962091]=C2=A0 ? __pfx_kthread+0x10/0x10
> [ 1171.962095]=C2=A0 ret_from_fork+0x29/0x50
> [ 1171.962105]=C2=A0 </TASK>
> [ 1171.962108] ---[ end trace 0000000000000000 ]---
> [ 1171.962116] ------------[ cut here ]------------
> [ 1171.962121] WARNING: CPU: 4 PID: 81 at kernel/workqueue.c:1499
> __queue_work+0x33b/0x3d0
> [ 1171.962129] Modules linked in: netconsole(E) af_packet(E)
> hid_logitech_hidpp(E) joydev(E) usblp(E) hid_logitech_dj(E)
> ip6table_mangle(E) ip6table_raw(E) iptable_raw(E) bridge(E) stp(E)
> llc(E) iscsi_ibft(E) iscsi_boot_sysfs(E) rfkill(E) nfnetlink(E)
> ebtable_filter(E) ebtables(E) ip6table_filter(E) ip6_tables(E)
> iptable_filter(E) bpfilter(E) intel_rapl_msr(E) intel_rapl_common(E)
> x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_realtek(E)
> snd_hda_codec_generic(E) ledtrig_audio(E) coretemp(E)
> snd_hda_codec_hdmi(E) iTCO_wdt(E) snd_hda_intel(E) at24(E)
> nls_iso8859_1(E) kvm_intel(E) intel_pmc_bxt(E) snd_intel_dspcfg(E)
> regmap_i2c(E) mei_hdcp(E) nls_cp437(E) iTCO_vendor_support(E)
> snd_hda_codec(E) snd_hwdep(E) kvm(E) snd_hda_core(E) irqbypass(E)
> r8169(E) pcspkr(E) snd_pcm(E) realtek(E) i2c_i801(E) mei_me(E)
> snd_timer(E) mdio_devres(E) snd(E) lpc_ich(E) i2c_smbus(E) libphy(E)
> soundcore(E) mfd_core(E) mei(E) fan(E) thermal(E)
> intel_smartconnect(E) nfsd(E) auth_rpcgss(E) nfs_acl(E)
> [ 1171.962185]=C2=A0 lockd(E) sch_fq_codel(E) grace(E) fuse(E) sunrpc(E)
> configfs(E) ip_tables(E) x_tables(E) uas(E) usb_storage(E)
> hid_generic(E) usbhid(E) nouveau(E) drm_ttm_helper(E) ttm(E)
> i2c_algo_bit(E) drm_display_helper(E) crct10dif_pclmul(E)
> crc32_pclmul(E) ghash_clmulni_intel(E) drm_kms_helper(E)
> sha512_ssse3(E) ahci(E) sha512_generic(E) xhci_pci(E) syscopyarea(E)
> aesni_intel(E) sysfillrect(E) libahci(E) ehci_pci(E) sysimgblt(E)
> crypto_simd(E) xhci_hcd(E) ehci_hcd(E) cryptd(E) drm(E) libata(E)
> cec(E) usbcore(E) usb_common(E) rc_core(E) video(E) wmi(E) button(E)
> sd_mod(E) t10_pi(E) crc64_rocksoft_generic(E) crc64_rocksoft(E)
> crc64(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) virtio(E)
> virtio_ring(E) ext4(E) crc32c_intel(E) crc16(E) mbcache(E) jbd2(E)
> loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E)
> scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E)
> efivarfs(E) autofs4(E)
> [ 1171.962274] CPU: 4 PID: 81 Comm: kswapd0 Kdump: loaded Tainted:
> G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0 E=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 6.1.0.g6feb57c-master #41
> [ 1171.962280] Hardware name: MEDION MS-7848/MS-7848, BIOS
> M7848W08.20C 09/23/2013
> [ 1171.962285] RIP: 0010:__queue_work+0x33b/0x3d0
> [ 1171.962290] Code: 25 40 d3 02 00 f6 47 2c 20 74 18 e8 6f 6f 00 00
> 48 85 c0 74 0e 48 8b 40 20 48 3b 68 08 0f 84 f5 fc ff ff 0f 0b e9 fe
> fd ff ff <0f> 0b e9 ee fd ff ff 83 c9 02 49 8d 57 68 e9 d7 fd ff ff
> 80 3d f3
> [ 1171.962296] RSP: 0018:ffff8881010a7c38 EFLAGS: 00010003
> [ 1171.962302] RAX: ffff8881313dab50 RBX: ffffffff81fcc880 RCX:
> 0000000000000000
> [ 1171.962306] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> ffff888100078000
> [ 1171.962310] RBP: ffff88810a0bae00 R08: ffff888100400028 R09:
> ffff888100400000
> [ 1171.962314] R10: 0000000000000000 R11: ffffffff8225d5c8 R12:
> 0000000000000008
> [ 1171.962319] R13: 0000000000000004 R14: ffff8881313dab48 R15:
> ffff888120a5e000
> [ 1171.962323] FS:=C2=A0 0000000000000000(0000) GS:ffff88840ed00000(0000=
)
> knlGS:0000000000000000
> [ 1171.962328] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1171.962333] CR2: 00007f39558dc000 CR3: 00000001b893a002 CR4:
> 00000000001706e0
> [ 1171.962337] Call Trace:
> [ 1171.962341]=C2=A0 <TASK>
> [ 1171.962345]=C2=A0 mod_delayed_work_on+0x49/0x70
> [ 1171.962351]=C2=A0 nfsd4_state_shrinker_count+0x24/0x50 [nfsd]
> [ 1171.962399]=C2=A0 shrink_slab.constprop.94+0x9d/0x370
> [ 1171.962406]=C2=A0 shrink_node+0x1c5/0x420
> [ 1171.962413]=C2=A0 balance_pgdat+0x25f/0x530
> [ 1171.962420]=C2=A0 ? __pfx_autoremove_wake_function+0x10/0x10
> [ 1171.962427]=C2=A0 kswapd+0x12c/0x360
> [ 1171.962433]=C2=A0 ? __pfx_autoremove_wake_function+0x10/0x10
> [ 1171.962438]=C2=A0 ? __pfx_kswapd+0x10/0x10
> [ 1171.962445]=C2=A0 kthread+0xc0/0xe0
> [ 1171.962450]=C2=A0 ? __pfx_kthread+0x10/0x10
> [ 1171.962454]=C2=A0 ret_from_fork+0x29/0x50
> [ 1171.962461]=C2=A0 </TASK>
> [ 1171.962465] ---[ end trace 0000000000000000 ]---
> [ 1171.962471] ------------[ cut here ]------------
> [ 1171.962474] WARNING: CPU: 4 PID: 81 at kernel/workqueue.c:1499
> __queue_work+0x33b/0x3d0
> [ 1171.962483] Modules linked in: netconsole(E) af_packet(E)
> hid_logitech_hidpp(E) joydev(E) usblp(E) hid_logitech_dj(E)
> ip6table_mangle(E) ip6table_raw(E) iptable_raw(E) bridge(E) stp(E)
> llc(E) iscsi_ibft(E) iscsi_boot_sysfs(E) rfkill(E) nfnetlink(E)
> ebtable_filter(E) ebtables(E) ip6table_filter(E) ip6_tables(E)
> iptable_filter(E) bpfilter(E) intel_rapl_msr(E) intel_rapl_common(E)
> x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_realtek(E)
> snd_hda_codec_generic(E) ledtrig_audio(E) coretemp(E)
> snd_hda_codec_hdmi(E) iTCO_wdt(E) snd_hda_intel(E) at24(E)
> nls_iso8859_1(E) kvm_intel(E) intel_pmc_bxt(E) snd_intel_dspcfg(E)
> regmap_i2c(E) mei_hdcp(E) nls_cp437(E) iTCO_vendor_support(E)
> snd_hda_codec(E) snd_hwdep(E) kvm(E) snd_hda_core(E) irqbypass(E)
> r8169(E) pcspkr(E) snd_pcm(E) realtek(E) i2c_i801(E) mei_me(E)
> snd_timer(E) mdio_devres(E) snd(E) lpc_ich(E) i2c_smbus(E) libphy(E)
> soundcore(E) mfd_core(E) mei(E) fan(E) thermal(E)
> intel_smartconnect(E) nfsd(E) auth_rpcgss(E) nfs_acl(E)
> [ 1171.962539]=C2=A0 lockd(E) sch_fq_codel(E) grace(E) fuse(E) sunrpc(E)
> configfs(E) ip_tables(E) x_tables(E) uas(E) usb_storage(E)
> hid_generic(E) usbhid(E) nouveau(E) drm_ttm_helper(E) ttm(E)
> i2c_algo_bit(E) drm_display_helper(E) crct10dif_pclmul(E)
> crc32_pclmul(E) ghash_clmulni_intel(E) drm_kms_helper(E)
> sha512_ssse3(E) ahci(E) sha512_generic(E) xhci_pci(E) syscopyarea(E)
> aesni_intel(E) sysfillrect(E) libahci(E) ehci_pci(E) sysimgblt(E)
> crypto_simd(E) xhci_hcd(E) ehci_hcd(E) cryptd(E) drm(E) libata(E)
> cec(E) usbcore(E) usb_common(E) rc_core(E) video(E) wmi(E) button(E)
> sd_mod(E) t10_pi(E) crc64_rocksoft_generic(E) crc64_rocksoft(E)
> crc64(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) virtio(E)
> virtio_ring(E) ext4(E) crc32c_intel(E) crc16(E) mbcache(E) jbd2(E)
> loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E)
> scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E)
> efivarfs(E) autofs4(E)
> [ 1171.962628] CPU: 4 PID: 81 Comm: kswapd0 Kdump: loaded Tainted:
> G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0 E=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 6.1.0.g6feb57c-master #41
> [ 1171.962634] Hardware name: MEDION MS-7848/MS-7848, BIOS
> M7848W08.20C 09/23/2013
> [ 1171.962638] RIP: 0010:__queue_work+0x33b/0x3d0
> [ 1171.962644] Code: 25 40 d3 02 00 f6 47 2c 20 74 18 e8 6f 6f 00 00
> 48 85 c0 74 0e 48 8b 40 20 48 3b 68 08 0f 84 f5 fc ff ff 0f 0b e9 fe
> fd ff ff <0f> 0b e9 ee fd ff ff 83 c9 02 49 8d 57 68 e9 d7 fd ff ff
> 80 3d f3
> [ 1171.962650] RSP: 0018:ffff8881010a7c38 EFLAGS: 00010003
> [ 1171.962655] RAX: ffff888199989f50 RBX: ffffffff81fcc880 RCX:
> 0000000000000000
> [ 1171.962660] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> ffff888100078000
> [ 1171.962665] RBP: ffff88810a0bae00 R08: ffff888100400028 R09:
> ffff888100400000
> [ 1171.962670] R10: 0000000000000000 R11: ffffffff8225d5c8 R12:
> 0000000000000008
> [ 1171.962674] R13: 0000000000000004 R14: ffff888199989f48 R15:
> ffff888120a5e000
> [ 1171.962681] FS:=C2=A0 0000000000000000(0000) GS:ffff88840ed00000(0000=
)
> knlGS:0000000000000000
> [ 1171.962686] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1171.962690] CR2: 00007f39558dc000 CR3: 00000001b893a002 CR4:
> 00000000001706e0
> [ 1171.962695] Call Trace:
> [ 1171.962699]=C2=A0 <TASK>
> [ 1171.962704]=C2=A0 mod_delayed_work_on+0x49/0x70
> [ 1171.962712]=C2=A0 nfsd4_state_shrinker_count+0x24/0x50 [nfsd]
> [ 1171.962760]=C2=A0 shrink_slab.constprop.94+0x9d/0x370
> [ 1171.962767]=C2=A0 shrink_node+0x1c5/0x420
> [ 1171.962772]=C2=A0 balance_pgdat+0x25f/0x530
> [ 1171.962780]=C2=A0 ? __pfx_autoremove_wake_function+0x10/0x10
> [ 1171.962786]=C2=A0 kswapd+0x12c/0x360
> [ 1171.962791]=C2=A0 ? __pfx_autoremove_wake_function+0x10/0x10
> [ 1171.962797]=C2=A0 ? __pfx_kswapd+0x10/0x10
> [ 1171.962802]=C2=A0 kthread+0xc0/0xe0
> [ 1171.962807]=C2=A0 ? __pfx_kthread+0x10/0x10
> [ 1171.962812]=C2=A0 ret_from_fork+0x29/0x50
> [ 1171.962819]=C2=A0 </TASK>
> [ 1171.962823] ---[ end trace 0000000000000000 ]---
> [ 1171.962830] ------------[ cut here ]------------
> [ 1171.962833] WARNING: CPU: 4 PID: 81 at kernel/workqueue.c:1499
> __queue_work+0x33b/0x3d0
> [ 1171.962841] Modules linked in: netconsole(E) af_packet(E)
> hid_logitech_hidpp(E) joydev(E) usblp(E) hid_logitech_dj(E)
> ip6table_mangle(E) ip6table_raw(E) iptable_raw(E) bridge(E) stp(E)
> llc(E) iscsi_ibft(E) iscsi_boot_sysfs(E) rfkill(E) nfnetlink(E)
> ebtable_filter(E) ebtables(E) ip6table_filter(E) ip6_tables(E)
> iptable_filter(E) bpfilter(E) intel_rapl_msr(E) intel_rapl_common(E)
> x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_realtek(E)
> snd_hda_codec_generic(E) ledtrig_audio(E) coretemp(E)
> snd_hda_codec_hdmi(E) iTCO_wdt(E) snd_hda_intel(E) at24(E)
> nls_iso8859_1(E) kvm_intel(E) intel_pmc_bxt(E) snd_intel_dspcfg(E)
> regmap_i2c(E) mei_hdcp(E) nls_cp437(E) iTCO_vendor_support(E)
> snd_hda_codec(E) snd_hwdep(E) kvm(E) snd_hda_core(E) irqbypass(E)
> r8169(E) pcspkr(E) snd_pcm(E) realtek(E) i2c_i801(E) mei_me(E)
> snd_timer(E) mdio_devres(E) snd(E) lpc_ich(E) i2c_smbus(E) libphy(E)
> soundcore(E) mfd_core(E) mei(E) fan(E) thermal(E)
> intel_smartconnect(E) nfsd(E) auth_rpcgss(E) nfs_acl(E)
> [ 1171.962895]=C2=A0 lockd(E) sch_fq_codel(E) grace(E) fuse(E) sunrpc(E)
> configfs(E) ip_tables(E) x_tables(E) uas(E) usb_storage(E)
> hid_generic(E) usbhid(E) nouveau(E) drm_ttm_helper(E) ttm(E)
> i2c_algo_bit(E) drm_display_helper(E) crct10dif_pclmul(E)
> crc32_pclmul(E) ghash_clmulni_intel(E) drm_kms_helper(E)
> sha512_ssse3(E) ahci(E) sha512_generic(E) xhci_pci(E) syscopyarea(E)
> aesni_intel(E) sysfillrect(E) libahci(E) ehci_pci(E) sysimgblt(E)
> crypto_simd(E) xhci_hcd(E) ehci_hcd(E) cryptd(E) drm(E) libata(E)
> cec(E) usbcore(E) usb_common(E) rc_core(E) video(E) wmi(E) button(E)
> sd_mod(E) t10_pi(E) crc64_rocksoft_generic(E) crc64_rocksoft(E)
> crc64(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) virtio(E)
> virtio_ring(E) ext4(E) crc32c_intel(E) crc16(E) mbcache(E) jbd2(E)
> loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E)
> scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E)
> efivarfs(E) autofs4(E)
> [ 1171.962984] CPU: 4 PID: 81 Comm: kswapd0 Kdump: loaded Tainted:
> G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0 E=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 6.1.0.g6feb57c-master #41
> [ 1171.962990] Hardware name: MEDION MS-7848/MS-7848, BIOS
> M7848W08.20C 09/23/2013
> [ 1171.962995] RIP: 0010:__queue_work+0x33b/0x3d0
> [ 1171.963001] Code: 25 40 d3 02 00 f6 47 2c 20 74 18 e8 6f 6f 00 00
> 48 85 c0 74 0e 48 8b 40 20 48 3b 68 08 0f 84 f5 fc ff ff 0f 0b e9 fe
> fd ff ff <0f> 0b e9 ee fd ff ff 83 c9 02 49 8d 57 68 e9 d7 fd ff ff
> 80 3d f3
> [ 1171.963009] RSP: 0018:ffff8881010a7c38 EFLAGS: 00010003
> [ 1171.963014] RAX: ffff88814ae67350 RBX: ffffffff81fcc880 RCX:
> 0000000000000000
> [ 1171.963019] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> ffff888100078000
> [ 1171.963024] RBP: ffff88810a0bae00 R08: ffff888100400028 R09:
> ffff888100400000
> [ 1171.963029] R10: 0000000000000000 R11: ffffffff8225d5c8 R12:
> 0000000000000008
> [ 1171.963034] R13: 0000000000000004 R14: ffff88814ae67348 R15:
> ffff888120a5e000
> [ 1171.963039] FS:=C2=A0 0000000000000000(0000) GS:ffff88840ed00000(0000=
)
> knlGS:0000000000000000
> [ 1171.963045] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1171.963050] CR2: 00007f39558dc000 CR3: 00000001b893a002 CR4:
> 00000000001706e0
> [ 1171.963054] Call Trace:
> [ 1171.963058]=C2=A0 <TASK>
> [ 1171.963062]=C2=A0 mod_delayed_work_on+0x49/0x70
> [ 1171.963070]=C2=A0 nfsd4_state_shrinker_count+0x24/0x50 [nfsd]
> [ 1171.963117]=C2=A0 shrink_slab.constprop.94+0x9d/0x370
> [ 1171.963124]=C2=A0 shrink_node+0x1c5/0x420
> [ 1171.963130]=C2=A0 balance_pgdat+0x25f/0x530
> [ 1171.963136]=C2=A0 ? __pfx_autoremove_wake_function+0x10/0x10
> [ 1171.963142]=C2=A0 kswapd+0x12c/0x360
> [ 1171.963148]=C2=A0 ? __pfx_autoremove_wake_function+0x10/0x10
> [ 1171.963153]=C2=A0 ? __pfx_kswapd+0x10/0x10
> [ 1171.963160]=C2=A0 kthread+0xc0/0xe0
> [ 1171.963165]=C2=A0 ? __pfx_kthread+0x10/0x10
> [ 1171.963170]=C2=A0 ret_from_fork+0x29/0x50
> [ 1171.963176]=C2=A0 </TASK>
> [ 1171.963180] ---[ end trace 0000000000000000 ]---
> [ 1171.963188] ------------[ cut here ]------------
> [ 1171.963192] WARNING: CPU: 4 PID: 81 at kernel/workqueue.c:1499
> __queue_work+0x33b/0x3d0
> [ 1171.963200] Modules linked in: netconsole(E) af_packet(E)
> hid_logitech_hidpp(E) joydev(E) usblp(E) hid_logitech_dj(E)
> ip6table_mangle(E) ip6table_raw(E) iptable_raw(E) bridge(E) stp(E)
> llc(E) iscsi_ibft(E) iscsi_boot_sysfs(E) rfkill(E) nfnetlink(E)
> ebtable_filter(E) ebtables(E) ip6table_filter(E) ip6_tables(E)
> iptable_filter(E) bpfilter(E) intel_rapl_msr(E) intel_rapl_common(E)
> x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_realtek(E)
> snd_hda_codec_generic(E) ledtrig_audio(E) coretemp(E)
> snd_hda_codec_hdmi(E) iTCO_wdt(E) snd_hda_intel(E) at24(E)
> nls_iso8859_1(E) kvm_intel(E) intel_pmc_bxt(E) snd_intel_dspcfg(E)
> regmap_i2c(E) mei_hdcp(E) nls_cp437(E) iTCO_vendor_support(E)
> snd_hda_codec(E) snd_hwdep(E) kvm(E) snd_hda_core(E) irqbypass(E)
> r8169(E) pcspkr(E) snd_pcm(E) realtek(E) i2c_i801(E) mei_me(E)
> snd_timer(E) mdio_devres(E) snd(E) lpc_ich(E) i2c_smbus(E) libphy(E)
> soundcore(E) mfd_core(E) mei(E) fan(E) thermal(E)
> intel_smartconnect(E) nfsd(E) auth_rpcgss(E) nfs_acl(E)
> [ 1171.963255]=C2=A0 lockd(E) sch_fq_codel(E) grace(E) fuse(E) sunrpc(E)
> configfs(E) ip_tables(E) x_tables(E) uas(E) usb_storage(E)
> hid_generic(E) usbhid(E) nouveau(E) drm_ttm_helper(E) ttm(E)
> i2c_algo_bit(E) drm_display_helper(E) crct10dif_pclmul(E)
> crc32_pclmul(E) ghash_clmulni_intel(E) drm_kms_helper(E)
> sha512_ssse3(E) ahci(E) sha512_generic(E) xhci_pci(E) syscopyarea(E)
> aesni_intel(E) sysfillrect(E) libahci(E) ehci_pci(E) sysimgblt(E)
> crypto_simd(E) xhci_hcd(E) ehci_hcd(E) cryptd(E) drm(E) libata(E)
> cec(E) usbcore(E) usb_common(E) rc_core(E) video(E) wmi(E) button(E)
> sd_mod(E) t10_pi(E) crc64_rocksoft_generic(E) crc64_rocksoft(E)
> crc64(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) virtio(E)
> virtio_ring(E) ext4(E) crc32c_intel(E) crc16(E) mbcache(E) jbd2(E)
> loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E)
> scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E)
> efivarfs(E) autofs4(E)
> [ 1171.963342] CPU: 4 PID: 81 Comm: kswapd0 Kdump: loaded Tainted:
> G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0 E=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 6.1.0.g6feb57c-master #41
> [ 1171.963348] Hardware name: MEDION MS-7848/MS-7848, BIOS
> M7848W08.20C 09/23/2013
> [ 1171.963352] RIP: 0010:__queue_work+0x33b/0x3d0
> [ 1171.963358] Code: 25 40 d3 02 00 f6 47 2c 20 74 18 e8 6f 6f 00 00
> 48 85 c0 74 0e 48 8b 40 20 48 3b 68 08 0f 84 f5 fc ff ff 0f 0b e9 fe
> fd ff ff <0f> 0b e9 ee fd ff ff 83 c9 02 49 8d 57 68 e9 d7 fd ff ff
> 80 3d f3
> [ 1171.963364] RSP: 0018:ffff8881010a7c38 EFLAGS: 00010003
> [ 1171.963370] RAX: ffff888191ea9f50 RBX: ffffffff81fcc880 RCX:
> 0000000000000000
> [ 1171.963374] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> ffff888100078000
> [ 1171.963379] RBP: ffff88810a0bae00 R08: ffff888100400028 R09:
> ffff888100400000
> [ 1171.963384] R10: 0000000000000000 R11: ffffffff8225d5c8 R12:
> 0000000000000008
> [ 1171.963389] R13: 0000000000000004 R14: ffff888191ea9f48 R15:
> ffff888120a5e000
> [ 1171.963394] FS:=C2=A0 0000000000000000(0000) GS:ffff88840ed00000(0000=
)
> knlGS:0000000000000000
> [ 1171.963399] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1171.963404] CR2: 00007f39558dc000 CR3: 00000001b893a002 CR4:
> 00000000001706e0
> [ 1171.963408] Call Trace:
> [ 1171.963412]=C2=A0 <TASK>
> [ 1171.963416]=C2=A0 mod_delayed_work_on+0x49/0x70
> [ 1171.963423]=C2=A0 nfsd4_state_shrinker_count+0x24/0x50 [nfsd]
> [ 1171.963471]=C2=A0 shrink_slab.constprop.94+0x9d/0x370
> [ 1171.963478]=C2=A0 shrink_node+0x1c5/0x420
> [ 1171.963484]=C2=A0 balance_pgdat+0x25f/0x530
> [ 1171.963491]=C2=A0 ? __pfx_autoremove_wake_function+0x10/0x10
> [ 1171.963498]=C2=A0 kswapd+0x12c/0x360
> [ 1171.963504]=C2=A0 ? __pfx_autoremove_wake_function+0x10/0x10
> [ 1171.963509]=C2=A0 ? __pfx_kswapd+0x10/0x10
> [ 1171.963515]=C2=A0 kthread+0xc0/0xe0
> [ 1171.963520]=C2=A0 ? __pfx_kthread+0x10/0x10
> [ 1171.963524]=C2=A0 ret_from_fork+0x29/0x50
> [ 1171.963531]=C2=A0 </TASK>
> [ 1171.963535] ---[ end trace 0000000000000000 ]---
> [ 1171.963542] ------------[ cut here ]------------
> [ 1171.963546] WARNING: CPU: 4 PID: 81 at kernel/workqueue.c:1499
> __queue_work+0x33b/0x3d0
> [ 1171.963554] Modules linked in: netconsole(E) af_packet(E)
> hid_logitech_hidpp(E) joydev(E) usblp(E) hid_logitech_dj(E)
> ip6table_mangle(E) ip6table_raw(E) iptable_raw(E) bridge(E) stp(E)
> llc(E) iscsi_ibft(E) iscsi_boot_sysfs(E) rfkill(E) nfnetlink(E)
> ebtable_filter(E) ebtables(E) ip6table_filter(E) ip6_tables(E)
> iptable_filter(E) bpfilter(E) intel_rapl_msr(E) intel_rapl_common(E)
> x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_realtek(E)
> snd_hda_codec_generic(E) ledtrig_audio(E) coretemp(E)
> snd_hda_codec_hdmi(E) iTCO_wdt(E) snd_hda_intel(E) at24(E)
> nls_iso8859_1(E) kvm_intel(E) intel_pmc_bxt(E) snd_intel_dspcfg(E)
> regmap_i2c(E) mei_hdcp(E) nls_cp437(E) iTCO_vendor_support(E)
> snd_hda_codec(E) snd_hwdep(E) kvm(E) snd_hda_core(E) irqbypass(E)
> r8169(E) pcspkr(E) snd_pcm(E) realtek(E) i2c_i801(E) mei_me(E)
> snd_timer(E) mdio_devres(E) snd(E) lpc_ich(E) i2c_smbus(E) libphy(E)
> soundcore(E) mfd_core(E) mei(E) fan(E) thermal(E)
> intel_smartconnect(E) nfsd(E) auth_rpcgss(E) nfs_acl(E)
> [ 1171.963609]=C2=A0 lockd(E) sch_fq_codel(E) grace(E) fuse(E) sunrpc(E)
> configfs(E) ip_tables(E) x_tables(E) uas(E) usb_storage(E)
> hid_generic(E) usbhid(E) nouveau(E) drm_ttm_helper(E) ttm(E)
> i2c_algo_bit(E) drm_display_helper(E) crct10dif_pclmul(E)
> crc32_pclmul(E) ghash_clmulni_intel(E) drm_kms_helper(E)
> sha512_ssse3(E) ahci(E) sha512_generic(E) xhci_pci(E) syscopyarea(E)
> aesni_intel(E) sysfillrect(E) libahci(E) ehci_pci(E) sysimgblt(E)
> crypto_simd(E) xhci_hcd(E) ehci_hcd(E) cryptd(E) drm(E) libata(E)
> cec(E) usbcore(E) usb_common(E) rc_core(E) video(E) wmi(E) button(E)
> sd_mod(E) t10_pi(E) crc64_rocksoft_generic(E) crc64_rocksoft(E)
> crc64(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) virtio(E)
> virtio_ring(E) ext4(E) crc32c_intel(E) crc16(E) mbcache(E) jbd2(E)
> loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E)
> scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E)
> efivarfs(E) autofs4(E)
> [ 1171.963697] CPU: 4 PID: 81 Comm: kswapd0 Kdump: loaded Tainted:
> G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0 E=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 6.1.0.g6feb57c-master #41
> [ 1171.963703] Hardware name: MEDION MS-7848/MS-7848, BIOS
> M7848W08.20C 09/23/2013
> [ 1171.963709] RIP: 0010:__queue_work+0x33b/0x3d0
> [ 1171.963715] Code: 25 40 d3 02 00 f6 47 2c 20 74 18 e8 6f 6f 00 00
> 48 85 c0 74 0e 48 8b 40 20 48 3b 68 08 0f 84 f5 fc ff ff 0f 0b e9 fe
> fd ff ff <0f> 0b e9 ee fd ff ff 83 c9 02 49 8d 57 68 e9 d7 fd ff ff
> 80 3d f3
> [ 1171.963721] RSP: 0018:ffff8881010a7c38 EFLAGS: 00010003
> [ 1171.963726] RAX: ffff8881a6e87b50 RBX: ffffffff81fcc880 RCX:
> 0000000000000000
> [ 1171.963730] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> ffff888100078000
> [ 1171.963735] RBP: ffff88810a0bae00 R08: ffff888100400028 R09:
> ffff888100400000
> [ 1171.963740] R10: 0000000000000000 R11: ffffffff8225d5c8 R12:
> 0000000000000008
> [ 1171.963744] R13: 0000000000000004 R14: ffff8881a6e87b48 R15:
> ffff888120a5e000
> [ 1171.963748] FS:=C2=A0 0000000000000000(0000) GS:ffff88840ed00000(0000=
)
> knlGS:0000000000000000
> [ 1171.963753] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1171.963757] CR2: 00007f39558dc000 CR3: 00000001b893a002 CR4:
> 00000000001706e0
> [ 1171.963762] Call Trace:
> [ 1171.963765]=C2=A0 <TASK>
> [ 1171.963768]=C2=A0 mod_delayed_work_on+0x49/0x70
> [ 1171.963775]=C2=A0 nfsd4_state_shrinker_count+0x24/0x50 [nfsd]
> [ 1171.963819]=C2=A0 shrink_slab.constprop.94+0x9d/0x370
> [ 1171.963826]=C2=A0 shrink_node+0x1c5/0x420
> [ 1171.963831]=C2=A0 balance_pgdat+0x25f/0x530
> [ 1171.963837]=C2=A0 ? __pfx_autoremove_wake_function+0x10/0x10
> [ 1171.963844]=C2=A0 kswapd+0x12c/0x360
> [ 1171.963850]=C2=A0 ? __pfx_autoremove_wake_function+0x10/0x10
> [ 1171.963855]=C2=A0 ? __pfx_kswapd+0x10/0x10
> [ 1171.963860]=C2=A0 kthread+0xc0/0xe0
> [ 1171.963864]=C2=A0 ? __pfx_kthread+0x10/0x10
> [ 1171.963869]=C2=A0 ret_from_fork+0x29/0x50
> [ 1171.963875]=C2=A0 </TASK>
> [ 1171.963878] ---[ end trace 0000000000000000 ]---
> [ 1171.963885] ------------[ cut here ]------------
> [ 1171.963890] WARNING: CPU: 4 PID: 81 at kernel/workqueue.c:1499
> __queue_work+0x33b/0x3d0
> [ 1171.963897] Modules linked in: netconsole(E) af_packet(E)
> hid_logitech_hidpp(E) joydev(E) usblp(E) hid_logitech_dj(E)
> ip6table_mangle(E) ip6table_raw(E) iptable_raw(E) bridge(E) stp(E)
> llc(E) iscsi_ibft(E) iscsi_boot_sysfs(E) rfkill(E) nfnetlink(E)
> ebtable_filter(E) ebtables(E) ip6table_filter(E) ip6_tables(E)
> iptable_filter(E) bpfilter(E) intel_rapl_msr(E) intel_rapl_common(E)
> x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_realtek(E)
> snd_hda_codec_generic(E) ledtrig_audio(E) coretemp(E)
> snd_hda_codec_hdmi(E) iTCO_wdt(E) snd_hda_intel(E) at24(E)
> nls_iso8859_1(E) kvm_intel(E) intel_pmc_bxt(E) snd_intel_dspcfg(E)
> regmap_i2c(E) mei_hdcp(E) nls_cp437(E) iTCO_vendor_support(E)
> snd_hda_codec(E) snd_hwdep(E) kvm(E) snd_hda_core(E) irqbypass(E)
> r8169(E) pcspkr(E) snd_pcm(E) realtek(E) i2c_i801(E) mei_me(E)
> snd_timer(E) mdio_devres(E) snd(E) lpc_ich(E) i2c_smbus(E) libphy(E)
> soundcore(E) mfd_core(E) mei(E) fan(E) thermal(E)
> intel_smartconnect(E) nfsd(E) auth_rpcgss(E) nfs_acl(E)
> [ 1171.963945]=C2=A0 lockd(E) sch_fq_codel(E) grace(E) fuse(E) sunrpc(E)
> configfs(E) ip_tables(E) x_tables(E) uas(E) usb_storage(E)
> hid_generic(E) usbhid(E) nouveau(E) drm_ttm_helper(E) ttm(E)
> i2c_algo_bit(E) drm_display_helper(E) crct10dif_pclmul(E)
> crc32_pclmul(E) ghash_clmulni_intel(E) drm_kms_helper(E)
> sha512_ssse3(E) ahci(E) sha512_generic(E) xhci_pci(E) syscopyarea(E)
> aesni_intel(E) sysfillrect(E) libahci(E) ehci_pci(E) sysimgblt(E)
> crypto_simd(E) xhci_hcd(E) ehci_hcd(E) cryptd(E) drm(E) libata(E)
> cec(E) usbcore(E) usb_common(E) rc_core(E) video(E) wmi(E) button(E)
> sd_mod(E) t10_pi(E) crc64_rocksoft_generic(E) crc64_rocksoft(E)
> crc64(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) virtio(E)
> virtio_ring(E) ext4(E) crc32c_intel(E) crc16(E) mbcache(E) jbd2(E)
> loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E)
> scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E)
> efivarfs(E) autofs4(E)
> [ 1171.964026] CPU: 4 PID: 81 Comm: kswapd0 Kdump: loaded Tainted:
> G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0 E=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 6.1.0.g6feb57c-master #41
> [ 1171.964032] Hardware name: MEDION MS-7848/MS-7848, BIOS
> M7848W08.20C 09/23/2013
> [ 1171.964035] RIP: 0010:__queue_work+0x33b/0x3d0
> [ 1171.964041] Code: 25 40 d3 02 00 f6 47 2c 20 74 18 e8 6f 6f 00 00
> 48 85 c0 74 0e 48 8b 40 20 48 3b 68 08 0f 84 f5 fc ff ff 0f 0b e9 fe
> fd ff ff <0f> 0b e9 ee fd ff ff 83 c9 02 49 8d 57 68 e9 d7 fd ff ff
> 80 3d f3
> [ 1171.964046] RSP: 0018:ffff8881010a7c38 EFLAGS: 00010003
> [ 1171.964051] RAX: ffff888198394b50 RBX: ffffffff81fcc880 RCX:
> 0000000000000000
> [ 1171.964056] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> ffff888100078000
> [ 1171.964062] RBP: ffff88810a0bae00 R08: ffff888100400028 R09:
> ffff888100400000
> [ 1171.964066] R10: 0000000000000000 R11: ffffffff8225d5c8 R12:
> 0000000000000008
> [ 1171.964073] R13: 0000000000000004 R14: ffff888198394b48 R15:
> ffff888120a5e000
> [ 1171.964077] FS:=C2=A0 0000000000000000(0000) GS:ffff88840ed00000(0000=
)
> knlGS:0000000000000000
> [ 1171.964081] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1171.964086] CR2: 00007f39558dc000 CR3: 00000001b893a002 CR4:
> 00000000001706e0
> [ 1171.964090] Call Trace:
> [ 1171.964095]=C2=A0 <TASK>
> [ 1171.964099]=C2=A0 mod_delayed_work_on+0x49/0x70
> [ 1171.964106]=C2=A0 nfsd4_state_shrinker_count+0x24/0x50 [nfsd]
> [ 1171.964154]=C2=A0 shrink_slab.constprop.94+0x9d/0x370
> [ 1171.964160]=C2=A0 shrink_node+0x1c5/0x420
> [ 1171.964166]=C2=A0 balance_pgdat+0x25f/0x530
> [ 1171.964174]=C2=A0 ? __pfx_autoremove_wake_function+0x10/0x10
> [ 1171.964181]=C2=A0 kswapd+0x12c/0x360
> [ 1171.964187]=C2=A0 ? __pfx_autoremove_wake_function+0x10/0x10
> [ 1171.964192]=C2=A0 ? __pfx_kswapd+0x10/0x10
> [ 1171.964198]=C2=A0 kthread+0xc0/0xe0
> [ 1171.964202]=C2=A0 ? __pfx_kthread+0x10/0x10
> [ 1171.964207]=C2=A0 ret_from_fork+0x29/0x50
> [ 1171.964213]=C2=A0 </TASK>
> [ 1171.964217] ---[ end trace 0000000000000000 ]---
> [ 1171.964224] ------------[ cut here ]------------
> [ 1171.964229] WARNING: CPU: 4 PID: 81 at kernel/workqueue.c:1499
> __queue_work+0x33b/0x3d0
> [ 1171.964235] Modules linked in: netconsole(E) af_packet(E)
> hid_logitech_hidpp(E) joydev(E) usblp(E) hid_logitech_dj(E)
> ip6table_mangle(E) ip6table_raw(E) iptable_raw(E) bridge(E) stp(E)
> llc(E) iscsi_ibft(E) iscsi_boot_sysfs(E) rfkill(E) nfnetlink(E)
> ebtable_filter(E) ebtables(E) ip6table_filter(E) ip6_tables(E)
> iptable_filter(E) bpfilter(E) intel_rapl_msr(E) intel_rapl_common(E)
> x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_realtek(E)
> snd_hda_codec_generic(E) ledtrig_audio(E) coretemp(E)
> snd_hda_codec_hdmi(E) iTCO_wdt(E) snd_hda_intel(E) at24(E)
> nls_iso8859_1(E) kvm_intel(E) intel_pmc_bxt(E) snd_intel_dspcfg(E)
> regmap_i2c(E) mei_hdcp(E) nls_cp437(E) iTCO_vendor_support(E)
> snd_hda_codec(E) snd_hwdep(E) kvm(E) snd_hda_core(E) irqbypass(E)
> r8169(E) pcspkr(E) snd_pcm(E) realtek(E) i2c_i801(E) mei_me(E)
> snd_timer(E) mdio_devres(E) snd(E) lpc_ich(E) i2c_smbus(E) libphy(E)
> soundcore(E) mfd_core(E) mei(E) fan(E) thermal(E)
> intel_smartconnect(E) nfsd(E) auth_rpcgss(E) nfs_acl(E)
> [ 1171.964287]=C2=A0 lockd(E) sch_fq_codel(E) grace(E) fuse(E) sunrpc(E)
> configfs(E) ip_tables(E) x_tables(E) uas(E) usb_storage(E)
> hid_generic(E) usbhid(E) nouveau(E) drm_ttm_helper(E) ttm(E)
> i2c_algo_bit(E) drm_display_helper(E) crct10dif_pclmul(E)
> crc32_pclmul(E) ghash_clmulni_intel(E) drm_kms_helper(E)
> sha512_ssse3(E) ahci(E) sha512_generic(E) xhci_pci(E) syscopyarea(E)
> aesni_intel(E) sysfillrect(E) libahci(E) ehci_pci(E) sysimgblt(E)
> crypto_simd(E) xhci_hcd(E) ehci_hcd(E) cryptd(E) drm(E) libata(E)
> cec(E) usbcore(E) usb_common(E) rc_core(E) video(E) wmi(E) button(E)
> sd_mod(E) t10_pi(E) crc64_rocksoft_generic(E) crc64_rocksoft(E)
> crc64(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) virtio(E)
> virtio_ring(E) ext4(E) crc32c_intel(E) crc16(E) mbcache(E) jbd2(E)
> loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E)
> scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E)
> efivarfs(E) autofs4(E)
> [ 1171.964371] CPU: 4 PID: 81 Comm: kswapd0 Kdump: loaded Tainted:
> G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0 E=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 6.1.0.g6feb57c-master #41
> [ 1171.964378] Hardware name: MEDION MS-7848/MS-7848, BIOS
> M7848W08.20C 09/23/2013
> [ 1171.964382] RIP: 0010:__queue_work+0x33b/0x3d0
> [ 1171.964388] Code: 25 40 d3 02 00 f6 47 2c 20 74 18 e8 6f 6f 00 00
> 48 85 c0 74 0e 48 8b 40 20 48 3b 68 08 0f 84 f5 fc ff ff 0f 0b e9 fe
> fd ff ff <0f> 0b e9 ee fd ff ff 83 c9 02 49 8d 57 68 e9 d7 fd ff ff
> 80 3d f3
> [ 1171.964394] RSP: 0018:ffff8881010a7c38 EFLAGS: 00010003
> [ 1171.964399] RAX: ffff88838c101f50 RBX: ffffffff81fcc880 RCX:
> 0000000000000000
> [ 1171.964404] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> ffff888100078000
> [ 1171.964408] RBP: ffff88810a0bae00 R08: ffff888100400028 R09:
> ffff888100400000
> [ 1171.964412] R10: 0000000000000000 R11: ffffffff8225d5c8 R12:
> 0000000000000008
> [ 1171.964416] R13: 0000000000000004 R14: ffff88838c101f48 R15:
> ffff888120a5e000
> [ 1171.964420] FS:=C2=A0 0000000000000000(0000) GS:ffff88840ed00000(0000=
)
> knlGS:0000000000000000
> [ 1171.964425] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1171.964429] CR2: 00007f39558dc000 CR3: 00000001b893a002 CR4:
> 00000000001706e0
> [ 1171.964433] Call Trace:
> [ 1171.964437]=C2=A0 <TASK>
> [ 1171.964442]=C2=A0 mod_delayed_work_on+0x49/0x70
> [ 1171.964450]=C2=A0 nfsd4_state_shrinker_count+0x24/0x50 [nfsd]
> [ 1171.964498]=C2=A0 shrink_slab.constprop.94+0x9d/0x370
> [ 1171.964504]=C2=A0 shrink_node+0x1c5/0x420
> [ 1171.964510]=C2=A0 balance_pgdat+0x25f/0x530
> [ 1171.964518]=C2=A0 ? __pfx_autoremove_wake_function+0x10/0x10
> [ 1171.964524]=C2=A0 kswapd+0x12c/0x360
> [ 1171.964530]=C2=A0 ? __pfx_autoremove_wake_function+0x10/0x10
> [ 1171.964536]=C2=A0 ? __pfx_kswapd+0x10/0x10
> [ 1171.964541]=C2=A0 kthread+0xc0/0xe0
> [ 1171.964545]=C2=A0 ? __pfx_kthread+0x10/0x10
> [ 1171.964551]=C2=A0 ret_from_fork+0x29/0x50
> [ 1171.964559]=C2=A0 </TASK>
> [ 1171.964562] ---[ end trace 0000000000000000 ]---
> [ 1281.909660] rcu: INFO: rcu_sched self-detected stall on CPU
> [ 1281.909674] rcu:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A04-...!: (15000 ticks th=
is GP)
> idle=3D3ee4/1/0x4000000000000000 softirq=3D437305/437305 fqs=3D210
> [ 1281.909680]=C2=A0=C2=A0(t=3D15000 jiffies g=3D566765 q=3D19351 ncpus=
=3D8)
> [ 1281.909684] rcu: rcu_sched kthread starved for 14580 jiffies!
> g566765 f0x0 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D3
> [ 1281.909691] rcu:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Unless rcu_sched kthrea=
d gets sufficient CPU
> time, OOM is now expected behavior.
> [ 1281.909695] rcu: RCU grace-period kthread stack dump:
> [ 1281.909697] task:rcu_sched=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 state:=
R=C2=A0 running task=C2=A0=C2=A0=C2=A0=C2=A0
> stack:0=C2=A0=C2=A0=C2=A0=C2=A0 pid:14=C2=A0=C2=A0=C2=A0 ppid:2=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 flags:0x00004000
> [ 1281.909704] Call Trace:
> [ 1281.909707]=C2=A0 <TASK>
> [ 1281.909710]=C2=A0 __schedule+0x2ba/0x8e0
> [ 1281.909720]=C2=A0 schedule+0x55/0xb0
> [ 1281.909723]=C2=A0 schedule_timeout+0x18d/0x280
> [ 1281.909729]=C2=A0 ? __pfx_process_timeout+0x10/0x10
> [ 1281.909733]=C2=A0 rcu_gp_fqs_loop+0x328/0x3b0
> [ 1281.909738]=C2=A0 ? __pfx_rcu_gp_kthread+0x10/0x10
> [ 1281.909742]=C2=A0 rcu_gp_kthread+0xb6/0x170
> [ 1281.909747]=C2=A0 kthread+0xc0/0xe0
> [ 1281.909752]=C2=A0 ? __pfx_kthread+0x10/0x10
> [ 1281.909756]=C2=A0 ret_from_fork+0x29/0x50
> [ 1281.909762]=C2=A0 </TASK>
> [ 1281.909764] rcu: Stack dump where RCU GP kthread last ran:
> [ 1281.909767] Sending NMI from CPU 4 to CPUs 3:
> [ 1281.909772] NMI backtrace for cpu 3
> [ 1281.909774] CPU: 3 PID: 9 Comm: kworker/u16:0 Kdump: loaded
> Tainted: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0 E=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.1.0.g6feb57c-master #41
> [ 1281.909776] Hardware name: MEDION MS-7848/MS-7848, BIOS
> M7848W08.20C 09/23/2013
> [ 1281.909777] Workqueue: writeback wb_workfn (flush-8:48)
> [ 1281.909781] RIP: 0010:native_queued_spin_lock_slowpath+0x47/0x290
> [ 1281.909784] Code: c0 75 f2 5b 5d 41 5c 41 5d c3 cc cc cc cc f3 90
> eb e3 81 fe 00 01 00 00 0f 84 da 00 00 00 40 30 f6 85 f6 75 4f f0 0f
> ba 2f 08 <0f> 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00
> 01 ff ff
> [ 1281.909785] RSP: 0018:ffff8881008a7418 EFLAGS: 00000046
> [ 1281.909786] RAX: 0000000000000001 RBX: ffff88818016b748 RCX:
> 0000000000000000
> [ 1281.909787] RDX: 0000000000000001 RSI: 0000000000000000 RDI:
> ffff88840ec2d4c0
> [ 1281.909787] RBP: ffff8881008a7470 R08: ffff888100400028 R09:
> ffff888100400000
> [ 1281.909788] R10: 0000000000000000 R11: ffffffff8225d5c8 R12:
> ffff88840ec2d4c0
> [ 1281.909788] R13: ffff88810a0bae00 R14: 0000000000000000 R15:
> ffff88818016b710
> [ 1281.909789] FS:=C2=A0 0000000000000000(0000) GS:ffff88840ecc0000(0000=
)
> knlGS:0000000000000000
> [ 1281.909790] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1281.909791] CR2: 0000559bf0ef4034 CR3: 0000000004210003 CR4:
> 00000000001706e0
> [ 1281.909792] Call Trace:
> [ 1281.909792]=C2=A0 <TASK>
> [ 1281.909793]=C2=A0 _raw_spin_lock+0x1e/0x30
> [ 1281.909795]=C2=A0 try_to_grab_pending+0x49/0x120
> [ 1281.909798]=C2=A0 mod_delayed_work_on+0x2d/0x70
> [ 1281.909802]=C2=A0 nfsd4_state_shrinker_count+0x24/0x50 [nfsd]
> [ 1281.909842]=C2=A0 shrink_slab.constprop.94+0x9d/0x370
> [ 1281.909845]=C2=A0 shrink_node+0x1c5/0x420
> [ 1281.909847]=C2=A0 try_to_free_pages+0x17b/0x560
> [ 1281.909850]=C2=A0 __alloc_pages_slowpath.constprop.125+0x35d/0xc70
> [ 1281.909853]=C2=A0 __alloc_pages+0x2b3/0x2e0
> [ 1281.909855]=C2=A0 new_slab+0x276/0x360
> [ 1281.909856]=C2=A0 ___slab_alloc+0x217/0x710
> [ 1281.909858]=C2=A0 ? mempool_alloc+0x54/0x160
> [ 1281.909860]=C2=A0 ? ext4_mark_iloc_dirty+0x177/0x600 [ext4]
> [ 1281.909897]=C2=A0 ? mempool_alloc+0x54/0x160
> [ 1281.909898]=C2=A0 kmem_cache_alloc+0x1b6/0x1d0
> [ 1281.909899]=C2=A0 ? __pfx_autoremove_wake_function+0x10/0x10
> [ 1281.909901]=C2=A0 mempool_alloc+0x54/0x160
> [ 1281.909903]=C2=A0 bio_alloc_bioset+0x1d5/0x3a0
> [ 1281.909906]=C2=A0 ? __pfx_ext4_end_bio+0x10/0x10 [ext4]
> [ 1281.909933]=C2=A0 ext4_bio_write_page+0x49f/0x530 [ext4]
> [ 1281.909956]=C2=A0 mpage_submit_page+0x4c/0x70 [ext4]
> [ 1281.909978]=C2=A0 mpage_map_and_submit_buffers+0x141/0x220 [ext4]
> [ 1281.909998]=C2=A0 ? __check_block_validity.constprop.83+0x3e/0x90
> [ext4]
> [ 1281.910016]=C2=A0 ? ext4_map_blocks+0x1fd/0x5a0 [ext4]
> [ 1281.910035]=C2=A0 ? __cond_resched+0x15/0x30
> [ 1281.910037]=C2=A0 ? kmem_cache_alloc+0xe1/0x1d0
> [ 1281.910038]=C2=A0 ext4_do_writepages+0x60d/0xbc0 [ext4]
> [ 1281.910060]=C2=A0 ? sock_wmalloc+0x60/0x60
> [ 1281.910063]=C2=A0 ? update_group_capacity+0x24/0x220
> [ 1281.910065]=C2=A0 ext4_writepages+0x6a/0xd0 [ext4]
> [ 1281.910085]=C2=A0 do_writepages+0xc8/0x1a0
> [ 1281.910087]=C2=A0 __writeback_single_inode+0x39/0x2d0
> [ 1281.910089]=C2=A0 writeback_sb_inodes+0x1c2/0x480
> [ 1281.910090]=C2=A0 __writeback_inodes_wb+0x5f/0xd0
> [ 1281.910091]=C2=A0 wb_writeback+0x1de/0x250
> [ 1281.910093]=C2=A0 wb_workfn+0x18b/0x3f0
> [ 1281.910094]=C2=A0 ? finish_task_switch+0x87/0x2c0
> [ 1281.910096]=C2=A0 process_one_work+0x1f7/0x3c0
> [ 1281.910098]=C2=A0 worker_thread+0x2d/0x3b0
> [ 1281.910100]=C2=A0 ? __pfx_worker_thread+0x10/0x10
> [ 1281.910102]=C2=A0 kthread+0xc0/0xe0
> [ 1281.910103]=C2=A0 ? __pfx_kthread+0x10/0x10
> [ 1281.910104]=C2=A0 ret_from_fork+0x29/0x50
> [ 1281.910106]=C2=A0 </TASK>
> [ 1281.910764] CPU: 4 PID: 81 Comm: kswapd0 Kdump: loaded Tainted:
> G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0 E=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 6.1.0.g6feb57c-master #41
> [ 1281.911452] Hardware name: MEDION MS-7848/MS-7848, BIOS
> M7848W08.20C 09/23/2013
> [ 1281.911455] RIP: 0010:try_to_grab_pending+0x79/0x120
> [ 1281.911459] Code: 04 74 11 48 81 e7 00 ff ff ff 49 89 fd 74 05 4c
> 3b 27 74 59 4c 89 e7 c6 07 00 0f 1f 00 48 8b 45 00 f6 c4 02 74 01 fb
> 48 8b 13 <b8> fe ff ff ff 83 e2 14 48 83 fa 10 74 9f f3 90 b8 f5 ff
> ff ff 5b
> [ 1281.911463] RSP: 0018:ffff8881010a7c58 EFLAGS: 00000202
> [ 1281.911466] RAX: 0000000000000246 RBX: ffff88818016b748 RCX:
> 0000000000100000
> [ 1281.911469] RDX: 0000000000000001 RSI: 0000000000100000 RDI:
> ffff88840ec2d4c0
> [ 1281.911471] RBP: ffff8881010a7c80 R08: ffff888100400028 R09:
> ffff888100400000
> [ 1281.911474] R10: 0000000000000000 R11: ffffffff8225d5c8 R12:
> ffff88840ec2d4c0
> [ 1281.911529] R13: ffff88810a0bae00 R14: 0000000000000000 R15:
> ffff88818016b710
> [ 1281.911532] FS:=C2=A0 0000000000000000(0000) GS:ffff88840ed00000(0000=
)
> knlGS:0000000000000000
> [ 1281.911535] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1281.911538] CR2: 00007fab452688ce CR3: 0000000004210002 CR4:
> 00000000001706e0
> [ 1281.911540] Call Trace:
> [ 1281.911542]=C2=A0 <TASK>
> [ 1281.911545]=C2=A0 mod_delayed_work_on+0x2d/0x70
> [ 1281.911549]=C2=A0 nfsd4_state_shrinker_count+0x24/0x50 [nfsd]
> [ 1281.911581]=C2=A0 shrink_slab.constprop.94+0x9d/0x370
> [ 1281.911585]=C2=A0 shrink_node+0x1c5/0x420
> [ 1281.911590]=C2=A0 balance_pgdat+0x25f/0x530
> [ 1281.911594]=C2=A0 ? __pfx_autoremove_wake_function+0x10/0x10
> [ 1281.911650]=C2=A0 kswapd+0x12c/0x360
> [ 1281.911654]=C2=A0 ? __pfx_autoremove_wake_function+0x10/0x10
> [ 1281.911658]=C2=A0 ? __pfx_kswapd+0x10/0x10
> [ 1281.911661]=C2=A0 kthread+0xc0/0xe0
> [ 1281.911664]=C2=A0 ? __pfx_kthread+0x10/0x10
> [ 1281.911667]=C2=A0 ret_from_fork+0x29/0x50
> [ 1281.911671]=C2=A0 </TASK>
> [ 1371.224288] sysrq: Resetting
>

