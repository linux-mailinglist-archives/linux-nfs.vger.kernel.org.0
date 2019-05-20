Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 850A422B87
	for <lists+linux-nfs@lfdr.de>; Mon, 20 May 2019 07:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbfETF6a (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 May 2019 01:58:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37616 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfETF6a (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 May 2019 01:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MsXW1oUHr05ZSy88t0Z7I0GXKd9SSvBG18rggV2Vu2g=; b=Y8rXbybloiYAZIahaVSujAokhz
        2Yi2UAMOUpPcvHfhuSHLQu4Juf5a1UAxTglQmGxVdyniHxS24VDy1xVzAnQsKm5k9Im81PSFPeMCp
        iR6c10H9cNGjTJJiTzM27ZW02nvJmYAMVOBAM7TdgvrB0NJW+fWgdreJcQhRt/7/ftrttcvqetx1U
        rWn7x9w7HZ9lj9cm3tviyv3JE/7gPR54vNFSwecekAofc7b1GzqZusqzQqbRLZWj8a2q4yV66IyoI
        msf9FbMvBh8VtCYc1ERTpXzsAPWMHbYvaqX210fg7ZdbKDzr92R1HS8AHgaIZExx/0OSOcra4N6Tg
        eHYmr0TQ==;
Received: from 089144206147.atnat0015.highway.bob.at ([89.144.206.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hSbJa-0006Eo-Oh; Mon, 20 May 2019 05:58:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] mm: fix an overly long line in read_cache_page
Date:   Mon, 20 May 2019 07:57:28 +0200
Message-Id: <20190520055731.24538-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520055731.24538-1-hch@lst.de>
References: <20190520055731.24538-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 mm/filemap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index c5af80c43d36..6a8048477bc6 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2862,7 +2862,8 @@ struct page *read_cache_page(struct address_space *mapping,
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

