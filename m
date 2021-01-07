Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818B22ECA30
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Jan 2021 06:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbhAGFcy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Jan 2021 00:32:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:47230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbhAGFcy (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 7 Jan 2021 00:32:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E234230F9
        for <linux-nfs@vger.kernel.org>; Thu,  7 Jan 2021 05:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609997493;
        bh=H9T9eD10HN0/76WEkR0XrwxhdODxSJjx6ZaAMOVJdt4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Wm//ZrwKHvNavettKmMn/tiPGX7Y/RIF/2xhBgpVXygaNFgv/R+HIh9obOLVZNSqM
         wayRkrgfXXEj+4nNaNCe+4tyUPfZuk19ZsFYly44S2Rjpcw+o7WuHZxH64C1zI30Rv
         L2rW70W/t7u3RjNsV6zYxPQMn8DJ0qxZT6gFvHGQddk86ePw4nveYF8Dj6D4Les3yu
         rBV7g0n8sY//cKluyNTpCuk9f+HeSZsJL4Z+eHwqClZS96/W7hbPGE5KWmipUeEHtI
         M4w0/DooEAvJBHpdOu/qujdS3+GPbqbXhhzBMbJ0c6bw5gSm8QoUPvrTtzPOR3g0zG
         lS05CAPugnO0g==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 6/7] NFS/pNFS: Don't leak DS commits in pnfs_generic_retry_commit()
Date:   Thu,  7 Jan 2021 00:31:29 -0500
Message-Id: <20210107053130.20341-6-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210107053130.20341-5-trondmy@kernel.org>
References: <20210107053130.20341-1-trondmy@kernel.org>
 <20210107053130.20341-2-trondmy@kernel.org>
 <20210107053130.20341-3-trondmy@kernel.org>
 <20210107053130.20341-4-trondmy@kernel.org>
 <20210107053130.20341-5-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

We must ensure that we pass a layout segment to nfs_retry_commit() when
we're cleaning up after pnfs_bucket_alloc_ds_commits(). Otherwise,
requests that should be committed to the DS will get committed to the
MDS.
Do so by ensuring that pnfs_bucket_get_committing() always tries to
return a layout segment when it returns a non-empty page list.

Fixes: c84bea59449a ("NFS/pNFS: Simplify bucket layout segment reference counting")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs_nfs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index df20bbe8d15e..49d3389bd813 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -403,12 +403,16 @@ pnfs_bucket_get_committing(struct list_head *head,
 			   struct pnfs_commit_bucket *bucket,
 			   struct nfs_commit_info *cinfo)
 {
+	struct pnfs_layout_segment *lseg;
 	struct list_head *pos;
 
 	list_for_each(pos, &bucket->committing)
 		cinfo->ds->ncommitting--;
 	list_splice_init(&bucket->committing, head);
-	return pnfs_free_bucket_lseg(bucket);
+	lseg = pnfs_free_bucket_lseg(bucket);
+	if (!lseg)
+		lseg = pnfs_get_lseg(bucket->lseg);
+	return lseg;
 }
 
 static struct nfs_commit_data *
@@ -420,8 +424,6 @@ pnfs_bucket_fetch_commitdata(struct pnfs_commit_bucket *bucket,
 	if (!data)
 		return NULL;
 	data->lseg = pnfs_bucket_get_committing(&data->pages, bucket, cinfo);
-	if (!data->lseg)
-		data->lseg = pnfs_get_lseg(bucket->lseg);
 	return data;
 }
 
-- 
2.29.2

