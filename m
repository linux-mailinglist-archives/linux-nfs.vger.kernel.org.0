Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620562C45D8
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Nov 2020 17:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732478AbgKYQrk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Nov 2020 11:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732473AbgKYQrk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Nov 2020 11:47:40 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6002DC0613D4
        for <linux-nfs@vger.kernel.org>; Wed, 25 Nov 2020 08:47:40 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 5FEB86EAD; Wed, 25 Nov 2020 11:47:38 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 5FEB86EAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1606322858;
        bh=79iQY6MryolhzKzOdz+x69Dy3Pn5pciH3/wt+E1DSFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y7+XaoF1Hhu4vgU27ihJpiQvcBD8Sj7A74qYwRShJ06uq19WIkLZU+yv7o/gcLvNu
         I1e6CHzN4y/EUvEvPaQ1Ii2DCnkT5BxsGnNTsqWVF4o1bHgqv1QpwXjxuxwrDSB6hW
         yckMN9g7LU9jV6GygE7j6vf5tZbZ/EaHFRRbJhMQ=
Date:   Wed, 25 Nov 2020 11:47:38 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: nfsd: skip some unnecessary stats in the v4 case
Message-ID: <20201125164738.GA7049@fieldses.org>
References: <de7dc4f1-cbf2-6bcd-1466-d67b418dcc5f@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de7dc4f1-cbf2-6bcd-1466-d67b418dcc5f@canonical.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Nov 25, 2020 at 02:50:51PM +0000, Colin Ian King wrote:
> Static analysis on today's linux-next has found an issue with the
> following commit:

Thanks!  I'll probably do something like this.

Though this still all seems slightly more complicated than necessary.

--b.

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 8502a493be6d..7eb761801169 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -260,13 +260,12 @@ void fill_pre_wcc(struct svc_fh *fhp)
 	struct inode    *inode;
 	struct kstat	stat;
 	bool v4 = (fhp->fh_maxsize == NFS4_FHSIZE);
-	__be32 err;
 
 	if (fhp->fh_pre_saved)
 		return;
 	inode = d_inode(fhp->fh_dentry);
 	if (!v4 || !inode->i_sb->s_export_op->fetch_iversion) {
-		err = fh_getattr(fhp, &stat);
+		__be32 err = fh_getattr(fhp, &stat);
 		if (err) {
 			/* Grab the times from inode anyway */
 			stat.mtime = inode->i_mtime;
@@ -290,23 +289,23 @@ void fill_post_wcc(struct svc_fh *fhp)
 {
 	bool v4 = (fhp->fh_maxsize == NFS4_FHSIZE);
 	struct inode *inode = d_inode(fhp->fh_dentry);
-	__be32 err;
 
 	if (fhp->fh_post_saved)
 		printk("nfsd: inode locked twice during operation.\n");
 
+	fhp->fh_post_saved = true;
 
-	if (!v4 || !inode->i_sb->s_export_op->fetch_iversion)
-		err = fh_getattr(fhp, &fhp->fh_post_attr);
+	if (!v4 || !inode->i_sb->s_export_op->fetch_iversion) {
+		__be32 err = fh_getattr(fhp, &fhp->fh_post_attr);
+		if (err) {
+			fhp->fh_post_saved = false;
+			/* set_change_info might still need this: */
+			fhp->fh_post_attr.ctime = inode->i_ctime;
+		}
+	}
 	if (v4)
 		fhp->fh_post_change =
 			nfsd4_change_attribute(&fhp->fh_post_attr, inode);
-	if (err) {
-		fhp->fh_post_saved = false;
-		/* Grab the ctime anyway - set_change_info might use it */
-		fhp->fh_post_attr.ctime = inode->i_ctime;
-	} else
-		fhp->fh_post_saved = true;
 }
 
 /*
