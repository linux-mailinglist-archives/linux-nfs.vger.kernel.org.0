Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05B05B125B
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Sep 2022 04:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiIHCIt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Sep 2022 22:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiIHCIr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Sep 2022 22:08:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0679A6B4
        for <linux-nfs@vger.kernel.org>; Wed,  7 Sep 2022 19:08:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3D71834360;
        Thu,  8 Sep 2022 02:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662602925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=bPLfOOe68eh88pjc1oFRBPnbrAFgPR4isLz78u+TjN0=;
        b=B/94qbZEsvkTIl1hleNVoLfiYUgNQtlZQLHnv/BMM9VcUHV2x2DGT6kxukP93BafxEA0JG
        g3D+48sa8O4Hp/coGz1k5oRnF95L4qdhfcZlLGO8ByeHoVtsk7cNGlxWDOm5MXiMbLgpdI
        5qEoBssGJncfjgdWY3ullVhl1UQnzxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662602925;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=bPLfOOe68eh88pjc1oFRBPnbrAFgPR4isLz78u+TjN0=;
        b=5zDvarY3zBAZPRy21y17dGxSgGY3h0AhU8Bnarj8cyHv0+4+eVcgCsTKuWgPey83XLNZG2
        nx1kMSb200jkFYCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 02B431322C;
        Thu,  8 Sep 2022 02:08:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id O3gVKqtOGWP2RQAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 08 Sep 2022 02:08:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Bruce Fields <bfields@fieldses.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [PATCH] NFSD: fix regression with setting ACLs.
Date:   Thu, 08 Sep 2022 12:08:40 +1000
Message-id: <166260292002.30452.4279820246560338475@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


A recent patch moved ACL setting into nfsd_setattr().
Unfortunately it didn't work as nfsd_setattr() aborts early if
iap->ia_valid is 0.

Remove this test, and instead avoid calling notify_change() when
ia_valid is 0.

This means that nfsd_setattr() will now *always* lock the inode.
Previously it didn't if only a ATTR_MODE change was requested on a
symlink (see Commit 15b7a1b86d66 ("[PATCH] knfsd: fix setattr-on-symlink
error return")). I don't think this change really matters.

Fixes: c0cbe70742f4 ("NFSD: add posix ACLs to struct nfsd_attrs")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/vfs.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 9f486b788ed0..bffb31540df8 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -353,7 +353,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	int		accmode = NFSD_MAY_SATTR;
 	umode_t		ftype = 0;
 	__be32		err;
-	int		host_err;
+	int		host_err = 0;
 	bool		get_write_count;
 	bool		size_change = (iap->ia_valid & ATTR_SIZE);
 
@@ -395,9 +395,6 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (S_ISLNK(inode->i_mode))
 		iap->ia_valid &= ~ATTR_MODE;
 
-	if (!iap->ia_valid)
-		return 0;
-
 	nfsd_sanitize_attrs(inode, iap);
 
 	if (check_guard && guardtime != inode->i_ctime.tv_sec)
@@ -448,8 +445,10 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			goto out_unlock;
 	}
 
-	iap->ia_valid |= ATTR_CTIME;
-	host_err = notify_change(&init_user_ns, dentry, iap, NULL);
+	if (iap->ia_valid) {
+		iap->ia_valid |= ATTR_CTIME;
+		host_err = notify_change(&init_user_ns, dentry, iap, NULL);
+	}
 
 out_unlock:
 	if (attr->na_seclabel && attr->na_seclabel->len)
-- 
2.37.1

