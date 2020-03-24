Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 428BF191DAF
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2020 00:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgCXXtl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Mar 2020 19:49:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726956AbgCXXtk (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 24 Mar 2020 19:49:40 -0400
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net [68.40.189.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 520FD20719
        for <linux-nfs@vger.kernel.org>; Tue, 24 Mar 2020 23:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585093780;
        bh=ksX41en9zXztZkK7yJUP1w30ssz69SdnHLr2M+BntI0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=nHR5kdL8jDBM7VYzDqNshOvXF4f15UZQ0JEv2mf9SPbss2Vu+2411rYgt210QA+Qy
         2mXzklU2ioEnvzUv2IS/3nuCcEgQLepGffoXVbItpfBYQwsjGgJ2DlV1oVcRwSySja
         H1yujwZf/4hPwDBY6w0lCpz69ts22gMp33hp85G0=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 06/22] pNFS: Support per-layout segment commits in pnfs_generic_recover_commit_reqs()
Date:   Tue, 24 Mar 2020 19:47:12 -0400
Message-Id: <20200324234728.8997-7-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324234728.8997-6-trondmy@kernel.org>
References: <20200324234728.8997-1-trondmy@kernel.org>
 <20200324234728.8997-2-trondmy@kernel.org>
 <20200324234728.8997-3-trondmy@kernel.org>
 <20200324234728.8997-4-trondmy@kernel.org>
 <20200324234728.8997-5-trondmy@kernel.org>
 <20200324234728.8997-6-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Add support for scanning the full list of per-layout segment commit
arrays to pnfs_generic_recover_commit_reqs().

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs_nfs.c | 41 +++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index 81fd85e66fd9..f16bd6d0e830 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -189,22 +189,23 @@ int pnfs_generic_scan_commit_lists(struct nfs_commit_info *cinfo, int max)
 }
 EXPORT_SYMBOL_GPL(pnfs_generic_scan_commit_lists);
 
-/* Pull everything off the committing lists and dump into @dst.  */
-void pnfs_generic_recover_commit_reqs(struct list_head *dst,
-				      struct nfs_commit_info *cinfo)
+static unsigned int
+pnfs_bucket_recover_commit_reqs(struct list_head *dst,
+			        struct pnfs_commit_bucket *buckets,
+				unsigned int nbuckets,
+				struct nfs_commit_info *cinfo)
 {
 	struct pnfs_commit_bucket *b;
 	struct pnfs_layout_segment *freeme;
-	int nwritten;
-	int i;
+	unsigned int nwritten, ret = 0;
+	unsigned int i;
 
-	lockdep_assert_held(&NFS_I(cinfo->inode)->commit_mutex);
 restart:
-	for (i = 0, b = cinfo->ds->buckets; i < cinfo->ds->nbuckets; i++, b++) {
+	for (i = 0, b = buckets; i < nbuckets; i++, b++) {
 		nwritten = nfs_scan_commit_list(&b->written, dst, cinfo, 0);
 		if (!nwritten)
 			continue;
-		cinfo->ds->nwritten -= nwritten;
+		ret += nwritten;
 		if (list_empty(&b->written)) {
 			freeme = b->wlseg;
 			b->wlseg = NULL;
@@ -212,6 +213,30 @@ void pnfs_generic_recover_commit_reqs(struct list_head *dst,
 			goto restart;
 		}
 	}
+	return ret;
+}
+
+/* Pull everything off the committing lists and dump into @dst.  */
+void pnfs_generic_recover_commit_reqs(struct list_head *dst,
+				      struct nfs_commit_info *cinfo)
+{
+	struct pnfs_ds_commit_info *fl_cinfo = cinfo->ds;
+	struct pnfs_commit_array *array;
+	unsigned int nwritten;
+
+	lockdep_assert_held(&NFS_I(cinfo->inode)->commit_mutex);
+	nwritten = pnfs_bucket_recover_commit_reqs(dst,
+						   fl_cinfo->buckets,
+						   fl_cinfo->nbuckets,
+						   cinfo);
+	fl_cinfo->nwritten -= nwritten;
+	list_for_each_entry(array, &fl_cinfo->commits, cinfo_list) {
+		nwritten = pnfs_bucket_recover_commit_reqs(dst,
+							   array->buckets,
+							   array->nbuckets,
+							   cinfo);
+		fl_cinfo->nwritten -= nwritten;
+	}
 }
 EXPORT_SYMBOL_GPL(pnfs_generic_recover_commit_reqs);
 
-- 
2.25.1

