Return-Path: <linux-nfs+bounces-6709-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA020989D87
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 11:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5EC6287082
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 09:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EA9183CAA;
	Mon, 30 Sep 2024 09:01:35 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.cecloud.com (unknown [1.203.97.246])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBD51822E5;
	Mon, 30 Sep 2024 09:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.203.97.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727686895; cv=none; b=XMxkqdI9QRfF7V+Ypk/REvSKNKnoMWpoEUa3mzBxZLCmdj0wQls12mxn5pNyPwDL4EU5RtYx9CeyuNLiJwhgThmzg/+3lESqxKPWn0u3lY50f/Uu01O4JN27rPyPZQ8Fj61NLaBnw3Lx6jSNUqJlmZz4nLH300+YZrq+HvO3NEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727686895; c=relaxed/simple;
	bh=CopFIQU0FKXnlEg22CS4h0qTbtoIcvXh4O7WhYmpwMo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=owAx62zL3/axzKnTkpGPnj3kPdYfq3NNkXU0gYc0Zj/aZSsqMAvMhpEO9d4dNlRz7It949XnmxG317fwCHx0IX0CWAPwZGWob5d/dEMvk8PoKa6c/zeBYrOQvkQ1XQFKjHG8JScnszNqXgmqjVBiIzayH++6YuzvZCWQwIYF8HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn; spf=pass smtp.mailfrom=cestc.cn; arc=none smtp.client-ip=1.203.97.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cestc.cn
Received: from localhost (localhost [127.0.0.1])
	by smtp.cecloud.com (Postfix) with ESMTP id 6E7D87C0115;
	Mon, 30 Sep 2024 17:01:21 +0800 (CST)
X-MAIL-GRAY:0
X-MAIL-DELIVERY:1
X-SKE-CHECKED:1
X-ANTISPAM-LEVEL:2
Received: from localhost.localdomain (unknown [111.48.58.13])
	by smtp.cecloud.com (postfix) whith ESMTP id P880592T281472854061424S1727686879002281_;
	Mon, 30 Sep 2024 17:01:21 +0800 (CST)
X-IP-DOMAINF:1
X-RL-SENDER:zhangyanjun@cestc.cn
X-SENDER:zhangyanjun@cestc.cn
X-LOGIN-NAME:zhangyanjun@cestc.cn
X-FST-TO:trondmy@kernel.org
X-RCPT-COUNT:6
X-LOCAL-RCPT-COUNT:1
X-MUTI-DOMAIN-COUNT:0
X-SENDER-IP:111.48.58.13
X-ATTACHMENT-NUM:0
X-UNIQUE-TAG:<09c93fd3e4110ba449d17d1ad239a071>
X-System-Flag:0
From: zhangyanjun@cestc.cn
To: trondmy@kernel.org,
	anna@kernel.org
Cc: Markus.Elfring@web.de,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yanjun Zhang <zhangyanjun@cestc.cn>
Subject: [PATCH v3] NFSv4: fix possible NULL-pointer dereference in nfs42_complete_copies()
Date: Mon, 30 Sep 2024 17:01:15 +0800
Message-Id: <20240930090115.463284-1-zhangyanjun@cestc.cn>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Yanjun Zhang <zhangyanjun@cestc.cn>

On the node of an nfs client, some files saved in the mountpoint of the
nfs server were coping within the same nfs server. Accidentally, the
nfs42_complete_copies() get a NULL-pointer dereference crash, as can be
seen in following syslog:

[232064.838881] NFSv4: state recovery failed for open file nfs/pvc-12b5200d=
-cd0f-46a3-b9f0-af8f4fe0ef64.qcow2, error =3D -116
[232064.839360] NFSv4: state recovery failed for open file nfs/pvc-12b5200d=
-cd0f-46a3-b9f0-af8f4fe0ef64.qcow2, error =3D -116
[232066.588183] Unable to handle kernel NULL pointer dereference at virtual=
 address 0000000000000058
[232066.588586] Mem abort info:
[232066.588701]   ESR =3D 0x0000000096000007
[232066.588862]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[232066.589084]   SET =3D 0, FnV =3D 0
[232066.589216]   EA =3D 0, S1PTW =3D 0
[232066.589340]   FSC =3D 0x07: level 3 translation fault
[232066.589559] Data abort info:
[232066.589683]   ISV =3D 0, ISS =3D 0x00000007
[232066.589842]   CM =3D 0, WnR =3D 0
[232066.589967] user pgtable: 64k pages, 48-bit VAs, pgdp=3D00002000956ff400
[232066.590231] [0000000000000058] pgd=3D08001100ae100003, p4d=3D08001100ae=
100003, pud=3D08001100ae100003, pmd=3D08001100b3c00003, pte=3D0000000000000=
000
[232066.590757] Internal error: Oops: 96000007 [#1] SMP
[232066.590958] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_re=
solver nfs lockd grace fscache netfs ocfs2_dlmfs ocfs2_stack_o2cb ocfs2_dlm=
 vhost_net vhost vhost_iotlb tap tun ipt_rpfilter xt_multiport ip_set_hash_=
ip ip_set_hash_net xfrm_interface xfrm6_tunnel tunnel4 tunnel6 esp4 ah4 wir=
eguard libcurve25519_generic veth xt_addrtype xt_set nf_conntrack_netlink i=
p_set_hash_ipportnet ip_set_hash_ipportip ip_set_bitmap_port ip_set_hash_ip=
port dummy ip_set ip_vs_sh ip_vs_wrr ip_vs_rr ip_vs iptable_filter sch_ingr=
ess nfnetlink_cttimeout vport_gre ip_gre ip_tunnel gre vport_geneve geneve =
vport_vxlan vxlan ip6_udp_tunnel udp_tunnel openvswitch nf_conncount dm_rou=
nd_robin dm_service_time dm_multipath xt_nat xt_MASQUERADE nft_chain_nat nf=
_nat xt_mark xt_conntrack xt_comment nft_compat nft_counter nf_tables nfnet=
link ocfs2 ocfs2_nodemanager ocfs2_stackglue iscsi_tcp libiscsi_tcp libiscs=
i scsi_transport_iscsi ipmi_ssif nbd overlay 8021q garp mrp bonding tls rfk=
ill sunrpc ext4 mbcache jbd2
[232066.591052]  vfat fat cas_cache cas_disk ses enclosure scsi_transport_s=
as sg acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler ip_tables vfio_pci vfi=
o_pci_core vfio_virqfd vfio_iommu_type1 vfio dm_mirror dm_region_hash dm_lo=
g dm_mod nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 br_netfilter bridge stp=
 llc fuse xfs libcrc32c ast drm_vram_helper qla2xxx drm_kms_helper syscopya=
rea crct10dif_ce sysfillrect ghash_ce sysimgblt sha2_ce fb_sys_fops cec sha=
256_arm64 sha1_ce drm_ttm_helper ttm nvme_fc igb sbsa_gwdt nvme_fabrics drm=
 nvme_core i2c_algo_bit i40e scsi_transport_fc megaraid_sas aes_neon_bs
[232066.596953] CPU: 6 PID: 4124696 Comm: 10.253.166.125- Kdump: loaded Not=
 tainted 5.15.131-9.cl9_ocfs2.aarch64 #1
[232066.597356] Hardware name: Great Wall .\x93\x8e...RF6260 V5/GWMSSE2GL1T=
, BIOS T656FBE_V3.0.18 2024-01-06
[232066.597721] pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[232066.598034] pc : nfs4_reclaim_open_state+0x220/0x800 [nfsv4]
[232066.598327] lr : nfs4_reclaim_open_state+0x12c/0x800 [nfsv4]
[232066.598595] sp : ffff8000f568fc70
[232066.598731] x29: ffff8000f568fc70 x28: 0000000000001000 x27: ffff21003d=
b33000
[232066.599030] x26: ffff800005521ae0 x25: ffff0100f98fa3f0 x24: 0000000000=
000001
[232066.599319] x23: ffff800009920008 x22: ffff21003db33040 x21: ffff21003d=
b33050
[232066.599628] x20: ffff410172fe9e40 x19: ffff410172fe9e00 x18: 0000000000=
000000
[232066.599914] x17: 0000000000000000 x16: 0000000000000004 x15: 0000000000=
000000
[232066.600195] x14: 0000000000000000 x13: ffff800008e685a8 x12: 00000000ea=
c0c6e6
[232066.600498] x11: 0000000000000000 x10: 0000000000000008 x9 : ffff800005=
4e5828
[232066.600784] x8 : 00000000ffffffbf x7 : 0000000000000001 x6 : 000000000a=
9eb14a
[232066.601062] x5 : 0000000000000000 x4 : ffff70ff8a14a800 x3 : 0000000000=
000058
[232066.601348] x2 : 0000000000000001 x1 : 54dce46366daa6c6 x0 : 0000000000=
000000
[232066.601636] Call trace:
[232066.601749]  nfs4_reclaim_open_state+0x220/0x800 [nfsv4]
[232066.601998]  nfs4_do_reclaim+0x1b8/0x28c [nfsv4]
[232066.602218]  nfs4_state_manager+0x928/0x10f0 [nfsv4]
[232066.602455]  nfs4_run_state_manager+0x78/0x1b0 [nfsv4]
[232066.602690]  kthread+0x110/0x114
[232066.602830]  ret_from_fork+0x10/0x20
[232066.602985] Code: 1400000d f9403f20 f9402e61 91016003 (f9402c00)
[232066.603284] SMP: stopping secondary CPUs
[232066.606936] Starting crashdump kernel...
[232066.607146] Bye!

Analysing the vmcore, we know that nfs4_copy_state listed by destination
nfs_server->ss_copies was added by the field copies in handle_async_copy(),
and we found a waiting copy process with the stack as:
PID: 3511963  TASK: ffff710028b47e00  CPU: 0   COMMAND: "cp"
 #0 [ffff8001116ef740] __switch_to at ffff8000081b92f4
 #1 [ffff8001116ef760] __schedule at ffff800008dd0650
 #2 [ffff8001116ef7c0] schedule at ffff800008dd0a00
 #3 [ffff8001116ef7e0] schedule_timeout at ffff800008dd6aa0
 #4 [ffff8001116ef860] __wait_for_common at ffff800008dd166c
 #5 [ffff8001116ef8e0] wait_for_completion_interruptible at ffff800008dd1898
 #6 [ffff8001116ef8f0] handle_async_copy at ffff8000055142f4 [nfsv4]
 #7 [ffff8001116ef970] _nfs42_proc_copy at ffff8000055147c8 [nfsv4]
 #8 [ffff8001116efa80] nfs42_proc_copy at ffff800005514cf0 [nfsv4]
 #9 [ffff8001116efc50] __nfs4_copy_file_range.constprop.0 at ffff8000054ed6=
94 [nfsv4]

The NULL-pointer dereference was due to nfs42_complete_copies() listed
the nfs_server->ss_copies by the field ss_copies of nfs4_copy_state.
So the nfs4_copy_state address ffff0100f98fa3f0 was offset by 0x10 and
the data accessed through this pointer was also incorrect. Generally,
the ordered list nfs4_state_owner->so_states indicate open(O_RDWR) or
open(O_WRITE) states are reclaimed firstly by nfs4_reclaim_open_state().
When destination state reclaim is failed with NFS_STATE_RECOVERY_FAILED
and copies are not deleted in nfs_server->ss_copies, the source state
may be passed to the nfs42_complete_copies() process earlier, resulting
in this crash scene finally. To solve this issue, we add a list_head
nfs_server->ss_src_copies for a server-to-server copy specially.

Fixes: 0e65a32c8a56 ("NFS: handle source server reboot")
Signed-off-by: Yanjun Zhang <zhangyanjun@cestc.cn>
---
 fs/nfs/client.c           | 1 +
 fs/nfs/nfs42proc.c        | 2 +-
 fs/nfs/nfs4state.c        | 2 +-
 include/linux/nfs_fs_sb.h | 1 +
 4 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 8286edd60..c49d5cce5 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -983,6 +983,7 @@ struct nfs_server *nfs_alloc_server(void)
 	INIT_LIST_HEAD(&server->layouts);
 	INIT_LIST_HEAD(&server->state_owners_lru);
 	INIT_LIST_HEAD(&server->ss_copies);
+	INIT_LIST_HEAD(&server->ss_src_copies);
=20
 	atomic_set(&server->active, 0);
=20
diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 28704f924..531c9c20e 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -218,7 +218,7 @@ static int handle_async_copy(struct nfs42_copy_res *res,
=20
 	if (dst_server !=3D src_server) {
 		spin_lock(&src_server->nfs_client->cl_lock);
-		list_add_tail(&copy->src_copies, &src_server->ss_copies);
+		list_add_tail(&copy->src_copies, &src_server->ss_src_copies);
 		spin_unlock(&src_server->nfs_client->cl_lock);
 	}
=20
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 877f682b4..00516982b 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1596,7 +1596,7 @@ static void nfs42_complete_copies(struct nfs4_state_o=
wner *sp, struct nfs4_state
 			complete(&copy->completion);
 		}
 	}
-	list_for_each_entry(copy, &sp->so_server->ss_copies, src_copies) {
+	list_for_each_entry(copy, &sp->so_server->ss_src_copies, src_copies) {
 		if ((test_bit(NFS_CLNT_SRC_SSC_COPY_STATE, &state->flags) &&
 				!nfs4_stateid_match_other(&state->stateid,
 				&copy->parent_src_state->stateid)))
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 1df86ab98..793a4a610 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -240,6 +240,7 @@ struct nfs_server {
 	struct list_head	layouts;
 	struct list_head	delegations;
 	struct list_head	ss_copies;
+	struct list_head	ss_src_copies;
=20
 	unsigned long		delegation_gen;
 	unsigned long		mig_gen;
--=20
2.31.1




