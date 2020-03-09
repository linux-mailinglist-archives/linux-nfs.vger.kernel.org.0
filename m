Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA9D17E234
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Mar 2020 15:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgCIOG2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Mar 2020 10:06:28 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43770 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbgCIOG2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Mar 2020 10:06:28 -0400
Received: by mail-yw1-f67.google.com with SMTP id p69so10181480ywh.10
        for <linux-nfs@vger.kernel.org>; Mon, 09 Mar 2020 07:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=jw35QgMW7MwJGusg//NZzr2ZGt36eAHRBQXR/pHxX2g=;
        b=Y40aHkk26qIheThSEM5OL23SAqPs+LWTGXPbusFXjmzvJGGobR29RpMxxvWkdANudI
         UvoteO9QK/m1H2dy6t/gjfeVPG8IEd/Iho8g4KVgvMriImH8spdL9Ju0n4FZ4Tl+zRdo
         9r82+rzFNkbza2qrdzistAyuR7aEgTrpZp4SLtNhwSrcPQXRLZNMGLmgFjeTmOmd/dN0
         vy38tFbhirOJWkmA1vXcFZ1kEM7dmvd5ryMGHjrSsZ+Q5slSxBTF0sMnngfojcsTdsHC
         fZPrY4Qk3qgZWZ1wLwH0sPaXIkL7gmgTKZyObxpqjnMf2IwD6/tDKa+3CCzRGEQiGv1+
         LHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=jw35QgMW7MwJGusg//NZzr2ZGt36eAHRBQXR/pHxX2g=;
        b=tqgg+uNKATeL115ocR7HVKj0hfZnyqKzDRwNmkQy34ed02FcQlCGanHvhxLPM7BvCB
         qO7AAVltoFfD1nFuOHYh04dapYzQn/L6LKFCtTpMTiduZ8Veh/pVwRzq/iuY3wq1io6b
         1U7qjEEZlUJ4kwvXOtiMAfHRo1tJ/tF4tv9RXEr4LJDD9lLcD8z/IV8+fUM1t0NQF/rY
         NHF/pkMe1i7xnty1CcJzPnss6HXpLzL+mXfXQFeYK8eKp/Str6eRqi3Jt/cdeXbNHBud
         0QJIVJ0RVFq7TmYggr8InU2A7LEc/Tli/h8iA79H9re0cI4lwS+YMbHn/jpvw4WV/3pD
         JXFA==
X-Gm-Message-State: ANhLgQ15ea9rZrhgZUxuIBr1YVUfwLFgBZoiMykz0ll4wzZoPEIL0Kgx
        UI30sCIKPGn5Vf4M/lTAnrEeQe4t7gY=
X-Google-Smtp-Source: ADFU+vsVQB0stqOx2GednN6gfUWnbsgA34jlOjVoxyj5vW9WC7Fo8DmKTog3uGmROfO/T4BGD6KscA==
X-Received: by 2002:a25:6a56:: with SMTP id f83mr18340636ybc.17.1583762785563;
        Mon, 09 Mar 2020 07:06:25 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c133sm6357938ywa.97.2020.03.09.07.06.24
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2020 07:06:25 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 029E6OQp007536
        for <linux-nfs@vger.kernel.org>; Mon, 9 Mar 2020 14:06:24 GMT
Subject: [PATCH v2 2/3] SUNRPC: Remove xdr_buf_read_mic()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 09 Mar 2020 10:06:24 -0400
Message-ID: <20200309140624.2637.64070.stgit@manet.1015granger.net>
In-Reply-To: <20200309140301.2637.9696.stgit@manet.1015granger.net>
References: <20200309140301.2637.9696.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: this function is no longer used.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
---
 include/linux/sunrpc/xdr.h |    1 -
 net/sunrpc/xdr.c           |   55 --------------------------------------------
 2 files changed, 56 deletions(-)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index a1264b19b34c..f0f0abef1a6e 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -184,7 +184,6 @@ static inline void xdr_netobj_dup(struct xdr_netobj *dst,
 extern void xdr_shift_buf(struct xdr_buf *, size_t);
 extern void xdr_buf_from_iov(struct kvec *, struct xdr_buf *);
 extern int xdr_buf_subsegment(struct xdr_buf *, struct xdr_buf *, unsigned int, unsigned int);
-extern int xdr_buf_read_mic(struct xdr_buf *, struct xdr_netobj *, unsigned int);
 extern int read_bytes_from_xdr_buf(struct xdr_buf *, unsigned int, void *, unsigned int);
 extern int write_bytes_to_xdr_buf(struct xdr_buf *, unsigned int, void *, unsigned int);
 
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index e5497dc2475b..15b58c5144f9 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1235,61 +1235,6 @@ int write_bytes_to_xdr_buf(struct xdr_buf *buf, unsigned int base, void *obj, un
 }
 EXPORT_SYMBOL_GPL(xdr_encode_word);
 
-/**
- * xdr_buf_read_mic() - obtain the address of the GSS mic from xdr buf
- * @buf: pointer to buffer containing a mic
- * @mic: on success, returns the address of the mic
- * @offset: the offset in buf where mic may be found
- *
- * This function may modify the xdr buf if the mic is found to be straddling
- * a boundary between head, pages, and tail.  On success the mic can be read
- * from the address returned.  There is no need to free the mic.
- *
- * Return: Success returns 0, otherwise an integer error.
- */
-int xdr_buf_read_mic(struct xdr_buf *buf, struct xdr_netobj *mic, unsigned int offset)
-{
-	struct xdr_buf subbuf;
-	unsigned int boundary;
-
-	if (xdr_decode_word(buf, offset, &mic->len))
-		return -EFAULT;
-	offset += 4;
-
-	/* Is the mic partially in the head? */
-	boundary = buf->head[0].iov_len;
-	if (offset < boundary && (offset + mic->len) > boundary)
-		xdr_shift_buf(buf, boundary - offset);
-
-	/* Is the mic partially in the pages? */
-	boundary += buf->page_len;
-	if (offset < boundary && (offset + mic->len) > boundary)
-		xdr_shrink_pagelen(buf, boundary - offset);
-
-	if (xdr_buf_subsegment(buf, &subbuf, offset, mic->len))
-		return -EFAULT;
-
-	/* Is the mic contained entirely in the head? */
-	mic->data = subbuf.head[0].iov_base;
-	if (subbuf.head[0].iov_len == mic->len)
-		return 0;
-	/* ..or is the mic contained entirely in the tail? */
-	mic->data = subbuf.tail[0].iov_base;
-	if (subbuf.tail[0].iov_len == mic->len)
-		return 0;
-
-	/* Find a contiguous area in @buf to hold all of @mic */
-	if (mic->len > buf->buflen - buf->len)
-		return -ENOMEM;
-	if (buf->tail[0].iov_len != 0)
-		mic->data = buf->tail[0].iov_base + buf->tail[0].iov_len;
-	else
-		mic->data = buf->head[0].iov_base + buf->head[0].iov_len;
-	__read_bytes_from_xdr_buf(&subbuf, mic->data, mic->len);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(xdr_buf_read_mic);
-
 /* Returns 0 on success, or else a negative error code. */
 static int
 xdr_xcode_array2(struct xdr_buf *buf, unsigned int base,

