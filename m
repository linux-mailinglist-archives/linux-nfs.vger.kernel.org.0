Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33A1B10AA0
	for <lists+linux-nfs@lfdr.de>; Wed,  1 May 2019 18:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfEAQHS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 May 2019 12:07:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35074 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfEAQHS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 May 2019 12:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lmTrIGpEbI3KMOEYpjM6/I8DyJIPcU5OW04RpHaMmk4=; b=MjceeoxumN84/e65UHYopkW3J5
        jbvdYbAu8j9CHPZfKzzFkJledp6gzX7UHAiSE2A1+0tOKgHOswlNOFYbe0kDzPsqLWFAsqHV8cNrr
        DZYb9sdK9qv9jOtfbU0kNMyP2h1odMGgHBqJs6/Hn8xUovLq3lAaypCDyTIVcTzBwLLrwY2M1B1P0
        tLI0BH7VQbm6FqOam7aePFfeJ2wuzPemXEZlU6HD8vV9Mf8+/QGyqeMYEg5zQ4trcRqAtzgZx+A4B
        WyjQ6Mecd3IE0LLrFjtwzmEbpo1lQ5ikOYpupyuNZZ+JvnMO4l/qWjwTEpKCJvFnqiiIzt6qKxoj4
        u3NrNhag==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLrlL-0008Kv-Eh; Wed, 01 May 2019 16:07:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] mm: fix an overly long line in read_cache_page
Date:   Wed,  1 May 2019 12:06:33 -0400
Message-Id: <20190501160636.30841-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190501160636.30841-1-hch@lst.de>
References: <20190501160636.30841-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/filemap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index d78f577baef2..a2fc59f56f50 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2956,7 +2956,8 @@ struct page *read_cache_page(struct address_space *mapping,
 				int (*filler)(void *, struct page *),
 				void *data)
 {
-	return do_read_cache_page(mapping, index, filler, data, mapping_gfp_mask(mapping));
+	return do_read_cache_page(mapping, index, filler, data,
+			mapping_gfp_mask(mapping));
 }
 EXPORT_SYMBOL(read_cache_page);
 
-- 
2.20.1

