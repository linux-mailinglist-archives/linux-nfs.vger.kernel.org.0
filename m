Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E84B246E8D
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Aug 2020 19:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389022AbgHQRdZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Aug 2020 13:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389120AbgHQQxr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Aug 2020 12:53:47 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA89C06134D
        for <linux-nfs@vger.kernel.org>; Mon, 17 Aug 2020 09:53:31 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id t15so18363907iob.3
        for <linux-nfs@vger.kernel.org>; Mon, 17 Aug 2020 09:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rl61QeYwzZvkWuvjGsNCF767mJbnp0XaPTQFoI5ixVE=;
        b=OoZABf416jDKy3MmHgrCrU/87PnzHqvajj5g9mBLounwTOfjIG4SIuxhMGAU7/2upo
         YW3dHNL2pVe7DdyW5+kcsMVTGNM7REJHXiyIPXJswhQS5bzemSm6du+aDPs+6NDbikFi
         qpIUyGaXgsiZ4M8h3AD+iIyufSsZuv0bcNRaOFYfusxwvGMNc80mGH0+dHSJS7WV+GtV
         lqLtPnEA6AqDynYf1Rc0roXGBv7scu5KGDscb5/WTN4cbSy2koyRVrXCtiqa6h2vRzEd
         vnM2q+PFH0zw+tjogNNEBsKE2is97vU9rbz49Ejd4/sX7Xi9a4tFqXsyuZtEyzQ9hUwD
         guNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=rl61QeYwzZvkWuvjGsNCF767mJbnp0XaPTQFoI5ixVE=;
        b=esMxn7dhnKGt1ZwrNCs3purrmyXtuuZZru153OsdKEekXzoBTAVB5hDMewYGqTaTXK
         0OkFhn8J9eKEfRvKiI6+Hw/HjfvBizU5zlIz/g1QJC70+pTixpdcg3fusYvXXl2ASpxZ
         3TtOJ7vcON7AKanZX0wqomOoMKwkis0bMxBDvbC+e5hRYdlzs9XvxAbtJr9wFBGZV8yF
         HubvQfWR3+LP6soFRfMIyZnDyCl6UyRfcu11AL21g1vzCMpsO5yKtCijoLI7aqtfahdZ
         ji3kfJtXfjux728lAg9Saz/DZw/+/o41qxTaX+DNt27nFsS82CJi+1i9xaHBSxl9g8El
         2BNw==
X-Gm-Message-State: AOAM533fNxVrqFn1u5iLQJ8OOpRB60W989Z9rmakW2mwcTJ8Yx0CoLq7
        r5GKLNNFkAAy1nD99Z3GRPnSOUHOecs=
X-Google-Smtp-Source: ABdhPJyVS67fqs3C7mxsbggP/7iU8j/Apgrof79/ePvtfJ2GT9WHAVrYtcnXvTUv/pgg3LeJSYt6Ig==
X-Received: by 2002:a05:6638:d12:: with SMTP id q18mr15604100jaj.5.1597683210862;
        Mon, 17 Aug 2020 09:53:30 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id a16sm7413106ilc.7.2020.08.17.09.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 09:53:30 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v4 02/10] SUNRPC: Implement a xdr_page_pos() function
Date:   Mon, 17 Aug 2020 12:53:19 -0400
Message-Id: <20200817165327.354181-3-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817165327.354181-1-Anna.Schumaker@Netapp.com>
References: <20200817165327.354181-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
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
index bac459584dd0..40318ff97c83 100644
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

