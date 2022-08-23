Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473BF59EDDC
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Aug 2022 23:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiHWVAR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Aug 2022 17:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiHWVAM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Aug 2022 17:00:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE40785B0
        for <linux-nfs@vger.kernel.org>; Tue, 23 Aug 2022 14:00:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 471B56159D
        for <linux-nfs@vger.kernel.org>; Tue, 23 Aug 2022 21:00:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863D0C433B5;
        Tue, 23 Aug 2022 21:00:08 +0000 (UTC)
Subject: [PATCH v1 1/7] SUNRPC: Fix end-of-buffer calculation
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 23 Aug 2022 17:00:07 -0400
Message-ID: <166128840714.2788.7887913547062461761.stgit@manet.1015granger.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Ensure that stream-based argument decoding can't go past the actual
end of the receive buffer. xdr_init_decode's calculation of the
value of xdr->end over-estimates the end of the buffer because the
Linux kernel RPC server code does not remove the size of the RPC
header from rqstp->rq_arg before calling the upper layer's
dispatcher.

The server-side still uses the svc_getnl() macros to decode the
RPC call header. These macros reduce the length of the head iov
but do not update the total length of the message in the buffer
(buf->len).

A proper fix for this would be to replace the use of svc_getnl() and
friends in the RPC header decoder, but that would be a large and
invasive change that would be difficult to backport.

Fixes: 5191955d6fc6 ("SUNRPC: Prepare for xdr_stream-style decoding on the server-side")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h |   14 +++++++++++---
 include/linux/sunrpc/xdr.h |   12 ++++++++++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index daecb009c05b..494375313a6f 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -544,16 +544,24 @@ static inline void svc_reserve_auth(struct svc_rqst *rqstp, int space)
 }
 
 /**
- * svcxdr_init_decode - Prepare an xdr_stream for svc Call decoding
+ * svcxdr_init_decode - Prepare an xdr_stream for Call decoding
  * @rqstp: controlling server RPC transaction context
  *
+ * This function currently assumes the RPC header in rq_arg has
+ * already been decoded. Upon return, xdr->p points to the
+ * location of the upper layer header.
  */
 static inline void svcxdr_init_decode(struct svc_rqst *rqstp)
 {
 	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
-	struct kvec *argv = rqstp->rq_arg.head;
+	struct xdr_buf *buf = &rqstp->rq_arg;
+	struct kvec *argv = buf->head;
 
-	xdr_init_decode(xdr, &rqstp->rq_arg, argv->iov_base, NULL);
+	/* Reset the argument buffer's length, now that the RPC header
+	 * has been decoded. */
+	buf->len = xdr_buf_length(buf);
+
+	xdr_init_decode(xdr, buf, argv->iov_base, NULL);
 	xdr_set_scratch_page(xdr, rqstp->rq_scratch_page);
 }
 
diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 69175029abbb..f6bb215d4029 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -83,6 +83,18 @@ xdr_buf_init(struct xdr_buf *buf, void *start, size_t len)
 	buf->buflen = len;
 }
 
+/**
+ * xdr_buf_length - Return the summed length of @buf's sub-buffers
+ * @buf: an instantiated xdr_buf
+ *
+ * Returns the sum of the lengths of the head kvec, the tail kvec,
+ * and the page array.
+ */
+static inline unsigned int xdr_buf_length(const struct xdr_buf *buf)
+{
+	return buf->head->iov_len + buf->page_len + buf->tail->iov_len;
+}
+
 /*
  * pre-xdr'ed macros.
  */


