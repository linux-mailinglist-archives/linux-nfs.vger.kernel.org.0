Return-Path: <linux-nfs+bounces-9587-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43719A1B8A9
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 16:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4443516AF84
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 15:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F1515530C;
	Fri, 24 Jan 2025 15:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+iOnTY+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455B014D70B
	for <linux-nfs@vger.kernel.org>; Fri, 24 Jan 2025 15:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737731760; cv=none; b=FFyfM/K9gX8SGTa45NtWc3sfVIgX5Eom14s3rLDxTCoIzU+iLxgiqFiKsC2ribktWNr6E62/em6XAeIeSWz16hB1BkpSOrnFbr0Mgkaxa+Ug14dRg51YUMYlE2ndnobgwuXcO9ZsI3UH8Z2YgYMjdcYuWeN3fzSBYZh9ktpiE1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737731760; c=relaxed/simple;
	bh=lpNCV+uemF9qbqZ1KLuBEdBLEqE7r+bzQZhA5FKroQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXHxsi0RtNBEyWuqRtIHFZuo8iUPBu7RnVfVAv8L/HY3pJOVg/Z1B6fmtZugfZo9vJR/kdDQwk7nNxzTSc1jEZJ1yFV3fAcILRnEi04RzjpnQLDFFWknaVk+uJROoJX6lBKhIcpCAeeZfVutSe1zfI8xDH1B+lpyDkDFCOeRPbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+iOnTY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045BDC4CED2;
	Fri, 24 Jan 2025 15:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737731759;
	bh=lpNCV+uemF9qbqZ1KLuBEdBLEqE7r+bzQZhA5FKroQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y+iOnTY+07BtciuTxAfgX8PRA9CISTWjwDTGbHk1LKaRvpGPHb0Zhv5OdQhcSJv/j
	 UaeCU8ZDUFm1kjhffbNeBHBrslhlO9SmLtA7lM3QepdoKjgaWuqIacqiCt5wGXBI+d
	 d02kV8ibDTNT4AxnBcNKG7pdr01o4KorwNR2n8ccC5aMzgZ+Lp6miOW2wUAGABObll
	 5khQ4LnfnB3TbCaAuMitmFzgBa7ilySTBd+P5dbCdjgbjdOog6e5noNzw4eWtRnufs
	 sGXf+eyvh0Ci4wwi/EEmSi4uet2ICHOmqsjPlMTKi7lNuCtbrj1UvBV0MYdBi+Cfw1
	 lLIg43E9u1P0w==
From: cel@kernel.org
To: Amir Goldstein <amir73il@gmail.com>,
	Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 3/4] NFSD: Return NFS4ERR_FILE_OPEN only when renaming over an open file
Date: Fri, 24 Jan 2025 10:15:52 -0500
Message-ID: <20250124151553.17824-4-cel@kernel.org>
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

RFC 8881 Section 18.26.4 paragraphs 1 - 3 tell us that RENAME should
return NFS4ERR_FILE_OPEN only when the target object is a file that
is currently open. If the target is a directory, some other status
must be returned.

Generally I expect that a delegation recall will be triggered in
some of these circumstances. In other cases, the VFS might return
-EBUSY for other reasons, and NFSD has to ensure that errno does
not leak to clients as a status code that is not permitted by spec.

There are some error flows where the target dentry hasn't been
found yet. The default value for @type therefore is S_IFDIR to return
an alternate status code in those cases.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 6cd130b5c2b6..532128b34161 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1795,9 +1795,19 @@ nfsd_has_cached_files(struct dentry *dentry)
 	return ret;
 }
 
-/*
- * Rename a file
- * N.B. After this call _both_ ffhp and tfhp need an fh_put
+/**
+ * nfsd_rename - rename a directory entry
+ * @rqstp: RPC transaction context
+ * @ffhp: the file handle of parent directory containing the entry to be renamed
+ * @fname: the filename of directory entry to be renamed
+ * @flen: the length of @fname in octets
+ * @tfhp: the file handle of parent directory to contain the renamed entry
+ * @tname: the filename of the new entry
+ * @tlen: the length of @tlen in octets
+ *
+ * After this call _both_ ffhp and tfhp need an fh_put.
+ *
+ * Returns a generic NFS status code in network byte-order.
  */
 __be32
 nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
@@ -1805,6 +1815,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 {
 	struct dentry	*fdentry, *tdentry, *odentry, *ndentry, *trap;
 	struct inode	*fdir, *tdir;
+	int		type = S_IFDIR;
 	__be32		err;
 	int		host_err;
 	bool		close_cached = false;
@@ -1867,6 +1878,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	host_err = PTR_ERR(ndentry);
 	if (IS_ERR(ndentry))
 		goto out_dput_old;
+	type = d_inode(ndentry)->i_mode & S_IFMT;
 	host_err = -ENOTEMPTY;
 	if (ndentry == trap)
 		goto out_dput_new;
@@ -1904,7 +1916,18 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
  out_dput_old:
 	dput(odentry);
  out_nfserr:
-	err = nfserrno(host_err);
+	if (host_err == -EBUSY) {
+		/*
+		 * See RFC 8881 Section 18.26.4 para 1-3: NFSv4 RENAME
+		 * wants a status unique to the object type.
+		 */
+		if (type != S_IFDIR)
+			err = nfserr_file_open;
+		else
+			err = nfserr_acces;
+	} else {
+		err = nfserrno(host_err);
+	}
 
 	if (!close_cached) {
 		fh_fill_post_attrs(ffhp);
-- 
2.47.0


