Return-Path: <linux-nfs+bounces-9640-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D54A1CEE0
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 22:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5061886F24
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 21:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90C11607B4;
	Sun, 26 Jan 2025 21:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVI+DpRD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8378F25A64F
	for <linux-nfs@vger.kernel.org>; Sun, 26 Jan 2025 21:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737928227; cv=none; b=Txiwpbvy6nhDePoe4aU5VJUgdBeyy2ydaZURrpAiEsTas9Mr6i1Gm2EgSRkqtdJPZPMUbryioXv0pNoScttaybxnPZEOJBc04v+6URmJPf1Edo5ajSVf9av3NlSGUYjT08A9kuUeR2hKYWddiKhFaR/WS/ZNqpBhawWShW39y9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737928227; c=relaxed/simple;
	bh=ctRaMSQCF8ndZCswqoz+G5wXIBNqy1MQ5SX5tZq9stE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pocs4t6YNTLThZwAsIMzpf/qDhlRrkLJ3MW6GS8X/Wkbp8RiUvUCrp8/V2V2zirzGUfl2u+adFP58VNIZL2eqhV0FCL73ZKPyhmpdeDNMyiBgoF/8RWN+P6n9rhs6eavWoA1/Bhimn3lo2FFZH1TWgklLbgCwjf/KahS55fytB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVI+DpRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3F4C4CED3;
	Sun, 26 Jan 2025 21:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737928227;
	bh=ctRaMSQCF8ndZCswqoz+G5wXIBNqy1MQ5SX5tZq9stE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GVI+DpRDPP8ENwXhBYnQiyYEv48Kg7H52lidRA6nMP/Q+K//nPlo4SMcWHgytBOMC
	 ycuWD6+83YwlnKm+y45hJ63uAY7fPgOAMQSZr4MLfbV09PbaszcLy8JBPNmBZgqDCV
	 jYJjQqJZh6gT4wrOWXhZ87Cpc1C3XAvxEm5Kg9UEZydyQ8OyUOBWgvKpcUsZPSnj+C
	 +dlV692APKJRS88cmcZDv6eXGW3aIcAJdNO/x0rQ5wQUxmoZPPD/deqitZIw2mzA4l
	 B1c0xFv2Nz6o3pt0SnYGdBjCUeBvNsFRLr37i8ziaRrB/kxD9IVkQupi1ZAuRAMhQO
	 5noL38xSgC5fA==
From: cel@kernel.org
To: Amir Goldstein <amir73il@gmail.com>,
	Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 3/4] NFSD: Return NFS4ERR_FILE_OPEN only when renaming over an open file
Date: Sun, 26 Jan 2025 16:50:19 -0500
Message-ID: <20250126215020.2466-4-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250126215020.2466-1-cel@kernel.org>
References: <20250126215020.2466-1-cel@kernel.org>
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
 fs/nfsd/vfs.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 6cd130b5c2b6..347114da4fd0 100644
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
@@ -1862,11 +1873,14 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	host_err = -EINVAL;
 	if (odentry == trap)
 		goto out_dput_old;
+	type = d_inode(odentry)->i_mode & S_IFMT;
 
 	ndentry = lookup_one_len(tname, tdentry, tlen);
 	host_err = PTR_ERR(ndentry);
 	if (IS_ERR(ndentry))
 		goto out_dput_old;
+	if (d_inode(ndentry))
+		type = d_inode(ndentry)->i_mode & S_IFMT;
 	host_err = -ENOTEMPTY;
 	if (ndentry == trap)
 		goto out_dput_new;
@@ -1904,7 +1918,18 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
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


