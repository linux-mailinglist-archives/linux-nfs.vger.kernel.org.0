Return-Path: <linux-nfs+bounces-17575-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 107EBCFEE7F
	for <lists+linux-nfs@lfdr.de>; Wed, 07 Jan 2026 17:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 624C634ADCBA
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jan 2026 16:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C83638F23B;
	Wed,  7 Jan 2026 16:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFCwITW3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AAD2737FC
	for <linux-nfs@vger.kernel.org>; Wed,  7 Jan 2026 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767802144; cv=none; b=gy5oDAUxKvXN/F+01Dxqr/11fo0X4fUc+J/fMPixLqn3YNLWxmlxhnhHoNf/Gc0n5ahjC5XaW0naVBxX3cxPFBJYGQGo6S1f7dzpw4snyL6gTWc8H+RpOKBpIbFpJ0JAxLV2dzowCtAk5JPA9yOf3NQPVL8wHLZnvU+AoPgAW6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767802144; c=relaxed/simple;
	bh=HraiImluaigZ3E5aQN+gDenzr7g+L4U7Y9Q1MMBbgb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YTegysjUpjs9yRVer0RRbX2X5hyGLEMyfIs7bHI6a4eIFzUm6SBYCLCVlmg+V6BzC57+Uq8eo1IzImHr1esofWjnls50lo5145qGmztaEAQh3Ny/r3Opq0WNq1WOHM+LlZPOC9YxmvKHDhrGMZRtbOTMVFq9seWIouL1rLWZe1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFCwITW3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD25C4CEF1;
	Wed,  7 Jan 2026 16:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767802141;
	bh=HraiImluaigZ3E5aQN+gDenzr7g+L4U7Y9Q1MMBbgb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HFCwITW3F0uiMFWvf49H/DfF09qEUPFkRFUxooHxOj0vEErhO4ohiG3BvSHTnkqzU
	 lANPy5DqEPN46xQP0Fb22hjUoal57ylXkf7nXkW/nQQBcmTHweqf9+SFYSSUW335mr
	 +ej4SRTvLqpkP5GmxwIARPkJbB17AqNjIM5s6eoo0WyzjHLqqrISZlvc3pzJiaaKY9
	 8KH/McrZiRhV87fpnPWtE5ayHiM7QXuA2yqifw3RysCm6cLsAWOq+BaPw4MZ1xNt+X
	 C0J+LAMf9GRAJUQ+KUyHIYi1coKn5Yd3iMXtzDRCWZkfsElLK07n9YL9XHlFkbDHKj
	 g8NUDY4RKV8bA==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/4] NFS/localio: prevent direct reclaim recursion into NFS via nfs_writepages
Date: Wed,  7 Jan 2026 11:08:55 -0500
Message-ID: <20260107160858.6847-2-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260107160858.6847-1-snitzer@kernel.org>
References: <20260107160858.6847-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Snitzer <snitzer@hammerspace.com>

LOCALIO is an NFS loopback mount optimization that avoids using the
network for READ, WRITE and COMMIT if the NFS client and server are
determined to be on the same system. But because LOCALIO is still
fundamentally "just NFS loopback mount" it is susceptible to recursion
deadlock via direct reclaim, e.g.: NFS LOCALIO down to XFS and then
back into NFS via nfs_writepages.

Fix LOCALIO's potential for direct reclaim deadlock by ensuring that
all its page cache allocations are done from GFP_NOFS context.

Thanks to Ben Coddington for pointing out commit ad22c7a043c2 ("xfs:
prevent stack overflows from page cache allocation").

Reported-by: John Cagle <john.cagle@hammerspace.com>
Tested-by: Allen Lu <allen.lu@hammerspace.com>
Suggested-by: Benjamin Coddington <bcodding@hammerspace.com>
Fixes: 70ba381e1a43 ("nfs: add LOCALIO support")
Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
---
 fs/nfs/localio.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index d21047f7e4528..c38e7d4685e2f 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -291,6 +291,18 @@ nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 }
 EXPORT_SYMBOL_GPL(nfs_local_open_fh);
 
+/*
+ * Ensure all page cache allocations are done from GFP_NOFS context to
+ * prevent direct reclaim recursion back into NFS via nfs_writepages.
+ */
+static void
+nfs_local_mapping_set_gfp_nofs_context(struct address_space *m)
+{
+	gfp_t gfp_mask = mapping_gfp_mask(m);
+
+	mapping_set_gfp_mask(m, (gfp_mask & ~(__GFP_FS)));
+}
+
 static void
 nfs_local_iocb_free(struct nfs_local_kiocb *iocb)
 {
@@ -315,6 +327,7 @@ nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
 		return NULL;
 	}
 
+	nfs_local_mapping_set_gfp_nofs_context(file->f_mapping);
 	init_sync_kiocb(&iocb->kiocb, file);
 
 	iocb->hdr = hdr;
@@ -1004,6 +1017,8 @@ nfs_local_run_commit(struct file *filp, struct nfs_commit_data *data)
 			end = LLONG_MAX;
 	}
 
+	nfs_local_mapping_set_gfp_nofs_context(filp->f_mapping);
+
 	dprintk("%s: commit %llu - %llu\n", __func__, start, end);
 	return vfs_fsync_range(filp, start, end, 0);
 }
-- 
2.44.0


