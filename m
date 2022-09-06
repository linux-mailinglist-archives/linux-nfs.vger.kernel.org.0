Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3055ADCA1
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Sep 2022 02:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbiIFAma (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Sep 2022 20:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiIFAm3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 5 Sep 2022 20:42:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54AF6A49C
        for <linux-nfs@vger.kernel.org>; Mon,  5 Sep 2022 17:42:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ED9F01F8B9;
        Tue,  6 Sep 2022 00:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662424946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=kpyfGOcI7GuWmB12GKLPIynRogI8GCvFaQQyUOir/k8=;
        b=gQQJpsyxMzQwN5Zhnbf7AwHhCzTN+boJiUkrYjrtICF3c3Gtkdk1VYWXQUWxZGdCAE1a0R
        dKVkb1Gd+XxKZJHdS4jSBLyzkOfEbMQD8sWI20Gjdwd5UML7kBzQgDGevFdL3zeVRBsT96
        l47HW12dqEAvNSEEMGGt3gjY8LhYyrA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662424946;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=kpyfGOcI7GuWmB12GKLPIynRogI8GCvFaQQyUOir/k8=;
        b=1OkFZorZ1GCmY5+WEsQFcU6zMbNchk6Z2LyrCyLboD0zk1c8IKGYhQA5h2YRmLs9ebXLyG
        93K7DL1VI82EHRBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D6247139C7;
        Tue,  6 Sep 2022 00:42:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LepQJHGXFmOxNAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 06 Sep 2022 00:42:25 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [PATCH] NFSD: drop fname and flen args from nfsd_create_locked()
Date:   Tue, 06 Sep 2022 10:42:19 +1000
Message-id: <166242493965.1168.6227147868888984691@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


nfsd_create_locked() does not use the "fname" and "flen" arguments, so
drop them from declaration and all callers.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfsproc.c | 4 ++--
 fs/nfsd/vfs.c     | 4 ++--
 fs/nfsd/vfs.h     | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 7381972f1677..9c766ac2cc68 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -390,8 +390,8 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 	resp->status = nfs_ok;
 	if (!inode) {
 		/* File doesn't exist. Create it and set attrs */
-		resp->status = nfsd_create_locked(rqstp, dirfhp, argp->name,
-						  argp->len, &attrs, type, rdev,
+		resp->status = nfsd_create_locked(rqstp, dirfhp,
+						  &attrs, type, rdev,
 						  newfhp);
 	} else if (type == S_IFREG) {
 		dprintk("nfsd:   existing %s, valid=%x, size=%ld\n",
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 9f486b788ed0..528afc3be7af 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1252,7 +1252,7 @@ nfsd_check_ignore_resizing(struct iattr *iap)
 /* The parent directory should already be locked: */
 __be32
 nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
-		   char *fname, int flen, struct nfsd_attrs *attrs,
+		   struct nfsd_attrs *attrs,
 		   int type, dev_t rdev, struct svc_fh *resfhp)
 {
 	struct dentry	*dentry, *dchild;
@@ -1379,7 +1379,7 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (err)
 		goto out_unlock;
 	fh_fill_pre_attrs(fhp);
-	err = nfsd_create_locked(rqstp, fhp, fname, flen, attrs, type,
+	err = nfsd_create_locked(rqstp, fhp, attrs, type,
 				 rdev, resfhp);
 	fh_fill_post_attrs(fhp);
 out_unlock:
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index c95cd414b4bb..0bf5c7e79abe 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -79,7 +79,7 @@ __be32		nfsd4_clone_file_range(struct svc_rqst *rqstp,
 				       u64 count, bool sync);
 #endif /* CONFIG_NFSD_V4 */
 __be32		nfsd_create_locked(struct svc_rqst *, struct svc_fh *,
-				char *name, int len, struct nfsd_attrs *attrs,
+				struct nfsd_attrs *attrs,
 				int type, dev_t rdev, struct svc_fh *res);
 __be32		nfsd_create(struct svc_rqst *, struct svc_fh *,
 				char *name, int len, struct nfsd_attrs *attrs,
-- 
2.37.1

