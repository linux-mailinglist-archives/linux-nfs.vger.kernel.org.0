Return-Path: <linux-nfs+bounces-10535-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A0CA57E05
	for <lists+linux-nfs@lfdr.de>; Sat,  8 Mar 2025 21:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0A0D3B2EC7
	for <lists+linux-nfs@lfdr.de>; Sat,  8 Mar 2025 20:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5BE1FC7D9;
	Sat,  8 Mar 2025 20:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O10wDYIu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7FF2A8C1
	for <linux-nfs@vger.kernel.org>; Sat,  8 Mar 2025 20:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741464884; cv=none; b=GPMa8n1sJ3simSCCsVO5+zhvbvqVa2A+wvKwiVP5Qo503/g5+tFFdaRM920lXioDcClo57ZWCZk2DFJrG30KENQRWzvejKU8yYHUjjHkpN1DrD8Zogob59R7l2VksqhvBRTzPJ3VBvkRxkKMGvgdsimf7TR7EF+jhGnME5nkMPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741464884; c=relaxed/simple;
	bh=Qc50ehoHiynfD5nMMbT9mmBoCXzoOB5NQF1YnTQ7VV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CbSk69oRh0jFaKaR3bdg1kOeG7af6CeL4WKibwdE2k8h7wSwSYdwxxhBMEYs0/hgJt04HCQSlGeB6SXgvQZHOAsKuOAYjWVE1b9yvUY3eW1gUXzoGv1J+rWFUpjnmqNYuE2QHlWvWHvFB8vSGDvQp4ljB4toWeBnj5hRU5O1rlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O10wDYIu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E3AC4CEE8;
	Sat,  8 Mar 2025 20:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741464883;
	bh=Qc50ehoHiynfD5nMMbT9mmBoCXzoOB5NQF1YnTQ7VV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O10wDYIunWDweMyDONgreH5FIE4EVvsi2Yd5/ZkGPr/SZ84Sq9RnhQd7agREDbKvd
	 vUWz+RaWv55wBCd75LbF88tjYjllh5TVKwXatEOig1gbd3TvfEOr/XE5mu49RU+nTQ
	 yVuz1JXT6SMs5lVjLrFvDw/HaqmNV3NrTaaR3/Vh1rY1BbDfW+hIZMMPtUI+7xTy7Q
	 JRtJEetZrQTWhS0g5xNM/WbEB0n8NE7Ak/7vZSx47+zFpiq08XC7Y2g5d8yNJy3XjM
	 Q/lSsgCi3Ye88/JCJlf8TmfNxR3HtMYQdWPLiSw/EM55tNkoNmEJHkYjhd/JHPDfud
	 11ZAKZuWi5ORA==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 2/2] NFSD: Add experimental setting to disable the use of splice read
Date: Sat,  8 Mar 2025 15:14:38 -0500
Message-ID: <20250308201438.2217-3-cel@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250308201438.2217-1-cel@kernel.org>
References: <20250308201438.2217-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

NFSD currently has two separate code paths for handling read
requests. One uses page splicing; the other is a traditional read
based on an iov iterator.

Because most Linux file systems support splice read, the latter
does not get nearly the same test experience as splice reads.

To force the use of vectored reads for testing and benchmarking,
introduce the ability to disable splice reads for all NFS READ
operations.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/debugfs.c | 29 +++++++++++++++++++++++++++++
 fs/nfsd/nfsd.h    |  2 ++
 fs/nfsd/vfs.c     |  4 ++++
 3 files changed, 35 insertions(+)

diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
index e913268d9c2d..894938fea97b 100644
--- a/fs/nfsd/debugfs.c
+++ b/fs/nfsd/debugfs.c
@@ -6,6 +6,32 @@
 
 static struct dentry *nfsd_top_dir __read_mostly;
 
+/*
+ * /sys/kernel/debug/nfsd/disable-splice-read
+ *
+ * Contents:
+ *   %0: NFS READ is allowed to use page splicing
+ *   %1: NFS READ uses only iov iter read
+ *
+ * The default value of this setting is zero (page splicing is
+ * allowed). This setting is effective for all NFS versions, all
+ * exports, and in all NFSD net namespaces.
+ */
+
+static int nfsd_dsr_get(void *data, u64 *val)
+{
+	*val = nfsd_disable_splice_read ? 1 : 0;
+	return 0;
+}
+
+static int nfsd_dsr_set(void *data, u64 val)
+{
+	nfsd_disable_splice_read = (val > 0) ? true : false;
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(nfsd_dsr_fops, nfsd_dsr_get, nfsd_dsr_set, "%llu\n");
+
 void nfsd_debugfs_exit(void)
 {
 	debugfs_remove_recursive(nfsd_top_dir);
@@ -15,4 +41,7 @@ void nfsd_debugfs_exit(void)
 void nfsd_debugfs_init(void)
 {
 	nfsd_top_dir = debugfs_create_dir("nfsd", NULL);
+
+	debugfs_create_file("disable-splice-read", S_IWUSR | S_IRUGO,
+			    nfsd_top_dir, NULL, &nfsd_dsr_fops);
 }
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 8a53ddab5df0..232aee06223d 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -164,6 +164,8 @@ static inline void nfsd_debugfs_init(void) {}
 static inline void nfsd_debugfs_exit(void) {}
 #endif
 
+extern bool nfsd_disable_splice_read __read_mostly;
+
 extern int nfsd_max_blksize;
 
 static inline int nfsd_v4client(struct svc_rqst *rq)
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 29cb7b812d71..30b0b192f1fa 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -47,6 +47,8 @@
 
 #define NFSDDBG_FACILITY		NFSDDBG_FILEOP
 
+bool nfsd_disable_splice_read __read_mostly;
+
 /**
  * nfserrno - Map Linux errnos to NFS errnos
  * @errno: POSIX(-ish) error code to be mapped
@@ -1237,6 +1239,8 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
  */
 bool nfsd_read_splice_ok(struct svc_rqst *rqstp)
 {
+	if (nfsd_disable_splice_read)
+		return false;
 	switch (svc_auth_flavor(rqstp)) {
 	case RPC_AUTH_GSS_KRB5I:
 	case RPC_AUTH_GSS_KRB5P:
-- 
2.48.1


