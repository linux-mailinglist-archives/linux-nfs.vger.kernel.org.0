Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4BC2C9167
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Nov 2020 23:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgK3WrB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 17:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729053AbgK3WrB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Nov 2020 17:47:01 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B88C0613D6
        for <linux-nfs@vger.kernel.org>; Mon, 30 Nov 2020 14:46:20 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 47F276EAD; Mon, 30 Nov 2020 17:46:20 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 47F276EAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1606776380;
        bh=j9hvBFu6mU+C0vE2Xvm/O/tMIXSDjLh4903hY8vcREo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xzjXHdYbEaz9tJDe4AgPaBgJ+k6VqQzNe2Nbeinifq3QYsahvWKwl+ejnlV7gRYPB
         p9N77IA+K2hFSzaN/lkklScS6RknjZMiVgSv3OXg2iLV/MX73yViJ2JzFTO3cdkv8a
         EQbrgn8tYgpOoQrslwCWWFE3m1vFMQqxV3sufWl0=
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 3/5] nfsd: minor nfsd4_change_attribute cleanup
Date:   Mon, 30 Nov 2020 17:46:16 -0500
Message-Id: <1606776378-22381-3-git-send-email-bfields@fieldses.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1606776378-22381-1-git-send-email-bfields@fieldses.org>
References: <1606776378-22381-1-git-send-email-bfields@fieldses.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

Minor cleanup, no change in behavior.

Also pull out a common helper that'll be useful elsewhere.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfsfh.h          | 13 +++++--------
 include/linux/iversion.h | 13 +++++++++++++
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 39d764b129fa..45bd776290d5 100644
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
-		chattr = stat->ctime.tv_sec;
-		chattr <<= 32;
-		chattr += stat->ctime.tv_nsec;
-	}
-	return chattr;
+		return chattr;
+	} else
+		return time_to_chattr(&stat->ctime);
 }
 
 extern void fill_pre_wcc(struct svc_fh *fhp);
diff --git a/include/linux/iversion.h b/include/linux/iversion.h
index 2917ef990d43..3bfebde5a1a6 100644
--- a/include/linux/iversion.h
+++ b/include/linux/iversion.h
@@ -328,6 +328,19 @@ inode_query_iversion(struct inode *inode)
 	return cur >> I_VERSION_QUERIED_SHIFT;
 }
 
+/*
+ * For filesystems without any sort of change attribute, the best we can
+ * do is fake one up from the ctime:
+ */
+static inline u64 time_to_chattr(struct timespec64 *t)
+{
+	u64 chattr = t->tv_sec;
+
+	chattr <<= 32;
+	chattr += t->tv_nsec;
+	return chattr;
+}
+
 /**
  * inode_eq_iversion_raw - check whether the raw i_version counter has changed
  * @inode: inode to check
-- 
2.28.0

