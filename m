Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3E5481432
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Dec 2021 15:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240332AbhL2OqB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Dec 2021 09:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236856AbhL2OqB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Dec 2021 09:46:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E44EC061574
        for <linux-nfs@vger.kernel.org>; Wed, 29 Dec 2021 06:46:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F1F5614F0
        for <linux-nfs@vger.kernel.org>; Wed, 29 Dec 2021 14:46:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B64CC36AEC
        for <linux-nfs@vger.kernel.org>; Wed, 29 Dec 2021 14:46:00 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] Revert "nfsd: skip some unnecessary stats in the v4 case"
Date:   Wed, 29 Dec 2021 09:45:59 -0500
Message-Id:  <164078915929.2414.5538230170152935284.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To:  <164078891040.2414.11995954842150988952.stgit@bazille.1015granger.net>
References:  <164078891040.2414.11995954842150988952.stgit@bazille.1015granger.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=4313; h=from:subject:message-id; bh=kW+WuBTmpoa721naxfjBVZlQrYJ5Hw0gTfliMhtbH4M=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBhzHSnPyEg6+KuXHBls0XzUCPHGC4WJArHxTv2eOz5 a5b51QWJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYcx0pwAKCRAzarMzb2Z/l5DhD/ 447dywFys5dyNl8EisUdRytNUEThLA17NBDuYU8VPDsi3ieUhfdPF1C8f7A+efnPITFabDX8bPuemU rb7cz1BBP1P7Hh6z37yiIQhzfDjphu+kb2WNh/2jDFbXrE1FB4jc42LNowLmQOD/lRrG8dqvHHWNDG c7ROgB5p5CxLgCFEF2kIZqAJ/KhqxNXJ1rl7z5IJikCd4+NHlhpLuYg4xieW39X9eYLx6JIYcy2Cp2 IPRVbEwKPOcXbJlKFkBm3uP8WSqikm9WNqXZmzr5tSMEf3h4OFQ6zjpzYw/N6JButeRB+7ey0jYMzl jQhuHVhyfVmghbRgq4ZsO7EZPZFgWH0m7Yyn/OnoHkNOwD90+YmliinMTNBoOopTMIIkAoGnHj+1dV pKxrn9xwwkayrPJEpdl3+5MtOE4Lj1asD5KX8wNhj1/4znwJhpc6JXey6bfWCpj7ORMd7XF+f96rWn mO+uji7eY7suqFUqf2fZoiwuSLP8bFLO4gbWFxz1ATO1aOi1REN+P5n3cYnDp4gGlJLgvEkCuq5cVb r8NeErY1NL26xalc/izDjZVAFUFdJTpLG7bj6lMfXLYSVHHizq0zgptsE5ZSW8AU5KDZEOe49FoBMt JbN6sAMre04B9es2gX/MTHDTbvuOTV8TcC3BUxvf/a+MsjEKZ7NB+hms6DwA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On the wire, I observed NFSv4 OPEN(CREATE) operations sometimes
returning a reasonable-looking value in the cinfo.before field and
zero in the cinfo.after field.

RFC 8881 Section 10.8.1 says:
> When a client is making changes to a given directory, it needs to
> determine whether there have been changes made to the directory by
> other clients.  It does this by using the change attribute as
> reported before and after the directory operation in the associated
> change_info4 value returned for the operation.

and

> ... The post-operation change
> value needs to be saved as the basis for future change_info4
> comparisons.

A good quality client implementation therefore saves the zero
cinfo.after value. During a subsequent OPEN operation, it will
receive a different non-zero value in the cinfo.before field for
that directory, and it will incorrectly believe the directory has
changed, triggering an undesirable directory cache invalidation.

There are filesystem types where fs_supports_change_attribute()
returns false, tmpfs being one. On NFSv4 mounts, this means the
fh_getattr() call site in fill_pre_wcc() and fill_post_wcc() is
never invoked. Subsequently, nfsd4_change_attribute() is invoked
with an uninitialized @stat argument.

In fill_pre_wcc(), @stat contains stale stack garbage, which is
then placed on the wire. In fill_post_wcc(), ->fh_post_wc is all
zeroes, so zero is placed on the wire. Both of these values are
meaningless.

This fix can be applied immediately to stable kernels. Once there
are more regression tests in this area, this optimization can be
attempted again.

Fixes: 428a23d2bf0c ("nfsd: skip some unnecessary stats in the v4 case")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3xdr.c |   44 +++++++++++++++++---------------------------
 1 file changed, 17 insertions(+), 27 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index c3ac1b6aa3aa..84088581bbe0 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -487,11 +487,6 @@ svcxdr_encode_wcc_data(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	return true;
 }
 
-static bool fs_supports_change_attribute(struct super_block *sb)
-{
-	return sb->s_flags & SB_I_VERSION || sb->s_export_op->fetch_iversion;
-}
-
 /*
  * Fill in the pre_op attr for the wcc data
  */
@@ -500,26 +495,24 @@ void fill_pre_wcc(struct svc_fh *fhp)
 	struct inode    *inode;
 	struct kstat	stat;
 	bool v4 = (fhp->fh_maxsize == NFS4_FHSIZE);
+	__be32 err;
 
 	if (fhp->fh_no_wcc || fhp->fh_pre_saved)
 		return;
 	inode = d_inode(fhp->fh_dentry);
-	if (fs_supports_change_attribute(inode->i_sb) || !v4) {
-		__be32 err = fh_getattr(fhp, &stat);
-
-		if (err) {
-			/* Grab the times from inode anyway */
-			stat.mtime = inode->i_mtime;
-			stat.ctime = inode->i_ctime;
-			stat.size  = inode->i_size;
-		}
-		fhp->fh_pre_mtime = stat.mtime;
-		fhp->fh_pre_ctime = stat.ctime;
-		fhp->fh_pre_size  = stat.size;
+	err = fh_getattr(fhp, &stat);
+	if (err) {
+		/* Grab the times from inode anyway */
+		stat.mtime = inode->i_mtime;
+		stat.ctime = inode->i_ctime;
+		stat.size  = inode->i_size;
 	}
 	if (v4)
 		fhp->fh_pre_change = nfsd4_change_attribute(&stat, inode);
 
+	fhp->fh_pre_mtime = stat.mtime;
+	fhp->fh_pre_ctime = stat.ctime;
+	fhp->fh_pre_size  = stat.size;
 	fhp->fh_pre_saved = true;
 }
 
@@ -530,6 +523,7 @@ void fill_post_wcc(struct svc_fh *fhp)
 {
 	bool v4 = (fhp->fh_maxsize == NFS4_FHSIZE);
 	struct inode *inode = d_inode(fhp->fh_dentry);
+	__be32 err;
 
 	if (fhp->fh_no_wcc)
 		return;
@@ -537,16 +531,12 @@ void fill_post_wcc(struct svc_fh *fhp)
 	if (fhp->fh_post_saved)
 		printk("nfsd: inode locked twice during operation.\n");
 
-	fhp->fh_post_saved = true;
-
-	if (fs_supports_change_attribute(inode->i_sb) || !v4) {
-		__be32 err = fh_getattr(fhp, &fhp->fh_post_attr);
-
-		if (err) {
-			fhp->fh_post_saved = false;
-			fhp->fh_post_attr.ctime = inode->i_ctime;
-		}
-	}
+	err = fh_getattr(fhp, &fhp->fh_post_attr);
+	if (err) {
+		fhp->fh_post_saved = false;
+		fhp->fh_post_attr.ctime = inode->i_ctime;
+	} else
+		fhp->fh_post_saved = true;
 	if (v4)
 		fhp->fh_post_change =
 			nfsd4_change_attribute(&fhp->fh_post_attr, inode);

