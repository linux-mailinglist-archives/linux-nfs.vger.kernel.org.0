Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AFA52921A
	for <lists+linux-nfs@lfdr.de>; Mon, 16 May 2022 23:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346609AbiEPVBj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 May 2022 17:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348960AbiEPVBA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 May 2022 17:01:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FBD2BD2
        for <linux-nfs@vger.kernel.org>; Mon, 16 May 2022 13:35:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28606B8165E
        for <linux-nfs@vger.kernel.org>; Mon, 16 May 2022 20:35:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EAD7C385AA;
        Mon, 16 May 2022 20:35:52 +0000 (UTC)
From:   Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v1 4/6] SUNRPC: Introduce xdr_buf_nth_page_address()
Date:   Mon, 16 May 2022 16:35:47 -0400
Message-Id: <20220516203549.2605575-5-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220516203549.2605575-1-Anna.Schumaker@Netapp.com>
References: <20220516203549.2605575-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

For getting a pointer to the memory address represented by the nth page,
along with the length of the data on that page.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 include/linux/sunrpc/xdr.h |  2 ++
 net/sunrpc/xdr.c           | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 344c820484ba..b375b284afbe 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -137,6 +137,8 @@ void	xdr_inline_pages(struct xdr_buf *, unsigned int,
 			 struct page **, unsigned int, unsigned int);
 void	xdr_terminate_string(const struct xdr_buf *, const u32);
 size_t	xdr_buf_pagecount(const struct xdr_buf *buf);
+char	*xdr_buf_nth_page_address(const struct xdr_buf *buf, unsigned int n,
+				  unsigned int *len);
 int	xdr_alloc_bvec(struct xdr_buf *buf, gfp_t gfp);
 void	xdr_free_bvec(struct xdr_buf *buf);
 
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 3ecc444b27be..0b378c80f5f5 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -140,6 +140,23 @@ size_t xdr_buf_pagecount(const struct xdr_buf *buf)
 	return (buf->page_base + buf->page_len + PAGE_SIZE - 1) >> PAGE_SHIFT;
 }
 
+char *xdr_buf_nth_page_address(const struct xdr_buf *buf, unsigned int n,
+			       unsigned int *len)
+{
+	unsigned int pgbase = buf->page_base + (n * PAGE_SIZE);
+	struct page **pages = buf->pages;
+	struct page **page;
+
+	if (n >= xdr_buf_pagecount(buf))
+		return NULL;
+
+	page = pages + (pgbase >> PAGE_SHIFT);
+	pgbase &= ~PAGE_MASK;
+	*len = min_t(size_t, PAGE_SIZE, buf->page_len - (n * PAGE_SIZE));
+	return page_address(*page) + pgbase;
+}
+EXPORT_SYMBOL_GPL(xdr_buf_nth_page_address);
+
 int
 xdr_alloc_bvec(struct xdr_buf *buf, gfp_t gfp)
 {
-- 
2.36.1

