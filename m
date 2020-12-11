Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2C92D7CD2
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Dec 2020 18:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395250AbgLKR1H (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Dec 2020 12:27:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:50814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395253AbgLKR0q (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 11 Dec 2020 12:26:46 -0500
From:   trondmy@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 13/15] NFSv4.2: Don't error when exiting early on a READ_PLUS buffer overflow
Date:   Fri, 11 Dec 2020 12:25:19 -0500
Message-Id: <20201211172521.5567-14-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201211172521.5567-13-trondmy@kernel.org>
References: <20201211172521.5567-1-trondmy@kernel.org>
 <20201211172521.5567-2-trondmy@kernel.org>
 <20201211172521.5567-3-trondmy@kernel.org>
 <20201211172521.5567-4-trondmy@kernel.org>
 <20201211172521.5567-5-trondmy@kernel.org>
 <20201211172521.5567-6-trondmy@kernel.org>
 <20201211172521.5567-7-trondmy@kernel.org>
 <20201211172521.5567-8-trondmy@kernel.org>
 <20201211172521.5567-9-trondmy@kernel.org>
 <20201211172521.5567-10-trondmy@kernel.org>
 <20201211172521.5567-11-trondmy@kernel.org>
 <20201211172521.5567-12-trondmy@kernel.org>
 <20201211172521.5567-13-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Expanding the READ_PLUS extents can cause the read buffer to overflow.
If it does, then don't error, but just exit early.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs42xdr.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 6ba2a28e7e03..9ef5261a1a70 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -1025,16 +1025,16 @@ static int decode_deallocate(struct xdr_stream *xdr, struct nfs42_falloc_res *re
 	return decode_op_hdr(xdr, OP_DEALLOCATE);
 }
 
-static int decode_read_plus_data(struct xdr_stream *xdr, struct nfs_pgio_res *res,
-				 uint32_t *eof)
+static int decode_read_plus_data(struct xdr_stream *xdr,
+				 struct nfs_pgio_res *res)
 {
 	uint32_t count, recvd;
 	uint64_t offset;
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, 8 + 4);
-	if (unlikely(!p))
-		return -EIO;
+	if (!p)
+		return 1;
 
 	p = xdr_decode_hyper(p, &offset);
 	count = be32_to_cpup(p);
@@ -1043,13 +1043,8 @@ static int decode_read_plus_data(struct xdr_stream *xdr, struct nfs_pgio_res *re
 		recvd = count;
 	res->count += recvd;
 
-	if (count > recvd) {
-		dprintk("NFS: server cheating in read reply: "
-				"count %u > recvd %u\n", count, recvd);
-		*eof = 0;
+	if (count > recvd)
 		return 1;
-	}
-
 	return 0;
 }
 
@@ -1061,8 +1056,8 @@ static int decode_read_plus_hole(struct xdr_stream *xdr,
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, 8 + 8);
-	if (unlikely(!p))
-		return -EIO;
+	if (!p)
+		return 1;
 
 	p = xdr_decode_hyper(p, &offset);
 	p = xdr_decode_hyper(p, &length);
@@ -1089,10 +1084,8 @@ static int decode_read_plus_hole(struct xdr_stream *xdr,
 	recvd = xdr_expand_hole(xdr, res->count, length);
 	res->count += recvd;
 
-	if (recvd < length) {
-		*eof = 0;
+	if (recvd < length)
 		return 1;
-	}
 	return 0;
 }
 
@@ -1121,12 +1114,12 @@ static int decode_read_plus(struct xdr_stream *xdr, struct nfs_pgio_res *res)
 
 	for (i = 0; i < segments; i++) {
 		p = xdr_inline_decode(xdr, 4);
-		if (unlikely(!p))
-			return -EIO;
+		if (!p)
+			goto early_out;
 
 		type = be32_to_cpup(p++);
 		if (type == NFS4_CONTENT_DATA)
-			status = decode_read_plus_data(xdr, res, &eof);
+			status = decode_read_plus_data(xdr, res);
 		else if (type == NFS4_CONTENT_HOLE)
 			status = decode_read_plus_hole(xdr, args, res, &eof);
 		else
@@ -1135,12 +1128,17 @@ static int decode_read_plus(struct xdr_stream *xdr, struct nfs_pgio_res *res)
 		if (status < 0)
 			return status;
 		if (status > 0)
-			break;
+			goto early_out;
 	}
 
 out:
 	res->eof = eof;
 	return 0;
+early_out:
+	if (unlikely(!i))
+		return -EIO;
+	res->eof = 0;
+	return 0;
 }
 
 static int decode_seek(struct xdr_stream *xdr, struct nfs42_seek_res *res)
-- 
2.29.2

