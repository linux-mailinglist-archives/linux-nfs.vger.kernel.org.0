Return-Path: <linux-nfs+bounces-905-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 432A082373F
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jan 2024 22:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3EBB287930
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jan 2024 21:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1851D6BD;
	Wed,  3 Jan 2024 21:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERAyfNJ6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA7E1D6BC
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jan 2024 21:45:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23A9C433C9
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jan 2024 21:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704318336;
	bh=sGGd315lbvPKbNrZgyCnbBYudEYPnNCTTvaZDmZ4Y0Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ERAyfNJ6TEyEZCbbrv1QaxHNic8S3EjdrVQBIacaGZH8vV5oSVPuz2apc3dhtVj/2
	 bhFltczY/WGRRjrKKUgjieEv/4cuK/LEylYN1lbVOZePSaOL3cNzKPOCMi2XCK/0/R
	 4NFalMCul2WGFAkd9WXsvegg3TuuNp8FCHIJtv++pQca6IJVornFF6s8IwiA+H2eS/
	 A0f0Kp7fVVY0lnWnRML86bPVZepvPIHXftY+BeuopXe15AkfBS+XMEnc6pTZ6MKUOv
	 awvMIoliqGSOELK6A8/LHwhBnwJuFqxZEb7EDvwNZeE8rWK9gO8ICYkn/B6l66Zhso
	 viWHY4CLDXnTw==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6dbaf9b1674so6537599a34.2
        for <linux-nfs@vger.kernel.org>; Wed, 03 Jan 2024 13:45:36 -0800 (PST)
X-Gm-Message-State: AOJu0Yyrw2cg7FmW3cXZnzpBOz6jDQ9lUWAWmXhwIyVWX+VMFTpAc635
	DrSVkKxn2Y8v/QWI1yZE6ZTuGB7KvOIbC/rCujQ=
X-Google-Smtp-Source: AGHT+IG7LRTAUSJLb8vTU5+oIZHMDXTwvQCmUgVAV+UNx0Kx0P2nOpxB0PGApp4Jx5L9ZsAVzu4d+FeZv2R0MhLU0Z4=
X-Received: by 2002:a9d:7d0d:0:b0:6db:bc6f:af0c with SMTP id
 v13-20020a9d7d0d000000b006dbbc6faf0cmr13529732otn.39.1704318335850; Wed, 03
 Jan 2024 13:45:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e28038fba1243f00b0dd66b7c5296a1e181645ea.1702496910.git.bcodding@redhat.com>
 <90c9365ad91e1eb0058b170fb332ea70ad554d8b.1702496910.git.bcodding@redhat.com>
In-Reply-To: <90c9365ad91e1eb0058b170fb332ea70ad554d8b.1702496910.git.bcodding@redhat.com>
From: Anna Schumaker <anna@kernel.org>
Date: Wed, 3 Jan 2024 16:45:19 -0500
X-Gmail-Original-Message-ID: <CAFX2Jf=CARs=2pPhi-Lj_ydZKyqpjA=kZQoWDNsRKM3gdp=CYw@mail.gmail.com>
Message-ID: <CAFX2Jf=CARs=2pPhi-Lj_ydZKyqpjA=kZQoWDNsRKM3gdp=CYw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] NFSv4.1: Use the nfs_client's rpc timeouts for backchannel
To: Benjamin Coddington <bcodding@redhat.com>
Cc: trond.myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ben,

On Wed, Dec 13, 2023 at 2:49=E2=80=AFPM Benjamin Coddington <bcodding@redha=
t.com> wrote:
>
> For backchannel requests that lookup the appropriate nfs_client, use the
> state-management rpc_clnt's rpc_timeout parameters for the backchannel's
> response.  When the nfs_client cannot be found, fall back to using the
> xprt's default timeout parameters.

I'm seeing a use-after-free after applying this patch when using pNFS
and session trunking. Any idea what's going on? Here is the stack
trace I'm seeing:

[    9.935256] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[   10.914810] NFS:  192.168.122.42: Session trunking succeeded for
192.168.122.44
[   11.864302] ------------[ cut here ]------------
[   11.864305] refcount_t: addition on 0; use-after-free.
[   11.864320] WARNING: CPU: 0 PID: 742 at lib/refcount.c:25
refcount_warn_saturate+0x82/0x120
[   11.864333] Modules linked in: nfs_layout_nfsv41_files
rpcsec_gss_krb5 nfsv4 nfs fscache netfs rpcrdma rdma_cm iw_cm ib_cm
ib_cor
e cfg80211 rfkill 8021q garp stp mrp llc intel_rapl_msr
intel_rapl_common intel_uncore_frequency_common kvm_intel kvm
snd_hda_codec_
generic irqbypass crct10dif_pclmul crc32_pclmul polyval_clmulni
snd_hda_intel polyval_generic snd_intel_dspcfg gf128mul snd_hda_code
c ghash_clmulni_intel sha512_ssse3 snd_hwdep sha256_ssse3 sha1_ssse3
vfat iTCO_wdt snd_hda_core aesni_intel fat joydev snd_pcm mouse
dev crypto_simd intel_pmc_bxt cryptd snd_timer iTCO_vendor_support
usbhid rapl snd psmouse pcspkr i2c_i801 soundcore lpc_ich i2c_smb
us mac_hid nfsd nfs_acl auth_rpcgss lockd grace usbip_host usbip_core
loop fuse sunrpc dm_mod nfnetlink qemu_fw_cfg ip_tables x_tabl
es xfs libcrc32c crc32c_generic virtio_net virtio_gpu virtio_balloon
net_failover virtio_blk failover virtio_dma_buf serio_raw virti
o_console atkbd virtio_scsi libps2 virtio_rng vivaldi_fmap
crc32c_intel i8042 intel_agp virtio_pci intel_gtt
[   11.864383]  virtio_pci_legacy_dev xhci_pci serio xhci_pci_renesas
virtio_pci_modern_dev
[   11.864387] CPU: 0 PID: 742 Comm: umount.nfs Not tainted
6.7.0-rc8-g4f79a1eeea4b+ #41661
749ab84c1af8a7111125e804fccf9cd536b09ccc
[   11.864390] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS unknown 2/2/2022
[   11.864391] RIP: 0010:refcount_warn_saturate+0x82/0x120
[   11.864393] Code: 89 e8 32 33 a3 ff 0f 0b c3 cc cc cc cc cc 80 3d
44 b4 52 01 00 75 c0 c6 05 3b b4 52 01 01 48 c7 c7 61 ad 7d 89
e8 0e 33 a3 ff <0f> 0b c3 cc cc cc cc cc 80 3d 21 b4 52 01 00 75 9c c6
05 18 b4 52
[   11.864394] RSP: 0018:ffffa677c0b97ca8 EFLAGS: 00010246
[   11.864395] RAX: bd28f387bfec6500 RBX: ffff99e884324e00 RCX: 00000000000=
00027
[   11.864397] RDX: ffffa677c0b97b70 RSI: 00000000ffffefff RDI: ffff99e8fbc=
21748
[   11.864398] RBP: 0000000000000000 R08: 0000000000000fff R09: ffffffff89a=
577e0
[   11.864399] R10: 0000000000002ffd R11: 0000000000000004 R12: ffff99e88c0=
9a000
[   11.864400] R13: 0000000000000000 R14: ffffa677c0b97cf0 R15: ffff99e8843=
24e00
[   11.864401] FS:  00007f0f757e0740(0000) GS:ffff99e8fbc00000(0000)
knlGS:0000000000000000
[   11.864402] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.864403] CR2: 000055b5ebbfdf70 CR3: 000000010c23e000 CR4: 00000000007=
50ef0
[   11.864406] PKRU: 55555554
[   11.864407] Call Trace:
[   11.864409]  <TASK>
[   11.864411]  ? __warn+0xc8/0x1c0
[   11.864413]  ? refcount_warn_saturate+0x82/0x120
[   11.864415]  ? report_bug+0x14e/0x1f0
[   11.864418]  ? handle_bug+0x42/0x70
[   11.864420]  ? exc_invalid_op+0x1a/0x50
[   11.864421]  ? asm_exc_invalid_op+0x1a/0x20
[   11.864424]  ? refcount_warn_saturate+0x82/0x120
[   11.864425]  ? refcount_warn_saturate+0x82/0x120
[   11.864427]  rpc_run_task+0x189/0x190 [sunrpc
6793b05ff35aa080c42f3ac953d266676d3f5305]
[   11.864465]  rpc_call_sync+0x76/0xd0 [sunrpc
6793b05ff35aa080c42f3ac953d266676d3f5305]
[   11.864494]  nfs4_proc_destroy_session+0x5f/0x110 [nfsv4
40e2e5b44d7c7f6d8dd1ddb28617f0073ea88879]
[   11.864529]  nfs4_destroy_session+0x29/0x110 [nfsv4
40e2e5b44d7c7f6d8dd1ddb28617f0073ea88879]
[   11.864561]  nfs41_shutdown_client+0xdc/0x100 [nfsv4
40e2e5b44d7c7f6d8dd1ddb28617f0073ea88879]
[   11.864587]  nfs4_free_client+0x2e/0xb0 [nfsv4
40e2e5b44d7c7f6d8dd1ddb28617f0073ea88879]
[   11.864612]  nfs_free_server+0x55/0xe0 [nfs
29da860307c99416b772706e6b567729d002ddce]
[   11.864638]  deactivate_locked_super+0x38/0x100
[   11.864641]  cleanup_mnt+0xfd/0x150
[   11.864643]  task_work_run+0x86/0xb0
[   11.864646]  exit_to_user_mode_loop+0xc8/0x110
[   11.864648]  exit_to_user_mode_prepare+0x73/0xe0
[   11.864650]  syscall_exit_to_user_mode+0x31/0x1b0
[   11.864651]  do_syscall_64+0x77/0x100
[   11.864654]  ? syscall_exit_to_user_mode+0x31/0x1b0
[   11.864655]  ? do_syscall_64+0x77/0x100
[   11.864657]  ? exc_page_fault+0x7a/0x1b0
[   11.864658]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[   11.864660] RIP: 0033:0x7f0f759114fb
[   11.864663] Code: c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3
0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6
00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 01 68
0c 00 f7 d8
[   11.864664] RSP: 002b:00007fff8bb7e358 EFLAGS: 00000246 ORIG_RAX:
00000000000000a6
[   11.864665] RAX: 0000000000000000 RBX: 000055f3424bbfc0 RCX: 00007f0f759=
114fb
[   11.864666] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055f3424=
bbfc0
[   11.864667] RBP: 000055f3424bbf90 R08: 00000000ffffffff R09: 00000000000=
00020
[   11.864668] R10: 00007f0f7580ddd0 R11: 0000000000000246 R12: 00000000000=
00000
[   11.864669] R13: 00007fff8bb7e568 R14: 00007f0f75bc8000 R15: 000055f341d=
a97d8
[   11.864670]  </TASK>
[   11.864671] ---[ end trace 0000000000000000 ]---
[   11.864675] BUG: kernel NULL pointer dereference, address: 0000000000000=
018
[   11.865152] #PF: supervisor read access in kernel mode
[   11.865483] #PF: error_code(0x0000) - not-present page
[   11.865811] PGD 0 P4D 0
[   11.865983] Oops: 0000 [#1] PREEMPT SMP NOPTI
[   11.866275] CPU: 0 PID: 742 Comm: umount.nfs Tainted: G        W
      6.7.0-rc8-g4f79a1eeea4b+ #41661 749ab84c1af8a7111125e80
4fccf9cd536b09ccc
[   11.867085] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS unknown 2/2/2022
[   11.867587] RIP: 0010:rpcauth_refreshcred+0x133/0x2b0 [sunrpc]
[   11.867987] Code: 8b 70 50 48 c7 c7 40 15 a1 89 e8 08 6e 8f c7 48
89 44 24 18 48 c7 44 24 20 00 00 00 00 8b 83 d8 00 00 00 01 c0
83 e0 02 09 c5 <49> 8b 46 18 4c 8b 58 30 48 8d 74 24 18 4c 89 f7 89 ea
41 ff d3 0f
[   11.869142] RSP: 0018:ffffa677c0b97bc8 EFLAGS: 00010246
[   11.869479] RAX: 0000000000000000 RBX: ffff99e884324e00 RCX: 00000000000=
00005
[   11.869933] RDX: 000000000000d380 RSI: 000000000000464f RDI: ffff99e88d6=
ca0c0
[   11.870383] RBP: 0000000000000000 R08: ffff99e88c09a018 R09: ffffffff89a=
577e0
[   11.870839] R10: 0000000000002ffd R11: ffffffffc07dc330 R12: ffff99e88c0=
9a600
[   11.871293] R13: ffffffffc082d8d0 R14: 0000000000000000 R15: ffffffffc07=
dc330
[   11.871730] FS:  00007f0f757e0740(0000) GS:ffff99e8fbc00000(0000)
knlGS:0000000000000000
[   11.872012] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.872221] CR2: 0000000000000018 CR3: 000000010c23e000 CR4: 00000000007=
50ef0
[   11.872467] PKRU: 55555554
[   11.872565] Call Trace:
[   11.872656]  <TASK>
[   11.872736]  ? __die_body+0x68/0xb0
[   11.872862]  ? page_fault_oops+0x3a6/0x400
[   11.873006]  ? exc_page_fault+0x7a/0x1b0
[   11.873144]  ? asm_exc_page_fault+0x26/0x30
[   11.873302]  ? __pfx_call_refresh+0x10/0x10 [sunrpc
6793b05ff35aa080c42f3ac953d266676d3f5305]
[   11.873620]  ? __pfx_call_refresh+0x10/0x10 [sunrpc
6793b05ff35aa080c42f3ac953d266676d3f5305]
[   11.873945]  ? rpcauth_refreshcred+0x133/0x2b0 [sunrpc
6793b05ff35aa080c42f3ac953d266676d3f5305]
[   11.874280]  ? rpcauth_refreshcred+0x118/0x2b0 [sunrpc
6793b05ff35aa080c42f3ac953d266676d3f5305]
[   11.874596]  ? _raw_spin_unlock+0xe/0x30
[   11.874734]  ? __pfx_call_refresh+0x10/0x10 [sunrpc
6793b05ff35aa080c42f3ac953d266676d3f5305]
[   11.875042]  ? __pfx_rpc_exit_task+0x10/0x10 [sunrpc
6793b05ff35aa080c42f3ac953d266676d3f5305]
[   11.875352]  __rpc_execute+0xfe/0x4b0 [sunrpc
6793b05ff35aa080c42f3ac953d266676d3f5305]
[   11.875642]  rpc_execute+0xa8/0x150 [sunrpc
6793b05ff35aa080c42f3ac953d266676d3f5305]
[   11.875926]  rpc_run_task+0x165/0x190 [sunrpc
6793b05ff35aa080c42f3ac953d266676d3f5305]
[   11.876236]  rpc_call_sync+0x76/0xd0 [sunrpc
6793b05ff35aa080c42f3ac953d266676d3f5305]
[   11.876525]  nfs4_proc_destroy_session+0x5f/0x110 [nfsv4
40e2e5b44d7c7f6d8dd1ddb28617f0073ea88879]
[   11.876853]  nfs4_destroy_session+0x29/0x110 [nfsv4
40e2e5b44d7c7f6d8dd1ddb28617f0073ea88879]
[   11.877164]  nfs41_shutdown_client+0xdc/0x100 [nfsv4
40e2e5b44d7c7f6d8dd1ddb28617f0073ea88879]
[   11.877493]  nfs4_free_client+0x2e/0xb0 [nfsv4
40e2e5b44d7c7f6d8dd1ddb28617f0073ea88879]
[   11.877790]  nfs_free_server+0x55/0xe0 [nfs
29da860307c99416b772706e6b567729d002ddce]
[   11.878200]  deactivate_locked_super+0x38/0x100
[   11.878370]  cleanup_mnt+0xfd/0x150
[   11.878496]  task_work_run+0x86/0xb0
[   11.878629]  exit_to_user_mode_loop+0xc8/0x110
[   11.878785]  exit_to_user_mode_prepare+0x73/0xe0
[   11.879121]  syscall_exit_to_user_mode+0x31/0x1b0
[   11.879451]  do_syscall_64+0x77/0x100
[   11.879746]  ? syscall_exit_to_user_mode+0x31/0x1b0
[   11.880076]  ? do_syscall_64+0x77/0x100
[   11.880370]  ? exc_page_fault+0x7a/0x1b0
[   11.880683]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[   11.881031] RIP: 0033:0x7f0f759114fb
[   11.881321] Code: c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3
0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6
00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 01 68
0c 00 f7 d8
[   11.882267] RSP: 002b:00007fff8bb7e358 EFLAGS: 00000246 ORIG_RAX:
00000000000000a6
[   11.882691] RAX: 0000000000000000 RBX: 000055f3424bbfc0 RCX: 00007f0f759=
114fb
[   11.883121] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055f3424=
bbfc0
[   11.883550] RBP: 000055f3424bbf90 R08: 00000000ffffffff R09: 00000000000=
00020
[   11.883987] R10: 00007f0f7580ddd0 R11: 0000000000000246 R12: 00000000000=
00000
[   11.884429] R13: 00007fff8bb7e568 R14: 00007f0f75bc8000 R15: 000055f341d=
a97d8
[   11.884873]  </TASK>
[   11.885132] Modules linked in: nfs_layout_nfsv41_files
rpcsec_gss_krb5 nfsv4 nfs fscache netfs rpcrdma rdma_cm iw_cm ib_cm
ib_cor
e cfg80211 rfkill 8021q garp stp mrp llc intel_rapl_msr
intel_rapl_common intel_uncore_frequency_common kvm_intel kvm
snd_hda_codec_
generic irqbypass crct10dif_pclmul crc32_pclmul polyval_clmulni
snd_hda_intel polyval_generic snd_intel_dspcfg gf128mul snd_hda_code
c ghash_clmulni_intel sha512_ssse3 snd_hwdep sha256_ssse3 sha1_ssse3
vfat iTCO_wdt snd_hda_core aesni_intel fat joydev snd_pcm mouse
dev crypto_simd intel_pmc_bxt cryptd snd_timer iTCO_vendor_support
usbhid rapl snd psmouse pcspkr i2c_i801 soundcore lpc_ich i2c_smb
us mac_hid nfsd nfs_acl auth_rpcgss lockd grace usbip_host usbip_core
loop fuse sunrpc dm_mod nfnetlink qemu_fw_cfg ip_tables x_tabl
es xfs libcrc32c crc32c_generic virtio_net virtio_gpu virtio_balloon
net_failover virtio_blk failover virtio_dma_buf serio_raw virti
o_console atkbd virtio_scsi libps2 virtio_rng vivaldi_fmap
crc32c_intel i8042 intel_agp virtio_pci intel_gtt
[   11.885172]  virtio_pci_legacy_dev xhci_pci serio xhci_pci_renesas
virtio_pci_modern_dev
[   11.890142] CR2: 0000000000000018
[   11.890468] ---[ end trace 0000000000000000 ]---

I hit this while testing against ontap, if that helps.

Thanks,
Anna

>
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
>  fs/nfs/callback_proc.c         | 3 +++
>  fs/nfs/callback_xdr.c          | 3 +++
>  include/linux/sunrpc/bc_xprt.h | 3 ++-
>  include/linux/sunrpc/sched.h   | 3 ++-
>  include/linux/sunrpc/svc.h     | 1 +
>  net/sunrpc/clnt.c              | 8 ++++++--
>  net/sunrpc/svc.c               | 6 +++++-
>  net/sunrpc/xprt.c              | 5 +++--
>  8 files changed, 25 insertions(+), 7 deletions(-)
>
> diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
> index 96a4923080ae..8ce721eba383 100644
> --- a/fs/nfs/callback_proc.c
> +++ b/fs/nfs/callback_proc.c
> @@ -504,6 +504,9 @@ __be32 nfs4_callback_sequence(void *argp, void *resp,
>         if (!(clp->cl_session->flags & SESSION4_BACK_CHAN))
>                 goto out;
>
> +       /* release in svc_process_bc */
> +       refcount_inc(&clp->cl_rpcclient->cl_count);
> +
>         tbl =3D &clp->cl_session->bc_slot_table;
>
>         /* Set up res before grabbing the spinlock */
> diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
> index 321af81c456e..40a43d615b82 100644
> --- a/fs/nfs/callback_xdr.c
> +++ b/fs/nfs/callback_xdr.c
> @@ -967,6 +967,9 @@ static __be32 nfs4_callback_compound(struct svc_rqst =
*rqstp)
>                 nops--;
>         }
>
> +       if (svc_is_backchannel(rqstp) && cps.clp)
> +               rqstp->bc_rpc_clnt =3D cps.clp->cl_rpcclient;
> +
>         *hdr_res.status =3D status;
>         *hdr_res.nops =3D htonl(nops);
>         nfs4_cb_free_slot(&cps);
> diff --git a/include/linux/sunrpc/bc_xprt.h b/include/linux/sunrpc/bc_xpr=
t.h
> index db30a159f9d5..f22bf915dcf6 100644
> --- a/include/linux/sunrpc/bc_xprt.h
> +++ b/include/linux/sunrpc/bc_xprt.h
> @@ -20,7 +20,8 @@
>  #ifdef CONFIG_SUNRPC_BACKCHANNEL
>  struct rpc_rqst *xprt_lookup_bc_request(struct rpc_xprt *xprt, __be32 xi=
d);
>  void xprt_complete_bc_request(struct rpc_rqst *req, uint32_t copied);
> -void xprt_init_bc_request(struct rpc_rqst *req, struct rpc_task *task);
> +void xprt_init_bc_request(struct rpc_rqst *req, struct rpc_task *task,
> +               const struct rpc_timeout *to);
>  void xprt_free_bc_request(struct rpc_rqst *req);
>  int xprt_setup_backchannel(struct rpc_xprt *, unsigned int min_reqs);
>  void xprt_destroy_backchannel(struct rpc_xprt *, unsigned int max_reqs);
> diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
> index 8ada7dc802d3..786c1d2e9d6a 100644
> --- a/include/linux/sunrpc/sched.h
> +++ b/include/linux/sunrpc/sched.h
> @@ -205,7 +205,8 @@ struct rpc_wait_queue {
>   */
>  struct rpc_task *rpc_new_task(const struct rpc_task_setup *);
>  struct rpc_task *rpc_run_task(const struct rpc_task_setup *);
> -struct rpc_task *rpc_run_bc_task(struct rpc_rqst *req);
> +struct rpc_task *rpc_run_bc_task(struct rpc_rqst *req,
> +               struct rpc_clnt *clnt);
>  void           rpc_put_task(struct rpc_task *);
>  void           rpc_put_task_async(struct rpc_task *);
>  bool           rpc_task_set_rpc_status(struct rpc_task *task, int rpc_st=
atus);
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index b10f987509cc..1c727a422a65 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -250,6 +250,7 @@ struct svc_rqst {
>         struct net              *rq_bc_net;     /* pointer to backchannel=
's
>                                                  * net namespace
>                                                  */
> +       struct rpc_clnt         *bc_rpc_clnt;   /* v4.1 backchannel RPC c=
lient */
>         void **                 rq_lease_breaker; /* The v4 client breaki=
ng a lease */
>         unsigned int            rq_status_counter; /* RPC processing coun=
ter */
>  };
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index daa9582ec861..1946c2b39de3 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -1302,9 +1302,12 @@ static void call_bc_encode(struct rpc_task *task);
>   * rpc_run_bc_task - Allocate a new RPC task for backchannel use, then r=
un
>   * rpc_execute against it
>   * @req: RPC request
> + * @clnt: RPC client from request's cl_rpcclient
>   */
> -struct rpc_task *rpc_run_bc_task(struct rpc_rqst *req)
> +struct rpc_task *rpc_run_bc_task(struct rpc_rqst *req,
> +               struct rpc_clnt *clnt)
>  {
> +       const struct rpc_timeout *timeout;
>         struct rpc_task *task;
>         struct rpc_task_setup task_setup_data =3D {
>                 .callback_ops =3D &rpc_default_ops,
> @@ -1322,7 +1325,8 @@ struct rpc_task *rpc_run_bc_task(struct rpc_rqst *r=
eq)
>                 return task;
>         }
>
> -       xprt_init_bc_request(req, task);
> +       timeout =3D clnt ? clnt->cl_timeout : req->rq_xprt->timeout;
> +       xprt_init_bc_request(req, task, timeout);
>
>         task->tk_action =3D call_bc_encode;
>         atomic_inc(&task->tk_count);
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 3f2ea7a0496f..47685c05499a 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -1603,7 +1603,11 @@ void svc_process_bc(struct rpc_rqst *req, struct s=
vc_rqst *rqstp)
>         }
>         /* Finally, send the reply synchronously */
>         memcpy(&req->rq_snd_buf, &rqstp->rq_res, sizeof(req->rq_snd_buf))=
;
> -       task =3D rpc_run_bc_task(req);
> +       task =3D rpc_run_bc_task(req, rqstp->bc_rpc_clnt);
> +
> +       if (rqstp->bc_rpc_clnt)
> +               rpc_release_client(rqstp->bc_rpc_clnt);
> +
>         if (IS_ERR(task))
>                 return;
>
> diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
> index 6cc9ffac962d..6f69975f3764 100644
> --- a/net/sunrpc/xprt.c
> +++ b/net/sunrpc/xprt.c
> @@ -1986,7 +1986,8 @@ void xprt_release(struct rpc_task *task)
>
>  #ifdef CONFIG_SUNRPC_BACKCHANNEL
>  void
> -xprt_init_bc_request(struct rpc_rqst *req, struct rpc_task *task)
> +xprt_init_bc_request(struct rpc_rqst *req, struct rpc_task *task,
> +               const struct rpc_timeout *to)
>  {
>         struct xdr_buf *xbufp =3D &req->rq_snd_buf;
>
> @@ -2000,7 +2001,7 @@ xprt_init_bc_request(struct rpc_rqst *req, struct r=
pc_task *task)
>         xbufp->len =3D xbufp->head[0].iov_len + xbufp->page_len +
>                 xbufp->tail[0].iov_len;
>
> -       xprt_init_majortimeo(task, req, req->rq_xprt->timeout);
> +       xprt_init_majortimeo(task, req, to);
>  }
>  #endif
>
> --
> 2.43.0
>

