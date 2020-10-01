Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0D0280ABE
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Oct 2020 01:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbgJAXA1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Oct 2020 19:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733119AbgJAXAI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Oct 2020 19:00:08 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC79C0613E3
        for <linux-nfs@vger.kernel.org>; Thu,  1 Oct 2020 16:00:08 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id s131so44600qke.0
        for <linux-nfs@vger.kernel.org>; Thu, 01 Oct 2020 16:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=W7bWTNBcIqM/lpglPNmziEyNx9mZl5g7pmGHxaknZ3o=;
        b=B9jG6UDkM2A3u/tL7V+CuiQ/+n+DDEVa3sS73XYX02LS7Y2hjp7WN5O0liErqXGUbO
         frG3q4mAxcCFXMN13NLHtGQKPbxwXWqGP2YAr46XhgrnSTzaHjBItDI1it7B5vLK9uu7
         WJHw4Zgn3W68xcGYMXwCZ1EG6ay6YWA3VsS2H3pTjUVVR4KSY3XowsYYDWdEdo8Sb6qR
         3Ozo68h0vAWUJAznshIJ2T4g6SXF65IIWvbkWimbR/sgxx8m3DFqP9wujez1CvoUYjyS
         mrqOJhgqjvVt2A4+R8D56KQVSNLpQEQ20+1CIaa0SxjLtc8drsWTuvq5gjLQbkAputTq
         zQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=W7bWTNBcIqM/lpglPNmziEyNx9mZl5g7pmGHxaknZ3o=;
        b=DREAKPZnWcZiku4qUoAyaft4P24aNk+uxMD5hb3D8iZuA8RzKQg1+00iMbILVgGuot
         KEdg0QHN8ty7vQOvJZN93cqFho5UmWUV3bXZEivib5FnypjRrVecCE/n/kFBHR9AuNtr
         HoixOPrE2SAsXDy9u5ck0MTbVP32j04FggKu6dNzKXgd0OWkeIX/QSUUxoUbmzRsjQ4t
         YUs9FHnVkShATASLxTJXRdXjz7tcScjovI0GKQSGa4dGYZnBZBeI6DS40Gz5t8/UAyh6
         WEur+ujYHLStQ8aDd66L+wdwBsA4BiaNvwEBTIHfy30xJ2iW3CAntmo6ru09GC/X1/eb
         SL+A==
X-Gm-Message-State: AOAM53191s9e5R5mrHclNVSxzHxDwTtASahwCawZpno6xszGVF1HHhOj
        T4ye5GTSMPxnBhSzEB8e0bqMDDQBXfS1gg==
X-Google-Smtp-Source: ABdhPJwl9tgjdzF/5URpYs51n1W8Y3OzPwRVWiCc2isPRB8yLMRfwbDGfemlhOlFuqhU/x9v/NBOqw==
X-Received: by 2002:a05:620a:958:: with SMTP id w24mr10266529qkw.65.1601593207018;
        Thu, 01 Oct 2020 16:00:07 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 192sm7965927qkn.9.2020.10.01.16.00.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Oct 2020 16:00:06 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 091N05Uh032617;
        Thu, 1 Oct 2020 23:00:05 GMT
Subject: [PATCH v3 15/15] NFSD: Hoist status code encoding into XDR encoder
 functions
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 01 Oct 2020 19:00:05 -0400
Message-ID: <160159320529.79253.2384123890533013768.stgit@klimt.1015granger.net>
In-Reply-To: <160159301676.79253.16488984581431975601.stgit@klimt.1015granger.net>
References: <160159301676.79253.16488984581431975601.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The original intent was presumably to reduce code duplication. The
trade-off was:

- No support for an NFSD proc function returning a non-success
  RPC accept_stat value.
- No support for void NFS replies to non-NULL procedures.
- Everyone pays for the deduplication with a few extra conditional
  branches in a hot path.

In addition, nfsd_dispatch() leaves *statp uninitialized in the
success path, unlike svc_generic_dispatch().

Address all of these problems by moving the logic for encoding
the NFS status code into the NFS XDR encoders themselves. Then
update the NFS .pc_func methods to return an RPC accept_stat
value.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs2acl.c  |   19 ++++++---
 fs/nfsd/nfs3acl.c  |    9 ++--
 fs/nfsd/nfs3proc.c |   44 ++++++++++-----------
 fs/nfsd/nfs3xdr.c  |   19 +++++++--
 fs/nfsd/nfs4proc.c |    5 +-
 fs/nfsd/nfs4xdr.c  |    5 +-
 fs/nfsd/nfsproc.c  |  111 ++++++++++++++++++++++++++--------------------------
 fs/nfsd/nfssvc.c   |   21 ++--------
 fs/nfsd/nfsxdr.c   |   23 +++++++++--
 fs/nfsd/xdr.h      |    5 ++
 10 files changed, 143 insertions(+), 118 deletions(-)

diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 6f46afdb0616..6a900f770dd2 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -21,7 +21,7 @@
 static __be32
 nfsacld_proc_null(struct svc_rqst *rqstp)
 {
-	return nfs_ok;
+	return rpc_success;
 }
 
 /*
@@ -79,7 +79,7 @@ static __be32 nfsacld_proc_getacl(struct svc_rqst *rqstp)
 
 	/* resp->acl_{access,default} are released in nfssvc_release_getacl. */
 out:
-	return resp->status;
+	return rpc_success;
 
 fail:
 	posix_acl_release(resp->acl_access);
@@ -131,7 +131,7 @@ static __be32 nfsacld_proc_setacl(struct svc_rqst *rqstp)
 	   nfssvc_decode_setaclargs. */
 	posix_acl_release(argp->acl_access);
 	posix_acl_release(argp->acl_default);
-	return resp->status;
+	return rpc_success;
 
 out_drop_lock:
 	fh_unlock(fh);
@@ -157,7 +157,7 @@ static __be32 nfsacld_proc_getattr(struct svc_rqst *rqstp)
 		goto out;
 	resp->status = fh_getattr(&resp->fh, &resp->stat);
 out:
-	return resp->status;
+	return rpc_success;
 }
 
 /*
@@ -179,7 +179,7 @@ static __be32 nfsacld_proc_access(struct svc_rqst *rqstp)
 		goto out;
 	resp->status = fh_getattr(&resp->fh, &resp->stat);
 out:
-	return resp->status;
+	return rpc_success;
 }
 
 /*
@@ -275,6 +275,7 @@ static int nfsaclsvc_encode_getaclres(struct svc_rqst *rqstp, __be32 *p)
 	int n;
 	int w;
 
+	*p++ = resp->status;
 	if (resp->status != nfs_ok)
 		return xdr_ressize_check(rqstp, p);
 
@@ -317,10 +318,12 @@ static int nfsaclsvc_encode_attrstatres(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd_attrstat *resp = rqstp->rq_resp;
 
+	*p++ = resp->status;
 	if (resp->status != nfs_ok)
-		return xdr_ressize_check(rqstp, p);
+		goto out;
 
 	p = nfs2svc_encode_fattr(rqstp, p, &resp->fh, &resp->stat);
+out:
 	return xdr_ressize_check(rqstp, p);
 }
 
@@ -329,11 +332,13 @@ static int nfsaclsvc_encode_accessres(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd3_accessres *resp = rqstp->rq_resp;
 
+	*p++ = resp->status;
 	if (resp->status != nfs_ok)
-		return xdr_ressize_check(rqstp, p);
+		goto out;
 
 	p = nfs2svc_encode_fattr(rqstp, p, &resp->fh, &resp->stat);
 	*p++ = htonl(resp->access);
+out:
 	return xdr_ressize_check(rqstp, p);
 }
 
diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index 3fee24dee98c..34a394e50e1d 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -19,7 +19,7 @@
 static __be32
 nfsd3_proc_null(struct svc_rqst *rqstp)
 {
-	return nfs_ok;
+	return rpc_success;
 }
 
 /*
@@ -71,7 +71,7 @@ static __be32 nfsd3_proc_getacl(struct svc_rqst *rqstp)
 
 	/* resp->acl_{access,default} are released in nfs3svc_release_getacl. */
 out:
-	return resp->status;
+	return rpc_success;
 
 fail:
 	posix_acl_release(resp->acl_access);
@@ -118,7 +118,7 @@ static __be32 nfsd3_proc_setacl(struct svc_rqst *rqstp)
 	   nfs3svc_decode_setaclargs. */
 	posix_acl_release(argp->acl_access);
 	posix_acl_release(argp->acl_default);
-	return resp->status;
+	return rpc_success;
 }
 
 /*
@@ -173,6 +173,7 @@ static int nfs3svc_encode_getaclres(struct svc_rqst *rqstp, __be32 *p)
 	struct nfsd3_getaclres *resp = rqstp->rq_resp;
 	struct dentry *dentry = resp->fh.fh_dentry;
 
+	*p++ = resp->status;
 	p = nfs3svc_encode_post_op_attr(rqstp, p, &resp->fh);
 	if (resp->status == 0 && dentry && d_really_is_positive(dentry)) {
 		struct inode *inode = d_inode(dentry);
@@ -217,8 +218,8 @@ static int nfs3svc_encode_setaclres(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd3_attrstat *resp = rqstp->rq_resp;
 
+	*p++ = resp->status;
 	p = nfs3svc_encode_post_op_attr(rqstp, p, &resp->fh);
-
 	return xdr_ressize_check(rqstp, p);
 }
 
diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 1d2c149e5ff4..14468613d150 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -32,7 +32,7 @@ static int	nfs3_ftypes[] = {
 static __be32
 nfsd3_proc_null(struct svc_rqst *rqstp)
 {
-	return nfs_ok;
+	return rpc_success;
 }
 
 /*
@@ -55,7 +55,7 @@ nfsd3_proc_getattr(struct svc_rqst *rqstp)
 
 	resp->status = fh_getattr(&resp->fh, &resp->stat);
 out:
-	return resp->status;
+	return rpc_success;
 }
 
 /*
@@ -73,7 +73,7 @@ nfsd3_proc_setattr(struct svc_rqst *rqstp)
 	fh_copy(&resp->fh, &argp->fh);
 	resp->status = nfsd_setattr(rqstp, &resp->fh, &argp->attrs,
 				    argp->check_guard, argp->guardtime);
-	return resp->status;
+	return rpc_success;
 }
 
 /*
@@ -96,7 +96,7 @@ nfsd3_proc_lookup(struct svc_rqst *rqstp)
 	resp->status = nfsd_lookup(rqstp, &resp->dirfh,
 				   argp->name, argp->len,
 				   &resp->fh);
-	return resp->status;
+	return rpc_success;
 }
 
 /*
@@ -115,7 +115,7 @@ nfsd3_proc_access(struct svc_rqst *rqstp)
 	fh_copy(&resp->fh, &argp->fh);
 	resp->access = argp->access;
 	resp->status = nfsd_access(rqstp, &resp->fh, &resp->access, NULL);
-	return resp->status;
+	return rpc_success;
 }
 
 /*
@@ -133,7 +133,7 @@ nfsd3_proc_readlink(struct svc_rqst *rqstp)
 	fh_copy(&resp->fh, &argp->fh);
 	resp->len = NFS3_MAXPATHLEN;
 	resp->status = nfsd_readlink(rqstp, &resp->fh, argp->buffer, &resp->len);
-	return resp->status;
+	return rpc_success;
 }
 
 /*
@@ -163,7 +163,7 @@ nfsd3_proc_read(struct svc_rqst *rqstp)
 	resp->status = nfsd_read(rqstp, &resp->fh, argp->offset,
 				 rqstp->rq_vec, argp->vlen, &resp->count,
 				 &resp->eof);
-	return resp->status;
+	return rpc_success;
 }
 
 /*
@@ -196,7 +196,7 @@ nfsd3_proc_write(struct svc_rqst *rqstp)
 				  resp->committed, resp->verf);
 	resp->count = cnt;
 out:
-	return resp->status;
+	return rpc_success;
 }
 
 /*
@@ -234,7 +234,7 @@ nfsd3_proc_create(struct svc_rqst *rqstp)
 	resp->status = do_nfsd_create(rqstp, dirfhp, argp->name, argp->len,
 				      attr, newfhp, argp->createmode,
 				      (u32 *)argp->verf, NULL, NULL);
-	return resp->status;
+	return rpc_success;
 }
 
 /*
@@ -257,7 +257,7 @@ nfsd3_proc_mkdir(struct svc_rqst *rqstp)
 	resp->status = nfsd_create(rqstp, &resp->dirfh, argp->name, argp->len,
 				   &argp->attrs, S_IFDIR, 0, &resp->fh);
 	fh_unlock(&resp->dirfh);
-	return resp->status;
+	return rpc_success;
 }
 
 static __be32
@@ -294,7 +294,7 @@ nfsd3_proc_symlink(struct svc_rqst *rqstp)
 				    argp->flen, argp->tname, &resp->fh);
 	kfree(argp->tname);
 out:
-	return resp->status;
+	return rpc_success;
 }
 
 /*
@@ -337,7 +337,7 @@ nfsd3_proc_mknod(struct svc_rqst *rqstp)
 				   &argp->attrs, type, rdev, &resp->fh);
 	fh_unlock(&resp->dirfh);
 out:
-	return resp->status;
+	return rpc_success;
 }
 
 /*
@@ -359,7 +359,7 @@ nfsd3_proc_remove(struct svc_rqst *rqstp)
 	resp->status = nfsd_unlink(rqstp, &resp->fh, -S_IFDIR,
 				   argp->name, argp->len);
 	fh_unlock(&resp->fh);
-	return resp->status;
+	return rpc_success;
 }
 
 /*
@@ -380,7 +380,7 @@ nfsd3_proc_rmdir(struct svc_rqst *rqstp)
 	resp->status = nfsd_unlink(rqstp, &resp->fh, S_IFDIR,
 				   argp->name, argp->len);
 	fh_unlock(&resp->fh);
-	return resp->status;
+	return rpc_success;
 }
 
 static __be32
@@ -402,7 +402,7 @@ nfsd3_proc_rename(struct svc_rqst *rqstp)
 	fh_copy(&resp->tfh, &argp->tfh);
 	resp->status = nfsd_rename(rqstp, &resp->ffh, argp->fname, argp->flen,
 				   &resp->tfh, argp->tname, argp->tlen);
-	return resp->status;
+	return rpc_success;
 }
 
 static __be32
@@ -422,7 +422,7 @@ nfsd3_proc_link(struct svc_rqst *rqstp)
 	fh_copy(&resp->tfh, &argp->tfh);
 	resp->status = nfsd_link(rqstp, &resp->tfh, argp->tname, argp->tlen,
 				 &resp->fh);
-	return resp->status;
+	return rpc_success;
 }
 
 /*
@@ -481,7 +481,7 @@ nfsd3_proc_readdir(struct svc_rqst *rqstp)
 		resp->offset = NULL;
 	}
 
-	return resp->status;
+	return rpc_success;
 }
 
 /*
@@ -551,7 +551,7 @@ nfsd3_proc_readdirplus(struct svc_rqst *rqstp)
 	}
 
 out:
-	return resp->status;
+	return rpc_success;
 }
 
 /*
@@ -568,7 +568,7 @@ nfsd3_proc_fsstat(struct svc_rqst *rqstp)
 
 	resp->status = nfsd_statfs(rqstp, &argp->fh, &resp->stats, 0);
 	fh_put(&argp->fh);
-	return resp->status;
+	return rpc_success;
 }
 
 /*
@@ -611,7 +611,7 @@ nfsd3_proc_fsinfo(struct svc_rqst *rqstp)
 	}
 
 	fh_put(&argp->fh);
-	return resp->status;
+	return rpc_success;
 }
 
 /*
@@ -653,7 +653,7 @@ nfsd3_proc_pathconf(struct svc_rqst *rqstp)
 	}
 
 	fh_put(&argp->fh);
-	return resp->status;
+	return rpc_success;
 }
 
 /*
@@ -679,7 +679,7 @@ nfsd3_proc_commit(struct svc_rqst *rqstp)
 	resp->status = nfsd_commit(rqstp, &resp->fh, argp->offset,
 				   argp->count, resp->verf);
 out:
-	return resp->status;
+	return rpc_success;
 }
 
 
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index e540fd1a29d8..9c23b6acf234 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -641,10 +641,7 @@ nfs3svc_decode_commitargs(struct svc_rqst *rqstp, __be32 *p)
 /*
  * XDR encode functions
  */
-/*
- * There must be an encoding function for void results so svc_process
- * will work properly.
- */
+
 int
 nfs3svc_encode_voidres(struct svc_rqst *rqstp, __be32 *p)
 {
@@ -657,6 +654,7 @@ nfs3svc_encode_attrstat(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd3_attrstat *resp = rqstp->rq_resp;
 
+	*p++ = resp->status;
 	if (resp->status == 0) {
 		lease_get_mtime(d_inode(resp->fh.fh_dentry),
 				&resp->stat.mtime);
@@ -671,6 +669,7 @@ nfs3svc_encode_wccstat(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd3_attrstat *resp = rqstp->rq_resp;
 
+	*p++ = resp->status;
 	p = encode_wcc_data(rqstp, p, &resp->fh);
 	return xdr_ressize_check(rqstp, p);
 }
@@ -681,6 +680,7 @@ nfs3svc_encode_diropres(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd3_diropres *resp = rqstp->rq_resp;
 
+	*p++ = resp->status;
 	if (resp->status == 0) {
 		p = encode_fh(p, &resp->fh);
 		p = encode_post_op_attr(rqstp, p, &resp->fh);
@@ -695,6 +695,7 @@ nfs3svc_encode_accessres(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd3_accessres *resp = rqstp->rq_resp;
 
+	*p++ = resp->status;
 	p = encode_post_op_attr(rqstp, p, &resp->fh);
 	if (resp->status == 0)
 		*p++ = htonl(resp->access);
@@ -707,6 +708,7 @@ nfs3svc_encode_readlinkres(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd3_readlinkres *resp = rqstp->rq_resp;
 
+	*p++ = resp->status;
 	p = encode_post_op_attr(rqstp, p, &resp->fh);
 	if (resp->status == 0) {
 		*p++ = htonl(resp->len);
@@ -729,6 +731,7 @@ nfs3svc_encode_readres(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd3_readres *resp = rqstp->rq_resp;
 
+	*p++ = resp->status;
 	p = encode_post_op_attr(rqstp, p, &resp->fh);
 	if (resp->status == 0) {
 		*p++ = htonl(resp->count);
@@ -754,6 +757,7 @@ nfs3svc_encode_writeres(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd3_writeres *resp = rqstp->rq_resp;
 
+	*p++ = resp->status;
 	p = encode_wcc_data(rqstp, p, &resp->fh);
 	if (resp->status == 0) {
 		*p++ = htonl(resp->count);
@@ -770,6 +774,7 @@ nfs3svc_encode_createres(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd3_diropres *resp = rqstp->rq_resp;
 
+	*p++ = resp->status;
 	if (resp->status == 0) {
 		*p++ = xdr_one;
 		p = encode_fh(p, &resp->fh);
@@ -785,6 +790,7 @@ nfs3svc_encode_renameres(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd3_renameres *resp = rqstp->rq_resp;
 
+	*p++ = resp->status;
 	p = encode_wcc_data(rqstp, p, &resp->ffh);
 	p = encode_wcc_data(rqstp, p, &resp->tfh);
 	return xdr_ressize_check(rqstp, p);
@@ -796,6 +802,7 @@ nfs3svc_encode_linkres(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd3_linkres *resp = rqstp->rq_resp;
 
+	*p++ = resp->status;
 	p = encode_post_op_attr(rqstp, p, &resp->fh);
 	p = encode_wcc_data(rqstp, p, &resp->tfh);
 	return xdr_ressize_check(rqstp, p);
@@ -807,6 +814,7 @@ nfs3svc_encode_readdirres(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd3_readdirres *resp = rqstp->rq_resp;
 
+	*p++ = resp->status;
 	p = encode_post_op_attr(rqstp, p, &resp->fh);
 
 	if (resp->status == 0) {
@@ -1059,6 +1067,7 @@ nfs3svc_encode_fsstatres(struct svc_rqst *rqstp, __be32 *p)
 	struct kstatfs	*s = &resp->stats;
 	u64		bs = s->f_bsize;
 
+	*p++ = resp->status;
 	*p++ = xdr_zero;	/* no post_op_attr */
 
 	if (resp->status == 0) {
@@ -1079,6 +1088,7 @@ nfs3svc_encode_fsinfores(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd3_fsinfores *resp = rqstp->rq_resp;
 
+	*p++ = resp->status;
 	*p++ = xdr_zero;	/* no post_op_attr */
 
 	if (resp->status == 0) {
@@ -1124,6 +1134,7 @@ nfs3svc_encode_commitres(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd3_commitres *resp = rqstp->rq_resp;
 
+	*p++ = resp->status;
 	p = encode_wcc_data(rqstp, p, &resp->fh);
 	/* Write verifier */
 	if (resp->status == 0) {
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index b99c050797db..efef9ebe652f 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2165,7 +2165,7 @@ nfsd4_removexattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 static __be32
 nfsd4_proc_null(struct svc_rqst *rqstp)
 {
-	return nfs_ok;
+	return rpc_success;
 }
 
 static inline void nfsd4_increment_op_stats(u32 opnum)
@@ -2464,8 +2464,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 out:
 	/* Reset deferral mechanism for RPC deferrals */
 	set_bit(RQ_USEDEFERRAL, &rqstp->rq_flags);
-	dprintk("nfsv4 compound returned %d\n", ntohl(status));
-	return status;
+	return rpc_success;
 }
 
 #define op_encode_hdr_size		(2)
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 758d8154a5b3..073f8be7555c 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5189,15 +5189,14 @@ nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfs4svc_encode_compoundres(struct svc_rqst *rqstp, __be32 *p)
 {
-	/*
-	 * All that remains is to write the tag and operation count...
-	 */
 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
 	struct xdr_buf *buf = resp->xdr.buf;
 
 	WARN_ON_ONCE(buf->len != buf->head[0].iov_len + buf->page_len +
 				 buf->tail[0].iov_len);
 
+	*p = resp->cstate.status;
+
 	rqstp->rq_next_page = resp->xdr.page_ptr + 1;
 
 	p = resp->tagp;
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 526170319ecf..f2450c719032 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -16,7 +16,7 @@
 static __be32
 nfsd_proc_null(struct svc_rqst *rqstp)
 {
-	return nfs_ok;
+	return rpc_success;
 }
 
 /*
@@ -38,7 +38,7 @@ nfsd_proc_getattr(struct svc_rqst *rqstp)
 		goto out;
 	resp->status = fh_getattr(&resp->fh, &resp->stat);
 out:
-	return resp->status;
+	return rpc_success;
 }
 
 /*
@@ -106,14 +106,14 @@ nfsd_proc_setattr(struct svc_rqst *rqstp)
 
 	resp->status = fh_getattr(&resp->fh, &resp->stat);
 out:
-	return resp->status;
+	return rpc_success;
 }
 
 /* Obsolete, replaced by MNTPROC_MNT. */
 static __be32
 nfsd_proc_root(struct svc_rqst *rqstp)
 {
-	return nfs_ok;
+	return rpc_success;
 }
 
 /*
@@ -140,7 +140,7 @@ nfsd_proc_lookup(struct svc_rqst *rqstp)
 
 	resp->status = fh_getattr(&resp->fh, &resp->stat);
 out:
-	return resp->status;
+	return rpc_success;
 }
 
 /*
@@ -159,7 +159,7 @@ nfsd_proc_readlink(struct svc_rqst *rqstp)
 	resp->status = nfsd_readlink(rqstp, &argp->fh, argp->buffer, &resp->len);
 
 	fh_put(&argp->fh);
-	return resp->status;
+	return rpc_success;
 }
 
 /*
@@ -197,19 +197,18 @@ nfsd_proc_read(struct svc_rqst *rqstp)
 				 rqstp->rq_vec, argp->vlen,
 				 &resp->count,
 				 &eof);
-	if (resp->status != nfs_ok)
-		goto out;
-
-	resp->status = fh_getattr(&resp->fh, &resp->stat);
-out:
-	return resp->status;
+	if (resp->status == nfs_ok)
+		resp->status = fh_getattr(&resp->fh, &resp->stat);
+	else if (resp->status == nfserr_jukebox)
+		return rpc_drop_reply;
+	return rpc_success;
 }
 
 /* Reserved */
 static __be32
 nfsd_proc_writecache(struct svc_rqst *rqstp)
 {
-	return nfs_ok;
+	return rpc_success;
 }
 
 /*
@@ -238,12 +237,12 @@ nfsd_proc_write(struct svc_rqst *rqstp)
 	resp->status = nfsd_write(rqstp, fh_copy(&resp->fh, &argp->fh),
 				  argp->offset, rqstp->rq_vec, nvecs,
 				  &cnt, NFS_DATA_SYNC, NULL);
-	if (resp->status != nfs_ok)
-		goto out;
-
-	resp->status = fh_getattr(&resp->fh, &resp->stat);
+	if (resp->status == nfs_ok)
+		resp->status = fh_getattr(&resp->fh, &resp->stat);
+	else if (resp->status == nfserr_jukebox)
+		return rpc_drop_reply;
 out:
-	return resp->status;
+	return rpc_success;
 }
 
 /*
@@ -410,47 +409,48 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 		goto out;
 	resp->status = fh_getattr(&resp->fh, &resp->stat);
 out:
-	return resp->status;
+	return rpc_success;
 }
 
 static __be32
 nfsd_proc_remove(struct svc_rqst *rqstp)
 {
 	struct nfsd_diropargs *argp = rqstp->rq_argp;
-	__be32	nfserr;
+	struct nfsd_stat *resp = rqstp->rq_resp;
 
 	dprintk("nfsd: REMOVE   %s %.*s\n", SVCFH_fmt(&argp->fh),
 		argp->len, argp->name);
 
 	/* Unlink. -SIFDIR means file must not be a directory */
-	nfserr = nfsd_unlink(rqstp, &argp->fh, -S_IFDIR, argp->name, argp->len);
+	resp->status = nfsd_unlink(rqstp, &argp->fh, -S_IFDIR,
+				   argp->name, argp->len);
 	fh_put(&argp->fh);
-	return nfserr;
+	return rpc_success;
 }
 
 static __be32
 nfsd_proc_rename(struct svc_rqst *rqstp)
 {
 	struct nfsd_renameargs *argp = rqstp->rq_argp;
-	__be32	nfserr;
+	struct nfsd_stat *resp = rqstp->rq_resp;
 
 	dprintk("nfsd: RENAME   %s %.*s -> \n",
 		SVCFH_fmt(&argp->ffh), argp->flen, argp->fname);
 	dprintk("nfsd:        ->  %s %.*s\n",
 		SVCFH_fmt(&argp->tfh), argp->tlen, argp->tname);
 
-	nfserr = nfsd_rename(rqstp, &argp->ffh, argp->fname, argp->flen,
-				    &argp->tfh, argp->tname, argp->tlen);
+	resp->status = nfsd_rename(rqstp, &argp->ffh, argp->fname, argp->flen,
+				   &argp->tfh, argp->tname, argp->tlen);
 	fh_put(&argp->ffh);
 	fh_put(&argp->tfh);
-	return nfserr;
+	return rpc_success;
 }
 
 static __be32
 nfsd_proc_link(struct svc_rqst *rqstp)
 {
 	struct nfsd_linkargs *argp = rqstp->rq_argp;
-	__be32	nfserr;
+	struct nfsd_stat *resp = rqstp->rq_resp;
 
 	dprintk("nfsd: LINK     %s ->\n",
 		SVCFH_fmt(&argp->ffh));
@@ -459,22 +459,22 @@ nfsd_proc_link(struct svc_rqst *rqstp)
 		argp->tlen,
 		argp->tname);
 
-	nfserr = nfsd_link(rqstp, &argp->tfh, argp->tname, argp->tlen,
-				  &argp->ffh);
+	resp->status = nfsd_link(rqstp, &argp->tfh, argp->tname, argp->tlen,
+				 &argp->ffh);
 	fh_put(&argp->ffh);
 	fh_put(&argp->tfh);
-	return nfserr;
+	return rpc_success;
 }
 
 static __be32
 nfsd_proc_symlink(struct svc_rqst *rqstp)
 {
 	struct nfsd_symlinkargs *argp = rqstp->rq_argp;
+	struct nfsd_stat *resp = rqstp->rq_resp;
 	struct svc_fh	newfh;
-	__be32		nfserr;
 
 	if (argp->tlen > NFS_MAXPATHLEN) {
-		nfserr = nfserr_nametoolong;
+		resp->status = nfserr_nametoolong;
 		goto out;
 	}
 
@@ -482,7 +482,7 @@ nfsd_proc_symlink(struct svc_rqst *rqstp)
 						page_address(rqstp->rq_arg.pages[0]),
 						argp->tlen);
 	if (IS_ERR(argp->tname)) {
-		nfserr = nfserrno(PTR_ERR(argp->tname));
+		resp->status = nfserrno(PTR_ERR(argp->tname));
 		goto out;
 	}
 
@@ -491,14 +491,14 @@ nfsd_proc_symlink(struct svc_rqst *rqstp)
 		argp->tlen, argp->tname);
 
 	fh_init(&newfh, NFS_FHSIZE);
-	nfserr = nfsd_symlink(rqstp, &argp->ffh, argp->fname, argp->flen,
-						 argp->tname, &newfh);
+	resp->status = nfsd_symlink(rqstp, &argp->ffh, argp->fname, argp->flen,
+				    argp->tname, &newfh);
 
 	kfree(argp->tname);
 	fh_put(&argp->ffh);
 	fh_put(&newfh);
 out:
-	return nfserr;
+	return rpc_success;
 }
 
 /*
@@ -528,7 +528,7 @@ nfsd_proc_mkdir(struct svc_rqst *rqstp)
 
 	resp->status = fh_getattr(&resp->fh, &resp->stat);
 out:
-	return resp->status;
+	return rpc_success;
 }
 
 /*
@@ -538,13 +538,14 @@ static __be32
 nfsd_proc_rmdir(struct svc_rqst *rqstp)
 {
 	struct nfsd_diropargs *argp = rqstp->rq_argp;
-	__be32	nfserr;
+	struct nfsd_stat *resp = rqstp->rq_resp;
 
 	dprintk("nfsd: RMDIR    %s %.*s\n", SVCFH_fmt(&argp->fh), argp->len, argp->name);
 
-	nfserr = nfsd_unlink(rqstp, &argp->fh, S_IFDIR, argp->name, argp->len);
+	resp->status = nfsd_unlink(rqstp, &argp->fh, S_IFDIR,
+				   argp->name, argp->len);
 	fh_put(&argp->fh);
-	return nfserr;
+	return rpc_success;
 }
 
 /*
@@ -584,7 +585,7 @@ nfsd_proc_readdir(struct svc_rqst *rqstp)
 		*resp->offset = htonl(offset);
 
 	fh_put(&argp->fh);
-	return resp->status;
+	return rpc_success;
 }
 
 /*
@@ -601,7 +602,7 @@ nfsd_proc_statfs(struct svc_rqst *rqstp)
 	resp->status = nfsd_statfs(rqstp, &argp->fh, &resp->stats,
 				   NFSD_MAY_BYPASS_GSS_ON_ROOT);
 	fh_put(&argp->fh);
-	return resp->status;
+	return rpc_success;
 }
 
 /*
@@ -622,7 +623,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_argsize = sizeof(struct nfsd_void),
 		.pc_ressize = sizeof(struct nfsd_void),
 		.pc_cachetype = RC_NOCACHE,
-		.pc_xdrressize = ST,
+		.pc_xdrressize = 0,
 	},
 	[NFSPROC_GETATTR] = {
 		.pc_func = nfsd_proc_getattr,
@@ -651,7 +652,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_argsize = sizeof(struct nfsd_void),
 		.pc_ressize = sizeof(struct nfsd_void),
 		.pc_cachetype = RC_NOCACHE,
-		.pc_xdrressize = ST,
+		.pc_xdrressize = 0,
 	},
 	[NFSPROC_LOOKUP] = {
 		.pc_func = nfsd_proc_lookup,
@@ -689,7 +690,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_argsize = sizeof(struct nfsd_void),
 		.pc_ressize = sizeof(struct nfsd_void),
 		.pc_cachetype = RC_NOCACHE,
-		.pc_xdrressize = ST,
+		.pc_xdrressize = 0,
 	},
 	[NFSPROC_WRITE] = {
 		.pc_func = nfsd_proc_write,
@@ -714,36 +715,36 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 	[NFSPROC_REMOVE] = {
 		.pc_func = nfsd_proc_remove,
 		.pc_decode = nfssvc_decode_diropargs,
-		.pc_encode = nfssvc_encode_void,
+		.pc_encode = nfssvc_encode_stat,
 		.pc_argsize = sizeof(struct nfsd_diropargs),
-		.pc_ressize = sizeof(struct nfsd_void),
+		.pc_ressize = sizeof(struct nfsd_stat),
 		.pc_cachetype = RC_REPLSTAT,
 		.pc_xdrressize = ST,
 	},
 	[NFSPROC_RENAME] = {
 		.pc_func = nfsd_proc_rename,
 		.pc_decode = nfssvc_decode_renameargs,
-		.pc_encode = nfssvc_encode_void,
+		.pc_encode = nfssvc_encode_stat,
 		.pc_argsize = sizeof(struct nfsd_renameargs),
-		.pc_ressize = sizeof(struct nfsd_void),
+		.pc_ressize = sizeof(struct nfsd_stat),
 		.pc_cachetype = RC_REPLSTAT,
 		.pc_xdrressize = ST,
 	},
 	[NFSPROC_LINK] = {
 		.pc_func = nfsd_proc_link,
 		.pc_decode = nfssvc_decode_linkargs,
-		.pc_encode = nfssvc_encode_void,
+		.pc_encode = nfssvc_encode_stat,
 		.pc_argsize = sizeof(struct nfsd_linkargs),
-		.pc_ressize = sizeof(struct nfsd_void),
+		.pc_ressize = sizeof(struct nfsd_stat),
 		.pc_cachetype = RC_REPLSTAT,
 		.pc_xdrressize = ST,
 	},
 	[NFSPROC_SYMLINK] = {
 		.pc_func = nfsd_proc_symlink,
 		.pc_decode = nfssvc_decode_symlinkargs,
-		.pc_encode = nfssvc_encode_void,
+		.pc_encode = nfssvc_encode_stat,
 		.pc_argsize = sizeof(struct nfsd_symlinkargs),
-		.pc_ressize = sizeof(struct nfsd_void),
+		.pc_ressize = sizeof(struct nfsd_stat),
 		.pc_cachetype = RC_REPLSTAT,
 		.pc_xdrressize = ST,
 	},
@@ -760,9 +761,9 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 	[NFSPROC_RMDIR] = {
 		.pc_func = nfsd_proc_rmdir,
 		.pc_decode = nfssvc_decode_diropargs,
-		.pc_encode = nfssvc_encode_void,
+		.pc_encode = nfssvc_encode_stat,
 		.pc_argsize = sizeof(struct nfsd_diropargs),
-		.pc_ressize = sizeof(struct nfsd_void),
+		.pc_ressize = sizeof(struct nfsd_stat),
 		.pc_cachetype = RC_REPLSTAT,
 		.pc_xdrressize = ST,
 	},
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index beb3875241cb..27b1ad136150 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -960,13 +960,6 @@ nfsd(void *vrqstp)
 	return 0;
 }
 
-static __be32 map_new_errors(u32 vers, __be32 nfserr)
-{
-	if (nfserr == nfserr_jukebox && vers == 2)
-		return nfserr_dropit;
-	return nfserr;
-}
-
 /*
  * A write procedure can have a large argument, and a read procedure can
  * have a large reply, but no NFSv2 or NFSv3 procedure has argument and
@@ -1014,7 +1007,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 	const struct svc_procedure *proc = rqstp->rq_procinfo;
 	struct kvec *argv = &rqstp->rq_arg.head[0];
 	struct kvec *resv = &rqstp->rq_res.head[0];
-	__be32 nfserr, *nfserrp;
+	__be32 *p;
 
 	dprintk("nfsd_dispatch: vers %d proc %d\n",
 				rqstp->rq_vers, rqstp->rq_proc);
@@ -1043,18 +1036,14 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 	 * Need to grab the location to store the status, as
 	 * NFSv4 does some encoding while processing
 	 */
-	nfserrp = resv->iov_base + resv->iov_len;
+	p = resv->iov_base + resv->iov_len;
 	resv->iov_len += sizeof(__be32);
 
-	nfserr = proc->pc_func(rqstp);
-	nfserr = map_new_errors(rqstp->rq_vers, nfserr);
-	if (nfserr == nfserr_dropit || test_bit(RQ_DROPME, &rqstp->rq_flags))
+	*statp = proc->pc_func(rqstp);
+	if (*statp == rpc_drop_reply || test_bit(RQ_DROPME, &rqstp->rq_flags))
 		goto out_update_drop;
 
-	if (rqstp->rq_proc != 0)
-		*nfserrp++ = nfserr;
-
-	if (!proc->pc_encode(rqstp, nfserrp))
+	if (!proc->pc_encode(rqstp, p))
 		goto out_encode_err;
 
 	nfsd_cache_update(rqstp, rqstp->rq_cachetype, statp + 1);
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 952e71c95d4e..8a288c8fcd57 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -429,15 +429,25 @@ nfssvc_encode_void(struct svc_rqst *rqstp, __be32 *p)
 	return xdr_ressize_check(rqstp, p);
 }
 
+int
+nfssvc_encode_stat(struct svc_rqst *rqstp, __be32 *p)
+{
+	struct nfsd_stat *resp = rqstp->rq_resp;
+
+	*p++ = resp->status;
+	return xdr_ressize_check(rqstp, p);
+}
+
 int
 nfssvc_encode_attrstat(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd_attrstat *resp = rqstp->rq_resp;
 
+	*p++ = resp->status;
 	if (resp->status != nfs_ok)
-		return xdr_ressize_check(rqstp, p);
-
+		goto out;
 	p = encode_fattr(rqstp, p, &resp->fh, &resp->stat);
+out:
 	return xdr_ressize_check(rqstp, p);
 }
 
@@ -446,11 +456,12 @@ nfssvc_encode_diropres(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd_diropres *resp = rqstp->rq_resp;
 
+	*p++ = resp->status;
 	if (resp->status != nfs_ok)
-		return xdr_ressize_check(rqstp, p);
-
+		goto out;
 	p = encode_fh(p, &resp->fh);
 	p = encode_fattr(rqstp, p, &resp->fh, &resp->stat);
+out:
 	return xdr_ressize_check(rqstp, p);
 }
 
@@ -459,6 +470,7 @@ nfssvc_encode_readlinkres(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd_readlinkres *resp = rqstp->rq_resp;
 
+	*p++ = resp->status;
 	if (resp->status != nfs_ok)
 		return xdr_ressize_check(rqstp, p);
 
@@ -479,6 +491,7 @@ nfssvc_encode_readres(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd_readres *resp = rqstp->rq_resp;
 
+	*p++ = resp->status;
 	if (resp->status != nfs_ok)
 		return xdr_ressize_check(rqstp, p);
 
@@ -502,6 +515,7 @@ nfssvc_encode_readdirres(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd_readdirres *resp = rqstp->rq_resp;
 
+	*p++ = resp->status;
 	if (resp->status != nfs_ok)
 		return xdr_ressize_check(rqstp, p);
 
@@ -520,6 +534,7 @@ nfssvc_encode_statfsres(struct svc_rqst *rqstp, __be32 *p)
 	struct nfsd_statfsres *resp = rqstp->rq_resp;
 	struct kstatfs	*stat = &resp->stats;
 
+	*p++ = resp->status;
 	if (resp->status != nfs_ok)
 		return xdr_ressize_check(rqstp, p);
 
diff --git a/fs/nfsd/xdr.h b/fs/nfsd/xdr.h
index 17221931815f..0ff336b0b25f 100644
--- a/fs/nfsd/xdr.h
+++ b/fs/nfsd/xdr.h
@@ -82,6 +82,10 @@ struct nfsd_readdirargs {
 	__be32 *		buffer;
 };
 
+struct nfsd_stat {
+	__be32			status;
+};
+
 struct nfsd_attrstat {
 	__be32			status;
 	struct svc_fh		fh;
@@ -153,6 +157,7 @@ int nfssvc_decode_linkargs(struct svc_rqst *, __be32 *);
 int nfssvc_decode_symlinkargs(struct svc_rqst *, __be32 *);
 int nfssvc_decode_readdirargs(struct svc_rqst *, __be32 *);
 int nfssvc_encode_void(struct svc_rqst *, __be32 *);
+int nfssvc_encode_stat(struct svc_rqst *, __be32 *);
 int nfssvc_encode_attrstat(struct svc_rqst *, __be32 *);
 int nfssvc_encode_diropres(struct svc_rqst *, __be32 *);
 int nfssvc_encode_readlinkres(struct svc_rqst *, __be32 *);


