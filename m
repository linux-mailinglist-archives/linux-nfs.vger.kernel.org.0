Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB76C2B879E
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Nov 2020 23:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgKRWTp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Nov 2020 17:19:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:43818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbgKRWTo (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 18 Nov 2020 17:19:44 -0500
Received: from leira.hammer.space (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBBED246DE
        for <linux-nfs@vger.kernel.org>; Wed, 18 Nov 2020 22:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605737984;
        bh=LMsPRKUc8R5f02kJdlmcEoIQVAinQSQdnEY3g8Kb6K0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=yWDYVJcllIqM1DRaMUs9f5sI2NJV9QvzlGgHSkC2di9I2PopU0OkkiLb+K+AA4l8W
         bcVL5km6xmLrfc7qNKr9/5ZZX66HM8viZfCpcUan6nxsly+zJjEx8QhweucrMfUKzz
         v4pGs1dpFQmRlbBjnYM0XI5iE5cpHKdjR3bZC9oI=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] NFS: Avoid copy of xdr padding in readlink, layoutget and getxattr
Date:   Wed, 18 Nov 2020 17:19:38 -0500
Message-Id: <20201118221939.20715-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201118221939.20715-1-trondmy@kernel.org>
References: <20201118221939.20715-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When doing a readlink, layoutget or getxattr call into an array of
pages, we don't care if the XDR padding ends up in the last page
when the data length is not 32-bit aligned.
Avoid an unnecessary copy by just leaving that padding in place.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs2xdr.c  | 2 +-
 fs/nfs/nfs3xdr.c  | 2 +-
 fs/nfs/nfs42xdr.c | 2 +-
 fs/nfs/nfs4xdr.c  | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/nfs2xdr.c b/fs/nfs/nfs2xdr.c
index f6676af37d5d..db9c265ad9e1 100644
--- a/fs/nfs/nfs2xdr.c
+++ b/fs/nfs/nfs2xdr.c
@@ -437,7 +437,7 @@ static int decode_path(struct xdr_stream *xdr)
 	length = be32_to_cpup(p);
 	if (unlikely(length >= xdr->buf->page_len || length > NFS_MAXPATHLEN))
 		goto out_size;
-	recvd = xdr_read_pages(xdr, length);
+	recvd = xdr_read_pages(xdr, xdr_align_size(length));
 	if (unlikely(length > recvd))
 		goto out_cheating;
 	xdr_terminate_string(xdr->buf, length);
diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
index 69971f6c840d..d3e1726d538b 100644
--- a/fs/nfs/nfs3xdr.c
+++ b/fs/nfs/nfs3xdr.c
@@ -234,7 +234,7 @@ static int decode_nfspath3(struct xdr_stream *xdr)
 	count = be32_to_cpup(p);
 	if (unlikely(count >= xdr->buf->page_len || count > NFS3_MAXPATHLEN))
 		goto out_nametoolong;
-	recvd = xdr_read_pages(xdr, count);
+	recvd = xdr_read_pages(xdr, xdr_align_size(count));
 	if (unlikely(count > recvd))
 		goto out_cheating;
 	xdr_terminate_string(xdr->buf, count);
diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 6e060a88f98c..e58bfe208ae8 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -495,7 +495,7 @@ static int decode_getxattr(struct xdr_stream *xdr,
 	res->xattr_len = len;
 
 	if (len > 0) {
-		rdlen = xdr_read_pages(xdr, len);
+		rdlen = xdr_read_pages(xdr, xdr_align_size(len));
 		if (rdlen < len)
 			return -EIO;
 	}
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index c8714381d511..755b556e85c3 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -5250,7 +5250,7 @@ static int decode_readlink(struct xdr_stream *xdr, struct rpc_rqst *req)
 		dprintk("nfs: server returned giant symlink!\n");
 		return -ENAMETOOLONG;
 	}
-	recvd = xdr_read_pages(xdr, len);
+	recvd = xdr_read_pages(xdr, xdr_align_size(len));
 	if (recvd < len) {
 		dprintk("NFS: server cheating in readlink reply: "
 				"count %u > recvd %u\n", len, recvd);
@@ -5925,7 +5925,7 @@ static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
 		res->type,
 		res->layoutp->len);
 
-	recvd = xdr_read_pages(xdr, res->layoutp->len);
+	recvd = xdr_read_pages(xdr, xdr_align_size(res->layoutp->len));
 	if (res->layoutp->len > recvd) {
 		dprintk("NFS: server cheating in layoutget reply: "
 				"layout len %u > recvd %u\n",
-- 
2.28.0

