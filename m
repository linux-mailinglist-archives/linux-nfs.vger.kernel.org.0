Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB84B1339
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2019 19:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbfILRH6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Sep 2019 13:07:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43322 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728646AbfILRH5 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 12 Sep 2019 13:07:57 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6FEDD307D847;
        Thu, 12 Sep 2019 17:07:57 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1AD431001B02;
        Thu, 12 Sep 2019 17:07:57 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 74A0A109C550; Thu, 12 Sep 2019 13:07:57 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        tibbs@math.uh.edu
Cc:     linux-nfs@vger.kernel.org, bfields@fieldses.org,
        chuck.lever@oracle.com, km@cm4all.com
Subject: [PATCH 1/2] SUNRPC: Fix buffer handling of GSS MIC with less slack
Date:   Thu, 12 Sep 2019 13:07:56 -0400
Message-Id: <043d2ca649c3d81cdf0b43b149cd43069ad1c1e2.1568307763.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 12 Sep 2019 17:07:57 +0000 (UTC)
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
Cc: stable@vger.kernel.org
---
 net/sunrpc/xdr.c | 45 +++++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 48c93b9e525e..6e05a9693568 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1237,39 +1237,48 @@ xdr_encode_word(struct xdr_buf *buf, unsigned int base, u32 obj)
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
+	unsigned int len_to_boundary;
 
 	if (xdr_decode_word(buf, offset, &obj->len))
 		return -EFAULT;
-	if (xdr_buf_subsegment(buf, &subbuf, offset + 4, obj->len))
+
+	offset += 4;
+
+	/* Is the obj partially in the head? */
+	len_to_boundary = buf->head->iov_len - offset;
+	if (len_to_boundary > 0 && len_to_boundary < obj->len)
+		xdr_shift_buf(buf, len_to_boundary);
+
+	/* Is the obj partially in the pages? */
+	len_to_boundary = buf->head->iov_len + buf->page_len - offset;
+	if (len_to_boundary > 0 && len_to_boundary < obj->len)
+		xdr_shrink_pagelen(buf, len_to_boundary);
+
+	if (xdr_buf_subsegment(buf, &subbuf, offset, obj->len))
 		return -EFAULT;
 
-	/* Is the obj contained entirely in the head? */
-	obj->data = subbuf.head[0].iov_base;
-	if (subbuf.head[0].iov_len == obj->len)
-		return 0;
-	/* ..or is the obj contained entirely in the tail? */
+	/* Most likely: is the obj contained entirely in the tail? */
 	obj->data = subbuf.tail[0].iov_base;
 	if (subbuf.tail[0].iov_len == obj->len)
 		return 0;
 
-	/* use end of tail as storage for obj:
-	 * (We don't copy to the beginning because then we'd have
-	 * to worry about doing a potentially overlapping copy.
-	 * This assumes the object is at most half the length of the
-	 * tail.) */
+	/* ..or is the obj contained entirely in the head? */
+	obj->data = subbuf.head[0].iov_base;
+	if (subbuf.head[0].iov_len == obj->len)
+		return 0;
+
+	/* obj is in the pages: move to tail */
 	if (obj->len > buf->buflen - buf->len)
 		return -ENOMEM;
-	if (buf->tail[0].iov_len != 0)
-		obj->data = buf->tail[0].iov_base + buf->tail[0].iov_len;
-	else
-		obj->data = buf->head[0].iov_base + buf->head[0].iov_len;
+	obj->data = buf->head[0].iov_base + buf->head[0].iov_len;
 	__read_bytes_from_xdr_buf(&subbuf, obj->data, obj->len);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(xdr_buf_read_netobj);
-- 
2.20.1

