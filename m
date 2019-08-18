Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3EB918C2
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Aug 2019 20:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfHRSV0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 18 Aug 2019 14:21:26 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36870 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfHRSVZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 18 Aug 2019 14:21:25 -0400
Received: by mail-io1-f66.google.com with SMTP id q22so16090790iog.4
        for <linux-nfs@vger.kernel.org>; Sun, 18 Aug 2019 11:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zt4n6s/YpVbTVOGWEloeyATSd4q30FWOGX3pX81vJbw=;
        b=HubosfmWE7ZYTlD9UaCcmKwW5WrISN0yaoF0jks7Nr0UIgfk/nfGwtu81TJkMI2r+M
         H48GNGK9ALDooIg4Lm3X1qkEYIzRlkHvjIlwXWV8HaZ8pG3BmZMmBUniXe4a/tOfZPSX
         /gUQZ6hPweaVhh2j6H+oryq3RzWsD4/Xoz5Tc7yZZI5Crmf/VSfDs4dK8r6uX6orI9gt
         KpA9yIKueq5ydeRjkftgFM9MyoVGuyGTAbt37tApxVpEV6y3n8QPC3WZP063xI/NjBXP
         LyYNUltML4n+krAaZW42eTLaDehGrWuLKkEdT0T9J9tTe4lrfyz/pBMxM5ZFxTh2M7Ap
         N8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zt4n6s/YpVbTVOGWEloeyATSd4q30FWOGX3pX81vJbw=;
        b=JjrU2QHRvzMj2J084Nc1Om2HNWAB2D1t+2ErHyMEFZz2FMguiTMix93GZIdDWjllSd
         XLxtmRrQi0gCQIHqaF3mMShdqduyzKzY44QVBssXzMTZlahr4EAuMLrxn7szFOrw5d1o
         x5lvfTsg7NIJ1jqQ7eTXkBwTwaNgp5NJRX6owaBuPDs6CpvlvvrbDNG3OGLarJ+Lf+DT
         B48AHtsnSqGC/pF/6F5KVEcXLCK8715WBsMNc/qm0+2woKu5dpefurj92Yt4kbwD8PhF
         +fx+AoFj6KIHiiJNbLyW01207nUIyXTMG9NxyLuqQqgsvCCIERt8xpzIqcN0zuDC9W6H
         tJ3A==
X-Gm-Message-State: APjAAAX3xNxcquacWhQewnBOJEpmU7BfVJewFgC7yrD5dDv7lgSDsWl5
        NbViZzHVDNnz9S9w6k9BGQ==
X-Google-Smtp-Source: APXvYqyUH1HUjvjDn+DpirJm//KXSGlcaHxPeL2O/+WI/khfZtYc+u1dYOUrEOL6CD6Wnj1M+G4LdA==
X-Received: by 2002:a5e:c911:: with SMTP id z17mr9743082iol.119.1566152484010;
        Sun, 18 Aug 2019 11:21:24 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id n22sm10317844iob.37.2019.08.18.11.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 11:21:23 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 10/16] nfsd: convert fi_deleg_file and ls_file fields to nfsd_file
Date:   Sun, 18 Aug 2019 14:18:53 -0400
Message-Id: <20190818181859.8458-11-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190818181859.8458-10-trond.myklebust@hammerspace.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Jeff Layton <jeff.layton@primarydata.com>

Have them keep an nfsd_file reference instead of a struct file.

Signed-off-by: Jeff Layton <jeff.layton@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/blocklayout.c |   3 +-
 fs/nfsd/nfs4layouts.c |  12 ++--
 fs/nfsd/nfs4state.c   | 140 +++++++++++++++++++++---------------------
 fs/nfsd/state.h       |   6 +-
 4 files changed, 82 insertions(+), 79 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 66d4c55eb48e..9bbaa671c079 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -15,6 +15,7 @@
 
 #include "blocklayoutxdr.h"
 #include "pnfs.h"
+#include "filecache.h"
 
 #define NFSDDBG_FACILITY	NFSDDBG_PNFS
 
@@ -404,7 +405,7 @@ static void
 nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls)
 {
 	struct nfs4_client *clp = ls->ls_stid.sc_client;
-	struct block_device *bdev = ls->ls_file->f_path.mnt->mnt_sb->s_bdev;
+	struct block_device *bdev = ls->ls_file->nf_file->f_path.mnt->mnt_sb->s_bdev;
 
 	bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, NFSD_MDS_PR_KEY,
 			nfsd4_scsi_pr_key(clp), 0, true);
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index a79e24b79095..2681c70283ce 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -169,8 +169,8 @@ nfsd4_free_layout_stateid(struct nfs4_stid *stid)
 	spin_unlock(&fp->fi_lock);
 
 	if (!nfsd4_layout_ops[ls->ls_layout_type]->disable_recalls)
-		vfs_setlease(ls->ls_file, F_UNLCK, NULL, (void **)&ls);
-	fput(ls->ls_file);
+		vfs_setlease(ls->ls_file->nf_file, F_UNLCK, NULL, (void **)&ls);
+	nfsd_file_put(ls->ls_file);
 
 	if (ls->ls_recalled)
 		atomic_dec(&ls->ls_stid.sc_file->fi_lo_recalls);
@@ -197,7 +197,7 @@ nfsd4_layout_setlease(struct nfs4_layout_stateid *ls)
 	fl->fl_end = OFFSET_MAX;
 	fl->fl_owner = ls;
 	fl->fl_pid = current->tgid;
-	fl->fl_file = ls->ls_file;
+	fl->fl_file = ls->ls_file->nf_file;
 
 	status = vfs_setlease(fl->fl_file, fl->fl_type, &fl, NULL);
 	if (status) {
@@ -236,13 +236,13 @@ nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
 			NFSPROC4_CLNT_CB_LAYOUT);
 
 	if (parent->sc_type == NFS4_DELEG_STID)
-		ls->ls_file = get_file(fp->fi_deleg_file);
+		ls->ls_file = nfsd_file_get(fp->fi_deleg_file);
 	else
 		ls->ls_file = find_any_file(fp);
 	BUG_ON(!ls->ls_file);
 
 	if (nfsd4_layout_setlease(ls)) {
-		fput(ls->ls_file);
+		nfsd_file_put(ls->ls_file);
 		put_nfs4_file(fp);
 		kmem_cache_free(nfs4_layout_stateid_cache, ls);
 		return NULL;
@@ -626,7 +626,7 @@ nfsd4_cb_layout_fail(struct nfs4_layout_stateid *ls)
 
 	argv[0] = (char *)nfsd_recall_failed;
 	argv[1] = addr_str;
-	argv[2] = ls->ls_file->f_path.mnt->mnt_sb->s_id;
+	argv[2] = ls->ls_file->nf_file->f_path.mnt->mnt_sb->s_id;
 	argv[3] = NULL;
 
 	error = call_usermodehelper(nfsd_recall_failed, argv, envp,
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 3742a2a7b4da..abcd3415dad0 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -430,18 +430,18 @@ put_nfs4_file(struct nfs4_file *fi)
 	}
 }
 
-static struct file *
+static struct nfsd_file *
 __nfs4_get_fd(struct nfs4_file *f, int oflag)
 {
 	if (f->fi_fds[oflag])
-		return get_file(f->fi_fds[oflag]->nf_file);
+		return nfsd_file_get(f->fi_fds[oflag]);
 	return NULL;
 }
 
-static struct file *
+static struct nfsd_file *
 find_writeable_file_locked(struct nfs4_file *f)
 {
-	struct file *ret;
+	struct nfsd_file *ret;
 
 	lockdep_assert_held(&f->fi_lock);
 
@@ -451,10 +451,10 @@ find_writeable_file_locked(struct nfs4_file *f)
 	return ret;
 }
 
-static struct file *
+static struct nfsd_file *
 find_writeable_file(struct nfs4_file *f)
 {
-	struct file *ret;
+	struct nfsd_file *ret;
 
 	spin_lock(&f->fi_lock);
 	ret = find_writeable_file_locked(f);
@@ -463,9 +463,10 @@ find_writeable_file(struct nfs4_file *f)
 	return ret;
 }
 
-static struct file *find_readable_file_locked(struct nfs4_file *f)
+static struct nfsd_file *
+find_readable_file_locked(struct nfs4_file *f)
 {
-	struct file *ret;
+	struct nfsd_file *ret;
 
 	lockdep_assert_held(&f->fi_lock);
 
@@ -475,10 +476,10 @@ static struct file *find_readable_file_locked(struct nfs4_file *f)
 	return ret;
 }
 
-static struct file *
+static struct nfsd_file *
 find_readable_file(struct nfs4_file *f)
 {
-	struct file *ret;
+	struct nfsd_file *ret;
 
 	spin_lock(&f->fi_lock);
 	ret = find_readable_file_locked(f);
@@ -487,10 +488,10 @@ find_readable_file(struct nfs4_file *f)
 	return ret;
 }
 
-struct file *
+struct nfsd_file *
 find_any_file(struct nfs4_file *f)
 {
-	struct file *ret;
+	struct nfsd_file *ret;
 
 	spin_lock(&f->fi_lock);
 	ret = __nfs4_get_fd(f, O_RDWR);
@@ -934,25 +935,25 @@ nfs4_inc_and_copy_stateid(stateid_t *dst, struct nfs4_stid *stid)
 
 static void put_deleg_file(struct nfs4_file *fp)
 {
-	struct file *filp = NULL;
+	struct nfsd_file *nf = NULL;
 
 	spin_lock(&fp->fi_lock);
 	if (--fp->fi_delegees == 0)
-		swap(filp, fp->fi_deleg_file);
+		swap(nf, fp->fi_deleg_file);
 	spin_unlock(&fp->fi_lock);
 
-	if (filp)
-		fput(filp);
+	if (nf)
+		nfsd_file_put(nf);
 }
 
 static void nfs4_unlock_deleg_lease(struct nfs4_delegation *dp)
 {
 	struct nfs4_file *fp = dp->dl_stid.sc_file;
-	struct file *filp = fp->fi_deleg_file;
+	struct nfsd_file *nf = fp->fi_deleg_file;
 
 	WARN_ON_ONCE(!fp->fi_delegees);
 
-	vfs_setlease(filp, F_UNLCK, NULL, (void **)&dp);
+	vfs_setlease(nf->nf_file, F_UNLCK, NULL, (void **)&dp);
 	put_deleg_file(fp);
 }
 
@@ -1290,11 +1291,14 @@ static void nfs4_free_lock_stateid(struct nfs4_stid *stid)
 {
 	struct nfs4_ol_stateid *stp = openlockstateid(stid);
 	struct nfs4_lockowner *lo = lockowner(stp->st_stateowner);
-	struct file *file;
+	struct nfsd_file *nf;
 
-	file = find_any_file(stp->st_stid.sc_file);
-	if (file)
-		filp_close(file, (fl_owner_t)lo);
+	nf = find_any_file(stp->st_stid.sc_file);
+	if (nf) {
+		get_file(nf->nf_file);
+		filp_close(nf->nf_file, (fl_owner_t)lo);
+		nfsd_file_put(nf);
+	}
 	nfs4_free_ol_stateid(stid);
 }
 
@@ -4768,7 +4772,7 @@ static struct file_lock *nfs4_alloc_init_lease(struct nfs4_delegation *dp,
 	fl->fl_end = OFFSET_MAX;
 	fl->fl_owner = (fl_owner_t)dp;
 	fl->fl_pid = current->tgid;
-	fl->fl_file = dp->dl_stid.sc_file->fi_deleg_file;
+	fl->fl_file = dp->dl_stid.sc_file->fi_deleg_file->nf_file;
 	return fl;
 }
 
@@ -4778,7 +4782,7 @@ nfs4_set_delegation(struct nfs4_client *clp, struct svc_fh *fh,
 {
 	int status = 0;
 	struct nfs4_delegation *dp;
-	struct file *filp;
+	struct nfsd_file *nf;
 	struct file_lock *fl;
 
 	/*
@@ -4789,8 +4793,8 @@ nfs4_set_delegation(struct nfs4_client *clp, struct svc_fh *fh,
 	if (fp->fi_had_conflict)
 		return ERR_PTR(-EAGAIN);
 
-	filp = find_readable_file(fp);
-	if (!filp) {
+	nf = find_readable_file(fp);
+	if (!nf) {
 		/* We should always have a readable file here */
 		WARN_ON_ONCE(1);
 		return ERR_PTR(-EBADF);
@@ -4800,17 +4804,17 @@ nfs4_set_delegation(struct nfs4_client *clp, struct svc_fh *fh,
 	if (nfs4_delegation_exists(clp, fp))
 		status = -EAGAIN;
 	else if (!fp->fi_deleg_file) {
-		fp->fi_deleg_file = filp;
+		fp->fi_deleg_file = nf;
 		/* increment early to prevent fi_deleg_file from being
 		 * cleared */
 		fp->fi_delegees = 1;
-		filp = NULL;
+		nf = NULL;
 	} else
 		fp->fi_delegees++;
 	spin_unlock(&fp->fi_lock);
 	spin_unlock(&state_lock);
-	if (filp)
-		fput(filp);
+	if (nf)
+		nfsd_file_put(nf);
 	if (status)
 		return ERR_PTR(status);
 
@@ -4823,7 +4827,7 @@ nfs4_set_delegation(struct nfs4_client *clp, struct svc_fh *fh,
 	if (!fl)
 		goto out_clnt_odstate;
 
-	status = vfs_setlease(fp->fi_deleg_file, fl->fl_type, &fl, NULL);
+	status = vfs_setlease(fp->fi_deleg_file->nf_file, fl->fl_type, &fl, NULL);
 	if (fl)
 		locks_free_lock(fl);
 	if (status)
@@ -4843,7 +4847,7 @@ nfs4_set_delegation(struct nfs4_client *clp, struct svc_fh *fh,
 
 	return dp;
 out_unlock:
-	vfs_setlease(fp->fi_deleg_file, F_UNLCK, NULL, (void **)&dp);
+	vfs_setlease(fp->fi_deleg_file->nf_file, F_UNLCK, NULL, (void **)&dp);
 out_clnt_odstate:
 	put_clnt_odstate(dp->dl_clnt_odstate);
 	nfs4_put_stid(&dp->dl_stid);
@@ -5514,7 +5518,7 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 	return nfs_ok;
 }
 
-static struct file *
+static struct nfsd_file *
 nfs4_find_file(struct nfs4_stid *s, int flags)
 {
 	if (!s)
@@ -5524,7 +5528,7 @@ nfs4_find_file(struct nfs4_stid *s, int flags)
 	case NFS4_DELEG_STID:
 		if (WARN_ON_ONCE(!s->sc_file->fi_deleg_file))
 			return NULL;
-		return get_file(s->sc_file->fi_deleg_file);
+		return nfsd_file_get(s->sc_file->fi_deleg_file);
 	case NFS4_OPEN_STID:
 	case NFS4_LOCK_STID:
 		if (flags & RD_STATE)
@@ -5553,29 +5557,27 @@ nfs4_check_file(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfs4_stid *s,
 		struct file **filpp, bool *tmp_file, int flags)
 {
 	int acc = (flags & RD_STATE) ? NFSD_MAY_READ : NFSD_MAY_WRITE;
-	struct file *file;
+	struct nfsd_file *nf;
 	__be32 status;
 
-	file = nfs4_find_file(s, flags);
-	if (file) {
+	nf = nfs4_find_file(s, flags);
+	if (nf) {
 		status = nfsd_permission(rqstp, fhp->fh_export, fhp->fh_dentry,
 				acc | NFSD_MAY_OWNER_OVERRIDE);
-		if (status) {
-			fput(file);
-			return status;
-		}
-
-		*filpp = file;
+		if (status)
+			goto out;
 	} else {
-		status = nfsd_open(rqstp, fhp, S_IFREG, acc, filpp);
+		status = nfsd_file_acquire(rqstp, fhp, acc, &nf);
 		if (status)
 			return status;
 
 		if (tmp_file)
 			*tmp_file = true;
 	}
-
-	return 0;
+	*filpp = get_file(nf->nf_file);
+out:
+	nfsd_file_put(nf);
+	return status;
 }
 
 /*
@@ -6393,7 +6395,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfs4_ol_stateid *lock_stp = NULL;
 	struct nfs4_ol_stateid *open_stp = NULL;
 	struct nfs4_file *fp;
-	struct file *filp = NULL;
+	struct nfsd_file *nf = NULL;
 	struct nfsd4_blocked_lock *nbl = NULL;
 	struct file_lock *file_lock = NULL;
 	struct file_lock *conflock = NULL;
@@ -6475,8 +6477,8 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			/* Fallthrough */
 		case NFS4_READ_LT:
 			spin_lock(&fp->fi_lock);
-			filp = find_readable_file_locked(fp);
-			if (filp)
+			nf = find_readable_file_locked(fp);
+			if (nf)
 				get_lock_access(lock_stp, NFS4_SHARE_ACCESS_READ);
 			spin_unlock(&fp->fi_lock);
 			fl_type = F_RDLCK;
@@ -6487,8 +6489,8 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			/* Fallthrough */
 		case NFS4_WRITE_LT:
 			spin_lock(&fp->fi_lock);
-			filp = find_writeable_file_locked(fp);
-			if (filp)
+			nf = find_writeable_file_locked(fp);
+			if (nf)
 				get_lock_access(lock_stp, NFS4_SHARE_ACCESS_WRITE);
 			spin_unlock(&fp->fi_lock);
 			fl_type = F_WRLCK;
@@ -6498,7 +6500,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		goto out;
 	}
 
-	if (!filp) {
+	if (!nf) {
 		status = nfserr_openmode;
 		goto out;
 	}
@@ -6514,7 +6516,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	file_lock->fl_type = fl_type;
 	file_lock->fl_owner = (fl_owner_t)lockowner(nfs4_get_stateowner(&lock_sop->lo_owner));
 	file_lock->fl_pid = current->tgid;
-	file_lock->fl_file = filp;
+	file_lock->fl_file = nf->nf_file;
 	file_lock->fl_flags = fl_flags;
 	file_lock->fl_lmops = &nfsd_posix_mng_ops;
 	file_lock->fl_start = lock->lk_offset;
@@ -6536,7 +6538,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		spin_unlock(&nn->blocked_locks_lock);
 	}
 
-	err = vfs_lock_file(filp, F_SETLK, file_lock, conflock);
+	err = vfs_lock_file(nf->nf_file, F_SETLK, file_lock, conflock);
 	switch (err) {
 	case 0: /* success! */
 		nfs4_inc_and_copy_stateid(&lock->lk_resp_stateid, &lock_stp->st_stid);
@@ -6571,8 +6573,8 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		}
 		free_blocked_lock(nbl);
 	}
-	if (filp)
-		fput(filp);
+	if (nf)
+		nfsd_file_put(nf);
 	if (lock_stp) {
 		/* Bump seqid manually if the 4.0 replay owner is openowner */
 		if (cstate->replay_owner &&
@@ -6699,7 +6701,7 @@ nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 {
 	struct nfsd4_locku *locku = &u->locku;
 	struct nfs4_ol_stateid *stp;
-	struct file *filp = NULL;
+	struct nfsd_file *nf = NULL;
 	struct file_lock *file_lock = NULL;
 	__be32 status;
 	int err;
@@ -6717,8 +6719,8 @@ nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 					&stp, nn);
 	if (status)
 		goto out;
-	filp = find_any_file(stp->st_stid.sc_file);
-	if (!filp) {
+	nf = find_any_file(stp->st_stid.sc_file);
+	if (!nf) {
 		status = nfserr_lock_range;
 		goto put_stateid;
 	}
@@ -6726,13 +6728,13 @@ nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (!file_lock) {
 		dprintk("NFSD: %s: unable to allocate lock!\n", __func__);
 		status = nfserr_jukebox;
-		goto fput;
+		goto put_file;
 	}
 
 	file_lock->fl_type = F_UNLCK;
 	file_lock->fl_owner = (fl_owner_t)lockowner(nfs4_get_stateowner(stp->st_stateowner));
 	file_lock->fl_pid = current->tgid;
-	file_lock->fl_file = filp;
+	file_lock->fl_file = nf->nf_file;
 	file_lock->fl_flags = FL_POSIX;
 	file_lock->fl_lmops = &nfsd_posix_mng_ops;
 	file_lock->fl_start = locku->lu_offset;
@@ -6741,14 +6743,14 @@ nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 						locku->lu_length);
 	nfs4_transform_lock_offset(file_lock);
 
-	err = vfs_lock_file(filp, F_SETLK, file_lock, NULL);
+	err = vfs_lock_file(nf->nf_file, F_SETLK, file_lock, NULL);
 	if (err) {
 		dprintk("NFSD: nfs4_locku: vfs_lock_file failed!\n");
 		goto out_nfserr;
 	}
 	nfs4_inc_and_copy_stateid(&locku->lu_stateid, &stp->st_stid);
-fput:
-	fput(filp);
+put_file:
+	nfsd_file_put(nf);
 put_stateid:
 	mutex_unlock(&stp->st_mutex);
 	nfs4_put_stid(&stp->st_stid);
@@ -6760,7 +6762,7 @@ nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 out_nfserr:
 	status = nfserrno(err);
-	goto fput;
+	goto put_file;
 }
 
 /*
@@ -6773,17 +6775,17 @@ check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner)
 {
 	struct file_lock *fl;
 	int status = false;
-	struct file *filp = find_any_file(fp);
+	struct nfsd_file *nf = find_any_file(fp);
 	struct inode *inode;
 	struct file_lock_context *flctx;
 
-	if (!filp) {
+	if (!nf) {
 		/* Any valid lock stateid should have some sort of access */
 		WARN_ON_ONCE(1);
 		return status;
 	}
 
-	inode = locks_inode(filp);
+	inode = locks_inode(nf->nf_file);
 	flctx = inode->i_flctx;
 
 	if (flctx && !list_empty_careful(&flctx->flc_posix)) {
@@ -6796,7 +6798,7 @@ check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner)
 		}
 		spin_unlock(&flctx->flc_lock);
 	}
-	fput(filp);
+	nfsd_file_put(nf);
 	return status;
 }
 
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 8196bfb74f12..d89d1ade1254 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -516,7 +516,7 @@ struct nfs4_file {
 	 */
 	atomic_t		fi_access[2];
 	u32			fi_share_deny;
-	struct file		*fi_deleg_file;
+	struct nfsd_file	*fi_deleg_file;
 	int			fi_delegees;
 	struct knfsd_fh		fi_fhandle;
 	bool			fi_had_conflict;
@@ -565,7 +565,7 @@ struct nfs4_layout_stateid {
 	spinlock_t			ls_lock;
 	struct list_head		ls_layouts;
 	u32				ls_layout_type;
-	struct file			*ls_file;
+	struct nfsd_file		*ls_file;
 	struct nfsd4_callback		ls_recall;
 	stateid_t			ls_recall_sid;
 	bool				ls_recalled;
@@ -657,7 +657,7 @@ static inline void get_nfs4_file(struct nfs4_file *fi)
 {
 	refcount_inc(&fi->fi_ref);
 }
-struct file *find_any_file(struct nfs4_file *f);
+struct nfsd_file *find_any_file(struct nfs4_file *f);
 
 /* grace period management */
 void nfsd4_end_grace(struct nfsd_net *nn);
-- 
2.21.0

