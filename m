Return-Path: <linux-nfs+bounces-9548-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 255E2A1AABD
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 20:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05E6D166320
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 19:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1A81ADC90;
	Thu, 23 Jan 2025 19:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgHIMSre"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A7C7E105
	for <linux-nfs@vger.kernel.org>; Thu, 23 Jan 2025 19:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737661969; cv=none; b=ilGyg2Rlfyr3DDn0BUeoVDYSBZZJI/IVcC+lSk4DN1DXLPkVQSqvNyFmMQoasFj5rjOLuL2L3sY1WRFrUsP+bTZ+J30ohy66O6EpuAddEuuWoy/+Ie6iCuCvnVIjF2FmLiwzThsSl2QYUR3yVXhvSrSuLyt+fiNu5yFYMzu9LF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737661969; c=relaxed/simple;
	bh=Spytuyccow0fo6u3nkrQ6bjUCKHsP46lrURrpOBvSYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmoFkPa/AryOsXWvL28lkKHZJ15cnr5s1bEgy2xjo9BXilOfXfylhZYwteedF8J+C+e5BlCunjG+xLxxK9Gy0o+qz9yPFVuXZXdgGfh7lG4dhSJvv/qR5vKvNJ300byrmEY5dsxLYUW8YUB2Gf7UbI8wbiMwSPs/5X/BIbjnZHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgHIMSre; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2548C4CEE2;
	Thu, 23 Jan 2025 19:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737661969;
	bh=Spytuyccow0fo6u3nkrQ6bjUCKHsP46lrURrpOBvSYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XgHIMSreSYL27cb5JdSS0SwkeQYjZoCHKd9AwXmBv4/GZqAjd8mNaAUsignMyc93l
	 ugIVoyhBCOoRs75xnp1/jEBkGwByllDSnwRIvTiL+KFxwLnMUXYLcy3YqDj2KsbkjI
	 dARYfoMAlgwIHkk2F27cYzfuUfwMqgeDfttacezPaCdeZDKEu+x1EKlUZUmsiPjESJ
	 li+br83jSLyn/up0EVjMiV2edmTZl3xgMwhb9x86+yrLqbC7sG7YG4s0Hfe34pbded
	 TYFN9VNXhMqGPSac3vm+lQkbQrZMZGlnMwtbQJXchmcS2DUctAS4/NyxiMS639q/Mx
	 ZyfGUcvNzOodg==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 3/4] NFSD: Return NFS4ERR_FILE_OPEN only when renaming over an open file
Date: Thu, 23 Jan 2025 14:52:41 -0500
Message-ID: <20250123195242.1378601-4-cel@kernel.org>
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
 fs/nfsd/vfs.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 3ead7fb3bf04..5cfb5eb54c23 100644
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
@@ -1904,7 +1916,17 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
  out_dput_old:
 	dput(odentry);
  out_nfserr:
-	err = nfserrno(host_err);
+	if (host_err == -EBUSY) {
+		/*
+		 * See RFC 8881 Section 18.26.4 para 1-3: NFSv4 RENAME
+		 * status distinguishes between reg file and dir.
+		 */
+		if (type != S_IFDIR)
+			err = nfserr_file_open;
+		else
+			err = nfserr_acces;
+	} else
+		err = nfserrno(host_err);
 
 	if (!close_cached) {
 		fh_fill_post_attrs(ffhp);
-- 
2.47.0


