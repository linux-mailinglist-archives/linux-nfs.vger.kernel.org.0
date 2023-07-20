Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3DD75B69F
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jul 2023 20:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjGTSXj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jul 2023 14:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjGTSXi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Jul 2023 14:23:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605F8273F;
        Thu, 20 Jul 2023 11:23:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C978961BD5;
        Thu, 20 Jul 2023 18:23:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7752CC433CA;
        Thu, 20 Jul 2023 18:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689877412;
        bh=MpDXGMwFBXEpaV59o0Rv1SAVOwm2OqsKMirDmQoSypo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=WwHyGrzS1jPbczJ0SssR7/Pmj/TGc5+byNHWiIC1fwH0I/kfVHjwF8F5+z8W0sLmk
         ZGWpYKphZLgtq738a/Ip0fPPFpRd4nhmVpmyR6qnmQElK8oJdY3hl1F8MhZNQKzdwF
         fRuK9vevGLfBhgTn+fzUrkTso/KVTgPxl2L90xRBT0VEbmftQtNxdecBfqL/nTGk5l
         igt4MCjBcrk7Vupy3doyl/qGnJBoTi/078zfnlMGp0L8eZvXxiwhJS7B7wnNVSJSpI
         Enfgx4wOhzPeQpMbnHxnmeNENHLI4E6lA/dLdzNiYWkZ+4c59HURMK0aleqXapaF+X
         yjAP7+FzzojEA==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Thu, 20 Jul 2023 14:23:20 -0400
Subject: [PATCH v2 1/2] nfsd: handle failure to collect pre/post-op attrs
 more sanely
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230720-bz2223560-v2-1-070aaf2660b7@kernel.org>
References: <20230720-bz2223560-v2-0-070aaf2660b7@kernel.org>
In-Reply-To: <20230720-bz2223560-v2-0-070aaf2660b7@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc:     Boyang Xue <bxue@redhat.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9824; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=MpDXGMwFBXEpaV59o0Rv1SAVOwm2OqsKMirDmQoSypo=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBkuXui31AYQooFJSRkTLLu2f6PTMrDpMpAs46VR
 LoHW6sn4PKJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZLl7ogAKCRAADmhBGVaC
 FRFnEACqlB5TzpELItUujqXhmPXFXUxZ62B8i/1SzhQe66UnHyCfkY5qS8RO1FFQvBgWDvncYOj
 oNk26GbYlHVCCNIzodEmoof0VnGTNDOjbkZc626oVOdKMUsANDWpcL4/eiWPJtYh44R9/3mpeM8
 VcNkPqzTg7mZL7b1Rj3XUcFz/JUcyLBkT/rdq2cVs9gscoDG/Zc4FxuSKrhkmJVoiLoha6Aa9Fw
 AOCrbpfUvmAVVJX+8V92uX+ZYNj4O7cM4ZkOgqSSTr0dLVslUF8Yz+dhoZyWZeXU/EN0lCJFQn7
 VBgyVKSigbyNVpyjVwNNfpifFprp1Ecn9t8j+YQ9nScl1vVtbYz5WN+QI3Bpyb3Nn8ZT1gFFviw
 AlUl5CL2iVU3zsRPlbVCb/36klQAHuQLpabzPzAudrWYK4E+R1z0zpFwJudWMnVwkaDmkW1eLGN
 GqiHlIXmxHv+xri6RX08PFRHl5UslHfamW7SKzbhHkS+ZJ9VASO0x5yH8KCYaFaumekwIhQrC48
 PArQRmyfCvIK/dmcbs/5x/WkvsKKjmMK1GUYBmRDf2lWOP2UBoNRK2QQKVdKP4XDEr3OK7zO9Qh
 lVWJHp27jbfKH5yoB+DikSZz1RWQ+ttjL+QM3UhebCquHfiDylXmvuE6LFw0EOpzhYqXaZnkw6V
 qWVnPfzO30vinxA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Collecting pre_op_attrs can fail, in which case it's probably best to
fail the whole operation.

Change fh_fill_{pre,post,both}_attrs to return __be32. For the pre and
both functions, have the callers check the return code and abort the
operation if it failed.

If fh_fill_post_attrs fails, then it's too late to do anything about it,
so most of those callers ignore the return value. If this happens, then
fh_post_saved will be false, which should cue the later stages to deal
with it.

Suggested-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs3proc.c |  4 +++-
 fs/nfsd/nfs4proc.c | 14 ++++++------
 fs/nfsd/nfsfh.c    | 26 ++++++++++++++---------
 fs/nfsd/nfsfh.h    |  6 +++---
 fs/nfsd/vfs.c      | 62 ++++++++++++++++++++++++++++++++++--------------------
 5 files changed, 69 insertions(+), 43 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index fc8d5b7db9f8..268ef57751c4 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -307,7 +307,9 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (!IS_POSIXACL(inode))
 		iap->ia_mode &= ~current_umask();
 
-	fh_fill_pre_attrs(fhp);
+	status = fh_fill_pre_attrs(fhp);
+	if (status != nfs_ok)
+		goto out;
 	host_err = vfs_create(&nop_mnt_idmap, inode, child, iap->ia_mode, true);
 	if (host_err < 0) {
 		status = nfserrno(host_err);
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index d8e7a533f9d2..9285e1eab4d5 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -297,12 +297,12 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	}
 
 	if (d_really_is_positive(child)) {
-		status = nfs_ok;
-
 		/* NFSv4 protocol requires change attributes even though
 		 * no change happened.
 		 */
-		fh_fill_both_attrs(fhp);
+		status = fh_fill_both_attrs(fhp);
+		if (status != nfs_ok)
+			goto out;
 
 		switch (open->op_createmode) {
 		case NFS4_CREATE_UNCHECKED:
@@ -345,7 +345,9 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (!IS_POSIXACL(inode))
 		iap->ia_mode &= ~current_umask();
 
-	fh_fill_pre_attrs(fhp);
+	status = fh_fill_pre_attrs(fhp);
+	if (status != nfs_ok)
+		goto out;
 	status = nfsd4_vfs_create(fhp, child, open);
 	if (status != nfs_ok)
 		goto out;
@@ -424,11 +426,11 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, stru
 	} else {
 		status = nfsd_lookup(rqstp, current_fh,
 				     open->op_fname, open->op_fnamelen, *resfh);
-		if (!status)
+		if (status == nfs_ok)
 			/* NFSv4 protocol requires change attributes even though
 			 * no change happened.
 			 */
-			fh_fill_both_attrs(current_fh);
+			status = fh_fill_both_attrs(current_fh);
 	}
 	if (status)
 		goto out;
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index c291389a1d71..f7e68a91e826 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -614,7 +614,7 @@ fh_update(struct svc_fh *fhp)
  * @fhp: file handle to be updated
  *
  */
-void fh_fill_pre_attrs(struct svc_fh *fhp)
+__be32 fh_fill_pre_attrs(struct svc_fh *fhp)
 {
 	bool v4 = (fhp->fh_maxsize == NFS4_FHSIZE);
 	struct inode *inode;
@@ -622,12 +622,12 @@ void fh_fill_pre_attrs(struct svc_fh *fhp)
 	__be32 err;
 
 	if (fhp->fh_no_wcc || fhp->fh_pre_saved)
-		return;
+		return nfs_ok;
 
 	inode = d_inode(fhp->fh_dentry);
 	err = fh_getattr(fhp, &stat);
 	if (err)
-		return;
+		return err;
 
 	if (v4)
 		fhp->fh_pre_change = nfsd4_change_attribute(&stat, inode);
@@ -636,6 +636,7 @@ void fh_fill_pre_attrs(struct svc_fh *fhp)
 	fhp->fh_pre_ctime = stat.ctime;
 	fhp->fh_pre_size  = stat.size;
 	fhp->fh_pre_saved = true;
+	return nfs_ok;
 }
 
 /**
@@ -643,26 +644,27 @@ void fh_fill_pre_attrs(struct svc_fh *fhp)
  * @fhp: file handle to be updated
  *
  */
-void fh_fill_post_attrs(struct svc_fh *fhp)
+__be32 fh_fill_post_attrs(struct svc_fh *fhp)
 {
 	bool v4 = (fhp->fh_maxsize == NFS4_FHSIZE);
 	struct inode *inode = d_inode(fhp->fh_dentry);
 	__be32 err;
 
 	if (fhp->fh_no_wcc)
-		return;
+		return nfs_ok;
 
 	if (fhp->fh_post_saved)
 		printk("nfsd: inode locked twice during operation.\n");
 
 	err = fh_getattr(fhp, &fhp->fh_post_attr);
 	if (err)
-		return;
+		return err;
 
 	fhp->fh_post_saved = true;
 	if (v4)
 		fhp->fh_post_change =
 			nfsd4_change_attribute(&fhp->fh_post_attr, inode);
+	return nfs_ok;
 }
 
 /**
@@ -672,16 +674,20 @@ void fh_fill_post_attrs(struct svc_fh *fhp)
  * This is used when the directory wasn't changed, but wcc attributes
  * are needed anyway.
  */
-void fh_fill_both_attrs(struct svc_fh *fhp)
+__be32 fh_fill_both_attrs(struct svc_fh *fhp)
 {
-	fh_fill_post_attrs(fhp);
-	if (!fhp->fh_post_saved)
-		return;
+	__be32 err;
+
+	err = fh_fill_post_attrs(fhp);
+	if (err)
+		return err;
+
 	fhp->fh_pre_change = fhp->fh_post_change;
 	fhp->fh_pre_mtime = fhp->fh_post_attr.mtime;
 	fhp->fh_pre_ctime = fhp->fh_post_attr.ctime;
 	fhp->fh_pre_size = fhp->fh_post_attr.size;
 	fhp->fh_pre_saved = true;
+	return nfs_ok;
 }
 
 /*
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 4e0ecf0ae2cf..486803694acc 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -294,7 +294,7 @@ static inline void fh_clear_pre_post_attrs(struct svc_fh *fhp)
 }
 
 u64 nfsd4_change_attribute(struct kstat *stat, struct inode *inode);
-extern void fh_fill_pre_attrs(struct svc_fh *fhp);
-extern void fh_fill_post_attrs(struct svc_fh *fhp);
-extern void fh_fill_both_attrs(struct svc_fh *fhp);
+__be32 fh_fill_pre_attrs(struct svc_fh *fhp);
+__be32 fh_fill_post_attrs(struct svc_fh *fhp);
+__be32 fh_fill_both_attrs(struct svc_fh *fhp);
 #endif /* _LINUX_NFSD_NFSFH_H */
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 8a2321d19194..f200afd33630 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1537,9 +1537,11 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	dput(dchild);
 	if (err)
 		goto out_unlock;
-	fh_fill_pre_attrs(fhp);
-	err = nfsd_create_locked(rqstp, fhp, attrs, type, rdev, resfhp);
-	fh_fill_post_attrs(fhp);
+	err = fh_fill_pre_attrs(fhp);
+	if (err == nfs_ok) {
+		err = nfsd_create_locked(rqstp, fhp, attrs, type, rdev, resfhp);
+		fh_fill_post_attrs(fhp);
+	}
 out_unlock:
 	inode_unlock(dentry->d_inode);
 	return err;
@@ -1632,13 +1634,16 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		inode_unlock(dentry->d_inode);
 		goto out_drop_write;
 	}
-	fh_fill_pre_attrs(fhp);
+	err = fh_fill_pre_attrs(fhp);
+	if (err)
+		goto out_unlock;
 	host_err = vfs_symlink(&nop_mnt_idmap, d_inode(dentry), dnew, path);
 	err = nfserrno(host_err);
 	cerr = fh_compose(resfhp, fhp->fh_export, dnew, fhp);
 	if (!err)
 		nfsd_create_setattr(rqstp, fhp, resfhp, attrs);
 	fh_fill_post_attrs(fhp);
+out_unlock:
 	inode_unlock(dentry->d_inode);
 	if (!err)
 		err = nfserrno(commit_metadata(fhp));
@@ -1700,7 +1705,9 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 	err = nfserr_noent;
 	if (d_really_is_negative(dold))
 		goto out_dput;
-	fh_fill_pre_attrs(ffhp);
+	err = fh_fill_pre_attrs(ffhp);
+	if (err != nfs_ok)
+		goto out_dput;
 	host_err = vfs_link(dold, &nop_mnt_idmap, dirp, dnew, NULL);
 	fh_fill_post_attrs(ffhp);
 	inode_unlock(dirp);
@@ -1786,8 +1793,12 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	}
 
 	trap = lock_rename(tdentry, fdentry);
-	fh_fill_pre_attrs(ffhp);
-	fh_fill_pre_attrs(tfhp);
+	err = fh_fill_pre_attrs(ffhp);
+	if (err != nfs_ok)
+		goto out_unlock;
+	err = fh_fill_pre_attrs(tfhp);
+	if (err != nfs_ok)
+		goto out_unlock;
 
 	odentry = lookup_one_len(fname, fdentry, flen);
 	host_err = PTR_ERR(odentry);
@@ -1854,6 +1865,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 		fh_fill_post_attrs(ffhp);
 		fh_fill_post_attrs(tfhp);
 	}
+out_unlock:
 	unlock_rename(tdentry, fdentry);
 	fh_drop_write(ffhp);
 
@@ -1913,12 +1925,14 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 		goto out_unlock;
 	}
 	rinode = d_inode(rdentry);
-	ihold(rinode);
+	err = fh_fill_pre_attrs(fhp);
+	if (err != nfs_ok)
+		goto out_unlock;
 
+	ihold(rinode);
 	if (!type)
 		type = d_inode(rdentry)->i_mode & S_IFMT;
 
-	fh_fill_pre_attrs(fhp);
 	if (type != S_IFDIR) {
 		int retries;
 
@@ -2338,16 +2352,17 @@ nfsd_removexattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name)
 		return nfserrno(ret);
 
 	inode_lock(fhp->fh_dentry->d_inode);
-	fh_fill_pre_attrs(fhp);
-
-	ret = __vfs_removexattr_locked(&nop_mnt_idmap, fhp->fh_dentry,
-				       name, NULL);
-
-	fh_fill_post_attrs(fhp);
+	err = fh_fill_pre_attrs(fhp);
+	if (err == nfs_ok) {
+		ret = __vfs_removexattr_locked(&nop_mnt_idmap, fhp->fh_dentry,
+					       name, NULL);
+		err = nfsd_xattr_errno(ret);
+		fh_fill_post_attrs(fhp);
+	}
 	inode_unlock(fhp->fh_dentry->d_inode);
 	fh_drop_write(fhp);
 
-	return nfsd_xattr_errno(ret);
+	return err;
 }
 
 __be32
@@ -2365,15 +2380,16 @@ nfsd_setxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name,
 	if (ret)
 		return nfserrno(ret);
 	inode_lock(fhp->fh_dentry->d_inode);
-	fh_fill_pre_attrs(fhp);
-
-	ret = __vfs_setxattr_locked(&nop_mnt_idmap, fhp->fh_dentry, name, buf,
-				    len, flags, NULL);
-	fh_fill_post_attrs(fhp);
+	err = fh_fill_pre_attrs(fhp);
+	if (err != nfs_ok) {
+		ret = __vfs_setxattr_locked(&nop_mnt_idmap, fhp->fh_dentry,
+					    name, buf, len, flags, NULL);
+		fh_fill_post_attrs(fhp);
+		err = nfsd_xattr_errno(ret);
+	}
 	inode_unlock(fhp->fh_dentry->d_inode);
 	fh_drop_write(fhp);
-
-	return nfsd_xattr_errno(ret);
+	return err;
 }
 #endif
 

-- 
2.41.0

