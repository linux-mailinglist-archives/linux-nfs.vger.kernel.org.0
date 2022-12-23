Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DF8654C79
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Dec 2022 07:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiLWG2f (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Dec 2022 01:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiLWG2e (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 23 Dec 2022 01:28:34 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC7E165B1;
        Thu, 22 Dec 2022 22:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1671776904; bh=wsRwIKdxqFAPGP9rTAWqWAP6nOxjtlNZCDvXkfBo3Qw=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=otCZ6VoFXZOFtc1dJwg/mIZfZ4xzxL7G06E09zLYCpKcrQaJ3f3ASNd0n6xlQEYIa
         rTtO/UdDmjwq/wlel9FrICT9MKQuora0diAnTGb9iRdvEJpVpInjqQkoa+HWz2fq03
         UoeCwUEQQ4Qg+r5uyOmk37DS6WYBACZr56AWgtWgLWOKfl4wcVBVDPbpRd8qXSaSSx
         taTty2BBfFJe8Nnk+mXNuDswc2apg+uBHqrjWlsQR/ziYZpv9+7VuNnx/6NzhTA+5b
         T2YYq/l36BlbQk7Zdu3kXw6B7HWqLrq9a+T7Tses2xZv6Q8yC7DfjcT68ilS65lvTc
         0EWGd//y4ffRQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([212.114.172.145]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGQjH-1p54uj1aRh-00GuCe; Fri, 23
 Dec 2022 07:28:24 +0100
Message-ID: <cb5508d260288126212453486d6d45e84436b530.camel@gmx.de>
Subject: Re: regression: nfs mount (even idle) eventually hangs server
From:   Mike Galbraith <efault@gmx.de>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Dai Ngo <dai.ngo@oracle.com>, LKML <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Fri, 23 Dec 2022 07:28:23 +0100
In-Reply-To: <a0abf7fef412dc0de0e42cbcd75ee5dec28cb544.camel@gmx.de>
References: <65ed34338c69cb034295f2c9cbe0af684d65d30f.camel@gmx.de>
         <360f3dcfb6cfbefdbcc42fc84c660995142a8645.camel@gmx.de>
         <241c118c2fb60df744bbe351387fc29a34ff6ab9.camel@gmx.de>
         <f533c2e38c0619ea0c3b4346d1c7c99c5ae2122b.camel@gmx.de>
         <1A404CDB-95A8-4D04-B76B-91D4F063B489@oracle.com>
         <36902a3dd6ee1a8656548ff5b5eadb88245e2799.camel@gmx.de>
         <e51b8b218f18abe00ec76eb911d5b5b5af02f79b.camel@gmx.de>
         <AF3DFAF9-CF19-40AE-8B8F-31D100E00F33@oracle.com>
         <a0abf7fef412dc0de0e42cbcd75ee5dec28cb544.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6959bKdsgGpUt70gvXtZanJdNUG6drvnctK8PgWt0gBXn8Frubm
 8sb8TKdOTQ/WjlEUz6GUJJQcSGs5IzNwL6isWicQY1VRixQVpZpvSfXUE6u/Gg1g5rqnwGb
 9ZBivaM1qOcvi4i8WiXoeoT0XWd0lQgQcoA/J/EKmWTLlFyp283vn0ZKdQm0XVgewGz4gxQ
 1NZ4UXB6zhKHIa2Ngy+hQ==
UI-OutboundReport: notjunk:1;M01:P0:N+rVue5dV3Y=;LF/YDDdaZUtQknkNotQruJr85pl
 lNXLVrNuKGLyuvHQ40YgMvSr1EPCT6tkk6Gfskt1OjNSt15Tb7kbTkHsD1txQnjl5lajeN/DV
 TgVvNuWin9cmqMohcsa2Dyfjl+D7c4pRt4Xefr7nyGSErQtaZpRcnGoe/jiT01C+y91sWbRf4
 u7CPKA0+MuZK/yf8CGHoJNLvDMEprLIfbuzht8SOWDUGuWv3liF9bk8Ca/S+CwXdMnrhY1+wD
 FTIVOhIwll6GFGkKZK0HMgggD/kYzQumPWHSUd0ksEDMHI9j14h6VoVWS4myoVpdBzm4uie4j
 463wk1xBN9VUsUrhAYrasw7HzbPf2xEA9+3cmhxGq2c4mKnUldVSLhKUbOtG5UUb54jTZ78J4
 /GgyLxJr4Iyy06rk6rO/YNIFx2CrOYe/AVIFWqzMvM3xy4bKrqJejwfx0dyEUBSoHv+GSsGF6
 duE+DiYzfypxrpzBk5uNa39yAHyUHb4eil5EXfR6KsxtyKCpoKdJbFsLekIsIpOio18j8ZR6E
 VYJApbLWMH/w2wrf96Rgz69t4eUuulbkGWKVQgaI+I8n2MFMzG0uWtU8y+ESWGDxgL47SC+0q
 ic8pV3g8mSY1DKy+RsODUYMr3iejJ67sCqrJTqOkbtpiHQSan0ZqzqeYwjnoPcI/9ru2BVPrd
 R445Ydj7CspIei1KcbhKJ+JM8jv/UBMtHw7EEvag6e3eeFtdAoR0CG/PcIRwk7BamEZGMvCdJ
 zFPEmECagtOK9Z042GDnJrc4npAQZbs/kZ9lbYQmwRKNwXNmTqR4G7RTTf8R+QBhvmLqF8/A5
 4CpFmcmUUDphuzFZsQxDv2llD4JI7ACIpB7dvxPEkEuZWE4qP4ZoxQYA0GeG4i+ikFALDziu6
 Yp85xlKGflfY3ipEUiabxoNuFxOJ2M/P5LW8YUpFd+GQSCBJvYweyQy5EHuG0YUg89K2pOmhU
 D+IntZyzB9TVXMUIkY1VjiYIMKs=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2022-12-23 at 05:41 +0100, Mike Galbraith wrote:
> On Thu, 2022-12-22 at 14:21 +0000, Chuck Lever III wrote:
> >=20
> > So my question is whether you see a problem when only a1049eb47f20
> > is applied, or only when all three are applied?
>=20
> Seemingly the latter.

Stuffing the other two into 6.1 sans a1049eb47f20 seems to agree that
the problem lies therein.

[ 1909.987616] WARNING: CPU: 7 PID: 78 at kernel/workqueue.c:1655 __queue_d=
elayed_work+0x6a/0x90
[ 1909.987627] Modules linked in: netconsole(E) af_packet(E) ip6table_mangl=
e(E) ip6table_raw(E) iptable_raw(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) i=
scsi_boot_sysfs(E) rfkill(E) nfnetlink(E) ebtable_filter(E) ebtables(E) ip6=
table_filter(E) ip6_tables(E) iptable_filter(E) bpfilter(E) usblp(E) joydev=
(E) intel_rapl_msr(E) intel_rapl_common(E) snd_hda_codec_realtek(E) snd_hda=
_codec_generic(E) ledtrig_audio(E) snd_hda_codec_hdmi(E) x86_pkg_temp_therm=
al(E) intel_powerclamp(E) coretemp(E) snd_hda_intel(E) snd_intel_dspcfg(E) =
iTCO_wdt(E) at24(E) intel_pmc_bxt(E) regmap_i2c(E) mei_hdcp(E) iTCO_vendor_=
support(E) kvm_intel(E) snd_hda_codec(E) nls_iso8859_1(E) snd_hwdep(E) nls_=
cp437(E) snd_hda_core(E) kvm(E) snd_pcm(E) r8169(E) irqbypass(E) snd_timer(=
E) i2c_i801(E) realtek(E) pcspkr(E) mei_me(E) mdio_devres(E) i2c_smbus(E) s=
nd(E) lpc_ich(E) mfd_core(E) libphy(E) soundcore(E) mei(E) thermal(E) fan(E=
) intel_smartconnect(E) nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E)=
 sch_fq_codel(E) sunrpc(E[ 1909.987603] ------------[ cut here ]-----------=
-
)
[ 1909.987663]  fuse(E) configfs(E) ip_tables(E) x_tables(E) hid_logitech_h=
idpp(E) hid_logitech_dj(E) uas(E) usb_storage(E) hid_generic(E) usbhid(E) n=
ouveau(E) i2c_algo_bit(E) drm_ttm_helper(E) ttm(E) drm_display_helper(E) cr=
ct10dif_pclmul(E) crc32_pclmul(E) drm_kms_helper(E) ghash_clmulni_intel(E) =
sha512_ssse3(E) syscopyarea(E) sha512_generic(E) sysfillrect(E) xhci_pci(E)=
 sysimgblt(E) ahci(E) ehci_pci(E) aesni_intel(E) fb_sys_fops(E) crypto_simd=
(E) libahci(E) cryptd(E) xhci_hcd(E) ehci_hcd(E) drm(E) libata(E) cec(E) us=
bcore(E) usb_common(E) rc_core(E) video(E) wmi(E) button(E) sd_mod(E) t10_p=
i(E) crc64_rocksoft_generic(E) crc64_rocksoft(E) crc64(E) vfat(E) fat(E) vi=
rtio_blk(E) virtio_mmio(E) virtio(E) virtio_ring(E) ext4(E) crc32c_intel(E)=
 crc16(E) mbcache(E) jbd2(E) loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_d=
h_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E) =
efivarfs(E) autofs4(E)
[ 1909.987715] CPU: 7 PID: 78 Comm: kswapd0 Kdump: loaded Tainted: G       =
     E      6.1.1-smpxx #8
[ 1909.987720] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[ 1909.987723] RIP: 0010:__queue_delayed_work+0x6a/0x90
[ 1909.987729] Code: 50 48 01 c1 83 ff 08 48 89 4a 30 75 2c 4c 89 c7 e9 fb =
e7 06 00 e9 a6 e9 ff ff 0f 0b eb cc 0f 0b 48 81 7a 38 10 4d 09 81 74 aa <0f=
> 0b 48 8b 42 28 48 85 c0 74 a8 0f 0b eb a4 89 fe 4c 89 c7 e9 7d
[ 1909.987734] RSP: 0018:ffff888100ec7c78 EFLAGS: 00010007
[ 1909.987737] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00000
[ 1909.987740] RDX: ffff88810800ab48 RSI: ffff88818118d400 RDI: 00000000000=
00008
[ 1909.987743] RBP: ffff88810800ab48 R08: 0000000000000004 R09: 00000000000=
00000
[ 1909.987745] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00008
[ 1909.987748] R13: ffff88818118d400 R14: 0000000000000000 R15: ffff8881080=
0ab10
[ 1909.987751] FS:  0000000000000000(0000) GS:ffff88840edc0000(0000) knlGS:=
0000000000000000
[ 1909.987754] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1909.987757] CR2: 00007f295eac7000 CR3: 0000000004010003 CR4: 00000000001=
706e0
[ 1909.987760] Call Trace:
[ 1909.987764]  <TASK>
[ 1909.987766]  mod_delayed_work_on+0x49/0x70
[ 1909.987772]  nfsd_courtesy_client_count+0x24/0x50 [nfsd]
[ 1909.987800]  shrink_slab.constprop.92+0x9d/0x370
[ 1909.987805]  shrink_node+0x1c5/0x420
[ 1909.987810]  balance_pgdat+0x25f/0x530
[ 1909.987814]  ? prepare_to_wait_event+0x120/0x120
[ 1909.987821]  kswapd+0x12c/0x360
[ 1909.987824]  ? prepare_to_wait_event+0x120/0x120
[ 1909.987830]  ? balance_pgdat+0x530/0x530
[ 1909.987834]  kthread+0xec/0x110
[ 1909.987840]  ? kthread_complete_and_exit+0x20/0x20
[ 1909.987844]  ret_from_fork+0x1f/0x30
[ 1909.987850]  </TASK>
[ 1909.987852] ---[ end trace 0000000000000000 ]---
[ 1909.987856] ------------[ cut here ]------------
[ 1909.987859] WARNING: CPU: 7 PID: 78 at kernel/workqueue.c:1657 __queue_d=
elayed_work+0x5a/0x90
[ 1909.987863] Modules linked in: netconsole(E) af_packet(E) ip6table_mangl=
e(E) ip6table_raw(E) iptable_raw(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) i=
scsi_boot_sysfs(E) rfkill(E) nfnetlink(E) ebtable_filter(E) ebtables(E) ip6=
table_filter(E) ip6_tables(E) iptable_filter(E) bpfilter(E) usblp(E) joydev=
(E) intel_rapl_msr(E) intel_rapl_common(E) snd_hda_codec_realtek(E) snd_hda=
_codec_generic(E) ledtrig_audio(E) snd_hda_codec_hdmi(E) x86_pkg_temp_therm=
al(E) intel_powerclamp(E) coretemp(E) snd_hda_intel(E) snd_intel_dspcfg(E) =
iTCO_wdt(E) at24(E) intel_pmc_bxt(E) regmap_i2c(E) mei_hdcp(E) iTCO_vendor_=
support(E) kvm_intel(E) snd_hda_codec(E) nls_iso8859_1(E) snd_hwdep(E) nls_=
cp437(E) snd_hda_core(E) kvm(E) snd_pcm(E) r8169(E) irqbypass(E) snd_timer(=
E) i2c_i801(E) realtek(E) pcspkr(E) mei_me(E) mdio_devres(E) i2c_smbus(E) s=
nd(E) lpc_ich(E) mfd_core(E) libphy(E) soundcore(E) mei(E) thermal(E) fan(E=
) intel_smartconnect(E) nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E)=
 sch_fq_codel(E) sunrpc(E)
[ 1909.987889]  fuse(E) configfs(E) ip_tables(E) x_tables(E) hid_logitech_h=
idpp(E) hid_logitech_dj(E) uas(E) usb_storage(E) hid_generic(E) usbhid(E) n=
ouveau(E) i2c_algo_bit(E) drm_ttm_helper(E) ttm(E) drm_display_helper(E) cr=
ct10dif_pclmul(E) crc32_pclmul(E) drm_kms_helper(E) ghash_clmulni_intel(E) =
sha512_ssse3(E) syscopyarea(E) sha512_generic(E) sysfillrect(E) xhci_pci(E)=
 sysimgblt(E) ahci(E) ehci_pci(E) aesni_intel(E) fb_sys_fops(E) crypto_simd=
(E) libahci(E) cryptd(E) xhci_hcd(E) ehci_hcd(E) drm(E) libata(E) cec(E) us=
bcore(E) usb_common(E) rc_core(E) video(E) wmi(E) button(E) sd_mod(E) t10_p=
i(E) crc64_rocksoft_generic(E) crc64_rocksoft(E) crc64(E) vfat(E) fat(E) vi=
rtio_blk(E) virtio_mmio(E) virtio(E) virtio_ring(E) ext4(E) crc32c_intel(E)=
 crc16(E) mbcache(E) jbd2(E) loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_d=
h_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E) =
efivarfs(E) autofs4(E)
[ 1909.987931] CPU: 7 PID: 78 Comm: kswapd0 Kdump: loaded Tainted: G       =
 W   E      6.1.1-smpxx #8
[ 1909.987934] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[ 1909.987937] RIP: 0010:__queue_delayed_work+0x5a/0x90
[ 1909.987941] Code: 8b 05 3a 2c 17 01 4c 8d 42 20 48 89 72 48 89 7a 50 48 =
01 c1 83 ff 08 48 89 4a 30 75 2c 4c 89 c7 e9 fb e7 06 00 e9 a6 e9 ff ff <0f=
> 0b eb cc 0f 0b 48 81 7a 38 10 4d 09 81 74 aa 0f 0b 48 8b 42 28
[ 1909.987945] RSP: 0018:ffff888100ec7c78 EFLAGS: 00010003
[ 1909.987948] RAX: ffff88810800ab50 RBX: 0000000000000000 RCX: 00000000000=
00000
[ 1909.987950] RDX: ffff88810800ab48 RSI: ffff88818118d400 RDI: 00000000000=
00008
[ 1909.987954] RBP: ffff88810800ab48 R08: 0000000000000000 R09: 00000000000=
00000
[ 1909.987957] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00008
[ 1909.987959] R13: ffff88818118d400 R14: 0000000000000000 R15: ffff8881080=
0ab10
[ 1909.987963] FS:  0000000000000000(0000) GS:ffff88840edc0000(0000) knlGS:=
0000000000000000
[ 1909.987966] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1909.987969] CR2: 00007f295eac7000 CR3: 0000000004010003 CR4: 00000000001=
706e0
[ 1909.987972] Call Trace:
[ 1909.987974]  <TASK>
[ 1909.987977]  mod_delayed_work_on+0x49/0x70
[ 1909.987980]  nfsd_courtesy_client_count+0x24/0x50 [nfsd]
[ 1909.987999]  shrink_slab.constprop.92+0x9d/0x370
[ 1909.988004]  shrink_node+0x1c5/0x420
[ 1909.988008]  balance_pgdat+0x25f/0x530
[ 1909.988013]  ? prepare_to_wait_event+0x120/0x120
[ 1909.988020]  ? prepare_to_wait_event+0x120/0x120
[ 1909.988026]  ? balance_pgdat+0x530/0x530
[ 1909.988030]  kthread+0xec/0x110
[ 1909.988033]  ? kthread_complete_and_exit+0x20/0x20
[ 1909.988038]  ret_from_fork+0x1f/0x30
[ 1909.988042]  </TASK>
[ 1909.988044] ---[ end trace 0000000000000000 ]---
[ 1909.988048] ------------[ cut here ]------------
[ 1909.988050] WARNING: CPU: 7 PID: 78 at kernel/workqueue.c:1500 __queue_w=
ork+0x33b/0x3d0
[ 1909.988017]  kswapd+0x12c/0x360
[ 1909.988064] Modules linked in: netconsole(E) af_packet(E) ip6table_mangl=
e(E) ip6table_raw(E) iptable_raw(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) i=
scsi_boot_sysfs(E) rfkill(E) nfnetlink(E) ebtable_filter(E) ebtables(E) ip6=
table_filter(E) ip6_tables(E) iptable_filter(E) bpfilter(E) usblp(E) joydev=
(E) intel_rapl_msr(E) intel_rapl_common(E) snd_hda_codec_realtek(E) snd_hda=
_codec_generic(E) ledtrig_audio(E) snd_hda_codec_hdmi(E) x86_pkg_temp_therm=
al(E) intel_powerclamp(E) coretemp(E) snd_hda_intel(E) snd_intel_dspcfg(E) =
iTCO_wdt(E) at24(E) intel_pmc_bxt(E) regmap_i2c(E) mei_hdcp(E) iTCO_vendor_=
support(E) kvm_intel(E) snd_hda_codec(E) nls_iso8859_1(E) snd_hwdep(E) nls_=
cp437(E) snd_hda_core(E) kvm(E) snd_pcm(E) r8169(E) irqbypass(E) snd_timer(=
E) i2c_i801(E) realtek(E) pcspkr(E) mei_me(E) mdio_devres(E) i2c_smbus(E) s=
nd(E) lpc_ich(E) mfd_core(E) libphy(E) soundcore(E) mei(E) thermal(E) fan(E=
) intel_smartconnect(E) nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E)=
 sch_fq_codel(E) sunrpc(E)
[ 1909.988099]  fuse(E) configfs(E) ip_tables(E) x_tables(E) hid_logitech_h=
idpp(E) hid_logitech_dj(E) uas(E) usb_storage(E) hid_generic(E) usbhid(E) n=
ouveau(E) i2c_algo_bit(E) drm_ttm_helper(E) ttm(E) drm_display_helper(E) cr=
ct10dif_pclmul(E) crc32_pclmul(E) drm_kms_helper(E) ghash_clmulni_intel(E) =
sha512_ssse3(E) syscopyarea(E) sha512_generic(E) sysfillrect(E) xhci_pci(E)=
 sysimgblt(E) ahci(E) ehci_pci(E) aesni_intel(E) fb_sys_fops(E) crypto_simd=
(E) libahci(E) cryptd(E) xhci_hcd(E) ehci_hcd(E) drm(E) libata(E) cec(E) us=
bcore(E) usb_common(E) rc_core(E) video(E) wmi(E) button(E) sd_mod(E) t10_p=
i(E) crc64_rocksoft_generic(E) crc64_rocksoft(E) crc64(E) vfat(E) fat(E) vi=
rtio_blk(E) virtio_mmio(E) virtio(E) virtio_ring(E) ext4(E) crc32c_intel(E)=
 crc16(E) mbcache(E) jbd2(E) loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_d=
h_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E) =
efivarfs(E) autofs4(E)
[ 1909.988140] CPU: 7 PID: 78 Comm: kswapd0 Kdump: loaded Tainted: G       =
 W   E      6.1.1-smpxx #8
[ 1909.988144] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[ 1909.988146] RIP: 0010:__queue_work+0x33b/0x3d0
[ 1909.988149] Code: 25 00 cd 01 00 f6 47 2c 20 74 18 e8 5f 65 00 00 48 85 =
c0 74 0e 48 8b 40 20 48 3b 68 08 0f 84 f5 fc ff ff 0f 0b e9 fe fd ff ff <0f=
> 0b e9 ee fd ff ff 83 c9 02 49 8d 57 68 e9 d7 fd ff ff 80 3d c3
[ 1909.988154] RSP: 0018:ffff888100ec7c38 EFLAGS: 00010003
[ 1909.988157] RAX: ffff88810800ab50 RBX: ffffffff820c4860 RCX: 00000000000=
00000
[ 1909.988160] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8881000=
70000
[ 1909.988164] RBP: ffff88818118d400 R08: ffff888100400028 R09: ffff8881004=
00000
[ 1909.988166] R10: 0000000000000000 R11: ffffffff8225f318 R12: 00000000000=
00008
[ 1909.988169] R13: 0000000000000007 R14: ffff88810800ab48 R15: ffff8881072=
56100
[ 1909.988172] FS:  0000000000000000(0000) GS:ffff88840edc0000(0000) knlGS:=
0000000000000000
[ 1909.988176] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1909.988178] CR2: 00007f295eac7000 CR3: 0000000004010003 CR4: 00000000001=
706e0
[ 1909.988181] Call Trace:
[ 1909.988184]  <TASK>
[ 1909.988186]  mod_delayed_work_on+0x49/0x70
[ 1909.988190]  nfsd_courtesy_client_count+0x24/0x50 [nfsd]
[ 1909.988207]  shrink_slab.constprop.92+0x9d/0x370
[ 1909.988212]  shrink_node+0x1c5/0x420
[ 1909.988216]  balance_pgdat+0x25f/0x530
[ 1909.988220]  ? prepare_to_wait_event+0x120/0x120
[ 1909.988224]  kswapd+0x12c/0x360
[ 1909.988228]  ? prepare_to_wait_event+0x120/0x120
[ 1909.988232]  ? balance_pgdat+0x530/0x530
[ 1909.988235]  kthread+0xec/0x110
[ 1909.988239]  ? kthread_complete_and_exit+0x20/0x20
[ 1909.988247]  </TASK>
[ 1909.988249] ---[ end trace 0000000000000000 ]---
[ 1909.988264] ------------[ cut here ]------------
[ 1909.988267] WARNING: CPU: 7 PID: 78 at kernel/workqueue.c:1500 __queue_w=
ork+0x33b/0x3d0
[ 1909.988271] Modules linked in: netconsole(E) af_packet(E) ip6table_mangl=
e(E) ip6table_raw(E) iptable_raw(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) i=
scsi_boot_sysfs(E) rfkill(E) nfnetlink(E) ebtable_filter(E) ebtables(E) ip6=
table_filter(E) ip6_tables(E) iptable_filter(E) bpfilter(E) usblp(E) joydev=
(E) intel_rapl_msr(E) intel_rapl_common(E) snd_hda_codec_realtek(E) snd_hda=
_codec_generic(E) ledtrig_audio(E) snd_hda_codec_hdmi(E) x86_pkg_temp_therm=
al(E) intel_powerclamp(E) coretemp(E) snd_hda_intel(E) snd_intel_dspcfg(E) =
iTCO_wdt(E) at24(E) intel_pmc_bxt(E) regmap_i2c(E) mei_hdcp(E) iTCO_vendor_=
support(E) kvm_intel(E) snd_hda_codec(E) nls_iso8859_1(E) snd_hwdep(E) nls_=
cp437(E) snd_hda_core(E) kvm(E) snd_pcm(E) r8169(E) irqbypass(E) snd_timer(=
E) i2c_i801(E) realtek(E) pcspkr(E) mei_me(E) mdio_devres(E) i2c_smbus(E) s=
nd(E) lpc_ich(E) mfd_core(E) libphy(E) soundcore(E) mei(E) thermal(E) fan(E=
) intel_smartconnect(E) nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E)=
 sch_fq_codel(E) sunrpc(E)
[ 1909.988296]  fuse(E) configfs(E) ip_tables(E) x_tables(E) hid_logitech_h=
idpp(E) hid_logitech_dj(E) uas(E) usb_storage(E) hid_generic(E) usbhid(E) n=
ouveau(E) i2c_algo_bit(E) drm_ttm_helper(E) ttm(E) drm_display_helper(E) cr=
ct10dif_pclmul(E) crc32_pclmul(E) drm_kms_helper(E) ghash_clmulni_intel(E) =
sha512_ssse3(E) syscopyarea(E) sha512_generic(E) sysfillrect(E) xhci_pci(E)=
 sysimgblt(E) ahci(E) ehci_pci(E) aesni_intel(E) fb_sys_fops(E) crypto_simd=
(E) libahci(E) cryptd(E) xhci_hcd(E) ehci_hcd(E) drm(E) libata(E) cec(E) us=
bcore(E) usb_common(E) rc_core(E) video(E) wmi(E) button(E) sd_mod(E) t10_p=
i(E) crc64_rocksoft_generic(E) crc64_rocksoft(E) crc64(E) vfat(E) fat(E) vi=
rtio_blk(E) virtio_mmio(E) virtio(E) virtio_ring(E) ext4(E) crc32c_intel(E)=
 crc16(E) mbcache(E) jbd2(E) loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_d=
h_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E) =
efivarfs(E) autofs4(E)
[ 1909.988357] CPU: 7 PID: 78 Comm: kswapd0 Kdump: loaded Tainted: G       =
 W   E      6.1.1-smpxx #8
[ 1909.988360] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[ 1909.988362] RIP: 0010:__queue_work+0x33b/0x3d0
[ 1909.988376] Code: 25 00 cd 01 00 f6 47 2c 20 74 18 e8 5f 65 00 00 48 85 =
c0 74 0e 48 8b 40 20 48 3b 68 08 0f 84 f5 fc ff ff 0f 0b e9 fe fd ff ff <0f=
> 0b e9 ee fd ff ff 83 c9 02 49 8d 57 68 e9 d7 fd ff ff 80 3d c3
[ 1909.988379] RSP: 0018:ffff888100ec7c38 EFLAGS: 00010003
[ 1909.988392] RAX: ffff888106c9bf50 RBX: ffffffff820c4860 RCX: 00000000000=
00000
[ 1909.988395] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8881000=
70000
[ 1909.988397] RBP: ffff88818118d400 R08: ffff888100400028 R09: ffff8881004=
00000
[ 1909.988400] R10: 0000000000000000 R11: ffffffff8225f318 R12: 00000000000=
00008
[ 1909.988404] R13: 0000000000000007 R14: ffff888106c9bf48 R15: ffff8881072=
56100
[ 1909.988407] FS:  0000000000000000(0000) GS:ffff88840edc0000(0000) knlGS:=
0000000000000000
[ 1909.988410] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1909.988413] CR2: 00007f295eac7000 CR3: 0000000004010003 CR4: 00000000001=
706e0
[ 1909.988416] Call Trace:
[ 1909.988243]  ret_from_fork+0x1f/0x30
[ 1909.988418]  <TASK>
[ 1909.988420]  mod_delayed_work_on+0x49/0x70
[ 1909.988424]  nfsd_courtesy_client_count+0x24/0x50 [nfsd]
[ 1909.988442]  shrink_slab.constprop.92+0x9d/0x370
[ 1909.988446]  shrink_node+0x1c5/0x420
[ 1909.988451]  balance_pgdat+0x25f/0x530
[ 1909.988455]  ? prepare_to_wait_event+0x120/0x120
[ 1909.988459]  kswapd+0x12c/0x360
[ 1909.988463]  ? prepare_to_wait_event+0x120/0x120
[ 1909.988467]  ? balance_pgdat+0x530/0x530
[ 1909.988470]  kthread+0xec/0x110
[ 1909.988475]  ? kthread_complete_and_exit+0x20/0x20
[ 1909.988478]  ret_from_fork+0x1f/0x30
[ 1909.988483]  </TASK>
[ 1909.988485] ---[ end trace 0000000000000000 ]---
[ 1909.988489] ------------[ cut here ]------------
[ 1909.988491] WARNING: CPU: 7 PID: 78 at kernel/workqueue.c:1500 __queue_w=
ork+0x33b/0x3d0
[ 1909.988495] Modules linked in: netconsole(E) af_packet(E) ip6table_mangl=
e(E) ip6table_raw(E) iptable_raw(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) i=
scsi_boot_sysfs(E) rfkill(E) nfnetlink(E) ebtable_filter(E) ebtables(E) ip6=
table_filter(E) ip6_tables(E) iptable_filter(E) bpfilter(E) usblp(E) joydev=
(E) intel_rapl_msr(E) intel_rapl_common(E) snd_hda_codec_realtek(E) snd_hda=
_codec_generic(E) ledtrig_audio(E) snd_hda_codec_hdmi(E) x86_pkg_temp_therm=
al(E) intel_powerclamp(E) coretemp(E) snd_hda_intel(E) snd_intel_dspcfg(E) =
iTCO_wdt(E) at24(E) intel_pmc_bxt(E) regmap_i2c(E) mei_hdcp(E) iTCO_vendor_=
support(E) kvm_intel(E) snd_hda_codec(E) nls_iso8859_1(E) snd_hwdep(E) nls_=
cp437(E) snd_hda_core(E) kvm(E) snd_pcm(E) r8169(E) irqbypass(E) snd_timer(=
E) i2c_i801(E) realtek(E) pcspkr(E) mei_me(E) mdio_devres(E) i2c_smbus(E) s=
nd(E) lpc_ich(E) mfd_core(E) libphy(E) soundcore(E) mei(E) thermal(E) fan(E=
) intel_smartconnect(E) nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E)=
 sch_fq_codel(E) sunrpc(E)
[ 1909.988521]  fuse(E) configfs(E) ip_tables(E) x_tables(E) hid_logitech_h=
idpp(E) hid_logitech_dj(E) uas(E) usb_storage(E) hid_generic(E) usbhid(E) n=
ouveau(E) i2c_algo_bit(E) drm_ttm_helper(E) ttm(E) drm_display_helper(E) cr=
ct10dif_pclmul(E) crc32_pclmul(E) drm_kms_helper(E) ghash_clmulni_intel(E) =
sha512_ssse3(E) syscopyarea(E) sha512_generic(E) sysfillrect(E) xhci_pci(E)=
 sysimgblt(E) ahci(E) ehci_pci(E) aesni_intel(E) fb_sys_fops(E) crypto_simd=
(E) libahci(E) cryptd(E) xhci_hcd(E) ehci_hcd(E) drm(E) libata(E) cec(E) us=
bcore(E) usb_common(E) rc_core(E) video(E) wmi(E) button(E) sd_mod(E) t10_p=
i(E) crc64_rocksoft_generic(E) crc64_rocksoft(E) crc64(E) vfat(E) fat(E) vi=
rtio_blk(E) virtio_mmio(E) virtio(E) virtio_ring(E) ext4(E) crc32c_intel(E)=
 crc16(E) mbcache(E) jbd2(E) loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_d=
h_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E) =
efivarfs(E) autofs4(E)
[ 1909.988563] CPU: 7 PID: 78 Comm: kswapd0 Kdump: loaded Tainted: G       =
 W   E      6.1.1-smpxx #8
[ 1909.988566] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[ 1909.988568] RIP: 0010:__queue_work+0x33b/0x3d0
[ 1909.988572] Code: 25 00 cd 01 00 f6 47 2c 20 74 18 e8 5f 65 00 00 48 85 =
c0 74 0e 48 8b 40 20 48 3b 68 08 0f 84 f5 fc ff ff 0f 0b e9 fe fd ff ff <0f=
> 0b e9 ee fd ff ff 83 c9 02 49 8d 57 68 e9 d7 fd ff ff 80 3d c3
[ 1909.988576] RSP: 0018:ffff888100ec7c38 EFLAGS: 00010003
[ 1909.988579] RAX: ffff8881438d7b50 RBX: ffffffff820c4860 RCX: 00000000000=
00000
[ 1909.988582] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8881000=
70000
[ 1909.988586] RBP: ffff88818118d400 R08: ffff888100400028 R09: ffff8881004=
00000
[ 1909.988588] R10: 0000000000000000 R11: ffffffff8225f318 R12: 00000000000=
00008
[ 1909.988591] R13: 0000000000000007 R14: ffff8881438d7b48 R15: ffff8881072=
56100
[ 1909.988594] FS:  0000000000000000(0000) GS:ffff88840edc0000(0000) knlGS:=
0000000000000000
[ 1909.988597] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1909.988602] CR2: 00007f295eac7000 CR3: 0000000004010003 CR4: 00000000001=
706e0
[ 1909.988605] Call Trace:
[ 1909.988607]  <TASK>
[ 1909.988610]  mod_delayed_work_on+0x49/0x70
[ 1909.988615]  nfsd_courtesy_client_count+0x24/0x50 [nfsd]
[ 1909.988633]  shrink_slab.constprop.92+0x9d/0x370
[ 1909.988637]  shrink_node+0x1c5/0x420
[ 1909.988641]  balance_pgdat+0x25f/0x530
[ 1909.988645]  ? prepare_to_wait_event+0x120/0x120
[ 1909.988649]  kswapd+0x12c/0x360
[ 1909.988653]  ? prepare_to_wait_event+0x120/0x120
[ 1909.988658]  ? balance_pgdat+0x530/0x530
[ 1909.988661]  kthread+0xec/0x110
[ 1909.988664]  ? kthread_complete_and_exit+0x20/0x20
[ 1909.988667]  ret_from_fork+0x1f/0x30
[ 1909.988672]  </TASK>
[ 1909.988674] ---[ end trace 0000000000000000 ]---
[ 1909.988678] ------------[ cut here ]------------
[ 1909.988681] WARNING: CPU: 7 PID: 78 at kernel/workqueue.c:1500 __queue_w=
ork+0x33b/0x3d0
[ 1909.988740] Modules linked in: netconsole(E) af_packet(E) ip6table_mangl=
e(E) ip6table_raw(E) iptable_raw(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) i=
scsi_boot_sysfs(E) rfkill(E) nfnetlink(E) ebtable_filter(E) ebtables(E) ip6=
table_filter(E) ip6_tables(E) iptable_filter(E) bpfilter(E) usblp(E) joydev=
(E) intel_rapl_msr(E) intel_rapl_common(E) snd_hda_codec_realtek(E) snd_hda=
_codec_generic(E) ledtrig_audio(E) snd_hda_codec_hdmi(E) x86_pkg_temp_therm=
al(E) intel_powerclamp(E) coretemp(E) snd_hda_intel(E) snd_intel_dspcfg(E) =
iTCO_wdt(E) at24(E) intel_pmc_bxt(E) regmap_i2c(E) mei_hdcp(E) iTCO_vendor_=
support(E) kvm_intel(E) snd_hda_codec(E) nls_iso8859_1(E) snd_hwdep(E) nls_=
cp437(E) snd_hda_core(E) kvm(E) snd_pcm(E) r8169(E) irqbypass(E) snd_timer(=
E) i2c_i801(E) realtek(E) pcspkr(E) mei_me(E) mdio_devres(E) i2c_smbus(E) s=
nd(E) lpc_ich(E) mfd_core(E) libphy(E) soundcore(E) mei(E) thermal(E) fan(E=
) intel_smartconnect(E) nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E)=
 sch_fq_codel(E) sunrpc(E)
[ 1909.988765]  fuse(E) configfs(E) ip_tables(E) x_tables(E) hid_logitech_h=
idpp(E) hid_logitech_dj(E) uas(E) usb_storage(E) hid_generic(E) usbhid(E) n=
ouveau(E) i2c_algo_bit(E) drm_ttm_helper(E) ttm(E) drm_display_helper(E) cr=
ct10dif_pclmul(E) crc32_pclmul(E) drm_kms_helper(E) ghash_clmulni_intel(E) =
sha512_ssse3(E) syscopyarea(E) sha512_generic(E) sysfillrect(E) xhci_pci(E)=
 sysimgblt(E) ahci(E) ehci_pci(E) aesni_intel(E) fb_sys_fops(E) crypto_simd=
(E) libahci(E) cryptd(E) xhci_hcd(E) ehci_hcd(E) drm(E) libata(E) cec(E) us=
bcore(E) usb_common(E) rc_core(E) video(E) wmi(E) button(E) sd_mod(E) t10_p=
i(E) crc64_rocksoft_generic(E) crc64_rocksoft(E) crc64(E) vfat(E) fat(E) vi=
rtio_blk(E) virtio_mmio(E) virtio(E) virtio_ring(E) ext4(E) crc32c_intel(E)=
 crc16(E) mbcache(E) jbd2(E) loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_d=
h_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E) =
efivarfs(E) autofs4(E)
[ 1909.988806] CPU: 7 PID: 78 Comm: kswapd0 Kdump: loaded Tainted: G       =
 W   E      6.1.1-smpxx #8
[ 1909.988809] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[ 1909.988812] RIP: 0010:__queue_work+0x33b/0x3d0
[ 1909.988815] Code: 25 00 cd 01 00 f6 47 2c 20 74 18 e8 5f 65 00 00 48 85 =
c0 74 0e 48 8b 40 20 48 3b 68 08 0f 84 f5 fc ff ff 0f 0b e9 fe fd ff ff <0f=
> 0b e9 ee fd ff ff 83 c9 02 49 8d 57 68 e9 d7 fd ff ff 80 3d c3
[ 1909.988819] RSP: 0018:ffff888100ec7c38 EFLAGS: 00010003
[ 1909.988822] RAX: ffff8881e2614750 RBX: ffffffff820c4860 RCX: 00000000000=
00000
[ 1909.988824] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8881000=
70000
[ 1909.988827] RBP: ffff88818118d400 R08: ffff888100400028 R09: ffff8881004=
00000
[ 1909.988830] R10: 0000000000000000 R11: ffffffff8225f318 R12: 00000000000=
00008
[ 1909.988832] R13: 0000000000000007 R14: ffff8881e2614748 R15: ffff8881072=
56100
[ 1909.988835] FS:  0000000000000000(0000) GS:ffff88840edc0000(0000) knlGS:=
0000000000000000
[ 1909.988838] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1909.988841] CR2: 00007f295eac7000 CR3: 0000000004010003 CR4: 00000000001=
706e0
[ 1909.988843] Call Trace:
[ 1909.988846]  <TASK>
[ 1909.988848]  mod_delayed_work_on+0x49/0x70
[ 1909.988852]  nfsd_courtesy_client_count+0x24/0x50 [nfsd]
[ 1909.988869]  shrink_slab.constprop.92+0x9d/0x370
[ 1909.988873]  shrink_node+0x1c5/0x420
[ 1909.988877]  balance_pgdat+0x25f/0x530
[ 1909.988881]  ? prepare_to_wait_event+0x120/0x120
[ 1909.988885]  kswapd+0x12c/0x360
[ 1909.988889]  ? prepare_to_wait_event+0x120/0x120
[ 1909.988893]  ? balance_pgdat+0x530/0x530
[ 1909.988897]  kthread+0xec/0x110
[ 1909.988900]  ? kthread_complete_and_exit+0x20/0x20
[ 1909.988903]  ret_from_fork+0x1f/0x30
[ 1909.988907]  </TASK>
[ 1909.988909] ---[ end trace 0000000000000000 ]---
[ 1909.988913] ------------[ cut here ]------------
[ 1909.988915] WARNING: CPU: 7 PID: 78 at kernel/workqueue.c:1500 __queue_w=
ork+0x33b/0x3d0
[ 1909.988919] Modules linked in: netconsole(E) af_packet(E) ip6table_mangl=
e(E) ip6table_raw(E) iptable_raw(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) i=
scsi_boot_sysfs(E) rfkill(E) nfnetlink(E) ebtable_filter(E) ebtables(E) ip6=
table_filter(E) ip6_tables(E) iptable_filter(E) bpfilter(E) usblp(E) joydev=
(E) intel_rapl_msr(E) intel_rapl_common(E) snd_hda_codec_realtek(E) snd_hda=
_codec_generic(E) ledtrig_audio(E) snd_hda_codec_hdmi(E) x86_pkg_temp_therm=
al(E) intel_powerclamp(E) coretemp(E) snd_hda_intel(E) snd_intel_dspcfg(E) =
iTCO_wdt(E) at24(E) intel_pmc_bxt(E) regmap_i2c(E) mei_hdcp(E) iTCO_vendor_=
support(E) kvm_intel(E) snd_hda_codec(E) nls_iso8859_1(E) snd_hwdep(E) nls_=
cp437(E) snd_hda_core(E) kvm(E) snd_pcm(E) r8169(E) irqbypass(E) snd_timer(=
E) i2c_i801(E) realtek(E) pcspkr(E) mei_me(E) mdio_devres(E) i2c_smbus(E) s=
nd(E) lpc_ich(E) mfd_core(E) libphy(E) soundcore(E) mei(E) thermal(E) fan(E=
) intel_smartconnect(E) nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E)=
 sch_fq_codel(E) sunrpc(E)
[ 1909.988945]  fuse(E) configfs(E) ip_tables(E) x_tables(E) hid_logitech_h=
idpp(E) hid_logitech_dj(E) uas(E) usb_storage(E) hid_generic(E) usbhid(E) n=
ouveau(E) i2c_algo_bit(E) drm_ttm_helper(E) ttm(E) drm_display_helper(E) cr=
ct10dif_pclmul(E) crc32_pclmul(E) drm_kms_helper(E) ghash_clmulni_intel(E) =
sha512_ssse3(E) syscopyarea(E) sha512_generic(E) sysfillrect(E) xhci_pci(E)=
 sysimgblt(E) ahci(E) ehci_pci(E) aesni_intel(E) fb_sys_fops(E) crypto_simd=
(E) libahci(E) cryptd(E) xhci_hcd(E) ehci_hcd(E) drm(E) libata(E) cec(E) us=
bcore(E) usb_common(E) rc_core(E) video(E) wmi(E) button(E) sd_mod(E) t10_p=
i(E) crc64_rocksoft_generic(E) crc64_rocksoft(E) crc64(E) vfat(E) fat(E) vi=
rtio_blk(E) virtio_mmio(E) virtio(E) virtio_ring(E) ext4(E) crc32c_intel(E)=
 crc16(E) mbcache(E) jbd2(E) loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_d=
h_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E) =
efivarfs(E) autofs4(E)
[ 1909.988986] CPU: 7 PID: 78 Comm: kswapd0 Kdump: loaded Tainted: G       =
 W   E      6.1.1-smpxx #8
[ 1909.988990] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[ 1909.988992] RIP: 0010:__queue_work+0x33b/0x3d0
[ 1909.988995] Code: 25 00 cd 01 00 f6 47 2c 20 74 18 e8 5f 65 00 00 48 85 =
c0 74 0e 48 8b 40 20 48 3b 68 08 0f 84 f5 fc ff ff 0f 0b e9 fe fd ff ff <0f=
> 0b e9 ee fd ff ff 83 c9 02 49 8d 57 68 e9 d7 fd ff ff 80 3d c3
[ 1909.988999] RSP: 0018:ffff888100ec7c38 EFLAGS: 00010003
[ 1909.989002] RAX: ffff888332342350 RBX: ffffffff820c4860 RCX: 00000000000=
00000
[ 1909.989005] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8881000=
70000
[ 1909.989007] RBP: ffff88818118d400 R08: ffff888100400028 R09: ffff8881004=
00000
[ 1909.989010] R10: 0000000000000000 R11: ffffffff8225f318 R12: 00000000000=
00008
[ 1909.989013] R13: 0000000000000007 R14: ffff888332342348 R15: ffff8881072=
56100
[ 1909.989016] FS:  0000000000000000(0000) GS:ffff88840edc0000(0000) knlGS:=
0000000000000000
[ 1909.989019] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1909.989021] CR2: 00007f295eac7000 CR3: 0000000004010003 CR4: 00000000001=
706e0
[ 1909.989024] Call Trace:
[ 1909.989026]  <TASK>
[ 1909.989028]  mod_delayed_work_on+0x49/0x70
[ 1909.989032]  nfsd_courtesy_client_count+0x24/0x50 [nfsd]
[ 1909.989049]  shrink_slab.constprop.92+0x9d/0x370
[ 1909.989053]  shrink_node+0x1c5/0x420
[ 1909.989057]  balance_pgdat+0x25f/0x530
[ 1909.989061]  ? prepare_to_wait_event+0x120/0x120
[ 1909.989065]  kswapd+0x12c/0x360
[ 1909.989069]  ? prepare_to_wait_event+0x120/0x120
[ 1909.989073]  ? balance_pgdat+0x530/0x530
[ 1909.989077]  kthread+0xec/0x110
[ 1909.989080]  ? kthread_complete_and_exit+0x20/0x20
[ 1909.989083]  ret_from_fork+0x1f/0x30
[ 1909.989089]  </TASK>
[ 1909.989091] ---[ end trace 0000000000000000 ]---
[ 1909.989095] ------------[ cut here ]------------
[ 1909.989097] WARNING: CPU: 7 PID: 78 at kernel/workqueue.c:1500 __queue_w=
ork+0x33b/0x3d0
[ 1909.989101] Modules linked in: netconsole(E) af_packet(E) ip6table_mangl=
e(E) ip6table_raw(E) iptable_raw(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) i=
scsi_boot_sysfs(E) rfkill(E) nfnetlink(E) ebtable_filter(E) ebtables(E) ip6=
table_filter(E) ip6_tables(E) iptable_filter(E) bpfilter(E) usblp(E) joydev=
(E) intel_rapl_msr(E) intel_rapl_common(E) snd_hda_codec_realtek(E) snd_hda=
_codec_generic(E) ledtrig_audio(E) snd_hda_codec_hdmi(E) x86_pkg_temp_therm=
al(E) intel_powerclamp(E) coretemp(E) snd_hda_intel(E) snd_intel_dspcfg(E) =
iTCO_wdt(E) at24(E) intel_pmc_bxt(E) regmap_i2c(E) mei_hdcp(E) iTCO_vendor_=
support(E) kvm_intel(E) snd_hda_codec(E) nls_iso8859_1(E) snd_hwdep(E) nls_=
cp437(E) snd_hda_core(E) kvm(E) snd_pcm(E) r8169(E) irqbypass(E) snd_timer(=
E) i2c_i801(E) realtek(E) pcspkr(E) mei_me(E) mdio_devres(E) i2c_smbus(E) s=
nd(E) lpc_ich(E) mfd_core(E) libphy(E) soundcore(E) mei(E) thermal(E) fan(E=
) intel_smartconnect(E) nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E)=
 sch_fq_codel(E) sunrpc(E)
[ 1909.989126]  fuse(E) configfs(E) ip_tables(E) x_tables(E) hid_logitech_h=
idpp(E) hid_logitech_dj(E) uas(E) usb_storage(E) hid_generic(E) usbhid(E) n=
ouveau(E) i2c_algo_bit(E) drm_ttm_helper(E) ttm(E) drm_display_helper(E) cr=
ct10dif_pclmul(E) crc32_pclmul(E) drm_kms_helper(E) ghash_clmulni_intel(E) =
sha512_ssse3(E) syscopyarea(E) sha512_generic(E) sysfillrect(E) xhci_pci(E)=
 sysimgblt(E) ahci(E) ehci_pci(E) aesni_intel(E) fb_sys_fops(E) crypto_simd=
(E) libahci(E) cryptd(E) xhci_hcd(E) ehci_hcd(E) drm(E) libata(E) cec(E) us=
bcore(E) usb_common(E) rc_core(E) video(E) wmi(E) button(E) sd_mod(E) t10_p=
i(E) crc64_rocksoft_generic(E) crc64_rocksoft(E) crc64(E) vfat(E) fat(E) vi=
rtio_blk(E) virtio_mmio(E) virtio(E) virtio_ring(E) ext4(E) crc32c_intel(E)=
 crc16(E) mbcache(E) jbd2(E) loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_d=
h_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E) =
efivarfs(E) autofs4(E)
[ 1909.989168] CPU: 7 PID: 78 Comm: kswapd0 Kdump: loaded Tainted: G       =
 W   E      6.1.1-smpxx #8
[ 1909.989229] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[ 1909.989232] RIP: 0010:__queue_work+0x33b/0x3d0
[ 1909.989235] Code: 25 00 cd 01 00 f6 47 2c 20 74 18 e8 5f 65 00 00 48 85 =
c0 74 0e 48 8b 40 20 48 3b 68 08 0f 84 f5 fc ff ff 0f 0b e9 fe fd ff ff <0f=
> 0b e9 ee fd ff ff 83 c9 02 49 8d 57 68 e9 d7 fd ff ff 80 3d c3
[ 1909.989239] RSP: 0018:ffff888100ec7c38 EFLAGS: 00010003
[ 1909.989242] RAX: ffff888331afb750 RBX: ffffffff820c4860 RCX: 00000000000=
00000
[ 1909.989244] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8881000=
70000
[ 1909.989247] RBP: ffff88818118d400 R08: ffff888100400028 R09: ffff8881004=
00000
[ 1909.989249] R10: 0000000000000000 R11: ffffffff8225f318 R12: 00000000000=
00008
[ 1909.989252] R13: 0000000000000007 R14: ffff888331afb748 R15: ffff8881072=
56100
[ 1909.989255] FS:  0000000000000000(0000) GS:ffff88840edc0000(0000) knlGS:=
0000000000000000
[ 1909.989258] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1909.989260] CR2: 00007f295eac7000 CR3: 0000000004010003 CR4: 00000000001=
706e0
[ 1909.989263] Call Trace:
[ 1909.989265]  <TASK>
[ 1909.989267]  mod_delayed_work_on+0x49/0x70
[ 1909.989271]  nfsd_courtesy_client_count+0x24/0x50 [nfsd]
[ 1909.989288]  shrink_slab.constprop.92+0x9d/0x370
[ 1909.989292]  shrink_node+0x1c5/0x420
[ 1909.989296]  balance_pgdat+0x25f/0x530
[ 1909.989300]  ? prepare_to_wait_event+0x120/0x120
[ 1909.989304]  kswapd+0x12c/0x360
[ 1909.989307]  ? prepare_to_wait_event+0x120/0x120
[ 1909.989311]  ? balance_pgdat+0x530/0x530
[ 1909.989315]  kthread+0xec/0x110
[ 1909.989318]  ? kthread_complete_and_exit+0x20/0x20
[ 1909.989321]  ret_from_fork+0x1f/0x30
[ 1909.989325]  </TASK>
[ 1909.989327] ---[ end trace 0000000000000000 ]---
[ 1909.989331] ------------[ cut here ]------------
[ 1909.989334] WARNING: CPU: 7 PID: 78 at kernel/workqueue.c:1500 __queue_w=
ork+0x33b/0x3d0
[ 1909.989337] Modules linked in: netconsole(E) af_packet(E) ip6table_mangl=
e(E) ip6table_raw(E) iptable_raw(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) i=
scsi_boot_sysfs(E) rfkill(E) nfnetlink(E) ebtable_filter(E) ebtables(E) ip6=
table_filter(E) ip6_tables(E) iptable_filter(E) bpfilter(E) usblp(E) joydev=
(E) intel_rapl_msr(E) intel_rapl_common(E) snd_hda_codec_realtek(E) snd_hda=
_codec_generic(E) ledtrig_audio(E) snd_hda_codec_hdmi(E) x86_pkg_temp_therm=
al(E) intel_powerclamp(E) coretemp(E) snd_hda_intel(E) snd_intel_dspcfg(E) =
iTCO_wdt(E) at24(E) intel_pmc_bxt(E) regmap_i2c(E) mei_hdcp(E) iTCO_vendor_=
support(E) kvm_intel(E) snd_hda_codec(E) nls_iso8859_1(E) snd_hwdep(E) nls_=
cp437(E) snd_hda_core(E) kvm(E) snd_pcm(E) r8169(E) irqbypass(E) snd_timer(=
E) i2c_i801(E) realtek(E) pcspkr(E) mei_me(E) mdio_devres(E) i2c_smbus(E) s=
nd(E) lpc_ich(E) mfd_core(E) libphy(E) soundcore(E) mei(E) thermal(E) fan(E=
) intel_smartconnect(E) nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E)=
 sch_fq_codel(E) sunrpc(E)
[ 1909.989363]  fuse(E) configfs(E) ip_tables(E) x_tables(E) hid_logitech_h=
idpp(E) hid_logitech_dj(E) uas(E) usb_storage(E) hid_generic(E) usbhid(E) n=
ouveau(E) i2c_algo_bit(E) drm_ttm_helper(E) ttm(E) drm_display_helper(E) cr=
ct10dif_pclmul(E) crc32_pclmul(E) drm_kms_helper(E) ghash_clmulni_intel(E) =
sha512_ssse3(E) syscopyarea(E) sha512_generic(E) sysfillrect(E) xhci_pci(E)=
 sysimgblt(E) ahci(E) ehci_pci(E) aesni_intel(E) fb_sys_fops(E) crypto_simd=
(E) libahci(E) cryptd(E) xhci_hcd(E) ehci_hcd(E) drm(E) libata(E) cec(E) us=
bcore(E) usb_common(E) rc_core(E) video(E) wmi(E) button(E) sd_mod(E) t10_p=
i(E) crc64_rocksoft_generic(E) crc64_rocksoft(E) crc64(E) vfat(E) fat(E) vi=
rtio_blk(E) virtio_mmio(E) virtio(E) virtio_ring(E) ext4(E) crc32c_intel(E)=
 crc16(E) mbcache(E) jbd2(E) loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_d=
h_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E) =
efivarfs(E) autofs4(E)
[ 1909.989404] CPU: 7 PID: 78 Comm: kswapd0 Kdump: loaded Tainted: G       =
 W   E      6.1.1-smpxx #8
[ 1909.989407] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[ 1909.989410] RIP: 0010:__queue_work+0x33b/0x3d0
[ 1909.989413] Code: 25 00 cd 01 00 f6 47 2c 20 74 18 e8 5f 65 00 00 48 85 =
c0 74 0e 48 8b 40 20 48 3b 68 08 0f 84 f5 fc ff ff 0f 0b e9 fe fd ff ff <0f=
> 0b e9 ee fd ff ff 83 c9 02 49 8d 57 68 e9 d7 fd ff ff 80 3d c3
[ 1909.989417] RSP: 0018:ffff888100ec7c38 EFLAGS: 00010003
[ 1909.989420] RAX: ffff888331aff350 RBX: ffffffff820c4860 RCX: 00000000000=
00000
[ 1909.989423] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8881000=
70000
[ 1909.989426] RBP: ffff88818118d400 R08: ffff888100400028 R09: ffff8881004=
00000
[ 1909.989428] R10: 0000000000000000 R11: ffffffff8225f318 R12: 00000000000=
00008
[ 1909.989431] R13: 0000000000000007 R14: ffff888331aff348 R15: ffff8881072=
56100
[ 1909.989434] FS:  0000000000000000(0000) GS:ffff88840edc0000(0000) knlGS:=
0000000000000000
[ 1909.989437] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1909.989440] CR2: 00007f295eac7000 CR3: 0000000004010003 CR4: 00000000001=
706e0
[ 1909.989442] Call Trace:
[ 1909.989444]  <TASK>
[ 1909.989447]  mod_delayed_work_on+0x49/0x70
[ 1909.989450]  nfsd_courtesy_client_count+0x24/0x50 [nfsd]
[ 1909.989467]  shrink_slab.constprop.92+0x9d/0x370
[ 1909.989471]  shrink_node+0x1c5/0x420
[ 1909.989475]  balance_pgdat+0x25f/0x530
[ 1909.989479]  ? prepare_to_wait_event+0x120/0x120
[ 1909.989484]  kswapd+0x12c/0x360
[ 1909.989487]  ? prepare_to_wait_event+0x120/0x120
[ 1909.989491]  ? balance_pgdat+0x530/0x530
[ 1909.989495]  kthread+0xec/0x110
[ 1909.989498]  ? kthread_complete_and_exit+0x20/0x20
[ 1909.989501]  ret_from_fork+0x1f/0x30
[ 1909.989505]  </TASK>
[ 1909.989507] ---[ end trace 0000000000000000 ]---
[ 1909.989511] ------------[ cut here ]------------
[ 1909.989514] WARNING: CPU: 7 PID: 78 at kernel/workqueue.c:1500 __queue_w=
ork+0x33b/0x3d0
[ 1909.989518] Modules linked in: netconsole(E) af_packet(E) ip6table_mangl=
e(E) ip6table_raw(E) iptable_raw(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) i=
scsi_boot_sysfs(E) rfkill(E) nfnetlink(E) ebtable_filter(E) ebtables(E) ip6=
table_filter(E) ip6_tables(E) iptable_filter(E) bpfilter(E) usblp(E) joydev=
(E) intel_rapl_msr(E) intel_rapl_common(E) snd_hda_codec_realtek(E) snd_hda=
_codec_generic(E) ledtrig_audio(E) snd_hda_codec_hdmi(E) x86_pkg_temp_therm=
al(E) intel_powerclamp(E) coretemp(E) snd_hda_intel(E) snd_intel_dspcfg(E) =
iTCO_wdt(E) at24(E) intel_pmc_bxt(E) regmap_i2c(E) mei_hdcp(E) iTCO_vendor_=
support(E) kvm_intel(E) snd_hda_codec(E) nls_iso8859_1(E) snd_hwdep(E) nls_=
cp437(E) snd_hda_core(E) kvm(E) snd_pcm(E) r8169(E) irqbypass(E) snd_timer(=
E) i2c_i801(E) realtek(E) pcspkr(E) mei_me(E) mdio_devres(E) i2c_smbus(E) s=
nd(E) lpc_ich(E) mfd_core(E) libphy(E) soundcore(E) mei(E) thermal(E) fan(E=
) intel_smartconnect(E) nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E)=
 sch_fq_codel(E) sunrpc(E)
[ 1909.989543]  fuse(E) configfs(E) ip_tables(E) x_tables(E) hid_logitech_h=
idpp(E) hid_logitech_dj(E) uas(E) usb_storage(E) hid_generic(E) usbhid(E) n=
ouveau(E) i2c_algo_bit(E) drm_ttm_helper(E) ttm(E) drm_display_helper(E) cr=
ct10dif_pclmul(E) crc32_pclmul(E) drm_kms_helper(E) ghash_clmulni_intel(E) =
sha512_ssse3(E) syscopyarea(E) sha512_generic(E) sysfillrect(E) xhci_pci(E)=
 sysimgblt(E) ahci(E) ehci_pci(E) aesni_intel(E) fb_sys_fops(E) crypto_simd=
(E) libahci(E) cryptd(E) xhci_hcd(E) ehci_hcd(E) drm(E) libata(E) cec(E) us=
bcore(E) usb_common(E) rc_core(E) video(E) wmi(E) button(E) sd_mod(E) t10_p=
i(E) crc64_rocksoft_generic(E) crc64_rocksoft(E) crc64(E) vfat(E) fat(E) vi=
rtio_blk(E) virtio_mmio(E) virtio(E) virtio_ring(E) ext4(E) crc32c_intel(E)=
 crc16(E) mbcache(E) jbd2(E) loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_d=
h_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E) =
efivarfs(E) autofs4(E)
[ 1909.989585] CPU: 7 PID: 78 Comm: kswapd0 Kdump: loaded Tainted: G       =
 W   E      6.1.1-smpxx #8
[ 1909.989588] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[ 1909.989590] RIP: 0010:__queue_work+0x33b/0x3d0
[ 1909.989594] Code: 25 00 cd 01 00 f6 47 2c 20 74 18 e8 5f 65 00 00 48 85 =
c0 74 0e 48 8b 40 20 48 3b 68 08 0f 84 f5 fc ff ff 0f 0b e9 fe fd ff ff <0f=
> 0b e9 ee fd ff ff 83 c9 02 49 8d 57 68 e9 d7 fd ff ff 80 3d c3
[ 1909.989597] RSP: 0018:ffff888100ec7c38 EFLAGS: 00010003
[ 1909.989674] RAX: ffff8883a3ba7b50 RBX: ffffffff820c4860 RCX: 00000000000=
00000
[ 1909.989676] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8881000=
70000
[ 1909.989679] RBP: ffff88818118d400 R08: ffff888100400028 R09: ffff8881004=
00000
[ 1909.989682] R10: 0000000000000000 R11: ffffffff8225f318 R12: 00000000000=
00008
[ 1909.989684] R13: 0000000000000007 R14: ffff8883a3ba7b48 R15: ffff8881072=
56100
[ 1909.989687] FS:  0000000000000000(0000) GS:ffff88840edc0000(0000) knlGS:=
0000000000000000
[ 1909.989690] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1909.989693] CR2: 00007f295eac7000 CR3: 0000000004010003 CR4: 00000000001=
706e0
[ 1909.989695] Call Trace:
[ 1909.989698]  <TASK>
[ 1909.989700]  mod_delayed_work_on+0x49/0x70
[ 1909.989704]  nfsd_courtesy_client_count+0x24/0x50 [nfsd]
[ 1909.989721]  shrink_slab.constprop.92+0x9d/0x370
[ 1909.989725]  shrink_node+0x1c5/0x420
[ 1909.989729]  balance_pgdat+0x25f/0x530
[ 1909.989733]  ? prepare_to_wait_event+0x120/0x120
[ 1909.989737]  kswapd+0x12c/0x360
[ 1909.989741]  ? prepare_to_wait_event+0x120/0x120
[ 1909.989745]  ? balance_pgdat+0x530/0x530
[ 1909.989749]  kthread+0xec/0x110
[ 1909.989751]  ? kthread_complete_and_exit+0x20/0x20
[ 1909.989755]  ret_from_fork+0x1f/0x30
[ 1909.989759]  </TASK>
[ 1909.989761] ---[ end trace 0000000000000000 ]---
[ 1909.989765] ------------[ cut here ]------------
[ 1909.989767] WARNING: CPU: 7 PID: 78 at kernel/workqueue.c:1500 __queue_w=
ork+0x33b/0x3d0
[ 1909.989771] Modules linked in: netconsole(E) af_packet(E) ip6table_mangl=
e(E) ip6table_raw(E) iptable_raw(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) i=
scsi_boot_sysfs(E) rfkill(E) nfnetlink(E) ebtable_filter(E) ebtables(E) ip6=
table_filter(E) ip6_tables(E) iptable_filter(E) bpfilter(E) usblp(E) joydev=
(E) intel_rapl_msr(E) intel_rapl_common(E) snd_hda_codec_realtek(E) snd_hda=
_codec_generic(E) ledtrig_audio(E) snd_hda_codec_hdmi(E) x86_pkg_temp_therm=
al(E) intel_powerclamp(E) coretemp(E) snd_hda_intel(E) snd_intel_dspcfg(E) =
iTCO_wdt(E) at24(E) intel_pmc_bxt(E) regmap_i2c(E) mei_hdcp(E) iTCO_vendor_=
support(E) kvm_intel(E) snd_hda_codec(E) nls_iso8859_1(E) snd_hwdep(E) nls_=
cp437(E) snd_hda_core(E) kvm(E) snd_pcm(E) r8169(E) irqbypass(E) snd_timer(=
E) i2c_i801(E) realtek(E) pcspkr(E) mei_me(E) mdio_devres(E) i2c_smbus(E) s=
nd(E) lpc_ich(E) mfd_core(E) libphy(E) soundcore(E) mei(E) thermal(E) fan(E=
) intel_smartconnect(E) nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E)=
 sch_fq_codel(E) sunrpc(E)
[ 1909.989796]  fuse(E) configfs(E) ip_tables(E) x_tables(E) hid_logitech_h=
idpp(E) hid_logitech_dj(E) uas(E) usb_storage(E) hid_generic(E) usbhid(E) n=
ouveau(E) i2c_algo_bit(E) drm_ttm_helper(E) ttm(E) drm_display_helper(E) cr=
ct10dif_pclmul(E) crc32_pclmul(E) drm_kms_helper(E) ghash_clmulni_intel(E) =
sha512_ssse3(E) syscopyarea(E) sha512_generic(E) sysfillrect(E) xhci_pci(E)=
 sysimgblt(E) ahci(E) ehci_pci(E) aesni_intel(E) fb_sys_fops(E) crypto_simd=
(E) libahci(E) cryptd(E) xhci_hcd(E) ehci_hcd(E) drm(E) libata(E) cec(E) us=
bcore(E) usb_common(E) rc_core(E) video(E) wmi(E) button(E) sd_mod(E) t10_p=
i(E) crc64_rocksoft_generic(E) crc64_rocksoft(E) crc64(E) vfat(E) fat(E) vi=
rtio_blk(E) virtio_mmio(E) virtio(E) virtio_ring(E) ext4(E) crc32c_intel(E)=
 crc16(E) mbcache(E) jbd2(E) loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_d=
h_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E) =
efivarfs(E) autofs4(E)
[ 1909.989838] CPU: 7 PID: 78 Comm: kswapd0 Kdump: loaded Tainted: G       =
 W   E      6.1.1-smpxx #8
[ 1909.989841] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[ 1909.989844] RIP: 0010:__queue_work+0x33b/0x3d0
[ 1909.989847] Code: 25 00 cd 01 00 f6 47 2c 20 74 18 e8 5f 65 00 00 48 85 =
c0 74 0e 48 8b 40 20 48 3b 68 08 0f 84 f5 fc ff ff 0f 0b e9 fe fd ff ff <0f=
> 0b e9 ee fd ff ff 83 c9 02 49 8d 57 68 e9 d7 fd ff ff 80 3d c3
[ 1909.989851] RSP: 0018:ffff888100ec7c38 EFLAGS: 00010003
[ 1909.989854] RAX: ffff8881737c2f50 RBX: ffffffff820c4860 RCX: 00000000000=
00000
[ 1909.989857] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8881000=
70000
[ 1909.989859] RBP: ffff88818118d400 R08: ffff888100400028 R09: ffff8881004=
00000
[ 1909.989862] R10: 0000000000000000 R11: ffffffff8225f318 R12: 00000000000=
00008
[ 1909.989865] R13: 0000000000000007 R14: ffff8881737c2f48 R15: ffff8881072=
56100
[ 1909.989867] FS:  0000000000000000(0000) GS:ffff88840edc0000(0000) knlGS:=
0000000000000000
[ 1909.989870] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1909.989873] CR2: 00007f295eac7000 CR3: 0000000004010003 CR4: 00000000001=
706e0
[ 1909.989876] Call Trace:
[ 1909.989878]  <TASK>
[ 1909.989880]  mod_delayed_work_on+0x49/0x70
[ 1909.989884]  nfsd_courtesy_client_count+0x24/0x50 [nfsd]
[ 1909.989901]  shrink_slab.constprop.92+0x9d/0x370
[ 1909.989905]  shrink_node+0x1c5/0x420
[ 1909.989909]  balance_pgdat+0x25f/0x530
[ 1909.989913]  ? prepare_to_wait_event+0x120/0x120
[ 1909.989917]  kswapd+0x12c/0x360
[ 1909.989921]  ? prepare_to_wait_event+0x120/0x120
[ 1909.989925]  ? balance_pgdat+0x530/0x530
[ 1909.989929]  kthread+0xec/0x110
[ 1909.989932]  ? kthread_complete_and_exit+0x20/0x20
[ 1909.989935]  ret_from_fork+0x1f/0x30
[ 1909.989939]  </TASK>
[ 1909.989941] ---[ end trace 0000000000000000 ]---
[ 1909.989946] ------------[ cut here ]------------
[ 1909.989948] WARNING: CPU: 7 PID: 78 at kernel/workqueue.c:1500 __queue_w=
ork+0x33b/0x3d0
[ 1909.989952] Modules linked in: netconsole(E) af_packet(E) ip6table_mangl=
e(E) ip6table_raw(E) iptable_raw(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) i=
scsi_boot_sysfs(E) rfkill(E) nfnetlink(E) ebtable_filter(E) ebtables(E) ip6=
table_filter(E) ip6_tables(E) iptable_filter(E) bpfilter(E) usblp(E) joydev=
(E) intel_rapl_msr(E) intel_rapl_common(E) snd_hda_codec_realtek(E) snd_hda=
_codec_generic(E) ledtrig_audio(E) snd_hda_codec_hdmi(E) x86_pkg_temp_therm=
al(E) intel_powerclamp(E) coretemp(E) snd_hda_intel(E) snd_intel_dspcfg(E) =
iTCO_wdt(E) at24(E) intel_pmc_bxt(E) regmap_i2c(E) mei_hdcp(E) iTCO_vendor_=
support(E) kvm_intel(E) snd_hda_codec(E) nls_iso8859_1(E) snd_hwdep(E) nls_=
cp437(E) snd_hda_core(E) kvm(E) snd_pcm(E) r8169(E) irqbypass(E) snd_timer(=
E) i2c_i801(E) realtek(E) pcspkr(E) mei_me(E) mdio_devres(E) i2c_smbus(E) s=
nd(E) lpc_ich(E) mfd_core(E) libphy(E) soundcore(E) mei(E) thermal(E) fan(E=
) intel_smartconnect(E) nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E)=
 sch_fq_codel(E) sunrpc(E)
[ 1909.989977]  fuse(E) configfs(E) ip_tables(E) x_tables(E) hid_logitech_h=
idpp(E) hid_logitech_dj(E) uas(E) usb_storage(E) hid_generic(E) usbhid(E) n=
ouveau(E) i2c_algo_bit(E) drm_ttm_helper(E) ttm(E) drm_display_helper(E) cr=
ct10dif_pclmul(E) crc32_pclmul(E) drm_kms_helper(E) ghash_clmulni_intel(E) =
sha512_ssse3(E) syscopyarea(E) sha512_generic(E) sysfillrect(E) xhci_pci(E)=
 sysimgblt(E) ahci(E) ehci_pci(E) aesni_intel(E) fb_sys_fops(E) crypto_simd=
(E) libahci(E) cryptd(E) xhci_hcd(E) ehci_hcd(E) drm(E) libata(E) cec(E) us=
bcore(E) usb_common(E) rc_core(E) video(E) wmi(E) button(E) sd_mod(E) t10_p=
i(E) crc64_rocksoft_generic(E) crc64_rocksoft(E) crc64(E) vfat(E) fat(E) vi=
rtio_blk(E) virtio_mmio(E) virtio(E) virtio_ring(E) ext4(E) crc32c_intel(E)=
 crc16(E) mbcache(E) jbd2(E) loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_d=
h_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E) =
efivarfs(E) autofs4(E)
[ 1909.990020] CPU: 7 PID: 78 Comm: kswapd0 Kdump: loaded Tainted: G       =
 W   E      6.1.1-smpxx #8
[ 1909.990023] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[ 1909.990025] RIP: 0010:__queue_work+0x33b/0x3d0
[ 1909.990029] Code: 25 00 cd 01 00 f6 47 2c 20 74 18 e8 5f 65 00 00 48 85 =
c0 74 0e 48 8b 40 20 48 3b 68 08 0f 84 f5 fc ff ff 0f 0b e9 fe fd ff ff <0f=
> 0b e9 ee fd ff ff 83 c9 02 49 8d 57 68 e9 d7 fd ff ff 80 3d c3
[ 1909.990033] RSP: 0018:ffff888100ec7c38 EFLAGS: 00010003
[ 1909.990035] RAX: ffff888354cb7f50 RBX: ffffffff820c4860 RCX: 00000000000=
00000
[ 1909.990038] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8881000=
70000
[ 1909.990041] RBP: ffff88818118d400 R08: ffff888100400028 R09: ffff8881004=
00000
[ 1909.990043] R10: 0000000000000000 R11: ffffffff8225f318 R12: 00000000000=
00008
[ 1909.990046] R13: 0000000000000007 R14: ffff888354cb7f48 R15: ffff8881072=
56100
[ 1909.990049] FS:  0000000000000000(0000) GS:ffff88840edc0000(0000) knlGS:=
0000000000000000
[ 1909.990052] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1909.990054] CR2: 00007f295eac7000 CR3: 0000000004010003 CR4: 00000000001=
706e0
[ 1909.990057] Call Trace:
[ 1909.990059]  <TASK>
[ 1909.990061]  mod_delayed_work_on+0x49/0x70
[ 1909.990065]  nfsd_courtesy_client_count+0x24/0x50 [nfsd]
[ 1909.990081]  shrink_slab.constprop.92+0x9d/0x370
[ 1909.990085]  shrink_node+0x1c5/0x420
[ 1909.990089]  balance_pgdat+0x25f/0x530
[ 1909.990093]  ? prepare_to_wait_event+0x120/0x120
[ 1909.990097]  kswapd+0x12c/0x360
[ 1909.990101]  ? prepare_to_wait_event+0x120/0x120
[ 1909.990105]  ? balance_pgdat+0x530/0x530
[ 1909.990108]  kthread+0xec/0x110
[ 1909.990111]  ? kthread_complete_and_exit+0x20/0x20
[ 1909.990114]  ret_from_fork+0x1f/0x30
[ 1909.990119]  </TASK>
[ 1909.990121] ---[ end trace 0000000000000000 ]---
[ 1943.085109] sysrq: Resetting

