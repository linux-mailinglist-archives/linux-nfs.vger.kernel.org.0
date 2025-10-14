Return-Path: <linux-nfs+bounces-15249-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CAFBDAE0F
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Oct 2025 20:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B08FC3ADCF0
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Oct 2025 18:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6B8307AD4;
	Tue, 14 Oct 2025 18:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GrFOJghT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AF2308F0F
	for <linux-nfs@vger.kernel.org>; Tue, 14 Oct 2025 18:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760464812; cv=none; b=GiuTbQ2aezRPzb5vk1zaq0g4xERPi5gubCiwXT5wq/8qJDKE5BtTHyYDbx2B/MsIyITr+AX9pJY0/l2FijLvedxtLYuD0/40scYS5JoihK4MsGx2xB+YXU1IM0kiUK9n2Rh9QBUPwPERDZF8tGEdMULFy2+/WdxrKZMvNP7B+IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760464812; c=relaxed/simple;
	bh=KWVTjcesUUB94XgIPdzVx9P9HoXXQ9tnWEx6ImIeAp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s54+nvrx5tEOGwore5MVNPEFA2haFUaj4Yi5OyWdlSJ84Sk68wGakZ+1nmaXvlI1rItfnjEMlCKZL+Lh3nIyh7Y5wdGhkHDYjsnuLD3ZTn0Ig44mxTLXS5+50hFPru55sHXRT2krAqxxOMSsOQCoYrPlzULm/PZ5VD3vMv/RoWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GrFOJghT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760464808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hUiZpcNG1S0cuWDnzt6wrXgoLj0raKHUEulfDM4wBGw=;
	b=GrFOJghTGwNisbZiyaceWJbEVtiddx2JwqnzSwnSF7sOHQAKL8Vtf+Bd9SxbWVNMN4vTn5
	cGYh9BUnOMa+aRmspjexnFQLGdFHjQPjVX3R2MDOGlRY4hOnNwLYWkhh58BDvUrlWJCvsh
	nlktEVz4qYcQUK5gfMDqTolMhBNjO8o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-9-FwJyn-NH2bxf7PeHSw8Q-1; Tue,
 14 Oct 2025 14:00:03 -0400
X-MC-Unique: 9-FwJyn-NH2bxf7PeHSw8Q-1
X-Mimecast-MFC-AGG-ID: 9-FwJyn-NH2bxf7PeHSw8Q_1760464802
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D810A1800378;
	Tue, 14 Oct 2025 18:00:01 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.81.146])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7E18119560B9;
	Tue, 14 Oct 2025 18:00:00 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neilb@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: [PATCH 1/1] NFSD: free copynotify stateid in nfs4_free_ol_stateid()
Date: Tue, 14 Oct 2025 13:59:59 -0400
Message-ID: <20251014175959.90513-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Typically copynotify stateid is freed either when parent's stateid
is being close/freed or in nfsd4_laundromat if the stateid hasn't
been used in a lease period.

However, in case when the server got an OPEN (which created
a parent stateid), followed by a COPY_NOTIFY using that stateid,
followed by a client reboot. New client instance while doing
CREATE_SESSION would force expire previous state of this client.
It leads to the open state being freed thru release_openowner->
nfs4_free_ol_stateid() and it finds that it still has copynotify
stateid associated with it. We currently print a warning and is
triggerred

WARNING: CPU: 1 PID: 8858 at fs/nfsd/nfs4state.c:1550 nfs4_free_ol_stateid+0xb0/0x100 [nfsd]

This patch, instead, frees the associated copynotify stateid here.

If the parent stateid is freed (without freeing the copynotify
stateids associated with it), it leads to the list corruption
when laundromat ends up freeing the copynotify state later.

[ 1626.839430] Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
[ 1626.842828] Modules linked in: nfnetlink_queue nfnetlink_log bluetooth cfg80211 rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd nfs_acl lockd grace nfs_localio ext4 crc16 mbcache jbd2 overlay uinput snd_seq_dummy snd_hrtimer qrtr rfkill vfat fat uvcvideo snd_hda_codec_generic videobuf2_vmalloc videobuf2_memops snd_hda_intel uvc snd_intel_dspcfg videobuf2_v4l2 videobuf2_common snd_hda_codec snd_hda_core videodev snd_hwdep snd_seq mc snd_seq_device snd_pcm snd_timer snd soundcore sg loop auth_rpcgss vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vmw_vmci vsock xfs 8021q garp stp llc mrp nvme ghash_ce e1000e nvme_core sr_mod nvme_keyring nvme_auth cdrom vmwgfx drm_ttm_helper ttm sunrpc dm_mirror dm_region_hash dm_log iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi fuse dm_multipath dm_mod nfnetlink
[ 1626.855594] CPU: 2 UID: 0 PID: 199 Comm: kworker/u24:33 Kdump: loaded Tainted: G    B   W           6.17.0-rc7+ #22 PREEMPT(voluntary)
[ 1626.857075] Tainted: [B]=BAD_PAGE, [W]=WARN
[ 1626.857573] Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VMW201.00V.24006586.BA64.2406042154 06/04/2024
[ 1626.858724] Workqueue: nfsd4 laundromat_main [nfsd]
[ 1626.859304] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[ 1626.860010] pc : __list_del_entry_valid_or_report+0x148/0x200
[ 1626.860601] lr : __list_del_entry_valid_or_report+0x148/0x200
[ 1626.861182] sp : ffff8000881d7a40
[ 1626.861521] x29: ffff8000881d7a40 x28: 0000000000000018 x27: ffff0000c2a98200
[ 1626.862260] x26: 0000000000000600 x25: 0000000000000000 x24: ffff8000881d7b20
[ 1626.862986] x23: ffff0000c2a981e8 x22: 1fffe00012410e7d x21: ffff0000920873e8
[ 1626.863701] x20: ffff0000920873e8 x19: ffff000086f22998 x18: 0000000000000000
[ 1626.864421] x17: 20747562202c3839 x16: 3932326636383030 x15: 3030666666662065
[ 1626.865092] x14: 6220646c756f6873 x13: 0000000000000001 x12: ffff60004fd9e4a3
[ 1626.865713] x11: 1fffe0004fd9e4a2 x10: ffff60004fd9e4a2 x9 : dfff800000000000
[ 1626.866320] x8 : 00009fffb0261b5e x7 : ffff00027ecf2513 x6 : 0000000000000001
[ 1626.866938] x5 : ffff00027ecf2510 x4 : ffff60004fd9e4a3 x3 : 0000000000000000
[ 1626.867553] x2 : 0000000000000000 x1 : ffff000096069640 x0 : 000000000000006d
[ 1626.868167] Call trace:
[ 1626.868382]  __list_del_entry_valid_or_report+0x148/0x200 (P)
[ 1626.868876]  _free_cpntf_state_locked+0xd0/0x268 [nfsd]
[ 1626.869368]  nfs4_laundromat+0x6f8/0x1058 [nfsd]
[ 1626.869813]  laundromat_main+0x24/0x60 [nfsd]
[ 1626.870231]  process_one_work+0x584/0x1050
[ 1626.870595]  worker_thread+0x4c4/0xc60
[ 1626.870893]  kthread+0x2f8/0x398
[ 1626.871146]  ret_from_fork+0x10/0x20
[ 1626.871422] Code: aa1303e1 aa1403e3 910e8000 97bc55d7 (d4210000)
[ 1626.871892] SMP: stopping secondary CPUs

Fixes: 624322f1adc5 ("NFSD add COPY_NOTIFY operation")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfsd/nfs4state.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 1c01836e8507..c197438765db 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1542,7 +1542,8 @@ static void nfs4_free_ol_stateid(struct nfs4_stid *stid)
 	release_all_access(stp);
 	if (stp->st_stateowner)
 		nfs4_put_stateowner(stp->st_stateowner);
-	WARN_ON(!list_empty(&stid->sc_cp_list));
+	if (!list_empty(&stid->sc_cp_list))
+		nfs4_free_cpntf_statelist(stid->sc_client->net, stid);
 	kmem_cache_free(stateid_slab, stid);
 }
 
-- 
2.47.3


