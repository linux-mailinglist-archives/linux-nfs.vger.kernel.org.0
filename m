Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39781436C98
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Oct 2021 23:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhJUVWi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Oct 2021 17:22:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232173AbhJUVWh (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 21 Oct 2021 17:22:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D24860F8F
        for <linux-nfs@vger.kernel.org>; Thu, 21 Oct 2021 21:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634851221;
        bh=B1wOpcPrUzB1INGSeHVom+RA7i6RWA/odgHtokOkci0=;
        h=From:To:Subject:Date:From;
        b=Ti1cvVXMAyMovIB1BzHsFhKI+kPwjk2hnAsgviARyXRZZazH3P6MYp4PoCf6SLBae
         Qs8Bck6R0SwITycuPaf7Of2nY2dyYhG8sw0ch6pNXIg5ymCvf4wNIq8Bi+VNcxh1FV
         UZ19e8zMYwabqE+lACH+iY5p3k9F6MtqYTsS2kOIKbrsBHdeObdvc/1ONh69zcwGmp
         AtED2WyhywXMlR5mPMryJvbzmJR5gRXhlslVbIvg5qKY5PcJhA5mgOv8+qWHn5Bgxa
         4hYgO7jfJ3n/0Aq/x2kgDN44O/izjKuU7GBU5WICXdVMZnJRbdUp16Rtgr6hjCLXmN
         u75RYqGeMyshQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Remove redundant call to __set_page_dirty_nobuffers
Date:   Thu, 21 Oct 2021 17:13:34 -0400
Message-Id: <20211021211334.681480-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Remove a redundant call in nfs_updatepage(). nfs_writepage_setup() will
have already called nfs_mark_request_dirty() on success.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/write.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 82c5b89395f6..9b7619ce17a7 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1384,8 +1384,6 @@ int nfs_updatepage(struct file *file, struct page *page,
 	status = nfs_writepage_setup(ctx, page, offset, count);
 	if (status < 0)
 		nfs_set_pageerror(mapping);
-	else
-		__set_page_dirty_nobuffers(page);
 out:
 	dprintk("NFS:       nfs_updatepage returns %d (isize %lld)\n",
 			status, (long long)i_size_read(inode));
-- 
2.31.1

