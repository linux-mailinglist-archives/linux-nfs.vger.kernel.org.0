Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F6D756E99
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jul 2023 22:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjGQUxZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Jul 2023 16:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjGQUxU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Jul 2023 16:53:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BDE172C
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jul 2023 13:52:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B848D6125F
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jul 2023 20:52:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57B8C433C9;
        Mon, 17 Jul 2023 20:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689627163;
        bh=CUpREJSecbGR1uFJn7DaCS4lubh25miJ6F+Vmuqh8PY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S+Oph1nZ6NOeKsDVbF7NyZ8c8wGbkvC32bsSYoLEiTaKVi9rvptN4CDqCtcfdUpbe
         45/WVU8lR/oy6Mte2/y5RX+KbxMck9H6ktBRttPvURRVAncTvHtBO6mQJUCpvcXywn
         4q9DQhh+sB0waabT43a5LLe6Ik4rzlauTdJV7TIypu5aj9z4AbM0XuF8YKZmbuFyhn
         qIFdx6DziX4yS4wPfadrxgoKaCLC8el5TBwCYDZ4NEtIOoUOb9DtOZNT8urehZ7Net
         e7fZmruaVVpILjTo0ers4woBtGBicgQolMe+e2PSbsMakx1E+B1gdP7SSPfr6VW6lJ
         E129EfkSDMi+w==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc:     anna@kernel.org, krzysztof.kozlowski@linaro.org
Subject: [PATCH v5 4/5] SUNRPC: kmap() the xdr pages during decode
Date:   Mon, 17 Jul 2023 16:52:38 -0400
Message-ID: <20230717205239.921002-5-anna@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230717205239.921002-1-anna@kernel.org>
References: <20230717205239.921002-1-anna@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

If the pages are in HIGHMEM then we need to make sure they're mapped
before trying to read data off of them, otherwise we could end up with a
NULL pointer dereference.

The downside to this is that we need an extra cleanup step at the end of
decode to kunmap() the last page.

Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
v5: Also clean up kmapped pages on the server
---
 include/linux/sunrpc/xdr.h |  2 ++
 net/sunrpc/clnt.c          |  1 +
 net/sunrpc/svc.c           |  2 ++
 net/sunrpc/xdr.c           | 17 ++++++++++++++++-
 4 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 6bffd10b7a33..60ddad33b49b 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -228,6 +228,7 @@ struct xdr_stream {
 	struct kvec *iov;	/* pointer to the current kvec */
 	struct kvec scratch;	/* Scratch buffer */
 	struct page **page_ptr;	/* pointer to the current page */
+	void *page_kaddr;	/* kmapped address of the current page */
 	unsigned int nwords;	/* Remaining decode buffer length */
 
 	struct rpc_rqst *rqst;	/* For debugging */
@@ -253,6 +254,7 @@ extern void xdr_truncate_decode(struct xdr_stream *xdr, size_t len);
 extern int xdr_restrict_buflen(struct xdr_stream *xdr, int newbuflen);
 extern void xdr_write_pages(struct xdr_stream *xdr, struct page **pages,
 		unsigned int base, unsigned int len);
+extern void xdr_stream_unmap_current_page(struct xdr_stream *xdr);
 extern unsigned int xdr_stream_pos(const struct xdr_stream *xdr);
 extern unsigned int xdr_page_pos(const struct xdr_stream *xdr);
 extern void xdr_init_decode(struct xdr_stream *xdr, struct xdr_buf *buf,
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index d7c697af3762..8080a1830ff3 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2602,6 +2602,7 @@ call_decode(struct rpc_task *task)
 	case 0:
 		task->tk_action = rpc_exit_task;
 		task->tk_status = rpcauth_unwrap_resp(task, &xdr);
+		xdr_stream_unmap_current_page(&xdr);
 		return;
 	case -EAGAIN:
 		task->tk_status = 0;
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 587811a002c9..5f32817579db 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1370,6 +1370,8 @@ svc_process_common(struct svc_rqst *rqstp)
 	rc = process.dispatch(rqstp);
 	if (procp->pc_release)
 		procp->pc_release(rqstp);
+	xdr_stream_unmap_current_page(xdr);
+
 	if (!rc)
 		goto dropit;
 	if (rqstp->rq_auth_stat != rpc_auth_ok)
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 94bddd1dd1d7..2b972954327f 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1306,6 +1306,14 @@ static unsigned int xdr_set_tail_base(struct xdr_stream *xdr,
 	return xdr_set_iov(xdr, buf->tail, base, len);
 }
 
+void xdr_stream_unmap_current_page(struct xdr_stream *xdr)
+{
+	if (xdr->page_kaddr) {
+		kunmap_local(xdr->page_kaddr);
+		xdr->page_kaddr = NULL;
+	}
+}
+
 static unsigned int xdr_set_page_base(struct xdr_stream *xdr,
 				      unsigned int base, unsigned int len)
 {
@@ -1323,12 +1331,18 @@ static unsigned int xdr_set_page_base(struct xdr_stream *xdr,
 	if (len > maxlen)
 		len = maxlen;
 
+	xdr_stream_unmap_current_page(xdr);
 	xdr_stream_page_set_pos(xdr, base);
 	base += xdr->buf->page_base;
 
 	pgnr = base >> PAGE_SHIFT;
 	xdr->page_ptr = &xdr->buf->pages[pgnr];
-	kaddr = page_address(*xdr->page_ptr);
+
+	if (PageHighMem(*xdr->page_ptr)) {
+		xdr->page_kaddr = kmap_local_page(*xdr->page_ptr);
+		kaddr = xdr->page_kaddr;
+	} else
+		kaddr = page_address(*xdr->page_ptr);
 
 	pgoff = base & ~PAGE_MASK;
 	xdr->p = (__be32*)(kaddr + pgoff);
@@ -1382,6 +1396,7 @@ void xdr_init_decode(struct xdr_stream *xdr, struct xdr_buf *buf, __be32 *p,
 		     struct rpc_rqst *rqst)
 {
 	xdr->buf = buf;
+	xdr->page_kaddr = NULL;
 	xdr_reset_scratch_buffer(xdr);
 	xdr->nwords = XDR_QUADLEN(buf->len);
 	if (xdr_set_iov(xdr, buf->head, 0, buf->len) == 0 &&
-- 
2.41.0

