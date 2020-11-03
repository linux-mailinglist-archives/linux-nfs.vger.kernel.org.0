Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D91F2A4A27
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Nov 2020 16:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgKCPnp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Nov 2020 10:43:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:39150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728275AbgKCPno (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 3 Nov 2020 10:43:44 -0500
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC5EB20780
        for <linux-nfs@vger.kernel.org>; Tue,  3 Nov 2020 15:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604418224;
        bh=ijOhG6wbzr1FDG0GumWGgfirWkyodCZ0HhgSawLq+cI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Jd9Fd5tkHvDX3SFxqKTI32FJyICAKkGZo6qWcripUcjth7U4McOLvmHuzmKH+cfzx
         qbELApNaqvdBDdEtFod+IEmMXWNGZbjFzLw4mFZs9Qjt+0nI2JFD8VplMqekNJNJ7V
         q3PFTEC8Zalv/RFEQZUzIPB/mfu9XzHqA7z1yBo0=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 07/16] NFS: Replace kmap() with kmap_atomic() in nfs_readdir_search_array()
Date:   Tue,  3 Nov 2020 10:33:20 -0500
Message-Id: <20201103153329.531942-8-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103153329.531942-7-trondmy@kernel.org>
References: <20201103153329.531942-1-trondmy@kernel.org>
 <20201103153329.531942-2-trondmy@kernel.org>
 <20201103153329.531942-3-trondmy@kernel.org>
 <20201103153329.531942-4-trondmy@kernel.org>
 <20201103153329.531942-5-trondmy@kernel.org>
 <20201103153329.531942-6-trondmy@kernel.org>
 <20201103153329.531942-7-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index ba3521dcd0c8..52fa0bcf3d1d 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -448,7 +448,7 @@ int nfs_readdir_search_array(nfs_readdir_descriptor_t *desc)
 	struct nfs_cache_array *array;
 	int status;
 
-	array = kmap(desc->page);
+	array = kmap_atomic(desc->page);
 
 	if (desc->dir_cookie == 0)
 		status = nfs_readdir_search_for_pos(array, desc);
@@ -460,7 +460,7 @@ int nfs_readdir_search_array(nfs_readdir_descriptor_t *desc)
 		desc->current_index += array->size;
 		desc->page_index++;
 	}
-	kunmap(desc->page);
+	kunmap_atomic(array);
 	return status;
 }
 
-- 
2.28.0

