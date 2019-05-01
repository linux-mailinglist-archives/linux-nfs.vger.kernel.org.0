Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1119810AA4
	for <lists+linux-nfs@lfdr.de>; Wed,  1 May 2019 18:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbfEAQHc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 May 2019 12:07:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35454 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfEAQHV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 May 2019 12:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UkZuaD7Mm6HPsygbDYfM+bk4xZlXKq4hzNRQaTP1dh0=; b=BOHFVQkAG46eDJBYOpbwz2YPVY
        XQWZ6xnJ52th5oNnDhX56QOGmvBs2NJ18NLF+KQDVDgs3rolaHP4MR5TdjtPjR+JJdljMUmO9UBaN
        UB/BV55owFyHcMrd5/ND3t+hPSjcs6OAZhKGjGwewGeE/O+lTOnRqmy3RFwzppAdYHQ2H+DXywuMm
        zig7Ko9GH/87I/mhU7tKmPn98Lbrvo4gmTE4TZBR5yIECXjXWshC9BB1zcDlKjfv/kFxH1sAQ8ZXc
        Tr+c9N6Y6GLUZDRBdPrBPPRdRYpbwZ5VwuKftQ0dJWhnuBZEUCuf0ozkuIswyhHll3ggTqxOobjBe
        BBQuKPvg==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLrlO-0008Mh-Dh; Wed, 01 May 2019 16:07:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] nfs: pass the correct prototype to read_cache_page
Date:   Wed,  1 May 2019 12:06:35 -0400
Message-Id: <20190501160636.30841-4-hch@lst.de>
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

Fix the callbacks NFS passes to read_cache_page to actually have the
proper type expected.  Casting around function pointers can easily
hide typing bugs, and defeats control flow protection.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/dir.c     | 7 ++++---
 fs/nfs/symlink.c | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index a71d0b42d160..47d445bec8c9 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -714,8 +714,9 @@ int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page *page,
  * We only need to convert from xdr once so future lookups are much simpler
  */
 static
-int nfs_readdir_filler(nfs_readdir_descriptor_t *desc, struct page* page)
+int nfs_readdir_filler(void *data, struct page* page)
 {
+	nfs_readdir_descriptor_t *desc = data;
 	struct inode	*inode = file_inode(desc->file);
 	int ret;
 
@@ -762,8 +763,8 @@ void cache_page_release(nfs_readdir_descriptor_t *desc)
 static
 struct page *get_cache_page(nfs_readdir_descriptor_t *desc)
 {
-	return read_cache_page(desc->file->f_mapping,
-			desc->page_index, (filler_t *)nfs_readdir_filler, desc);
+	return read_cache_page(desc->file->f_mapping, desc->page_index,
+			nfs_readdir_filler, desc);
 }
 
 /*
diff --git a/fs/nfs/symlink.c b/fs/nfs/symlink.c
index 06eb44b47885..25ba299fdac2 100644
--- a/fs/nfs/symlink.c
+++ b/fs/nfs/symlink.c
@@ -26,8 +26,9 @@
  * and straight-forward than readdir caching.
  */
 
-static int nfs_symlink_filler(struct inode *inode, struct page *page)
+static int nfs_symlink_filler(void *data, struct page *page)
 {
+	struct inode *inode = data;
 	int error;
 
 	error = NFS_PROTO(inode)->readlink(inode, page, 0, PAGE_SIZE);
@@ -65,8 +66,8 @@ static const char *nfs_get_link(struct dentry *dentry,
 		err = ERR_PTR(nfs_revalidate_mapping(inode, inode->i_mapping));
 		if (err)
 			return err;
-		page = read_cache_page(&inode->i_data, 0,
-					(filler_t *)nfs_symlink_filler, inode);
+		page = read_cache_page(&inode->i_data, 0, nfs_symlink_filler,
+				inode);
 		if (IS_ERR(page))
 			return ERR_CAST(page);
 	}
-- 
2.20.1

