Return-Path: <linux-nfs+bounces-6702-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 745F29898AC
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 02:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6AD2B2278E
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 00:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7ECF3C39;
	Mon, 30 Sep 2024 00:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQ/BMjEY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834A23C38
	for <linux-nfs@vger.kernel.org>; Mon, 30 Sep 2024 00:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727657426; cv=none; b=ek5fsqlClUdyLGTiIyy/FpcXK38riCpW0MRT5qEq5s5RLT3LxHM9OTZKDdaO+Wx6FkJ6AXPLRfdAyB9YgJ6d8IKZgMIP9UD4LKA89J5SIcKVfEdYmj0PkPwvtbg60hWletonZLeiHCoxVM52wXk7yaPk2F1J42cpVe5HIL8RNlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727657426; c=relaxed/simple;
	bh=5KtTnpQev6xhIQxVCcHFFjBd75qG9m+gybMvSg8152g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJZw1mE1vAYQtv+AZnB9KRF8woJTeYyr7MHx3W+ILZfS4e7hkUztcaCsbvG6N5cq+Y0jUGfsW8cPNmVro3if2HvQg7dFFYfF+1ePVdtaHGeac4gBqNNR83Do1ts0E04ZlDJKZd8l8wAolVf2VMNUN/jxiDAkFcCeLNu5ocDkFrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQ/BMjEY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E003C4CEC6;
	Mon, 30 Sep 2024 00:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727657426;
	bh=5KtTnpQev6xhIQxVCcHFFjBd75qG9m+gybMvSg8152g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CQ/BMjEYPv/HA0CKIxFvZg69dt7NQ6Hq9PtuB6kol0JlR09yHNB6HA+i9ZUdDIR03
	 gegj680ZYjWMlbja5v2PMmC37Io3wEFijb45wFpOPKpoNfk2VvD08KW+/qhjTTFncE
	 yXHJ2oSjflaIIF+2z8COgb8RBopO6eOlC64Gq0oRVNomdiMMytBGbViqatllEfYYtl
	 IlC+gu1Yb2oc+35NJIp4Q4IbWNI1/BbJHUwp5kZPninKKzIOVaL1b8ZEq+PdIf/tNB
	 EjRcFE1NthL3MepqVBBifjYgRakrBNN7nPYB0Uw/derftNQEYtRYvoenJPeCyORtEk
	 yZJU8F6eTR2sw==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] NFSD: Remove unused function parameter
Date: Sun, 29 Sep 2024 20:50:10 -0400
Message-ID: <20240930005016.13374-2-cel@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930005016.13374-1-cel@kernel.org>
References: <20240930005016.13374-1-cel@kernel.org>
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


