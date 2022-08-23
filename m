Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D5259EDE0
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Aug 2022 23:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiHWVA7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Aug 2022 17:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiHWVAy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Aug 2022 17:00:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763E67AC19
        for <linux-nfs@vger.kernel.org>; Tue, 23 Aug 2022 14:00:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A4E9B82184
        for <linux-nfs@vger.kernel.org>; Tue, 23 Aug 2022 21:00:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A656C433C1;
        Tue, 23 Aug 2022 21:00:46 +0000 (UTC)
Subject: [PATCH v1 7/7] SUNRPC: Use the new xdr_buf_length() helper
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 23 Aug 2022 17:00:45 -0400
Message-ID: <166128844564.2788.14369025982070863998.stgit@manet.1015granger.net>
In-Reply-To: <166128840714.2788.7887913547062461761.stgit@manet.1015granger.net>
References: <166128840714.2788.7887913547062461761.stgit@manet.1015granger.net>
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

Clean up.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |    3 +--
 net/sunrpc/xdr.c  |    5 ++---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 1e9690a061ec..26d005c5ec10 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5426,8 +5426,7 @@ nfs4svc_encode_compoundres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	struct xdr_buf *buf = xdr->buf;
 	__be32 *p;
 
-	WARN_ON_ONCE(buf->len != buf->head[0].iov_len + buf->page_len +
-				 buf->tail[0].iov_len);
+	WARN_ON_ONCE(buf->len != xdr_buf_length(buf));
 
 	/*
 	 * Send buffer space for the following items is reserved
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 8ad637ca703e..f77a7d98b294 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -508,9 +508,8 @@ static unsigned int xdr_buf_pages_fill_sparse(const struct xdr_buf *buf,
 
 static void xdr_buf_try_expand(struct xdr_buf *buf, unsigned int len)
 {
-	struct kvec *head = buf->head;
 	struct kvec *tail = buf->tail;
-	unsigned int sum = head->iov_len + buf->page_len + tail->iov_len;
+	unsigned int sum = xdr_buf_length(buf);
 	unsigned int free_space, newlen;
 
 	if (sum > buf->len) {
@@ -2060,7 +2059,7 @@ int xdr_encode_array2(const struct xdr_buf *buf, unsigned int base,
 		      struct xdr_array2_desc *desc)
 {
 	if ((unsigned long) base + 4 + desc->array_len * desc->elem_size >
-	    buf->head->iov_len + buf->page_len + buf->tail->iov_len)
+	    xdr_buf_length(buf))
 		return -EINVAL;
 
 	return xdr_xcode_array2(buf, base, desc, 1);


