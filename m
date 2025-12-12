Return-Path: <linux-nfs+bounces-17055-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF1FCB9633
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Dec 2025 17:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CC7C3095273
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Dec 2025 16:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B4C224AF7;
	Fri, 12 Dec 2025 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dZmMSZ0i"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BE62FD1A8
	for <linux-nfs@vger.kernel.org>; Fri, 12 Dec 2025 16:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765558045; cv=none; b=QqdAAf3UDx/c8tSkI3QZ2XSH2nBJP9X6w2WcgL9swcCJst5ae2mmCiekGQ/rxo2DHtvb+WbHa3fbjyKu0IginZOnacj4SDsg5dJ+50NsTdIAzJCKNZgMH1nBAJH10ZxfCe9R7gnBwh3ZixfkjYj/EFa+O2Kz7JD2zdYH2BlLaiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765558045; c=relaxed/simple;
	bh=eHU7+cSQQ0ZX6/Ut5xv/umEp34vbdI+0wocadtrGhK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HcoUy5d9pIHzlIj2fdM5hJR/tdUOAwPRVxW7yql94kyZOhO/x9YG6q1H/nSsLSbDlXS9uX5GY5pd0PTCBChEenhrXdM9iyXqyXXEj7WrpiRFd9whOjFbDSRerh7F/ts/WIbTZEPxA5uBjTCotarTTjztVHJvn2cRUwoc4IY8fhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dZmMSZ0i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765558041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0SiW0BF/og/Rx9XNZZx2kvwAcMLSpGEPBbNXftP52A0=;
	b=dZmMSZ0i77vw0+03gdJ1QFpSHeCJRUFZERnusYWgMYluzkKSj1HqB+i+x8de5/EBbtY7aw
	HRNkJZ32fzsIH9oRFTEzkWoldhwBn1a5Kxj0YxXQdK4hKkvlGK5p536qJyG2wuAmDeFTEq
	Ujv54wyVzAKqXTjTe6gJEKuWLSnP9hI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-sOnk1uLnPn-Uh4ETMQ5gbA-1; Fri,
 12 Dec 2025 11:47:15 -0500
X-MC-Unique: sOnk1uLnPn-Uh4ETMQ5gbA-1
X-Mimecast-MFC-AGG-ID: sOnk1uLnPn-Uh4ETMQ5gbA_1765558033
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19727195FCE3;
	Fri, 12 Dec 2025 16:47:13 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.81.193])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D8C041953984;
	Fri, 12 Dec 2025 16:47:11 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neilb@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: [PATCH v2 1/1] nfsd: check that server is running in unlock_filesystem
Date: Fri, 12 Dec 2025 11:47:10 -0500
Message-ID: <20251212164711.55712-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

If we are trying to unlock the filesystem via an administrative
interface and nfsd isn't running, it crashes the server.

[   59.445578] Modules linked in: nfsd nfs_acl lockd grace nfs_localio ext4 crc16 mbcache jbd2 overlay uinput snd_seq_dummy snd_hrtimer qrtr rfkill vfat fat uvcvideo snd_hda_codec_generic videobuf2_vmalloc videobuf2_memops uvc videobuf2_v4l2 videobuf2_common snd_hda_intel snd_intel_dspcfg snd_hda_codec videodev snd_hda_core snd_hwdep mc snd_seq snd_seq_device snd_pcm snd_timer snd soundcore sg loop auth_rpcgss vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vmw_vmci vsock xfs ghash_ce nvme e1000e nvme_core nvme_keyring nvme_auth hkdf sr_mod cdrom vmwgfx drm_ttm_helper ttm 8021q garp stp llc mrp sunrpc dm_mirror dm_region_hash dm_log iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi fuse dm_multipath dm_mod nfnetlink
[   59.451979] CPU: 4 UID: 0 PID: 5193 Comm: bash Kdump: loaded Tainted: G    B               6.18.0-rc4+ #74 PREEMPT(voluntary)
[   59.453311] Tainted: [B]=BAD_PAGE
[   59.453913] Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VMW201.00V.24006586.BA64.2406042154 06/04/2024
[   59.454869] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[   59.455463] pc : nfsd4_revoke_states+0x1b4/0x898 [nfsd]
[   59.456069] lr : nfsd4_revoke_states+0x19c/0x898 [nfsd]
[   59.456701] sp : ffff80008cd67900
[   59.457115] x29: ffff80008cd679d0 x28: 1fffe00016a53f84 x27: dfff800000000000
[   59.458006] x26: 04b800ef00000000 x25: 1fffe00016a53f80 x24: ffff0000a796ea00
[   59.458872] x23: ffff0000b89d6000 x22: ffff0000b6c36900 x21: ffff0000b6c36580
[   59.459738] x20: ffff80008cd67990 x19: ffff0000b6c365c0 x18: 0000000000000000
[   59.460602] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[   59.461480] x14: 0000000000000000 x13: 0000000000000001 x12: ffff7000119acf13
[   59.462272] x11: 1ffff000119acf12 x10: ffff7000119acf12 x9 : dfff800000000000
[   59.463002] x8 : ffff80008cd67810 x7 : 0000000000000000 x6 : 0097001de0000000
[   59.463732] x5 : 0000000000000004 x4 : ffff0000b5818000 x3 : 04b800ef00000004
[   59.464368] x2 : 0000000000000000 x1 : 0000000000000005 x0 : 04b800ef00000000
[   59.465072] Call trace:
[   59.465308]  nfsd4_revoke_states+0x1b4/0x898 [nfsd] (P)
[   59.465830]  write_unlock_fs+0x258/0x440 [nfsd]
[   59.466278]  nfsctl_transaction_write+0xb0/0x120 [nfsd]
[   59.466780]  vfs_write+0x1f0/0x938
[   59.467088]  ksys_write+0xfc/0x1f8
[   59.467395]  __arm64_sys_write+0x74/0xb8
[   59.467746]  invoke_syscall.constprop.0+0xdc/0x1e8
[   59.468177]  do_el0_svc+0x154/0x1d8
[   59.468489]  el0_svc+0x40/0xe0
[   59.468767]  el0t_64_sync_handler+0xa0/0xe8
[   59.469138]  el0t_64_sync+0x1ac/0x1b0
[   59.469472] Code: 91001343 92400865 d343fc66 110004a1 (38fb68c0)
[   59.470012] SMP: stopping secondary CPUs

-- v2 changes to address Neil's comments/suggestions
changing nfsd4_revoke_states() to take in nfsd_net
holding nfsd_mutex over nfsd4_revoke_states (making sure to unlock
and cleanup before return)

Fixes: 1ac3629bf0125 ("nfsd: prepare for supporting admin-revocation of state")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfsd/nfs4state.c |  3 +--
 fs/nfsd/nfsctl.c    | 11 ++++++++++-
 fs/nfsd/state.h     |  4 ++--
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 35004568d43e..191d67973e31 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1769,9 +1769,8 @@ static struct nfs4_stid *find_one_sb_stid(struct nfs4_client *clp,
  * The clients which own the states will subsequently being notified that the
  * states have been "admin-revoked".
  */
-void nfsd4_revoke_states(struct net *net, struct super_block *sb)
+void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb)
 {
-	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	unsigned int idhashval;
 	unsigned int sc_types;
 
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 2b79129703d5..35bb94f49392 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -259,6 +259,7 @@ static ssize_t write_unlock_fs(struct file *file, char *buf, size_t size)
 	struct path path;
 	char *fo_path;
 	int error;
+	struct nfsd_net *nn;
 
 	/* sanity check */
 	if (size == 0)
@@ -285,7 +286,15 @@ static ssize_t write_unlock_fs(struct file *file, char *buf, size_t size)
 	 * 3.  Is that directory the root of an exported file system?
 	 */
 	error = nlmsvc_unlock_all_by_sb(path.dentry->d_sb);
-	nfsd4_revoke_states(netns(file), path.dentry->d_sb);
+	mutex_lock(&nfsd_mutex);
+	nn = net_generic(netns(file), nfsd_net_id);
+	if (!nn->nfsd_serv) {
+		error = -EINVAL;
+		goto out;
+	}
+	nfsd4_revoke_states(nn, path.dentry->d_sb);
+out:
+	mutex_unlock(&nfsd_mutex);
 
 	path_put(&path);
 	return error;
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 1e736f402426..bf3394a01375 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -841,9 +841,9 @@ static inline void get_nfs4_file(struct nfs4_file *fi)
 struct nfsd_file *find_any_file(struct nfs4_file *f);
 
 #ifdef CONFIG_NFSD_V4
-void nfsd4_revoke_states(struct net *net, struct super_block *sb);
+void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb);
 #else
-static inline void nfsd4_revoke_states(struct net *net, struct super_block *sb)
+static inline void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb)
 {
 }
 #endif
-- 
2.47.3


