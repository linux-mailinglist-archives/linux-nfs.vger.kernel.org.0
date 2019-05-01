Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACBFC10AA1
	for <lists+linux-nfs@lfdr.de>; Wed,  1 May 2019 18:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfEAQHY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 May 2019 12:07:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35878 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfEAQHY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 May 2019 12:07:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UYhsUC45x3BaFz65BgDHiQpOpAjMvMtZBCkBOB8hL5Q=; b=N9hkv1/KxvUiY8l8aDh5EzrKDf
        aX39LFBLR0uVkQvhJLeEuPzxrJ0HtEIeY1e9ikhySWDweBLiPvDrdzTlg6Wi0QSSQyaH9yXwYdcov
        pBzp0wGVJgNK7NXNtPiDAUZ9JEhgdVCOcXx35OAT/umKz11Mt42tyvCSvcGByPL85Lm1hqWDO1jDB
        3eWTieiEchWRQ2uYH/Y5x99PF4advsXL+oOmTaa4AVdjheR/oqOCWxx1j8RQR+gadGYSv+v5Gdcjt
        uilpaJBDPY/A3oCNijbOhKOerYmle8m2zgrUn4qQy2u/DTcJ71W+0FaQ0X2cTtzC+j/lhgvo5htPv
        w1zfZX8A==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLrlQ-0008P9-2K; Wed, 01 May 2019 16:07:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] jffs2: pass the correct prototype to read_cache_page
Date:   Wed,  1 May 2019 12:06:36 -0400
Message-Id: <20190501160636.30841-5-hch@lst.de>
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

Fix the callback jffs2 passes to read_cache_page to actually have the
proper type expected.  Casting around function pointers can easily
hide typing bugs, and defeats control flow protection.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/jffs2/file.c     | 4 ++--
 fs/jffs2/fs.c       | 2 +-
 fs/jffs2/os-linux.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
index 7d8654a1472e..f8fb89b10227 100644
--- a/fs/jffs2/file.c
+++ b/fs/jffs2/file.c
@@ -109,9 +109,9 @@ static int jffs2_do_readpage_nolock (struct inode *inode, struct page *pg)
 	return ret;
 }
 
-int jffs2_do_readpage_unlock(struct inode *inode, struct page *pg)
+int jffs2_do_readpage_unlock(void *data, struct page *pg)
 {
-	int ret = jffs2_do_readpage_nolock(inode, pg);
+	int ret = jffs2_do_readpage_nolock(data, pg);
 	unlock_page(pg);
 	return ret;
 }
diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
index eab04eca95a3..7fbe8a7843b9 100644
--- a/fs/jffs2/fs.c
+++ b/fs/jffs2/fs.c
@@ -686,7 +686,7 @@ unsigned char *jffs2_gc_fetch_page(struct jffs2_sb_info *c,
 	struct page *pg;
 
 	pg = read_cache_page(inode->i_mapping, offset >> PAGE_SHIFT,
-			     (void *)jffs2_do_readpage_unlock, inode);
+			     jffs2_do_readpage_unlock, inode);
 	if (IS_ERR(pg))
 		return (void *)pg;
 
diff --git a/fs/jffs2/os-linux.h b/fs/jffs2/os-linux.h
index a2dbbb3f4c74..bd3d5f0ddc34 100644
--- a/fs/jffs2/os-linux.h
+++ b/fs/jffs2/os-linux.h
@@ -155,7 +155,7 @@ extern const struct file_operations jffs2_file_operations;
 extern const struct inode_operations jffs2_file_inode_operations;
 extern const struct address_space_operations jffs2_file_address_operations;
 int jffs2_fsync(struct file *, loff_t, loff_t, int);
-int jffs2_do_readpage_unlock (struct inode *inode, struct page *pg);
+int jffs2_do_readpage_unlock(void *data, struct page *pg);
 
 /* ioctl.c */
 long jffs2_ioctl(struct file *, unsigned int, unsigned long);
-- 
2.20.1

