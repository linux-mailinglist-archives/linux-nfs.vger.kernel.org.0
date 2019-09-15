Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 364AAB30BD
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Sep 2019 17:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbfIOPlY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 15 Sep 2019 11:41:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39556 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbfIOPlY (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 15 Sep 2019 11:41:24 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3A7123B714;
        Sun, 15 Sep 2019 15:41:23 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B244160BE0;
        Sun, 15 Sep 2019 15:41:22 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 44407109C550; Sun, 15 Sep 2019 11:41:23 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        tibbs@math.uh.edu, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, bfields@fieldses.org, km@cm4all.com
Subject: [PATCH v2 1/2] SUNRPC: Fix buffer handling of GSS MIC without slack
Date:   Sun, 15 Sep 2019 11:41:22 -0400
Message-Id: <9f9848f4cbb03b09c7f28f8a43fb27120703ae49.1568557832.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Sun, 15 Sep 2019 15:41:23 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The GSS Message Integrity Check data for krb5i may lie partially in the XDR
reply buffer's pages and tail.  If so, we try to copy the entire MIC into
free space in the tail.  But as the estimations of the slack space required
for authentication and verification have improved there may be less free
space in the tail to complete this copy -- see commit 2c94b8eca1a2
("SUNRPC: Use au_rslack when computing reply buffer size").  In fact, there
may only be room in the tail for a single copy of the MIC, and not part of
the MIC and then another complete copy.

The real world failure reported is that `ls` of a directory on NFS may
sometimes return -EIO, which can be traced back to xdr_buf_read_netobj()
failing to find available free space in the tail to copy the MIC.

Fix this by checking for the case of the MIC crossing the boundaries of
head, pages, and tail. If so, shift the buffer until the MIC is contained
completely within the pages or tail.  This allows the remainder of the
function to create a sub buffer that directly address the complete MIC.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
Cc: stable@vger.kernel.org # v5.1
---
 net/sunrpc/xdr.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 48c93b9e525e..a29ce73c3029 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1237,16 +1237,29 @@ xdr_encode_word(struct xdr_buf *buf, unsigned int base, u32 obj)
 EXPORT_SYMBOL_GPL(xdr_encode_word);
 
 /* If the netobj starting offset bytes from the start of xdr_buf is contained
- * entirely in the head or the tail, set object to point to it; otherwise
- * try to find space for it at the end of the tail, copy it there, and
- * set obj to point to it. */
+ * entirely in the head, pages, or tail, set object to point to it; otherwise
+ * shift the buffer until it is contained entirely within the pages or tail.
+ */
 int xdr_buf_read_netobj(struct xdr_buf *buf, struct xdr_netobj *obj, unsigned int offset)
 {
 	struct xdr_buf subbuf;
+	unsigned int boundary;
 
 	if (xdr_decode_word(buf, offset, &obj->len))
 		return -EFAULT;
-	if (xdr_buf_subsegment(buf, &subbuf, offset + 4, obj->len))
+	offset += 4;
+
+	/* Is the obj partially in the head? */
+	boundary = buf->head[0].iov_len;
+	if (offset < boundary && (offset + obj->len) > boundary)
+		xdr_shift_buf(buf, boundary - offset);
+
+	/* Is the obj partially in the pages? */
+	boundary += buf->page_len;
+	if (offset < boundary && (offset + obj->len) > boundary)
+		xdr_shrink_pagelen(buf, boundary - offset);
+
+	if (xdr_buf_subsegment(buf, &subbuf, offset, obj->len))
 		return -EFAULT;
 
 	/* Is the obj contained entirely in the head? */
@@ -1258,17 +1271,10 @@ int xdr_buf_read_netobj(struct xdr_buf *buf, struct xdr_netobj *obj, unsigned in
 	if (subbuf.tail[0].iov_len == obj->len)
 		return 0;
 
-	/* use end of tail as storage for obj:
-	 * (We don't copy to the beginning because then we'd have
-	 * to worry about doing a potentially overlapping copy.
-	 * This assumes the object is at most half the length of the
-	 * tail.) */
+	/* obj is in the pages: move to end of the tail */
 	if (obj->len > buf->buflen - buf->len)
 		return -ENOMEM;
-	if (buf->tail[0].iov_len != 0)
-		obj->data = buf->tail[0].iov_base + buf->tail[0].iov_len;
-	else
-		obj->data = buf->head[0].iov_base + buf->head[0].iov_len;
+	obj->data = buf->tail[0].iov_base + buf->tail[0].iov_len;
 	__read_bytes_from_xdr_buf(&subbuf, obj->data, obj->len);
 	return 0;
 }
-- 
2.20.1

