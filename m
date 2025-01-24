Return-Path: <linux-nfs+bounces-9588-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1458FA1B8AA
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 16:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34C4A3A3269
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 15:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053B314D70B;
	Fri, 24 Jan 2025 15:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0rEMyYP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AE015534B
	for <linux-nfs@vger.kernel.org>; Fri, 24 Jan 2025 15:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737731760; cv=none; b=k34iwuGifWgM91E3h/5DhyxXordqLK0ngxCvSYMCtNpTy3Z50HKZlg6uAkH/HuC2ZNGl67WYyMPx09sldeve2hmM8xCZokZgPnNEDQqyvw8EV9wh7/+sBH80YRsYYp/CWDn6A2DHYJe0f5+F8q41JQ4FVLu+tDlLNfdy75I2l+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737731760; c=relaxed/simple;
	bh=sSiVgBOKSiUMkm8BTFROvWjivQi03fKFirFyqsuBK8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bap6MbCZU7I5d9/6nXYDYTbgHmgpayE0UlbvQBa5MrEDbKFG1Y5KCy3/Yb9oKldqTS2/agtOa6S4SSv8bz/g4rJ7i8EHfWaYIR2VFtHoWKXdztKeP3KOafdQqwBnp/TfOV5+7s7IcpcZG0e3A11tGqHL31IZerz1z5AVZaohyT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0rEMyYP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B18C4CEE4;
	Fri, 24 Jan 2025 15:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737731760;
	bh=sSiVgBOKSiUMkm8BTFROvWjivQi03fKFirFyqsuBK8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I0rEMyYP0+0jTLSpuUAtJ1MZ/B+YqEoWGL9QpgzGnUwD+/bYquBUTZy+n6iRzzlgR
	 aEgKEyJQcH0mYFl4iJO6brZpVtffgRJCUyNspX8gC7M5jKf5mE/XwESPYW9X8gKwXx
	 Xoo3KpOZKoYWoh1YRq8p7m6rvfYmB6rEn9xTRz3fHdfBbhVtZcBUSI8Bl3wJLjJ3Ti
	 zS0GiiqTYjAcD031gM9SsBvjCCXfFNUiN/8XktU2jUIzUyhgQ+RPnte7CYi8kM7l3y
	 tAsLqQUeMoHfSyrQN4GKpGe+jxu/h36T2DrJ1oFMa8FksySdT6eWSFbeVahhyNyb2Y
	 s+rGpliT0PFqg==
From: cel@kernel.org
To: Amir Goldstein <amir73il@gmail.com>,
	Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 4/4] NFSD: Return NFS4ERR_FILE_OPEN only when linking an open file
Date: Fri, 24 Jan 2025 10:15:53 -0500
Message-ID: <20250124151553.17824-5-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250124151553.17824-1-cel@kernel.org>
References: <20250124151553.17824-1-cel@kernel.org>
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

The VFS is unlikely to return -EBUSY, but NFSD has to ensure that
errno does not leak to clients as a status code that is not
permitted by spec.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 44 +++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 532128b34161..494f14e122fc 100644
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
+		 * wants a status unique to the object type.
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


