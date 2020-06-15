Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E511F9044
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jun 2020 09:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgFOHsQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Jun 2020 03:48:16 -0400
Received: from m12-18.163.com ([220.181.12.18]:55027 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgFOHsP (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 15 Jun 2020 03:48:15 -0400
X-Greylist: delayed 913 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jun 2020 03:48:12 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=pmsVZhLOHx5tUCubv1
        Oj1GTL6dlyR+r2Lx+F3Kge8Ks=; b=d3XSP5+hHvQzeiV9fg0EdaoQbkso1glhc8
        73d860VOmQRKNGLDwPxiW5HzCP5uAj3ja99kKSOcjYFDQPbwGZgLxtnO0qkLPHdY
        bBh9NW0Dl42keM8+HdHSCDWM4PIm3q7PjSrRRr6gds7fqtisx9uaZRqowr4Ru1wO
        UTZk33RIY=
Received: from luo.lan (unknown [113.91.141.189])
        by smtp14 (Coremail) with SMTP id EsCowAAXGECnI+deGjypGA--.22308S2;
        Mon, 15 Jun 2020 15:31:07 +0800 (CST)
From:   Luo Xiaogang <lxgrxd@163.com>
To:     bfields@fieldses.org, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luo Xiaogang <lxgrxd@163.com>
Subject: [PATCH] nfsd: fix kernel crash when load nfsd in docker
Date:   Mon, 15 Jun 2020 15:12:11 +0800
Message-Id: <20200615071211.31326-1-lxgrxd@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: EsCowAAXGECnI+deGjypGA--.22308S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKFWkWw1xXFWxJrW5XF1rXrb_yoW3XFWUpF
        WjqryUWF4xJry5XF45Ja98Xw1UGr4xua4kWrWfJws5JFs8Wry8Xryktr4UJFyDKr4UXry3
        Jw1Dt3WIq345AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYxR-UUUUU=
X-Originating-IP: [113.91.141.189]
X-CM-SenderInfo: ho0j25rg6rljoofrz/1tbiqBxEUVc7P9e23AAAsP
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We load nfsd module in the docker container, kernel crash as following.

The 'current->nsproxy->net_ns->gen->ptr[nfsd_net_id]' is overflow in the
nfsd_init_net.

We should use the net_ns which is being init in the nfsd_init_net,
not the 'current->nsproxy->net_ns'.

[  939.174448] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[  939.174533] BUG: kernel NULL pointer dereference, address: 0000000000000058
[  939.174536] #PF: supervisor write access in kernel mode
[  939.174538] #PF: error_code(0x0002) - not-present page
[  939.174540] PGD 0 P4D 0
[  939.174543] Oops: 0002 [#1] SMP PTI
[  939.174546] CPU: 0 PID: 5031 Comm: modprobe Tainted: G           O      5.3.0-51-generic #44~18.04.2-Ubuntu
[  939.174548] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
[  939.174562] RIP: 0010:nfsd_fill_super+0x71/0x90 [nfsd]
[  939.174565] Code: 85 c0 89 c3 74 09 89 d8 5b 41 5c 41 5d 5d c3 49 8b 7c 24 68 31 f6 48 c7 c2 70 24 9f c0 e8 97 fe ff ff 48 3d 00 f0 ff ff 77 0d <49> 89 45 58 89 d8 5b 41 5c 41 5d 5d c3 89 c3 eb cb 0f 1f 40 00 66
[  939.174567] RSP: 0018:ffffaf12850f7aa8 EFLAGS: 00010287
[  939.174569] RAX: ffff94269f29a600 RBX: 0000000000000000 RCX: 0000000000000002
[  939.174570] RDX: 0000000000000000 RSI: 0000000000000100 RDI: ffff94269f30f820
[  939.174572] RBP: ffffaf12850f7ac0 R08: ffff94269f29a620 R09: 0000000000000000
[  939.174573] R10: 0000000000000000 R11: fefefefefefefeff R12: ffff942754da4800
[  939.174575] R13: 0000000000000000 R14: ffffffffc09b94d0 R15: ffff94275b344480
[  939.174577] FS:  00007f25508ed540(0000) GS:ffff94275ba00000(0000) knlGS:0000000000000000
[  939.174579] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  939.174580] CR2: 0000000000000058 CR3: 00000000619be000 CR4: 00000000000406f0
[  939.174586] Call Trace:
[  939.174593]  vfs_get_super+0x5b/0xe0
[  939.174597]  ? vfs_parse_fs_param+0xdc/0x1c0
[  939.174608]  nfsd_fs_get_tree+0x2c/0x30 [nfsd]
[  939.174610]  vfs_get_tree+0x2a/0x100
[  939.174613]  fc_mount+0x12/0x40
[  939.174615]  vfs_kern_mount.part.31+0x76/0x90
[  939.174618]  vfs_kern_mount+0x13/0x20
[  939.174627]  nfsd_init_net+0x101/0x140 [nfsd]
[  939.174630]  ops_init+0x44/0x120
[  939.174633]  register_pernet_operations+0xed/0x200
[  939.174645]  ? trace_event_define_fields_nfsd_stateid_class+0xb3/0xb3 [nfsd]
[  939.174647]  register_pernet_subsys+0x28/0x40
[  939.174658]  init_nfsd+0x22/0xcbc [nfsd]
[  939.174661]  do_one_initcall+0x4a/0x1fa
[  939.174664]  ? _cond_resched+0x19/0x40
[  939.174667]  ? kmem_cache_alloc_trace+0x15c/0x210
[  939.174671]  do_init_module+0x5f/0x227
[  939.174674]  load_module+0x1aa4/0x2140
[  939.174678]  __do_sys_finit_module+0xfc/0x120
[  939.174681]  ? __do_sys_finit_module+0xfc/0x120
[  939.174684]  __x64_sys_finit_module+0x1a/0x20
[  939.174687]  do_syscall_64+0x5a/0x130
[  939.174690]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  939.174692] RIP: 0033:0x7f2550a3270d
[  939.174694] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 53 f7 0c 00 f7 d8 64 89 01 48
[  939.174696] RSP: 002b:00007ffd4a3d9738 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  939.174698] RAX: ffffffffffffffda RBX: 000055d5164584e0 RCX: 00007f2550a3270d
[  939.174699] RDX: 0000000000000000 RSI: 000055d5146b7358 RDI: 0000000000000007
[  939.174701] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000000
[  939.174702] R10: 0000000000000007 R11: 0000000000000246 R12: 000055d5146b7358
[  939.174704] R13: 0000000000000000 R14: 000055d5164547c0 R15: 000055d5164584e0
[  939.174706] Modules linked in: nfsd(+) auth_rpcgss nfs_acl lockd grace veth xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo xt_addrtype iptable_filter iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c bpfilter br_netfilter bridge stp llc nls_utf8 isofs vboxsf(O) aufs overlay intel_rapl_msr snd_intel8x0 snd_ac97_codec ac97_bus snd_pcm snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq snd_seq_device snd_timer snd joydev soundcore vboxvideo intel_rapl_common drm_vram_helper ttm drm_kms_helper drm fb_sys_fops crct10dif_pclmul crc32_pclmul syscopyarea sysfillrect ghash_clmulni_intel sysimgblt aesni_intel aes_x86_64 crypto_simd cryptd glue_helper vboxguest(O) intel_rapl_perf input_leds mac_hid serio_raw binfmt_misc sch_fq_codel cuse sunrpc parport_pc ppdev lp parport ip_tables x_tables autofs4 hid_generic usbhid hid psmouse ahci libahci e1000 i2c_piix4 pata_acpi video
[  939.174739] CR2: 0000000000000058
[  939.174742] ---[ end trace 9fba6033f11f2b84 ]---
[  939.174752] RIP: 0010:nfsd_fill_super+0x71/0x90 [nfsd]
[  939.174754] Code: 85 c0 89 c3 74 09 89 d8 5b 41 5c 41 5d 5d c3 49 8b 7c 24 68 31 f6 48 c7 c2 70 24 9f c0 e8 97 fe ff ff 48 3d 00 f0 ff ff 77 0d <49> 89 45 58 89 d8 5b 41 5c 41 5d 5d c3 89 c3 eb cb 0f 1f 40 00 66
[  939.174755] RSP: 0018:ffffaf12850f7aa8 EFLAGS: 00010287
[  939.174757] RAX: ffff94269f29a600 RBX: 0000000000000000 RCX: 0000000000000002
[  939.174759] RDX: 0000000000000000 RSI: 0000000000000100 RDI: ffff94269f30f820
[  939.174760] RBP: ffffaf12850f7ac0 R08: ffff94269f29a620 R09: 0000000000000000
[  939.174761] R10: 0000000000000000 R11: fefefefefefefeff R12: ffff942754da4800
[  939.174763] R13: 0000000000000000 R14: ffffffffc09b94d0 R15: ffff94275b344480
[  939.174765] FS:  00007f25508ed540(0000) GS:ffff94275ba00000(0000) knlGS:0000000000000000
[  939.174766] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  939.174768] CR2: 0000000000000058 CR3: 00000000619be000 CR4: 00000000000406f0

Signed-off-by: Luo Xiaogang <lxgrxd@163.com>
---
 fs/nfsd/nfsctl.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index b68e96681522..87bb348a05ed 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1340,8 +1340,7 @@ void nfsd_client_rmdir(struct dentry *dentry)
 
 static int nfsd_fill_super(struct super_block *sb, struct fs_context *fc)
 {
-	struct nfsd_net *nn = net_generic(current->nsproxy->net_ns,
-							nfsd_net_id);
+	struct nfsd_net *nn = net_generic(fc->net_ns, nfsd_net_id);
 	struct dentry *dentry;
 	int ret;
 
@@ -1395,15 +1394,25 @@ static void nfsd_fs_free_fc(struct fs_context *fc)
 		put_net(fc->s_fs_info);
 }
 
+static int nfsd_fs_parse_monolithic(struct fs_context *fc, void *data)
+{
+	put_net(fc->net_ns);
+	fc->net_ns = get_net(data);
+
+	put_user_ns(fc->user_ns);
+	fc->user_ns = get_user_ns(fc->net_ns->user_ns);
+
+	return 0;
+}
+
 static const struct fs_context_operations nfsd_fs_context_ops = {
 	.free		= nfsd_fs_free_fc,
 	.get_tree	= nfsd_fs_get_tree,
+	.parse_monolithic = nfsd_fs_parse_monolithic,
 };
 
 static int nfsd_init_fs_context(struct fs_context *fc)
 {
-	put_user_ns(fc->user_ns);
-	fc->user_ns = get_user_ns(fc->net_ns->user_ns);
 	fc->ops = &nfsd_fs_context_ops;
 	return 0;
 }
@@ -1478,7 +1487,7 @@ static __net_init int nfsd_init_net(struct net *net)
 	init_waitqueue_head(&nn->ntf_wq);
 	seqlock_init(&nn->boot_lock);
 
-	mnt =  vfs_kern_mount(&nfsd_fs_type, SB_KERNMOUNT, "nfsd", NULL);
+	mnt =  vfs_kern_mount(&nfsd_fs_type, SB_KERNMOUNT, "nfsd", net);
 	if (IS_ERR(mnt)) {
 		retval = PTR_ERR(mnt);
 		goto out_mount_err;
-- 
2.17.1


