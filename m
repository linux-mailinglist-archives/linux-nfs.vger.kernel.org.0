Return-Path: <linux-nfs+bounces-3862-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4160290A1B3
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 03:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5991F215AE
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 01:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDBA8BF8;
	Mon, 17 Jun 2024 01:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loaz9KiA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1A28836
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718587511; cv=none; b=VX0kaihqQNtNFj1uhC33a+XpP1xsh5ni9iidDkIm++kN8EsXh1S5p+2o5v/7pUcZbH6cbBhYNQnaEB/HaefxFpqbJAIQsOVk6fUY37aiQxf6eCmtaNLucCpWRxawacPToe/iyV5j19EuVay5Pt3IbF3jFz9Mwe9gYijWI99tUxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718587511; c=relaxed/simple;
	bh=yDabwdVXNqxnlWBF+9EKtfdYgtedLWLI9u8TZ7oUUXE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXcanmdKmK69pptioCPVbgVO64batMZ90YOhKzcDqhuedIWBROZ74og8gQmfdESmjWRIfs1EC5nrnr34Icy2FMXkALzEr2k1XXWWr51KCxE4SNOh8k92DnZL/25DbFhHI1yo6R+e6cx4y0xNulkyhJKZDuOc31F088uZ4H5jR6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loaz9KiA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A10C4AF1C
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718587511;
	bh=yDabwdVXNqxnlWBF+9EKtfdYgtedLWLI9u8TZ7oUUXE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=loaz9KiAcTSSZA91g815IhBdIJVzdel4lsoa60SOyyT4cZy9kcuDXhIMgKThjsded
	 Qr+s82QYyGpIFvv06ap43eI9rnZJHkL8jF7yfSh2w02D1CsNEGImCayDXU4LeENUFj
	 adrLSwdMxlBViozgY9kHDMZpPIN1WsOOzF2W5+T2o2UCXCvSt7FhxX9hCvqYo4Lowj
	 hna7e8PzvGJEcljAOrKr2bEqntmJR2kLmJl9/I/r9HztzU8ybV3hu/thDAH94u368S
	 24WiFnCsMLX8RyCadfg3qTCawDrrslpe6vllRCX1nqKY9mmI3WYHt/uynSvx5cja67
	 Tj6pZkIqTcYyQ==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Subject: [PATCH v2 03/19] NFSv4: Add new attribute delegation definitions
Date: Sun, 16 Jun 2024 21:21:21 -0400
Message-ID: <20240617012137.674046-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240617012137.674046-3-trondmy@kernel.org>
References: <20240617012137.674046-1-trondmy@kernel.org>
 <20240617012137.674046-2-trondmy@kernel.org>
 <20240617012137.674046-3-trondmy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@primarydata.com>

Add the attribute delegation XDR definitions from the spec.

Signed-off-by: Tom Haynes <loghyr@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c         | 2 +-
 include/linux/nfs4.h      | 9 +++++++++
 include/uapi/linux/nfs4.h | 2 ++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 7f294085e887..90df37f3866a 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3852,7 +3852,7 @@ static void nfs4_close_context(struct nfs_open_context *ctx, int is_sync)
 
 #define FATTR4_WORD1_NFS40_MASK (2*FATTR4_WORD1_MOUNTED_ON_FILEID - 1UL)
 #define FATTR4_WORD2_NFS41_MASK (2*FATTR4_WORD2_SUPPATTR_EXCLCREAT - 1UL)
-#define FATTR4_WORD2_NFS42_MASK (2*FATTR4_WORD2_XATTR_SUPPORT - 1UL)
+#define FATTR4_WORD2_NFS42_MASK (2*FATTR4_WORD2_TIME_DELEG_MODIFY - 1UL)
 
 static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *fhandle)
 {
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 0d896ce296ce..c074e0ac390f 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -367,6 +367,8 @@ enum open_delegation_type4 {
 	NFS4_OPEN_DELEGATE_READ = 1,
 	NFS4_OPEN_DELEGATE_WRITE = 2,
 	NFS4_OPEN_DELEGATE_NONE_EXT = 3, /* 4.1 */
+	NFS4_OPEN_DELEGATE_READ_ATTRS_DELEG = 4,
+	NFS4_OPEN_DELEGATE_WRITE_ATTRS_DELEG = 5,
 };
 
 enum why_no_delegation4 { /* new to v4.1 */
@@ -507,6 +509,11 @@ enum {
 	FATTR4_XATTR_SUPPORT		= 82,
 };
 
+enum {
+	FATTR4_TIME_DELEG_ACCESS	= 84,
+	FATTR4_TIME_DELEG_MODIFY	= 85,
+};
+
 /*
  * The following internal definitions enable processing the above
  * attribute bits within 32-bit word boundaries.
@@ -586,6 +593,8 @@ enum {
 #define FATTR4_WORD2_SECURITY_LABEL     BIT(FATTR4_SEC_LABEL - 64)
 #define FATTR4_WORD2_MODE_UMASK		BIT(FATTR4_MODE_UMASK - 64)
 #define FATTR4_WORD2_XATTR_SUPPORT	BIT(FATTR4_XATTR_SUPPORT - 64)
+#define FATTR4_WORD2_TIME_DELEG_ACCESS	BIT(FATTR4_TIME_DELEG_ACCESS - 64)
+#define FATTR4_WORD2_TIME_DELEG_MODIFY	BIT(FATTR4_TIME_DELEG_MODIFY - 64)
 
 /* MDS threshold bitmap bits */
 #define THRESHOLD_RD                    (1UL << 0)
diff --git a/include/uapi/linux/nfs4.h b/include/uapi/linux/nfs4.h
index 1d2043708bf1..afd7e32906c3 100644
--- a/include/uapi/linux/nfs4.h
+++ b/include/uapi/linux/nfs4.h
@@ -69,6 +69,8 @@
 #define NFS4_SHARE_SIGNAL_DELEG_WHEN_RESRC_AVAIL	0x10000
 #define NFS4_SHARE_PUSH_DELEG_WHEN_UNCONTENDED		0x20000
 
+#define NFS4_SHARE_WANT_DELEG_TIMESTAMPS		0x100000
+
 #define NFS4_CDFC4_FORE	0x1
 #define NFS4_CDFC4_BACK 0x2
 #define NFS4_CDFC4_BOTH 0x3
-- 
2.45.2


