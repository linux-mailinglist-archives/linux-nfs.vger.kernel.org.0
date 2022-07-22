Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D8557E801
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jul 2022 22:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236207AbiGVUJU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Jul 2022 16:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236544AbiGVUJC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Jul 2022 16:09:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E8CAF70E
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 13:09:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 457CBB81EDB
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 20:09:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E9DC341C6
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 20:08:58 +0000 (UTC)
Subject: [PATCH v1 4/8] NFSD: Add an nfsd4_read::rd_eof field
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 22 Jul 2022 16:08:57 -0400
Message-ID: <165852053791.11198.9827634691670761329.stgit@manet.1015granger.net>
In-Reply-To: <165852051841.11198.2929614302983292322.stgit@manet.1015granger.net>
References: <165852051841.11198.2929614302983292322.stgit@manet.1015granger.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
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

Refactor: Make the EOF result available in the entire NFSv4 READ
path.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   11 +++++------
 fs/nfsd/xdr4.h    |    5 +++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index c9468f205dad..16ae1be1bbac 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3879,7 +3879,6 @@ static __be32 nfsd4_encode_splice_read(
 	struct xdr_stream *xdr = resp->xdr;
 	struct xdr_buf *buf = xdr->buf;
 	int status, space_left;
-	u32 eof;
 	__be32 nfserr;
 	__be32 *p = xdr->p - 2;
 
@@ -3888,7 +3887,8 @@ static __be32 nfsd4_encode_splice_read(
 		return nfserr_resource;
 
 	nfserr = nfsd_splice_read(read->rd_rqstp, read->rd_fhp,
-				  file, read->rd_offset, &maxcount, &eof);
+				  file, read->rd_offset, &maxcount,
+				  &read->rd_eof);
 	read->rd_length = maxcount;
 	if (nfserr)
 		goto out_err;
@@ -3899,7 +3899,7 @@ static __be32 nfsd4_encode_splice_read(
 		goto out_err;
 	}
 
-	*(p++) = htonl(eof);
+	*(p++) = htonl(read->rd_eof);
 	*(p++) = htonl(maxcount);
 
 	buf->page_len = maxcount;
@@ -3943,7 +3943,6 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 				 struct file *file, unsigned long maxcount)
 {
 	struct xdr_stream *xdr = resp->xdr;
-	u32 eof;
 	int starting_len = xdr->buf->len - 8;
 	__be32 nfserr;
 	__be32 tmp;
@@ -3955,7 +3954,7 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 
 	nfserr = nfsd_readv(resp->rqstp, read->rd_fhp, file, read->rd_offset,
 			    resp->rqstp->rq_vec, read->rd_vlen, &maxcount,
-			    &eof);
+			    &read->rd_eof);
 	read->rd_length = maxcount;
 	if (nfserr)
 		return nfserr;
@@ -3963,7 +3962,7 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 		return nfserr_io;
 	xdr_truncate_encode(xdr, starting_len + 8 + xdr_align_size(maxcount));
 
-	tmp = htonl(eof);
+	tmp = htonl(read->rd_eof);
 	write_bytes_to_xdr_buf(xdr->buf, starting_len    , &tmp, 4);
 	tmp = htonl(maxcount);
 	write_bytes_to_xdr_buf(xdr->buf, starting_len + 4, &tmp, 4);
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 7b744011f2d3..6e6a89008ce1 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -302,9 +302,10 @@ struct nfsd4_read {
 	u32			rd_length;          /* request */
 	int			rd_vlen;
 	struct nfsd_file	*rd_nf;
-	
+
 	struct svc_rqst		*rd_rqstp;          /* response */
-	struct svc_fh		*rd_fhp;             /* response */
+	struct svc_fh		*rd_fhp;            /* response */
+	u32			rd_eof;             /* response */
 };
 
 struct nfsd4_readdir {


