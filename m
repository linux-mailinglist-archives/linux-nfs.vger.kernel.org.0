Return-Path: <linux-nfs+bounces-6696-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FD2989647
	for <lists+linux-nfs@lfdr.de>; Sun, 29 Sep 2024 18:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4320B1C20D29
	for <lists+linux-nfs@lfdr.de>; Sun, 29 Sep 2024 16:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0B414EC7D;
	Sun, 29 Sep 2024 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpulZuD7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F292B9B7
	for <linux-nfs@vger.kernel.org>; Sun, 29 Sep 2024 16:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727627420; cv=none; b=d+I8TwDRDcHbYyUl1iN7YarF8Tlbe3y1PgjkrK5s1U+G7xg19dJ7ckfeLgrI7bt4/DGVheauahi1VWImF1eNNE6LWScEIN70PzJGZ28gVk21rKSh2ZlLsaEpD7XFmU3nq8siSztC3g41U3liwC5/04kkhKBSOE9gkI7p9rORRvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727627420; c=relaxed/simple;
	bh=5KtTnpQev6xhIQxVCcHFFjBd75qG9m+gybMvSg8152g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t1hgdKhlYDyn8cIIg1wN+vSHHPEn3czyNTKkebuHz82rSUjIVw3eBhnEoimT2e376QFq1YCNUURV4vrCVLkWWdSSwC4fzTzDQLKnbsooqhLtrNjctvVCpQtIcA/HfwlGZxI/zFk2oIjX1yPfuSe6N6i/XwNcyrQvK6fCsy/V5AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpulZuD7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67B9C4CEC5;
	Sun, 29 Sep 2024 16:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727627419;
	bh=5KtTnpQev6xhIQxVCcHFFjBd75qG9m+gybMvSg8152g=;
	h=From:To:Cc:Subject:Date:From;
	b=WpulZuD78vkWn+1yFzeKlbY7voEVBgt3TXrvty7779in8H5JajE9Q0P7MvTUqGBh6
	 vmCUzCUzBuaC8N18y0og0gzQB9B81LTxQF7DSk4exzW8ZryQKU265w4w6mtuTjhTNF
	 0PpgZlVYGnDllfX0rw8yGYO+7ZUdGs0nUB2UdUSjKOh4w5gZBvVude3BONnH0LLT+6
	 COrqHY05Hbs2PgUsYZJuNi3R4jnetj8MIJTfP1BrGom0yXD9H+LXZjLDzxaMTKiENQ
	 LodXQW4uxdrONJyJi8jez+PQjoI9hjr9jEFUzrPnb/vuGGslgfjHkQ4CL3aHz4oN23
	 6RhS+KPBCplyg==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] NFSD: Remove unused function parameter
Date: Sun, 29 Sep 2024 12:29:43 -0400
Message-ID: <20240929162943.10915-1-cel@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Clean up: Commit 65294c1f2c5e ("nfsd: add a new struct file caching
facility to nfsd") moved the fh_verify() call site out of
nfsd_open(). That was the only user of nfsd_open's @rqstp parameter,
so that parameter can be removed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c |  3 +--
 fs/nfsd/vfs.c       | 11 ++++-------
 fs/nfsd/vfs.h       |  4 ++--
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 19bb88c7eebd..8158406bac18 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -1121,8 +1121,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct net *net,
 			status = nfs_ok;
 			trace_nfsd_file_opened(nf, status);
 		} else {
-			ret = nfsd_open_verified(rqstp, fhp, may_flags,
-						 &nf->nf_file);
+			ret = nfsd_open_verified(fhp, may_flags, &nf->nf_file);
 			if (ret == -EOPENSTALE && stale_retry) {
 				stale_retry = false;
 				nfsd_file_unhash(nf);
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 22325b590e17..d0bf4ffa5543 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -861,8 +861,7 @@ int nfsd_open_break_lease(struct inode *inode, int access)
  * N.B. After this call fhp needs an fh_put
  */
 static int
-__nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
-			int may_flags, struct file **filp)
+__nfsd_open(struct svc_fh *fhp, umode_t type, int may_flags, struct file **filp)
 {
 	struct path	path;
 	struct inode	*inode;
@@ -937,7 +936,7 @@ nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
 retry:
 	err = fh_verify(rqstp, fhp, type, may_flags);
 	if (!err) {
-		host_err = __nfsd_open(rqstp, fhp, type, may_flags, filp);
+		host_err = __nfsd_open(fhp, type, may_flags, filp);
 		if (host_err == -EOPENSTALE && !retried) {
 			retried = true;
 			fh_put(fhp);
@@ -950,7 +949,6 @@ nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
 
 /**
  * nfsd_open_verified - Open a regular file for the filecache
- * @rqstp: RPC request
  * @fhp: NFS filehandle of the file to open
  * @may_flags: internal permission flags
  * @filp: OUT: open "struct file *"
@@ -958,10 +956,9 @@ nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
  * Returns zero on success, or a negative errno value.
  */
 int
-nfsd_open_verified(struct svc_rqst *rqstp, struct svc_fh *fhp, int may_flags,
-		   struct file **filp)
+nfsd_open_verified(struct svc_fh *fhp, int may_flags, struct file **filp)
 {
-	return __nfsd_open(rqstp, fhp, S_IFREG, may_flags, filp);
+	return __nfsd_open(fhp, S_IFREG, may_flags, filp);
 }
 
 /*
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 3ff146522556..854fb95dfdca 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -114,8 +114,8 @@ __be32		nfsd_setxattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 int 		nfsd_open_break_lease(struct inode *, int);
 __be32		nfsd_open(struct svc_rqst *, struct svc_fh *, umode_t,
 				int, struct file **);
-int		nfsd_open_verified(struct svc_rqst *rqstp, struct svc_fh *fhp,
-				   int may_flags, struct file **filp);
+int		nfsd_open_verified(struct svc_fh *fhp, int may_flags,
+				struct file **filp);
 __be32		nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				struct file *file, loff_t offset,
 				unsigned long *count,
-- 
2.46.2


