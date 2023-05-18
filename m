Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82997708720
	for <lists+linux-nfs@lfdr.de>; Thu, 18 May 2023 19:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjERRqE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 May 2023 13:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjERRps (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 May 2023 13:45:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AE810D9
        for <linux-nfs@vger.kernel.org>; Thu, 18 May 2023 10:45:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF67165151
        for <linux-nfs@vger.kernel.org>; Thu, 18 May 2023 17:45:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0043C433EF;
        Thu, 18 May 2023 17:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684431938;
        bh=zmx31IBMhswvh8VvcwzaL8k+Mw8JRQIyOLRpM63CV0s=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bpUIM/xb/BsQt/XZiCRQKh+aA2Ak7oGdC+WuC4RA0n3zYZ51o4CFxYeW+4sRD2yPJ
         YhqHTB+37Ko4FiQoVqVm1cDOO10W85NoE8OAvVcZz+Ab57CMMVZdRa3OgxBCBM7YZM
         SKlpu1k//XQi4AtXCnNtAkpKEqcBOMoHi3ENqrvK0IIZV+0ECj8wOC8/mbIhjCIyOv
         1OcXNSRD0AIktPej8PiUe51x40iZ7ak0aEi3Vq3e2OHgdnsjogvGADQuhN21aVDqta
         ztwTkswQ9dSmnfBQRMV9eHvOTwfwUQINYYSlz+KdGdWfBzbSHlPfhU9FdkOx74baL9
         5HToUEzWkmmmQ==
Subject: [PATCH v1 1/6] NFSD: Ensure that xdr_write_pages updates rq_next_page
From:   Chuck Lever <cel@kernel.org>
To:     anna.schumaker@netapp.com, dhowells@redhat.com, jlayton@redhat.com
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date:   Thu, 18 May 2023 13:45:36 -0400
Message-ID: <168443193694.516083.10348236224527959251.stgit@klimt.1015granger.net>
In-Reply-To: <168443154055.516083.746756240848084451.stgit@klimt.1015granger.net>
References: <168443154055.516083.746756240848084451.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

All other NFSv[23] procedures manage to keep page_ptr and
rq_next_page in lock step.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3xdr.c          |   11 +++++++----
 fs/nfsd/nfsxdr.c           |   11 +++++++----
 include/linux/sunrpc/svc.h |   21 +++++++++++++++++++++
 3 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 3308dd671ef0..f32128955ec8 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -828,7 +828,8 @@ nfs3svc_encode_readlinkres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 			return false;
 		if (xdr_stream_encode_u32(xdr, resp->len) < 0)
 			return false;
-		xdr_write_pages(xdr, resp->pages, 0, resp->len);
+		svcxdr_encode_opaque_pages(rqstp, xdr, resp->pages, 0,
+					   resp->len);
 		if (svc_encode_result_payload(rqstp, head->iov_len, resp->len) < 0)
 			return false;
 		break;
@@ -859,8 +860,9 @@ nfs3svc_encode_readres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 			return false;
 		if (xdr_stream_encode_u32(xdr, resp->count) < 0)
 			return false;
-		xdr_write_pages(xdr, resp->pages, rqstp->rq_res.page_base,
-				resp->count);
+		svcxdr_encode_opaque_pages(rqstp, xdr, resp->pages,
+					   rqstp->rq_res.page_base,
+					   resp->count);
 		if (svc_encode_result_payload(rqstp, head->iov_len, resp->count) < 0)
 			return false;
 		break;
@@ -961,7 +963,8 @@ nfs3svc_encode_readdirres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 			return false;
 		if (!svcxdr_encode_cookieverf3(xdr, resp->verf))
 			return false;
-		xdr_write_pages(xdr, dirlist->pages, 0, dirlist->len);
+		svcxdr_encode_opaque_pages(rqstp, xdr, dirlist->pages, 0,
+					   dirlist->len);
 		/* no more entries */
 		if (xdr_stream_encode_item_absent(xdr) < 0)
 			return false;
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index caf6355b18fa..5777f40c7353 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -468,7 +468,8 @@ nfssvc_encode_readlinkres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	case nfs_ok:
 		if (xdr_stream_encode_u32(xdr, resp->len) < 0)
 			return false;
-		xdr_write_pages(xdr, &resp->page, 0, resp->len);
+		svcxdr_encode_opaque_pages(rqstp, xdr, &resp->page, 0,
+					   resp->len);
 		if (svc_encode_result_payload(rqstp, head->iov_len, resp->len) < 0)
 			return false;
 		break;
@@ -491,8 +492,9 @@ nfssvc_encode_readres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 			return false;
 		if (xdr_stream_encode_u32(xdr, resp->count) < 0)
 			return false;
-		xdr_write_pages(xdr, resp->pages, rqstp->rq_res.page_base,
-				resp->count);
+		svcxdr_encode_opaque_pages(rqstp, xdr, resp->pages,
+					   rqstp->rq_res.page_base,
+					   resp->count);
 		if (svc_encode_result_payload(rqstp, head->iov_len, resp->count) < 0)
 			return false;
 		break;
@@ -511,7 +513,8 @@ nfssvc_encode_readdirres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 		return false;
 	switch (resp->status) {
 	case nfs_ok:
-		xdr_write_pages(xdr, dirlist->pages, 0, dirlist->len);
+		svcxdr_encode_opaque_pages(rqstp, xdr, dirlist->pages, 0,
+					   dirlist->len);
 		/* no more entries */
 		if (xdr_stream_encode_item_absent(xdr) < 0)
 			return false;
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 762d7231e574..3b10636c51a9 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -508,6 +508,27 @@ static inline void svcxdr_init_encode(struct svc_rqst *rqstp)
 	xdr->rqst = NULL;
 }
 
+/**
+ * svcxdr_encode_opaque_pages - Insert pages into an xdr_stream
+ * @xdr: xdr_stream to be updated
+ * @pages: array of pages to insert
+ * @base: starting offset of first data byte in @pages
+ * @len: number of data bytes in @pages to insert
+ *
+ * After the @pages are added, the tail iovec is instantiated pointing
+ * to end of the head buffer, and the stream is set up to encode
+ * subsequent items into the tail.
+ */
+static inline void svcxdr_encode_opaque_pages(struct svc_rqst *rqstp,
+					      struct xdr_stream *xdr,
+					      struct page **pages,
+					      unsigned int base,
+					      unsigned int len)
+{
+	xdr_write_pages(xdr, pages, base, len);
+	xdr->page_ptr = rqstp->rq_next_page - 1;
+}
+
 /**
  * svcxdr_set_auth_slack -
  * @rqstp: RPC transaction


