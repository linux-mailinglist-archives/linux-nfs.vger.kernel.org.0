Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF16280ABC
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Oct 2020 01:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733278AbgJAXAU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Oct 2020 19:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733290AbgJAW76 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Oct 2020 18:59:58 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C03C0613D0
        for <linux-nfs@vger.kernel.org>; Thu,  1 Oct 2020 15:59:57 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id r8so629748qtp.13
        for <linux-nfs@vger.kernel.org>; Thu, 01 Oct 2020 15:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=BqSdJp1ueaEGZhSMspX0jNsZEEpeLgJTVAy+bITpD1o=;
        b=PINgVVEjianf6c0Svn71P2XPrfy0Nt49wkDwHIbAULxEHHC5rhgKnT/mpgcFO/vc3H
         Nq+pylQ6Hyzk98QTjX5CVvj5GXm/OdOEiOF2vmNXvkaakSKiUjr++wa0XvaIowE/gedr
         z4Td3l/3YUabYv5Y614dkTBm/92WHMBWDLvqSqoi/Dkm+GTGrazam9FpC8ScTCQKoBQZ
         5LQDPn14LI6uIelPFtbzOKpvFAJNGDanuRkO/qeUvtcQ7fQuSDrxv36IOsr1zYxk/4hF
         kN1IBOaJ1Mk/UVmj9lWXLAkGbjsj8EtYp7gv1UZR+HTgpK3YvSev+9Zu37gFKIe/iuYE
         JuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=BqSdJp1ueaEGZhSMspX0jNsZEEpeLgJTVAy+bITpD1o=;
        b=luscPP8QbMTcgPqBo5mxSsEQiWC4mdWNjdRI0MrxxcDp75YXBKt9ZSX2GeDwzfn7vy
         ZCM0fLn8xOKPHDYiT28FIPwMAWJGVqcJsYmvFbPbX1hFvtHjSFpzUZuct/vypC00ahtV
         Ac+KlBMQvzU4qX8MXMSR/mKMqEuUPWh9HJ6sMNBEJ5H4NXxZzz+mLg1BPrcWxkF7oq6Z
         qBzVt3bjxFr7hvYV1uvYSdmJ3AJhLgeLoB1sd/0d5SVjhUzq20+oulJXIfHU4V2XA55u
         7dzO1//80RqDspCNH0HqSsRxmfBwTovGPbxhjnMl7CNWnHpB7c7s27xmjo1c/to0TDEm
         soKw==
X-Gm-Message-State: AOAM533MTVcpvgnFIuhmH1rMvSrrb1QqrX3uW1JeSqF4/+AEshUZVRXp
        q+1qWw2AEmqBr9eSzNz/h95TMIfwHW0/KQ==
X-Google-Smtp-Source: ABdhPJzYtBnDQjmMOAGg4RGadi1TIccfTeKxs8ehoAOfwbLYrGpEtJVmiFBHZgauWgCTttP6dgsbGA==
X-Received: by 2002:ac8:140c:: with SMTP id k12mr10218835qtj.6.1601593196414;
        Thu, 01 Oct 2020 15:59:56 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id m97sm8718648qte.55.2020.10.01.15.59.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Oct 2020 15:59:55 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 091MxsES032601;
        Thu, 1 Oct 2020 22:59:54 GMT
Subject: [PATCH v3 13/15] NFSD: Remove the RETURN_STATUS() macro
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 01 Oct 2020 18:59:54 -0400
Message-ID: <160159319468.79253.8591580877265045371.stgit@klimt.1015granger.net>
In-Reply-To: <160159301676.79253.16488984581431975601.stgit@klimt.1015granger.net>
References: <160159301676.79253.16488984581431975601.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Refactor: I'm about to change the return value from .pc_func. Clear
the way by replacing the RETURN_STATUS() macro with logic that
plants the status code directly into the response structure.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3acl.c  |   33 ++++---
 fs/nfsd/nfs3proc.c |  235 +++++++++++++++++++++++++---------------------------
 2 files changed, 130 insertions(+), 138 deletions(-)

diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index 614168675c17..3fee24dee98c 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -13,8 +13,6 @@
 #include "xdr3.h"
 #include "vfs.h"
 
-#define RETURN_STATUS(st)	{ resp->status = (st); return (st); }
-
 /*
  * NULL call.
  */
@@ -34,17 +32,18 @@ static __be32 nfsd3_proc_getacl(struct svc_rqst *rqstp)
 	struct posix_acl *acl;
 	struct inode *inode;
 	svc_fh *fh;
-	__be32 nfserr = 0;
 
 	fh = fh_copy(&resp->fh, &argp->fh);
-	nfserr = fh_verify(rqstp, &resp->fh, 0, NFSD_MAY_NOP);
-	if (nfserr)
-		RETURN_STATUS(nfserr);
+	resp->status = fh_verify(rqstp, &resp->fh, 0, NFSD_MAY_NOP);
+	if (resp->status != nfs_ok)
+		goto out;
 
 	inode = d_inode(fh->fh_dentry);
 
-	if (argp->mask & ~NFS_ACL_MASK)
-		RETURN_STATUS(nfserr_inval);
+	if (argp->mask & ~NFS_ACL_MASK) {
+		resp->status = nfserr_inval;
+		goto out;
+	}
 	resp->mask = argp->mask;
 
 	if (resp->mask & (NFS_ACL|NFS_ACLCNT)) {
@@ -54,7 +53,7 @@ static __be32 nfsd3_proc_getacl(struct svc_rqst *rqstp)
 			acl = posix_acl_from_mode(inode->i_mode, GFP_KERNEL);
 		}
 		if (IS_ERR(acl)) {
-			nfserr = nfserrno(PTR_ERR(acl));
+			resp->status = nfserrno(PTR_ERR(acl));
 			goto fail;
 		}
 		resp->acl_access = acl;
@@ -64,19 +63,20 @@ static __be32 nfsd3_proc_getacl(struct svc_rqst *rqstp)
 		   of a non-directory! */
 		acl = get_acl(inode, ACL_TYPE_DEFAULT);
 		if (IS_ERR(acl)) {
-			nfserr = nfserrno(PTR_ERR(acl));
+			resp->status = nfserrno(PTR_ERR(acl));
 			goto fail;
 		}
 		resp->acl_default = acl;
 	}
 
 	/* resp->acl_{access,default} are released in nfs3svc_release_getacl. */
-	RETURN_STATUS(0);
+out:
+	return resp->status;
 
 fail:
 	posix_acl_release(resp->acl_access);
 	posix_acl_release(resp->acl_default);
-	RETURN_STATUS(nfserr);
+	goto out;
 }
 
 /*
@@ -88,12 +88,11 @@ static __be32 nfsd3_proc_setacl(struct svc_rqst *rqstp)
 	struct nfsd3_attrstat *resp = rqstp->rq_resp;
 	struct inode *inode;
 	svc_fh *fh;
-	__be32 nfserr = 0;
 	int error;
 
 	fh = fh_copy(&resp->fh, &argp->fh);
-	nfserr = fh_verify(rqstp, &resp->fh, 0, NFSD_MAY_SATTR);
-	if (nfserr)
+	resp->status = fh_verify(rqstp, &resp->fh, 0, NFSD_MAY_SATTR);
+	if (resp->status != nfs_ok)
 		goto out;
 
 	inode = d_inode(fh->fh_dentry);
@@ -113,13 +112,13 @@ static __be32 nfsd3_proc_setacl(struct svc_rqst *rqstp)
 	fh_unlock(fh);
 	fh_drop_write(fh);
 out_errno:
-	nfserr = nfserrno(error);
+	resp->status = nfserrno(error);
 out:
 	/* argp->acl_{access,default} may have been allocated in
 	   nfs3svc_decode_setaclargs. */
 	posix_acl_release(argp->acl_access);
 	posix_acl_release(argp->acl_default);
-	RETURN_STATUS(nfserr);
+	return resp->status;
 }
 
 /*
diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 3d09959c7042..1d2c149e5ff4 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -15,8 +15,6 @@
 
 #define NFSDDBG_FACILITY		NFSDDBG_PROC
 
-#define RETURN_STATUS(st)	{ resp->status = (st); return (st); }
-
 static int	nfs3_ftypes[] = {
 	0,			/* NF3NON */
 	S_IFREG,		/* NF3REG */
@@ -45,20 +43,19 @@ nfsd3_proc_getattr(struct svc_rqst *rqstp)
 {
 	struct nfsd_fhandle *argp = rqstp->rq_argp;
 	struct nfsd3_attrstat *resp = rqstp->rq_resp;
-	__be32	nfserr;
 
 	dprintk("nfsd: GETATTR(3)  %s\n",
 		SVCFH_fmt(&argp->fh));
 
 	fh_copy(&resp->fh, &argp->fh);
-	nfserr = fh_verify(rqstp, &resp->fh, 0,
-			NFSD_MAY_NOP | NFSD_MAY_BYPASS_GSS_ON_ROOT);
-	if (nfserr)
-		RETURN_STATUS(nfserr);
-
-	nfserr = fh_getattr(&resp->fh, &resp->stat);
-
-	RETURN_STATUS(nfserr);
+	resp->status = fh_verify(rqstp, &resp->fh, 0,
+				 NFSD_MAY_NOP | NFSD_MAY_BYPASS_GSS_ON_ROOT);
+	if (resp->status != nfs_ok)
+		goto out;
+
+	resp->status = fh_getattr(&resp->fh, &resp->stat);
+out:
+	return resp->status;
 }
 
 /*
@@ -69,15 +66,14 @@ nfsd3_proc_setattr(struct svc_rqst *rqstp)
 {
 	struct nfsd3_sattrargs *argp = rqstp->rq_argp;
 	struct nfsd3_attrstat *resp = rqstp->rq_resp;
-	__be32	nfserr;
 
 	dprintk("nfsd: SETATTR(3)  %s\n",
 				SVCFH_fmt(&argp->fh));
 
 	fh_copy(&resp->fh, &argp->fh);
-	nfserr = nfsd_setattr(rqstp, &resp->fh, &argp->attrs,
-			      argp->check_guard, argp->guardtime);
-	RETURN_STATUS(nfserr);
+	resp->status = nfsd_setattr(rqstp, &resp->fh, &argp->attrs,
+				    argp->check_guard, argp->guardtime);
+	return resp->status;
 }
 
 /*
@@ -88,7 +84,6 @@ nfsd3_proc_lookup(struct svc_rqst *rqstp)
 {
 	struct nfsd3_diropargs *argp = rqstp->rq_argp;
 	struct nfsd3_diropres  *resp = rqstp->rq_resp;
-	__be32	nfserr;
 
 	dprintk("nfsd: LOOKUP(3)   %s %.*s\n",
 				SVCFH_fmt(&argp->fh),
@@ -98,11 +93,10 @@ nfsd3_proc_lookup(struct svc_rqst *rqstp)
 	fh_copy(&resp->dirfh, &argp->fh);
 	fh_init(&resp->fh, NFS3_FHSIZE);
 
-	nfserr = nfsd_lookup(rqstp, &resp->dirfh,
-				    argp->name,
-				    argp->len,
-				    &resp->fh);
-	RETURN_STATUS(nfserr);
+	resp->status = nfsd_lookup(rqstp, &resp->dirfh,
+				   argp->name, argp->len,
+				   &resp->fh);
+	return resp->status;
 }
 
 /*
@@ -113,7 +107,6 @@ nfsd3_proc_access(struct svc_rqst *rqstp)
 {
 	struct nfsd3_accessargs *argp = rqstp->rq_argp;
 	struct nfsd3_accessres *resp = rqstp->rq_resp;
-	__be32	nfserr;
 
 	dprintk("nfsd: ACCESS(3)   %s 0x%x\n",
 				SVCFH_fmt(&argp->fh),
@@ -121,8 +114,8 @@ nfsd3_proc_access(struct svc_rqst *rqstp)
 
 	fh_copy(&resp->fh, &argp->fh);
 	resp->access = argp->access;
-	nfserr = nfsd_access(rqstp, &resp->fh, &resp->access, NULL);
-	RETURN_STATUS(nfserr);
+	resp->status = nfsd_access(rqstp, &resp->fh, &resp->access, NULL);
+	return resp->status;
 }
 
 /*
@@ -133,15 +126,14 @@ nfsd3_proc_readlink(struct svc_rqst *rqstp)
 {
 	struct nfsd3_readlinkargs *argp = rqstp->rq_argp;
 	struct nfsd3_readlinkres *resp = rqstp->rq_resp;
-	__be32 nfserr;
 
 	dprintk("nfsd: READLINK(3) %s\n", SVCFH_fmt(&argp->fh));
 
 	/* Read the symlink. */
 	fh_copy(&resp->fh, &argp->fh);
 	resp->len = NFS3_MAXPATHLEN;
-	nfserr = nfsd_readlink(rqstp, &resp->fh, argp->buffer, &resp->len);
-	RETURN_STATUS(nfserr);
+	resp->status = nfsd_readlink(rqstp, &resp->fh, argp->buffer, &resp->len);
+	return resp->status;
 }
 
 /*
@@ -152,7 +144,6 @@ nfsd3_proc_read(struct svc_rqst *rqstp)
 {
 	struct nfsd3_readargs *argp = rqstp->rq_argp;
 	struct nfsd3_readres *resp = rqstp->rq_resp;
-	__be32	nfserr;
 	u32	max_blocksize = svc_max_payload(rqstp);
 	unsigned long cnt = min(argp->count, max_blocksize);
 
@@ -169,12 +160,10 @@ nfsd3_proc_read(struct svc_rqst *rqstp)
 	svc_reserve_auth(rqstp, ((1 + NFS3_POST_OP_ATTR_WORDS + 3)<<2) + resp->count +4);
 
 	fh_copy(&resp->fh, &argp->fh);
-	nfserr = nfsd_read(rqstp, &resp->fh,
-				  argp->offset,
-			   	  rqstp->rq_vec, argp->vlen,
-				  &resp->count,
-				  &resp->eof);
-	RETURN_STATUS(nfserr);
+	resp->status = nfsd_read(rqstp, &resp->fh, argp->offset,
+				 rqstp->rq_vec, argp->vlen, &resp->count,
+				 &resp->eof);
+	return resp->status;
 }
 
 /*
@@ -185,7 +174,6 @@ nfsd3_proc_write(struct svc_rqst *rqstp)
 {
 	struct nfsd3_writeargs *argp = rqstp->rq_argp;
 	struct nfsd3_writeres *resp = rqstp->rq_resp;
-	__be32	nfserr;
 	unsigned long cnt = argp->len;
 	unsigned int nvecs;
 
@@ -199,13 +187,16 @@ nfsd3_proc_write(struct svc_rqst *rqstp)
 	resp->committed = argp->stable;
 	nvecs = svc_fill_write_vector(rqstp, rqstp->rq_arg.pages,
 				      &argp->first, cnt);
-	if (!nvecs)
-		RETURN_STATUS(nfserr_io);
-	nfserr = nfsd_write(rqstp, &resp->fh, argp->offset,
-			    rqstp->rq_vec, nvecs, &cnt,
-			    resp->committed, resp->verf);
+	if (!nvecs) {
+		resp->status = nfserr_io;
+		goto out;
+	}
+	resp->status = nfsd_write(rqstp, &resp->fh, argp->offset,
+				  rqstp->rq_vec, nvecs, &cnt,
+				  resp->committed, resp->verf);
 	resp->count = cnt;
-	RETURN_STATUS(nfserr);
+out:
+	return resp->status;
 }
 
 /*
@@ -220,7 +211,6 @@ nfsd3_proc_create(struct svc_rqst *rqstp)
 	struct nfsd3_diropres *resp = rqstp->rq_resp;
 	svc_fh		*dirfhp, *newfhp = NULL;
 	struct iattr	*attr;
-	__be32		nfserr;
 
 	dprintk("nfsd: CREATE(3)   %s %.*s\n",
 				SVCFH_fmt(&argp->fh),
@@ -241,11 +231,10 @@ nfsd3_proc_create(struct svc_rqst *rqstp)
 	}
 
 	/* Now create the file and set attributes */
-	nfserr = do_nfsd_create(rqstp, dirfhp, argp->name, argp->len,
-				attr, newfhp,
-				argp->createmode, (u32 *)argp->verf, NULL, NULL);
-
-	RETURN_STATUS(nfserr);
+	resp->status = do_nfsd_create(rqstp, dirfhp, argp->name, argp->len,
+				      attr, newfhp, argp->createmode,
+				      (u32 *)argp->verf, NULL, NULL);
+	return resp->status;
 }
 
 /*
@@ -256,7 +245,6 @@ nfsd3_proc_mkdir(struct svc_rqst *rqstp)
 {
 	struct nfsd3_createargs *argp = rqstp->rq_argp;
 	struct nfsd3_diropres *resp = rqstp->rq_resp;
-	__be32	nfserr;
 
 	dprintk("nfsd: MKDIR(3)    %s %.*s\n",
 				SVCFH_fmt(&argp->fh),
@@ -266,10 +254,10 @@ nfsd3_proc_mkdir(struct svc_rqst *rqstp)
 	argp->attrs.ia_valid &= ~ATTR_SIZE;
 	fh_copy(&resp->dirfh, &argp->fh);
 	fh_init(&resp->fh, NFS3_FHSIZE);
-	nfserr = nfsd_create(rqstp, &resp->dirfh, argp->name, argp->len,
-				    &argp->attrs, S_IFDIR, 0, &resp->fh);
+	resp->status = nfsd_create(rqstp, &resp->dirfh, argp->name, argp->len,
+				   &argp->attrs, S_IFDIR, 0, &resp->fh);
 	fh_unlock(&resp->dirfh);
-	RETURN_STATUS(nfserr);
+	return resp->status;
 }
 
 static __be32
@@ -277,18 +265,23 @@ nfsd3_proc_symlink(struct svc_rqst *rqstp)
 {
 	struct nfsd3_symlinkargs *argp = rqstp->rq_argp;
 	struct nfsd3_diropres *resp = rqstp->rq_resp;
-	__be32	nfserr;
 
-	if (argp->tlen == 0)
-		RETURN_STATUS(nfserr_inval);
-	if (argp->tlen > NFS3_MAXPATHLEN)
-		RETURN_STATUS(nfserr_nametoolong);
+	if (argp->tlen == 0) {
+		resp->status = nfserr_inval;
+		goto out;
+	}
+	if (argp->tlen > NFS3_MAXPATHLEN) {
+		resp->status = nfserr_nametoolong;
+		goto out;
+	}
 
 	argp->tname = svc_fill_symlink_pathname(rqstp, &argp->first,
 						page_address(rqstp->rq_arg.pages[0]),
 						argp->tlen);
-	if (IS_ERR(argp->tname))
-		RETURN_STATUS(nfserrno(PTR_ERR(argp->tname)));
+	if (IS_ERR(argp->tname)) {
+		resp->status = nfserrno(PTR_ERR(argp->tname));
+		goto out;
+	}
 
 	dprintk("nfsd: SYMLINK(3)  %s %.*s -> %.*s\n",
 				SVCFH_fmt(&argp->ffh),
@@ -297,10 +290,11 @@ nfsd3_proc_symlink(struct svc_rqst *rqstp)
 
 	fh_copy(&resp->dirfh, &argp->ffh);
 	fh_init(&resp->fh, NFS3_FHSIZE);
-	nfserr = nfsd_symlink(rqstp, &resp->dirfh, argp->fname, argp->flen,
-						   argp->tname, &resp->fh);
+	resp->status = nfsd_symlink(rqstp, &resp->dirfh, argp->fname,
+				    argp->flen, argp->tname, &resp->fh);
 	kfree(argp->tname);
-	RETURN_STATUS(nfserr);
+out:
+	return resp->status;
 }
 
 /*
@@ -311,7 +305,6 @@ nfsd3_proc_mknod(struct svc_rqst *rqstp)
 {
 	struct nfsd3_mknodargs *argp = rqstp->rq_argp;
 	struct nfsd3_diropres  *resp = rqstp->rq_resp;
-	__be32	nfserr;
 	int type;
 	dev_t	rdev = 0;
 
@@ -323,22 +316,28 @@ nfsd3_proc_mknod(struct svc_rqst *rqstp)
 	fh_copy(&resp->dirfh, &argp->fh);
 	fh_init(&resp->fh, NFS3_FHSIZE);
 
-	if (argp->ftype == 0 || argp->ftype >= NF3BAD)
-		RETURN_STATUS(nfserr_inval);
+	if (argp->ftype == 0 || argp->ftype >= NF3BAD) {
+		resp->status = nfserr_inval;
+		goto out;
+	}
 	if (argp->ftype == NF3CHR || argp->ftype == NF3BLK) {
 		rdev = MKDEV(argp->major, argp->minor);
 		if (MAJOR(rdev) != argp->major ||
-		    MINOR(rdev) != argp->minor)
-			RETURN_STATUS(nfserr_inval);
-	} else
-		if (argp->ftype != NF3SOCK && argp->ftype != NF3FIFO)
-			RETURN_STATUS(nfserr_inval);
+		    MINOR(rdev) != argp->minor) {
+			resp->status = nfserr_inval;
+			goto out;
+		}
+	} else if (argp->ftype != NF3SOCK && argp->ftype != NF3FIFO) {
+		resp->status = nfserr_inval;
+		goto out;
+	}
 
 	type = nfs3_ftypes[argp->ftype];
-	nfserr = nfsd_create(rqstp, &resp->dirfh, argp->name, argp->len,
-				    &argp->attrs, type, rdev, &resp->fh);
+	resp->status = nfsd_create(rqstp, &resp->dirfh, argp->name, argp->len,
+				   &argp->attrs, type, rdev, &resp->fh);
 	fh_unlock(&resp->dirfh);
-	RETURN_STATUS(nfserr);
+out:
+	return resp->status;
 }
 
 /*
@@ -349,7 +348,6 @@ nfsd3_proc_remove(struct svc_rqst *rqstp)
 {
 	struct nfsd3_diropargs *argp = rqstp->rq_argp;
 	struct nfsd3_attrstat *resp = rqstp->rq_resp;
-	__be32	nfserr;
 
 	dprintk("nfsd: REMOVE(3)   %s %.*s\n",
 				SVCFH_fmt(&argp->fh),
@@ -358,9 +356,10 @@ nfsd3_proc_remove(struct svc_rqst *rqstp)
 
 	/* Unlink. -S_IFDIR means file must not be a directory */
 	fh_copy(&resp->fh, &argp->fh);
-	nfserr = nfsd_unlink(rqstp, &resp->fh, -S_IFDIR, argp->name, argp->len);
+	resp->status = nfsd_unlink(rqstp, &resp->fh, -S_IFDIR,
+				   argp->name, argp->len);
 	fh_unlock(&resp->fh);
-	RETURN_STATUS(nfserr);
+	return resp->status;
 }
 
 /*
@@ -371,7 +370,6 @@ nfsd3_proc_rmdir(struct svc_rqst *rqstp)
 {
 	struct nfsd3_diropargs *argp = rqstp->rq_argp;
 	struct nfsd3_attrstat *resp = rqstp->rq_resp;
-	__be32	nfserr;
 
 	dprintk("nfsd: RMDIR(3)    %s %.*s\n",
 				SVCFH_fmt(&argp->fh),
@@ -379,9 +377,10 @@ nfsd3_proc_rmdir(struct svc_rqst *rqstp)
 				argp->name);
 
 	fh_copy(&resp->fh, &argp->fh);
-	nfserr = nfsd_unlink(rqstp, &resp->fh, S_IFDIR, argp->name, argp->len);
+	resp->status = nfsd_unlink(rqstp, &resp->fh, S_IFDIR,
+				   argp->name, argp->len);
 	fh_unlock(&resp->fh);
-	RETURN_STATUS(nfserr);
+	return resp->status;
 }
 
 static __be32
@@ -389,7 +388,6 @@ nfsd3_proc_rename(struct svc_rqst *rqstp)
 {
 	struct nfsd3_renameargs *argp = rqstp->rq_argp;
 	struct nfsd3_renameres *resp = rqstp->rq_resp;
-	__be32	nfserr;
 
 	dprintk("nfsd: RENAME(3)   %s %.*s ->\n",
 				SVCFH_fmt(&argp->ffh),
@@ -402,9 +400,9 @@ nfsd3_proc_rename(struct svc_rqst *rqstp)
 
 	fh_copy(&resp->ffh, &argp->ffh);
 	fh_copy(&resp->tfh, &argp->tfh);
-	nfserr = nfsd_rename(rqstp, &resp->ffh, argp->fname, argp->flen,
-				    &resp->tfh, argp->tname, argp->tlen);
-	RETURN_STATUS(nfserr);
+	resp->status = nfsd_rename(rqstp, &resp->ffh, argp->fname, argp->flen,
+				   &resp->tfh, argp->tname, argp->tlen);
+	return resp->status;
 }
 
 static __be32
@@ -412,7 +410,6 @@ nfsd3_proc_link(struct svc_rqst *rqstp)
 {
 	struct nfsd3_linkargs *argp = rqstp->rq_argp;
 	struct nfsd3_linkres  *resp = rqstp->rq_resp;
-	__be32	nfserr;
 
 	dprintk("nfsd: LINK(3)     %s ->\n",
 				SVCFH_fmt(&argp->ffh));
@@ -423,9 +420,9 @@ nfsd3_proc_link(struct svc_rqst *rqstp)
 
 	fh_copy(&resp->fh,  &argp->ffh);
 	fh_copy(&resp->tfh, &argp->tfh);
-	nfserr = nfsd_link(rqstp, &resp->tfh, argp->tname, argp->tlen,
-				  &resp->fh);
-	RETURN_STATUS(nfserr);
+	resp->status = nfsd_link(rqstp, &resp->tfh, argp->tname, argp->tlen,
+				 &resp->fh);
+	return resp->status;
 }
 
 /*
@@ -436,7 +433,6 @@ nfsd3_proc_readdir(struct svc_rqst *rqstp)
 {
 	struct nfsd3_readdirargs *argp = rqstp->rq_argp;
 	struct nfsd3_readdirres  *resp = rqstp->rq_resp;
-	__be32		nfserr;
 	int		count = 0;
 	struct page	**p;
 	caddr_t		page_addr = NULL;
@@ -456,8 +452,8 @@ nfsd3_proc_readdir(struct svc_rqst *rqstp)
 	resp->common.err = nfs_ok;
 	resp->buffer = argp->buffer;
 	resp->rqstp = rqstp;
-	nfserr = nfsd_readdir(rqstp, &resp->fh, (loff_t*) &argp->cookie, 
-					&resp->common, nfs3svc_encode_entry);
+	resp->status = nfsd_readdir(rqstp, &resp->fh, (loff_t *)&argp->cookie,
+				    &resp->common, nfs3svc_encode_entry);
 	memcpy(resp->verf, argp->verf, 8);
 	count = 0;
 	for (p = rqstp->rq_respages + 1; p < rqstp->rq_next_page; p++) {
@@ -485,7 +481,7 @@ nfsd3_proc_readdir(struct svc_rqst *rqstp)
 		resp->offset = NULL;
 	}
 
-	RETURN_STATUS(nfserr);
+	return resp->status;
 }
 
 /*
@@ -497,7 +493,6 @@ nfsd3_proc_readdirplus(struct svc_rqst *rqstp)
 {
 	struct nfsd3_readdirargs *argp = rqstp->rq_argp;
 	struct nfsd3_readdirres  *resp = rqstp->rq_resp;
-	__be32	nfserr;
 	int	count = 0;
 	loff_t	offset;
 	struct page **p;
@@ -520,17 +515,17 @@ nfsd3_proc_readdirplus(struct svc_rqst *rqstp)
 	resp->rqstp = rqstp;
 	offset = argp->cookie;
 
-	nfserr = fh_verify(rqstp, &resp->fh, S_IFDIR, NFSD_MAY_NOP);
-	if (nfserr)
-		RETURN_STATUS(nfserr);
+	resp->status = fh_verify(rqstp, &resp->fh, S_IFDIR, NFSD_MAY_NOP);
+	if (resp->status != nfs_ok)
+		goto out;
 
-	if (resp->fh.fh_export->ex_flags & NFSEXP_NOREADDIRPLUS)
-		RETURN_STATUS(nfserr_notsupp);
+	if (resp->fh.fh_export->ex_flags & NFSEXP_NOREADDIRPLUS) {
+		resp->status = nfserr_notsupp;
+		goto out;
+	}
 
-	nfserr = nfsd_readdir(rqstp, &resp->fh,
-				     &offset,
-				     &resp->common,
-				     nfs3svc_encode_entry_plus);
+	resp->status = nfsd_readdir(rqstp, &resp->fh, &offset,
+				    &resp->common, nfs3svc_encode_entry_plus);
 	memcpy(resp->verf, argp->verf, 8);
 	for (p = rqstp->rq_respages + 1; p < rqstp->rq_next_page; p++) {
 		page_addr = page_address(*p);
@@ -555,7 +550,8 @@ nfsd3_proc_readdirplus(struct svc_rqst *rqstp)
 		resp->offset = NULL;
 	}
 
-	RETURN_STATUS(nfserr);
+out:
+	return resp->status;
 }
 
 /*
@@ -566,14 +562,13 @@ nfsd3_proc_fsstat(struct svc_rqst *rqstp)
 {
 	struct nfsd_fhandle *argp = rqstp->rq_argp;
 	struct nfsd3_fsstatres *resp = rqstp->rq_resp;
-	__be32	nfserr;
 
 	dprintk("nfsd: FSSTAT(3)   %s\n",
 				SVCFH_fmt(&argp->fh));
 
-	nfserr = nfsd_statfs(rqstp, &argp->fh, &resp->stats, 0);
+	resp->status = nfsd_statfs(rqstp, &argp->fh, &resp->stats, 0);
 	fh_put(&argp->fh);
-	RETURN_STATUS(nfserr);
+	return resp->status;
 }
 
 /*
@@ -584,7 +579,6 @@ nfsd3_proc_fsinfo(struct svc_rqst *rqstp)
 {
 	struct nfsd_fhandle *argp = rqstp->rq_argp;
 	struct nfsd3_fsinfores *resp = rqstp->rq_resp;
-	__be32	nfserr;
 	u32	max_blocksize = svc_max_payload(rqstp);
 
 	dprintk("nfsd: FSINFO(3)   %s\n",
@@ -600,13 +594,13 @@ nfsd3_proc_fsinfo(struct svc_rqst *rqstp)
 	resp->f_maxfilesize = ~(u32) 0;
 	resp->f_properties = NFS3_FSF_DEFAULT;
 
-	nfserr = fh_verify(rqstp, &argp->fh, 0,
-			NFSD_MAY_NOP | NFSD_MAY_BYPASS_GSS_ON_ROOT);
+	resp->status = fh_verify(rqstp, &argp->fh, 0,
+				 NFSD_MAY_NOP | NFSD_MAY_BYPASS_GSS_ON_ROOT);
 
 	/* Check special features of the file system. May request
 	 * different read/write sizes for file systems known to have
 	 * problems with large blocks */
-	if (nfserr == 0) {
+	if (resp->status == nfs_ok) {
 		struct super_block *sb = argp->fh.fh_dentry->d_sb;
 
 		/* Note that we don't care for remote fs's here */
@@ -617,7 +611,7 @@ nfsd3_proc_fsinfo(struct svc_rqst *rqstp)
 	}
 
 	fh_put(&argp->fh);
-	RETURN_STATUS(nfserr);
+	return resp->status;
 }
 
 /*
@@ -628,7 +622,6 @@ nfsd3_proc_pathconf(struct svc_rqst *rqstp)
 {
 	struct nfsd_fhandle *argp = rqstp->rq_argp;
 	struct nfsd3_pathconfres *resp = rqstp->rq_resp;
-	__be32	nfserr;
 
 	dprintk("nfsd: PATHCONF(3) %s\n",
 				SVCFH_fmt(&argp->fh));
@@ -641,9 +634,9 @@ nfsd3_proc_pathconf(struct svc_rqst *rqstp)
 	resp->p_case_insensitive = 0;
 	resp->p_case_preserving = 1;
 
-	nfserr = fh_verify(rqstp, &argp->fh, 0, NFSD_MAY_NOP);
+	resp->status = fh_verify(rqstp, &argp->fh, 0, NFSD_MAY_NOP);
 
-	if (nfserr == 0) {
+	if (resp->status == nfs_ok) {
 		struct super_block *sb = argp->fh.fh_dentry->d_sb;
 
 		/* Note that we don't care for remote fs's here */
@@ -660,10 +653,9 @@ nfsd3_proc_pathconf(struct svc_rqst *rqstp)
 	}
 
 	fh_put(&argp->fh);
-	RETURN_STATUS(nfserr);
+	return resp->status;
 }
 
-
 /*
  * Commit a file (range) to stable storage.
  */
@@ -672,21 +664,22 @@ nfsd3_proc_commit(struct svc_rqst *rqstp)
 {
 	struct nfsd3_commitargs *argp = rqstp->rq_argp;
 	struct nfsd3_commitres *resp = rqstp->rq_resp;
-	__be32	nfserr;
 
 	dprintk("nfsd: COMMIT(3)   %s %u@%Lu\n",
 				SVCFH_fmt(&argp->fh),
 				argp->count,
 				(unsigned long long) argp->offset);
 
-	if (argp->offset > NFS_OFFSET_MAX)
-		RETURN_STATUS(nfserr_inval);
+	if (argp->offset > NFS_OFFSET_MAX) {
+		resp->status = nfserr_inval;
+		goto out;
+	}
 
 	fh_copy(&resp->fh, &argp->fh);
-	nfserr = nfsd_commit(rqstp, &resp->fh, argp->offset, argp->count,
-			resp->verf);
-
-	RETURN_STATUS(nfserr);
+	resp->status = nfsd_commit(rqstp, &resp->fh, argp->offset,
+				   argp->count, resp->verf);
+out:
+	return resp->status;
 }
 
 


