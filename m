Return-Path: <linux-nfs+bounces-3812-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 905C890829A
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 05:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B3EF1F24219
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 03:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77318146D73;
	Fri, 14 Jun 2024 03:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1oLn+72"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534FF146D40
	for <linux-nfs@vger.kernel.org>; Fri, 14 Jun 2024 03:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718336684; cv=none; b=BUc+VwsxRxoKpgCFUEZBGoWPxHJOpKqqf0WA7n7H7g9qbNy54Gr0PgSF0SEfa1cPev+ckgiJJDGPZPSOKSm4SdGq9sAUif4yrYbNPOgjkKT8KzFFG33ajy5YUcjaTVIAnbC/jo9PIMR1U5TyJVOdIXKKI4F9AvwNFP7vliZXWPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718336684; c=relaxed/simple;
	bh=abK5oPUtz+Jhmhx7HxELuk/43QgqF1f5Zo34E08TUKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XIcgYsQzMCd22xvmDXQ8jg55xo8ybDySQp/QEgNjP9MLW/Rr2lCc5yCJJkFOcjUW/OdfC1MTY+VfKXTOdYotd9fT7+vHNxREPzkGEGoPFJnbDFSdszik8T2wO8i4F+sWaY/TYheE8p0UE2jYIigKKpq/MjoelYgpQZOudrR5Iws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1oLn+72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D23C2BBFC;
	Fri, 14 Jun 2024 03:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718336684;
	bh=abK5oPUtz+Jhmhx7HxELuk/43QgqF1f5Zo34E08TUKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O1oLn+72qpMYdrKfTEAqc2QyXjz4WQOGuF0z/wxMuEXLD/Qk3SjG5ySXb05ci+5ef
	 X3V/55Xo2jr/SyHS+z39GMYj4EYH9jbRrNpe4koF9E2V0bRZRwkBhi4YNVovJk3Ky9
	 O/iBfCgU+RWf8lYDcR9592+x96i6/fNu49XGjByQ9tnOCl7NEWgS0X8OEmZYxkg+bc
	 Egi8UvEL0ooW0N5T4yKd0rvYLvJRk1hWRwCCGcuchbWd16eTn8NVohpO0zd9Y5rNER
	 GzCexdIUiD3ANZkuudGLGuo0qCtmVOTHL4IORSqRHu6wy9/o83mhODcgbMobIZApKn
	 iEiMwaMnyyvvA==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v3 12/18] nfs/nfsd: consolidate {encode,decode}_opaque_fixed in nfs_xdr.h
Date: Thu, 13 Jun 2024 23:44:20 -0400
Message-ID: <20240614034426.31043-13-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240614034426.31043-1-snitzer@kernel.org>
References: <20240614034426.31043-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Eliminates duplicate functions in various files.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/flexfilelayout/flexfilelayout.c |  6 ------
 fs/nfs/nfs3xdr.c                       |  9 ---------
 fs/nfs/nfs4xdr.c                       | 13 -------------
 fs/nfsd/localio.c                      |  7 ++-----
 include/linux/nfs_xdr.h                | 20 +++++++++++++++++++-
 5 files changed, 21 insertions(+), 34 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index ec6aaa110a7b..8b9096ad0663 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -2185,12 +2185,6 @@ static int ff_layout_encode_ioerr(struct xdr_stream *xdr,
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
diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
index d2a17ecd12b8..95a2fb0733ae 100644
--- a/fs/nfs/nfs3xdr.c
+++ b/fs/nfs/nfs3xdr.c
@@ -2591,15 +2591,6 @@ static void nfs3_xdr_enc_getuuidargs(struct rpc_rqst *req,
 	/* void function */
 }
 
-// FIXME: factor out from fs/nfs/nfs4xdr.c
-static int decode_opaque_fixed(struct xdr_stream *xdr, void *buf, size_t len)
-{
-	ssize_t ret = xdr_stream_decode_opaque_fixed(xdr, buf, len);
-	if (unlikely(ret < 0))
-		return -EIO;
-	return 0;
-}
-
 static inline int nfs3_decode_getuuidresok(struct xdr_stream *xdr,
 					struct nfs_getuuidres *result)
 {
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index d3b4fa3245f0..6b35b1d7d7ce 100644
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
diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index bb84e165dbe1..7ecd72406dc0 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -11,6 +11,8 @@
 #include <linux/sunrpc/svcauth_gss.h>
 #include <linux/sunrpc/clnt.h>
 #include <linux/nfs.h>
+#include <linux/nfs_fs.h>
+#include <linux/nfs_xdr.h>
 #include <linux/string.h>
 
 #include "nfsd.h"
@@ -267,11 +269,6 @@ static __be32 nfsd_proc_getuuid(struct svc_rqst *rqstp)
 
 #define NFS_getuuid_sz XDR_QUADLEN(UUID_SIZE)
 
-static inline void encode_opaque_fixed(struct xdr_stream *xdr, const void *buf, size_t len)
-{
-	WARN_ON_ONCE(xdr_stream_encode_opaque_fixed(xdr, buf, len) < 0);
-}
-
 static void encode_uuid(struct xdr_stream *xdr, uuid_t *src_uuid)
 {
 	u8 uuid[UUID_SIZE];
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 2a438f4c2d6d..daa4115f6be6 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1826,6 +1826,24 @@ struct nfs_rpc_ops {
 	void	(*init_localioclient)(struct nfs_client *);
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
@@ -1844,4 +1862,4 @@ extern const struct rpc_program nfslocalio_program3;
 extern const struct rpc_version nfslocalio_version4;
 extern const struct rpc_program nfslocalio_program4;
 
-#endif
+#endif /* _LINUX_NFS_XDR_H */
-- 
2.44.0


