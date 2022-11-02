Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5792616681
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Nov 2022 16:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiKBPvf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Nov 2022 11:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiKBPvc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Nov 2022 11:51:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1B62BB2D;
        Wed,  2 Nov 2022 08:51:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9AF0A21A19;
        Wed,  2 Nov 2022 15:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667404287;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mcjly+6k+Roo3zyR9RHj6FlFx6EO6C07QIf6qAKL3qo=;
        b=2r+YUzXzHoC/l/YtjVcBqtY0PK0ewnXcrvCyqe5wLTjz1fNJWCTZneNtn2szwPFsCa8CH3
        qdufc08KCX3CCv4G4zuTefOFJl3ZVHUaZjwFgWaMWsfxjG838EFzGpVuOh4mXXtIhJy+vO
        ni0/Esf+rHShei0WTyUr0EwZqC0htaM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667404287;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mcjly+6k+Roo3zyR9RHj6FlFx6EO6C07QIf6qAKL3qo=;
        b=GfmqQXikpWdJagccRC2toRmQB+NQU2EDYKTmps4xBtGO0cwsqy+djFjCmKyaI3p+SK5amY
        nulqPyXP6SLsL5BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 209AD139D3;
        Wed,  2 Nov 2022 15:51:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id alAbBf+RYmNeDwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 02 Nov 2022 15:51:27 +0000
Date:   Wed, 2 Nov 2022 16:51:25 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Kees Cook <keescook@chromium.org>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        kernel test robot <yujie.liu@intel.com>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        Dave Jones <davej@codemonkey.org.uk>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v2] NFS: Avoid memcpy() run-time warning for struct
 sockaddr overflows
Message-ID: <Y2KR/Vw/aLJlDoXc@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20221017043107.never.457-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017043107.never.457-kees@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi all,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

It looks like it fixed all kernel oops triggered when running LTP NFS tests
(net.nfs runtest file).

First one was reported by Dave Jones
(https://lore.kernel.org/all/Y0zEzZwhOxTDcBTB@codemonkey.org.uk/)

and both were addressed in by this patchset.

BTW There are some other errors lockd related (nfslock* tests), I'll investigate
them during this week:
[  967.545642] lockd: cannot monitor 10.0.0.2
[  974.016225] xs_tcp_setup_socket: connect returned unhandled error -107

Thanks Kees!

Kind regards,
Petr

[  125.774063] ------------[ cut here ]------------
[  125.775460] memcpy: detected field-spanning write (size 28) of single field "request.sap" at fs/nfs/super.c:857 (size 18446744073709551615)
[  125.777904] WARNING: CPU: 0 PID: 3217 at fs/nfs/super.c:857 nfs_request_mount.constprop.0.isra.0+0x1cf/0x1e0 [nfs]
[  125.779823] Modules linked in: rpcsec_gss_krb5(E) nfsv4(E) dns_resolver(E) nfsv3(E) nfs(E) fscache(E) netfs(E) xfrm_user(E) xfrm_algo(E) veth(E) af_packet(E) rfkill(E) qrtr(E) intel_rapl_msr(E) intel_rapl_common(E) intel_pmc_core_pltdrv(E) intel_pmc_core(E) kvm_intel(E) snd_hda_codec_generic(E) ledtrig_audio(E) snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) iTCO_wdt(E) intel_pmc_bxt(E) iTCO_vendor_support(E) snd_hda_codec(E) kvm(E) irqbypass(E) pcspkr(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) snd_timer(E) joydev(E) i2c_i801(E) lpc_ich(E) i2c_smbus(E) snd(E) soundcore(E) virtio_net(E) virtio_balloon(E) net_failover(E) failover(E) tiny_power_button(E) button(E) nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E) fuse(E) configfs(E) sunrpc(E) ip_tables(E) x_tables(E) hid_generic(E) usbhid(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) gf128mul(E) ghash_clmulni_intel(E) sha512_ssse3(E) aesni_intel(E) xhci_pci(E) crypto_simd(E)
[  125.779892]  xhci_pci_renesas(E) cryptd(E) serio_raw(E) xhci_hcd(E) virtio_rng(E) virtio_blk(E) usbcore(E) virtio_gpu(E) virtio_dma_buf(E) btrfs(E) blake2b_generic(E) libcrc32c(E) crc32c_intel(E) xor(E) raid6_pq(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) qemu_fw_cfg(E)
[  125.793324] Unloaded tainted modules: intel_tcc_cooling(E):2 pcc_cpufreq(E):2 acpi_cpufreq(E):2
[  125.799336] CPU: 0 PID: 3217 Comm: mount.nfs Tainted: G            E      6.1.0-rc3-0.g3b74e67-default #1 openSUSE Tumbleweed (unreleased) 83d9036cc26826a41b4e9f7bea95f22c34b218fc
[  125.802007] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552-rebuilt.opensuse.org 04/01/2014
[  125.804599] RIP: 0010:nfs_request_mount.constprop.0.isra.0+0x1cf/0x1e0 [nfs]
[  125.806374] Code: 0f 85 2d ff ff ff 48 c7 c1 ff ff ff ff 48 c7 c2 80 4e da c0 48 89 ee 48 c7 c7 b0 4e da c0 c6 05 68 91 04 00 01 e8 43 e8 d7 ca <0f> 0b 48 8b 3c 24 e9 fe fe ff ff e8 91 01 dd ca 90 0f 1f 44 00 00
[  125.809487] RSP: 0018:ffffac0a0157fce0 EFLAGS: 00010282
[  125.810651] RAX: 0000000000000000 RBX: ffff9819c3cd5c00 RCX: 0000000000000027
[  125.811999] RDX: ffff981a1e4224c8 RSI: 0000000000000001 RDI: ffff981a1e4224c0
[  125.813296] RBP: 000000000000001c R08: 0000000000000000 R09: ffffac0a0157fb88
[  125.814622] R10: 0000000000000003 R11: ffffffff8c958348 R12: ffff9819c3cd5d30
[  125.815971] R13: ffff9819c64c1340 R14: ffff9819c39ae0c0 R15: 0000000000000001
[  125.817269] FS:  00007f0283539100(0000) GS:ffff981a1e400000(0000) knlGS:0000000000000000
[  125.818816] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  125.820120] CR2: 00005580d080bc68 CR3: 0000000003c6c003 CR4: 0000000000370ef0
[  125.821557] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  125.822924] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  125.824417] Call Trace:
[  125.825286]  <TASK>
[  125.826030]  nfs_try_get_tree+0xa7/0x200 [nfs 25f29e807864c924ae56dc3fe894ed7d36f5a514]
[  125.827520]  ? nfs_get_tree+0x1ec/0x6b0 [nfs 25f29e807864c924ae56dc3fe894ed7d36f5a514]
[  125.829262]  ? __kmalloc_node_track_caller+0x48/0x150
[  125.830466]  ? get_nfs_version+0x5f/0x130 [nfs 25f29e807864c924ae56dc3fe894ed7d36f5a514]
[  125.831941]  ? nfs_get_tree+0x447/0x6b0 [nfs 25f29e807864c924ae56dc3fe894ed7d36f5a514]
[  125.833408]  vfs_get_tree+0x22/0xc0
[  125.834446]  path_mount+0x458/0xa60
[  125.835614]  __x64_sys_mount+0x105/0x140
[  125.836786]  do_syscall_64+0x58/0x80
[  125.837681]  ? exit_to_user_mode_prepare+0x166/0x1f0
[  125.838793]  ? syscall_exit_to_user_mode+0x17/0x40
[  125.840130]  ? do_syscall_64+0x67/0x80
[  125.841241]  ? do_syscall_64+0x67/0x80
[  125.842641]  ? exc_page_fault+0x66/0x150
[  125.844412]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  125.845895] RIP: 0033:0x7f02838f268e
[  125.846862] Code: 48 8b 0d 85 e7 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 52 e7 0c 00 f7 d8 64 89 01 48
[  125.850094] RSP: 002b:00007ffee724dfd8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
[  125.851555] RAX: ffffffffffffffda RBX: 00007ffee724e1f0 RCX: 00007f02838f268e
[  125.852917] RDX: 0000563edbf74070 RSI: 0000563edbf74ed0 RDI: 0000563edbf74f40
[  125.854350] RBP: 0000563edbf99f70 R08: 0000563edbf99f70 R09: 0000563edbf99f70
[  125.855671] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffee724e1f0
[  125.857006] R13: 00007ffee724e0d0 R14: 0000563edbf99ed0 R15: 0000563edbf77170
[  125.858302]  </TASK>
[  125.859007] ---[ end trace 0000000000000000 ]---

export LTPROOT=/opt/ltp; runltp-ng -r net.nfs
[   84.451572] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552-rebuilt.opensuse.org 04/01/2014
[   84.454466] RIP: 0010:nfs_d_automount+0x24c/0x290 [nfs]
[   84.456065] Code: 10 00 00 00 4c 89 ee 4c 89 04 24 48 c7 c2 48 52 da c0 48 c7 c7 88 52 da c0 48 89 44 24 08 c6 05 8c d3 03 00 01 e8 66 2a 77 ce <0f> 0b 48 8b 44 24 08 4c 8b 04 24 e9 b7 fe ff ff be 01 00 00 00 e8
[   84.459311] RSP: 0018:ffffa50b811039f0 EFLAGS: 00010286
[   84.460532] RAX: 0000000000000000 RBX: ffff88ad83696000 RCX: 0000000000000000
[   84.461886] RDX: ffff88adde42efa8 RSI: ffff88adde4224c0 RDI: ffff88adde4224c0
[   84.463367] RBP: ffff88ad9c862240 R08: 0000000000000000 R09: ffffa50b81103898
[   84.464727] R10: 0000000000000003 R11: ffffffff90358348 R12: 000000000001e848
[   84.466115] R13: 000000000000001c R14: ffff88ad82f09000 R15: ffff88ad83694c00
[   84.467942] FS:  00007f46a8761100(0000) GS:ffff88adde400000(0000) knlGS:0000000000000000
[   84.469531] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   84.470678] CR2: 0000555c1ce960d8 CR3: 0000000005782006 CR4: 0000000000370ef0
[   84.471999] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   84.473420] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   84.474894] Call Trace:
[   84.475701]  <TASK>
[   84.476446]  __traverse_mounts+0x8c/0x210
[   84.477494]  step_into+0x339/0x760
[   84.478461]  link_path_walk.part.0.constprop.0+0x246/0x3b0
[   84.479583]  ? path_init+0x5c/0x3c0
[   84.480479]  path_lookupat+0x3e/0x190
[   84.481439]  filename_lookup+0xd0/0x1d0
[   84.482341]  ? getname_kernel+0x25/0x110
[   84.483262]  ? kmem_cache_alloc+0x16a/0x360
[   84.484258]  ? alloc_mnt_ns+0x57/0x170
[   84.485522]  vfs_path_lookup+0x4e/0x80
[   84.486628]  mount_subtree+0x8b/0x130
[   84.487542]  do_nfs4_mount+0x269/0x360 [nfsv4 59ca3c817e039994690a920010d1ce7d3d851090]
[   84.488996]  nfs4_try_get_tree+0x44/0xb0 [nfsv4 59ca3c817e039994690a920010d1ce7d3d851090]
[   84.490854]  vfs_get_tree+0x22/0xc0
[   84.491735]  path_mount+0x458/0xa60
[   84.492588]  __x64_sys_mount+0x105/0x140
[   84.493513]  do_syscall_64+0x58/0x80
[   84.494343]  ? exit_to_user_mode_prepare+0x166/0x1f0
[   84.495328]  ? syscall_exit_to_user_mode+0x17/0x40
[   84.496318]  ? do_syscall_64+0x67/0x80
[   84.497737]  ? syscall_exit_to_user_mode+0x17/0x40
[   84.498716]  ? do_syscall_64+0x67/0x80
[   84.499634]  ? do_syscall_64+0x67/0x80
[   84.500462]  ? do_user_addr_fault+0x1dc/0x690
[   84.501534]  ? exc_page_fault+0x66/0x150
[   84.502373]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   84.503350] RIP: 0033:0x7f46a8b1a68e
[   84.504098] Code: 48 8b 0d 85 e7 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 52 e7 0c 00 f7 d8 64 89 01 48
[   84.507186] RSP: 002b:00007ffd9cc0c9c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
[   84.508695] RAX: ffffffffffffffda RBX: 00007ffd9cc0cbf0 RCX: 00007f46a8b1a68e
[   84.509955] RDX: 000055f08e126070 RSI: 000055f08e126ed0 RDI: 000055f08e126f40
[   84.511158] RBP: 000055f08e129400 R08: 000055f08e129400 R09: 00313a3a313a313a
[   84.512318] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd9cc0cbf0
[   84.513522] R13: 000055f08e129120 R14: 0000000000000005 R15: 000055f08dfdc8f8
[   84.514798]  </TASK>
[   84.515652] ---[ end trace 0000000000000000 ]---

...

[   84.451572] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552-rebuilt.opensuse.org 04/01/2014
[   84.454466] RIP: 0010:nfs_d_automount+0x24c/0x290 [nfs]
[   84.456065] Code: 10 00 00 00 4c 89 ee 4c 89 04 24 48 c7 c2 48 52 da c0 48 c7 c7 88 52 da c0 48 89 44 24 08 c6 05 8c d3 03 00 01 e8 66 2a 77 ce <0f> 0b 48 8b 44 24 08 4c 8b 04 24 e9 b7 fe ff ff be 01 00 00 00 e8
[   84.459311] RSP: 0018:ffffa50b811039f0 EFLAGS: 00010286
[   84.460532] RAX: 0000000000000000 RBX: ffff88ad83696000 RCX: 0000000000000000
[   84.461886] RDX: ffff88adde42efa8 RSI: ffff88adde4224c0 RDI: ffff88adde4224c0
[   84.463367] RBP: ffff88ad9c862240 R08: 0000000000000000 R09: ffffa50b81103898
[   84.464727] R10: 0000000000000003 R11: ffffffff90358348 R12: 000000000001e848
[   84.466115] R13: 000000000000001c R14: ffff88ad82f09000 R15: ffff88ad83694c00
[   84.467942] FS:  00007f46a8761100(0000) GS:ffff88adde400000(0000) knlGS:0000000000000000
[   84.469531] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   84.470678] CR2: 0000555c1ce960d8 CR3: 0000000005782006 CR4: 0000000000370ef0
[   84.471999] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   84.473420] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   84.474894] Call Trace:
[   84.475701]  <TASK>
[   84.476446]  __traverse_mounts+0x8c/0x210
[   84.477494]  step_into+0x339/0x760
[   84.478461]  link_path_walk.part.0.constprop.0+0x246/0x3b0
[   84.479583]  ? path_init+0x5c/0x3c0
[   84.480479]  path_lookupat+0x3e/0x190
[   84.481439]  filename_lookup+0xd0/0x1d0
[   84.482341]  ? getname_kernel+0x25/0x110
[   84.483262]  ? kmem_cache_alloc+0x16a/0x360
[   84.484258]  ? alloc_mnt_ns+0x57/0x170
[   84.485522]  vfs_path_lookup+0x4e/0x80
[   84.486628]  mount_subtree+0x8b/0x130
[   84.487542]  do_nfs4_mount+0x269/0x360 [nfsv4 59ca3c817e039994690a920010d1ce7d3d851090]
[   84.488996]  nfs4_try_get_tree+0x44/0xb0 [nfsv4 59ca3c817e039994690a920010d1ce7d3d851090]
[   84.490854]  vfs_get_tree+0x22/0xc0
[   84.491735]  path_mount+0x458/0xa60
[   84.492588]  __x64_sys_mount+0x105/0x140
[   84.493513]  do_syscall_64+0x58/0x80
[   84.494343]  ? exit_to_user_mode_prepare+0x166/0x1f0
[   84.495328]  ? syscall_exit_to_user_mode+0x17/0x40
[   84.496318]  ? do_syscall_64+0x67/0x80
[   84.497737]  ? syscall_exit_to_user_mode+0x17/0x40
[   84.498716]  ? do_syscall_64+0x67/0x80
[   84.499634]  ? do_syscall_64+0x67/0x80
[   84.500462]  ? do_user_addr_fault+0x1dc/0x690
[   84.501534]  ? exc_page_fault+0x66/0x150
[   84.502373]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   84.503350] RIP: 0033:0x7f46a8b1a68e
[   84.504098] Code: 48 8b 0d 85 e7 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 52 e7 0c 00 f7 d8 64 89 01 48
[   84.507186] RSP: 002b:00007ffd9cc0c9c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
[   84.508695] RAX: ffffffffffffffda RBX: 00007ffd9cc0cbf0 RCX: 00007f46a8b1a68e
[   84.509955] RDX: 000055f08e126070 RSI: 000055f08e126ed0 RDI: 000055f08e126f40
[   84.511158] RBP: 000055f08e129400 R08: 000055f08e129400 R09: 00313a3a313a313a
[   84.512318] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd9cc0cbf0
[   84.513522] R13: 000055f08e129120 R14: 0000000000000005 R15: 000055f08dfdc8f8
[   84.514798]  </TASK>
[   84.515652] ---[ end trace 0000000000000000 ]---
