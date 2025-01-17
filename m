Return-Path: <linux-nfs+bounces-9343-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04435A15476
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2025 17:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 026503A8320
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2025 16:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EDD19F127;
	Fri, 17 Jan 2025 16:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQY2dVOU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1215819F47E
	for <linux-nfs@vger.kernel.org>; Fri, 17 Jan 2025 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737131591; cv=none; b=iJhehS4oJUBjk3WTZmPtdi4wxo262QaWwyfxhacS7npesEjkXk7VLq+qPa+xb/hAync8LeIDMiA2bA696ewDpAIRUu5WdELG4N1KNpDEFaWooysVADEa9XaNh3Gv+HofIgMy865RSW3QgNCn+AY8v0dl99igLFC27Qbl7yZ3E70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737131591; c=relaxed/simple;
	bh=HK/4/ppyD9uqNCngbCzJRIR/OgIbDfMbmy/xryrtbIE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ciq6RS4z8RaewZ7+K0a2+Yb/ifBUvUbzy7sfJ2fxbGrmCc9rp+KEf9ztsfmAwIxSrKQmHoExIV84KDVCslZy1gQ90UvMRM2uqVEOnX6YramKfat5EU47HPH6B/aPNuonEmmubwWYBqm7j8/sbQp12ZjIAnexV8+5eHii0gaa28w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jQY2dVOU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737131589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ru/vwkeKSjgJVRnD/6xHjyd9VAusIrSoT64KJaSDug8=;
	b=jQY2dVOUT83BRzNtAxJAgcYd2m9Y+d1zugA26ln8flZE4Q3hxEeAbEHwJ7kacJnp92dcaa
	jD1+MDPQP+/X28PUwbgbdsiZurzYTEadtA0Sm7QkUVLY2FQjIA7b9iStSYSjp/8PVoBjt9
	XN7Inl/Az9RPUUwES6Hx892yTooYfhU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-moywrpHUOaCGY8eJ7-CvkA-1; Fri,
 17 Jan 2025 11:33:04 -0500
X-MC-Unique: moywrpHUOaCGY8eJ7-CvkA-1
X-Mimecast-MFC-AGG-ID: moywrpHUOaCGY8eJ7-CvkA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C3201955D4E;
	Fri, 17 Jan 2025 16:33:03 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.89.195])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9D37E19560A3;
	Fri, 17 Jan 2025 16:33:01 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neilb@suse.de,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH 1/1] nfsd: fix management of listener transports
Date: Fri, 17 Jan 2025 11:32:58 -0500
Message-Id: <20250117163258.52885-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Currently, when no active threads are running, a root user using nfsdctl
command can try to remove a particular listener from the list of previously
added ones, then start the server by increasing the number of threads,
it leads to the following problem:

[  158.835354] refcount_t: addition on 0; use-after-free.
[  158.835603] WARNING: CPU: 2 PID: 9145 at lib/refcount.c:25 refcount_warn_saturate+0x160/0x1a0
[  158.836017] Modules linked in: rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd auth_rpcgss nfs_acl lockd grace overlay isofs uinput snd_seq_dummy snd_hrtimer nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill ip_set nf_tables qrtr sunrpc vfat fat uvcvideo videobuf2_vmalloc videobuf2_memops uvc videobuf2_v4l2 videodev videobuf2_common snd_hda_codec_generic mc e1000e snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hda_core snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd soundcore sg loop dm_multipath dm_mod nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vmw_vmci vsock xfs libcrc32c crct10dif_ce ghash_ce vmwgfx sha2_ce sha256_arm64 sr_mod sha1_ce cdrom nvme drm_client_lib drm_ttm_helper ttm nvme_core drm_kms_helper nvme_auth drm fuse
[  158.840093] CPU: 2 UID: 0 PID: 9145 Comm: nfsd Kdump: loaded Tainted: G    B   W          6.13.0-rc6+ #7
[  158.840624] Tainted: [B]=BAD_PAGE, [W]=WARN
[  158.840802] Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VMW201.00V.24006586.BA64.2406042154 06/04/2024
[  158.841220] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[  158.841563] pc : refcount_warn_saturate+0x160/0x1a0
[  158.841780] lr : refcount_warn_saturate+0x160/0x1a0
[  158.842000] sp : ffff800089be7d80
[  158.842147] x29: ffff800089be7d80 x28: ffff00008e68c148 x27: ffff00008e68c148
[  158.842492] x26: ffff0002e3b5c000 x25: ffff600011cd1829 x24: ffff00008653c010
[  158.842832] x23: ffff00008653c000 x22: 1fffe00011cd1829 x21: ffff00008653c028
[  158.843175] x20: 0000000000000002 x19: ffff00008653c010 x18: 0000000000000000
[  158.843505] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[  158.843836] x14: 0000000000000000 x13: 0000000000000001 x12: ffff600050a26493
[  158.844143] x11: 1fffe00050a26492 x10: ffff600050a26492 x9 : dfff800000000000
[  158.844475] x8 : 00009fffaf5d9b6e x7 : ffff000285132493 x6 : 0000000000000001
[  158.844823] x5 : ffff000285132490 x4 : ffff600050a26493 x3 : ffff8000805e72bc
[  158.845174] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000098588000
[  158.845528] Call trace:
[  158.845658]  refcount_warn_saturate+0x160/0x1a0 (P)
[  158.845894]  svc_recv+0x58c/0x680 [sunrpc]
[  158.846183]  nfsd+0x1fc/0x348 [nfsd]
[  158.846390]  kthread+0x274/0x2f8
[  158.846546]  ret_from_fork+0x10/0x20
[  158.846714] ---[ end trace 0000000000000000 ]---

nfsd_nl_listener_set_doit() would manipulate the list of transports of
server's sv_permsocks and close the specified listener but the other
list of transports (server's sp_xprts list) would not be changed leading
to the problem above.

Instead, determined if the nfsdctl is trying to remove a listener, in
which case, delete all the existing listener transports and re-create
all-but-the-removed ones.

Fixes: 16a471177496 ("NFSD: add listener-{set,get} netlink command")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfsd/nfsctl.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 95ea4393305b..079c1fe2eee7 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1918,6 +1918,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 	LIST_HEAD(permsocks);
 	struct nfsd_net *nn;
 	int err, rem;
+	bool delete = false;
 
 	mutex_lock(&nfsd_mutex);
 
@@ -1977,35 +1978,26 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 
-	/* For now, no removing old sockets while server is running */
-	if (serv->sv_nrthreads && !list_empty(&permsocks)) {
+	/* If we have listener transports left on permsocks list, it means
+	 * we are asked to remove a listener
+	 */
+	if (!list_empty(&permsocks)) {
 		list_splice_init(&permsocks, &serv->sv_permsocks);
-		spin_unlock_bh(&serv->sv_lock);
-		err = -EBUSY;
-		goto out_unlock_mtx;
+		delete = true;
 	}
+	spin_unlock_bh(&serv->sv_lock);
 
-	/* Close the remaining sockets on the permsocks list */
-	while (!list_empty(&permsocks)) {
-		xprt = list_first_entry(&permsocks, struct svc_xprt, xpt_list);
-		list_move(&xprt->xpt_list, &serv->sv_permsocks);
-
-		/*
-		 * Newly-created sockets are born with the BUSY bit set. Clear
-		 * it if there are no threads, since nothing can pick it up
-		 * in that case.
+	/* Not removing old listener transports while server is running */
+	if (serv->sv_nrthreads) {
+		err = -EBUSY;
+		goto out_unlock_mtx;
+	} else if (delete) {
+		/* since we can't delete a single entry, we will destroy
+		 * all remaining listeners and recreate the list
 		 */
-		if (!serv->sv_nrthreads)
-			clear_bit(XPT_BUSY, &xprt->xpt_flags);
-
-		set_bit(XPT_CLOSE, &xprt->xpt_flags);
-		spin_unlock_bh(&serv->sv_lock);
-		svc_xprt_close(xprt);
-		spin_lock_bh(&serv->sv_lock);
+		svc_xprt_destroy_all(serv, net);
 	}
 
-	spin_unlock_bh(&serv->sv_lock);
-
 	/* walk list of addrs again, open any that still don't exist */
 	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
 		struct nlattr *tb[NFSD_A_SOCK_MAX + 1];
@@ -2031,6 +2023,9 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 
 		xprt = svc_find_listener(serv, xcl_name, net, sa);
 		if (xprt) {
+			if (delete)
+				WARN_ONCE("Transport type=%s already exists\n",
+					  xcl_name);
 			svc_xprt_put(xprt);
 			continue;
 		}
-- 
2.47.1


