Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90E8E14F347
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Jan 2020 21:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgAaUl4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 31 Jan 2020 15:41:56 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:42778 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgAaUlz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 31 Jan 2020 15:41:55 -0500
Received: by mail-yw1-f68.google.com with SMTP id b81so6058899ywe.9;
        Fri, 31 Jan 2020 12:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ChAqFwypT96xxLsIvs9dj825z+OPVY1aE7NWj1QcivA=;
        b=qJj6t2q6QQgwYYiZiXWUekXWJC4BL6J/YtCXCMcpUjFjKnhLcxQqA5mUd6TNLQSASM
         bwxhQc1Rk2cJh7DiV+JKh+L2u81D1+X1pYkEER+pctZ855GjqzqBL1247I7FGZni4Pq7
         Kdmo+r2kHLd6zsT+mDjEpsSWNW64E9a6ovK2nHgZ7qqobaTJ3OmsKtctYKhmrzpjYFJE
         Ajd3deSbRjEZdHF2ZH2Go9J8jNgJhIoyOmmySKO2X+b9TVifoaycvpxyuqnEYUabyNdo
         MfrsyRx9zEZ41/9AhaltaVhs9RhZk0bwhZYDIG2lPUiLGvnd8YlrpCDgYLRe9R86eHYg
         WKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=ChAqFwypT96xxLsIvs9dj825z+OPVY1aE7NWj1QcivA=;
        b=r3Ucibw0vw2pIBL0zrqB9B2qtM8AS5a243oA4kX5j6UlSSzrwEu4SHn0tw6ogxwkgn
         n3QvwGN+BjxR56SFf7qXGsI1vM3p0FNdaAgH+dnb7W7gNFrCCIsZlPHDsb7QzfzE6RZs
         6YjIgaxYA4o/c6s0e45oikwrRbZ/JLMssaSWzTXNRVzDs8IBSbb2VGW1S3/tM88ojeXD
         anoKrkMMCYjgovOrHiK026E0JvJhxcX/Tqff+NGqXucJI7tY9f2hhdFjdj1nT8U8G36u
         +gKyW7uguakiuiymPjfS1+T8fp0MVCIuDld9llxsgT+tL/T0I/zOw3JQxbOuQCdUHFZZ
         3eFg==
X-Gm-Message-State: APjAAAXOmKxG15HNLAkYV5t2OiAyDARnXmgef0/HqgoEMJhwXTaa3qNw
        +Ymwyw6Ys6qBuBVrTddXHRo=
X-Google-Smtp-Source: APXvYqyhBcOPOQNFlpviJ94Wc6jgbFh2VgWHQFZhYLUV2tv7Tpzd1PM4TfycR34OvYYZIUOpWogLlw==
X-Received: by 2002:a25:2311:: with SMTP id j17mr10098621ybj.31.1580503313651;
        Fri, 31 Jan 2020 12:41:53 -0800 (PST)
Received: from bazille.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p1sm4795779ywh.74.2020.01.31.12.41.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jan 2020 12:41:53 -0800 (PST)
Subject: [PATCH RFC2 2/3] SUNRPC: Track current encode position in struct
 xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Fri, 31 Jan 2020 15:41:52 -0500
Message-ID: <20200131204152.31409.48018.stgit@bazille.1015granger.net>
In-Reply-To: <20200131203727.31409.63652.stgit@bazille.1015granger.net>
References: <20200131203727.31409.63652.stgit@bazille.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Maintain a byte-offset cursor in struct xdr_stream. This will be
used in a subsequent patch.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c         |    1 +
 include/linux/sunrpc/xdr.h |    1 +
 net/sunrpc/xdr.c           |    2 ++
 3 files changed, 4 insertions(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 4798667af647..9cd610485f7d 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1904,6 +1904,7 @@ static void svcxdr_init_encode(struct svc_rqst *rqstp,
 	xdr->iov = head;
 	xdr->p   = head->iov_base + head->iov_len;
 	xdr->end = head->iov_base + PAGE_SIZE - rqstp->rq_auth_slack;
+	xdr->pos = head->iov_len;
 	/* Tail and page_len should be zero at this point: */
 	buf->len = buf->head[0].iov_len;
 	xdr->scratch.iov_len = 0;
diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index b41f34977995..2ca479b0708e 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -232,6 +232,7 @@ struct xdr_stream {
 	struct kvec *iov;	/* pointer to the current kvec */
 	struct kvec scratch;	/* Scratch buffer */
 	struct page **page_ptr;	/* pointer to the current page */
+	unsigned int pos;	/* current encode position */
 	unsigned int nwords;	/* Remaining decode buffer length */
 
 	struct rpc_rqst *rqst;	/* For debugging */
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index f3104be8ff5d..b8b78876a9bd 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -542,6 +542,7 @@ void xdr_init_encode(struct xdr_stream *xdr, struct xdr_buf *buf, __be32 *p,
 		buf->len += len;
 		iov->iov_len += len;
 	}
+	xdr->pos = iov->iov_len;
 	xdr->rqst = rqst;
 }
 EXPORT_SYMBOL_GPL(xdr_init_encode);
@@ -644,6 +645,7 @@ __be32 * xdr_reserve_space(struct xdr_stream *xdr, size_t nbytes)
 	else
 		xdr->buf->page_len += nbytes;
 	xdr->buf->len += nbytes;
+	xdr->pos += nbytes;
 	return p;
 }
 EXPORT_SYMBOL_GPL(xdr_reserve_space);

