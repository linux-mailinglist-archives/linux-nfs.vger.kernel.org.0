Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB94D10C0B
	for <lists+linux-nfs@lfdr.de>; Wed,  1 May 2019 19:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfEARfB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 May 2019 13:35:01 -0400
Received: from verein.lst.de ([213.95.11.211]:54116 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbfEARfB (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 1 May 2019 13:35:01 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 5364068AFE; Wed,  1 May 2019 19:34:43 +0200 (CEST)
Date:   Wed, 1 May 2019 19:34:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/4] 9p: pass the correct prototype to read_cache_page
Message-ID: <20190501173443.GA19969@lst.de>
References: <20190501160636.30841-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501160636.30841-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Fix the callback 9p passes to read_cache_page to actually have the
proper type expected.  Casting around function pointers can easily
hide typing bugs, and defeats control flow protection.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/9p/vfs_addr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 0bcbcc20f769..02e0fc51401e 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -50,8 +50,9 @@
  * @page: structure to page
  *
  */
-static int v9fs_fid_readpage(struct p9_fid *fid, struct page *page)
+static int v9fs_fid_readpage(void *data, struct page *page)
 {
+	struct p9_fid *fid = data;
 	struct inode *inode = page->mapping->host;
 	struct bio_vec bvec = {.bv_page = page, .bv_len = PAGE_SIZE};
 	struct iov_iter to;
@@ -122,7 +123,8 @@ static int v9fs_vfs_readpages(struct file *filp, struct address_space *mapping,
 	if (ret == 0)
 		return ret;
 
-	ret = read_cache_pages(mapping, pages, (void *)v9fs_vfs_readpage, filp);
+	ret = read_cache_pages(mapping, pages, v9fs_fid_readpage,
+			filp->private_data);
 	p9_debug(P9_DEBUG_VFS, "  = %d\n", ret);
 	return ret;
 }
-- 
2.20.1

