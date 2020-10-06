Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98270284FD4
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Oct 2020 18:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgJFQ3c (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Oct 2020 12:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgJFQ3c (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Oct 2020 12:29:32 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201BCC061755
        for <linux-nfs@vger.kernel.org>; Tue,  6 Oct 2020 09:29:32 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id j22so13523002qtj.8
        for <linux-nfs@vger.kernel.org>; Tue, 06 Oct 2020 09:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FifsME1ATOsJkuZC/VYkpO0dbUrlMefaE25nRi/x3mQ=;
        b=vM+fLU3Sr1Sgw4Dn1Dvm96iLLraKZ18/x119x6tQ/Sn94gVezYdIoBYmHZVF+zSvhn
         K7t9l6haXNv96sqRheP9h+vVhzVTd3kzufRvrLCkqbYUWuQsrfeygKXFS4qVsr0owJlP
         JDBBfBhQb9uzJzmiJIgH5AGDmk/Jzc0SK9d9GN/bxxaab3MN2cxDp107GlyUCktllSEJ
         oZza5/0r2fjimnroBaMT0+ma+ckclGlcTGRsGvhxrTV6qld8RlyRqdzIoGTDZVp8k4EO
         SV5z9eIiWEue0jtGa6OSZ2mU/AMNDTOqg/VhLvp8GFJRdld2jIXaVgquod/5Rn49ShXR
         tb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=FifsME1ATOsJkuZC/VYkpO0dbUrlMefaE25nRi/x3mQ=;
        b=qMkSh7xsl2HED2neh6uOKuRIjqAcLJCTtdOlyGWwrAkKjTTXmqUtVCCWcyZG/IvjyU
         /VWBLHZUO5U0wqwa5+YmcW2qg6l9amx8NQS2HioOKKqAWdZ63CylM8w/Y7xP2/JKZQ/x
         fyN7YkIF2+xDhUS9vg36yF2Wz1s7SuDmzqmqd5dwKf1OEywizogsSFXKrckMvv8zJI32
         ACQWMS9yuYvKJOCeje+lcdc3wezVuYJofkGZiwKcZR5mBf2V42ndcfaXUOBwJXYvvPjj
         Zkoz+r14QeOBm55NqbHJjmVAvlagGAnrASZr1T1ucfj6gVJ2Srpyby94swASda1UC9Sz
         DkeQ==
X-Gm-Message-State: AOAM531MLJb2M72ZAgLc87wd2CfakJOHTF4moxgzti03mpQm4eqRJ7X6
        8PppFIx/f/aVbNTBjzFWJuuxF5cP+ZIduw==
X-Google-Smtp-Source: ABdhPJyzqCzgRrJQ6g07w80hpAoM6qTdidSfMqOKVlvj16bfgE6z3q2WhL0suexlEg7cXJdTVHG3dg==
X-Received: by 2002:ac8:7250:: with SMTP id l16mr5971874qtp.36.1602001769536;
        Tue, 06 Oct 2020 09:29:29 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id q5sm2629984qtn.60.2020.10.06.09.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 09:29:28 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v7 02/10] SUNRPC: Implement a xdr_page_pos() function
Date:   Tue,  6 Oct 2020 12:29:17 -0400
Message-Id: <20201006162925.1331781-3-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201006162925.1331781-1-Anna.Schumaker@Netapp.com>
References: <20201006162925.1331781-1-Anna.Schumaker@Netapp.com>
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

