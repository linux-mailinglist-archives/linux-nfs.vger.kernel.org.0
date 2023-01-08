Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A4F6616B4
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Jan 2023 17:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbjAHQbY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Jan 2023 11:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236238AbjAHQaz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Jan 2023 11:30:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF33D125
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 08:30:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 692FE60C8C
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:30:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB683C433F0
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673195453;
        bh=4lC584jtj171PekqVOHcolTWrxY4SdAn+3yqCcCk0+g=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=g0edeSs0MTF5aU8hk0E+qpBs/6lL4yA0eQfrnLsF4pqqTVwTcHK8YRQnF9pTwCVfZ
         W6EDNL2l/2BgMHeFGHDnZEPogslgpVKPDseI4Zka1RGegjAvGHq0m+b/gMlnAepA62
         caq6GWlkQ32awQZ5+ei+gHdUTLYiuZg1SgmuDzXYPRu5+JkzfOYwPMdI/7ysdIsmxK
         epd/u/vjq1hNgfhJfzR8qyfXy0JzJcZdp8AE+bIfhNdkxi0iyEWpcEQQiyv/mxWEyx
         R/N7r7Ax2hxOMJ24wtEzQPEMrHmZT2XaFGek6i2CHEI6EPFWBIBVO4gDw3+hd2lTaL
         s2JT+VajNP0LQ==
Subject: [PATCH v1 24/27] SUNRPC: Remove no-longer-used helper functions
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Sun, 08 Jan 2023 11:30:52 -0500
Message-ID: <167319545290.7490.4776771429759719974.stgit@bazille.1015granger.net>
In-Reply-To: <167319499150.7490.2294168831574653380.stgit@bazille.1015granger.net>
References: <167319499150.7490.2294168831574653380.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

The svc_get/put helpers are no longer used.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h |   66 +-------------------------------------------
 1 file changed, 1 insertion(+), 65 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index dd9f68acd9f1..32eb98e621c3 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -193,40 +193,6 @@ extern u32 svc_max_payload(const struct svc_rqst *rqstp);
 #define RPCSVC_MAXPAGES		((RPCSVC_MAXPAYLOAD+PAGE_SIZE-1)/PAGE_SIZE \
 				+ 2 + 1)
 
-static inline u32 svc_getnl(struct kvec *iov)
-{
-	__be32 val, *vp;
-	vp = iov->iov_base;
-	val = *vp++;
-	iov->iov_base = (void*)vp;
-	iov->iov_len -= sizeof(__be32);
-	return ntohl(val);
-}
-
-static inline void svc_putnl(struct kvec *iov, u32 val)
-{
-	__be32 *vp = iov->iov_base + iov->iov_len;
-	*vp = htonl(val);
-	iov->iov_len += sizeof(__be32);
-}
-
-static inline __be32 svc_getu32(struct kvec *iov)
-{
-	__be32 val, *vp;
-	vp = iov->iov_base;
-	val = *vp++;
-	iov->iov_base = (void*)vp;
-	iov->iov_len -= sizeof(__be32);
-	return val;
-}
-
-static inline void svc_putu32(struct kvec *iov, __be32 val)
-{
-	__be32 *vp = iov->iov_base + iov->iov_len;
-	*vp = val;
-	iov->iov_len += sizeof(__be32);
-}
-
 /*
  * The context of a single thread, including the request currently being
  * processed.
@@ -345,29 +311,6 @@ static inline struct sockaddr *svc_daddr(const struct svc_rqst *rqst)
 	return (struct sockaddr *) &rqst->rq_daddr;
 }
 
-/*
- * Check buffer bounds after decoding arguments
- */
-static inline int
-xdr_argsize_check(struct svc_rqst *rqstp, __be32 *p)
-{
-	char *cp = (char *)p;
-	struct kvec *vec = &rqstp->rq_arg.head[0];
-	return cp >= (char*)vec->iov_base
-		&& cp <= (char*)vec->iov_base + vec->iov_len;
-}
-
-static inline int
-xdr_ressize_check(struct svc_rqst *rqstp, __be32 *p)
-{
-	struct kvec *vec = &rqstp->rq_res.head[0];
-	char *cp = (char*)p;
-
-	vec->iov_len = cp - (char*)vec->iov_base;
-
-	return vec->iov_len <= PAGE_SIZE;
-}
-
 static inline void svc_free_res_pages(struct svc_rqst *rqstp)
 {
 	while (rqstp->rq_next_page != rqstp->rq_respages) {
@@ -540,9 +483,6 @@ static inline void svc_reserve_auth(struct svc_rqst *rqstp, int space)
  * svcxdr_init_decode - Prepare an xdr_stream for Call decoding
  * @rqstp: controlling server RPC transaction context
  *
- * This function currently assumes the RPC header in rq_arg has
- * already been decoded. Upon return, xdr->p points to the
- * location of the upper layer header.
  */
 static inline void svcxdr_init_decode(struct svc_rqst *rqstp)
 {
@@ -550,11 +490,7 @@ static inline void svcxdr_init_decode(struct svc_rqst *rqstp)
 	struct xdr_buf *buf = &rqstp->rq_arg;
 	struct kvec *argv = buf->head;
 
-	/*
-	 * svc_getnl() and friends do not keep the xdr_buf's ::len
-	 * field up to date. Refresh that field before initializing
-	 * the argument decoding stream.
-	 */
+	WARN_ON(buf->len != buf->head->iov_len + buf->page_len + buf->tail->iov_len);
 	buf->len = buf->head->iov_len + buf->page_len + buf->tail->iov_len;
 
 	xdr_init_decode(xdr, buf, argv->iov_base, NULL);


