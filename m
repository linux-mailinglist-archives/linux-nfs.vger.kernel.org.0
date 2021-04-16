Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0872B36275A
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Apr 2021 20:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbhDPSAt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 16 Apr 2021 14:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236062AbhDPSAr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 16 Apr 2021 14:00:47 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2CCC061760
        for <linux-nfs@vger.kernel.org>; Fri, 16 Apr 2021 11:00:21 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 1ABAC7CC; Fri, 16 Apr 2021 14:00:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 1ABAC7CC
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 4/5] nfsd: reshuffle some code
Date:   Fri, 16 Apr 2021 14:00:17 -0400
Message-Id: <1618596018-9899-4-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1618596018-9899-1-git-send-email-bfields@redhat.com>
References: <1618596018-9899-1-git-send-email-bfields@redhat.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

No change in behavior, I'm just moving some code around to avoid forward
references in a following patch.

(To do someday: figure out how to split up nfs4state.c.  It's big and
disorganized.)

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4state.c | 234 ++++++++++++++++++++++----------------------
 1 file changed, 117 insertions(+), 117 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c1ba60db671a..dfe3e39c891c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -353,6 +353,123 @@ static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops = {
 	.release	= nfsd4_cb_notify_lock_release,
 };
 
+/*
+ * We store the NONE, READ, WRITE, and BOTH bits separately in the
+ * st_{access,deny}_bmap field of the stateid, in order to track not
+ * only what share bits are currently in force, but also what
+ * combinations of share bits previous opens have used.  This allows us
+ * to enforce the recommendation of rfc 3530 14.2.19 that the server
+ * return an error if the client attempt to downgrade to a combination
+ * of share bits not explicable by closing some of its previous opens.
+ *
+ * XXX: This enforcement is actually incomplete, since we don't keep
+ * track of access/deny bit combinations; so, e.g., we allow:
+ *
+ *	OPEN allow read, deny write
+ *	OPEN allow both, deny none
+ *	DOWNGRADE allow read, deny none
+ *
+ * which we should reject.
+ */
+static unsigned int
+bmap_to_share_mode(unsigned long bmap) {
+	int i;
+	unsigned int access = 0;
+
+	for (i = 1; i < 4; i++) {
+		if (test_bit(i, &bmap))
+			access |= i;
+	}
+	return access;
+}
+
+/* set share access for a given stateid */
+static inline void
+set_access(u32 access, struct nfs4_ol_stateid *stp)
+{
+	unsigned char mask = 1 << access;
+
+	WARN_ON_ONCE(access > NFS4_SHARE_ACCESS_BOTH);
+	stp->st_access_bmap |= mask;
+}
+
+/* clear share access for a given stateid */
+static inline void
+clear_access(u32 access, struct nfs4_ol_stateid *stp)
+{
+	unsigned char mask = 1 << access;
+
+	WARN_ON_ONCE(access > NFS4_SHARE_ACCESS_BOTH);
+	stp->st_access_bmap &= ~mask;
+}
+
+/* test whether a given stateid has access */
+static inline bool
+test_access(u32 access, struct nfs4_ol_stateid *stp)
+{
+	unsigned char mask = 1 << access;
+
+	return (bool)(stp->st_access_bmap & mask);
+}
+
+/* set share deny for a given stateid */
+static inline void
+set_deny(u32 deny, struct nfs4_ol_stateid *stp)
+{
+	unsigned char mask = 1 << deny;
+
+	WARN_ON_ONCE(deny > NFS4_SHARE_DENY_BOTH);
+	stp->st_deny_bmap |= mask;
+}
+
+/* clear share deny for a given stateid */
+static inline void
+clear_deny(u32 deny, struct nfs4_ol_stateid *stp)
+{
+	unsigned char mask = 1 << deny;
+
+	WARN_ON_ONCE(deny > NFS4_SHARE_DENY_BOTH);
+	stp->st_deny_bmap &= ~mask;
+}
+
+/* test whether a given stateid is denying specific access */
+static inline bool
+test_deny(u32 deny, struct nfs4_ol_stateid *stp)
+{
+	unsigned char mask = 1 << deny;
+
+	return (bool)(stp->st_deny_bmap & mask);
+}
+
+static int nfs4_access_to_omode(u32 access)
+{
+	switch (access & NFS4_SHARE_ACCESS_BOTH) {
+	case NFS4_SHARE_ACCESS_READ:
+		return O_RDONLY;
+	case NFS4_SHARE_ACCESS_WRITE:
+		return O_WRONLY;
+	case NFS4_SHARE_ACCESS_BOTH:
+		return O_RDWR;
+	}
+	WARN_ON_ONCE(1);
+	return O_RDONLY;
+}
+
+static inline int
+access_permit_read(struct nfs4_ol_stateid *stp)
+{
+	return test_access(NFS4_SHARE_ACCESS_READ, stp) ||
+		test_access(NFS4_SHARE_ACCESS_BOTH, stp) ||
+		test_access(NFS4_SHARE_ACCESS_WRITE, stp);
+}
+
+static inline int
+access_permit_write(struct nfs4_ol_stateid *stp)
+{
+	return test_access(NFS4_SHARE_ACCESS_WRITE, stp) ||
+		test_access(NFS4_SHARE_ACCESS_BOTH, stp);
+}
+
 static inline struct nfs4_stateowner *
 nfs4_get_stateowner(struct nfs4_stateowner *sop)
 {
@@ -1149,108 +1266,6 @@ static unsigned int clientstr_hashval(struct xdr_netobj name)
 	return opaque_hashval(name.data, 8) & CLIENT_HASH_MASK;
 }
 
-/*
- * We store the NONE, READ, WRITE, and BOTH bits separately in the
- * st_{access,deny}_bmap field of the stateid, in order to track not
- * only what share bits are currently in force, but also what
- * combinations of share bits previous opens have used.  This allows us
- * to enforce the recommendation of rfc 3530 14.2.19 that the server
- * return an error if the client attempt to downgrade to a combination
- * of share bits not explicable by closing some of its previous opens.
- *
- * XXX: This enforcement is actually incomplete, since we don't keep
- * track of access/deny bit combinations; so, e.g., we allow:
- *
- *	OPEN allow read, deny write
- *	OPEN allow both, deny none
- *	DOWNGRADE allow read, deny none
- *
- * which we should reject.
- */
-static unsigned int
-bmap_to_share_mode(unsigned long bmap) {
-	int i;
-	unsigned int access = 0;
-
-	for (i = 1; i < 4; i++) {
-		if (test_bit(i, &bmap))
-			access |= i;
-	}
-	return access;
-}
-
-/* set share access for a given stateid */
-static inline void
-set_access(u32 access, struct nfs4_ol_stateid *stp)
-{
-	unsigned char mask = 1 << access;
-
-	WARN_ON_ONCE(access > NFS4_SHARE_ACCESS_BOTH);
-	stp->st_access_bmap |= mask;
-}
-
-/* clear share access for a given stateid */
-static inline void
-clear_access(u32 access, struct nfs4_ol_stateid *stp)
-{
-	unsigned char mask = 1 << access;
-
-	WARN_ON_ONCE(access > NFS4_SHARE_ACCESS_BOTH);
-	stp->st_access_bmap &= ~mask;
-}
-
-/* test whether a given stateid has access */
-static inline bool
-test_access(u32 access, struct nfs4_ol_stateid *stp)
-{
-	unsigned char mask = 1 << access;
-
-	return (bool)(stp->st_access_bmap & mask);
-}
-
-/* set share deny for a given stateid */
-static inline void
-set_deny(u32 deny, struct nfs4_ol_stateid *stp)
-{
-	unsigned char mask = 1 << deny;
-
-	WARN_ON_ONCE(deny > NFS4_SHARE_DENY_BOTH);
-	stp->st_deny_bmap |= mask;
-}
-
-/* clear share deny for a given stateid */
-static inline void
-clear_deny(u32 deny, struct nfs4_ol_stateid *stp)
-{
-	unsigned char mask = 1 << deny;
-
-	WARN_ON_ONCE(deny > NFS4_SHARE_DENY_BOTH);
-	stp->st_deny_bmap &= ~mask;
-}
-
-/* test whether a given stateid is denying specific access */
-static inline bool
-test_deny(u32 deny, struct nfs4_ol_stateid *stp)
-{
-	unsigned char mask = 1 << deny;
-
-	return (bool)(stp->st_deny_bmap & mask);
-}
-
-static int nfs4_access_to_omode(u32 access)
-{
-	switch (access & NFS4_SHARE_ACCESS_BOTH) {
-	case NFS4_SHARE_ACCESS_READ:
-		return O_RDONLY;
-	case NFS4_SHARE_ACCESS_WRITE:
-		return O_WRONLY;
-	case NFS4_SHARE_ACCESS_BOTH:
-		return O_RDWR;
-	}
-	WARN_ON_ONCE(1);
-	return O_RDONLY;
-}
-
 /*
  * A stateid that had a deny mode associated with it is being released
  * or downgraded. Recalculate the deny mode on the file.
@@ -5507,21 +5522,6 @@ static inline __be32 nfs4_check_fh(struct svc_fh *fhp, struct nfs4_stid *stp)
 	return nfs_ok;
 }
 
-static inline int
-access_permit_read(struct nfs4_ol_stateid *stp)
-{
-	return test_access(NFS4_SHARE_ACCESS_READ, stp) ||
-		test_access(NFS4_SHARE_ACCESS_BOTH, stp) ||
-		test_access(NFS4_SHARE_ACCESS_WRITE, stp);
-}
-
-static inline int
-access_permit_write(struct nfs4_ol_stateid *stp)
-{
-	return test_access(NFS4_SHARE_ACCESS_WRITE, stp) ||
-		test_access(NFS4_SHARE_ACCESS_BOTH, stp);
-}
-
 static
 __be32 nfs4_check_openmode(struct nfs4_ol_stateid *stp, int flags)
 {
-- 
2.30.2

