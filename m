Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9563529241
	for <lists+linux-nfs@lfdr.de>; Mon, 16 May 2022 23:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348790AbiEPVBn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 May 2022 17:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348949AbiEPVBA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 May 2022 17:01:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071D42738
        for <linux-nfs@vger.kernel.org>; Mon, 16 May 2022 13:35:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0227C61499
        for <linux-nfs@vger.kernel.org>; Mon, 16 May 2022 20:35:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D45C34116;
        Mon, 16 May 2022 20:35:53 +0000 (UTC)
From:   Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v1 5/6] SUNRPC: Export xdr_buf_pagecount()
Date:   Mon, 16 May 2022 16:35:48 -0400
Message-Id: <20220516203549.2605575-6-Anna.Schumaker@Netapp.com>
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

The NFS server will need this for iterating over pages in a READ_PLUS
reply

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 net/sunrpc/xdr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 0b378c80f5f5..d71c90552fa2 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -139,6 +139,7 @@ size_t xdr_buf_pagecount(const struct xdr_buf *buf)
 		return 0;
 	return (buf->page_base + buf->page_len + PAGE_SIZE - 1) >> PAGE_SHIFT;
 }
+EXPORT_SYMBOL_GPL(xdr_buf_pagecount);
 
 char *xdr_buf_nth_page_address(const struct xdr_buf *buf, unsigned int n,
 			       unsigned int *len)
-- 
2.36.1

