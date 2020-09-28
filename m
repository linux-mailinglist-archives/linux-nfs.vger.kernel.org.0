Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561E427B2C1
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Sep 2020 19:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgI1RJZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Sep 2020 13:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgI1RJZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Sep 2020 13:09:25 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11D0C061755
        for <linux-nfs@vger.kernel.org>; Mon, 28 Sep 2020 10:09:24 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id g72so1636043qke.8
        for <linux-nfs@vger.kernel.org>; Mon, 28 Sep 2020 10:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FifsME1ATOsJkuZC/VYkpO0dbUrlMefaE25nRi/x3mQ=;
        b=UrjthepIrFE/vJrAEYo70s+OZ+fOweZKmmD4Q98sOWup1kZPiOB/MciwlcE90RHss+
         Pmegra+kjqGqrVUKRC7x0KpeoVL6MOpwyNvD+TgMuL/pcgbrKpeANEqiibvxf0NLX8pC
         AcujWN/StjGrj7+1oNrEFMoQDwi+UlAJ/jG+VUGVsxGNZHVMtDViA72vyHTcpYC+DOwD
         HayRnkvKgsG7VtBD2RXmYavP4WnJbqDtmvWdgcP474zIDaG9WTfBJkj1S2wtVZFig6aY
         xgkSXU1qADk8cYc+jGipfPs7Y0ZKDShIsNHm63CNNAlhM6mC27VlcKfd7jN2UXN4Zz2J
         eYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=FifsME1ATOsJkuZC/VYkpO0dbUrlMefaE25nRi/x3mQ=;
        b=RvJG+4NkTCNobGikgLjtzM0fwMkPfCI7OXZS3O57Iybjh7Qid5hA3SLO8AOMQo1Wga
         imjt5GQ4iiG7o8qQXBBVr6kMwfpcUHBQeA5l8GWCPsse+Sv/22Vo2/KQ/VHBE2ngd0BZ
         KOBwJ1jD5VymM3oBoYlGpjjeojcMgqL8+C6h6Tb8B4SP0nhmDf6dy2+qKgdKHf1ZG3t8
         cPlL60XMT63juKm8fMgLlVMkZvemawf1hajVy2N42N97TNFpobpgnvFbnXzzb7TKERrG
         sWXZMYH/Y5ziMLLajmLm3CjO4xv+6niMfkaSpNf14nDbZLrce6mRCGYy+z3qfLlpkV1N
         Kqxg==
X-Gm-Message-State: AOAM533FSUAZg1Y7+7XFl6nTSoICH56UJ6xfGHJDY/CEyZnZRWLSofPw
        jliaChgnY3HGCY4RekxqmeYD/E3IbQU=
X-Google-Smtp-Source: ABdhPJyFzmNP6yl77mIVMjHBIP0kFxWR17GfT+BG5BdrkcpRM7Oh0vF4rKwWEiaZV6d8JfotsQavFw==
X-Received: by 2002:ae9:e8c5:: with SMTP id a188mr456663qkg.204.1601312963191;
        Mon, 28 Sep 2020 10:09:23 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id 201sm1556862qkf.103.2020.09.28.10.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 10:09:22 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v6 02/10] SUNRPC: Implement a xdr_page_pos() function
Date:   Mon, 28 Sep 2020 13:09:11 -0400
Message-Id: <20200928170919.707641-3-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928170919.707641-1-Anna.Schumaker@Netapp.com>
References: <20200928170919.707641-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

I'll need this for READ_PLUS to help figure out the offset where page
data is stored at, but it might also be useful for other things.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 include/linux/sunrpc/xdr.h |  1 +
 net/sunrpc/xdr.c           | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 6613d96a3029..026edbd041d5 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -242,6 +242,7 @@ extern int xdr_restrict_buflen(struct xdr_stream *xdr, int newbuflen);
 extern void xdr_write_pages(struct xdr_stream *xdr, struct page **pages,
 		unsigned int base, unsigned int len);
 extern unsigned int xdr_stream_pos(const struct xdr_stream *xdr);
+extern unsigned int xdr_page_pos(const struct xdr_stream *xdr);
 extern void xdr_init_decode(struct xdr_stream *xdr, struct xdr_buf *buf,
 			    __be32 *p, struct rpc_rqst *rqst);
 extern void xdr_init_decode_pages(struct xdr_stream *xdr, struct xdr_buf *buf,
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index c62b0882c0d8..8d29450fdce5 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -505,6 +505,19 @@ unsigned int xdr_stream_pos(const struct xdr_stream *xdr)
 }
 EXPORT_SYMBOL_GPL(xdr_stream_pos);
 
+/**
+ * xdr_page_pos - Return the current offset from the start of the xdr pages
+ * @xdr: pointer to struct xdr_stream
+ */
+unsigned int xdr_page_pos(const struct xdr_stream *xdr)
+{
+	unsigned int pos = xdr_stream_pos(xdr);
+
+	WARN_ON(pos < xdr->buf->head[0].iov_len);
+	return pos - xdr->buf->head[0].iov_len;
+}
+EXPORT_SYMBOL_GPL(xdr_page_pos);
+
 /**
  * xdr_init_encode - Initialize a struct xdr_stream for sending data.
  * @xdr: pointer to xdr_stream struct
-- 
2.28.0

