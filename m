Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB67873ECAF
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jun 2023 23:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjFZVMb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Jun 2023 17:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFZVMa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Jun 2023 17:12:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2470DE4D
        for <linux-nfs@vger.kernel.org>; Mon, 26 Jun 2023 14:12:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3A5760F59
        for <linux-nfs@vger.kernel.org>; Mon, 26 Jun 2023 21:12:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F17C433C8;
        Mon, 26 Jun 2023 21:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687813945;
        bh=qSwvirVSiix96WROyQPMZo4TrKKCLKv3Rx6ynb0C/WQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LaToTG8jh+1sVpkx4YrVfMx3Dh1+eG8i1Wih2dayAMrHDOHViVorj+siZUMWODObj
         hrlD6uP/O25ySjrg2R5QsL5ll5rqn+SgvWXyw6Vc5RoGNw5M8XnNcHpHa17P0zxorV
         XhUjYH20cLLQvZTAcT2QwFrhsbP21Fbsirmb1Vky+GGJmVjFcZdeVJOMGiz3dWMJMB
         9IuyFNbBRZ8hC6MX5aWBYFzEDFWAw5SMfQRGXEC9FXr91RxfqK+Xs/rdOB7Pazkp6l
         hJk6xdM9khJkHmHl4AxS2cNeBR+0RrEFxoo0pV/ZyRsy2V5jnWvP7+I6Hhqh4pB3pA
         fm6QYXP6BEtLQ==
Date:   Mon, 26 Jun 2023 14:12:23 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 05/11] NFS: add superblock sysfs entries
Message-ID: <20230626211223.GA3771155@dev-arch.thelio-3990X>
References: <cover.1686851158.git.bcodding@redhat.com>
 <095dda5e682c8367335b9fa448f2834b9435ee69.1686851158.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <095dda5e682c8367335b9fa448f2834b9435ee69.1686851158.git.bcodding@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Benjamin,

On Thu, Jun 15, 2023 at 02:07:26PM -0400, Benjamin Coddington wrote:
> Create a sysfs directory for each mount that corresponds to the mount's
> nfs_server struct.  As the mount is being constructed, use the name
> "server-n", but rename it to the "MAJOR:MINOR" of the mount after assigni=
ng
> a device_id. The rename approach allows us to populate the mount's direct=
ory
> with links to the various rpc_client objects during the mount's
> construction.  The naming convention (MAJOR:MINOR) can be used to referen=
ce
> a particular NFS mount's sysfs tree.
>=20
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>

I am not sure if this has been reported or fixed already, so I apologize
if this is a duplicate. After this change landed in -next as commit
1c7251187dc0 ("NFS: add superblock sysfs entries"), I see the following
splat when accessing a NFS server:

[   21.180403] RPC: Registered named UNIX socket transport module.
[   21.180407] RPC: Registered udp transport module.
[   21.180407] RPC: Registered tcp transport module.
[   21.180408] RPC: Registered tcp-with-tls transport module.
[   21.180408] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   21.210652] Key type dns_resolver registered
[   21.297136] NFS: Registering the id_resolver key type
[   21.297140] Key type id_resolver registered
[   21.297140] Key type id_legacy registered
[   21.322237] ------------[ cut here ]------------
[   21.322238] kobject: '(null)' (000000000804ef51): is not initialized, ye=
t kobject_put() is being called.
[   21.322246] WARNING: CPU: 0 PID: 2501 at lib/kobject.c:728 kobject_put+0=
xc1/0x1d0
[   21.322251] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_res=
olver nfs lockd grace sunrpc fscache netfs overlay xt_mark snd_seq_dummy sn=
d_hrtimer snd_seq snd_seq_device tun hid_logitech_hidpp mousedev joydev xt_=
CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp nft=
_compat nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_=
tables nfnetlink bridge stp llc hid_logitech_dj hid_razer snd_hda_codec_hdm=
i snd_hda_codec_realtek snd_hda_codec_generic vfat fat snd_sof_pci_intel_tg=
l snd_sof_intel_hda_common snd_soc_hdac_hda snd_sof_pci snd_sof_xtensa_dsp =
snd_sof_intel_hda_mlink snd_sof_intel_hda intel_rapl_msr snd_sof intel_rapl=
_common x86_pkg_temp_thermal snd_sof_utils intel_powerclamp snd_hda_ext_cor=
e i915 snd_soc_acpi_intel_match snd_soc_acpi snd_soc_core coretemp snd_comp=
ress eeepc_wmi kvm_intel asus_wmi snd_hda_intel i2c_algo_bit mei_hdcp mei_p=
xp ledtrig_audio usbhid snd_intel_dspcfg drm_buddy sparse_keymap kvm snd_hd=
a_codec iTCO_wdt platform_profile ee1004 intel_pmc_bxt rfkill
[   21.322304]  snd_hwdep intel_gtt iTCO_vendor_support irqbypass wmi_bmof =
snd_hda_core crct10dif_pclmul drm_display_helper crc32_pclmul polyval_clmul=
ni polyval_generic drm_kms_helper snd_pcm gf128mul syscopyarea ghash_clmuln=
i_intel sysfillrect sha512_ssse3 sysimgblt snd_timer aesni_intel video cryp=
to_simd cryptd intel_cstate intel_uncore spi_nor snd intel_lpss_pci mei_me =
pcspkr intel_lpss cec i2c_i801 e1000e mtd i2c_smbus mei soundcore ttm idma6=
4 wmi acpi_pad acpi_tad mac_hid pkcs8_key_parser dm_multipath drm crypto_us=
er fuse dm_mod loop zram bpf_preload ip_tables x_tables nvme nvme_core spi_=
intel_pci xhci_pci spi_intel xhci_pci_renesas nvme_common btrfs blake2b_gen=
eric libcrc32c crc32c_generic crc32c_intel xor raid6_pq
[   21.322331] CPU: 0 PID: 2501 Comm: mount.nfs Not tainted 6.4.0-rc7-debug=
-00022-g1c7251187dc0 #1 650a78de916f9c7b93e3e16eabf8ef901a04fe73
[   21.322333] Hardware name: ASUS System Product Name/PRIME Z590M-PLUS, BI=
OS 1203 10/27/2021
[   21.322334] RIP: 0010:kobject_put+0xc1/0x1d0
[   21.322347] Code: 00 4c 89 ef e8 00 c8 65 ff 48 85 db 74 9a f6 43 3c 01 =
0f 85 78 ff ff ff 48 8b 33 48 89 da 48 c7 c7 e0 91 a6 90 e8 7f 7c 40 ff <0f=
> 0b e9 5f ff ff ff c3 cc cc cc cc 4d 89 f1 49 c7 c0 d0 9b 61 90
[   21.322349] RSP: 0018:ffffa94f44e93d50 EFLAGS: 00010286
[   21.322350] RAX: 0000000000000000 RBX: ffff93d852edfc48 RCX: 00000000000=
00027
[   21.322351] RDX: ffff93df7f421688 RSI: 0000000000000001 RDI: ffff93df7f4=
21680
[   21.322352] RBP: 00000000ffffffff R08: 0000000000000000 R09: ffffa94f44e=
93be0
[   21.322353] R10: 0000000000000003 R11: ffffffff910ca808 R12: 00000000fff=
fffa3
[   21.322353] R13: ffffa94f44e93d90 R14: ffff93d8a96c1000 R15: 00000000000=
00000
[   21.322354] FS:  00007f6f56579740(0000) GS:ffff93df7f400000(0000) knlGS:=
0000000000000000
[   21.322355] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   21.322356] CR2: 00007f0c3e6eaa48 CR3: 00000001793a2005 CR4: 00000000007=
70ef0
[   21.322357] PKRU: 55555554
[   21.322358] Call Trace:
[   21.322359]  <TASK>
[   21.322360]  ? kobject_put+0xc1/0x1d0
[   21.322362]  ? __warn+0x81/0x130
[   21.322365]  ? kobject_put+0xc1/0x1d0
[   21.322367]  ? report_bug+0x171/0x1a0
[   21.322376]  ? prb_read_valid+0x1b/0x30
[   21.322379]  ? handle_bug+0x3c/0x80
[   21.322382]  ? exc_invalid_op+0x17/0x70
[   21.322384]  ? asm_exc_invalid_op+0x1a/0x20
[   21.322387]  ? kobject_put+0xc1/0x1d0
[   21.322390]  nfs_free_server+0x6b/0xe0 [nfs 624204e86a6049542d6fb7844efc=
3f7da8452ecc]
[   21.322408]  nfs4_create_server+0x234/0x350 [nfsv4 c1cc88cc5dfaa7ab85ce3=
3d7e154b7db9d5a5f0d]
[   21.322443]  nfs4_try_get_tree+0x37/0xd0 [nfsv4 c1cc88cc5dfaa7ab85ce33d7=
e154b7db9d5a5f0d]
[   21.322470]  vfs_get_tree+0x26/0xd0
[   21.322473]  path_mount+0x4a1/0xae0
[   21.322476]  __x64_sys_mount+0x11a/0x150
[   21.322477]  do_syscall_64+0x5d/0x90
[   21.322480]  ? syscall_exit_to_user_mode+0x1b/0x40
[   21.322482]  ? do_syscall_64+0x6c/0x90
[   21.322484]  ? exc_page_fault+0x7f/0x180
[   21.322486]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   21.322489] RIP: 0033:0x7f6f5684f08e
[   21.322509] Code: 48 8b 0d cd ec 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 =
2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 9a ec 0c 00 f7 d8 64 89 01 48
[   21.322510] RSP: 002b:00007ffc781debe8 EFLAGS: 00000246 ORIG_RAX: 000000=
00000000a5
[   21.322512] RAX: ffffffffffffffda RBX: 00007ffc781dee10 RCX: 00007f6f568=
4f08e
[   21.322512] RDX: 0000560364a99a10 RSI: 0000560364a999f0 RDI: 0000560364a=
99880
[   21.322513] RBP: 0000560364a99da0 R08: 0000560364a99da0 R09: 00000000000=
00060
[   21.322514] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc781=
dee10
[   21.322514] R13: 0000560364a99d60 R14: 0000000000000004 R15: 0000560362f=
49927
[   21.322516]  </TASK>
[   21.322517] ---[ end trace 0000000000000000 ]---
[   21.322518] ------------[ cut here ]------------
[   21.322518] refcount_t: underflow; use-after-free.
[   21.322522] WARNING: CPU: 0 PID: 2501 at lib/refcount.c:28 refcount_warn=
_saturate+0xbe/0x110
[   21.322525] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_res=
olver nfs lockd grace sunrpc fscache netfs overlay xt_mark snd_seq_dummy sn=
d_hrtimer snd_seq snd_seq_device tun hid_logitech_hidpp mousedev joydev xt_=
CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp nft=
_compat nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_=
tables nfnetlink bridge stp llc hid_logitech_dj hid_razer snd_hda_codec_hdm=
i snd_hda_codec_realtek snd_hda_codec_generic vfat fat snd_sof_pci_intel_tg=
l snd_sof_intel_hda_common snd_soc_hdac_hda snd_sof_pci snd_sof_xtensa_dsp =
snd_sof_intel_hda_mlink snd_sof_intel_hda intel_rapl_msr snd_sof intel_rapl=
_common x86_pkg_temp_thermal snd_sof_utils intel_powerclamp snd_hda_ext_cor=
e i915 snd_soc_acpi_intel_match snd_soc_acpi snd_soc_core coretemp snd_comp=
ress eeepc_wmi kvm_intel asus_wmi snd_hda_intel i2c_algo_bit mei_hdcp mei_p=
xp ledtrig_audio usbhid snd_intel_dspcfg drm_buddy sparse_keymap kvm snd_hd=
a_codec iTCO_wdt platform_profile ee1004 intel_pmc_bxt rfkill
[   21.322551]  snd_hwdep intel_gtt iTCO_vendor_support irqbypass wmi_bmof =
snd_hda_core crct10dif_pclmul drm_display_helper crc32_pclmul polyval_clmul=
ni polyval_generic drm_kms_helper snd_pcm gf128mul syscopyarea ghash_clmuln=
i_intel sysfillrect sha512_ssse3 sysimgblt snd_timer aesni_intel video cryp=
to_simd cryptd intel_cstate intel_uncore spi_nor snd intel_lpss_pci mei_me =
pcspkr intel_lpss cec i2c_i801 e1000e mtd i2c_smbus mei soundcore ttm idma6=
4 wmi acpi_pad acpi_tad mac_hid pkcs8_key_parser dm_multipath drm crypto_us=
er fuse dm_mod loop zram bpf_preload ip_tables x_tables nvme nvme_core spi_=
intel_pci xhci_pci spi_intel xhci_pci_renesas nvme_common btrfs blake2b_gen=
eric libcrc32c crc32c_generic crc32c_intel xor raid6_pq
[   21.322573] CPU: 0 PID: 2501 Comm: mount.nfs Tainted: G        W        =
  6.4.0-rc7-debug-00022-g1c7251187dc0 #1 650a78de916f9c7b93e3e16eabf8ef901a=
04fe73
[   21.322574] Hardware name: ASUS System Product Name/PRIME Z590M-PLUS, BI=
OS 1203 10/27/2021
[   21.322575] RIP: 0010:refcount_warn_saturate+0xbe/0x110
[   21.322576] Code: 01 01 e8 d5 e0 a9 ff 0f 0b c3 cc cc cc cc 80 3d 82 f5 =
7a 01 00 75 85 48 c7 c7 f0 eb a0 90 c6 05 72 f5 7a 01 01 e8 b2 e0 a9 ff <0f=
> 0b c3 cc cc cc cc 80 3d 60 f5 7a 01 00 0f 85 5e ff ff ff 48 c7
[   21.322577] RSP: 0018:ffffa94f44e93d78 EFLAGS: 00010286
[   21.322578] RAX: 0000000000000000 RBX: ffff93d852edf800 RCX: 00000000000=
00027
[   21.322579] RDX: ffff93df7f421688 RSI: 0000000000000001 RDI: ffff93df7f4=
21680
[   21.322580] RBP: ffffffffffffffa3 R08: 0000000000000000 R09: ffffa94f44e=
93c08
[   21.322580] R10: 0000000000000003 R11: ffffffff910ca808 R12: 00000000fff=
fffa3
[   21.322581] R13: ffffa94f44e93d90 R14: ffff93d8a96c1000 R15: 00000000000=
00000
[   21.322582] FS:  00007f6f56579740(0000) GS:ffff93df7f400000(0000) knlGS:=
0000000000000000
[   21.322583] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   21.322584] CR2: 00007f0c3e6eaa48 CR3: 00000001793a2005 CR4: 00000000007=
70ef0
[   21.322584] PKRU: 55555554
[   21.322585] Call Trace:
[   21.322585]  <TASK>
[   21.322586]  ? refcount_warn_saturate+0xbe/0x110
[   21.322587]  ? __warn+0x81/0x130
[   21.322589]  ? refcount_warn_saturate+0xbe/0x110
[   21.322591]  ? report_bug+0x171/0x1a0
[   21.322592]  ? prb_read_valid+0x1b/0x30
[   21.322595]  ? handle_bug+0x3c/0x80
[   21.322597]  ? exc_invalid_op+0x17/0x70
[   21.322599]  ? asm_exc_invalid_op+0x1a/0x20
[   21.322600]  ? refcount_warn_saturate+0xbe/0x110
[   21.322602]  ? refcount_warn_saturate+0xbe/0x110
[   21.322604]  nfs_free_server+0x6b/0xe0 [nfs 624204e86a6049542d6fb7844efc=
3f7da8452ecc]
[   21.322621]  nfs4_create_server+0x234/0x350 [nfsv4 c1cc88cc5dfaa7ab85ce3=
3d7e154b7db9d5a5f0d]
[   21.322650]  nfs4_try_get_tree+0x37/0xd0 [nfsv4 c1cc88cc5dfaa7ab85ce33d7=
e154b7db9d5a5f0d]
[   21.322675]  vfs_get_tree+0x26/0xd0
[   21.322677]  path_mount+0x4a1/0xae0
[   21.322679]  __x64_sys_mount+0x11a/0x150
[   21.322681]  do_syscall_64+0x5d/0x90
[   21.322683]  ? syscall_exit_to_user_mode+0x1b/0x40
[   21.322685]  ? do_syscall_64+0x6c/0x90
[   21.322686]  ? exc_page_fault+0x7f/0x180
[   21.322688]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   21.322691] RIP: 0033:0x7f6f5684f08e
[   21.322696] Code: 48 8b 0d cd ec 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 =
2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 9a ec 0c 00 f7 d8 64 89 01 48
[   21.322697] RSP: 002b:00007ffc781debe8 EFLAGS: 00000246 ORIG_RAX: 000000=
00000000a5
[   21.322698] RAX: ffffffffffffffda RBX: 00007ffc781dee10 RCX: 00007f6f568=
4f08e
[   21.322699] RDX: 0000560364a99a10 RSI: 0000560364a999f0 RDI: 0000560364a=
99880
[   21.322699] RBP: 0000560364a99da0 R08: 0000560364a99da0 R09: 00000000000=
00060
[   21.322700] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc781=
dee10
[   21.322701] R13: 0000560364a99d60 R14: 0000000000000004 R15: 0000560362f=
49927
[   21.322702]  </TASK>
[   21.322703] ---[ end trace 0000000000000000 ]---

The configuration is just Arch Linux's (run through olddefconfig), in
case it is relevant:

https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/raw/main/=
config

If there is any other information I can provide or patches I can test, I
am more than happy to do so.

Cheers,
Nathan
