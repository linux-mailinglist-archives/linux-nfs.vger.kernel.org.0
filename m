Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF7323AB1D
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Aug 2020 19:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgHCQ76 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Aug 2020 12:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgHCQ76 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Aug 2020 12:59:58 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54049C06174A
        for <linux-nfs@vger.kernel.org>; Mon,  3 Aug 2020 09:59:58 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id p13so3238600ilh.4
        for <linux-nfs@vger.kernel.org>; Mon, 03 Aug 2020 09:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sQ5eL1nmuUmkLTUxFw+0Fbr3N0wgB3Xm8iWP31hLmAs=;
        b=aRlzH1hr2wHpPP58ZC5qwWvavEZv8k/Ei3Q6PFmZqRIC7CeaISNUyKy6mdzBfVyCHh
         LZSMt08Z5bTnGyQUWBNVYleQ0DxCX7u3DZjinq4Pa2dbZp7PITVw5RoG/EZRsauk2H1i
         C5zYwPhTPzrI8BhrJJgkCTGaIx9Jz4WsreCn9d2rjzWKZoBvnsci3oBcr4OtUGl57uBd
         TaTHvBB1GvMCwVR9uN9+FYZpk/b78unDtcvIYMg7Jo8kW7kntIqESzJcT2jR0pbOChYB
         MT8bODzpjBeFjupVzsEy7HwyUF5GQsc96jNDK6RGDoJcxxc11+o0opTtppior2FmFiSw
         mMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=sQ5eL1nmuUmkLTUxFw+0Fbr3N0wgB3Xm8iWP31hLmAs=;
        b=i6TBv47VN5v0nbwZqOz1DG9DvXnYyWYZhVaXIEw0GLhfBZlr3cKWGkz8fiUTrJzuaM
         pIu/mrcwHz8EKfYOWzFT9ANcIDqHljxilOTz9lRZFfK0aUPEFAH/7y1dMGLUxmGmJz+8
         kcZde9vbeKvvOX91bwYDpf8pZBteC2cuE4Fd45mREzhdVU/OqEBkfWWR2n0u7LlLRhSS
         ByB5kZQgN5s0Z+Bc/ECA4woklwzPrRze86LIR4Ksy31xEjF4FBFpDTfpQLRFnrQr61ex
         DNNx5wBjMX/CHaDxabiULWwJPzuCX2uibREPvQ9aVFRp5x+wYjn5OKqoVF/XrYhrneYG
         aUHw==
X-Gm-Message-State: AOAM53078QxIkIoEe+8lNslIZaDfsKnEzdtQbBLla29z3cqiCsj41zhr
        gOhbtnalINhnNXQsrTuVftDp1i3C
X-Google-Smtp-Source: ABdhPJzi+GDc7vDlwUcKsJnP5RQmi03LcTfO2+4e/sYaBceSn/w0+qE+zgI6x3t5UdrAqeWFG/EUVQ==
X-Received: by 2002:a92:d781:: with SMTP id d1mr302536iln.68.1596473997682;
        Mon, 03 Aug 2020 09:59:57 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id f20sm10794639ilj.62.2020.08.03.09.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 09:59:57 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     bfields@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v3 1/6] SUNRPC: Implement xdr_reserve_space_vec()
Date:   Mon,  3 Aug 2020 12:59:49 -0400
Message-Id: <20200803165954.1348263-2-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200803165954.1348263-1-Anna.Schumaker@Netapp.com>
References: <20200803165954.1348263-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Reserving space for a large READ payload requires special handling when
reserving space in the xdr buffer pages. One problem we can have is use
of the scratch buffer, which is used to get a pointer to a contiguous
region of data up to PAGE_SIZE. When using the scratch buffer, calls to
xdr_commit_encode() shift the data to it's proper alignment in the xdr
buffer. If we've reserved several pages in a vector, then this could
potentially invalidate earlier pointers and result in incorrect READ
data being sent to the client.

I get around this by looking at the amount of space left in the current
page, and never reserve more than that for each entry in the read
vector. This lets us place data directly where it needs to go in the
buffer pages.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 include/linux/sunrpc/xdr.h |  2 ++
 net/sunrpc/xdr.c           | 45 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 22c207b2425f..bac459584dd0 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -234,6 +234,8 @@ typedef int	(*kxdrdproc_t)(struct rpc_rqst *rqstp, struct xdr_stream *xdr,
 extern void xdr_init_encode(struct xdr_stream *xdr, struct xdr_buf *buf,
 			    __be32 *p, struct rpc_rqst *rqst);
 extern __be32 *xdr_reserve_space(struct xdr_stream *xdr, size_t nbytes);
+extern int xdr_reserve_space_vec(struct xdr_stream *xdr, struct kvec *vec,
+		size_t nbytes);
 extern void xdr_commit_encode(struct xdr_stream *xdr);
 extern void xdr_truncate_encode(struct xdr_stream *xdr, size_t len);
 extern int xdr_restrict_buflen(struct xdr_stream *xdr, int newbuflen);
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index be11d672b5b9..6dfe5dc8b35f 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -648,6 +648,51 @@ __be32 * xdr_reserve_space(struct xdr_stream *xdr, size_t nbytes)
 }
 EXPORT_SYMBOL_GPL(xdr_reserve_space);
 
+
+/**
+ * xdr_reserve_space_vec - Reserves a large amount of buffer space for sending
+ * @xdr: pointer to xdr_stream
+ * @vec: pointer to a kvec array
+ * @nbytes: number of bytes to reserve
+ *
+ * Reserves enough buffer space to encode 'nbytes' of data and stores the
+ * pointers in 'vec'. The size argument passed to xdr_reserve_space() is
+ * determined based on the number of bytes remaining in the current page to
+ * avoid invalidating iov_base pointers when xdr_commit_encode() is called.
+ */
+int xdr_reserve_space_vec(struct xdr_stream *xdr, struct kvec *vec, size_t nbytes)
+{
+	int thislen;
+	int v = 0;
+	__be32 *p;
+
+	/*
+	 * svcrdma requires every READ payload to start somewhere
+	 * in xdr->pages.
+	 */
+	if (xdr->iov == xdr->buf->head) {
+		xdr->iov = NULL;
+		xdr->end = xdr->p;
+	}
+
+	while (nbytes) {
+		thislen = xdr->buf->page_len % PAGE_SIZE;
+		thislen = min_t(size_t, nbytes, PAGE_SIZE - thislen);
+
+		p = xdr_reserve_space(xdr, thislen);
+		if (!p)
+			return -EIO;
+
+		vec[v].iov_base = p;
+		vec[v].iov_len = thislen;
+		v++;
+		nbytes -= thislen;
+	}
+
+	return v;
+}
+EXPORT_SYMBOL_GPL(xdr_reserve_space_vec);
+
 /**
  * xdr_truncate_encode - truncate an encode buffer
  * @xdr: pointer to xdr_stream
-- 
2.27.0

