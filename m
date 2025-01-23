Return-Path: <linux-nfs+bounces-9549-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FECA1AABC
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 20:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2F9D1883103
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 19:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DC2191F8E;
	Thu, 23 Jan 2025 19:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUOWysSh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E137E105
	for <linux-nfs@vger.kernel.org>; Thu, 23 Jan 2025 19:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737661970; cv=none; b=kg+bEtN7f4DWqaMDC5OYW7feqEvVLMCopnE+zweEIAUCUVk7c2k52VJw0bTLlWnvnfbRPrsQpgeFmqQd6M05JhX0uuY74CgJ1TfBzzjXxuiiFefAR/Jo9O9PUzYChAIY+vPGeU2SQqzhqRrRsv6RXJcuo3GFIBG0h8/5NKGm0Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737661970; c=relaxed/simple;
	bh=RdLHGc4i0BeNbFMb4ZVieqeEJEHPiEWqsizdAmF6Du4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dcOXlRSPWqOxddR2YBpLPjuXarpkRTo6Yyl9zCAg5VGiiJet6L0m35+ts1GOwp3ew8nR2OX71C8YxvkwkH2tdaMRE2wRJPcqxq9aoDTzkJ5GSOsNCi5WyNUGRMWQxLj8YyB4X16z8BfsA0UNstKtHsCY9QcIo47mVGtSKKdl8bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUOWysSh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF57C4CEDF;
	Thu, 23 Jan 2025 19:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737661970;
	bh=RdLHGc4i0BeNbFMb4ZVieqeEJEHPiEWqsizdAmF6Du4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jUOWysShEVLUdfh2TwM2FsePewZGme80kgRiRbn9VoeDoUg4d29xLgspS/5dn7zf/
	 82qTnGDvDc22g/nzkixH/zfdBzDs1VIgIsE0Djd7fqWPfQt6ecdBBKWQ3RQxBFa9dY
	 rWmf9ZfjZU+4rYcGjE07A9h4rgRuT7UpPsmhkRGs5qoozov0o81JjnZGpFvfBsbvdE
	 /UHr31eHkBU4zndHiTsZG2KRlGLevsqU/WBXXuoLWm2RslVpA5eL/HLTigUPRqzuvr
	 UHC4yfEdgFigwNNWW/oncPJGEZ4xpiwhCJSSs6s8VA+IoMdLtu3cFYHG6VpL/K+RJe
	 4uPJhVZm9NtpA==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 4/4] NFSD: Return NFS4ERR_FILE_OPEN only when linking an open file
Date: Thu, 23 Jan 2025 14:52:42 -0500
Message-ID: <20250123195242.1378601-5-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250123195242.1378601-1-cel@kernel.org>
References: <20250123195242.1378601-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

RFC 8881 Section 18.9.4 paragraphs 1 - 2 tell us that RENAME should
return NFS4ERR_FILE_OPEN only when the target object is a file that
is currently open. If the target is a directory, some other status
must be returned.

Generally I expect that a delegation recall will be triggered in
some of these circumstances. In other cases, the VFS might return
-EBUSY for other reasons, and NFSD has to ensure that errno does
not leak to clients as a status code that is not permitted by spec.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 44 +++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 5cfb5eb54c23..566b9adf2259 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1699,9 +1699,17 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	return err;
 }
 
-/*
- * Create a hardlink
- * N.B. After this call _both_ ffhp and tfhp need an fh_put
+/**
+ * nfsd_link - create a link
+ * @rqstp: RPC transaction context
+ * @ffhp: the file handle of the directory where the new link is to be created
+ * @name: the filename of the new link
+ * @len: the length of @name in octets
+ * @tfhp: the file handle of an existing file object
+ *
+ * After this call _both_ ffhp and tfhp need an fh_put.
+ *
+ * Returns a generic NFS status code in network byte-order.
  */
 __be32
 nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
@@ -1709,6 +1717,7 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 {
 	struct dentry	*ddir, *dnew, *dold;
 	struct inode	*dirp;
+	int		type;
 	__be32		err;
 	int		host_err;
 
@@ -1728,11 +1737,11 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 	if (isdotent(name, len))
 		goto out;
 
+	err = nfs_ok;
+	type = d_inode(tfhp->fh_dentry)->i_mode & S_IFMT;
 	host_err = fh_want_write(tfhp);
-	if (host_err) {
-		err = nfserrno(host_err);
+	if (host_err)
 		goto out;
-	}
 
 	ddir = ffhp->fh_dentry;
 	dirp = d_inode(ddir);
@@ -1740,7 +1749,7 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 
 	dnew = lookup_one_len(name, ddir, len);
 	if (IS_ERR(dnew)) {
-		err = nfserrno(PTR_ERR(dnew));
+		host_err = PTR_ERR(dnew);
 		goto out_unlock;
 	}
 
@@ -1756,17 +1765,26 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 	fh_fill_post_attrs(ffhp);
 	inode_unlock(dirp);
 	if (!host_err) {
-		err = nfserrno(commit_metadata(ffhp));
-		if (!err)
-			err = nfserrno(commit_metadata(tfhp));
-	} else {
-		err = nfserrno(host_err);
+		host_err = commit_metadata(ffhp);
+		if (!host_err)
+			host_err = commit_metadata(tfhp);
 	}
+
 	dput(dnew);
 out_drop_write:
 	fh_drop_write(tfhp);
+	if (host_err == -EBUSY) {
+		/*
+		 * See RFC 8881 Section 18.9.4 para 1-2: NFSv4 LINK
+		 * status distinguishes between reg file and dir.
+		 */
+		if (type != S_IFDIR)
+			err = nfserr_file_open;
+		else
+			err = nfserr_acces;
+	}
 out:
-	return err;
+	return err != nfs_ok ? err : nfserrno(host_err);
 
 out_dput:
 	dput(dnew);
-- 
2.47.0


