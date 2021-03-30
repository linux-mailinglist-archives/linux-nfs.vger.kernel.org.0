Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15B134E3D6
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Mar 2021 11:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhC3JBr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Mar 2021 05:01:47 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:56204 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231637AbhC3JBk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 Mar 2021 05:01:40 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UTqSFHU_1617094896;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0UTqSFHU_1617094896)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 30 Mar 2021 17:01:36 +0800
Date:   Tue, 30 Mar 2021 17:01:36 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "aglo@umich.edu" <aglo@umich.edu>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: kernel ops from commit 6869c46bd960
Message-ID: <20210330090136.GM95214@e18g06458.et15sqa>
References: <CAN-5tyHxeLknSxbRb92shQv3hsf146N9wsvEUQ4VEJRGhEXD_g@mail.gmail.com>
 <463e945f7dbe9730283d4f3b6850cc3e4326f0b9.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <463e945f7dbe9730283d4f3b6850cc3e4326f0b9.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Mar 29, 2021 at 09:26:24PM +0000, Trond Myklebust wrote:
> Hi Olga,
> 
> On Mon, 2021-03-29 at 17:11 -0400, Olga Kornievskaia wrote:
> > I'm on commit 20e0d860a4217b8e6a2f72852a5d6465e6104078 of your
> > origin/testing
> > 
> > I just did mount -o vers=3,sec=sys <linux_server>:/ /mnt
> > 
> > Got the following oops.
> > 
> > I believe I bisected it to the following commit:
> > 6869c46bd9607787f2f39dabf59da8f34dd3f513 "nfs: hornor timeo and
> > retrans option when mounting NFSv3"
> > 
> > cb76aa233c4d060b2daa8077a5dc0f414ca682c1 "SUNRPC: Ensure the
> > transport
> > backchannel association"
> > 
> > [66946.322155] kernel BUG at fs/nfs/client.c:492!
> > [66946.323863] invalid opcode: 0000 [#1] SMP KASAN PTI
> > [66946.325630] CPU: 0 PID: 69573 Comm: mount.nfs Tainted: G        W
> >       5.12.0-rc4+ #86
> > [66946.328195] Hardware name: VMware, Inc. VMware Virtual
> > Platform/440BX Desktop Reference Platform, BIOS 6.00 07/22/2020
> > [66946.331367] RIP: 0010:nfs_init_timeout_values+0x104/0x110 [nfs]
> > [66946.333501] Code: 00 76 a3 49 c7 45 00 c0 27 09 00 bb c0 27 09 00
> > eb 94 e8 8f a8 f5 d7 41 bc 03 00 00 00 41 c7 45 18 02 00 00 00 e9 65
> > ff ff ff <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 b8
> > 00
> > 00 00
> > [66946.339146] RSP: 0018:ffff888017c17908 EFLAGS: 00010287
> > [66946.340624] RAX: 0000000000000000 RBX: ffffffffffffff9c RCX:
> > ffffffffc15215a7
> > [66946.342576] RDX: dffffc0000000000 RSI: 0000000000000011 RDI:
> > ffffffffc158d6a0
> > [66946.344483] RBP: 00000000ffffffff R08: 6d01a8c000000002 R09:
> > 0000000000000000
> > [66946.346391] R10: 6d01a8c000000002 R11: 0000000000000000 R12:
> > 00000000ffffffff
> > [66946.348367] R13: ffffffffc158d6a0 R14: 0000000000000011 R15:
> > ffff888077a97820
> > [66946.350280] FS:  00007f50b9827880(0000) GS:ffff888059600000(0000)
> > knlGS:0000000000000000
> > [66946.352440] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [66946.354087] CR2: 000055aa60e6b000 CR3: 000000000d7e8004 CR4:
> > 00000000001706f0
> > [66946.356261] Call Trace:
> > [66946.356943]  nfs_mount+0x297/0x470 [nfs]
> > [66946.358041]  ? mnt_xdr_dec_mountres+0x130/0x130 [nfs]
> > [66946.359515]  ? ip_map_cache_destroy+0x80/0x80 [sunrpc]
> > [66946.361471]  nfs_request_mount.constprop.17+0x205/0x310 [nfs]
> > [66946.363036]  ? nfs_show_stats+0x7d0/0x7d0 [nfs]
> > [66946.364352]  ? avc_has_extended_perms+0x760/0x760
> > [66946.365772]  nfs_try_get_tree+0x18d/0x490 [nfs]
> > [66946.367058]  ? nfs_get_tree_common+0x690/0x690 [nfs]
> > [66946.368447]  ? cred_has_capability+0xf4/0x1e0
> > [66946.369655]  ? _raw_spin_lock+0x7a/0xd0
> > [66946.370889]  ? _raw_write_lock_bh+0xe0/0xe0
> > [66946.372022]  ? __kmalloc_track_caller+0x136/0x450
> > [66946.373365]  ? try_module_get+0x40/0xe0
> > [66946.374440]  ? get_nfs_version+0x29/0x80 [nfs]
> > [66946.375711]  ? nfs_get_tree+0x7ca/0xa20 [nfs]
> > [66946.376982]  vfs_get_tree+0x45/0x120
> > [66946.377966]  path_mount+0x914/0xd30
> > [66946.378976]  ? __check_object_size+0x178/0x220
> > [66946.380201]  ? finish_automount+0x2f0/0x2f0
> > [66946.381304]  ? strncpy_from_user+0x1e4/0x250
> > [66946.382584]  ? getname_flags+0x10d/0x2a0
> > [66946.383642]  ? call_rcu+0x273/0x870
> > [66946.384675]  do_mount+0xcb/0xf0
> > [66946.385531]  ? path_mount+0xd30/0xd30
> > [66946.386524]  ? _copy_from_user+0x4c/0x90
> > [66946.387605]  ? copy_mount_options+0x59/0x100
> > [66946.388821]  __x64_sys_mount+0xf4/0x110
> > [66946.389860]  do_syscall_64+0x33/0x40
> > [66946.390865]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > [66946.392225] RIP: 0033:0x7f50b8cb79ee
> > [66946.393215] Code: 48 8b 0d 9d f4 2b 00 f7 d8 64 89 01 48 83 c8 ff
> > c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00
> > 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6a f4 2b 00 f7 d8 64
> > 89
> > 01 48
> > [66946.398172] RSP: 002b:00007ffe53753188 EFLAGS: 00000246 ORIG_RAX:
> > 00000000000000a5
> > [66946.400138] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
> > 00007f50b8cb79ee
> > [66946.402202] RDX: 000055aa60e4a2b0 RSI: 000055aa60e4a290 RDI:
> > 000055aa60e484d0
> > [66946.404306] RBP: 00007ffe537533a0 R08: 000055aa60e4d180 R09:
> > 000055aa60e4d170
> > [66946.406418] R10: 0000000000000000 R11: 0000000000000246 R12:
> > 00007f50b98277f8
> > [66946.408502] R13: 00007ffe537533a0 R14: 00007ffe53753280 R15:
> > 000055aa60e4d140
> > [66946.410600] Modules linked in: nfsv3 nfs_acl
> > nfs_layout_nfsv41_files rpcsec_gss_krb5 nfsv4 dns_resolver nfs lockd
> > grace nfs_ssc fuse rfcomm xt_conntrack nf_conntrack nf_defrag_ipv6
> > nf_defrag_ipv4 ipt_REJECT nf_reject_ipv4 nft_counter nft_compat
> > nf_tables nfnetlink tun bridge stp llc vmw_vsock_vmci_transport vsock
> > bnep snd_seq_midi snd_seq_midi_event intel_rapl_msr intel_rapl_common
> > crct10dif_pclmul crc32_pclmul vmw_balloon ghash_clmulni_intel joydev
> > pcspkr btusb uvcvideo btrtl btbcm btintel videobuf2_vmalloc
> > snd_ens1371 videobuf2_memops videobuf2_v4l2 snd_ac97_codec ac97_bus
> > videobuf2_common snd_seq bluetooth videodev snd_pcm rfkill mc
> > ecdh_generic ecc snd_timer snd_rawmidi snd_seq_device snd soundcore
> > i2c_piix4 vmw_vmci auth_rpcgss sunrpc ip_tables xfs libcrc32c sr_mod
> > cdrom sg ata_generic crc32c_intel vmwgfx drm_kms_helper serio_raw
> > syscopyarea sysfillrect sysimgblt fb_sys_fops cec ttm nvme nvme_core
> > t10_pi ahci libahci ata_piix drm vmxnet3 libata
> > [66946.437026] ---[ end trace b2ce7b83b0ed50dc ]---
> 
> OK. Why is mnt_timeout declared to be a static variable in that patch?
> Does the mount succeed if you let it be a stack variable?

I followed what nfs_umount() does. And the BUG() has no nothing to do
with the mnt_timeout variable.

The BUG() happens in nfs_init_timeout_values(), as the protocol is UDP,
but CONFIG_NFS_DISABLE_UDP_SUPPORT. I was testing with UDP enabled, so
didn't hit this crash.

The attached patch fixed the issue for me, but I'm not sure if it's the
proper place to update mount protocol (e.g. another option would be
updating it when parsing mount options).

Thanks,
Eryu

> 
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 

--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-nfs-mount-nfsv3-with-TCP-if-UDP-is-disabled.patch"

From 4655d3c757c23f3665efd54fda07ee7103f91777 Mon Sep 17 00:00:00 2001
From: Eryu Guan <eguan@linux.alibaba.com>
Date: Tue, 30 Mar 2021 16:33:01 +0800
Subject: [PATCH] nfs: mount nfsv3 with TCP if UDP is disabled

Commit b24ee6c64ca7 ("NFS: allow deprecation of NFS UDP protocol")
deprecates nfs server UDP protocol, but v3 mount protocol is possible
to be UDP.

So update mount protocol to TCP as well if UDP is disabled.

Fixes: b24ee6c64ca7 ("NFS: allow deprecation of NFS UDP protocol")
Signed-off-by: Eryu Guan <eguan@linux.alibaba.com>
---
 fs/nfs/fs_context.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 971a9251c1d9..bccbe66589f4 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -301,12 +301,16 @@ static void nfs_validate_transport_protocol(struct nfs_fs_context *ctx)
 
 /*
  * For text based NFSv2/v3 mounts, the mount protocol transport default
- * settings should depend upon the specified NFS transport.
+ * settings should depend upon the specified NFS transport. If UDP is disabled,
+ * only TCP is allowed.
  */
 static void nfs_set_mount_transport_protocol(struct nfs_fs_context *ctx)
 {
 	nfs_validate_transport_protocol(ctx);
 
+#ifdef CONFIG_NFS_DISABLE_UDP_SUPPORT
+	ctx->mount_server.protocol = XPRT_TRANSPORT_TCP;
+#else
 	if (ctx->mount_server.protocol == XPRT_TRANSPORT_UDP ||
 	    ctx->mount_server.protocol == XPRT_TRANSPORT_TCP)
 			return;
@@ -318,6 +322,7 @@ static void nfs_set_mount_transport_protocol(struct nfs_fs_context *ctx)
 	case XPRT_TRANSPORT_RDMA:
 		ctx->mount_server.protocol = XPRT_TRANSPORT_TCP;
 	}
+#endif
 }
 
 /*
-- 
2.26.1.107.gefe3874


--2fHTh5uZTiUOsy+g--
