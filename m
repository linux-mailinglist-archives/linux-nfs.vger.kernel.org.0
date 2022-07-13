Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A358A573CF1
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Jul 2022 21:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236659AbiGMTIj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Jul 2022 15:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236627AbiGMTIf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Jul 2022 15:08:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C751334
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 12:08:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C997B82131
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 19:08:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD11BC341C0;
        Wed, 13 Jul 2022 19:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657739310;
        bh=06tbDAIV50KkX1Rev4Q+dwEAZwyYL5nx50/XVjO3+DI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jV1WIvTnRf6N8dmGBqVdvItUps/vQB5sNtT44Z9FxIOu4TfTPKS93oQt4/7dleHnP
         E58emDZYt0MB2FmzbqAvra7IkqiI3EZqQ5vHsbTUDc8+WgYQDMiorzi+EIRhcmajfM
         f18Q6CjnWwZg/MRDKR5akQsqeqsHsr0ctUgBl8DXEoE7FlLwbCC5hn4gH9HSGa8X/P
         nUOrFohS4JLOGVGJwx1FmzG6ETuruTHb2j2FUCA3+Vr/hM6ShFD6Akx0VecOhWhGCQ
         ZtzvGu52G2nDoaCzwrxmzoSIp8GGyO+anAbTPeNEuqoxgIYAzMqaaOibN27/IycJ8N
         pYQZrdYjwT76g==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, chuck.lever@oracle.com
Cc:     anna@kernel.org
Subject: [PATCH v2 4/6] SUNRPC: Introduce xdr_buf_nth_page_address()
Date:   Wed, 13 Jul 2022 15:08:23 -0400
Message-Id: <20220713190825.615678-5-anna@kernel.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220713190825.615678-1-anna@kernel.org>
References: <20220713190825.615678-1-anna@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index bdaf048edde0..79824fea4529 100644
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
index 37956a274f81..88b28656a05d 100644
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
2.37.0

