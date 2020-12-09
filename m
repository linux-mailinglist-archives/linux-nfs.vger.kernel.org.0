Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5312D44BF
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Dec 2020 15:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733108AbgLIOtg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Dec 2020 09:49:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:50718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733111AbgLIOtf (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 9 Dec 2020 09:49:35 -0500
From:   trondmy@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 11/16] NFSv4.2: decode_read_plus_hole() needs to check the extent offset
Date:   Wed,  9 Dec 2020 09:47:56 -0500
Message-Id: <20201209144801.700778-12-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209144801.700778-11-trondmy@kernel.org>
References: <20201209144801.700778-1-trondmy@kernel.org>
 <20201209144801.700778-2-trondmy@kernel.org>
 <20201209144801.700778-3-trondmy@kernel.org>
 <20201209144801.700778-4-trondmy@kernel.org>
 <20201209144801.700778-5-trondmy@kernel.org>
 <20201209144801.700778-6-trondmy@kernel.org>
 <20201209144801.700778-7-trondmy@kernel.org>
 <20201209144801.700778-8-trondmy@kernel.org>
 <20201209144801.700778-9-trondmy@kernel.org>
 <20201209144801.700778-10-trondmy@kernel.org>
 <20201209144801.700778-11-trondmy@kernel.org>
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

