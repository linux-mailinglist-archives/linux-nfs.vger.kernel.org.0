Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30C94F664B
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Apr 2022 19:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238262AbiDFREY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Apr 2022 13:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238272AbiDFRCT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Apr 2022 13:02:19 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D707217498
        for <linux-nfs@vger.kernel.org>; Wed,  6 Apr 2022 07:25:46 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:3030:2:1c98:2277:ba57:a2c0:5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id DBDBA1F43994
        for <linux-nfs@vger.kernel.org>; Wed,  6 Apr 2022 15:25:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649255145;
        bh=Ap1H4Ppc4RISIIw/I5+mJFxMrfXys0AEPYY7C6HzfPk=;
        h=Date:From:To:Subject:From;
        b=Z7YgZz1mdZimM1TMmENR4sunYOcMZSC8Mq7prLWC456HMSvQGWK6e8X2W7yzeltBG
         Xzpa6XhsvbZUG/iA/ZGbPh0ntJxh6Q2Fn+DxjGfuzeNDUvcwHw6kN239f0Z7W7qUnX
         rkdw2vhmJRht9xdvFpcu/mrYcY4XuOSd3tZwcfbVCME/Tb6lumvvAmBcmKO13tUlCH
         TCHn6izeoro7ZMkizYrekoqxWnWlzzHK+Poam79DcDeVu3RU4VYi/5oR8bJIQiC3jI
         j6HmZjsF7tUyC05RV9MxWBq3PS05F9MAy16INPNoZNHViUeno365pZ/Uqr+Fot4fq1
         N2eOhS1wvBhfA==
Date:   Wed, 6 Apr 2022 16:25:41 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     linux-nfs@vger.kernel.org
Subject: Possible NFS4 regression on 5.18-rc1
Message-ID: <20220406142541.eouf7ryfbd7aooye@basti-XPS-13-9310>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello folks,

I am currently developing a V4L2 driver with support on GStreamer, for
that purpose I am mounting the GStreamer repository via NFS from my
development machine to the target ARM64 hardware.

I just switched to the latest kernel and got a sudden hang up of my
system.
What I did was a rebase of the GStreamer repository and then I wanted to
build it with ninja on the target, this failed with a segmentation fault:
```
gstreamer| Configuring libgstreamer-1.0.so.0.2100.0-gdb.py using configurat=
ion
Segmentation fault
FAILED: build.ninja=20
/usr/local/bin/meson --internal regenerate /home/user/gstreamer_crossbuild =
/home/user/gstreamer_crossbuild/build --backend ninja
ninja: error: rebuilding 'build.ninja': subcommand FAILED
```

And on the kernel side I got a OOPS:

```
[ 4595.193433] Unable to handle kernel NULL pointer dereference at virtual =
address 0000000000000008
[ 4595.194259] Mem abort info:
[ 4595.194518]   ESR =3D 0x96000006
[ 4595.194857]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[ 4595.195343]   SET =3D 0, FnV =3D 0
[ 4595.195622]   EA =3D 0, S1PTW =3D 0
[ 4595.195908]   FSC =3D 0x06: level 2 translation fault
[ 4595.196348] Data abort info:
[ 4595.196610]   ISV =3D 0, ISS =3D 0x00000006
[ 4595.196958]   CM =3D 0, WnR =3D 0
[ 4595.197229] user pgtable: 4k pages, 48-bit VAs, pgdp=3D000000000450a000
[ 4595.197807] [0000000000000008] pgd=3D08000000f1812003, p4d=3D08000000f18=
12003, pud=3D08000000390bf003, pmd=3D0000000000000000
[ 4595.198793] Internal error: Oops: 96000006 [#1] PREEMPT SMP
[ 4595.199300] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4 nfs loc=
kd grace fscache netfs iptable_nat nf_nat iptable_mangle bpfilter iptable_f=
ilter btsdio ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_tcpudp=
  xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_compa=
t nf_tables nfnetlink hantro_vpu(C) rockchip_vdec(C) hci_uart v4l2_vp9 rock=
chip_rga v4l2_h264 btqca videobuf2_dma_contig brcmfmac videobuf2_dma_sg v4l=
2_mem2mem btrtl snd_soc_es8316 snd_soc_audio_graph_card videobuf2_memops bt=
bcm snd_soc_hdmi_codec snd_soc_simple_card snd_soc_rockchip_i2s snd_soc_spd=
if_tx brcmutil videobuf2_v4l2 snd_soc_simple_card_utils btintel videobuf2_c=
ommon snd_soc_core bluetooth cfg80211 snd_pcm_dmaengine videodev snd_pcm sn=
d_timer dw_hdmi_i2s_audio mc dw_hdmi_cec snd rfkill soundcore cpufreq_dt su=
nrpc ip_tables x_tables autofs4 cls_cgroup panfrost drm_shmem_helper gpu_sc=
hed rockchipdrm drm_cma_helper dw_hdmi dw_mipi_dsi analogix_dp drm_dp_helpe=
r drm_kms_helper cec rc_core
[ 4595.199702]  drm drm_panel_orientation_quirks realtek(E)
[ 4595.207759] CPU: 4 PID: 3716 Comm: meson Tainted: G         C  E     5.1=
8.0-rc1-rockpidebug2 #94
[ 4595.208532] Hardware name: Radxa ROCK Pi 4B (DT)
[ 4595.208938] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[ 4595.209552] pc : list_lru_add+0xd4/0x180
[ 4595.209907] lr : list_lru_add+0x15c/0x180
[ 4595.210263] sp : ffff80000b75bbf0
[ 4595.210556] x29: ffff80000b75bbf0 x28: ffff000005cd9d80 x27: ffff0000056=
92a10
[ 4595.211188] x26: 00000000000000f0 x25: ffff000001962000 x24: ffff8000018=
d7a80
[ 4595.211819] x23: 0000000000000000 x22: 0000000000000000 x21: 00000000000=
00000
[ 4595.212449] x20: ffff0000078fdc80 x19: ffff000013be8808 x18: 00000000000=
000c0
[ 4595.213080] x17: 0000000000000020 x16: fffffc0001028608 x15: fffffc00010=
28600
[ 4595.213710] x14: 1600000000000000 x13: 0000000000000008 x12: ffff0000f77=
df278
[ 4595.214339] x11: 0000000000000000 x10: ffff0000f77df258 x9 : ffff8000088=
1f12c
[ 4595.214970] x8 : ffff000001bbd300 x7 : 00000000ecc07b31 x6 : 00000000000=
00001
[ 4595.215600] x5 : ffff000001f04100 x4 : ffff80000b75bbb0 x3 : 00000000000=
00000
[ 4595.216229] x2 : 0000000000000001 x1 : 0000000000000000 x0 : 00000000000=
00000
[ 4595.216858] Call trace:
[ 4595.217077]  list_lru_add+0xd4/0x180
[ 4595.217396]  nfs4_xattr_get_cache+0x254/0x368 [nfsv4]
[ 4595.217910]  nfs4_xattr_cache_set_list+0x2c/0x138 [nfsv4]
[ 4595.218440]  nfs4_listxattr+0x208/0x228 [nfsv4]
[ 4595.218895]  vfs_listxattr+0x60/0xb0
[ 4595.219215]  listxattr+0x64/0x170
[ 4595.219510]  path_listxattr+0x70/0xc8
[ 4595.219835]  __arm64_sys_listxattr+0x28/0x38
[ 4595.220212]  invoke_syscall+0x4c/0x110
[ 4595.220547]  el0_svc_common.constprop.0+0x4c/0xf8
[ 4595.220963]  do_el0_svc+0x2c/0x90
[ 4595.221257]  el0_svc+0x2c/0x88
[ 4595.221532]  el0t_64_sync_handler+0xb0/0xb8
[ 4595.221900]  el0t_64_sync+0x18c/0x190
[ 4595.222227] Code: f9400317 8b1602f6 910022d7 aa1703e1 (f94006e0)=20
[ 4595.222763] ---[ end trace 0000000000000000 ]---
[ 4595.223179] note: meson[3716] exited with preempt_count 2
```

I tried to get more information from the address information of the dump
but sadly without success:
```
$ ./scripts/faddr2line fs/nfs/nfsv4.ko nfs4_xattr_get_cache+0x254/0x368=20
nfs4_xattr_get_cache+0x254/0x368:
addr2line: DWARF error: info pointer extends beyond end of attributes
addr2line: DWARF error: info pointer extends beyond end of attributes
addr2line: DWARF error: info pointer extends beyond end of attributes
addr2line: DWARF error: info pointer extends beyond end of attributes
addr2line: DWARF error: info pointer extends beyond end of attributes
addr2line: DWARF error: offset (2704378094) greater than or equal to .debug=
_str size (1786)
addr2line: DWARF error: info pointer extends beyond end of attributes
addr2line: DWARF error: info pointer extends beyond end of attributes
addr2line: DWARF error: info pointer extends beyond end of attributes
addr2line: DWARF error: info pointer extends beyond end of attributes
addr2line: DWARF error: offset (1670626809) greater than or equal to .debug=
_line size (450319)
nfs4_xattr_get_cache at nfs42xattr.c:?
```

(I probably did something wrong here :/)

I was still able to attempt a reboot, but the system hanged itself then
in an endless loop of interrupting self detected stalls and trying to
unmount the NFS directory:

https://paste.debian.net/1236971/

Thanks in advance :)

Greetings,
Sebastian
