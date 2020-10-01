Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2126D280AAC
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Oct 2020 00:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733288AbgJAW76 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Oct 2020 18:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbgJAW7x (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Oct 2020 18:59:53 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0976C0613E2
        for <linux-nfs@vger.kernel.org>; Thu,  1 Oct 2020 15:59:52 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id 10so639002qtx.12
        for <linux-nfs@vger.kernel.org>; Thu, 01 Oct 2020 15:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=j+kHGRFDcPqWCDyMVc/nd+kO9np7pZ2UObcXmHHpeZk=;
        b=E123Att0Rsvbc2lGI+NassWEONlz5ZDKrREvJPp/a/5sKMDKiDD0DOWc2e0EpdvUSX
         RgQAzxZdLXWkE6B8ZxuAO/D3oRiPHCrPMhu7wp3LbT+9N6k0/4EQ1wrgkaXaHM6hvZ05
         M2l0jpfCJZd9yYcswyng0YX0YNOqPmKskyvCd7ITeyqsN0IKXFctRlX+6Jd2OBjrD8W3
         z0w9ycZ9iaK5utqbUjvkgJnLG8kOgF1GXuv+RfUxcYhRkFBN1VSwJYdZ4z2EXjPYuQDd
         d27ANGbrzzFfKuGAKDUyCjtd4uR19hePaACle1GJP9juY1fHX7ZxsAIMNkmgBKuAhDms
         /dJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=j+kHGRFDcPqWCDyMVc/nd+kO9np7pZ2UObcXmHHpeZk=;
        b=imp9CWikXLa438470ddOjyGFoUDFzDmS5kauezMi+cYUstIv5kLnGxgkwF2Ks61iJH
         QCHN9MFTTXdlJWG7VL4DdhYeDArCeNqT1gtGUrzkXyFiZQ7Wsd39p9ga8Pf2ym7Wd/zj
         NXtRP+L2oPHGU1CXjEdtInFDOyJ2H2g88d4EeOQqC+U3uJtKG31ViuUZcH3N+xpi43+I
         CFAPoubjHbNdmhzmmRCiqAY43Czxq090pysSTs2tnDXnS+fBLzFwki8tYj0zG9I4GviT
         7Yn9VeL/xzVwboiXiSw31TlL9SA2Vs7vLAm46Mdo2dCv/mQuyaqsPuaEZG7Ts2LqTLcu
         mnHw==
X-Gm-Message-State: AOAM530i3uWsGHCgMwuz4DxCGQ/EQs64fGBT64qcLzu3bwvceVG7YlJq
        UYCIz2Oa1DnA/GGwICBlXkgVanmxg6C7Ug==
X-Google-Smtp-Source: ABdhPJwl/DNXiArGgzIKA7N4SLZETa37nT6ER9AXB9xC8233Cd2KnTYRch+a9CKtaV/DSgoxz8iejA==
X-Received: by 2002:ac8:4e55:: with SMTP id e21mr10712783qtw.66.1601593191166;
        Thu, 01 Oct 2020 15:59:51 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 90sm4713344qtb.6.2020.10.01.15.59.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Oct 2020 15:59:50 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 091MxniZ032598;
        Thu, 1 Oct 2020 22:59:49 GMT
Subject: [PATCH v3 12/15] NFSD: Call NFSv2 encoders on error returns
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 01 Oct 2020 18:59:49 -0400
Message-ID: <160159318959.79253.14160757630143989977.stgit@klimt.1015granger.net>
In-Reply-To: <160159301676.79253.16488984581431975601.stgit@klimt.1015granger.net>
References: <160159301676.79253.16488984581431975601.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Remove special dispatcher logic for NFSv2 error responses. These are
rare to the point of becoming extinct, but all NFS responses have to
pay the cost of the extra conditional branches.

With this change, the NFSv2 error cases now get proper
xdr_ressize_check() calls.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs2acl.c |   75 ++++++++++++---------
 fs/nfsd/nfsproc.c |  185 +++++++++++++++++++++++++++++------------------------
 fs/nfsd/nfssvc.c  |    8 +-
 fs/nfsd/nfsxdr.c  |   18 +++++
 fs/nfsd/xdr.h     |    7 ++
 5 files changed, 171 insertions(+), 122 deletions(-)

diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 3c8b9250dc4a..6f46afdb0616 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -14,7 +14,6 @@
 #include "vfs.h"
 
 #define NFSDDBG_FACILITY		NFSDDBG_PROC
-#define RETURN_STATUS(st)	{ resp->status = (st); return (st); }
 
 /*
  * NULL call.
@@ -35,24 +34,25 @@ static __be32 nfsacld_proc_getacl(struct svc_rqst *rqstp)
 	struct posix_acl *acl;
 	struct inode *inode;
 	svc_fh *fh;
-	__be32 nfserr = 0;
 
 	dprintk("nfsd: GETACL(2acl)   %s\n", SVCFH_fmt(&argp->fh));
 
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
 
-	nfserr = fh_getattr(fh, &resp->stat);
-	if (nfserr)
-		RETURN_STATUS(nfserr);
+	resp->status = fh_getattr(fh, &resp->stat);
+	if (resp->status != nfs_ok)
+		goto out;
 
 	if (resp->mask & (NFS_ACL|NFS_ACLCNT)) {
 		acl = get_acl(inode, ACL_TYPE_ACCESS);
@@ -61,7 +61,7 @@ static __be32 nfsacld_proc_getacl(struct svc_rqst *rqstp)
 			acl = posix_acl_from_mode(inode->i_mode, GFP_KERNEL);
 		}
 		if (IS_ERR(acl)) {
-			nfserr = nfserrno(PTR_ERR(acl));
+			resp->status = nfserrno(PTR_ERR(acl));
 			goto fail;
 		}
 		resp->acl_access = acl;
@@ -71,19 +71,20 @@ static __be32 nfsacld_proc_getacl(struct svc_rqst *rqstp)
 		   of a non-directory! */
 		acl = get_acl(inode, ACL_TYPE_DEFAULT);
 		if (IS_ERR(acl)) {
-			nfserr = nfserrno(PTR_ERR(acl));
+			resp->status = nfserrno(PTR_ERR(acl));
 			goto fail;
 		}
 		resp->acl_default = acl;
 	}
 
 	/* resp->acl_{access,default} are released in nfssvc_release_getacl. */
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
@@ -95,14 +96,13 @@ static __be32 nfsacld_proc_setacl(struct svc_rqst *rqstp)
 	struct nfsd_attrstat *resp = rqstp->rq_resp;
 	struct inode *inode;
 	svc_fh *fh;
-	__be32 nfserr = 0;
 	int error;
 
 	dprintk("nfsd: SETACL(2acl)   %s\n", SVCFH_fmt(&argp->fh));
 
 	fh = fh_copy(&resp->fh, &argp->fh);
-	nfserr = fh_verify(rqstp, &resp->fh, 0, NFSD_MAY_SATTR);
-	if (nfserr)
+	resp->status = fh_verify(rqstp, &resp->fh, 0, NFSD_MAY_SATTR);
+	if (resp->status != nfs_ok)
 		goto out;
 
 	inode = d_inode(fh->fh_dentry);
@@ -124,19 +124,20 @@ static __be32 nfsacld_proc_setacl(struct svc_rqst *rqstp)
 
 	fh_drop_write(fh);
 
-	nfserr = fh_getattr(fh, &resp->stat);
+	resp->status = fh_getattr(fh, &resp->stat);
 
 out:
 	/* argp->acl_{access,default} may have been allocated in
 	   nfssvc_decode_setaclargs. */
 	posix_acl_release(argp->acl_access);
 	posix_acl_release(argp->acl_default);
-	return nfserr;
+	return resp->status;
+
 out_drop_lock:
 	fh_unlock(fh);
 	fh_drop_write(fh);
 out_errno:
-	nfserr = nfserrno(error);
+	resp->status = nfserrno(error);
 	goto out;
 }
 
@@ -147,15 +148,16 @@ static __be32 nfsacld_proc_getattr(struct svc_rqst *rqstp)
 {
 	struct nfsd_fhandle *argp = rqstp->rq_argp;
 	struct nfsd_attrstat *resp = rqstp->rq_resp;
-	__be32 nfserr;
+
 	dprintk("nfsd: GETATTR  %s\n", SVCFH_fmt(&argp->fh));
 
 	fh_copy(&resp->fh, &argp->fh);
-	nfserr = fh_verify(rqstp, &resp->fh, 0, NFSD_MAY_NOP);
-	if (nfserr)
-		return nfserr;
-	nfserr = fh_getattr(&resp->fh, &resp->stat);
-	return nfserr;
+	resp->status = fh_verify(rqstp, &resp->fh, 0, NFSD_MAY_NOP);
+	if (resp->status != nfs_ok)
+		goto out;
+	resp->status = fh_getattr(&resp->fh, &resp->stat);
+out:
+	return resp->status;
 }
 
 /*
@@ -165,7 +167,6 @@ static __be32 nfsacld_proc_access(struct svc_rqst *rqstp)
 {
 	struct nfsd3_accessargs *argp = rqstp->rq_argp;
 	struct nfsd3_accessres *resp = rqstp->rq_resp;
-	__be32 nfserr;
 
 	dprintk("nfsd: ACCESS(2acl)   %s 0x%x\n",
 			SVCFH_fmt(&argp->fh),
@@ -173,11 +174,12 @@ static __be32 nfsacld_proc_access(struct svc_rqst *rqstp)
 
 	fh_copy(&resp->fh, &argp->fh);
 	resp->access = argp->access;
-	nfserr = nfsd_access(rqstp, &resp->fh, &resp->access, NULL);
-	if (nfserr)
-		return nfserr;
-	nfserr = fh_getattr(&resp->fh, &resp->stat);
-	return nfserr;
+	resp->status = nfsd_access(rqstp, &resp->fh, &resp->access, NULL);
+	if (resp->status != nfs_ok)
+		goto out;
+	resp->status = fh_getattr(&resp->fh, &resp->stat);
+out:
+	return resp->status;
 }
 
 /*
@@ -273,6 +275,9 @@ static int nfsaclsvc_encode_getaclres(struct svc_rqst *rqstp, __be32 *p)
 	int n;
 	int w;
 
+	if (resp->status != nfs_ok)
+		return xdr_ressize_check(rqstp, p);
+
 	/*
 	 * Since this is version 2, the check for nfserr in
 	 * nfsd_dispatch actually ensures the following cannot happen.
@@ -312,6 +317,9 @@ static int nfsaclsvc_encode_attrstatres(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd_attrstat *resp = rqstp->rq_resp;
 
+	if (resp->status != nfs_ok)
+		return xdr_ressize_check(rqstp, p);
+
 	p = nfs2svc_encode_fattr(rqstp, p, &resp->fh, &resp->stat);
 	return xdr_ressize_check(rqstp, p);
 }
@@ -321,6 +329,9 @@ static int nfsaclsvc_encode_accessres(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd3_accessres *resp = rqstp->rq_resp;
 
+	if (resp->status != nfs_ok)
+		return xdr_ressize_check(rqstp, p);
+
 	p = nfs2svc_encode_fattr(rqstp, p, &resp->fh, &resp->stat);
 	*p++ = htonl(resp->access);
 	return xdr_ressize_check(rqstp, p);
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index c349e1dac3ff..526170319ecf 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -13,25 +13,12 @@
 
 #define NFSDDBG_FACILITY		NFSDDBG_PROC
 
-
 static __be32
 nfsd_proc_null(struct svc_rqst *rqstp)
 {
 	return nfs_ok;
 }
 
-static __be32
-nfsd_return_attrs(__be32 err, struct nfsd_attrstat *resp)
-{
-	if (err) return err;
-	return fh_getattr(&resp->fh, &resp->stat);
-}
-static __be32
-nfsd_return_dirop(__be32 err, struct nfsd_diropres *resp)
-{
-	if (err) return err;
-	return fh_getattr(&resp->fh, &resp->stat);
-}
 /*
  * Get a file's attributes
  * N.B. After this call resp->fh needs an fh_put
@@ -41,13 +28,17 @@ nfsd_proc_getattr(struct svc_rqst *rqstp)
 {
 	struct nfsd_fhandle *argp = rqstp->rq_argp;
 	struct nfsd_attrstat *resp = rqstp->rq_resp;
-	__be32 nfserr;
+
 	dprintk("nfsd: GETATTR  %s\n", SVCFH_fmt(&argp->fh));
 
 	fh_copy(&resp->fh, &argp->fh);
-	nfserr = fh_verify(rqstp, &resp->fh, 0,
-			NFSD_MAY_NOP | NFSD_MAY_BYPASS_GSS_ON_ROOT);
-	return nfsd_return_attrs(nfserr, resp);
+	resp->status = fh_verify(rqstp, &resp->fh, 0,
+				 NFSD_MAY_NOP | NFSD_MAY_BYPASS_GSS_ON_ROOT);
+	if (resp->status != nfs_ok)
+		goto out;
+	resp->status = fh_getattr(&resp->fh, &resp->stat);
+out:
+	return resp->status;
 }
 
 /*
@@ -61,7 +52,6 @@ nfsd_proc_setattr(struct svc_rqst *rqstp)
 	struct nfsd_attrstat *resp = rqstp->rq_resp;
 	struct iattr *iap = &argp->attrs;
 	struct svc_fh *fhp;
-	__be32 nfserr;
 
 	dprintk("nfsd: SETATTR  %s, valid=%x, size=%ld\n",
 		SVCFH_fmt(&argp->fh),
@@ -93,9 +83,9 @@ nfsd_proc_setattr(struct svc_rqst *rqstp)
 		 */
 		time64_t delta = iap->ia_atime.tv_sec - ktime_get_real_seconds();
 
-		nfserr = fh_verify(rqstp, fhp, 0, NFSD_MAY_NOP);
-		if (nfserr)
-			goto done;
+		resp->status = fh_verify(rqstp, fhp, 0, NFSD_MAY_NOP);
+		if (resp->status != nfs_ok)
+			return resp->status;
 
 		if (delta < 0)
 			delta = -delta;
@@ -110,9 +100,13 @@ nfsd_proc_setattr(struct svc_rqst *rqstp)
 		}
 	}
 
-	nfserr = nfsd_setattr(rqstp, fhp, iap, 0, (time64_t)0);
-done:
-	return nfsd_return_attrs(nfserr, resp);
+	resp->status = nfsd_setattr(rqstp, fhp, iap, 0, (time64_t)0);
+	if (resp->status != nfs_ok)
+		goto out;
+
+	resp->status = fh_getattr(&resp->fh, &resp->stat);
+out:
+	return resp->status;
 }
 
 /* Obsolete, replaced by MNTPROC_MNT. */
@@ -133,17 +127,20 @@ nfsd_proc_lookup(struct svc_rqst *rqstp)
 {
 	struct nfsd_diropargs *argp = rqstp->rq_argp;
 	struct nfsd_diropres *resp = rqstp->rq_resp;
-	__be32	nfserr;
 
 	dprintk("nfsd: LOOKUP   %s %.*s\n",
 		SVCFH_fmt(&argp->fh), argp->len, argp->name);
 
 	fh_init(&resp->fh, NFS_FHSIZE);
-	nfserr = nfsd_lookup(rqstp, &argp->fh, argp->name, argp->len,
-				 &resp->fh);
-
+	resp->status = nfsd_lookup(rqstp, &argp->fh, argp->name, argp->len,
+				   &resp->fh);
 	fh_put(&argp->fh);
-	return nfsd_return_dirop(nfserr, resp);
+	if (resp->status != nfs_ok)
+		goto out;
+
+	resp->status = fh_getattr(&resp->fh, &resp->stat);
+out:
+	return resp->status;
 }
 
 /*
@@ -154,16 +151,15 @@ nfsd_proc_readlink(struct svc_rqst *rqstp)
 {
 	struct nfsd_readlinkargs *argp = rqstp->rq_argp;
 	struct nfsd_readlinkres *resp = rqstp->rq_resp;
-	__be32	nfserr;
 
 	dprintk("nfsd: READLINK %s\n", SVCFH_fmt(&argp->fh));
 
 	/* Read the symlink. */
 	resp->len = NFS_MAXPATHLEN;
-	nfserr = nfsd_readlink(rqstp, &argp->fh, argp->buffer, &resp->len);
+	resp->status = nfsd_readlink(rqstp, &argp->fh, argp->buffer, &resp->len);
 
 	fh_put(&argp->fh);
-	return nfserr;
+	return resp->status;
 }
 
 /*
@@ -175,7 +171,6 @@ nfsd_proc_read(struct svc_rqst *rqstp)
 {
 	struct nfsd_readargs *argp = rqstp->rq_argp;
 	struct nfsd_readres *resp = rqstp->rq_resp;
-	__be32	nfserr;
 	u32 eof;
 
 	dprintk("nfsd: READ    %s %d bytes at %d\n",
@@ -197,14 +192,17 @@ nfsd_proc_read(struct svc_rqst *rqstp)
 	svc_reserve_auth(rqstp, (19<<2) + argp->count + 4);
 
 	resp->count = argp->count;
-	nfserr = nfsd_read(rqstp, fh_copy(&resp->fh, &argp->fh),
-				  argp->offset,
-			   	  rqstp->rq_vec, argp->vlen,
-				  &resp->count,
-				  &eof);
-
-	if (nfserr) return nfserr;
-	return fh_getattr(&resp->fh, &resp->stat);
+	resp->status = nfsd_read(rqstp, fh_copy(&resp->fh, &argp->fh),
+				 argp->offset,
+				 rqstp->rq_vec, argp->vlen,
+				 &resp->count,
+				 &eof);
+	if (resp->status != nfs_ok)
+		goto out;
+
+	resp->status = fh_getattr(&resp->fh, &resp->stat);
+out:
+	return resp->status;
 }
 
 /* Reserved */
@@ -223,7 +221,6 @@ nfsd_proc_write(struct svc_rqst *rqstp)
 {
 	struct nfsd_writeargs *argp = rqstp->rq_argp;
 	struct nfsd_attrstat *resp = rqstp->rq_resp;
-	__be32	nfserr;
 	unsigned long cnt = argp->len;
 	unsigned int nvecs;
 
@@ -233,12 +230,20 @@ nfsd_proc_write(struct svc_rqst *rqstp)
 
 	nvecs = svc_fill_write_vector(rqstp, rqstp->rq_arg.pages,
 				      &argp->first, cnt);
-	if (!nvecs)
-		return nfserr_io;
-	nfserr = nfsd_write(rqstp, fh_copy(&resp->fh, &argp->fh),
-			    argp->offset, rqstp->rq_vec, nvecs,
-			    &cnt, NFS_DATA_SYNC, NULL);
-	return nfsd_return_attrs(nfserr, resp);
+	if (!nvecs) {
+		resp->status = nfserr_io;
+		goto out;
+	}
+
+	resp->status = nfsd_write(rqstp, fh_copy(&resp->fh, &argp->fh),
+				  argp->offset, rqstp->rq_vec, nvecs,
+				  &cnt, NFS_DATA_SYNC, NULL);
+	if (resp->status != nfs_ok)
+		goto out;
+
+	resp->status = fh_getattr(&resp->fh, &resp->stat);
+out:
+	return resp->status;
 }
 
 /*
@@ -258,7 +263,6 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 	struct inode	*inode;
 	struct dentry	*dchild;
 	int		type, mode;
-	__be32		nfserr;
 	int		hosterr;
 	dev_t		rdev = 0, wanted = new_decode_dev(attr->ia_size);
 
@@ -266,40 +270,40 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 		SVCFH_fmt(dirfhp), argp->len, argp->name);
 
 	/* First verify the parent file handle */
-	nfserr = fh_verify(rqstp, dirfhp, S_IFDIR, NFSD_MAY_EXEC);
-	if (nfserr)
+	resp->status = fh_verify(rqstp, dirfhp, S_IFDIR, NFSD_MAY_EXEC);
+	if (resp->status != nfs_ok)
 		goto done; /* must fh_put dirfhp even on error */
 
 	/* Check for NFSD_MAY_WRITE in nfsd_create if necessary */
 
-	nfserr = nfserr_exist;
+	resp->status = nfserr_exist;
 	if (isdotent(argp->name, argp->len))
 		goto done;
 	hosterr = fh_want_write(dirfhp);
 	if (hosterr) {
-		nfserr = nfserrno(hosterr);
+		resp->status = nfserrno(hosterr);
 		goto done;
 	}
 
 	fh_lock_nested(dirfhp, I_MUTEX_PARENT);
 	dchild = lookup_one_len(argp->name, dirfhp->fh_dentry, argp->len);
 	if (IS_ERR(dchild)) {
-		nfserr = nfserrno(PTR_ERR(dchild));
+		resp->status = nfserrno(PTR_ERR(dchild));
 		goto out_unlock;
 	}
 	fh_init(newfhp, NFS_FHSIZE);
-	nfserr = fh_compose(newfhp, dirfhp->fh_export, dchild, dirfhp);
-	if (!nfserr && d_really_is_negative(dchild))
-		nfserr = nfserr_noent;
+	resp->status = fh_compose(newfhp, dirfhp->fh_export, dchild, dirfhp);
+	if (!resp->status && d_really_is_negative(dchild))
+		resp->status = nfserr_noent;
 	dput(dchild);
-	if (nfserr) {
-		if (nfserr != nfserr_noent)
+	if (resp->status) {
+		if (resp->status != nfserr_noent)
 			goto out_unlock;
 		/*
 		 * If the new file handle wasn't verified, we can't tell
 		 * whether the file exists or not. Time to bail ...
 		 */
-		nfserr = nfserr_acces;
+		resp->status = nfserr_acces;
 		if (!newfhp->fh_dentry) {
 			printk(KERN_WARNING 
 				"nfsd_proc_create: file handle not verified\n");
@@ -332,11 +336,11 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 					 *   echo thing > device-special-file-or-pipe
 					 * by doing a CREATE with type==0
 					 */
-					nfserr = nfsd_permission(rqstp,
+					resp->status = nfsd_permission(rqstp,
 								 newfhp->fh_export,
 								 newfhp->fh_dentry,
 								 NFSD_MAY_WRITE|NFSD_MAY_LOCAL_ACCESS);
-					if (nfserr && nfserr != nfserr_rofs)
+					if (resp->status && resp->status != nfserr_rofs)
 						goto out_unlock;
 				}
 			} else
@@ -372,16 +376,17 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 		attr->ia_valid &= ~ATTR_SIZE;
 
 		/* Make sure the type and device matches */
-		nfserr = nfserr_exist;
+		resp->status = nfserr_exist;
 		if (inode && type != (inode->i_mode & S_IFMT))
 			goto out_unlock;
 	}
 
-	nfserr = 0;
+	resp->status = nfs_ok;
 	if (!inode) {
 		/* File doesn't exist. Create it and set attrs */
-		nfserr = nfsd_create_locked(rqstp, dirfhp, argp->name,
-					argp->len, attr, type, rdev, newfhp);
+		resp->status = nfsd_create_locked(rqstp, dirfhp, argp->name,
+						  argp->len, attr, type, rdev,
+						  newfhp);
 	} else if (type == S_IFREG) {
 		dprintk("nfsd:   existing %s, valid=%x, size=%ld\n",
 			argp->name, attr->ia_valid, (long) attr->ia_size);
@@ -391,7 +396,8 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 		 */
 		attr->ia_valid &= ATTR_SIZE;
 		if (attr->ia_valid)
-			nfserr = nfsd_setattr(rqstp, newfhp, attr, 0, (time64_t)0);
+			resp->status = nfsd_setattr(rqstp, newfhp, attr, 0,
+						    (time64_t)0);
 	}
 
 out_unlock:
@@ -400,7 +406,11 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 	fh_drop_write(dirfhp);
 done:
 	fh_put(dirfhp);
-	return nfsd_return_dirop(nfserr, resp);
+	if (resp->status != nfs_ok)
+		goto out;
+	resp->status = fh_getattr(&resp->fh, &resp->stat);
+out:
+	return resp->status;
 }
 
 static __be32
@@ -463,14 +473,18 @@ nfsd_proc_symlink(struct svc_rqst *rqstp)
 	struct svc_fh	newfh;
 	__be32		nfserr;
 
-	if (argp->tlen > NFS_MAXPATHLEN)
-		return nfserr_nametoolong;
+	if (argp->tlen > NFS_MAXPATHLEN) {
+		nfserr = nfserr_nametoolong;
+		goto out;
+	}
 
 	argp->tname = svc_fill_symlink_pathname(rqstp, &argp->first,
 						page_address(rqstp->rq_arg.pages[0]),
 						argp->tlen);
-	if (IS_ERR(argp->tname))
-		return nfserrno(PTR_ERR(argp->tname));
+	if (IS_ERR(argp->tname)) {
+		nfserr = nfserrno(PTR_ERR(argp->tname));
+		goto out;
+	}
 
 	dprintk("nfsd: SYMLINK  %s %.*s -> %.*s\n",
 		SVCFH_fmt(&argp->ffh), argp->flen, argp->fname,
@@ -483,6 +497,7 @@ nfsd_proc_symlink(struct svc_rqst *rqstp)
 	kfree(argp->tname);
 	fh_put(&argp->ffh);
 	fh_put(&newfh);
+out:
 	return nfserr;
 }
 
@@ -495,7 +510,6 @@ nfsd_proc_mkdir(struct svc_rqst *rqstp)
 {
 	struct nfsd_createargs *argp = rqstp->rq_argp;
 	struct nfsd_diropres *resp = rqstp->rq_resp;
-	__be32	nfserr;
 
 	dprintk("nfsd: MKDIR    %s %.*s\n", SVCFH_fmt(&argp->fh), argp->len, argp->name);
 
@@ -506,10 +520,15 @@ nfsd_proc_mkdir(struct svc_rqst *rqstp)
 
 	argp->attrs.ia_valid &= ~ATTR_SIZE;
 	fh_init(&resp->fh, NFS_FHSIZE);
-	nfserr = nfsd_create(rqstp, &argp->fh, argp->name, argp->len,
-				    &argp->attrs, S_IFDIR, 0, &resp->fh);
+	resp->status = nfsd_create(rqstp, &argp->fh, argp->name, argp->len,
+				   &argp->attrs, S_IFDIR, 0, &resp->fh);
 	fh_put(&argp->fh);
-	return nfsd_return_dirop(nfserr, resp);
+	if (resp->status != nfs_ok)
+		goto out;
+
+	resp->status = fh_getattr(&resp->fh, &resp->stat);
+out:
+	return resp->status;
 }
 
 /*
@@ -537,7 +556,6 @@ nfsd_proc_readdir(struct svc_rqst *rqstp)
 	struct nfsd_readdirargs *argp = rqstp->rq_argp;
 	struct nfsd_readdirres *resp = rqstp->rq_resp;
 	int		count;
-	__be32		nfserr;
 	loff_t		offset;
 
 	dprintk("nfsd: READDIR  %s %d bytes at %d\n",
@@ -558,15 +576,15 @@ nfsd_proc_readdir(struct svc_rqst *rqstp)
 	resp->common.err = nfs_ok;
 	/* Read directory and encode entries on the fly */
 	offset = argp->cookie;
-	nfserr = nfsd_readdir(rqstp, &argp->fh, &offset, 
-			      &resp->common, nfssvc_encode_entry);
+	resp->status = nfsd_readdir(rqstp, &argp->fh, &offset,
+				    &resp->common, nfssvc_encode_entry);
 
 	resp->count = resp->buffer - argp->buffer;
 	if (resp->offset)
 		*resp->offset = htonl(offset);
 
 	fh_put(&argp->fh);
-	return nfserr;
+	return resp->status;
 }
 
 /*
@@ -577,14 +595,13 @@ nfsd_proc_statfs(struct svc_rqst *rqstp)
 {
 	struct nfsd_fhandle *argp = rqstp->rq_argp;
 	struct nfsd_statfsres *resp = rqstp->rq_resp;
-	__be32	nfserr;
 
 	dprintk("nfsd: STATFS   %s\n", SVCFH_fmt(&argp->fh));
 
-	nfserr = nfsd_statfs(rqstp, &argp->fh, &resp->stats,
-			NFSD_MAY_BYPASS_GSS_ON_ROOT);
+	resp->status = nfsd_statfs(rqstp, &argp->fh, &resp->stats,
+				   NFSD_MAY_BYPASS_GSS_ON_ROOT);
 	fh_put(&argp->fh);
-	return nfserr;
+	return resp->status;
 }
 
 /*
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index e793344227c9..4aa8db879ca2 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1056,12 +1056,8 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 	if (rqstp->rq_proc != 0)
 		*nfserrp++ = nfserr;
 
-	/*
-	 * For NFSv2, additional info is never returned in case of an error.
-	 */
-	if (!(nfserr && rqstp->rq_vers == 2))
-		if (!proc->pc_encode(rqstp, nfserrp))
-			goto out_encode_err;
+	if (!proc->pc_encode(rqstp, nfserrp))
+		goto out_encode_err;
 
 	nfsd_cache_update(rqstp, rqstp->rq_cachetype, statp + 1);
 out_cached_reply:
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 39c004ec7d85..952e71c95d4e 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -434,6 +434,9 @@ nfssvc_encode_attrstat(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd_attrstat *resp = rqstp->rq_resp;
 
+	if (resp->status != nfs_ok)
+		return xdr_ressize_check(rqstp, p);
+
 	p = encode_fattr(rqstp, p, &resp->fh, &resp->stat);
 	return xdr_ressize_check(rqstp, p);
 }
@@ -443,6 +446,9 @@ nfssvc_encode_diropres(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd_diropres *resp = rqstp->rq_resp;
 
+	if (resp->status != nfs_ok)
+		return xdr_ressize_check(rqstp, p);
+
 	p = encode_fh(p, &resp->fh);
 	p = encode_fattr(rqstp, p, &resp->fh, &resp->stat);
 	return xdr_ressize_check(rqstp, p);
@@ -453,6 +459,9 @@ nfssvc_encode_readlinkres(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd_readlinkres *resp = rqstp->rq_resp;
 
+	if (resp->status != nfs_ok)
+		return xdr_ressize_check(rqstp, p);
+
 	*p++ = htonl(resp->len);
 	xdr_ressize_check(rqstp, p);
 	rqstp->rq_res.page_len = resp->len;
@@ -470,6 +479,9 @@ nfssvc_encode_readres(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd_readres *resp = rqstp->rq_resp;
 
+	if (resp->status != nfs_ok)
+		return xdr_ressize_check(rqstp, p);
+
 	p = encode_fattr(rqstp, p, &resp->fh, &resp->stat);
 	*p++ = htonl(resp->count);
 	xdr_ressize_check(rqstp, p);
@@ -490,6 +502,9 @@ nfssvc_encode_readdirres(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd_readdirres *resp = rqstp->rq_resp;
 
+	if (resp->status != nfs_ok)
+		return xdr_ressize_check(rqstp, p);
+
 	xdr_ressize_check(rqstp, p);
 	p = resp->buffer;
 	*p++ = 0;			/* no more entries */
@@ -505,6 +520,9 @@ nfssvc_encode_statfsres(struct svc_rqst *rqstp, __be32 *p)
 	struct nfsd_statfsres *resp = rqstp->rq_resp;
 	struct kstatfs	*stat = &resp->stats;
 
+	if (resp->status != nfs_ok)
+		return xdr_ressize_check(rqstp, p);
+
 	*p++ = htonl(NFSSVC_MAXBLKSIZE_V2);	/* max transfer size */
 	*p++ = htonl(stat->f_bsize);
 	*p++ = htonl(stat->f_blocks);
diff --git a/fs/nfsd/xdr.h b/fs/nfsd/xdr.h
index 3d3e16d48268..17221931815f 100644
--- a/fs/nfsd/xdr.h
+++ b/fs/nfsd/xdr.h
@@ -83,26 +83,32 @@ struct nfsd_readdirargs {
 };
 
 struct nfsd_attrstat {
+	__be32			status;
 	struct svc_fh		fh;
 	struct kstat		stat;
 };
 
 struct nfsd_diropres  {
+	__be32			status;
 	struct svc_fh		fh;
 	struct kstat		stat;
 };
 
 struct nfsd_readlinkres {
+	__be32			status;
 	int			len;
 };
 
 struct nfsd_readres {
+	__be32			status;
 	struct svc_fh		fh;
 	unsigned long		count;
 	struct kstat		stat;
 };
 
 struct nfsd_readdirres {
+	__be32			status;
+
 	int			count;
 
 	struct readdir_cd	common;
@@ -112,6 +118,7 @@ struct nfsd_readdirres {
 };
 
 struct nfsd_statfsres {
+	__be32			status;
 	struct kstatfs		stats;
 };
 


