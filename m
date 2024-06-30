Return-Path: <linux-nfs+bounces-4418-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B6491D2B6
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 18:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 166A5B20C30
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 16:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5EE154C1E;
	Sun, 30 Jun 2024 16:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4fR/V92"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FD1153838
	for <linux-nfs@vger.kernel.org>; Sun, 30 Jun 2024 16:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719765466; cv=none; b=pDxJi+S8UCVyb7gv3gE+2U5HDy92lXdv71G3DIUg7OoNgfeRfGxrOkaBu+YBAsgW0McX5GQDSKyyQW6/OaNd73oP9PF3XX0cdBocdEc2rfy8bd2KPN8m0eDxbrNhluRy8cId/VGW7OI7YbEpOe+xkZVEa+NhDlBr7jto273eUoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719765466; c=relaxed/simple;
	bh=Jm3umfTGrDMXI+tJ98/TojwLInuH6vjuctnnss5tvyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fFIUAQlvbdWxC69DTfbVQbpwoARhY1A90Tltii1Et/hotZwuL2dwGdepa8QHg3caXoOcHb0wbRzp7crHr+RdRPOKBgQT1X4Vw1KCLEFiK63AUoUrpI5RRS4wwQuytzlDoUyXZxNhFAdTCswa9Z3KB6AR9h/UU2pDdu+871xSca4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4fR/V92; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F8EC2BD10;
	Sun, 30 Jun 2024 16:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719765465;
	bh=Jm3umfTGrDMXI+tJ98/TojwLInuH6vjuctnnss5tvyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O4fR/V92MLg9Y3VGuHL9+OlTEonmxJ/+wR1xIladr6+Xp0EGrELUPLk4Bbe750SrR
	 D6SBpXeKpF3kBrbMwhqtjm7++oggEnChVjIZfNd3ZT9xbuhKjpoDIXpzPelTmgWMxz
	 gBPXGj6zszRKBXzjqTNHCn8BTzlFZFzFMEas5xA9ycWdCoHiESGnLzRTTAU1yMe8Tb
	 V2PClsBjCHy2cEwLIDeP1czxFDASrOgG/bqBRzyPYAEKzmqydfIR+khZMDbLJC+xv3
	 peU8Wizjlu5h1Rc/BuKeWiLKV7dBoy9V9gk8K+S9bVNz3Zt/Mm7WCVuXPAGCrch+Iy
	 ssX7+k4N9XXlw==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v10 02/19] nfs: factor out {encode,decode}_opaque_fixed to nfs_xdr.h
Date: Sun, 30 Jun 2024 12:37:24 -0400
Message-ID: <20240630163741.48753-3-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240630163741.48753-1-snitzer@kernel.org>
References: <20240630163741.48753-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Eliminates duplicate functions in various files to allow for
additional callers.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/flexfilelayout/flexfilelayout.c |  6 ------
 fs/nfs/nfs4xdr.c                       | 13 -------------
 include/linux/nfs_xdr.h                | 20 +++++++++++++++++++-
 3 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 24188af56d5b..4a9106fa8220 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -2086,12 +2086,6 @@ static int ff_layout_encode_ioerr(struct xdr_stream *xdr,
 	return ff_layout_encode_ds_ioerr(xdr, &ff_args->errors);
 }
 
-static void
-encode_opaque_fixed(struct xdr_stream *xdr, const void *buf, size_t len)
-{
-	WARN_ON_ONCE(xdr_stream_encode_opaque_fixed(xdr, buf, len) < 0);
-}
-
 static void
 ff_layout_encode_ff_iostat_head(struct xdr_stream *xdr,
 			    const nfs4_stateid *stateid,
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 1416099dfcd1..ede431ee0ef0 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -968,11 +968,6 @@ static __be32 *reserve_space(struct xdr_stream *xdr, size_t nbytes)
 	return p;
 }
 
-static void encode_opaque_fixed(struct xdr_stream *xdr, const void *buf, size_t len)
-{
-	WARN_ON_ONCE(xdr_stream_encode_opaque_fixed(xdr, buf, len) < 0);
-}
-
 static void encode_string(struct xdr_stream *xdr, unsigned int len, const char *str)
 {
 	WARN_ON_ONCE(xdr_stream_encode_opaque(xdr, str, len) < 0);
@@ -4352,14 +4347,6 @@ static int decode_access(struct xdr_stream *xdr, u32 *supported, u32 *access)
 	return 0;
 }
 
-static int decode_opaque_fixed(struct xdr_stream *xdr, void *buf, size_t len)
-{
-	ssize_t ret = xdr_stream_decode_opaque_fixed(xdr, buf, len);
-	if (unlikely(ret < 0))
-		return -EIO;
-	return 0;
-}
-
 static int decode_stateid(struct xdr_stream *xdr, nfs4_stateid *stateid)
 {
 	return decode_opaque_fixed(xdr, stateid, NFS4_STATEID_SIZE);
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index d09b9773b20c..bb460af0ea1f 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1820,6 +1820,24 @@ struct nfs_rpc_ops {
 	void	(*disable_swap)(struct inode *inode);
 };
 
+/*
+ * Helper functions used by NFS client and/or server
+ */
+static inline void encode_opaque_fixed(struct xdr_stream *xdr,
+				       const void *buf, size_t len)
+{
+	WARN_ON_ONCE(xdr_stream_encode_opaque_fixed(xdr, buf, len) < 0);
+}
+
+static inline int decode_opaque_fixed(struct xdr_stream *xdr,
+				      void *buf, size_t len)
+{
+	ssize_t ret = xdr_stream_decode_opaque_fixed(xdr, buf, len);
+	if (unlikely(ret < 0))
+		return -EIO;
+	return 0;
+}
+
 /*
  * Function vectors etc. for the NFS client
  */
@@ -1833,4 +1851,4 @@ extern const struct rpc_version nfs_version4;
 extern const struct rpc_version nfsacl_version3;
 extern const struct rpc_program nfsacl_program;
 
-#endif
+#endif /* _LINUX_NFS_XDR_H */
-- 
2.44.0


