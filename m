Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC045B2918
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Sep 2022 00:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiIHWOL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Sep 2022 18:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiIHWOK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 8 Sep 2022 18:14:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280D01098CE
        for <linux-nfs@vger.kernel.org>; Thu,  8 Sep 2022 15:14:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1C0D61D99
        for <linux-nfs@vger.kernel.org>; Thu,  8 Sep 2022 22:14:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FFAC433C1
        for <linux-nfs@vger.kernel.org>; Thu,  8 Sep 2022 22:14:08 +0000 (UTC)
Subject: [PATCH v4 5/8] NFSD: Refactor nfsd_setattr()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Thu, 08 Sep 2022 18:14:07 -0400
Message-ID: <166267524713.1842.2388707630082157165.stgit@manet.1015granger.net>
In-Reply-To: <166267495153.1842.14474564029477470642.stgit@manet.1015granger.net>
References: <166267495153.1842.14474564029477470642.stgit@manet.1015granger.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Move code that will be retried (in a subsequent patch) into a helper
function.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c |   74 ++++++++++++++++++++++++++++++---------------------------
 1 file changed, 39 insertions(+), 35 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 9f486b788ed0..02f31d8c727a 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -339,6 +339,44 @@ nfsd_get_write_access(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	return nfserrno(get_write_access(inode));
 }
 
+static int __nfsd_setattr(struct dentry *dentry, struct iattr *iap)
+{
+	int host_err;
+
+	if (iap->ia_valid & ATTR_SIZE) {
+		/*
+		 * RFC5661, Section 18.30.4:
+		 *   Changing the size of a file with SETATTR indirectly
+		 *   changes the time_modify and change attributes.
+		 *
+		 * (and similar for the older RFCs)
+		 */
+		struct iattr size_attr = {
+			.ia_valid	= ATTR_SIZE | ATTR_CTIME | ATTR_MTIME,
+			.ia_size	= iap->ia_size,
+		};
+
+		if (iap->ia_size < 0)
+			return -EFBIG;
+
+		host_err = notify_change(&init_user_ns, dentry, &size_attr, NULL);
+		if (host_err)
+			return host_err;
+		iap->ia_valid &= ~ATTR_SIZE;
+
+		/*
+		 * Avoid the additional setattr call below if the only other
+		 * attribute that the client sends is the mtime, as we update
+		 * it as part of the size change above.
+		 */
+		if ((iap->ia_valid & ~ATTR_MTIME) == 0)
+			return 0;
+	}
+
+	iap->ia_valid |= ATTR_CTIME;
+	return notify_change(&init_user_ns, dentry, iap, NULL);
+}
+
 /*
  * Set various file attributes.  After this call fhp needs an fh_put.
  */
@@ -417,41 +455,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	}
 
 	inode_lock(inode);
-	if (size_change) {
-		/*
-		 * RFC5661, Section 18.30.4:
-		 *   Changing the size of a file with SETATTR indirectly
-		 *   changes the time_modify and change attributes.
-		 *
-		 * (and similar for the older RFCs)
-		 */
-		struct iattr size_attr = {
-			.ia_valid	= ATTR_SIZE | ATTR_CTIME | ATTR_MTIME,
-			.ia_size	= iap->ia_size,
-		};
-
-		host_err = -EFBIG;
-		if (iap->ia_size < 0)
-			goto out_unlock;
-
-		host_err = notify_change(&init_user_ns, dentry, &size_attr, NULL);
-		if (host_err)
-			goto out_unlock;
-		iap->ia_valid &= ~ATTR_SIZE;
-
-		/*
-		 * Avoid the additional setattr call below if the only other
-		 * attribute that the client sends is the mtime, as we update
-		 * it as part of the size change above.
-		 */
-		if ((iap->ia_valid & ~ATTR_MTIME) == 0)
-			goto out_unlock;
-	}
-
-	iap->ia_valid |= ATTR_CTIME;
-	host_err = notify_change(&init_user_ns, dentry, iap, NULL);
-
-out_unlock:
+	host_err = __nfsd_setattr(dentry, iap);
 	if (attr->na_seclabel && attr->na_seclabel->len)
 		attr->na_labelerr = security_inode_setsecctx(dentry,
 			attr->na_seclabel->data, attr->na_seclabel->len);


