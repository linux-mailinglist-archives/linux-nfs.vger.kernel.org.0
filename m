Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0DCB30BC
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Sep 2019 17:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731545AbfIOPlY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 15 Sep 2019 11:41:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48360 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730811AbfIOPlX (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 15 Sep 2019 11:41:23 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 416D8308404E;
        Sun, 15 Sep 2019 15:41:23 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B54131001B07;
        Sun, 15 Sep 2019 15:41:22 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 48D32109AF40; Sun, 15 Sep 2019 11:41:23 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        tibbs@math.uh.edu, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, bfields@fieldses.org, km@cm4all.com
Subject: [PATCH v2 2/2] SUNRPC: Rename xdr_buf_read_netobj to xdr_buf_read_mic
Date:   Sun, 15 Sep 2019 11:41:23 -0400
Message-Id: <e3d308728feb1ee134898977571d3ff93b156ace.1568557832.git.bcodding@redhat.com>
In-Reply-To: <9f9848f4cbb03b09c7f28f8a43fb27120703ae49.1568557832.git.bcodding@redhat.com>
References: <9f9848f4cbb03b09c7f28f8a43fb27120703ae49.1568557832.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Sun, 15 Sep 2019 15:41:23 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Let the name reflect the single use.  The function now assumes the GSS MIC
is the last object in the buffer.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 include/linux/sunrpc/xdr.h     |  2 +-
 net/sunrpc/auth_gss/auth_gss.c |  2 +-
 net/sunrpc/xdr.c               | 50 ++++++++++++++++++++++------------
 3 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 9ee3970ba59c..a6b63e47a79b 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -179,7 +179,7 @@ xdr_adjust_iovec(struct kvec *iov, __be32 *p)
 extern void xdr_shift_buf(struct xdr_buf *, size_t);
 extern void xdr_buf_from_iov(struct kvec *, struct xdr_buf *);
 extern int xdr_buf_subsegment(struct xdr_buf *, struct xdr_buf *, unsigned int, unsigned int);
-extern int xdr_buf_read_netobj(struct xdr_buf *, struct xdr_netobj *, unsigned int);
+extern int xdr_buf_read_mic(struct xdr_buf *, struct xdr_netobj *, unsigned int);
 extern int read_bytes_from_xdr_buf(struct xdr_buf *, unsigned int, void *, unsigned int);
 extern int write_bytes_to_xdr_buf(struct xdr_buf *, unsigned int, void *, unsigned int);
 
diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 4ce42c62458e..d75fddca44c9 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -1960,7 +1960,7 @@ gss_unwrap_resp_integ(struct rpc_task *task, struct rpc_cred *cred,
 
 	if (xdr_buf_subsegment(rcv_buf, &integ_buf, data_offset, integ_len))
 		goto unwrap_failed;
-	if (xdr_buf_read_netobj(rcv_buf, &mic, mic_offset))
+	if (xdr_buf_read_mic(rcv_buf, &mic, mic_offset))
 		goto unwrap_failed;
 	maj_stat = gss_verify_mic(ctx->gc_gss_ctx, &integ_buf, &mic);
 	if (maj_stat == GSS_S_CONTEXT_EXPIRED)
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index a29ce73c3029..2d046573d3a0 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1240,45 +1240,59 @@ EXPORT_SYMBOL_GPL(xdr_encode_word);
  * entirely in the head, pages, or tail, set object to point to it; otherwise
  * shift the buffer until it is contained entirely within the pages or tail.
  */
-int xdr_buf_read_netobj(struct xdr_buf *buf, struct xdr_netobj *obj, unsigned int offset)
+
+
+/**
+ * xdr_buf_read_mic() - obtain the address of the GSS mic from xdr buf
+ * @buf: pointer to buffer containing a mic
+ * @mic: on success, returns the address of the mic
+ * @offset: the offset in buf where mic may be found
+ *
+ * This function may modify the xdr buf if the mic is found to be straddling
+ * a boundary between head, pages, and tail.  On success the mic can be read
+ * from the address returned.  There is no need to free the mic.
+ *
+ * Return: Success returns 0, otherwise an integer error.
+ */
+int xdr_buf_read_mic(struct xdr_buf *buf, struct xdr_netobj *mic, unsigned int offset)
 {
 	struct xdr_buf subbuf;
 	unsigned int boundary;
 
-	if (xdr_decode_word(buf, offset, &obj->len))
+	if (xdr_decode_word(buf, offset, &mic->len))
 		return -EFAULT;
 	offset += 4;
 
-	/* Is the obj partially in the head? */
+	/* Is the mic partially in the head? */
 	boundary = buf->head[0].iov_len;
-	if (offset < boundary && (offset + obj->len) > boundary)
+	if (offset < boundary && (offset + mic->len) > boundary)
 		xdr_shift_buf(buf, boundary - offset);
 
-	/* Is the obj partially in the pages? */
+	/* Is the mic partially in the pages? */
 	boundary += buf->page_len;
-	if (offset < boundary && (offset + obj->len) > boundary)
+	if (offset < boundary && (offset + mic->len) > boundary)
 		xdr_shrink_pagelen(buf, boundary - offset);
 
-	if (xdr_buf_subsegment(buf, &subbuf, offset, obj->len))
+	if (xdr_buf_subsegment(buf, &subbuf, offset, mic->len))
 		return -EFAULT;
 
-	/* Is the obj contained entirely in the head? */
-	obj->data = subbuf.head[0].iov_base;
-	if (subbuf.head[0].iov_len == obj->len)
+	/* Is the mic contained entirely in the head? */
+	mic->data = subbuf.head[0].iov_base;
+	if (subbuf.head[0].iov_len == mic->len)
 		return 0;
-	/* ..or is the obj contained entirely in the tail? */
-	obj->data = subbuf.tail[0].iov_base;
-	if (subbuf.tail[0].iov_len == obj->len)
+	/* ..or is the mic contained entirely in the tail? */
+	mic->data = subbuf.tail[0].iov_base;
+	if (subbuf.tail[0].iov_len == mic->len)
 		return 0;
 
-	/* obj is in the pages: move to end of the tail */
-	if (obj->len > buf->buflen - buf->len)
+	/* mic is in the pages: move to the tail */
+	if (mic->len > buf->buflen - buf->len)
 		return -ENOMEM;
-	obj->data = buf->tail[0].iov_base + buf->tail[0].iov_len;
-	__read_bytes_from_xdr_buf(&subbuf, obj->data, obj->len);
+	mic->data = buf->tail[0].iov_base;
+	__read_bytes_from_xdr_buf(&subbuf, mic->data, mic->len);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(xdr_buf_read_netobj);
+EXPORT_SYMBOL_GPL(xdr_buf_read_mic);
 
 /* Returns 0 on success, or else a negative error code. */
 static int
-- 
2.20.1

