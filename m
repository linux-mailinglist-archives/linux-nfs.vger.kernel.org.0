Return-Path: <linux-nfs+bounces-3874-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B7F90A1C2
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 03:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E704CB21B58
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 01:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E9318EA8;
	Mon, 17 Jun 2024 01:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMu05A8O"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41763182DF
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718587516; cv=none; b=bdlN3m555xa9juDap2RS+65LGnSsh36VJmjq2sx8WQ65aMZ3FtBT3SdNKYAZZF5yhJ/Qc9zdl8lNzchzRnBinxNoWxDo2ibEf4YMAM4UdPoGC/haRCNaxG/dZtTplKJZtJ3fhwj5erH1bTDbxpqYRz35+AvsuqHlshPKvDqwDZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718587516; c=relaxed/simple;
	bh=AelsKPKkKq6V8JmwXj1j8mt7xWzcsElbBaV3WfIhePY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VqaFfC2aqn9ZSafhuJDBayMg1gkLhutocajyaIMf2Q8U6vYExJpqi6YgVDKKnbcCcdRU9CIA5VCzvnrPzIcKByz2KYzlsXad+5avZY9eHG2ScKwC1lbU39cGtMEBk5kQRFv1UNVxyovqrsdSaoqNYynSiRHqKUGxtJXHGUqTnOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMu05A8O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77D3C4AF48
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718587515;
	bh=AelsKPKkKq6V8JmwXj1j8mt7xWzcsElbBaV3WfIhePY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mMu05A8O6jvatHagERmv/uku+SNgT8iljzYCfOFRG7WDY/AGMWeRhyhpJnX0VqxbM
	 CxM3kTNCU/7b00KyxQpL8/YchbsvYpVh4YtXqLn0wrtHmT9OASjcA4EwoHw+InsoS7
	 yCZRry9TikDVI501rQk2jxPVSWE0v31WjD42RUthq83hQhKEVQSCWxIq1rZCupuSvi
	 vl/pudxCegvlbDfC72/EkYS1hFO3FEfuDv3iggFgcYTGA0klLpum2qbkRlywIOTUup
	 sH8C+rMFoMkhpF6II5AJ2bxLa7Wtv53+AiIpsSz8/4KH2h9/RsiIfIKzrYGQaeLYxW
	 oecZNg72L8QRg==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Subject: [PATCH v2 15/19] NFSv4: Detect support for OPEN4_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION
Date: Sun, 16 Jun 2024 21:21:33 -0400
Message-ID: <20240617012137.674046-16-trondmy@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240617012137.674046-15-trondmy@kernel.org>
References: <20240617012137.674046-1-trondmy@kernel.org>
 <20240617012137.674046-2-trondmy@kernel.org>
 <20240617012137.674046-3-trondmy@kernel.org>
 <20240617012137.674046-4-trondmy@kernel.org>
 <20240617012137.674046-5-trondmy@kernel.org>
 <20240617012137.674046-6-trondmy@kernel.org>
 <20240617012137.674046-7-trondmy@kernel.org>
 <20240617012137.674046-8-trondmy@kernel.org>
 <20240617012137.674046-9-trondmy@kernel.org>
 <20240617012137.674046-10-trondmy@kernel.org>
 <20240617012137.674046-11-trondmy@kernel.org>
 <20240617012137.674046-12-trondmy@kernel.org>
 <20240617012137.674046-13-trondmy@kernel.org>
 <20240617012137.674046-14-trondmy@kernel.org>
 <20240617012137.674046-15-trondmy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@primarydata.com>

If the server supports the NFSv4.2 protocol extension to optimise away
returning a stateid when it returns a delegation, then we cache that
information in another capability flag.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c         | 4 ++++
 include/linux/nfs_fs_sb.h | 1 +
 include/uapi/linux/nfs4.h | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index ae91492e9521..adf4fc8610f6 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3990,6 +3990,10 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 				sizeof(server->attr_bitmask));
 		server->attr_bitmask_nl[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
 
+		if (res.open_caps.oa_share_access_want[0] &
+		    NFS4_SHARE_WANT_OPEN_XOR_DELEGATION)
+			server->caps |= NFS_CAP_OPEN_XOR;
+
 		memcpy(server->cache_consistency_bitmask, res.attr_bitmask, sizeof(server->cache_consistency_bitmask));
 		server->cache_consistency_bitmask[0] &= FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE;
 		server->cache_consistency_bitmask[1] &= FATTR4_WORD1_TIME_METADATA|FATTR4_WORD1_TIME_MODIFY;
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 5a76a87cd924..fe5b1a8bd723 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -278,6 +278,7 @@ struct nfs_server {
 #define NFS_CAP_LGOPEN		(1U << 5)
 #define NFS_CAP_CASE_INSENSITIVE	(1U << 6)
 #define NFS_CAP_CASE_PRESERVING	(1U << 7)
+#define NFS_CAP_OPEN_XOR	(1U << 12)
 #define NFS_CAP_DELEGTIME	(1U << 13)
 #define NFS_CAP_POSIX_LOCK	(1U << 14)
 #define NFS_CAP_UIDGID_NOMAP	(1U << 15)
diff --git a/include/uapi/linux/nfs4.h b/include/uapi/linux/nfs4.h
index afd7e32906c3..caf4db2fcbb9 100644
--- a/include/uapi/linux/nfs4.h
+++ b/include/uapi/linux/nfs4.h
@@ -46,6 +46,7 @@
 #define NFS4_OPEN_RESULT_CONFIRM		0x0002
 #define NFS4_OPEN_RESULT_LOCKTYPE_POSIX		0x0004
 #define NFS4_OPEN_RESULT_PRESERVE_UNLINKED	0x0008
+#define NFS4_OPEN_RESULT_NO_OPEN_STATEID	0x0010
 #define NFS4_OPEN_RESULT_MAY_NOTIFY_LOCK	0x0020
 
 #define NFS4_SHARE_ACCESS_MASK	0x000F
@@ -70,6 +71,7 @@
 #define NFS4_SHARE_PUSH_DELEG_WHEN_UNCONTENDED		0x20000
 
 #define NFS4_SHARE_WANT_DELEG_TIMESTAMPS		0x100000
+#define NFS4_SHARE_WANT_OPEN_XOR_DELEGATION		0x200000
 
 #define NFS4_CDFC4_FORE	0x1
 #define NFS4_CDFC4_BACK 0x2
-- 
2.45.2


