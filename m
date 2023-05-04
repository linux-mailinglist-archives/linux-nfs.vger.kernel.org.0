Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4836F7764
	for <lists+linux-nfs@lfdr.de>; Thu,  4 May 2023 22:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjEDUtI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 May 2023 16:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjEDUsj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 May 2023 16:48:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371668F
        for <linux-nfs@vger.kernel.org>; Thu,  4 May 2023 13:48:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14B91639F6
        for <linux-nfs@vger.kernel.org>; Thu,  4 May 2023 20:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA26C433D2;
        Thu,  4 May 2023 20:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683233235;
        bh=oBYSQTE9cYZca3/Nl7LnNd72cGaq0A/IjR/ySwOHW9k=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=reMN6/W3vJC4gx0Yc3+kesNSbpOQ+EzXTG3uOw6Se1WbT8mc9YoTlFU6cOazbj4u/
         VOk66Py4yU5VNHBoqJ25QNavzgTpPBtZF7ca7qtfwSEXBR4C0irLic0pumIxF9Tuq6
         1p7+pJwutFBQMgXRhBIoLH36YSSHaEftUzUN3nCIfXqcyynoQ6r4fVTqc+OSkoNVXU
         i0qDhPtkP4O6dAHtll1NGaBRk9Xf+C0K48cVlnGuLy68MRT/GyA+uqA8mbjAW7itfi
         F+5EdrPdY8Al+XHhR4QYnQHVyBoxum46hdlm9xq2NAjEckIleL0El9Qv0Qa0fsMR0y
         pMgFfxFj9F4BA==
From:   Anna Schumaker <anna@kernel.org>
Date:   Thu, 04 May 2023 16:47:13 -0400
Subject: [PATCH 3/6] NFSv4.2: Clean up: Move nfs4_xdr_enc_*xattr()
 functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230504-xattr-ctime-v1-3-ac3fc5a00942@Netapp.com>
References: <20230504-xattr-ctime-v1-0-ac3fc5a00942@Netapp.com>
In-Reply-To: <20230504-xattr-ctime-v1-0-ac3fc5a00942@Netapp.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6084;
 i=Anna.Schumaker@Netapp.com; h=from:subject:message-id;
 bh=LejxEI+D7/LUOB1eLc8MKxgM86cKmVm1M3SpRTEUWaA=;
 b=owEBbQKS/ZANAwAIAdfLVL+wpUDrAcsmYgBkVBnRvapt9w1IKOt9RXmZsiL6QjJF+98Atv9MR
 Y/rFDtbXkiJAjMEAAEIAB0WIQSdnkxBOlHtwtTsoSnXy1S/sKVA6wUCZFQZ0QAKCRDXy1S/sKVA
 63/PEAD5fyDiDogKtFAhx8osvBwvWgvHme0UT/o60H/HJIcOMIElJUL64sjfV0x6zTqiv2VWYWm
 A4sZvcz5ndZuqkO/LWFAWnbgEWVVYXghX+JXGzsmm/MJwDjmdVyIgwpP+FbKpciL5BgXw4otRlE
 fKvdK2CAheWZuOk/6N4cZE0Bx5UnoJKUV0lXfUx3eSF1+pwoFKRVcLm66XBURRVy7EBuQHB1d4n
 5o+SnFTHUSCzAp7u59oRpFjdQS0zcciZuKhw2AvmoL9umejLEaxdMLEsJ1SsyUKXsvVV0C2sHHo
 BOKG/5ZYZXoP00/taGBDvhaewx49N0wrqddHy1CxKR2T0NIG0OCSW3qUvBEpK1hqoglCzqFx6wx
 LpbGaDFXfybaGDsS4zyfJSyELt0YzyRoAhvLcoliCyEQtgN/m8zjs5j/62oZnEUaxdWhVofR9LJ
 YSxD+dhLb6bIhZXMxMILtAnEeAd7mvM3XUvj6puz47s5/6BY5Sbx6NiWcbSqgEUPqgYMKREg7N6
 1fTg28+Bau+aA287W1+rYFw6dJ+chakNkf8p0bTy/QJeo8kZ5gg55rS2ZIY0NXrCaJgBqR4vden
 wt26hWtS0gDzEpRVFqQM08KEnFPj4C5AAnuVLWB0DTrbGkTD4n4oRSA5y3eguU7GYR6+yXth3+l
 szos6kR/P4rTaYQ==
X-Developer-Key: i=Anna.Schumaker@Netapp.com; a=openpgp;
 fpr=9D9E4C413A51EDC2D4ECA129D7CB54BFB0A540EB
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

They should be in the nfs4_xdr_enc_*() section, and not at the bottom of
the file.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs42xdr.c | 154 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 83 insertions(+), 71 deletions(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 09e735bcee09..51560c7d468d 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -707,6 +707,89 @@ static void nfs4_xdr_enc_layouterror(struct rpc_rqst *req,
 	encode_nops(&hdr);
 }
 
+/*
+ * Encode SETXATTR request
+ */
+static void nfs4_xdr_enc_setxattr(struct rpc_rqst *req, struct xdr_stream *xdr,
+				  const void *data)
+{
+	const struct nfs42_setxattrargs *args = data;
+	struct compound_hdr hdr = {
+		.minorversion = nfs4_xdr_minorversion(&args->seq_args),
+	};
+
+	encode_compound_hdr(xdr, req, &hdr);
+	encode_sequence(xdr, &args->seq_args, &hdr);
+	encode_putfh(xdr, args->fh, &hdr);
+	encode_setxattr(xdr, args, &hdr);
+	encode_nops(&hdr);
+}
+
+/*
+ * Encode GETXATTR request
+ */
+static void nfs4_xdr_enc_getxattr(struct rpc_rqst *req, struct xdr_stream *xdr,
+				  const void *data)
+{
+	const struct nfs42_getxattrargs *args = data;
+	struct compound_hdr hdr = {
+		.minorversion = nfs4_xdr_minorversion(&args->seq_args),
+	};
+	uint32_t replen;
+
+	encode_compound_hdr(xdr, req, &hdr);
+	encode_sequence(xdr, &args->seq_args, &hdr);
+	encode_putfh(xdr, args->fh, &hdr);
+	replen = hdr.replen + op_decode_hdr_maxsz + 1;
+	encode_getxattr(xdr, args->xattr_name, &hdr);
+
+	rpc_prepare_reply_pages(req, args->xattr_pages, 0, args->xattr_len,
+				replen);
+
+	encode_nops(&hdr);
+}
+
+/*
+ * Encode LISTXATTR request
+ */
+static void nfs4_xdr_enc_listxattrs(struct rpc_rqst *req,
+				    struct xdr_stream *xdr, const void *data)
+{
+	const struct nfs42_listxattrsargs *args = data;
+	struct compound_hdr hdr = {
+		.minorversion = nfs4_xdr_minorversion(&args->seq_args),
+	};
+	uint32_t replen;
+
+	encode_compound_hdr(xdr, req, &hdr);
+	encode_sequence(xdr, &args->seq_args, &hdr);
+	encode_putfh(xdr, args->fh, &hdr);
+	replen = hdr.replen + op_decode_hdr_maxsz + 2 + 1;
+	encode_listxattrs(xdr, args, &hdr);
+
+	rpc_prepare_reply_pages(req, args->xattr_pages, 0, args->count, replen);
+
+	encode_nops(&hdr);
+}
+
+/*
+ * Encode REMOVEXATTR request
+ */
+static void nfs4_xdr_enc_removexattr(struct rpc_rqst *req,
+				     struct xdr_stream *xdr, const void *data)
+{
+	const struct nfs42_removexattrargs *args = data;
+	struct compound_hdr hdr = {
+		.minorversion = nfs4_xdr_minorversion(&args->seq_args),
+	};
+
+	encode_compound_hdr(xdr, req, &hdr);
+	encode_sequence(xdr, &args->seq_args, &hdr);
+	encode_putfh(xdr, args->fh, &hdr);
+	encode_removexattr(xdr, args->xattr_name, &hdr);
+	encode_nops(&hdr);
+}
+
 static int decode_allocate(struct xdr_stream *xdr, struct nfs42_falloc_res *res)
 {
 	return decode_op_hdr(xdr, OP_ALLOCATE);
@@ -1480,21 +1563,6 @@ static int nfs4_xdr_dec_layouterror(struct rpc_rqst *rqstp,
 }
 
 #ifdef CONFIG_NFS_V4_2
-static void nfs4_xdr_enc_setxattr(struct rpc_rqst *req, struct xdr_stream *xdr,
-				  const void *data)
-{
-	const struct nfs42_setxattrargs *args = data;
-	struct compound_hdr hdr = {
-		.minorversion = nfs4_xdr_minorversion(&args->seq_args),
-	};
-
-	encode_compound_hdr(xdr, req, &hdr);
-	encode_sequence(xdr, &args->seq_args, &hdr);
-	encode_putfh(xdr, args->fh, &hdr);
-	encode_setxattr(xdr, args, &hdr);
-	encode_nops(&hdr);
-}
-
 static int nfs4_xdr_dec_setxattr(struct rpc_rqst *req, struct xdr_stream *xdr,
 				 void *data)
 {
@@ -1517,27 +1585,6 @@ static int nfs4_xdr_dec_setxattr(struct rpc_rqst *req, struct xdr_stream *xdr,
 	return status;
 }
 
-static void nfs4_xdr_enc_getxattr(struct rpc_rqst *req, struct xdr_stream *xdr,
-				  const void *data)
-{
-	const struct nfs42_getxattrargs *args = data;
-	struct compound_hdr hdr = {
-		.minorversion = nfs4_xdr_minorversion(&args->seq_args),
-	};
-	uint32_t replen;
-
-	encode_compound_hdr(xdr, req, &hdr);
-	encode_sequence(xdr, &args->seq_args, &hdr);
-	encode_putfh(xdr, args->fh, &hdr);
-	replen = hdr.replen + op_decode_hdr_maxsz + 1;
-	encode_getxattr(xdr, args->xattr_name, &hdr);
-
-	rpc_prepare_reply_pages(req, args->xattr_pages, 0, args->xattr_len,
-				replen);
-
-	encode_nops(&hdr);
-}
-
 static int nfs4_xdr_dec_getxattr(struct rpc_rqst *rqstp,
 				 struct xdr_stream *xdr, void *data)
 {
@@ -1559,26 +1606,6 @@ static int nfs4_xdr_dec_getxattr(struct rpc_rqst *rqstp,
 	return status;
 }
 
-static void nfs4_xdr_enc_listxattrs(struct rpc_rqst *req,
-				    struct xdr_stream *xdr, const void *data)
-{
-	const struct nfs42_listxattrsargs *args = data;
-	struct compound_hdr hdr = {
-		.minorversion = nfs4_xdr_minorversion(&args->seq_args),
-	};
-	uint32_t replen;
-
-	encode_compound_hdr(xdr, req, &hdr);
-	encode_sequence(xdr, &args->seq_args, &hdr);
-	encode_putfh(xdr, args->fh, &hdr);
-	replen = hdr.replen + op_decode_hdr_maxsz + 2 + 1;
-	encode_listxattrs(xdr, args, &hdr);
-
-	rpc_prepare_reply_pages(req, args->xattr_pages, 0, args->count, replen);
-
-	encode_nops(&hdr);
-}
-
 static int nfs4_xdr_dec_listxattrs(struct rpc_rqst *rqstp,
 				   struct xdr_stream *xdr, void *data)
 {
@@ -1602,21 +1629,6 @@ static int nfs4_xdr_dec_listxattrs(struct rpc_rqst *rqstp,
 	return status;
 }
 
-static void nfs4_xdr_enc_removexattr(struct rpc_rqst *req,
-				     struct xdr_stream *xdr, const void *data)
-{
-	const struct nfs42_removexattrargs *args = data;
-	struct compound_hdr hdr = {
-		.minorversion = nfs4_xdr_minorversion(&args->seq_args),
-	};
-
-	encode_compound_hdr(xdr, req, &hdr);
-	encode_sequence(xdr, &args->seq_args, &hdr);
-	encode_putfh(xdr, args->fh, &hdr);
-	encode_removexattr(xdr, args->xattr_name, &hdr);
-	encode_nops(&hdr);
-}
-
 static int nfs4_xdr_dec_removexattr(struct rpc_rqst *req,
 				    struct xdr_stream *xdr, void *data)
 {

-- 
2.40.1

