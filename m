Return-Path: <linux-nfs+bounces-4338-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1BF918E59
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 20:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4781F276CB
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 18:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9381F19049E;
	Wed, 26 Jun 2024 18:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTtR4X+L"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F76A19047F
	for <linux-nfs@vger.kernel.org>; Wed, 26 Jun 2024 18:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719426297; cv=none; b=LtETpdm3CWN+KldlaSPZqOZyi4dbAbBZiP+Ffsa+KoWPWOwDdTBDdO067Ol+8BKgjO6mbeZrMttYp3fTMYjiXgNm3x/T3R7srldV3+rHdKwGA6aexWPa3mTwnjBbzFKQDuRVmovfPdLs4bsjoRsw2ItvVnNbPLtZcjW0FsL8CFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719426297; c=relaxed/simple;
	bh=i0Hg7Di7ViVzTwEPbXHxTBXT/ZyLE/03WHls5qFK+Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ACbrd4yVMpThoER5INCd1ZQKPal297Cdc68p8ngGCt9uB2yRReR0aClv6WnilypQLS9ra21v74iRs8nYR718SQ48yyD6Okr3YKw2UhqA17RiUvX2euvjDbeWwJ1NXt3De0iL7grLhQcq0MS/S87CjGAAD01RS3+Gec1/LfBoIP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTtR4X+L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32DCC116B1;
	Wed, 26 Jun 2024 18:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719426297;
	bh=i0Hg7Di7ViVzTwEPbXHxTBXT/ZyLE/03WHls5qFK+Sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pTtR4X+L/9ahbx/mnIViTvk+qmQyLDr5lL/LkDDDGB8QxHnw7clxp6DR7rIy+2G0R
	 Cxjy4ZvrlsGHFUYCUgXr2cOiMyUCugSuLyjadP4rfA/2Anv324EpgA/4lPRNdEb4BE
	 o/SHXOjqE+F8YmC94Nmak8ejLp9gr94oCDNu4YkBxatD9uwsjCSxiONOUBfj0XJLoV
	 YTNUPrhau+y0+nwmwucwM7J6GEtVnCRAUZ9OnsAmx76JwV3TdtowE5Oy0y3e1ZebmX
	 IcSyfpUoS4QIQfPe9fimbKohowJ3F9yDIn1D8amDazV6zT+fHgzhh0JAob8z5jHSvQ
	 SsiASr0s6aGrw==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v8 13/18] nfs: factor out {encode,decode}_opaque_fixed to nfs_xdr.h
Date: Wed, 26 Jun 2024 14:24:33 -0400
Message-ID: <20240626182438.69539-14-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240626182438.69539-1-snitzer@kernel.org>
References: <20240626182438.69539-1-snitzer@kernel.org>
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


