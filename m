Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6361AD29F
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2020 00:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbgDPWPE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Apr 2020 18:15:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729199AbgDPWPD (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 16 Apr 2020 18:15:03 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B3C4221F9;
        Thu, 16 Apr 2020 22:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587075303;
        bh=3aUFRrpZcE/s1KgidxE52RylYFuRQiFUfWiqJcLIGjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r3IgAwR42Ba40tyMNX0H++hTLOh6X5tbjjpcB5iKt+8RzXpnPfDMz8H+T60m5J4K9
         S+J+TUQ4WJZlZYwfq4epGcvCB38JbQOZ/sh9YMFgoYr7pnkHeRxG/RpHLiZRoabW41
         sZz3bBAtwNC7XLnzq8Un5A5jbXPRGyUObp27TZXM=
From:   trondmy@kernel.org
To:     Steve Dickson <SteveD@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 6/7] mountd: Ignore transient and non-fatal filesystem errors in nfsd_fh()
Date:   Thu, 16 Apr 2020 18:12:51 -0400
Message-Id: <20200416221252.82102-7-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200416221252.82102-6-trondmy@kernel.org>
References: <20200416221252.82102-1-trondmy@kernel.org>
 <20200416221252.82102-2-trondmy@kernel.org>
 <20200416221252.82102-3-trondmy@kernel.org>
 <20200416221252.82102-4-trondmy@kernel.org>
 <20200416221252.82102-5-trondmy@kernel.org>
 <20200416221252.82102-6-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

In nfsd_fh(), if the error returned by the downcall is transient,
then we should ignore it. Only reject the export if the filesystem
path is truly not exportable.
This fixes a case where we can see spurious NFSERR_STALE errors
being returned by knfsd.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 utils/mountd/cache.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/utils/mountd/cache.c b/utils/mountd/cache.c
index 0f323226b12a..79d3ee085a90 100644
--- a/utils/mountd/cache.c
+++ b/utils/mountd/cache.c
@@ -843,8 +843,14 @@ static void nfsd_fh(int f)
 			}
 		}
 	}
-	if (found && 
-	    found->e_mountpoint &&
+
+	if (!found) {
+		/* The missing dev could be what we want, so just be
+		 * quiet rather than returning stale yet
+		 */
+		if (dev_missing)
+			goto out;
+	} else if (found->e_mountpoint &&
 	    !is_mountpoint(found->e_mountpoint[0]?
 			   found->e_mountpoint:
 			   found->e_path)) {
@@ -855,17 +861,12 @@ static void nfsd_fh(int f)
 		 */
 		/* FIXME we need to make sure we re-visit this later */
 		goto out;
+	} else if (cache_export_ent(buf, sizeof(buf), dom, found, found_path) < 0) {
+		if (!path_lookup_error(errno))
+			goto out;
+		/* The kernel is saying the path is unexportable */
+		found = NULL;
 	}
-	if (!found && dev_missing) {
-		/* The missing dev could be what we want, so just be
-		 * quite rather than returning stale yet
-		 */
-		goto out;
-	}
-
-	if (found)
-		if (cache_export_ent(buf, sizeof(buf), dom, found, found_path) < 0)
-			found = 0;
 
 	bp = buf; blen = sizeof(buf);
 	qword_add(&bp, &blen, dom);
-- 
2.25.2

