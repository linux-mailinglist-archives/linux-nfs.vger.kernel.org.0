Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804AE2BB928
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 23:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgKTWjX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 17:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728885AbgKTWjW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 17:39:22 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7E8C061A04
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 14:39:22 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 0181A41A2; Fri, 20 Nov 2020 17:39:22 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 0181A41A2
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 3/8] nfsd: minor nfsd4_change_attribute cleanup
Date:   Fri, 20 Nov 2020 17:39:15 -0500
Message-Id: <1605911960-12516-3-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1605911960-12516-1-git-send-email-bfields@redhat.com>
References: <20201120223831.GB7705@fieldses.org>
 <1605911960-12516-1-git-send-email-bfields@redhat.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

Minor cleanup, no change in behavior

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfsfh.h | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 3faf5974fa4e..45bd776290d5 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -259,19 +259,16 @@ fh_clear_wcc(struct svc_fh *fhp)
 static inline u64 nfsd4_change_attribute(struct kstat *stat,
 					 struct inode *inode)
 {
-	u64 chattr;
-
 	if (IS_I_VERSION(inode)) {
+		u64 chattr;
+
 		chattr =  stat->ctime.tv_sec;
 		chattr <<= 30;
 		chattr += stat->ctime.tv_nsec;
 		chattr += inode_query_iversion(inode);
-	} else {
-		chattr = cpu_to_be32(stat->ctime.tv_sec);
-		chattr <<= 32;
-		chattr += cpu_to_be32(stat->ctime.tv_nsec);
-	}
-	return chattr;
+		return chattr;
+	} else
+		return time_to_chattr(&stat->ctime);
 }
 
 extern void fill_pre_wcc(struct svc_fh *fhp);
-- 
2.28.0

