Return-Path: <linux-nfs+bounces-3669-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 856F690495F
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 05:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29D791F225A7
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 03:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3F729408;
	Wed, 12 Jun 2024 03:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLjeGDQW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA76729413
	for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 03:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718161692; cv=none; b=H5SDi5uzwsen8UIisJUzziRAv9sHjVQKXh/Hgja3IWVCUZJ/7PYYdDCBZ4OCb/tUbms5ycJ7OTgqA46CaTC+u8sSTmBODq+zsyzBv0xK7CZvVgggc4a4TNB4meffW6UMSzG6CBeMiMwXeVanLfPnQqplBTXYyVBcxRFj2D37/u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718161692; c=relaxed/simple;
	bh=hvvrtj9EQvdttxz6RCaCjY4hSWTpXoeAgbtItksIgP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UAAAlSdNJGgjqkWgViLH981SXaIeY2Og8suSNiJnPmd/kMzIHE8BtOJTKFoiKZ2l4ewE49jx3D9EOwjpuulE07OWHCYdwn/Qs7io1VF3TSp/oLi3vqCSQXfF4DN/NQunMg1k2OgloCIE5rPSg3nzMmi7bvctRc3WBMMqPXP2jWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLjeGDQW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64916C2BD10;
	Wed, 12 Jun 2024 03:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718161692;
	bh=hvvrtj9EQvdttxz6RCaCjY4hSWTpXoeAgbtItksIgP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LLjeGDQWV/7OdbTey3Avbj6fxXchitBnRd5aYSBnDAKVo1LVgYWdNwGITbeOR2p2R
	 8mXQE5zaDzuRLGvRV+1H2zaAWN11dlRogj67h/6QlJO+JFB7rwHGQQgzbMImmoJ2lz
	 /SRLh3zA1vVk1OMAas2GN9cp+2HiJPCRbdKDoNs0B/MA3EKsN/I8gxTGQw3WzV0kfI
	 AIGi9XAA0C3udvQSSEoi3i1WMl6FNuWsOdfyLTosekN3ZQEwReBZiPcj5W5zMFODJf
	 EAlGKRtFzmPQ4wjt202lVFjbw9cH3bAQ7d9G5J5/hPZzw0jO3O4eHqP9+fhSymvYoj
	 3XIPfSPPnAJgw==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [RFC PATCH v2 13/15] nfs/nfsd: consolidate {encode,decode}_opaque_fixed in nfs_xdr.h
Date: Tue, 11 Jun 2024 23:07:50 -0400
Message-ID: <20240612030752.31754-14-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240612030752.31754-1-snitzer@kernel.org>
References: <20240612030752.31754-1-snitzer@kernel.org>
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
index e35480595ec9..866e8c8a5548 100644
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
@@ -208,11 +210,6 @@ static __be32 nfsd_proc_getuuid(struct svc_rqst *rqstp)
 
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


