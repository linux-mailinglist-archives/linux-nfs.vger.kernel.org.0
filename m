Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8428A2BB92C
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 23:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgKTWjY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 17:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728902AbgKTWjX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 17:39:23 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032B1C061A4A
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 14:39:22 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 6EB4B6E9B; Fri, 20 Nov 2020 17:39:22 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 6EB4B6E9B
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 8/8] Revert "nfsd4: support change_attr_type attribute"
Date:   Fri, 20 Nov 2020 17:39:20 -0500
Message-Id: <1605911960-12516-8-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1605911960-12516-1-git-send-email-bfields@redhat.com>
References: <20201120223831.GB7705@fieldses.org>
 <1605911960-12516-1-git-send-email-bfields@redhat.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

This reverts commit a85857633b04d57f4524cca0a2bfaf87b2543f9f.

We're still factoring ctime into our change attribute even in the
IS_I_VERSION case.  If someone sets the system time backwards, a client
could see the change attribute go backwards.  Maybe we can just say
"well, don't do that", but there's some question whether that's good
enough, or whether we need a better guarantee.

Also, the client still isn't actually using the attribute.

While we're still figuring this out, let's just stop returning this
attribute.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4xdr.c    | 10 ----------
 fs/nfsd/nfsd.h       |  1 -
 include/linux/nfs4.h |  8 --------
 3 files changed, 19 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 182190684792..c33838caf8c6 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3183,16 +3183,6 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 
-	if (bmval2 & FATTR4_WORD2_CHANGE_ATTR_TYPE) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		if (IS_I_VERSION(d_inode(dentry))
-			*p++ = cpu_to_be32(NFS4_CHANGE_TYPE_IS_MONOTONIC_INCR);
-		else
-			*p++ = cpu_to_be32(NFS4_CHANGE_TYPE_IS_TIME_METADATA);
-	}
-
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 	if (bmval2 & FATTR4_WORD2_SECURITY_LABEL) {
 		status = nfsd4_encode_security_label(xdr, rqstp, context,
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index cb742e17e04a..40cb40ac0a65 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -387,7 +387,6 @@ void		nfsd_lockd_shutdown(void);
 
 #define NFSD4_2_SUPPORTED_ATTRS_WORD2 \
 	(NFSD4_1_SUPPORTED_ATTRS_WORD2 | \
-	FATTR4_WORD2_CHANGE_ATTR_TYPE | \
 	FATTR4_WORD2_MODE_UMASK | \
 	NFSD4_2_SECURITY_ATTRS | \
 	FATTR4_WORD2_XATTR_SUPPORT)
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 9dc7eeac924f..5b4c67c91f56 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -385,13 +385,6 @@ enum lock_type4 {
 	NFS4_WRITEW_LT = 4
 };
 
-enum change_attr_type4 {
-	NFS4_CHANGE_TYPE_IS_MONOTONIC_INCR = 0,
-	NFS4_CHANGE_TYPE_IS_VERSION_COUNTER = 1,
-	NFS4_CHANGE_TYPE_IS_VERSION_COUNTER_NOPNFS = 2,
-	NFS4_CHANGE_TYPE_IS_TIME_METADATA = 3,
-	NFS4_CHANGE_TYPE_IS_UNDEFINED = 4
-};
 
 /* Mandatory Attributes */
 #define FATTR4_WORD0_SUPPORTED_ATTRS    (1UL << 0)
@@ -459,7 +452,6 @@ enum change_attr_type4 {
 #define FATTR4_WORD2_LAYOUT_BLKSIZE     (1UL << 1)
 #define FATTR4_WORD2_MDSTHRESHOLD       (1UL << 4)
 #define FATTR4_WORD2_CLONE_BLKSIZE	(1UL << 13)
-#define FATTR4_WORD2_CHANGE_ATTR_TYPE	(1UL << 15)
 #define FATTR4_WORD2_SECURITY_LABEL     (1UL << 16)
 #define FATTR4_WORD2_MODE_UMASK		(1UL << 17)
 #define FATTR4_WORD2_XATTR_SUPPORT	(1UL << 18)
-- 
2.28.0

