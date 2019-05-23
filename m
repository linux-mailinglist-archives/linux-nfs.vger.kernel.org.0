Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27ED9275B4
	for <lists+linux-nfs@lfdr.de>; Thu, 23 May 2019 07:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbfEWFrv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 May 2019 01:47:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52272 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbfEWFrv (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 23 May 2019 01:47:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1290713AA9
        for <linux-nfs@vger.kernel.org>; Thu, 23 May 2019 05:47:51 +0000 (UTC)
Received: from nkshirsa.pnq.com (unknown [10.76.1.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 03F7E18205;
        Thu, 23 May 2019 05:47:47 +0000 (UTC)
From:   Nikhil Kshirsagar <nkshirsa@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, nkshirsa@redhat.com
Subject: [PATCH] rpc.mountd: Fix e_hostname and e_uuid leaks reported in bz1711210
Date:   Thu, 23 May 2019 11:17:34 +0530
Message-Id: <1558590454-31741-1-git-send-email-nkshirsa@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 23 May 2019 05:47:51 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

strdup of exportent uuid and hostname in getexportent() ends up leaking
memory. Free the memory before getexportent() is called again from xtab_read()

Signed-off-by: Nikhil Kshirsagar <nkshirsa@redhat.com>
---
 support/export/xtab.c | 19 ++++++++++++++++++-
 support/nfs/exports.c | 15 +++++++++++++--
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/support/export/xtab.c b/support/export/xtab.c
index d42eeef..1e1d679 100644
--- a/support/export/xtab.c
+++ b/support/export/xtab.c
@@ -50,6 +50,14 @@ xtab_read(char *xtab, char *lockfn, int is_export)
 	while ((xp = getexportent(is_export==0, 0)) != NULL) {
 		if (!(exp = export_lookup(xp->e_hostname, xp->e_path, is_export != 1)) &&
 		    !(exp = export_create(xp, is_export!=1))) {
+                        if(xp->e_hostname) {
+                            free(xp->e_hostname);
+                            xp->e_hostname=NULL;
+                        }
+                        if(xp->e_uuid) {
+                            free(xp->e_uuid);
+                            xp->e_uuid=NULL;
+                        }
 			continue;
 		}
 		switch (is_export) {
@@ -62,7 +70,16 @@ xtab_read(char *xtab, char *lockfn, int is_export)
 			if ((xp->e_flags & NFSEXP_FSID) && xp->e_fsid == 0)
 				v4root_needed = 0;
 			break;
-		}
+		}  
+                if(xp->e_hostname) {
+                    free(xp->e_hostname);
+                    xp->e_hostname=NULL;
+                }
+                if(xp->e_uuid) {
+                    free(xp->e_uuid);
+                    xp->e_uuid=NULL;
+                }
+
 	}
 	endexportent();
 	xfunlock(lockid);
diff --git a/support/nfs/exports.c b/support/nfs/exports.c
index 5f4cb95..a7582ca 100644
--- a/support/nfs/exports.c
+++ b/support/nfs/exports.c
@@ -179,9 +179,20 @@ getexportent(int fromkernel, int fromexports)
 	}
 	ee.e_hostname = xstrdup(hostname);
 
-	if (parseopts(opt, &ee, fromexports && !has_default_subtree_opts, NULL) < 0)
-		return NULL;
+	if (parseopts(opt, &ee, fromexports && !has_default_subtree_opts, NULL) < 0) {
+                if(ee.e_hostname)
+                {
+                    xfree(ee.e_hostname);
+                    ee.e_hostname=NULL;
+                }
+                if(ee.e_uuid)
+                {
+                    xfree(ee.e_uuid);
+                    ee.e_uuid=NULL;
+                }
 
+		return NULL;
+        }
 	/* resolve symlinks */
 	if (realpath(ee.e_path, rpath) != NULL) {
 		rpath[sizeof (rpath) - 1] = '\0';
-- 
1.8.3.1

