Return-Path: <linux-nfs+bounces-14648-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC560B9ADB8
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 18:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8D1819C3F5F
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 16:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788AC16D4EF;
	Wed, 24 Sep 2025 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="CjdfeCCf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADFB1EF091
	for <linux-nfs@vger.kernel.org>; Wed, 24 Sep 2025 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758730868; cv=none; b=X6imRqV1egrZ2KJOi1qQDSU9AyV5tvYMi9gpnYZZckLwOhEQ/M5YO9L/yHakamZR19wo07c/svp95uw0XX9CH+Zqq+Rx6Uk5S+Do9MtSkHccOjvPdzIPqBQn+8J2/Ie3vGXlPWvKNp7fAjtU/08ORYCwLyiLBMLgq5IAHyBXpaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758730868; c=relaxed/simple;
	bh=OjWbuJJ8F/5sGtxD0mT4oKEGbpfMkUiErqXbvrFUwd0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N3495NkdhQ5dXCUpWOmR1IC4FLR3s4sZ1Gj5fWGriV3J8p0mC7w9fSe6lZK1EYYChpIbragVPrZsTtEb1zFEggUoMPNlNAX8i9AmjEIkBcB+48HERgnZQskpi26nn2EwWU8/i8L7zdEUyQFnP7YuRGykJaycBQJ0V6wTn7P2jRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=CjdfeCCf; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62fbc90e6f6so10221269a12.3
        for <linux-nfs@vger.kernel.org>; Wed, 24 Sep 2025 09:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758730864; x=1759335664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azDLsI7UjptFP0c2TnwTMIaGxwoGun/yHIhPL6MpJyM=;
        b=CjdfeCCffndGOkBNef11OgzFGhAnaLzm/KwQrsb9W7/3oa1TLws7jNUxvFXyzT9SX8
         ucAAK4RmnbIWfmsssi109QnXl5vpeqckvPdJ3QVa/G0bZh4mxeQqP3h4DX2vZQ6hGcVR
         h5xQ11RMctsvx2FVaX0Hh0mQnwPwbgcMgoCNxnpvh5lP3lsJCBQaUlLx6SRhZuBUHV7I
         ZpOcY/HXVdK/Q3VlN8LMjm7M/seDBPsVxyHIgtgF+LbA4mt/QUt5Z9z4LYlolMeR0rJw
         QLUe4aQR23wavGcMS8BUwEjHppwPUmjDbed/h+0E9EFv9el1cwRykILoRgHCvXYS56o0
         hdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758730864; x=1759335664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azDLsI7UjptFP0c2TnwTMIaGxwoGun/yHIhPL6MpJyM=;
        b=EzQag6kEtfsaFPhyMRp1OH6kFOXa7Vm/4mOhqP3OXVVDoj6hqC6HVuZR2yCWjaodQD
         2u1a+XCJBpwqNLPriY5CRypRaeuzeSedkKRNga0C+gJDcgUFVRF6095EGxCnS4iELaiH
         F1UayCp9IGomTtbwR98lutmCUPkk91ddFX2vSOAxSNQCbFuOTkvSG+GH+3UkbNIAfd3e
         TvKvy8LQYAqHp4BL7TDj1ZeF6uOJeR7kpNzaLoW3NZr12knaIsKeHSDoFlZ7PfWkhDnU
         rlH/D2WVZQs41NdNlDe8HvXo+VKzAVuJUCkG7qst36njvfFeofCw3pd6YYP/tK0EQGoN
         Grpg==
X-Forwarded-Encrypted: i=1; AJvYcCUWnQEYl6PX8fhlZkhWbnYzXBemOEj3enETblAfg7wr6zYgiTXM722wkGuCfdOI3hwvFTe5TuFbfqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0P//QZgS0GiSGxYKgvpEepIuLTdT9N6gc9awGCvSRr9eRFn3T
	IRSW4JpiGvs8DXH50YtJCEjigEqcz+XpZ8hE5OqB2niTIqyxU+Ohp7tAZrUBdOCJsCA=
X-Gm-Gg: ASbGncu8WeGJ4Tj27LG7/LCeJ2kGrFMalYAhZ3xprWWG47y9jVJwlEiPGU0hO+0wpID
	dN6O4ef7BzJHvA7r7Xf5OLuVxYTAIR84rXDxRn7nd1KpnLVEqD6FSNlXkUwtDJjNQGkJV7ULWPk
	fEeHhlalTDgmhc0fXm2fPd2tJxGknlRioGYyfnLZ9xEaxVWESa0sv2mkuPDyi55YdfKsLoD61xY
	aYEOQvWvEcjrRmbNYRSucTYVtr9Ej/VetYTIQtLCoJsqpvhwLiW34+CtMDBhBWxh2Q/S1ED3b/k
	ObvyFuJv07JQ5++8yab0CbQB5732I077w77RgZDLgHdICRMM9Phbh9JV8JZiGYTLLG0NxAHRAxE
	UAtE4fTP3sbekEYUVTvYEL9g=
X-Google-Smtp-Source: AGHT+IFW339tKFBTv/3Rmsj3NrE3OX0Xf+/6YSNKcgicPNbvz28Bmw86cp1giJjfvAWwX6LKQZFucw==
X-Received: by 2002:a05:6402:270f:b0:62f:a904:7646 with SMTP id 4fb4d7f45d1cf-6349fa73c48mr64584a12.21.1758730864021;
        Wed, 24 Sep 2025 09:21:04 -0700 (PDT)
Received: from localhost ([208.88.158.128])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62fa5f133cfsm13111820a12.34.2025.09.24.09.21.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 09:21:03 -0700 (PDT)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [RFC PATCH v4 3/9] NFSv4/flexfiles: Add data structure support for striped layouts
Date: Wed, 24 Sep 2025 16:20:44 +0000
Message-Id: <20250924162050.634451-4-jcurley@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250924162050.634451-1-jcurley@purestorage.com>
References: <20250924162050.634451-1-jcurley@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds a new struct nfs4_ff_layout_ds_stripe that represents a data
server stripe within a layout. A new dynamically allocated array of
this type has been added to nfs4_ff_layout_mirror and per stripe
configuration information has been moved from the mirror type to the
stripe based on the RFC.

Signed-off-by: Jonathan Curley <jcurley@purestorage.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c    | 134 ++++++++++++----------
 fs/nfs/flexfilelayout/flexfilelayout.h    |  27 +++--
 fs/nfs/flexfilelayout/flexfilelayoutdev.c |  54 ++++-----
 3 files changed, 117 insertions(+), 98 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index a437d20ebcdf..46a765bf05c3 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -171,7 +171,7 @@ ff_local_open_fh(struct pnfs_layout_segment *lseg, u32 ds_idx,
 #if IS_ENABLED(CONFIG_NFS_LOCALIO)
 	struct nfs4_ff_layout_mirror *mirror = FF_LAYOUT_COMP(lseg, ds_idx);
 
-	return nfs_local_open_fh(clp, cred, fh, &mirror->nfl, mode);
+	return nfs_local_open_fh(clp, cred, fh, &mirror->dss[0].nfl, mode);
 #else
 	return NULL;
 #endif
@@ -182,13 +182,13 @@ static bool ff_mirror_match_fh(const struct nfs4_ff_layout_mirror *m1,
 {
 	int i, j;
 
-	if (m1->fh_versions_cnt != m2->fh_versions_cnt)
+	if (m1->dss[0].fh_versions_cnt != m2->dss[0].fh_versions_cnt)
 		return false;
-	for (i = 0; i < m1->fh_versions_cnt; i++) {
+	for (i = 0; i < m1->dss[0].fh_versions_cnt; i++) {
 		bool found_fh = false;
-		for (j = 0; j < m2->fh_versions_cnt; j++) {
-			if (nfs_compare_fh(&m1->fh_versions[i],
-					&m2->fh_versions[j]) == 0) {
+		for (j = 0; j < m2->dss[0].fh_versions_cnt; j++) {
+			if (nfs_compare_fh(&m1->dss[0].fh_versions[i],
+					&m2->dss[0].fh_versions[j]) == 0) {
 				found_fh = true;
 				break;
 			}
@@ -209,7 +209,8 @@ ff_layout_add_mirror(struct pnfs_layout_hdr *lo,
 
 	spin_lock(&inode->i_lock);
 	list_for_each_entry(pos, &ff_layout->mirrors, mirrors) {
-		if (memcmp(&mirror->devid, &pos->devid, sizeof(pos->devid)) != 0)
+		if (memcmp(&mirror->dss[0].devid, &pos->dss[0].devid,
+			   sizeof(pos->dss[0].devid)) != 0)
 			continue;
 		if (!ff_mirror_match_fh(mirror, pos))
 			continue;
@@ -246,23 +247,27 @@ static struct nfs4_ff_layout_mirror *ff_layout_alloc_mirror(gfp_t gfp_flags)
 		spin_lock_init(&mirror->lock);
 		refcount_set(&mirror->ref, 1);
 		INIT_LIST_HEAD(&mirror->mirrors);
-		nfs_localio_file_init(&mirror->nfl);
+		nfs_localio_file_init(&mirror->dss[0].nfl);
 	}
 	return mirror;
 }
 
 static void ff_layout_free_mirror(struct nfs4_ff_layout_mirror *mirror)
 {
-	const struct cred *cred;
+	const struct cred	*cred;
+	int dss_id = 0;
 
 	ff_layout_remove_mirror(mirror);
-	kfree(mirror->fh_versions);
-	nfs_close_local_fh(&mirror->nfl);
-	cred = rcu_access_pointer(mirror->ro_cred);
+
+	kfree(mirror->dss[dss_id].fh_versions);
+	nfs_close_local_fh(&mirror->dss[dss_id].nfl);
+	cred = rcu_access_pointer(mirror->dss[dss_id].ro_cred);
 	put_cred(cred);
-	cred = rcu_access_pointer(mirror->rw_cred);
+	cred = rcu_access_pointer(mirror->dss[dss_id].rw_cred);
 	put_cred(cred);
-	nfs4_ff_layout_put_deviceid(mirror->mirror_ds);
+	nfs4_ff_layout_put_deviceid(mirror->dss[dss_id].mirror_ds);
+
+	kfree(mirror->dss);
 	kfree(mirror);
 }
 
@@ -372,8 +377,8 @@ static void ff_layout_sort_mirrors(struct nfs4_ff_layout_segment *fls)
 
 	for (i = 0; i < fls->mirror_array_cnt - 1; i++) {
 		for (j = i + 1; j < fls->mirror_array_cnt; j++)
-			if (fls->mirror_array[i]->efficiency <
-			    fls->mirror_array[j]->efficiency)
+			if (fls->mirror_array[i]->dss[0].efficiency <
+			    fls->mirror_array[j]->dss[0].efficiency)
 				swap(fls->mirror_array[i],
 				     fls->mirror_array[j]);
 	}
@@ -427,23 +432,25 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 	fls->mirror_array_cnt = mirror_array_cnt;
 	fls->stripe_unit = stripe_unit;
 
+	u32 dss_count = 0;
 	for (i = 0; i < fls->mirror_array_cnt; i++) {
 		struct nfs4_ff_layout_mirror *mirror;
 		struct cred *kcred;
 		const struct cred __rcu *cred;
 		kuid_t uid;
 		kgid_t gid;
-		u32 ds_count, fh_count, id;
-		int j;
+		u32 fh_count, id;
+		int j, dss_id = 0;
 
 		rc = -EIO;
 		p = xdr_inline_decode(&stream, 4);
 		if (!p)
 			goto out_err_free;
-		ds_count = be32_to_cpup(p);
+
+		dss_count = be32_to_cpup(p);
 
 		/* FIXME: allow for striping? */
-		if (ds_count != 1)
+		if (dss_count != 1)
 			goto out_err_free;
 
 		fls->mirror_array[i] = ff_layout_alloc_mirror(gfp_flags);
@@ -452,10 +459,13 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 			goto out_err_free;
 		}
 
-		fls->mirror_array[i]->ds_count = ds_count;
+		fls->mirror_array[i]->dss_count = dss_count;
+		fls->mirror_array[i]->dss =
+		    kcalloc(dss_count, sizeof(struct nfs4_ff_layout_ds_stripe),
+			    gfp_flags);
 
 		/* deviceid */
-		rc = decode_deviceid(&stream, &fls->mirror_array[i]->devid);
+		rc = decode_deviceid(&stream, &fls->mirror_array[i]->dss[dss_id].devid);
 		if (rc)
 			goto out_err_free;
 
@@ -464,10 +474,10 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 		p = xdr_inline_decode(&stream, 4);
 		if (!p)
 			goto out_err_free;
-		fls->mirror_array[i]->efficiency = be32_to_cpup(p);
+		fls->mirror_array[i]->dss[dss_id].efficiency = be32_to_cpup(p);
 
 		/* stateid */
-		rc = decode_pnfs_stateid(&stream, &fls->mirror_array[i]->stateid);
+		rc = decode_pnfs_stateid(&stream, &fls->mirror_array[i]->dss[dss_id].stateid);
 		if (rc)
 			goto out_err_free;
 
@@ -478,22 +488,22 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 			goto out_err_free;
 		fh_count = be32_to_cpup(p);
 
-		fls->mirror_array[i]->fh_versions =
-			kcalloc(fh_count, sizeof(struct nfs_fh),
-				gfp_flags);
-		if (fls->mirror_array[i]->fh_versions == NULL) {
+		fls->mirror_array[i]->dss[dss_id].fh_versions =
+		    kcalloc(fh_count, sizeof(struct nfs_fh),
+			    gfp_flags);
+		if (fls->mirror_array[i]->dss[dss_id].fh_versions == NULL) {
 			rc = -ENOMEM;
 			goto out_err_free;
 		}
 
 		for (j = 0; j < fh_count; j++) {
 			rc = decode_nfs_fh(&stream,
-					   &fls->mirror_array[i]->fh_versions[j]);
+					   &fls->mirror_array[i]->dss[dss_id].fh_versions[j]);
 			if (rc)
 				goto out_err_free;
 		}
 
-		fls->mirror_array[i]->fh_versions_cnt = fh_count;
+		fls->mirror_array[i]->dss[dss_id].fh_versions_cnt = fh_count;
 
 		/* user */
 		rc = decode_name(&stream, &id);
@@ -524,19 +534,21 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 		cred = RCU_INITIALIZER(kcred);
 
 		if (lgr->range.iomode == IOMODE_READ)
-			rcu_assign_pointer(fls->mirror_array[i]->ro_cred, cred);
+			rcu_assign_pointer(fls->mirror_array[i]->dss[dss_id].ro_cred, cred);
 		else
-			rcu_assign_pointer(fls->mirror_array[i]->rw_cred, cred);
+			rcu_assign_pointer(fls->mirror_array[i]->dss[dss_id].rw_cred, cred);
 
 		mirror = ff_layout_add_mirror(lh, fls->mirror_array[i]);
 		if (mirror != fls->mirror_array[i]) {
 			/* swap cred ptrs so free_mirror will clean up old */
 			if (lgr->range.iomode == IOMODE_READ) {
-				cred = xchg(&mirror->ro_cred, fls->mirror_array[i]->ro_cred);
-				rcu_assign_pointer(fls->mirror_array[i]->ro_cred, cred);
+				cred = xchg(&mirror->dss[dss_id].ro_cred,
+					    fls->mirror_array[i]->dss[dss_id].ro_cred);
+				rcu_assign_pointer(fls->mirror_array[i]->dss[dss_id].ro_cred, cred);
 			} else {
-				cred = xchg(&mirror->rw_cred, fls->mirror_array[i]->rw_cred);
-				rcu_assign_pointer(fls->mirror_array[i]->rw_cred, cred);
+				cred = xchg(&mirror->dss[dss_id].rw_cred,
+					    fls->mirror_array[i]->dss[dss_id].rw_cred);
+				rcu_assign_pointer(fls->mirror_array[i]->dss[dss_id].rw_cred, cred);
 			}
 			ff_layout_free_mirror(fls->mirror_array[i]);
 			fls->mirror_array[i] = mirror;
@@ -624,8 +636,8 @@ nfs4_ff_layoutstat_start_io(struct nfs4_ff_layout_mirror *mirror,
 	struct nfs4_flexfile_layout *ffl = FF_LAYOUT_FROM_HDR(mirror->layout);
 
 	nfs4_ff_start_busy_timer(&layoutstat->busy_timer, now);
-	if (!mirror->start_time)
-		mirror->start_time = now;
+	if (!mirror->dss[0].start_time)
+		mirror->dss[0].start_time = now;
 	if (mirror->report_interval != 0)
 		report_interval = (s64)mirror->report_interval * 1000LL;
 	else if (layoutstats_timer != 0)
@@ -680,8 +692,8 @@ nfs4_ff_layout_stat_io_start_read(struct inode *inode,
 	bool report;
 
 	spin_lock(&mirror->lock);
-	report = nfs4_ff_layoutstat_start_io(mirror, &mirror->read_stat, now);
-	nfs4_ff_layout_stat_io_update_requested(&mirror->read_stat, requested);
+	report = nfs4_ff_layoutstat_start_io(mirror, &mirror->dss[0].read_stat, now);
+	nfs4_ff_layout_stat_io_update_requested(&mirror->dss[0].read_stat, requested);
 	set_bit(NFS4_FF_MIRROR_STAT_AVAIL, &mirror->flags);
 	spin_unlock(&mirror->lock);
 
@@ -696,7 +708,7 @@ nfs4_ff_layout_stat_io_end_read(struct rpc_task *task,
 		__u64 completed)
 {
 	spin_lock(&mirror->lock);
-	nfs4_ff_layout_stat_io_update_completed(&mirror->read_stat,
+	nfs4_ff_layout_stat_io_update_completed(&mirror->dss[0].read_stat,
 			requested, completed,
 			ktime_get(), task->tk_start);
 	set_bit(NFS4_FF_MIRROR_STAT_AVAIL, &mirror->flags);
@@ -711,8 +723,8 @@ nfs4_ff_layout_stat_io_start_write(struct inode *inode,
 	bool report;
 
 	spin_lock(&mirror->lock);
-	report = nfs4_ff_layoutstat_start_io(mirror , &mirror->write_stat, now);
-	nfs4_ff_layout_stat_io_update_requested(&mirror->write_stat, requested);
+	report = nfs4_ff_layoutstat_start_io(mirror, &mirror->dss[0].write_stat, now);
+	nfs4_ff_layout_stat_io_update_requested(&mirror->dss[0].write_stat, requested);
 	set_bit(NFS4_FF_MIRROR_STAT_AVAIL, &mirror->flags);
 	spin_unlock(&mirror->lock);
 
@@ -731,7 +743,7 @@ nfs4_ff_layout_stat_io_end_write(struct rpc_task *task,
 		requested = completed = 0;
 
 	spin_lock(&mirror->lock);
-	nfs4_ff_layout_stat_io_update_completed(&mirror->write_stat,
+	nfs4_ff_layout_stat_io_update_completed(&mirror->dss[0].write_stat,
 			requested, completed, ktime_get(), task->tk_start);
 	set_bit(NFS4_FF_MIRROR_STAT_AVAIL, &mirror->flags);
 	spin_unlock(&mirror->lock);
@@ -773,7 +785,7 @@ ff_layout_choose_ds_for_read(struct pnfs_layout_segment *lseg,
 			continue;
 
 		if (check_device &&
-		    nfs4_test_deviceid_unavailable(&mirror->mirror_ds->id_node))
+		    nfs4_test_deviceid_unavailable(&mirror->dss[0].mirror_ds->id_node))
 			continue;
 
 		*best_idx = idx;
@@ -879,7 +891,7 @@ ff_layout_pg_init_read(struct nfs_pageio_descriptor *pgio,
 
 	mirror = FF_LAYOUT_COMP(pgio->pg_lseg, ds_idx);
 	pgm = &pgio->pg_mirrors[0];
-	pgm->pg_bsize = mirror->mirror_ds->ds_versions[0].rsize;
+	pgm->pg_bsize = mirror->dss[0].mirror_ds->ds_versions[0].rsize;
 
 	pgio->pg_mirror_idx = ds_idx;
 	return;
@@ -951,7 +963,7 @@ ff_layout_pg_init_write(struct nfs_pageio_descriptor *pgio,
 			goto retry;
 		}
 		pgm = &pgio->pg_mirrors[i];
-		pgm->pg_bsize = mirror->mirror_ds->ds_versions[0].wsize;
+		pgm->pg_bsize = mirror->dss[0].mirror_ds->ds_versions[0].wsize;
 	}
 
 	if (NFS_SERVER(pgio->pg_inode)->flags &
@@ -2021,7 +2033,7 @@ select_ds_fh_from_commit(struct pnfs_layout_segment *lseg, u32 i)
 	/* FIXME: Assume that there is only one NFS version available
 	 * for the DS.
 	 */
-	return &flseg->mirror_array[i]->fh_versions[0];
+	return &flseg->mirror_array[i]->dss[0].fh_versions[0];
 }
 
 static int ff_layout_initiate_commit(struct nfs_commit_data *data, int how)
@@ -2137,10 +2149,10 @@ static void ff_layout_cancel_io(struct pnfs_layout_segment *lseg)
 
 	for (idx = 0; idx < flseg->mirror_array_cnt; idx++) {
 		mirror = flseg->mirror_array[idx];
-		mirror_ds = mirror->mirror_ds;
+		mirror_ds = mirror->dss[0].mirror_ds;
 		if (IS_ERR_OR_NULL(mirror_ds))
 			continue;
-		ds = mirror->mirror_ds->ds;
+		ds = mirror->dss[0].mirror_ds->ds;
 		if (!ds)
 			continue;
 		ds_clp = ds->ds_clp;
@@ -2541,8 +2553,8 @@ ff_layout_encode_ff_layoutupdate(struct xdr_stream *xdr,
 			      struct nfs4_ff_layout_mirror *mirror)
 {
 	struct nfs4_pnfs_ds_addr *da;
-	struct nfs4_pnfs_ds *ds = mirror->mirror_ds->ds;
-	struct nfs_fh *fh = &mirror->fh_versions[0];
+	struct nfs4_pnfs_ds *ds = mirror->dss[0].mirror_ds->ds;
+	struct nfs_fh *fh = &mirror->dss[0].fh_versions[0];
 	__be32 *p;
 
 	da = list_first_entry(&ds->ds_addrs, struct nfs4_pnfs_ds_addr, da_node);
@@ -2555,12 +2567,12 @@ ff_layout_encode_ff_layoutupdate(struct xdr_stream *xdr,
 	xdr_encode_opaque(p, fh->data, fh->size);
 	/* ff_io_latency4 read */
 	spin_lock(&mirror->lock);
-	ff_layout_encode_io_latency(xdr, &mirror->read_stat.io_stat);
+	ff_layout_encode_io_latency(xdr, &mirror->dss[0].read_stat.io_stat);
 	/* ff_io_latency4 write */
-	ff_layout_encode_io_latency(xdr, &mirror->write_stat.io_stat);
+	ff_layout_encode_io_latency(xdr, &mirror->dss[0].write_stat.io_stat);
 	spin_unlock(&mirror->lock);
 	/* nfstime4 */
-	ff_layout_encode_nfstime(xdr, ktime_sub(ktime_get(), mirror->start_time));
+	ff_layout_encode_nfstime(xdr, ktime_sub(ktime_get(), mirror->dss[0].start_time));
 	/* bool */
 	p = xdr_reserve_space(xdr, 4);
 	*p = cpu_to_be32(false);
@@ -2607,7 +2619,7 @@ ff_layout_mirror_prepare_stats(struct pnfs_layout_hdr *lo,
 	list_for_each_entry(mirror, &ff_layout->mirrors, mirrors) {
 		if (i >= dev_limit)
 			break;
-		if (IS_ERR_OR_NULL(mirror->mirror_ds))
+		if (IS_ERR_OR_NULL(mirror->dss[0].mirror_ds))
 			continue;
 		if (!test_and_clear_bit(NFS4_FF_MIRROR_STAT_AVAIL,
 					&mirror->flags) &&
@@ -2616,15 +2628,15 @@ ff_layout_mirror_prepare_stats(struct pnfs_layout_hdr *lo,
 		/* mirror refcount put in cleanup_layoutstats */
 		if (!refcount_inc_not_zero(&mirror->ref))
 			continue;
-		dev = &mirror->mirror_ds->id_node; 
+		dev = &mirror->dss[0].mirror_ds->id_node;
 		memcpy(&devinfo->dev_id, &dev->deviceid, NFS4_DEVICEID4_SIZE);
 		devinfo->offset = 0;
 		devinfo->length = NFS4_MAX_UINT64;
 		spin_lock(&mirror->lock);
-		devinfo->read_count = mirror->read_stat.io_stat.ops_completed;
-		devinfo->read_bytes = mirror->read_stat.io_stat.bytes_completed;
-		devinfo->write_count = mirror->write_stat.io_stat.ops_completed;
-		devinfo->write_bytes = mirror->write_stat.io_stat.bytes_completed;
+		devinfo->read_count = mirror->dss[0].read_stat.io_stat.ops_completed;
+		devinfo->read_bytes = mirror->dss[0].read_stat.io_stat.bytes_completed;
+		devinfo->write_count = mirror->dss[0].write_stat.io_stat.ops_completed;
+		devinfo->write_bytes = mirror->dss[0].write_stat.io_stat.bytes_completed;
 		spin_unlock(&mirror->lock);
 		devinfo->layout_type = LAYOUT_FLEX_FILES;
 		devinfo->ld_private.ops = &layoutstat_ops;
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.h b/fs/nfs/flexfilelayout/flexfilelayout.h
index 095df09017a5..14640452713b 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.h
+++ b/fs/nfs/flexfilelayout/flexfilelayout.h
@@ -71,12 +71,12 @@ struct nfs4_ff_layoutstat {
 	struct nfs4_ff_busy_timer busy_timer;
 };
 
-struct nfs4_ff_layout_mirror {
-	struct pnfs_layout_hdr		*layout;
-	struct list_head		mirrors;
-	u32				ds_count;
-	u32				efficiency;
+struct nfs4_ff_layout_mirror;
+
+struct nfs4_ff_layout_ds_stripe {
+	struct nfs4_ff_layout_mirror   *mirror;
 	struct nfs4_deviceid		devid;
+	u32				efficiency;
 	struct nfs4_ff_layout_ds	*mirror_ds;
 	u32				fh_versions_cnt;
 	struct nfs_fh			*fh_versions;
@@ -84,12 +84,19 @@ struct nfs4_ff_layout_mirror {
 	const struct cred __rcu		*ro_cred;
 	const struct cred __rcu		*rw_cred;
 	struct nfs_file_localio		nfl;
-	refcount_t			ref;
-	spinlock_t			lock;
-	unsigned long			flags;
 	struct nfs4_ff_layoutstat	read_stat;
 	struct nfs4_ff_layoutstat	write_stat;
 	ktime_t				start_time;
+};
+
+struct nfs4_ff_layout_mirror {
+	struct pnfs_layout_hdr		*layout;
+	struct list_head		mirrors;
+	u32				dss_count;
+	struct nfs4_ff_layout_ds_stripe *dss;
+	refcount_t			ref;
+	spinlock_t			lock;
+	unsigned long			flags;
 	u32				report_interval;
 };
 
@@ -155,7 +162,7 @@ FF_LAYOUT_DEVID_NODE(struct pnfs_layout_segment *lseg, u32 idx)
 	struct nfs4_ff_layout_mirror *mirror = FF_LAYOUT_COMP(lseg, idx);
 
 	if (mirror != NULL) {
-		struct nfs4_ff_layout_ds *mirror_ds = mirror->mirror_ds;
+		struct nfs4_ff_layout_ds *mirror_ds = mirror->dss[0].mirror_ds;
 
 		if (!IS_ERR_OR_NULL(mirror_ds))
 			return &mirror_ds->id_node;
@@ -184,7 +191,7 @@ ff_layout_no_read_on_rw(struct pnfs_layout_segment *lseg)
 static inline int
 nfs4_ff_layout_ds_version(const struct nfs4_ff_layout_mirror *mirror)
 {
-	return mirror->mirror_ds->ds_versions[0].version;
+	return mirror->dss[0].mirror_ds->ds_versions[0].version;
 }
 
 struct nfs4_ff_layout_ds *
diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
index 656d5c50bbce..f8ac9d8bd380 100644
--- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
+++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
@@ -259,7 +259,7 @@ int ff_layout_track_ds_error(struct nfs4_flexfile_layout *flo,
 	if (status == 0)
 		return 0;
 
-	if (IS_ERR_OR_NULL(mirror->mirror_ds))
+	if (IS_ERR_OR_NULL(mirror->dss[0].mirror_ds))
 		return -EINVAL;
 
 	dserr = kmalloc(sizeof(*dserr), gfp_flags);
@@ -271,8 +271,8 @@ int ff_layout_track_ds_error(struct nfs4_flexfile_layout *flo,
 	dserr->length = length;
 	dserr->status = status;
 	dserr->opnum = opnum;
-	nfs4_stateid_copy(&dserr->stateid, &mirror->stateid);
-	memcpy(&dserr->deviceid, &mirror->mirror_ds->id_node.deviceid,
+	nfs4_stateid_copy(&dserr->stateid, &mirror->dss[0].stateid);
+	memcpy(&dserr->deviceid, &mirror->dss[0].mirror_ds->id_node.deviceid,
 	       NFS4_DEVICEID4_SIZE);
 
 	spin_lock(&flo->generic_hdr.plh_inode->i_lock);
@@ -287,9 +287,9 @@ ff_layout_get_mirror_cred(struct nfs4_ff_layout_mirror *mirror, u32 iomode)
 	const struct cred *cred, __rcu **pcred;
 
 	if (iomode == IOMODE_READ)
-		pcred = &mirror->ro_cred;
+		pcred = &mirror->dss[0].ro_cred;
 	else
-		pcred = &mirror->rw_cred;
+		pcred = &mirror->dss[0].rw_cred;
 
 	rcu_read_lock();
 	do {
@@ -307,7 +307,7 @@ struct nfs_fh *
 nfs4_ff_layout_select_ds_fh(struct nfs4_ff_layout_mirror *mirror)
 {
 	/* FIXME: For now assume there is only 1 version available for the DS */
-	return &mirror->fh_versions[0];
+	return &mirror->dss[0].fh_versions[0];
 }
 
 void
@@ -315,7 +315,7 @@ nfs4_ff_layout_select_ds_stateid(const struct nfs4_ff_layout_mirror *mirror,
 		nfs4_stateid *stateid)
 {
 	if (nfs4_ff_layout_ds_version(mirror) == 4)
-		nfs4_stateid_copy(stateid, &mirror->stateid);
+		nfs4_stateid_copy(stateid, &mirror->dss[0].stateid);
 }
 
 static bool
@@ -324,23 +324,23 @@ ff_layout_init_mirror_ds(struct pnfs_layout_hdr *lo,
 {
 	if (mirror == NULL)
 		goto outerr;
-	if (mirror->mirror_ds == NULL) {
+	if (mirror->dss[0].mirror_ds == NULL) {
 		struct nfs4_deviceid_node *node;
 		struct nfs4_ff_layout_ds *mirror_ds = ERR_PTR(-ENODEV);
 
 		node = nfs4_find_get_deviceid(NFS_SERVER(lo->plh_inode),
-				&mirror->devid, lo->plh_lc_cred,
+				&mirror->dss[0].devid, lo->plh_lc_cred,
 				GFP_KERNEL);
 		if (node)
 			mirror_ds = FF_LAYOUT_MIRROR_DS(node);
 
 		/* check for race with another call to this function */
-		if (cmpxchg(&mirror->mirror_ds, NULL, mirror_ds) &&
+		if (cmpxchg(&mirror->dss[0].mirror_ds, NULL, mirror_ds) &&
 		    mirror_ds != ERR_PTR(-ENODEV))
 			nfs4_put_deviceid_node(node);
 	}
 
-	if (IS_ERR(mirror->mirror_ds))
+	if (IS_ERR(mirror->dss[0].mirror_ds))
 		goto outerr;
 
 	return true;
@@ -379,7 +379,7 @@ nfs4_ff_layout_prepare_ds(struct pnfs_layout_segment *lseg,
 	if (!ff_layout_init_mirror_ds(lseg->pls_layout, mirror))
 		goto noconnect;
 
-	ds = mirror->mirror_ds->ds;
+	ds = mirror->dss[0].mirror_ds->ds;
 	if (READ_ONCE(ds->ds_clp))
 		goto out;
 	/* matching smp_wmb() in _nfs4_pnfs_v3/4_ds_connect */
@@ -388,10 +388,10 @@ nfs4_ff_layout_prepare_ds(struct pnfs_layout_segment *lseg,
 	/* FIXME: For now we assume the server sent only one version of NFS
 	 * to use for the DS.
 	 */
-	status = nfs4_pnfs_ds_connect(s, ds, &mirror->mirror_ds->id_node,
+	status = nfs4_pnfs_ds_connect(s, ds, &mirror->dss[0].mirror_ds->id_node,
 			     dataserver_timeo, dataserver_retrans,
-			     mirror->mirror_ds->ds_versions[0].version,
-			     mirror->mirror_ds->ds_versions[0].minor_version);
+			     mirror->dss[0].mirror_ds->ds_versions[0].version,
+			     mirror->dss[0].mirror_ds->ds_versions[0].minor_version);
 
 	/* connect success, check rsize/wsize limit */
 	if (!status) {
@@ -404,10 +404,10 @@ nfs4_ff_layout_prepare_ds(struct pnfs_layout_segment *lseg,
 		max_payload =
 			nfs_block_size(rpc_max_payload(ds->ds_clp->cl_rpcclient),
 				       NULL);
-		if (mirror->mirror_ds->ds_versions[0].rsize > max_payload)
-			mirror->mirror_ds->ds_versions[0].rsize = max_payload;
-		if (mirror->mirror_ds->ds_versions[0].wsize > max_payload)
-			mirror->mirror_ds->ds_versions[0].wsize = max_payload;
+		if (mirror->dss[0].mirror_ds->ds_versions[0].rsize > max_payload)
+			mirror->dss[0].mirror_ds->ds_versions[0].rsize = max_payload;
+		if (mirror->dss[0].mirror_ds->ds_versions[0].wsize > max_payload)
+			mirror->dss[0].mirror_ds->ds_versions[0].wsize = max_payload;
 		goto out;
 	}
 noconnect:
@@ -430,7 +430,7 @@ ff_layout_get_ds_cred(struct nfs4_ff_layout_mirror *mirror,
 {
 	const struct cred *cred;
 
-	if (mirror && !mirror->mirror_ds->ds_versions[0].tightly_coupled) {
+	if (mirror && !mirror->dss[0].mirror_ds->ds_versions[0].tightly_coupled) {
 		cred = ff_layout_get_mirror_cred(mirror, range->iomode);
 		if (!cred)
 			cred = get_cred(mdscred);
@@ -453,7 +453,7 @@ struct rpc_clnt *
 nfs4_ff_find_or_create_ds_client(struct nfs4_ff_layout_mirror *mirror,
 				 struct nfs_client *ds_clp, struct inode *inode)
 {
-	switch (mirror->mirror_ds->ds_versions[0].version) {
+	switch (mirror->dss[0].mirror_ds->ds_versions[0].version) {
 	case 3:
 		/* For NFSv3 DS, flavor is set when creating DS connections */
 		return ds_clp->cl_rpcclient;
@@ -564,11 +564,11 @@ static bool ff_read_layout_has_available_ds(struct pnfs_layout_segment *lseg)
 	for (idx = 0; idx < FF_LAYOUT_MIRROR_COUNT(lseg); idx++) {
 		mirror = FF_LAYOUT_COMP(lseg, idx);
 		if (mirror) {
-			if (!mirror->mirror_ds)
+			if (!mirror->dss[0].mirror_ds)
 				return true;
-			if (IS_ERR(mirror->mirror_ds))
+			if (IS_ERR(mirror->dss[0].mirror_ds))
 				continue;
-			devid = &mirror->mirror_ds->id_node;
+			devid = &mirror->dss[0].mirror_ds->id_node;
 			if (!nfs4_test_deviceid_unavailable(devid))
 				return true;
 		}
@@ -585,11 +585,11 @@ static bool ff_rw_layout_has_available_ds(struct pnfs_layout_segment *lseg)
 
 	for (idx = 0; idx < FF_LAYOUT_MIRROR_COUNT(lseg); idx++) {
 		mirror = FF_LAYOUT_COMP(lseg, idx);
-		if (!mirror || IS_ERR(mirror->mirror_ds))
+		if (!mirror || IS_ERR(mirror->dss[0].mirror_ds))
 			return false;
-		if (!mirror->mirror_ds)
+		if (!mirror->dss[0].mirror_ds)
 			continue;
-		devid = &mirror->mirror_ds->id_node;
+		devid = &mirror->dss[0].mirror_ds->id_node;
 		if (nfs4_test_deviceid_unavailable(devid))
 			return false;
 	}
-- 
2.34.1


