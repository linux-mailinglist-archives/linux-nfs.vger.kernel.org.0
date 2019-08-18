Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E009C918C3
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Aug 2019 20:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfHRSV1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 18 Aug 2019 14:21:27 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36345 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfHRSV1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 18 Aug 2019 14:21:27 -0400
Received: by mail-io1-f68.google.com with SMTP id o9so16094920iom.3
        for <linux-nfs@vger.kernel.org>; Sun, 18 Aug 2019 11:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hvxv5Z4nWfR3bph9KDKXZGhDeGcM3JrlQACNOfp7QLI=;
        b=Xb/HuwltuADGe/Kt5Vy7Ntt0ewABW+JxMMo/ZiSR01yeFEJHqTdMSevWllMT2uzDRu
         HfMYHDTLNFWiIUCNGD0zh6vylTIEmzxwXAvpidQ36X4PWxbv0O4UolanTA76HxCnTJ91
         Mj0R4mfxyG1LBzKJ1kuNyx6A47yUoGO7tz/h+Bg6tL0M9RVXBm3pO5hCsqT1XuIiwfkC
         OFKX3v2jV6YmDbGOzV/fRfFEb9EY1w31tzUPqQ+9wzExwg4+GLAWds3/i9/iHKFZChe4
         TtXxCKFweaZmu1aA7igyZCLd5Rb8cJc4Ojv7lDVo2DvPqpenrw153o/KCwfQqDM3Ky4I
         kRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hvxv5Z4nWfR3bph9KDKXZGhDeGcM3JrlQACNOfp7QLI=;
        b=qvFgJM/hyDCW0ptxnXvxjM55PfenNJ62HUCWFs8qJAKMlKXE4WHT+mO3AkntNUVfZK
         kBGijOWIISOdz8VgiOMcEXr+prBIZOO5PaPNcz3UUV/LXXCHe3/wvF5yQHkraTIwIMAc
         pykwpREtI7AWqBnb2IjjFKCo3QvTxigCwI/cdfkGd4kb53gNSgbMwkP6TTfYOeYI53JW
         fZPfn5sWFHSg7Vks1zwWPKnK6AkpiF3jsJveMwpDIHUoFyBwULV1r8kN6g9kzpDfEFmf
         oLlhzvpkE13W30SgO8Qp2lh5LYBdKz6geSjFaGYxATqf8EEcVHwJ6A9rMkWfMd1wX2hj
         pdUw==
X-Gm-Message-State: APjAAAW4G3k/cSwLAdI5ZnvvOi1JPs9IHQS6Kk4AEXQnxgWIF08FvsG1
        datYtkG6+1vzTG/guEnIwA==
X-Google-Smtp-Source: APXvYqxBfrLz4RXjMeXW/1z2l9VLRy5S9OO8XABb0Y95zrUpIFxRSavGULjwF56cMJqmgEKWCXp9lQ==
X-Received: by 2002:a05:6638:517:: with SMTP id i23mr15852191jar.71.1566152485451;
        Sun, 18 Aug 2019 11:21:25 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id n22sm10317844iob.37.2019.08.18.11.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 11:21:24 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 11/16] nfsd: hook up nfs4_preprocess_stateid_op to the nfsd_file cache
Date:   Sun, 18 Aug 2019 14:18:54 -0400
Message-Id: <20190818181859.8458-12-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190818181859.8458-11-trond.myklebust@hammerspace.com>
References: <20190818181859.8458-1-trond.myklebust@hammerspace.com>
 <20190818181859.8458-2-trond.myklebust@hammerspace.com>
 <20190818181859.8458-3-trond.myklebust@hammerspace.com>
 <20190818181859.8458-4-trond.myklebust@hammerspace.com>
 <20190818181859.8458-5-trond.myklebust@hammerspace.com>
 <20190818181859.8458-6-trond.myklebust@hammerspace.com>
 <20190818181859.8458-7-trond.myklebust@hammerspace.com>
 <20190818181859.8458-8-trond.myklebust@hammerspace.com>
 <20190818181859.8458-9-trond.myklebust@hammerspace.com>
 <20190818181859.8458-10-trond.myklebust@hammerspace.com>
 <20190818181859.8458-11-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Jeff Layton <jeff.layton@primarydata.com>

Have nfs4_preprocess_stateid_op pass back a nfsd_file instead of a filp.
Since we now presume that the struct file will be persistent in most
cases, we can stop fiddling with the raparms in the read code. This
also means that we don't really care about the rd_tmp_file field
anymore.

Signed-off-by: Jeff Layton <jeff.layton@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/nfs4proc.c  | 83 +++++++++++++++++++++++----------------------
 fs/nfsd/nfs4state.c | 24 ++++++-------
 fs/nfsd/nfs4xdr.c   | 14 ++++----
 fs/nfsd/state.h     |  2 +-
 fs/nfsd/xdr4.h      | 19 +++++------
 5 files changed, 68 insertions(+), 74 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 8beda999e134..cb51893ec1cd 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -761,7 +761,7 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd4_read *read = &u->read;
 	__be32 status;
 
-	read->rd_filp = NULL;
+	read->rd_nf = NULL;
 	if (read->rd_offset >= OFFSET_MAX)
 		return nfserr_inval;
 
@@ -782,7 +782,7 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	/* check stateid */
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
 					&read->rd_stateid, RD_STATE,
-					&read->rd_filp, &read->rd_tmp_file);
+					&read->rd_nf);
 	if (status) {
 		dprintk("NFSD: nfsd4_read: couldn't process stateid!\n");
 		goto out;
@@ -798,8 +798,8 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 static void
 nfsd4_read_release(union nfsd4_op_u *u)
 {
-	if (u->read.rd_filp)
-		fput(u->read.rd_filp);
+	if (u->read.rd_nf)
+		nfsd_file_put(u->read.rd_nf);
 	trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
 			     u->read.rd_offset, u->read.rd_length);
 }
@@ -954,7 +954,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (setattr->sa_iattr.ia_valid & ATTR_SIZE) {
 		status = nfs4_preprocess_stateid_op(rqstp, cstate,
 				&cstate->current_fh, &setattr->sa_stateid,
-				WR_STATE, NULL, NULL);
+				WR_STATE, NULL);
 		if (status) {
 			dprintk("NFSD: nfsd4_setattr: couldn't process stateid!\n");
 			return status;
@@ -993,7 +993,7 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 {
 	struct nfsd4_write *write = &u->write;
 	stateid_t *stateid = &write->wr_stateid;
-	struct file *filp = NULL;
+	struct nfsd_file *nf = NULL;
 	__be32 status = nfs_ok;
 	unsigned long cnt;
 	int nvecs;
@@ -1005,7 +1005,7 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	trace_nfsd_write_start(rqstp, &cstate->current_fh,
 			       write->wr_offset, cnt);
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
-						stateid, WR_STATE, &filp, NULL);
+						stateid, WR_STATE, &nf);
 	if (status) {
 		dprintk("NFSD: nfsd4_write: couldn't process stateid!\n");
 		return status;
@@ -1018,10 +1018,10 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 				      &write->wr_head, write->wr_buflen);
 	WARN_ON_ONCE(nvecs > ARRAY_SIZE(rqstp->rq_vec));
 
-	status = nfsd_vfs_write(rqstp, &cstate->current_fh, filp,
+	status = nfsd_vfs_write(rqstp, &cstate->current_fh, nf->nf_file,
 				write->wr_offset, rqstp->rq_vec, nvecs, &cnt,
 				write->wr_how_written);
-	fput(filp);
+	nfsd_file_put(nf);
 
 	write->wr_bytes_written = cnt;
 	trace_nfsd_write_done(rqstp, &cstate->current_fh,
@@ -1031,8 +1031,8 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 static __be32
 nfsd4_verify_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
-		  stateid_t *src_stateid, struct file **src,
-		  stateid_t *dst_stateid, struct file **dst)
+		  stateid_t *src_stateid, struct nfsd_file **src,
+		  stateid_t *dst_stateid, struct nfsd_file **dst)
 {
 	__be32 status;
 
@@ -1040,22 +1040,22 @@ nfsd4_verify_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		return nfserr_nofilehandle;
 
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->save_fh,
-					    src_stateid, RD_STATE, src, NULL);
+					    src_stateid, RD_STATE, src);
 	if (status) {
 		dprintk("NFSD: %s: couldn't process src stateid!\n", __func__);
 		goto out;
 	}
 
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
-					    dst_stateid, WR_STATE, dst, NULL);
+					    dst_stateid, WR_STATE, dst);
 	if (status) {
 		dprintk("NFSD: %s: couldn't process dst stateid!\n", __func__);
 		goto out_put_src;
 	}
 
 	/* fix up for NFS-specific error code */
-	if (!S_ISREG(file_inode(*src)->i_mode) ||
-	    !S_ISREG(file_inode(*dst)->i_mode)) {
+	if (!S_ISREG(file_inode((*src)->nf_file)->i_mode) ||
+	    !S_ISREG(file_inode((*dst)->nf_file)->i_mode)) {
 		status = nfserr_wrong_type;
 		goto out_put_dst;
 	}
@@ -1063,9 +1063,9 @@ nfsd4_verify_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 out:
 	return status;
 out_put_dst:
-	fput(*dst);
+	nfsd_file_put(*dst);
 out_put_src:
-	fput(*src);
+	nfsd_file_put(*src);
 	goto out;
 }
 
@@ -1074,7 +1074,7 @@ nfsd4_clone(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		union nfsd4_op_u *u)
 {
 	struct nfsd4_clone *clone = &u->clone;
-	struct file *src, *dst;
+	struct nfsd_file *src, *dst;
 	__be32 status;
 
 	status = nfsd4_verify_copy(rqstp, cstate, &clone->cl_src_stateid, &src,
@@ -1082,11 +1082,11 @@ nfsd4_clone(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (status)
 		goto out;
 
-	status = nfsd4_clone_file_range(src, clone->cl_src_pos,
-			dst, clone->cl_dst_pos, clone->cl_count);
+	status = nfsd4_clone_file_range(src->nf_file, clone->cl_src_pos,
+			dst->nf_file, clone->cl_dst_pos, clone->cl_count);
 
-	fput(dst);
-	fput(src);
+	nfsd_file_put(dst);
+	nfsd_file_put(src);
 out:
 	return status;
 }
@@ -1176,8 +1176,9 @@ static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy)
 	do {
 		if (kthread_should_stop())
 			break;
-		bytes_copied = nfsd_copy_file_range(copy->file_src, src_pos,
-				copy->file_dst, dst_pos, bytes_total);
+		bytes_copied = nfsd_copy_file_range(copy->nf_src->nf_file,
+				src_pos, copy->nf_dst->nf_file, dst_pos,
+				bytes_total);
 		if (bytes_copied <= 0)
 			break;
 		bytes_total -= bytes_copied;
@@ -1204,8 +1205,8 @@ static __be32 nfsd4_do_copy(struct nfsd4_copy *copy, bool sync)
 		status = nfs_ok;
 	}
 
-	fput(copy->file_src);
-	fput(copy->file_dst);
+	nfsd_file_put(copy->nf_src);
+	nfsd_file_put(copy->nf_dst);
 	return status;
 }
 
@@ -1218,16 +1219,16 @@ static void dup_copy_fields(struct nfsd4_copy *src, struct nfsd4_copy *dst)
 	memcpy(&dst->cp_res, &src->cp_res, sizeof(src->cp_res));
 	memcpy(&dst->fh, &src->fh, sizeof(src->fh));
 	dst->cp_clp = src->cp_clp;
-	dst->file_dst = get_file(src->file_dst);
-	dst->file_src = get_file(src->file_src);
+	dst->nf_dst = nfsd_file_get(src->nf_dst);
+	dst->nf_src = nfsd_file_get(src->nf_src);
 	memcpy(&dst->cp_stateid, &src->cp_stateid, sizeof(src->cp_stateid));
 }
 
 static void cleanup_async_copy(struct nfsd4_copy *copy)
 {
 	nfs4_free_cp_state(copy);
-	fput(copy->file_dst);
-	fput(copy->file_src);
+	nfsd_file_put(copy->nf_dst);
+	nfsd_file_put(copy->nf_src);
 	spin_lock(&copy->cp_clp->async_lock);
 	list_del(&copy->copies);
 	spin_unlock(&copy->cp_clp->async_lock);
@@ -1264,8 +1265,8 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd4_copy *async_copy = NULL;
 
 	status = nfsd4_verify_copy(rqstp, cstate, &copy->cp_src_stateid,
-				   &copy->file_src, &copy->cp_dst_stateid,
-				   &copy->file_dst);
+				   &copy->nf_src, &copy->cp_dst_stateid,
+				   &copy->nf_dst);
 	if (status)
 		goto out;
 
@@ -1347,21 +1348,21 @@ nfsd4_fallocate(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		struct nfsd4_fallocate *fallocate, int flags)
 {
 	__be32 status;
-	struct file *file;
+	struct nfsd_file *nf;
 
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
 					    &fallocate->falloc_stateid,
-					    WR_STATE, &file, NULL);
+					    WR_STATE, &nf);
 	if (status != nfs_ok) {
 		dprintk("NFSD: nfsd4_fallocate: couldn't process stateid!\n");
 		return status;
 	}
 
-	status = nfsd4_vfs_fallocate(rqstp, &cstate->current_fh, file,
+	status = nfsd4_vfs_fallocate(rqstp, &cstate->current_fh, nf->nf_file,
 				     fallocate->falloc_offset,
 				     fallocate->falloc_length,
 				     flags);
-	fput(file);
+	nfsd_file_put(nf);
 	return status;
 }
 static __be32
@@ -1406,11 +1407,11 @@ nfsd4_seek(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd4_seek *seek = &u->seek;
 	int whence;
 	__be32 status;
-	struct file *file;
+	struct nfsd_file *nf;
 
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
 					    &seek->seek_stateid,
-					    RD_STATE, &file, NULL);
+					    RD_STATE, &nf);
 	if (status) {
 		dprintk("NFSD: nfsd4_seek: couldn't process stateid!\n");
 		return status;
@@ -1432,14 +1433,14 @@ nfsd4_seek(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	 * Note:  This call does change file->f_pos, but nothing in NFSD
 	 *        should ever file->f_pos.
 	 */
-	seek->seek_pos = vfs_llseek(file, seek->seek_offset, whence);
+	seek->seek_pos = vfs_llseek(nf->nf_file, seek->seek_offset, whence);
 	if (seek->seek_pos < 0)
 		status = nfserrno(seek->seek_pos);
-	else if (seek->seek_pos >= i_size_read(file_inode(file)))
+	else if (seek->seek_pos >= i_size_read(file_inode(nf->nf_file)))
 		seek->seek_eof = true;
 
 out:
-	fput(file);
+	nfsd_file_put(nf);
 	return status;
 }
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index abcd3415dad0..af6b191bdafc 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5554,7 +5554,7 @@ nfs4_check_olstateid(struct nfs4_ol_stateid *ols, int flags)
 
 static __be32
 nfs4_check_file(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfs4_stid *s,
-		struct file **filpp, bool *tmp_file, int flags)
+		struct nfsd_file **nfp, int flags)
 {
 	int acc = (flags & RD_STATE) ? NFSD_MAY_READ : NFSD_MAY_WRITE;
 	struct nfsd_file *nf;
@@ -5564,19 +5564,17 @@ nfs4_check_file(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfs4_stid *s,
 	if (nf) {
 		status = nfsd_permission(rqstp, fhp->fh_export, fhp->fh_dentry,
 				acc | NFSD_MAY_OWNER_OVERRIDE);
-		if (status)
+		if (status) {
+			nfsd_file_put(nf);
 			goto out;
+		}
 	} else {
 		status = nfsd_file_acquire(rqstp, fhp, acc, &nf);
 		if (status)
 			return status;
-
-		if (tmp_file)
-			*tmp_file = true;
 	}
-	*filpp = get_file(nf->nf_file);
+	*nfp = nf;
 out:
-	nfsd_file_put(nf);
 	return status;
 }
 
@@ -5586,7 +5584,7 @@ nfs4_check_file(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfs4_stid *s,
 __be32
 nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
 		struct nfsd4_compound_state *cstate, struct svc_fh *fhp,
-		stateid_t *stateid, int flags, struct file **filpp, bool *tmp_file)
+		stateid_t *stateid, int flags, struct nfsd_file **nfp)
 {
 	struct inode *ino = d_inode(fhp->fh_dentry);
 	struct net *net = SVC_NET(rqstp);
@@ -5594,10 +5592,8 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
 	struct nfs4_stid *s = NULL;
 	__be32 status;
 
-	if (filpp)
-		*filpp = NULL;
-	if (tmp_file)
-		*tmp_file = false;
+	if (nfp)
+		*nfp = NULL;
 
 	if (grace_disallows_io(net, ino))
 		return nfserr_grace;
@@ -5634,8 +5630,8 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
 	status = nfs4_check_fh(fhp, s);
 
 done:
-	if (!status && filpp)
-		status = nfs4_check_file(rqstp, fhp, s, filpp, tmp_file, flags);
+	if (status == nfs_ok && nfp)
+		status = nfs4_check_file(rqstp, fhp, s, nfp, flags);
 out:
 	if (s)
 		nfs4_put_stid(s);
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 442811809f3d..7b03bcca0dfe 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -49,6 +49,7 @@
 #include "cache.h"
 #include "netns.h"
 #include "pnfs.h"
+#include "filecache.h"
 
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 #include <linux/security.h>
@@ -3574,11 +3575,14 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
 {
 	unsigned long maxcount;
 	struct xdr_stream *xdr = &resp->xdr;
-	struct file *file = read->rd_filp;
+	struct file *file;
 	int starting_len = xdr->buf->len;
-	struct raparms *ra = NULL;
 	__be32 *p;
 
+	if (nfserr)
+		return nfserr;
+	file = read->rd_nf->nf_file;
+
 	p = xdr_reserve_space(xdr, 8); /* eof flag and byte count */
 	if (!p) {
 		WARN_ON_ONCE(test_bit(RQ_SPLICE_OK, &resp->rqstp->rq_flags));
@@ -3596,18 +3600,12 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
 			 (xdr->buf->buflen - xdr->buf->len));
 	maxcount = min_t(unsigned long, maxcount, read->rd_length);
 
-	if (read->rd_tmp_file)
-		ra = nfsd_init_raparms(file);
-
 	if (file->f_op->splice_read &&
 	    test_bit(RQ_SPLICE_OK, &resp->rqstp->rq_flags))
 		nfserr = nfsd4_encode_splice_read(resp, read, file, maxcount);
 	else
 		nfserr = nfsd4_encode_readv(resp, read, file, maxcount);
 
-	if (ra)
-		nfsd_put_raparams(file, ra);
-
 	if (nfserr)
 		xdr_truncate_encode(xdr, starting_len);
 
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index d89d1ade1254..d00c86d05beb 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -616,7 +616,7 @@ struct nfsd4_copy;
 
 extern __be32 nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
 		struct nfsd4_compound_state *cstate, struct svc_fh *fhp,
-		stateid_t *stateid, int flags, struct file **filp, bool *tmp_file);
+		stateid_t *stateid, int flags, struct nfsd_file **filp);
 __be32 nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 		     stateid_t *stateid, unsigned char typemask,
 		     struct nfs4_stid **s, struct nfsd_net *nn);
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index d64c870f998a..f4737d66ee98 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -273,15 +273,14 @@ struct nfsd4_open_downgrade {
 
 
 struct nfsd4_read {
-	stateid_t	rd_stateid;         /* request */
-	u64		rd_offset;          /* request */
-	u32		rd_length;          /* request */
-	int		rd_vlen;
-	struct file     *rd_filp;
-	bool		rd_tmp_file;
+	stateid_t		rd_stateid;         /* request */
+	u64			rd_offset;          /* request */
+	u32			rd_length;          /* request */
+	int			rd_vlen;
+	struct nfsd_file	*rd_nf;
 	
-	struct svc_rqst *rd_rqstp;          /* response */
-	struct svc_fh * rd_fhp;             /* response */
+	struct svc_rqst		*rd_rqstp;          /* response */
+	struct svc_fh		*rd_fhp;             /* response */
 };
 
 struct nfsd4_readdir {
@@ -538,8 +537,8 @@ struct nfsd4_copy {
 
 	struct nfs4_client      *cp_clp;
 
-	struct file             *file_src;
-	struct file             *file_dst;
+	struct nfsd_file        *nf_src;
+	struct nfsd_file        *nf_dst;
 
 	stateid_t		cp_stateid;
 
-- 
2.21.0

