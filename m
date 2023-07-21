Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4272D75D5D7
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jul 2023 22:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjGUUkA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Jul 2023 16:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjGUUj6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Jul 2023 16:39:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C567530D6
        for <linux-nfs@vger.kernel.org>; Fri, 21 Jul 2023 13:39:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7D9961DA2
        for <linux-nfs@vger.kernel.org>; Fri, 21 Jul 2023 20:39:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B4CC433CA;
        Fri, 21 Jul 2023 20:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689971997;
        bh=iL75ElDphkS82/qNzpQ/BGJl3oi/Ae1Tnh4sy2V8REM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NFMY0QJ/HJD6FiXQ4/q/nUfoDpdvbS4ixzxfXZfQqz+WJfSbnE94djbppU6FUIz6O
         ufDWBEM3TseHqrH7xmmNnrOfd/j+2UhHofzpjrneqNrXcHDY0hZM3kPo6QCvWNX3tP
         WxutP2WmB04Vl04qK0J35gESRLve5TvS05zK3M5+xq4eQLewhKu7lS0//dCFN5lww+
         7GNpwEG0V1ZpA6DylNrh+HwfRo2KlbY0uTuqbkXlkC+B+Az2qaTkzGbQrXv87B4+Gy
         IykxQPe/munXxEovmEHba17qrome78iOiMfvyjHuPlAi8RP7AX9QVOvuXULFd7DNk7
         Qfl0/tF9iTNSA==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc:     anna@kernel.org, krzysztof.kozlowski@linaro.org
Subject: [PATCH v6 4/5] SUNRPC: kmap() the xdr pages during decode
Date:   Fri, 21 Jul 2023 16:39:52 -0400
Message-ID: <20230721203953.315706-5-anna@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721203953.315706-1-anna@kernel.org>
References: <20230721203953.315706-1-anna@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
decode to kunmap() the last page. I introduced an xdr_finish_decode()
function to do this. Right now this function only calls the
unmap_current_page() function, but other generic cleanup steps could be
added in the future if we come across anything else.

Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 include/linux/sunrpc/xdr.h |  3 +++
 net/sunrpc/clnt.c          |  1 +
 net/sunrpc/svc.c           |  2 ++
 net/sunrpc/xdr.c           | 27 ++++++++++++++++++++++++++-
 4 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 6bffd10b7a33..b75b3d416c5c 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -228,6 +228,7 @@ struct xdr_stream {
 	struct kvec *iov;	/* pointer to the current kvec */
 	struct kvec scratch;	/* Scratch buffer */
 	struct page **page_ptr;	/* pointer to the current page */
+	void *page_kaddr;	/* kmapped address of the current page */
 	unsigned int nwords;	/* Remaining decode buffer length */
 
 	struct rpc_rqst *rqst;	/* For debugging */
@@ -253,12 +254,14 @@ extern void xdr_truncate_decode(struct xdr_stream *xdr, size_t len);
 extern int xdr_restrict_buflen(struct xdr_stream *xdr, int newbuflen);
 extern void xdr_write_pages(struct xdr_stream *xdr, struct page **pages,
 		unsigned int base, unsigned int len);
+extern void xdr_stream_unmap_current_page(struct xdr_stream *xdr);
 extern unsigned int xdr_stream_pos(const struct xdr_stream *xdr);
 extern unsigned int xdr_page_pos(const struct xdr_stream *xdr);
 extern void xdr_init_decode(struct xdr_stream *xdr, struct xdr_buf *buf,
 			    __be32 *p, struct rpc_rqst *rqst);
 extern void xdr_init_decode_pages(struct xdr_stream *xdr, struct xdr_buf *buf,
 		struct page **pages, unsigned int len);
+extern void xdr_finish_decode(struct xdr_stream *xdr);
 extern __be32 *xdr_inline_decode(struct xdr_stream *xdr, size_t nbytes);
 extern unsigned int xdr_read_pages(struct xdr_stream *xdr, unsigned int len);
 extern void xdr_enter_page(struct xdr_stream *xdr, unsigned int len);
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index d7c697af3762..ca2c6efe19c9 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2602,6 +2602,7 @@ call_decode(struct rpc_task *task)
 	case 0:
 		task->tk_action = rpc_exit_task;
 		task->tk_status = rpcauth_unwrap_resp(task, &xdr);
+		xdr_finish_decode(&xdr);
 		return;
 	case -EAGAIN:
 		task->tk_status = 0;
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 587811a002c9..a864414ce811 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1370,6 +1370,8 @@ svc_process_common(struct svc_rqst *rqstp)
 	rc = process.dispatch(rqstp);
 	if (procp->pc_release)
 		procp->pc_release(rqstp);
+	xdr_finish_decode(xdr);
+
 	if (!rc)
 		goto dropit;
 	if (rqstp->rq_auth_stat != rpc_auth_ok)
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 94bddd1dd1d7..d318701a904a 100644
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
@@ -1414,6 +1429,16 @@ void xdr_init_decode_pages(struct xdr_stream *xdr, struct xdr_buf *buf,
 }
 EXPORT_SYMBOL_GPL(xdr_init_decode_pages);
 
+/**
+ * xdr_finish_decode - Clean up the xdr_stream after decoding data.
+ * @xdr: pointer to xdr_stream struct
+ */
+void xdr_finish_decode(struct xdr_stream *xdr)
+{
+	xdr_stream_unmap_current_page(xdr);
+}
+EXPORT_SYMBOL(xdr_finish_decode);
+
 static __be32 * __xdr_inline_decode(struct xdr_stream *xdr, size_t nbytes)
 {
 	unsigned int nwords = XDR_QUADLEN(nbytes);
-- 
2.41.0

