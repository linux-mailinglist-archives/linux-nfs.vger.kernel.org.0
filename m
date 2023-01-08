Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC10166169B
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Jan 2023 17:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbjAHQ3Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Jan 2023 11:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236104AbjAHQ3U (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Jan 2023 11:29:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9579BDECE
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 08:29:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44C9BB801C1
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:29:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0647C433EF
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673195355;
        bh=yU44dm8r/pJTTVOzENxVl4aOQ7MAaVzzz9F/BxOpfkA=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=jn6/j0Oy9NYi2HM9zZJfaq7t8Ukw1xHkPo0PbOH9wkyc3rqQaLEi/h9+Iw5gMt2Ai
         9JHiCDtRnVMJwTQNBMV5oI4slCiecHICLtzoTkMbzResF9BUWus32ez7uNcUdprbJM
         3tYx+xk1Yrv6gi3kdfym0nLX5e+alLCQYLaI/YCu7UuqmqviRciZbrnEeqy60MW2ql
         7opInqvMEjHhrq+tGFtQ3BXJVPjg5Z1iJKchpiJM5NxQidKv2/vAkNeR/d+ML3IO14
         oHhMjnBSgG9aSCBKSbQvk76hYLIGxI/UzhyGymuXSCgTNzNYZSGfKyVlufro+ktKZP
         7+JHU7Ktk6ejw==
Subject: [PATCH v1 08/27] SUNRPC: Add @head and @tail variables in
 svcauth_gss_wrap_priv()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Sun, 08 Jan 2023 11:29:14 -0500
Message-ID: <167319535402.7490.11914043108523808242.stgit@bazille.1015granger.net>
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

Simplify the references to the head and tail iovecs for readability.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/svcauth_gss.c |   34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 573b9d029709..cfcd74e6369d 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1836,6 +1836,8 @@ static int svcauth_gss_wrap_priv(struct svc_rqst *rqstp)
 	struct gss_svc_data *gsd = rqstp->rq_auth_data;
 	struct rpc_gss_wire_cred *gc = &gsd->clcred;
 	struct xdr_buf *buf = &rqstp->rq_res;
+	struct kvec *head = buf->head;
+	struct kvec *tail = buf->tail;
 	u32 offset, pad, maj_stat;
 	__be32 *p, *lenp;
 
@@ -1844,7 +1846,7 @@ static int svcauth_gss_wrap_priv(struct svc_rqst *rqstp)
 		return 0;
 
 	lenp = p++;
-	offset = (u8 *)p - (u8 *)buf->head[0].iov_base;
+	offset = (u8 *)p - (u8 *)head->iov_base;
 	*p++ = htonl(gc->gc_seq);
 	/* XXX: Would be better to write some xdr helper functions for
 	 * nfs{2,3,4}xdr.c that place the data right, instead of copying: */
@@ -1856,19 +1858,17 @@ static int svcauth_gss_wrap_priv(struct svc_rqst *rqstp)
 	 * there is RPC_MAX_AUTH_SIZE slack space available in
 	 * both the head and tail.
 	 */
-	if (buf->tail[0].iov_base) {
-		if (buf->tail[0].iov_base >=
-			buf->head[0].iov_base + PAGE_SIZE)
+	if (tail->iov_base) {
+		if (tail->iov_base >= head->iov_base + PAGE_SIZE)
 			goto wrap_failed;
-		if (buf->tail[0].iov_base < buf->head[0].iov_base)
+		if (tail->iov_base < head->iov_base)
 			goto wrap_failed;
-		if (buf->tail[0].iov_len + buf->head[0].iov_len
+		if (tail->iov_len + head->iov_len
 				+ 2 * RPC_MAX_AUTH_SIZE > PAGE_SIZE)
 			goto wrap_failed;
-		memmove(buf->tail[0].iov_base + RPC_MAX_AUTH_SIZE,
-			buf->tail[0].iov_base,
-			buf->tail[0].iov_len);
-		buf->tail[0].iov_base += RPC_MAX_AUTH_SIZE;
+		memmove(tail->iov_base + RPC_MAX_AUTH_SIZE, tail->iov_base,
+			tail->iov_len);
+		tail->iov_base += RPC_MAX_AUTH_SIZE;
 	}
 	/*
 	 * If there is no current tail data, make sure there is
@@ -1877,12 +1877,12 @@ static int svcauth_gss_wrap_priv(struct svc_rqst *rqstp)
 	 * is RPC_MAX_AUTH_SIZE slack space available in both the
 	 * head and tail.
 	 */
-	if (!buf->tail[0].iov_base) {
-		if (buf->head[0].iov_len + 2 * RPC_MAX_AUTH_SIZE > PAGE_SIZE)
+	if (!tail->iov_base) {
+		if (head->iov_len + 2 * RPC_MAX_AUTH_SIZE > PAGE_SIZE)
 			goto wrap_failed;
-		buf->tail[0].iov_base = buf->head[0].iov_base
-			+ buf->head[0].iov_len + RPC_MAX_AUTH_SIZE;
-		buf->tail[0].iov_len = 0;
+		tail->iov_base = head->iov_base
+			+ head->iov_len + RPC_MAX_AUTH_SIZE;
+		tail->iov_len = 0;
 	}
 
 	maj_stat = gss_wrap(gsd->rsci->mechctx, offset, buf, buf->pages);
@@ -1891,9 +1891,9 @@ static int svcauth_gss_wrap_priv(struct svc_rqst *rqstp)
 
 	*lenp = htonl(buf->len - offset);
 	pad = 3 - ((buf->len - offset - 1) & 3);
-	p = (__be32 *)(buf->tail[0].iov_base + buf->tail[0].iov_len);
+	p = (__be32 *)(tail->iov_base + tail->iov_len);
 	memset(p, 0, pad);
-	buf->tail[0].iov_len += pad;
+	tail->iov_len += pad;
 	buf->len += pad;
 
 	return 0;


