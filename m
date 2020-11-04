Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7492A69AE
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Nov 2020 17:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgKDQ1U (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Nov 2020 11:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgKDQ1S (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Nov 2020 11:27:18 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD8AC0613D3
        for <linux-nfs@vger.kernel.org>; Wed,  4 Nov 2020 08:27:18 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id h12so12609584qtu.1
        for <linux-nfs@vger.kernel.org>; Wed, 04 Nov 2020 08:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uitkgNsrQ+w9e0WKoHTLsIeCU2ez8dbftYaDmCFKgG4=;
        b=goC2go9e2xQQwnPog8gICjfX1ws2yIDu/gcGxcTwkAhr4qp2EtadZ8wqGGsmoDgVuU
         QI4cTGE+xhH9N+rRNdZKfGHz3K3lFEfPEOUaVNcEPBGUu/yz6W5nuN/0uU9/D2LYvhCU
         fS21E+UfLYCIGoOovDLrDGZxyWQPqM+TsansWsVroUKLdZqfdpeAFopN+JNkMneScN3a
         qn32W1O8sOr0C3pLlvoN/mMH86SdIoE4M0Obus69Nf8IFwNpjbOr0t0kG3HvogSlt+T5
         kLdQkgZ2FCILOiSFha16y3lCzy31RG2N0sT8BpokbjfWbcYPQnuz7UBkVXJTuZ7xCQwf
         2m4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uitkgNsrQ+w9e0WKoHTLsIeCU2ez8dbftYaDmCFKgG4=;
        b=DZkDVNCDo932snwY/wI9+28h3yz+UKLRmTdvLughiI4/pqJrztpQidbtnzeKaHyXuh
         bAhaMAQMuFteSYHDMOiVBD08bD/edOExe7kd/Nq1xcLW7CgEz/ui/cQjrDvA2v9qpX2E
         qhrgDV6DIJTqjuC9SFSdtJO/EIs0egHG6W10umutu/YV30GqrIEl+9Z7n3pf1TmJFuo/
         znSvO81R71C++JlEwRreI8w3Cth26/+OClaoiMakEaE5k3foqB549x4PsmpyELWRF/vv
         0aBuTPKi/z7+W6b+IKH0N/wM77Ux+3/mDqSsnG7pnc3SWkwNiz+TJaUfU/QGXUZWMAAM
         Qqbg==
X-Gm-Message-State: AOAM533kMjqghhIqPFWr+qpr88C4iSmWJqNgoojG2TDCz+adEyngW+OT
        6g8DOe6qJBZ2gdUx/f4RP3wXpRQC4m1s
X-Google-Smtp-Source: ABdhPJzURfWCT7XGWZYCpWQJj9tMTKpOt8YD0/E9PWC2Enaqdw0Hf6B8uyI/RMgzGTIfOuNtbo7B1Q==
X-Received: by 2002:ac8:7391:: with SMTP id t17mr19866451qtp.289.1604507236822;
        Wed, 04 Nov 2020 08:27:16 -0800 (PST)
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net. [68.36.133.222])
        by smtp.gmail.com with ESMTPSA id g78sm2896924qke.88.2020.11.04.08.27.15
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:27:16 -0800 (PST)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 14/17] NFS: Allow the NFS generic code to pass in a verifier to readdir
Date:   Wed,  4 Nov 2020 11:16:35 -0500
Message-Id: <20201104161638.300324-15-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201104161638.300324-14-trond.myklebust@hammerspace.com>
References: <20201104161638.300324-1-trond.myklebust@hammerspace.com>
 <20201104161638.300324-2-trond.myklebust@hammerspace.com>
 <20201104161638.300324-3-trond.myklebust@hammerspace.com>
 <20201104161638.300324-4-trond.myklebust@hammerspace.com>
 <20201104161638.300324-5-trond.myklebust@hammerspace.com>
 <20201104161638.300324-6-trond.myklebust@hammerspace.com>
 <20201104161638.300324-7-trond.myklebust@hammerspace.com>
 <20201104161638.300324-8-trond.myklebust@hammerspace.com>
 <20201104161638.300324-9-trond.myklebust@hammerspace.com>
 <20201104161638.300324-10-trond.myklebust@hammerspace.com>
 <20201104161638.300324-11-trond.myklebust@hammerspace.com>
 <20201104161638.300324-12-trond.myklebust@hammerspace.com>
 <20201104161638.300324-13-trond.myklebust@hammerspace.com>
 <20201104161638.300324-14-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If we're ever going to allow support for servers that use the readdir
verifier, then that use needs to be managed by the middle layers as
those need to be able to reject cookies from other verifiers.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c            | 23 ++++++++++++++++++-----
 fs/nfs/nfs3proc.c       | 35 +++++++++++++++++------------------
 fs/nfs/nfs4proc.c       | 38 ++++++++++++++++++--------------------
 fs/nfs/proc.c           | 18 +++++++++---------
 include/linux/nfs_xdr.h | 17 +++++++++++++++--
 5 files changed, 77 insertions(+), 54 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index b226f6f3ae96..3ee0668a9719 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -469,8 +469,20 @@ static int nfs_readdir_xdr_filler(struct nfs_readdir_descriptor *desc,
 				  u64 cookie, struct page **pages,
 				  size_t bufsize)
 {
-	struct file *file = desc->file;
-	struct inode *inode = file_inode(file);
+	struct inode *inode = file_inode(desc->file);
+	__be32 verf_res[2];
+	struct nfs_readdir_arg arg = {
+		.dentry = file_dentry(desc->file),
+		.cred = desc->file->f_cred,
+		.verf = NFS_I(inode)->cookieverf,
+		.cookie = cookie,
+		.pages = pages,
+		.page_len = bufsize,
+		.plus = desc->plus,
+	};
+	struct nfs_readdir_res res = {
+		.verf = verf_res,
+	};
 	unsigned long	timestamp, gencount;
 	int		error;
 
@@ -478,20 +490,21 @@ static int nfs_readdir_xdr_filler(struct nfs_readdir_descriptor *desc,
 	timestamp = jiffies;
 	gencount = nfs_inc_attr_generation_counter();
 	desc->dir_verifier = nfs_save_change_attribute(inode);
-	error = NFS_PROTO(inode)->readdir(file_dentry(file), file->f_cred,
-					  cookie, pages, bufsize, desc->plus);
+	error = NFS_PROTO(inode)->readdir(&arg, &res);
 	if (error < 0) {
 		/* We requested READDIRPLUS, but the server doesn't grok it */
 		if (error == -ENOTSUPP && desc->plus) {
 			NFS_SERVER(inode)->caps &= ~NFS_CAP_READDIRPLUS;
 			clear_bit(NFS_INO_ADVISE_RDPLUS, &NFS_I(inode)->flags);
-			desc->plus = false;
+			desc->plus = arg.plus = false;
 			goto again;
 		}
 		goto error;
 	}
 	desc->timestamp = timestamp;
 	desc->gencount = gencount;
+	memcpy(NFS_I(inode)->cookieverf, res.verf,
+	       sizeof(NFS_I(inode)->cookieverf));
 error:
 	return error;
 }
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 6b66b73a50eb..5c4e23abc345 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -662,37 +662,36 @@ nfs3_proc_rmdir(struct inode *dir, const struct qstr *name)
  * Also note that this implementation handles both plain readdir and
  * readdirplus.
  */
-static int
-nfs3_proc_readdir(struct dentry *dentry, const struct cred *cred,
-		  u64 cookie, struct page **pages, unsigned int count, bool plus)
+static int nfs3_proc_readdir(struct nfs_readdir_arg *nr_arg,
+			     struct nfs_readdir_res *nr_res)
 {
-	struct inode		*dir = d_inode(dentry);
-	__be32			*verf = NFS_I(dir)->cookieverf;
+	struct inode		*dir = d_inode(nr_arg->dentry);
 	struct nfs3_readdirargs	arg = {
 		.fh		= NFS_FH(dir),
-		.cookie		= cookie,
-		.verf		= {verf[0], verf[1]},
-		.plus		= plus,
-		.count		= count,
-		.pages		= pages
+		.cookie		= nr_arg->cookie,
+		.plus		= nr_arg->plus,
+		.count		= nr_arg->page_len,
+		.pages		= nr_arg->pages
 	};
 	struct nfs3_readdirres	res = {
-		.verf		= verf,
-		.plus		= plus
+		.verf		= nr_res->verf,
+		.plus		= nr_arg->plus,
 	};
 	struct rpc_message	msg = {
 		.rpc_proc	= &nfs3_procedures[NFS3PROC_READDIR],
 		.rpc_argp	= &arg,
 		.rpc_resp	= &res,
-		.rpc_cred	= cred,
+		.rpc_cred	= nr_arg->cred,
 	};
 	int status = -ENOMEM;
 
-	if (plus)
+	if (nr_arg->plus)
 		msg.rpc_proc = &nfs3_procedures[NFS3PROC_READDIRPLUS];
+	if (arg.cookie)
+		memcpy(arg.verf, nr_arg->verf, sizeof(arg.verf));
 
-	dprintk("NFS call  readdir%s %d\n",
-			plus? "plus" : "", (unsigned int) cookie);
+	dprintk("NFS call  readdir%s %llu\n", nr_arg->plus ? "plus" : "",
+		(unsigned long long)nr_arg->cookie);
 
 	res.dir_attr = nfs_alloc_fattr();
 	if (res.dir_attr == NULL)
@@ -705,8 +704,8 @@ nfs3_proc_readdir(struct dentry *dentry, const struct cred *cred,
 
 	nfs_free_fattr(res.dir_attr);
 out:
-	dprintk("NFS reply readdir%s: %d\n",
-			plus? "plus" : "", status);
+	dprintk("NFS reply readdir%s: %d\n", nr_arg->plus ? "plus" : "",
+		status);
 	return status;
 }
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index a5b9356bee6a..8e82f988a11f 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4961,35 +4961,34 @@ static int nfs4_proc_mkdir(struct inode *dir, struct dentry *dentry,
 	return err;
 }
 
-static int _nfs4_proc_readdir(struct dentry *dentry, const struct cred *cred,
-		u64 cookie, struct page **pages, unsigned int count, bool plus)
+static int _nfs4_proc_readdir(struct nfs_readdir_arg *nr_arg,
+			      struct nfs_readdir_res *nr_res)
 {
-	struct inode		*dir = d_inode(dentry);
+	struct inode		*dir = d_inode(nr_arg->dentry);
 	struct nfs4_readdir_arg args = {
 		.fh = NFS_FH(dir),
-		.pages = pages,
+		.pages = nr_arg->pages,
 		.pgbase = 0,
-		.count = count,
-		.bitmask = NFS_SERVER(d_inode(dentry))->attr_bitmask,
-		.plus = plus,
+		.count = nr_arg->page_len,
+		.bitmask = NFS_SERVER(d_inode(nr_arg->dentry))->attr_bitmask,
+		.plus = nr_arg->plus,
 	};
 	struct nfs4_readdir_res res;
 	struct rpc_message msg = {
 		.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_READDIR],
 		.rpc_argp = &args,
 		.rpc_resp = &res,
-		.rpc_cred = cred,
+		.rpc_cred = nr_arg->cred,
 	};
 	int			status;
 
-	dprintk("%s: dentry = %pd2, cookie = %Lu\n", __func__,
-			dentry,
-			(unsigned long long)cookie);
-	nfs4_setup_readdir(cookie, NFS_I(dir)->cookieverf, dentry, &args);
+	dprintk("%s: dentry = %pd2, cookie = %llu\n", __func__,
+		nr_arg->dentry, (unsigned long long)nr_arg->cookie);
+	nfs4_setup_readdir(nr_arg->cookie, nr_arg->verf, nr_arg->dentry, &args);
 	res.pgbase = args.pgbase;
 	status = nfs4_call_sync(NFS_SERVER(dir)->client, NFS_SERVER(dir), &msg, &args.seq_args, &res.seq_res, 0);
 	if (status >= 0) {
-		memcpy(NFS_I(dir)->cookieverf, res.verifier.data, NFS4_VERIFIER_SIZE);
+		memcpy(nr_res->verf, res.verifier.data, NFS4_VERIFIER_SIZE);
 		status += args.pgbase;
 	}
 
@@ -4999,19 +4998,18 @@ static int _nfs4_proc_readdir(struct dentry *dentry, const struct cred *cred,
 	return status;
 }
 
-static int nfs4_proc_readdir(struct dentry *dentry, const struct cred *cred,
-		u64 cookie, struct page **pages, unsigned int count, bool plus)
+static int nfs4_proc_readdir(struct nfs_readdir_arg *arg,
+			     struct nfs_readdir_res *res)
 {
 	struct nfs4_exception exception = {
 		.interruptible = true,
 	};
 	int err;
 	do {
-		err = _nfs4_proc_readdir(dentry, cred, cookie,
-				pages, count, plus);
-		trace_nfs4_readdir(d_inode(dentry), err);
-		err = nfs4_handle_exception(NFS_SERVER(d_inode(dentry)), err,
-				&exception);
+		err = _nfs4_proc_readdir(arg, res);
+		trace_nfs4_readdir(d_inode(arg->dentry), err);
+		err = nfs4_handle_exception(NFS_SERVER(d_inode(arg->dentry)),
+					    err, &exception);
 	} while (exception.retry);
 	return err;
 }
diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
index 15c865cc837f..73ab7c59d3a7 100644
--- a/fs/nfs/proc.c
+++ b/fs/nfs/proc.c
@@ -499,26 +499,26 @@ nfs_proc_rmdir(struct inode *dir, const struct qstr *name)
  * sure it is syntactically correct; the entries itself are decoded
  * from nfs_readdir by calling the decode_entry function directly.
  */
-static int
-nfs_proc_readdir(struct dentry *dentry, const struct cred *cred,
-		 u64 cookie, struct page **pages, unsigned int count, bool plus)
+static int nfs_proc_readdir(struct nfs_readdir_arg *nr_arg,
+			    struct nfs_readdir_res *nr_res)
 {
-	struct inode		*dir = d_inode(dentry);
+	struct inode		*dir = d_inode(nr_arg->dentry);
 	struct nfs_readdirargs	arg = {
 		.fh		= NFS_FH(dir),
-		.cookie		= cookie,
-		.count		= count,
-		.pages		= pages,
+		.cookie		= nr_arg->cookie,
+		.count		= nr_arg->page_len,
+		.pages		= nr_arg->pages,
 	};
 	struct rpc_message	msg = {
 		.rpc_proc	= &nfs_procedures[NFSPROC_READDIR],
 		.rpc_argp	= &arg,
-		.rpc_cred	= cred,
+		.rpc_cred	= nr_arg->cred,
 	};
 	int			status;
 
-	dprintk("NFS call  readdir %d\n", (unsigned int)cookie);
+	dprintk("NFS call  readdir %llu\n", (unsigned long long)nr_arg->cookie);
 	status = rpc_call_sync(NFS_CLIENT(dir), &msg, 0);
+	nr_res->verf[0] = nr_res->verf[1] = 0;
 
 	nfs_invalidate_atime(dir);
 
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index d63cb862d58e..3327239fa2f9 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -750,6 +750,20 @@ struct nfs_entry {
 	struct nfs_server *	server;
 };
 
+struct nfs_readdir_arg {
+	struct dentry		*dentry;
+	const struct cred	*cred;
+	__be32			*verf;
+	u64			cookie;
+	struct page		**pages;
+	unsigned int		page_len;
+	bool			plus;
+};
+
+struct nfs_readdir_res {
+	__be32			*verf;
+};
+
 /*
  * The following types are for NFSv2 only.
  */
@@ -1744,8 +1758,7 @@ struct nfs_rpc_ops {
 			    unsigned int, struct iattr *);
 	int	(*mkdir)   (struct inode *, struct dentry *, struct iattr *);
 	int	(*rmdir)   (struct inode *, const struct qstr *);
-	int	(*readdir) (struct dentry *, const struct cred *,
-			    u64, struct page **, unsigned int, bool);
+	int	(*readdir) (struct nfs_readdir_arg *, struct nfs_readdir_res *);
 	int	(*mknod)   (struct inode *, struct dentry *, struct iattr *,
 			    dev_t);
 	int	(*statfs)  (struct nfs_server *, struct nfs_fh *,
-- 
2.28.0

