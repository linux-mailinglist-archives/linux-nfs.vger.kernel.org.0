Return-Path: <linux-nfs+bounces-13020-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBD5B034D9
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 05:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B0883B4AA7
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 03:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F4F1DE3A7;
	Mon, 14 Jul 2025 03:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7eqZIyJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9624B2E3713
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 03:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752462855; cv=none; b=ovZFhY0/3btoNBMvcrPg6tI+gr+DJnLWa6xuY9J5h0tCmwO/FqBYLMAZNFTBIJI41yFnnIoCXJJFcYsjzLDmgu26hDn7x+lV1jMdXx9KX7/JvpGmugZ5GZJAfDIMMjFTyVO/C2apAuDTyDsJ7wq3CM+hZDtcJiDpXr7HiI6x56A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752462855; c=relaxed/simple;
	bh=bR+yCHYHYnS6rbRiVhgBkVFiQCGLSf2OJToZaIdt5Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ya4uh0bYfcayXhKanIhfwMoa1o/2Qm2Tk6xSZB3AKtOTPCDUX0zCR3dO1rSFI4IjrXuzGL0WuiXAXuUVwLqBU//U6lUrO+zMg5eGJqG7v/rAIf9/GrQPq2x/ETaHf8IfIdUA1jjnlmsxewEj84IiHxzhjbofUJ9AGRw5uuY6WJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7eqZIyJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E751DC4CEE3;
	Mon, 14 Jul 2025 03:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752462854;
	bh=bR+yCHYHYnS6rbRiVhgBkVFiQCGLSf2OJToZaIdt5Hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I7eqZIyJ2q22Fu04jTKr8H2zZUKX9GAsphYFAMKUSMgWX5q+aZChpqM7vYuSQ8KCg
	 pbA1ZEIUJL5LKBJeYqNQOmhpqn4aYxPetkHF66kE8epv38JpvAuJK3+25MVnhbYgy2
	 dVSvHLGxDQ+TcugOAxZT75BxWgKa+qJ3BBRyx3oTT6dx/CTwI9Xym2hggGQwL3PsBb
	 5aiVz2EmeZB/YpiZ0FdydcTIYNXI1AGm05/RYvrG++3gLALJpDPOgPFR+U1XX/GmWX
	 aEJRhbqSE3+nr72AJW/53tDuQa07bwPPCvbh0EdyqtEMTVHecLlc53vxiRw82YgcSv
	 kWpxLSsvg8rUQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>
Cc: linux-nfs@vger.kernel.org
Subject: [for-6.16-final PATCH 9/9] nfs/localio: add localio_async_probe modparm
Date: Sun, 13 Jul 2025 23:13:59 -0400
Message-ID: <20250714031359.10192-10-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250714031359.10192-1-snitzer@kernel.org>
References: <20250714031359.10192-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Snitzer <snitzer@hammerspace.com>

This knob influences the LOCALIO handshake so that it happens
synchronously upon NFS client creation.. which reduces the window of
opportunity for a bunch of IO to flood page cache and send out over to
NFSD before LOCALIO handshake negotiates that the client and server
are local.  The knob is:
  echo N > /sys/module/nfs/parameters/localio_async_probe

Fixes: 1ff4716f420b ("NFS: always probe for LOCALIO support asynchronously")
Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
---
 fs/nfs/localio.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index e3ae003118cb..76ca9bd21d2e 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -49,6 +49,11 @@ struct nfs_local_fsync_ctx {
 static bool localio_enabled __read_mostly = true;
 module_param(localio_enabled, bool, 0644);
 
+static bool localio_async_probe __read_mostly = true;
+module_param(localio_async_probe, bool, 0644);
+MODULE_PARM_DESC(localio_async_probe,
+		 "Probe for LOCALIO support asynchronously.");
+
 static bool localio_O_DIRECT_semantics __read_mostly = false;
 module_param(localio_O_DIRECT_semantics, bool, 0644);
 MODULE_PARM_DESC(localio_O_DIRECT_semantics,
@@ -203,7 +208,10 @@ void nfs_local_probe_async_work(struct work_struct *work)
 
 void nfs_local_probe_async(struct nfs_client *clp)
 {
-	queue_work(nfsiod_workqueue, &clp->cl_local_probe_work);
+	if (likely(localio_async_probe))
+		queue_work(nfsiod_workqueue, &clp->cl_local_probe_work);
+	else
+		nfs_local_probe(clp);
 }
 EXPORT_SYMBOL_GPL(nfs_local_probe_async);
 
-- 
2.44.0


