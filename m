Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBC422B8C
	for <lists+linux-nfs@lfdr.de>; Mon, 20 May 2019 07:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730513AbfETF6g (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 May 2019 01:58:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38412 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730511AbfETF6g (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 May 2019 01:58:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rcaOtmTyxwSnzPPNQ/axvrfybs4dWe6fVXdJWykZd68=; b=TKZaPqvgbKWe2FRLJA63Rp5Va4
        EtvOO4vybw2xssgKukZXhNdAQkCvd0y1IE51VR6M7TTOcm6DLHU2qbgUwi6nPchdxoG4tGd5VhFj7
        9yybQfAzQmIjw22SU7R09kbrt8RnT/FngobcNa5wKjOlKMJ3XzkXclUBNGYSdK+al7cntGX2uvwNL
        eRifDrk6y+rx14GKPJO3SZblI7ry/8uTGUm2VZ3m6UDmQq12v2Y/7CyJiQUeU8OHnGXUxmfYvyuvG
        l1BG/wqrcj3QlYZP4pV6fuYRhD8W8fO60c9YZw65wHlm783Vt9UblIP7bahz++F6NgG2/U8i5iEi6
        YTclvUgQ==;
Received: from 089144206147.atnat0015.highway.bob.at ([89.144.206.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hSbJe-0006FV-Qn; Mon, 20 May 2019 05:58:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] mm: don't cast ->readpage to filler_t for do_read_cache_page
Date:   Mon, 20 May 2019 07:57:29 +0200
Message-Id: <20190520055731.24538-3-hch@lst.de>
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

We can just pass a NULL filler and do the right thing inside of
do_read_cache_page based on the NULL parameter.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 include/linux/pagemap.h |  3 +--
 mm/filemap.c            | 10 ++++++----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 9ec3544baee2..6dd7ec95c778 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -396,8 +396,7 @@ extern int read_cache_pages(struct address_space *mapping,
 static inline struct page *read_mapping_page(struct address_space *mapping,
 				pgoff_t index, void *data)
 {
-	filler_t *filler = (filler_t *)mapping->a_ops->readpage;
-	return read_cache_page(mapping, index, filler, data);
+	return read_cache_page(mapping, index, NULL, data);
 }
 
 /*
diff --git a/mm/filemap.c b/mm/filemap.c
index 6a8048477bc6..3bec6e18b763 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2772,7 +2772,11 @@ static struct page *do_read_cache_page(struct address_space *mapping,
 		}
 
 filler:
-		err = filler(data, page);
+		if (filler)
+			err = filler(data, page);
+		else
+			err = mapping->a_ops->readpage(data, page);
+
 		if (err < 0) {
 			put_page(page);
 			return ERR_PTR(err);
@@ -2884,9 +2888,7 @@ struct page *read_cache_page_gfp(struct address_space *mapping,
 				pgoff_t index,
 				gfp_t gfp)
 {
-	filler_t *filler = (filler_t *)mapping->a_ops->readpage;
-
-	return do_read_cache_page(mapping, index, filler, NULL, gfp);
+	return do_read_cache_page(mapping, index, NULL, NULL, gfp);
 }
 EXPORT_SYMBOL(read_cache_page_gfp);
 
-- 
2.20.1

