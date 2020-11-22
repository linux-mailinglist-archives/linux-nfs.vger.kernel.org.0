Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358812BC95F
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Nov 2020 21:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgKVUwg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 22 Nov 2020 15:52:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:57582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727418AbgKVUwg (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 22 Nov 2020 15:52:36 -0500
Received: from leira.hammer.space (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6CF220789
        for <linux-nfs@vger.kernel.org>; Sun, 22 Nov 2020 20:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606078356;
        bh=5gtozA03I7R/4JernBdR56cfYEcT9DxzMQL+zZ1AofY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=uVmEXw4xNbc2hYTC4P2cY9um8Oi1nwg9vII1i+sJrdq3tpWhyv9YXKi8GVSQbaEhk
         +qSMC0dbWA0rA/eTy3BfL9J8Xm0D2HjLMQUdbpyW9KB8MCiKOCFEnDa4VGnYi+w/Aq
         eV8L35OzBvXueakmAkB8G8mUJvkWnPhJVa2j+ePs=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 5/8] SUNRPC: Don't truncate tail in xdr_inline_pages()
Date:   Sun, 22 Nov 2020 15:52:26 -0500
Message-Id: <20201122205229.3826-6-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201122205229.3826-5-trondmy@kernel.org>
References: <20201122205229.3826-1-trondmy@kernel.org>
 <20201122205229.3826-2-trondmy@kernel.org>
 <20201122205229.3826-3-trondmy@kernel.org>
 <20201122205229.3826-4-trondmy@kernel.org>
 <20201122205229.3826-5-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

True that if the length of the pages[] array is not 4-byte aligned, then
we will need to store the padding in the tail, but there is no need to
truncate the total buffer length here.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xdr.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 3ce0a5daa9eb..5a450055469f 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -193,9 +193,6 @@ xdr_inline_pages(struct xdr_buf *xdr, unsigned int offset,
 
 	tail->iov_base = buf + offset;
 	tail->iov_len = buflen - offset;
-	if ((xdr->page_len & 3) == 0)
-		tail->iov_len -= sizeof(__be32);
-
 	xdr->buflen += len;
 }
 EXPORT_SYMBOL_GPL(xdr_inline_pages);
-- 
2.28.0

