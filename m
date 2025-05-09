Return-Path: <linux-nfs+bounces-11641-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EC7AB1D1D
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 21:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39DF6527C8A
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 19:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A912459CD;
	Fri,  9 May 2025 19:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvtB5tSP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8104E242D65;
	Fri,  9 May 2025 19:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746817453; cv=none; b=P6mIb3MVxpZR8K85YGLPuinejc06XuYe32xgKzSB9UqM4lNIa4KmxeqHiGWYHptE0eyGN9WTvxM6PecJqOCaMmTBf4Tpyd0zFgFxM4BsX6l7aEPcLZcPpBha1XOLEkTmim8ZuBGIs40VsTQi4EPtkRTU0/DaQk7xGoG95Da6Cuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746817453; c=relaxed/simple;
	bh=4SvbYqTS8sn4BsSK2OwkBodmmwjlcTc5fTO28d1y+hI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IEBGLhIlyB0TpAuFL1UuwsnWD4WocmJcSOCiJLzTWzCMag5IJAxhZVaEO+IEXUoJJeN3yG2Bq8q+JEUNBrqcmIiXi0VMOF33ZO0Wu6BGFKtHFGHi/+GGi3Fl8VJhJI0K/OzogR2cuQ1bmylexzTCvBLzYOM/GNr4qWbmUInPTXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvtB5tSP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7468C4CEE4;
	Fri,  9 May 2025 19:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746817453;
	bh=4SvbYqTS8sn4BsSK2OwkBodmmwjlcTc5fTO28d1y+hI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uvtB5tSPZ8ehIsFp50E8a6zjBB6mxDbIEf9bCi/JuQYrfMFtQC+Q+zaeMMKOptLyH
	 ROtI72bhiNU68wcx9fdKYXRV9+DIuu5qj/CTmiFDYQ2+wR7sSrynLe/rctBjczz9rR
	 hlBNHHR3FeIHjj75FCdWWVP6oaShgnglE1cjvBteyT/zriaR9xTwU5I2YulSotrtgG
	 rnnnOf35sAip/vCV1mRpya4ckz7x37RQniusOksn2quPCubKGIunLuXziDWKmASlmU
	 GUgglovowy5tA5I+yE253RA8RQ1O2TyXsktdQCUpvmCbnR4t/Jx+zSmiM92HIY15ZO
	 8Y3r/EGRysTew==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v5 19/19] SUNRPC: Bump the maximum payload size for the server
Date: Fri,  9 May 2025 15:03:53 -0400
Message-ID: <20250509190354.5393-20-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509190354.5393-1-cel@kernel.org>
References: <20250509190354.5393-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Increase the maximum server-side RPC payload to 4MB. The default
remains at 1MB.

An API to adjust the operational maximum was added in 2006 by commit
596bbe53eb3a ("[PATCH] knfsd: Allow max size of NFSd payload to be
configured"). To adjust the operational maximum using this API, shut
down the NFS server. Then echo a new value into:

  /proc/fs/nfsd/max_block_size

And restart the NFS server.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index d57df042e24a..48666b83fe68 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -119,14 +119,14 @@ void svc_destroy(struct svc_serv **svcp);
  * Linux limit; someone who cares more about NFS/UDP performance
  * can test a larger number.
  *
- * For TCP transports we have more freedom.  A size of 1MB is
- * chosen to match the client limit.  Other OSes are known to
- * have larger limits, but those numbers are probably beyond
- * the point of diminishing returns.
+ * For non-UDP transports we have more freedom.  A size of 4MB is
+ * chosen to accommodate clients that support larger I/O sizes.
  */
-#define RPCSVC_MAXPAYLOAD	(1*1024*1024u)
-#define RPCSVC_MAXPAYLOAD_TCP	RPCSVC_MAXPAYLOAD
-#define RPCSVC_MAXPAYLOAD_UDP	(32*1024u)
+enum {
+	RPCSVC_MAXPAYLOAD	= 4 * 1024 * 1024,
+	RPCSVC_MAXPAYLOAD_TCP	= RPCSVC_MAXPAYLOAD,
+	RPCSVC_MAXPAYLOAD_UDP	= 32 * 1024,
+};
 
 extern u32 svc_max_payload(const struct svc_rqst *rqstp);
 
-- 
2.49.0


