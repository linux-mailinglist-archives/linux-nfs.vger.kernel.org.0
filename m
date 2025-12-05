Return-Path: <linux-nfs+bounces-16963-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A8CCA9532
	for <lists+linux-nfs@lfdr.de>; Fri, 05 Dec 2025 21:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 319F3313C14D
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Dec 2025 20:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2AF36B069;
	Fri,  5 Dec 2025 18:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cK2nRCcr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D5836B061
	for <linux-nfs@vger.kernel.org>; Fri,  5 Dec 2025 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764960128; cv=none; b=d1eFmKYVnFfqY943xuZBC8k75JqqKYwyZnCgp0EWNkOvgKD2PLLZiNGjH5W/8HoyH02HIh1YpGHnh2niabvx+/ISXZrM2zQk78ZzToPkZhSvnvtE3zQmgmyozqiXNVh2i6RjCTTgsOfeaseIZhPwp5k2KCrVcZhR5rerNRGhfoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764960128; c=relaxed/simple;
	bh=oXVwtTeWYUkM3jX7hpWDHKK7TCPZ0s2cMIPCKsERX9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hKAl9OtO0GYWDPBGyInFX6LTDD1OrvKUT1rkEyh3vq0tR7R+ketoVy6+cK6qKbsBlAo/gW0TqXYh2oK73c2tVjeYHmeECvJQ6h5qKmd0QrjCODmDNs2Vl9A3mKomhAe5zNLA5zpB1tGMrQSKz6Kp7jzLNdqEmzjlM98iftHQhj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cK2nRCcr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764960125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7MQiJqQiqUP1+KMyhn41p5RfeBv+OofzT26keorvkng=;
	b=cK2nRCcrW73mn91HI8hWTF3UlwCjkRAqxqu2flXmLQCocxQyvL0EGm6HkgfqhvMTmiG5sl
	pwLDFECgCe6HdbAQZL0GBcvy/HoblPg/K1icN+f3ZimrTrbbAmE8XyHVltVvG7fULywWBI
	7uhYmkXMowMk74lXdy+Hb7JBKhKM+7U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-nc9JB8siMR-habMOi9588A-1; Fri,
 05 Dec 2025 13:42:00 -0500
X-MC-Unique: nc9JB8siMR-habMOi9588A-1
X-Mimecast-MFC-AGG-ID: nc9JB8siMR-habMOi9588A_1764960119
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D07941956095;
	Fri,  5 Dec 2025 18:41:58 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.65.211])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4E9B41800357;
	Fri,  5 Dec 2025 18:41:57 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neilb@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: [PATCH 1/1] nfsd: check that server is running in unlock_filesystem
Date: Fri,  5 Dec 2025 13:41:56 -0500
Message-ID: <20251205184156.10983-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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
[   59.472070] Starting crashdump kernel...
[   59.472537] Bye!

Fixes: 1ac3629bf0125 ("nfsd: prepare for supporting admin-revocation of state")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfsd/nfs4state.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 35004568d43e..faa874eff1e9 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1775,6 +1775,9 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
 	unsigned int idhashval;
 	unsigned int sc_types;
 
+	if (!nn->nfsd_serv)
+		return;
+
 	sc_types = SC_TYPE_OPEN | SC_TYPE_LOCK | SC_TYPE_DELEG | SC_TYPE_LAYOUT;
 
 	spin_lock(&nn->client_lock);
-- 
2.47.3


