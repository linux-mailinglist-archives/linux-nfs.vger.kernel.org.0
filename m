Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C343821F18
	for <lists+linux-nfs@lfdr.de>; Fri, 17 May 2019 22:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfEQUd6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 May 2019 16:33:58 -0400
Received: from fieldses.org ([173.255.197.46]:54152 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbfEQUd6 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 17 May 2019 16:33:58 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 3A35F14D8; Fri, 17 May 2019 16:33:58 -0400 (EDT)
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 2/2] nfsd: note inadequate stats locking
Date:   Fri, 17 May 2019 16:33:57 -0400
Message-Id: <1558125237-21030-2-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1558125237-21030-1-git-send-email-bfields@redhat.com>
References: <1558125237-21030-1-git-send-email-bfields@redhat.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

After 89a26b3d295d "nfsd: split DRC global spinlock into per-bucket
locks", there is no longer a single global spinlock to protect these
stats.

So, really we need to fix that.  For now, at least fix the comment.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/netns.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 4146dca94c5f..e01c22fd1485 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -144,8 +144,11 @@ struct nfsd_net {
 	unsigned int             drc_hashsize;
 
 	/*
-	 * Stats and other tracking of on the duplicate reply cache. All of these and
-	 * the "rc" fields in nfsdstats are protected by the cache_lock
+	 * Stats and other tracking of on the duplicate reply cache.
+	 * These fields and the "rc" fields in nfsdstats are modified
+	 * with only the per-bucket cache lock, which isn't really safe
+	 * and should be fixed if we want the statistics to be
+	 * completely accurate.
 	 */
 
 	/* total number of entries */
-- 
2.21.0

