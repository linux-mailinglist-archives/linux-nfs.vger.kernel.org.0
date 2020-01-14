Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8360513B055
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jan 2020 18:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbgANRE7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Jan 2020 12:04:59 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39388 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728757AbgANRE6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Jan 2020 12:04:58 -0500
Received: by mail-yw1-f67.google.com with SMTP id h126so9613650ywc.6
        for <linux-nfs@vger.kernel.org>; Tue, 14 Jan 2020 09:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SE26EesNUecRwDO6N1lJu/rquesZ28VIaIofdzQG548=;
        b=mE2g/1Y+4+tY4Gcy8z6VsRwsJcATKvuq3nyrNvIVTJmWlDPmWKe4HU5AZl7eYueDRJ
         mJ4woY1GZoX47tQ6hWWwcAkIg8dB9HQnBV2r6KHzsEHPsN3rKtpgdP2dE5/494+/TGvr
         laD5JGl6M2LDHIqi8Fosfr3jKpKpqqxvkWwTIqh4Co3z5r+RWU+R0j7m8VjjDofPdc9h
         JaRvJE6hDyDQiSxMDL41XVcE8RIkKFYbvtKziwWvTsFPFaZ0cpd1M+rdanUZER0WqLz+
         WEJXLuhzsxl/U1I7DrlVLkFRpviFuK/pP5TH0HTkF/FId4rbOMhkhcCPGP6b/E/kulgM
         PwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SE26EesNUecRwDO6N1lJu/rquesZ28VIaIofdzQG548=;
        b=lsdZHSD8ta3+I718BlrVxNHnzGk5Vbe8TXtQC28ci4BBxSZs2RihG2B620RNxCtdHw
         +nwwI2qsAF13KNyjP5N+G2xTiJAILt69tv5myKM5K8hXxrtr0RakLBgbe1eO4e12Ct/3
         9MKMRUnMTi1O/FvLxLpjTlwR/9z1xeVssGy9eIrQJ8wHa8DJJ12UAtMPcQnBB9qXWmPb
         DwqV64jmt7/xvTQJhP2CULls02oMPyHT0EhNf44a7HY9fowiFTuf/MHJsuQE5K8mKepX
         sMXywHDtwfvK5EzxIU/w5ZwkDvjDoZEirv3AMfiD52tnQ9ook8XQOtY50xGh+PtAyWLr
         JUWw==
X-Gm-Message-State: APjAAAU5OqpXEMRMuOt4XvSSajP5IC2zMEG4XpKTgMazKpsVyaSNuMQq
        bWIton3ALOL8V/gHPfslow==
X-Google-Smtp-Source: APXvYqw26CpsWLO7OSw1xGIkpydWmbHOQ41x85F0TCdRtGfA2EJOEDOUafZhC0I0lcd+QjPPQjfGPg==
X-Received: by 2002:a25:ada5:: with SMTP id z37mr14103980ybi.434.1579021497637;
        Tue, 14 Jan 2020 09:04:57 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id w74sm6981702ywa.71.2020.01.14.09.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 09:04:57 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: convert file cache to use over/underflow safe refcount
Date:   Tue, 14 Jan 2020 12:02:44 -0500
Message-Id: <20200114170244.923186-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Use the 'refcount_t' type instead of 'atomic_t' for improved
refcounting safety.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/filecache.c | 23 +++++++++++------------
 fs/nfsd/filecache.h |  4 ++--
 fs/nfsd/trace.h     |  4 ++--
 3 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 2fadf080ac42..23c1fa5da1e9 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -100,7 +100,7 @@ nfsd_file_mark_free(struct fsnotify_mark *mark)
 static struct nfsd_file_mark *
 nfsd_file_mark_get(struct nfsd_file_mark *nfm)
 {
-	if (!atomic_inc_not_zero(&nfm->nfm_ref))
+	if (!refcount_inc_not_zero(&nfm->nfm_ref))
 		return NULL;
 	return nfm;
 }
@@ -108,8 +108,7 @@ nfsd_file_mark_get(struct nfsd_file_mark *nfm)
 static void
 nfsd_file_mark_put(struct nfsd_file_mark *nfm)
 {
-	if (atomic_dec_and_test(&nfm->nfm_ref)) {
-
+	if (refcount_dec_and_test(&nfm->nfm_ref)) {
 		fsnotify_destroy_mark(&nfm->nfm_mark, nfsd_file_fsnotify_group);
 		fsnotify_put_mark(&nfm->nfm_mark);
 	}
@@ -148,7 +147,7 @@ nfsd_file_mark_find_or_create(struct nfsd_file *nf)
 			return NULL;
 		fsnotify_init_mark(&new->nfm_mark, nfsd_file_fsnotify_group);
 		new->nfm_mark.mask = FS_ATTRIB|FS_DELETE_SELF;
-		atomic_set(&new->nfm_ref, 1);
+		refcount_set(&new->nfm_ref, 1);
 
 		err = fsnotify_add_inode_mark(&new->nfm_mark, inode, 0);
 
@@ -186,7 +185,7 @@ nfsd_file_alloc(struct inode *inode, unsigned int may, unsigned int hashval,
 		nf->nf_flags = 0;
 		nf->nf_inode = inode;
 		nf->nf_hashval = hashval;
-		atomic_set(&nf->nf_ref, 1);
+		refcount_set(&nf->nf_ref, 1);
 		nf->nf_may = may & NFSD_FILE_MAY_MASK;
 		if (may & NFSD_MAY_NOT_BREAK_LEASE) {
 			if (may & NFSD_MAY_WRITE)
@@ -280,7 +279,7 @@ nfsd_file_unhash_and_release_locked(struct nfsd_file *nf, struct list_head *disp
 	if (!nfsd_file_unhash(nf))
 		return false;
 	/* keep final reference for nfsd_file_lru_dispose */
-	if (atomic_add_unless(&nf->nf_ref, -1, 1))
+	if (refcount_dec_not_one(&nf->nf_ref))
 		return true;
 
 	list_add(&nf->nf_lru, dispose);
@@ -292,7 +291,7 @@ nfsd_file_put_noref(struct nfsd_file *nf)
 {
 	trace_nfsd_file_put(nf);
 
-	if (atomic_dec_and_test(&nf->nf_ref)) {
+	if (refcount_dec_and_test(&nf->nf_ref)) {
 		WARN_ON(test_bit(NFSD_FILE_HASHED, &nf->nf_flags));
 		nfsd_file_free(nf);
 	}
@@ -304,7 +303,7 @@ nfsd_file_put(struct nfsd_file *nf)
 	bool is_hashed;
 
 	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
-	if (atomic_read(&nf->nf_ref) > 2 || !nf->nf_file) {
+	if (refcount_read(&nf->nf_ref) > 2 || !nf->nf_file) {
 		nfsd_file_put_noref(nf);
 		return;
 	}
@@ -321,7 +320,7 @@ nfsd_file_put(struct nfsd_file *nf)
 struct nfsd_file *
 nfsd_file_get(struct nfsd_file *nf)
 {
-	if (likely(atomic_inc_not_zero(&nf->nf_ref)))
+	if (likely(refcount_inc_not_zero(&nf->nf_ref)))
 		return nf;
 	return NULL;
 }
@@ -347,7 +346,7 @@ nfsd_file_dispose_list_sync(struct list_head *dispose)
 	while(!list_empty(dispose)) {
 		nf = list_first_entry(dispose, struct nfsd_file, nf_lru);
 		list_del(&nf->nf_lru);
-		if (!atomic_dec_and_test(&nf->nf_ref))
+		if (!refcount_dec_and_test(&nf->nf_ref))
 			continue;
 		if (nfsd_file_free(nf))
 			flush = true;
@@ -430,7 +429,7 @@ nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
 	 * counter. Here we check the counter and then test and clear the flag.
 	 * That order is deliberate to ensure that we can do this locklessly.
 	 */
-	if (atomic_read(&nf->nf_ref) > 1)
+	if (refcount_read(&nf->nf_ref) > 1)
 		goto out_skip;
 
 	/*
@@ -1019,7 +1018,7 @@ nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 open_file:
 	nf = new;
 	/* Take reference for the hashtable */
-	atomic_inc(&nf->nf_ref);
+	refcount_inc(&nf->nf_ref);
 	__set_bit(NFSD_FILE_HASHED, &nf->nf_flags);
 	__set_bit(NFSD_FILE_PENDING, &nf->nf_flags);
 	list_lru_add(&nfsd_file_lru, &nf->nf_lru);
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index 986c325a54bd..7872df5a0fe3 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -19,7 +19,7 @@
  */
 struct nfsd_file_mark {
 	struct fsnotify_mark	nfm_mark;
-	atomic_t		nfm_ref;
+	refcount_t		nfm_ref;
 };
 
 /*
@@ -43,7 +43,7 @@ struct nfsd_file {
 	unsigned long		nf_flags;
 	struct inode		*nf_inode;
 	unsigned int		nf_hashval;
-	atomic_t		nf_ref;
+	refcount_t		nf_ref;
 	unsigned char		nf_may;
 	struct nfsd_file_mark	*nf_mark;
 	struct rw_semaphore	nf_rwsem;
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 17ecef404e5b..06dd0d337049 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -201,7 +201,7 @@ DECLARE_EVENT_CLASS(nfsd_file_class,
 	TP_fast_assign(
 		__entry->nf_hashval = nf->nf_hashval;
 		__entry->nf_inode = nf->nf_inode;
-		__entry->nf_ref = atomic_read(&nf->nf_ref);
+		__entry->nf_ref = refcount_read(&nf->nf_ref);
 		__entry->nf_flags = nf->nf_flags;
 		__entry->nf_may = nf->nf_may;
 		__entry->nf_file = nf->nf_file;
@@ -250,7 +250,7 @@ TRACE_EVENT(nfsd_file_acquire,
 		__entry->hash = hash;
 		__entry->inode = inode;
 		__entry->may_flags = may_flags;
-		__entry->nf_ref = nf ? atomic_read(&nf->nf_ref) : 0;
+		__entry->nf_ref = nf ? refcount_read(&nf->nf_ref) : 0;
 		__entry->nf_flags = nf ? nf->nf_flags : 0;
 		__entry->nf_may = nf ? nf->nf_may : 0;
 		__entry->nf_file = nf ? nf->nf_file : NULL;
-- 
2.24.1

