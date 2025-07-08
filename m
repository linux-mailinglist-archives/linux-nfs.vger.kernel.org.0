Return-Path: <linux-nfs+bounces-12939-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C0EAFD07B
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 18:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF5818868BE
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 16:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385E72E49A8;
	Tue,  8 Jul 2025 16:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4kfdKOp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D032E266B
	for <linux-nfs@vger.kernel.org>; Tue,  8 Jul 2025 16:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751991672; cv=none; b=ZZwWCy2FhvLVFEZM7ZcH/KcPbja+Gj2HeNEpka5q2jfBw807aC/111Y1eRJ3WcvTYUxZe8uX0bCUoZfIDZ73NA+F8LdCY/By9QNGIrIRMg1FDeU+KPr5QuNmXRgb+Xk2vaCoqkNIVeI/HSkQLc/fp/S0hxXgifHA80D2S3Qadvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751991672; c=relaxed/simple;
	bh=IUKPAq/+MMmBodQVm4Oz3DELYiy4wBzRvp/wVCdqymw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sM85ROSsbiFBWJFkl72U7G9CYZgEWsoDKGXPia4w2iOX+E2j4YcRPeiTs3XProD5n1YRwrx5D7vGa+wwAKDcNMlPf07UcR7hXxp+F1uY/RCW6CbOIzOjr1HRwXGgNLC+qOp8/XABDoNhwfIouQTx7/UuylBLkC+3YWn3bt3LNPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4kfdKOp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78410C4CEED;
	Tue,  8 Jul 2025 16:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751991671;
	bh=IUKPAq/+MMmBodQVm4Oz3DELYiy4wBzRvp/wVCdqymw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i4kfdKOpndiMdhxVL8zqr9Q6N4cRpKZFw3+3M2GF+zT2EcT1USu2nW/nNfegEdc3w
	 JWE3eRWAEpK8GjEUT3wISHT36070N2C2DzJhrOPIItKgzZB295yXT6Kflk7X5sYQdg
	 a1ts8YFbvwu2T7WvSG8aTncTwJtTri76yM1YIfuLYMLrpsu+zOmRTJ4RtWXo7HezuU
	 Xy+YFFOwWwMhxOCnQUH5j7Wt5NQsR5IzxhUEIGbNsPvl7e8JEd7m5XCly5TEZYOM4L
	 tqFNEVlyPuu0OasvvlA7HrxlaQotCz4hMIDqXCaxabIiSEYuNgYyboq0PhbxWmOCut
	 ameY6KwCc/pPw==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	snitzer@kernel.org,
	Mike Snitzer <snitzer@hammerspace.com>
Subject: [RFC PATCH 2/6] nfs/localio: add localio_async_probe modparm
Date: Tue,  8 Jul 2025 12:20:43 -0400
Message-ID: <20250708162047.65017-3-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250708162047.65017-1-snitzer@kernel.org>
References: <20250708162047.65017-1-snitzer@kernel.org>
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
index b728b9305a0f..c05dc8a09653 100644
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


