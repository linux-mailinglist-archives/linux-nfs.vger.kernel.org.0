Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECF92D7CCE
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Dec 2020 18:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395253AbgLKR1H (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Dec 2020 12:27:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:50810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395246AbgLKR0q (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 11 Dec 2020 12:26:46 -0500
From:   trondmy@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 11/15] NFSv4.2: decode_read_plus_hole() needs to check the extent offset
Date:   Fri, 11 Dec 2020 12:25:17 -0500
Message-Id: <20201211172521.5567-12-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201211172521.5567-11-trondmy@kernel.org>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The server is allowed to return a hole extent with an offset that starts
before the offset supplied in the READ_PLUS argument. Ensure that we
support that case too.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs42xdr.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 4c6bce3dbaeb..f9faa131a4f5 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -1053,8 +1053,9 @@ static int decode_read_plus_data(struct xdr_stream *xdr, struct nfs_pgio_res *re
 	return 0;
 }
 
-static int decode_read_plus_hole(struct xdr_stream *xdr, struct nfs_pgio_res *res,
-				 uint32_t *eof)
+static int decode_read_plus_hole(struct xdr_stream *xdr,
+				 struct nfs_pgio_args *args,
+				 struct nfs_pgio_res *res, uint32_t *eof)
 {
 	uint64_t offset, length, recvd;
 	__be32 *p;
@@ -1065,6 +1066,20 @@ static int decode_read_plus_hole(struct xdr_stream *xdr, struct nfs_pgio_res *re
 
 	p = xdr_decode_hyper(p, &offset);
 	p = xdr_decode_hyper(p, &length);
+	if (offset != args->offset + res->count) {
+		/* Server returned an out-of-sequence extent */
+		if (offset > args->offset + res->count ||
+		    offset + length < args->offset + res->count) {
+			dprintk("NFS: server returned out of sequence extent: "
+				"offset/size = %llu/%llu != expected %llu\n",
+				(unsigned long long)offset,
+				(unsigned long long)length,
+				(unsigned long long)(args->offset +
+						     res->count));
+			return 1;
+		}
+		length -= args->offset + res->count - offset;
+	}
 	recvd = xdr_expand_hole(xdr, res->count, length);
 	res->count += recvd;
 
@@ -1077,6 +1092,9 @@ static int decode_read_plus_hole(struct xdr_stream *xdr, struct nfs_pgio_res *re
 
 static int decode_read_plus(struct xdr_stream *xdr, struct nfs_pgio_res *res)
 {
+	struct nfs_pgio_header *hdr =
+		container_of(res, struct nfs_pgio_header, res);
+	struct nfs_pgio_args *args = &hdr->args;
 	uint32_t eof, segments, type;
 	int status, i;
 	__be32 *p;
@@ -1104,7 +1122,7 @@ static int decode_read_plus(struct xdr_stream *xdr, struct nfs_pgio_res *res)
 		if (type == NFS4_CONTENT_DATA)
 			status = decode_read_plus_data(xdr, res, &eof);
 		else if (type == NFS4_CONTENT_HOLE)
-			status = decode_read_plus_hole(xdr, res, &eof);
+			status = decode_read_plus_hole(xdr, args, res, &eof);
 		else
 			return -EINVAL;
 
-- 
2.29.2

