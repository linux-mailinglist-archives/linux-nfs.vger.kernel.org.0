Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94CDC27D082
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Sep 2020 16:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbgI2OEi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Sep 2020 10:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730077AbgI2OEi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Sep 2020 10:04:38 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC23FC061755
        for <linux-nfs@vger.kernel.org>; Tue, 29 Sep 2020 07:04:37 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id e5so4967316ilr.8
        for <linux-nfs@vger.kernel.org>; Tue, 29 Sep 2020 07:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=PSBAnYdCaKpQyLEXmIpUuzAlW0Ekz2CprOd+LEta5Go=;
        b=gvcT6LREXkXqwX40ImsqcY9b9ubsuSNA/GN80US1mSgEt/oIcOxgeFGUOWJbQomNfY
         P0PkLVNLNAMTQXtE77UxYmC6UWmhZQhqyxCKtrE1M9aIoWZlPyFU7yCQUjbMI47KXS4S
         kK3nIhYnIeoe5XnF95bgSPaJKSTzTJt016h+bE6tBsvSHgLUqKSNo7e5aBS/PIIGBEyD
         bPn3tNzt3kA1v9C08GJ3Bza20AGLb9rkhHs78hYkkzhFoX8pTc6zmquqxDIpGi+UKyma
         17KkKv3bPyHJJQt4xnaNisuqGw+QXswVWL+UCsImNVlvbEm6yQ8xVYpiyuYNUS5D3LCP
         2nbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=PSBAnYdCaKpQyLEXmIpUuzAlW0Ekz2CprOd+LEta5Go=;
        b=mIF7npMafz4E/nUQ4FXKI5w/pQDoX4MSYlS7im1yCuTdiEOY5U9yyLcSMTGiAqfOyU
         M8C5MlfTbvK22SqMkaA7iRGk1mE7qcOCt4lO+fRihi0PZ2mDVfdVkyV2WHXRWYFRy9qe
         ErK4CA7qXLCTwbg+QmeYGMw18ov+9Zxzge+G/KbEZI2ixgKEhZy8Vu2GYnvfUuqpq2wY
         kd+hxhhQAtyO8StWI9oU2yFMI+H9xnwqJC/iIMjuQ2zf0A5149KK4n/AofRRFXbJkqjt
         w06tz1UCZ23CQLcWke+8uGqe0zCfOee9B+S1oGc98newoe7hq0mmadjYDxehU1vnPRt2
         HHaw==
X-Gm-Message-State: AOAM5304BgIkqzzLue65E2wuK8L9HqN0lSb+rAnCiDFQhLwyVr7XRJrJ
        L9262QjOqqRUBRSDSqDclzI=
X-Google-Smtp-Source: ABdhPJwqhiJDL2nfB0M4uVGhj2m4V6D0T2Yt7X1llflNGXTP+eOf03VfAFNh+d8Ewnj7nnoOcTlwoQ==
X-Received: by 2002:a92:96c3:: with SMTP id g186mr1225177ilh.8.1601388276994;
        Tue, 29 Sep 2020 07:04:36 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id z15sm2405893ilb.73.2020.09.29.07.04.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Sep 2020 07:04:36 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08TE4ZUs026445;
        Tue, 29 Sep 2020 14:04:35 GMT
Subject: [PATCH v2 11/11] NFSD: Call NFSv2 encoders on error returns
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 29 Sep 2020 10:04:35 -0400
Message-ID: <160138827523.2558.10662502652461223634.stgit@klimt.1015granger.net>
In-Reply-To: <160138785101.2558.11821923574884893011.stgit@klimt.1015granger.net>
References: <160138785101.2558.11821923574884893011.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Eventually we want to deprecate NFSv2 entirely.

Remove special dispatcher logic for NFSv2 error responses. These are
rare to the point of becoming extinct, but all NFS responses have to
pay the cost of the extra conditional branches.

This also means the NFSv2 error cases now get proper
xdr_ressize_check() calls.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs2acl.c |    9 +++
 fs/nfsd/nfsproc.c |  159 +++++++++++++++++++++++++++--------------------------
 fs/nfsd/nfssvc.c  |    8 +--
 fs/nfsd/nfsxdr.c  |   18 ++++++
 fs/nfsd/xdr.h     |    7 ++
 5 files changed, 118 insertions(+), 83 deletions(-)

diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 3c8b9250dc4a..70b3a90cfe92 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -273,6 +273,9 @@ static int nfsaclsvc_encode_getaclres(struct svc_rqst *rqstp, __be32 *p)
 	int n;
 	int w;
 
+	if (resp->status != nfs_ok)
+		return xdr_ressize_check(rqstp, p);
+
 	/*
 	 * Since this is version 2, the check for nfserr in
 	 * nfsd_dispatch actually ensures the following cannot happen.
@@ -312,6 +315,9 @@ static int nfsaclsvc_encode_attrstatres(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd_attrstat *resp = rqstp->rq_resp;
 
+	if (resp->status != nfs_ok)
+		return xdr_ressize_check(rqstp, p);
+
 	p = nfs2svc_encode_fattr(rqstp, p, &resp->fh, &resp->stat);
 	return xdr_ressize_check(rqstp, p);
 }
@@ -321,6 +327,9 @@ static int nfsaclsvc_encode_accessres(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd3_accessres *resp = rqstp->rq_resp;
 
+	if (resp->status != nfs_ok)
+		return xdr_ressize_check(rqstp, p);
+
 	p = nfs2svc_encode_fattr(rqstp, p, &resp->fh, &resp->stat);
 	*p++ = htonl(resp->access);
 	return xdr_ressize_check(rqstp, p);
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 33204d83709c..9727f2fdf5e4 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -16,6 +16,7 @@ typedef struct svc_buf	svc_buf;
 
 #define NFSDDBG_FACILITY		NFSDDBG_PROC
 
+#define RETURN_STATUS(st)	{ resp->status = (st); return (st); }
 
 static __be32
 nfsd_proc_null(struct svc_rqst *rqstp)
@@ -23,18 +24,6 @@ nfsd_proc_null(struct svc_rqst *rqstp)
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
@@ -44,13 +33,17 @@ nfsd_proc_getattr(struct svc_rqst *rqstp)
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
+		return resp->status;
+
+	resp->status = fh_getattr(&resp->fh, &resp->stat);
+	return resp->status;
 }
 
 /*
@@ -64,7 +57,6 @@ nfsd_proc_setattr(struct svc_rqst *rqstp)
 	struct nfsd_attrstat *resp = rqstp->rq_resp;
 	struct iattr *iap = &argp->attrs;
 	struct svc_fh *fhp;
-	__be32 nfserr;
 
 	dprintk("nfsd: SETATTR  %s, valid=%x, size=%ld\n",
 		SVCFH_fmt(&argp->fh),
@@ -96,9 +88,9 @@ nfsd_proc_setattr(struct svc_rqst *rqstp)
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
@@ -113,9 +105,12 @@ nfsd_proc_setattr(struct svc_rqst *rqstp)
 		}
 	}
 
-	nfserr = nfsd_setattr(rqstp, fhp, iap, 0, (time64_t)0);
-done:
-	return nfsd_return_attrs(nfserr, resp);
+	resp->status = nfsd_setattr(rqstp, fhp, iap, 0, (time64_t)0);
+	if (resp->status != nfs_ok)
+		return resp->status;
+
+	resp->status = fh_getattr(&resp->fh, &resp->stat);
+	return resp->status;
 }
 
 /*
@@ -129,17 +124,19 @@ nfsd_proc_lookup(struct svc_rqst *rqstp)
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
+		return resp->status;
+
+	resp->status = fh_getattr(&resp->fh, &resp->stat);
+	return resp->status;
 }
 
 /*
@@ -150,16 +147,15 @@ nfsd_proc_readlink(struct svc_rqst *rqstp)
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
@@ -171,7 +167,6 @@ nfsd_proc_read(struct svc_rqst *rqstp)
 {
 	struct nfsd_readargs *argp = rqstp->rq_argp;
 	struct nfsd_readres *resp = rqstp->rq_resp;
-	__be32	nfserr;
 	u32 eof;
 
 	dprintk("nfsd: READ    %s %d bytes at %d\n",
@@ -193,14 +188,16 @@ nfsd_proc_read(struct svc_rqst *rqstp)
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
+		return resp->status;
+
+	resp->status = fh_getattr(&resp->fh, &resp->stat);
+	return resp->status;
 }
 
 /*
@@ -212,7 +209,6 @@ nfsd_proc_write(struct svc_rqst *rqstp)
 {
 	struct nfsd_writeargs *argp = rqstp->rq_argp;
 	struct nfsd_attrstat *resp = rqstp->rq_resp;
-	__be32	nfserr;
 	unsigned long cnt = argp->len;
 	unsigned int nvecs;
 
@@ -224,10 +220,14 @@ nfsd_proc_write(struct svc_rqst *rqstp)
 				      &argp->first, cnt);
 	if (!nvecs)
 		return nfserr_io;
-	nfserr = nfsd_write(rqstp, fh_copy(&resp->fh, &argp->fh),
-			    argp->offset, rqstp->rq_vec, nvecs,
-			    &cnt, NFS_DATA_SYNC, NULL);
-	return nfsd_return_attrs(nfserr, resp);
+	resp->status = nfsd_write(rqstp, fh_copy(&resp->fh, &argp->fh),
+				  argp->offset, rqstp->rq_vec, nvecs,
+				  &cnt, NFS_DATA_SYNC, NULL);
+	if (resp->status != nfs_ok)
+		return resp->status;
+
+	resp->status = fh_getattr(&resp->fh, &resp->stat);
+	return resp->status;
 }
 
 /*
@@ -247,7 +247,6 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 	struct inode	*inode;
 	struct dentry	*dchild;
 	int		type, mode;
-	__be32		nfserr;
 	int		hosterr;
 	dev_t		rdev = 0, wanted = new_decode_dev(attr->ia_size);
 
@@ -255,40 +254,40 @@ nfsd_proc_create(struct svc_rqst *rqstp)
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
@@ -321,11 +320,11 @@ nfsd_proc_create(struct svc_rqst *rqstp)
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
@@ -361,16 +360,17 @@ nfsd_proc_create(struct svc_rqst *rqstp)
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
@@ -380,7 +380,8 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 		 */
 		attr->ia_valid &= ATTR_SIZE;
 		if (attr->ia_valid)
-			nfserr = nfsd_setattr(rqstp, newfhp, attr, 0, (time64_t)0);
+			resp->status = nfsd_setattr(rqstp, newfhp, attr, 0,
+						    (time64_t)0);
 	}
 
 out_unlock:
@@ -389,7 +390,10 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 	fh_drop_write(dirfhp);
 done:
 	fh_put(dirfhp);
-	return nfsd_return_dirop(nfserr, resp);
+	if (resp->status != nfs_ok)
+		return resp->status;
+	resp->status = fh_getattr(&resp->fh, &resp->stat);
+	return resp->status;
 }
 
 static __be32
@@ -484,7 +488,6 @@ nfsd_proc_mkdir(struct svc_rqst *rqstp)
 {
 	struct nfsd_createargs *argp = rqstp->rq_argp;
 	struct nfsd_diropres *resp = rqstp->rq_resp;
-	__be32	nfserr;
 
 	dprintk("nfsd: MKDIR    %s %.*s\n", SVCFH_fmt(&argp->fh), argp->len, argp->name);
 
@@ -495,10 +498,14 @@ nfsd_proc_mkdir(struct svc_rqst *rqstp)
 
 	argp->attrs.ia_valid &= ~ATTR_SIZE;
 	fh_init(&resp->fh, NFS_FHSIZE);
-	nfserr = nfsd_create(rqstp, &argp->fh, argp->name, argp->len,
-				    &argp->attrs, S_IFDIR, 0, &resp->fh);
+	resp->status = nfsd_create(rqstp, &argp->fh, argp->name, argp->len,
+				   &argp->attrs, S_IFDIR, 0, &resp->fh);
 	fh_put(&argp->fh);
-	return nfsd_return_dirop(nfserr, resp);
+	if (resp->status != nfs_ok)
+		return resp->status;
+
+	resp->status = fh_getattr(&resp->fh, &resp->stat);
+	return resp->status;
 }
 
 /*
@@ -526,7 +533,6 @@ nfsd_proc_readdir(struct svc_rqst *rqstp)
 	struct nfsd_readdirargs *argp = rqstp->rq_argp;
 	struct nfsd_readdirres *resp = rqstp->rq_resp;
 	int		count;
-	__be32		nfserr;
 	loff_t		offset;
 
 	dprintk("nfsd: READDIR  %s %d bytes at %d\n",
@@ -547,15 +553,15 @@ nfsd_proc_readdir(struct svc_rqst *rqstp)
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
@@ -566,14 +572,13 @@ nfsd_proc_statfs(struct svc_rqst *rqstp)
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
index 08776b44cde6..9faf9224ef62 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1056,12 +1056,8 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 	if (rqstp->rq_proc != 0)
 		*p++ = nfserr;
 
-	/*
-	 * For NFSv2, additional info is never returned in case of an error.
-	 */
-	if (!(nfserr && rqstp->rq_vers == 2))
-		if (!proc->pc_encode(rqstp, p))
-			goto out_encode_err;
+	if (!proc->pc_encode(rqstp, p))
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
 


