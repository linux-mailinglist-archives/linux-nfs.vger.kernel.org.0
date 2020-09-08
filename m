Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54911261492
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Sep 2020 18:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731908AbgIHQ1L (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Sep 2020 12:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731046AbgIHQ0T (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Sep 2020 12:26:19 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A088C061756
        for <linux-nfs@vger.kernel.org>; Tue,  8 Sep 2020 09:26:03 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id r9so17776924ioa.2
        for <linux-nfs@vger.kernel.org>; Tue, 08 Sep 2020 09:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FRSuIdkk6ALMTWDJIFlzdvg+Fc3EiYObmZAafS+1zAY=;
        b=HLmckf9BB/soOGh8cc+6du8DkgJ8974kIPJ0vmem3+oAtVoiBsxZJNRUmLbO/6QVtk
         m5EMfR4OwBBgWdC8OZD5mJCXetgxVXpblwEBuF8COyZQp/mn0fz+mA8SBdUOxn45S1VG
         9Zo84ZphtdZ9XuSiR4GJV9SW/9lX/uaPweS6KShGf0pY/kzaIRJlVc1r6S5/k9sBNYM+
         r1LPE0CNcIRpvhX/VzHx27t0qxRrzIjNM7yOJIyo0t+vassBUcZoX3wHT69LbEXNeJ77
         fq0QkZSdQa4IAkjBg3TCrG5pyd/pqki4mceBcXYn9ds4z0K8OGBJIVeX6tXgKiSdZE/t
         ighw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=FRSuIdkk6ALMTWDJIFlzdvg+Fc3EiYObmZAafS+1zAY=;
        b=mtcPNhymJKTW8Myo7Vjbc0LoAvNXl22F8uxicJGF32JxvoDhYIopM39eqNaIUcxTYQ
         NuqV+9ZyZKZD7JI2zIFYV3W1Gs4SaLEN0uver+v6t7AkIvqln2jY6SewSNWXGGUwqjn8
         w/GMsWrRr+fvrxczp2+ROpxyk2xUL2FYb/MujWhCptCkpoZ4IcRNjDhBHXKiuuD+c75c
         b5c2dfkCiz78pfs9S3TF4cmbZIsWTahM6DeNVTHRcjRusm2/wgGyVkVHZ5IKTqSfPIHU
         1j8w+7l1jhZSB/Jl2Ninh/g6pFNqhwfGOJFRrFBpIkFT2ZZ5HpyRogey+jPqu09a+TGL
         poZA==
X-Gm-Message-State: AOAM530ZeXouegiX6Ydhmy/s9LaJI/kHcLwSNvtim9lTQKwMT0JBNfbO
        4Gh94yU/OZszAHO4pScoYWJRnRzoMNk=
X-Google-Smtp-Source: ABdhPJyMKphX1omDaM0mQrqWTuZluMQqNg3JgsM8YuhPO4pMWTkdbLidzWA0Pj2ULyc4zqmIbV7vcA==
X-Received: by 2002:a6b:d214:: with SMTP id q20mr11207687iob.23.1599582362001;
        Tue, 08 Sep 2020 09:26:02 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id v7sm10269657ilg.83.2020.09.08.09.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 09:26:01 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     bfields@redhat.com, chuck.lever@oracle.com,
        linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v5 1/5] SUNRPC/NFSD: Implement xdr_reserve_space_vec()
Date:   Tue,  8 Sep 2020 12:25:55 -0400
Message-Id: <20200908162559.509113-2-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908162559.509113-1-Anna.Schumaker@Netapp.com>
References: <20200908162559.509113-1-Anna.Schumaker@Netapp.com>
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
 fs/nfsd/nfs4xdr.c          | 28 +++---------------------
 include/linux/sunrpc/xdr.h |  2 ++
 net/sunrpc/xdr.c           | 45 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 25 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 259d5ad0e3f4..0be194de4888 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3814,36 +3814,14 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 {
 	struct xdr_stream *xdr = &resp->xdr;
 	u32 eof;
-	int v;
 	int starting_len = xdr->buf->len - 8;
-	long len;
-	int thislen;
 	__be32 nfserr;
 	__be32 tmp;
-	__be32 *p;
 	int pad;
 
-	/*
-	 * svcrdma requires every READ payload to start somewhere
-	 * in xdr->pages.
-	 */
-	if (xdr->iov == xdr->buf->head) {
-		xdr->iov = NULL;
-		xdr->end = xdr->p;
-	}
-
-	len = maxcount;
-	v = 0;
-	while (len) {
-		thislen = min_t(long, len, PAGE_SIZE);
-		p = xdr_reserve_space(xdr, thislen);
-		WARN_ON_ONCE(!p);
-		resp->rqstp->rq_vec[v].iov_base = p;
-		resp->rqstp->rq_vec[v].iov_len = thislen;
-		v++;
-		len -= thislen;
-	}
-	read->rd_vlen = v;
+	read->rd_vlen = xdr_reserve_space_vec(xdr, resp->rqstp->rq_vec, maxcount);
+	if (read->rd_vlen < 0)
+		return nfserr_resource;
 
 	nfserr = nfsd_readv(resp->rqstp, read->rd_fhp, file, read->rd_offset,
 			    resp->rqstp->rq_vec, read->rd_vlen, &maxcount,
diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 5a6a81b7cd9f..6613d96a3029 100644
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
2.28.0

