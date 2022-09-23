Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC93E5E8276
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Sep 2022 21:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiIWTUT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Sep 2022 15:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiIWTUT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 23 Sep 2022 15:20:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0321D76770
        for <linux-nfs@vger.kernel.org>; Fri, 23 Sep 2022 12:20:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8964F61372
        for <linux-nfs@vger.kernel.org>; Fri, 23 Sep 2022 19:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59C6C433C1
        for <linux-nfs@vger.kernel.org>; Fri, 23 Sep 2022 19:20:16 +0000 (UTC)
Subject: [PATCH RFC] NFSD: Cap rsize_bop result based on send buffer size
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 23 Sep 2022 15:20:15 -0400
Message-ID: <166396081544.17299.12934850812688968276.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Since before the git era, NFSD has conserved the number of pages
held by each nfsd thread by combining the RPC receive and send
buffers into a single array of pages. This works because there are
no cases where an operation needs a large RPC Call message and a
large RPC Reply at the same time.

Once an RPC Call has been received, svc_process() updates
svc_rqst::rq_res to describe the part of rq_pages that can be
used for constructing the Reply. This means that the send buffer
(rq_res) shrinks when the received RPC record containing the RPC
Call is large.

Add an NFSv4 helper that computes the size of the send buffer. It
replaces svc_max_payload() in spots where svc_max_payload() returns
a value that might be larger than the remaining send buffer space.
Callers who need to know the transport's actual maximum payload size
will continue to use svc_max_payload().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |   48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index a09901cf175c..8beb2bc4c328 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2771,6 +2771,22 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 
 #define op_encode_channel_attrs_maxsz	(6 + 1 + 1)
 
+/*
+ * The _rsize() helpers are invoked by the NFSv4 COMPOUND decoder, which
+ * is called before sunrpc sets rq_res.buflen. Thus we have to compute
+ * the maximum payload size here, based on transport limits and the size
+ * of the remaining space in the rq_pages array.
+ */
+static u32 nfsd4_max_payload(const struct svc_rqst *rqstp)
+{
+	u32 buflen;
+
+	buflen = (rqstp->rq_page_end - rqstp->rq_next_page) * PAGE_SIZE;
+	buflen -= rqstp->rq_auth_slack;
+	buflen -= rqstp->rq_res.head[0].iov_len;
+	return min_t(u32, buflen, svc_max_payload(rqstp));
+}
+
 static u32 nfsd4_only_status_rsize(const struct svc_rqst *rqstp,
 				   const struct nfsd4_op *op)
 {
@@ -2816,9 +2832,9 @@ static u32 nfsd4_getattr_rsize(const struct svc_rqst *rqstp,
 	u32 ret = 0;
 
 	if (bmap0 & FATTR4_WORD0_ACL)
-		return svc_max_payload(rqstp);
+		return nfsd4_max_payload(rqstp);
 	if (bmap0 & FATTR4_WORD0_FS_LOCATIONS)
-		return svc_max_payload(rqstp);
+		return nfsd4_max_payload(rqstp);
 
 	if (bmap1 & FATTR4_WORD1_OWNER) {
 		ret += IDMAP_NAMESZ + 4;
@@ -2878,10 +2894,7 @@ static u32 nfsd4_open_rsize(const struct svc_rqst *rqstp,
 static u32 nfsd4_read_rsize(const struct svc_rqst *rqstp,
 			    const struct nfsd4_op *op)
 {
-	u32 maxcount = 0, rlen = 0;
-
-	maxcount = svc_max_payload(rqstp);
-	rlen = min(op->u.read.rd_length, maxcount);
+	u32 rlen = min(op->u.read.rd_length, nfsd4_max_payload(rqstp));
 
 	return (op_encode_hdr_size + 2 + XDR_QUADLEN(rlen)) * sizeof(__be32);
 }
@@ -2889,8 +2902,7 @@ static u32 nfsd4_read_rsize(const struct svc_rqst *rqstp,
 static u32 nfsd4_read_plus_rsize(const struct svc_rqst *rqstp,
 				 const struct nfsd4_op *op)
 {
-	u32 maxcount = svc_max_payload(rqstp);
-	u32 rlen = min(op->u.read.rd_length, maxcount);
+	u32 rlen = min(op->u.read.rd_length, nfsd4_max_payload(rqstp));
 	/*
 	 * If we detect that the file changed during hole encoding, then we
 	 * recover by encoding the remaining reply as data. This means we need
@@ -2904,10 +2916,7 @@ static u32 nfsd4_read_plus_rsize(const struct svc_rqst *rqstp,
 static u32 nfsd4_readdir_rsize(const struct svc_rqst *rqstp,
 			       const struct nfsd4_op *op)
 {
-	u32 maxcount = 0, rlen = 0;
-
-	maxcount = svc_max_payload(rqstp);
-	rlen = min(op->u.readdir.rd_maxcount, maxcount);
+	u32 rlen = min(op->u.readdir.rd_maxcount, nfsd4_max_payload(rqstp));
 
 	return (op_encode_hdr_size + op_encode_verifier_maxsz +
 		XDR_QUADLEN(rlen)) * sizeof(__be32);
@@ -3046,10 +3055,7 @@ static u32 nfsd4_copy_notify_rsize(const struct svc_rqst *rqstp,
 static u32 nfsd4_getdeviceinfo_rsize(const struct svc_rqst *rqstp,
 				     const struct nfsd4_op *op)
 {
-	u32 maxcount = 0, rlen = 0;
-
-	maxcount = svc_max_payload(rqstp);
-	rlen = min(op->u.getdeviceinfo.gd_maxcount, maxcount);
+	u32 rlen = min(op->u.getdeviceinfo.gd_maxcount, nfsd4_max_payload(rqstp));
 
 	return (op_encode_hdr_size +
 		1 /* gd_layout_type*/ +
@@ -3099,10 +3105,7 @@ static u32 nfsd4_seek_rsize(const struct svc_rqst *rqstp,
 static u32 nfsd4_getxattr_rsize(const struct svc_rqst *rqstp,
 				const struct nfsd4_op *op)
 {
-	u32 maxcount, rlen;
-
-	maxcount = svc_max_payload(rqstp);
-	rlen = min_t(u32, XATTR_SIZE_MAX, maxcount);
+	u32 rlen = min_t(u32, XATTR_SIZE_MAX, nfsd4_max_payload(rqstp));
 
 	return (op_encode_hdr_size + 1 + XDR_QUADLEN(rlen)) * sizeof(__be32);
 }
@@ -3116,10 +3119,7 @@ static u32 nfsd4_setxattr_rsize(const struct svc_rqst *rqstp,
 static u32 nfsd4_listxattrs_rsize(const struct svc_rqst *rqstp,
 				  const struct nfsd4_op *op)
 {
-	u32 maxcount, rlen;
-
-	maxcount = svc_max_payload(rqstp);
-	rlen = min(op->u.listxattrs.lsxa_maxcount, maxcount);
+	u32 rlen = min(op->u.listxattrs.lsxa_maxcount, nfsd4_max_payload(rqstp));
 
 	return (op_encode_hdr_size + 4 + XDR_QUADLEN(rlen)) * sizeof(__be32);
 }


