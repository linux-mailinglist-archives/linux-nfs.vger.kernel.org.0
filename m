Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C487C9A53
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Oct 2023 19:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjJOR3c (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 15 Oct 2023 13:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJOR3c (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 15 Oct 2023 13:29:32 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0754EB7
        for <linux-nfs@vger.kernel.org>; Sun, 15 Oct 2023 10:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=vk33ABiurXn21cNplHE1J6yGulBfdZZA6vrX/5WfZAs=; b=b+f5J+eVc52B1dVMY5QBD0S4th
        CD5EyFkKTu+pnkBp1VtsZYes/keFOvjV9WahtBOXAkdUgsqp7ON3t16uc2Ic8KVg7J1G83bOuEvlV
        TdOVln3LtcdfMr/XUihKw8VCfIXy7rbd92xXExGF2DvcbjSjSMAc6HQvXdOVcgJpbFN3nC5sDIPGO
        l+tAA2tLCTVXl1stH2AtciVtN8flwYFGSJll6PifpYdsipZP+UGw7OmX/245TYEa6zbK0QGVVTWZH
        to17AoaJ23aT28kihJ3Ya99CTkO38zpSO1AUK5noeorQyu0lFOFfszP2+AUkG0BYRDGg2vJ9Qon+D
        tsVysixw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qs4vf-001Vkc-1m
        for linux-nfs@vger.kernel.org;
        Sun, 15 Oct 2023 17:29:27 +0000
Date:   Sun, 15 Oct 2023 18:29:27 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: lock_rename() needs both directories to live on the
 same fs
Message-ID: <20231015172927.GE800259@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

... checking that after lock_rename() is too late.  Incidentally,
NFSv2 had no nfserr_xdev...

Fixes: aa387d6ce153 "nfsd: fix EXDEV checking in rename"
Cc: stable@vger.kernel.org # v3.9+
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

[in git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #nfsd-fix;
it's an immutable branch, please either pull from it or put that thing
into an immutable branch in your tree - there's a lock_rename-related
series in the making and I'd rather avoid mixing unrelated nfsd stuff
into it ;-/]

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 48260cf68fde..02f5fcaad03f 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1788,6 +1788,12 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	if (!flen || isdotent(fname, flen) || !tlen || isdotent(tname, tlen))
 		goto out;
 
+	err = (rqstp->rq_vers == 2) ? nfserr_acces : nfserr_xdev;
+	if (ffhp->fh_export->ex_path.mnt != tfhp->fh_export->ex_path.mnt)
+		goto out;
+	if (ffhp->fh_export->ex_path.dentry != tfhp->fh_export->ex_path.dentry)
+		goto out;
+
 retry:
 	host_err = fh_want_write(ffhp);
 	if (host_err) {
@@ -1823,12 +1829,6 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	if (ndentry == trap)
 		goto out_dput_new;
 
-	host_err = -EXDEV;
-	if (ffhp->fh_export->ex_path.mnt != tfhp->fh_export->ex_path.mnt)
-		goto out_dput_new;
-	if (ffhp->fh_export->ex_path.dentry != tfhp->fh_export->ex_path.dentry)
-		goto out_dput_new;
-
 	if ((ndentry->d_sb->s_export_op->flags & EXPORT_OP_CLOSE_BEFORE_UNLINK) &&
 	    nfsd_has_cached_files(ndentry)) {
 		close_cached = true;
