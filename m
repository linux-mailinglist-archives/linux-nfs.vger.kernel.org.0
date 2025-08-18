Return-Path: <linux-nfs+bounces-13762-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6CAB2B3F5
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 00:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF3483AAF0A
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 22:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498C727AC3C;
	Mon, 18 Aug 2025 22:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fn8uq7iq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6FC1E25F2
	for <linux-nfs@vger.kernel.org>; Mon, 18 Aug 2025 22:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755554935; cv=none; b=hzZZxuo0X/7ZkKQCc/KLxTtd/uGxmfOxVSZ3XzNHO/JeRsM4Q2SNfLlzU4O4jfKplOnJdrBuA/mhcyokCk86TwZph0gc+/PUVhu8jBLRyaGRmkumup29DxFL5tgfGQ+ID8zdbm85e/lJCQ8pUrMZp5GCaBLMRU3bTd+muyC3M1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755554935; c=relaxed/simple;
	bh=XGhKrop+17OYir1NqM8j5jvhaMkicQIwPnymgTbAq90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QPx8o/zDWuxqT6D5emvRAtHygHXLa2e9MhnyQ8bCoM8L4JeE8ZPZszJS0nGCfFizyNq9fkudb3EQV8m6iwcus8NBXOBFGsnWTdu7ACihAIWItDaCY4MG//6PjInIk/J0H1pIxrJhqaGvwQuu4u37ZNyUnmEe8EHDeCUCQmcVYTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fn8uq7iq; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-618b62dbb21so6106863a12.2
        for <linux-nfs@vger.kernel.org>; Mon, 18 Aug 2025 15:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1755554932; x=1756159732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mT5O+FLfTRxCU2w0ib628Dfu2yu2/CDwalkTABmEb14=;
        b=fn8uq7iqt8ZbGDkzTHE0NNsqwqmcQWDjQ3UaOpErt+GY2c5YeOthZO4BgiL016Pu2F
         OJuBJ8GJoNRYZ8K4wvwMU8YlZ4PlD++ffn33jKGVqim3CS2FOFKudu41fQIgful/iewV
         ALgpZehG4chUxasIDAHymBCQufJfAclikHAqr+YLHzj2aFpL+BbGNAuzT8RlrDi2phq8
         9NYwMWLG2NuCKCUE+PQqiCSLosjwZcDLAWeQiALEdgDHKUhz7FeWH+bIlusrr3vko2Nn
         afqx+Npg54B2dpdGWaZEp5nhiGvhLZSjiYjnMdEptHQLg5yEpD29lL3wr+0tsRTE8evQ
         +6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755554932; x=1756159732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mT5O+FLfTRxCU2w0ib628Dfu2yu2/CDwalkTABmEb14=;
        b=l4cmUVY6NsZ220qNWx/5/uzqVSd1DElWpgiAtHw15KQVV7La2f3b9r+afvJ1nGXs67
         LlBtWe4PBOxBCd5H9wG1iJfEZIyeIsEJTA5lVasf7BRqP+GfWz25IFvKXDepvh+qydJ5
         sQ+RU7jpzxl/r1yGLFAj76Pk0M1eSxZtdUs5p2B5jpJjntQW/KWcbpBVOtn1k1jIivD6
         x0udKsG47wWpLwQPlrbDSJIylAwxs3PS4eZ8LQbBfRVnOS8SXCpzsncsfUoXDIsOnLgJ
         qbpUx9u4Akp22o+3iHWT7e+ZKq4Yy2dJ6cCKJXBBfP54z9YYppWfvjpC/BfL9bYouUmd
         5bdg==
X-Forwarded-Encrypted: i=1; AJvYcCX1CQoRK1MW5Fsmq+Tk/B8pG35Cgm1lYDVU64gZFUVy1OckQCGtQUb2YK5/30JYggy/1bRqibE+78M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyiq5kf4LobWX5tZct9HJjlVFde1uaPwh5xg6qGL9U/mX21xwPr
	qZvhxng4zxTUoplenxhPKUdWBCSXz9WLWXWrq0myKskvDk24eYB30jHz/gS5f0GD4kc=
X-Gm-Gg: ASbGncuOOfM+9tTkU6lT1SKlexBXKFFvuVjC3KNZg9gFz4fQHJz8MgncHSA8ikcHC9n
	lUPd7KH9dCLoDcLsc3NXUfd0Z56CLaWxkmVo1t0R8qhYa5y9nvUZKpXKJqFI8jOtFlgmQdIRMix
	H+mAB2H7T/DvFUn3GDqd6XCMubk2Yx582cf6p8XMgc3vgErW4NeiZ8fROyFzD0ZZGqdOttWVtsw
	o/kxkcLLmUPzbX9JB+sbCLleZpAlQpGmeQe3yEx6oDFXvmv4IjCn1Nul0yEwnb6ijPXHON5ayKg
	t1hradE4og/BK7brPFfSCP5OVHIDvsHM0iuwnlLw/znWqvCckyBgV+dV/xsFubcN2Mp3Nu4lTrw
	MOMtT6g1h0JlMwRgtApLzgM0=
X-Google-Smtp-Source: AGHT+IEtXmS9oVc8cWUIvreVGKBoeAozv0nJzFX3GkbEXpgGy6ogPPoE27EhPCUMQaRHA4D2yw2ndg==
X-Received: by 2002:a05:6402:440a:b0:615:979c:e8b2 with SMTP id 4fb4d7f45d1cf-61a7e75e7c6mr103997a12.29.1755554931675;
        Mon, 18 Aug 2025 15:08:51 -0700 (PDT)
Received: from localhost ([208.88.158.128])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-61a761f2599sm478609a12.5.2025.08.18.15.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 15:08:51 -0700 (PDT)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 9/9] NFSv4/flexfiles: Add support for striped layouts
Date: Mon, 18 Aug 2025 22:07:50 +0000
Message-Id: <20250818220750.47085-10-jcurley@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250818220750.47085-1-jcurley@purestorage.com>
References: <20250818220750.47085-1-jcurley@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Updates lseg creation path to parse and add striped layouts. Enable
support for striped layouts.

Limitations:

1. All mirrors must have the same number of stripes.

Signed-off-by: Jonathan Curley <jcurley@purestorage.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 247 ++++++++++++++++---------
 fs/nfs/flexfilelayout/flexfilelayout.h |   2 +
 2 files changed, 157 insertions(+), 92 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 24d0eef0b6a4..444267938081 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -177,18 +177,19 @@ ff_local_open_fh(struct pnfs_layout_segment *lseg, u32 ds_idx, u32 dss_id,
 #endif
 }
 
-static bool ff_mirror_match_fh(const struct nfs4_ff_layout_mirror *m1,
-		const struct nfs4_ff_layout_mirror *m2)
+static bool ff_dss_match_fh(const struct nfs4_ff_layout_ds_stripe *dss1,
+		const struct nfs4_ff_layout_ds_stripe *dss2)
 {
 	int i, j;
 
-	if (m1->dss[0].fh_versions_cnt != m2->dss[0].fh_versions_cnt)
+	if (dss1->fh_versions_cnt != dss2->fh_versions_cnt)
 		return false;
-	for (i = 0; i < m1->dss[0].fh_versions_cnt; i++) {
+
+	for (i = 0; i < dss1->fh_versions_cnt; i++) {
 		bool found_fh = false;
-		for (j = 0; j < m2->dss[0].fh_versions_cnt; j++) {
-			if (nfs_compare_fh(&m1->dss[0].fh_versions[i],
-					&m2->dss[0].fh_versions[j]) == 0) {
+		for (j = 0; j < dss2->fh_versions_cnt; j++) {
+			if (nfs_compare_fh(&dss1->fh_versions[i],
+					&dss2->fh_versions[j]) == 0) {
 				found_fh = true;
 				break;
 			}
@@ -199,6 +200,38 @@ static bool ff_mirror_match_fh(const struct nfs4_ff_layout_mirror *m1,
 	return true;
 }
 
+static bool ff_mirror_match_fh(const struct nfs4_ff_layout_mirror *m1,
+		const struct nfs4_ff_layout_mirror *m2)
+{
+	u32 dss_id;
+
+	if (m1->dss_count != m2->dss_count)
+		return false;
+
+	for (dss_id = 0; dss_id < m1->dss_count; dss_id++)
+		if (!ff_dss_match_fh(&m1->dss[dss_id], &m2->dss[dss_id]))
+			return false;
+
+	return true;
+}
+
+static bool ff_mirror_match_devid(const struct nfs4_ff_layout_mirror *m1,
+		const struct nfs4_ff_layout_mirror *m2)
+{
+	u32 dss_id;
+
+	if (m1->dss_count != m2->dss_count)
+		return false;
+
+	for (dss_id = 0; dss_id < m1->dss_count; dss_id++)
+		if (memcmp(&m1->dss[dss_id].devid,
+			   &m2->dss[dss_id].devid,
+			   sizeof(m1->dss[dss_id].devid)) != 0)
+			return false;
+
+	return true;
+}
+
 static struct nfs4_ff_layout_mirror *
 ff_layout_add_mirror(struct pnfs_layout_hdr *lo,
 		struct nfs4_ff_layout_mirror *mirror)
@@ -209,8 +242,7 @@ ff_layout_add_mirror(struct pnfs_layout_hdr *lo,
 
 	spin_lock(&inode->i_lock);
 	list_for_each_entry(pos, &ff_layout->mirrors, mirrors) {
-		if (memcmp(&mirror->dss[0].devid, &pos->dss[0].devid,
-			   sizeof(pos->dss[0].devid)) != 0)
+		if (!ff_mirror_match_devid(mirror, pos))
 			continue;
 		if (!ff_mirror_match_fh(mirror, pos))
 			continue;
@@ -241,13 +273,15 @@ ff_layout_remove_mirror(struct nfs4_ff_layout_mirror *mirror)
 static struct nfs4_ff_layout_mirror *ff_layout_alloc_mirror(gfp_t gfp_flags)
 {
 	struct nfs4_ff_layout_mirror *mirror;
+	u32 dss_id;
 
 	mirror = kzalloc(sizeof(*mirror), gfp_flags);
 	if (mirror != NULL) {
 		spin_lock_init(&mirror->lock);
 		refcount_set(&mirror->ref, 1);
 		INIT_LIST_HEAD(&mirror->mirrors);
-		nfs_localio_file_init(&mirror->dss[0].nfl);
+		for (dss_id = 0; dss_id < mirror->dss_count; dss_id++)
+			nfs_localio_file_init(&mirror->dss[dss_id].nfl);
 	}
 	return mirror;
 }
@@ -255,17 +289,19 @@ static struct nfs4_ff_layout_mirror *ff_layout_alloc_mirror(gfp_t gfp_flags)
 static void ff_layout_free_mirror(struct nfs4_ff_layout_mirror *mirror)
 {
 	const struct cred	*cred;
-	int dss_id = 0;
+	u32 dss_id;
 
 	ff_layout_remove_mirror(mirror);
 
-	kfree(mirror->dss[dss_id].fh_versions);
-	nfs_close_local_fh(&mirror->dss[dss_id].nfl);
-	cred = rcu_access_pointer(mirror->dss[dss_id].ro_cred);
-	put_cred(cred);
-	cred = rcu_access_pointer(mirror->dss[dss_id].rw_cred);
-	put_cred(cred);
-	nfs4_ff_layout_put_deviceid(mirror->dss[dss_id].mirror_ds);
+	for (dss_id = 0; dss_id < mirror->dss_count; dss_id++) {
+		kfree(mirror->dss[dss_id].fh_versions);
+		cred = rcu_access_pointer(mirror->dss[dss_id].ro_cred);
+		put_cred(cred);
+		cred = rcu_access_pointer(mirror->dss[dss_id].rw_cred);
+		put_cred(cred);
+		nfs_close_local_fh(&mirror->dss[dss_id].nfl);
+		nfs4_ff_layout_put_deviceid(mirror->dss[dss_id].mirror_ds);
+	}
 
 	kfree(mirror->dss);
 	kfree(mirror);
@@ -371,14 +407,24 @@ ff_layout_add_lseg(struct pnfs_layout_hdr *lo,
 			free_me);
 }
 
+static u32 ff_mirror_efficiency_sum(const struct nfs4_ff_layout_mirror *mirror)
+{
+	u32 dss_id, sum = 0;
+
+	for (dss_id = 0; dss_id < mirror->dss_count; dss_id++)
+		sum += mirror->dss[dss_id].efficiency;
+
+	return sum;
+}
+
 static void ff_layout_sort_mirrors(struct nfs4_ff_layout_segment *fls)
 {
 	int i, j;
 
 	for (i = 0; i < fls->mirror_array_cnt - 1; i++) {
 		for (j = i + 1; j < fls->mirror_array_cnt; j++)
-			if (fls->mirror_array[i]->dss[0].efficiency <
-			    fls->mirror_array[j]->dss[0].efficiency)
+			if (ff_mirror_efficiency_sum(fls->mirror_array[i]) <
+			    ff_mirror_efficiency_sum(fls->mirror_array[j]))
 				swap(fls->mirror_array[i],
 				     fls->mirror_array[j]);
 	}
@@ -398,6 +444,7 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 	u32 mirror_array_cnt;
 	__be32 *p;
 	int i, rc;
+	struct nfs4_ff_layout_ds_stripe *dss_info;
 
 	dprintk("--> %s\n", __func__);
 	scratch = alloc_page(gfp_flags);
@@ -440,17 +487,24 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 		kuid_t uid;
 		kgid_t gid;
 		u32 fh_count, id;
-		int j, dss_id = 0;
+		int j, dss_id;
 
 		rc = -EIO;
 		p = xdr_inline_decode(&stream, 4);
 		if (!p)
 			goto out_err_free;
 
-		dss_count = be32_to_cpup(p);
+		// Ensure all mirrors have same stripe count.
+		if (dss_count == 0)
+			dss_count = be32_to_cpup(p);
+		else if (dss_count != be32_to_cpup(p))
+			goto out_err_free;
+
+		if (dss_count > NFS4_FLEXFILE_LAYOUT_MAX_STRIPE_CNT ||
+		    dss_count == 0)
+			goto out_err_free;
 
-		/* FIXME: allow for striping? */
-		if (dss_count != 1)
+		if (dss_count > 1 && stripe_unit == 0)
 			goto out_err_free;
 
 		fls->mirror_array[i] = ff_layout_alloc_mirror(gfp_flags);
@@ -464,91 +518,100 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 		    kcalloc(dss_count, sizeof(struct nfs4_ff_layout_ds_stripe),
 			    gfp_flags);
 
-		/* deviceid */
-		rc = decode_deviceid(&stream, &fls->mirror_array[i]->dss[dss_id].devid);
-		if (rc)
-			goto out_err_free;
+		for (dss_id = 0; dss_id < dss_count; dss_id++) {
+			dss_info = &fls->mirror_array[i]->dss[dss_id];
+			dss_info->mirror = fls->mirror_array[i];
 
-		/* efficiency */
-		rc = -EIO;
-		p = xdr_inline_decode(&stream, 4);
-		if (!p)
-			goto out_err_free;
-		fls->mirror_array[i]->dss[dss_id].efficiency = be32_to_cpup(p);
+			/* deviceid */
+			rc = decode_deviceid(&stream, &dss_info->devid);
+			if (rc)
+				goto out_err_free;
 
-		/* stateid */
-		rc = decode_pnfs_stateid(&stream, &fls->mirror_array[i]->dss[dss_id].stateid);
-		if (rc)
-			goto out_err_free;
+			/* efficiency */
+			rc = -EIO;
+			p = xdr_inline_decode(&stream, 4);
+			if (!p)
+				goto out_err_free;
+			dss_info->efficiency = be32_to_cpup(p);
 
-		/* fh */
-		rc = -EIO;
-		p = xdr_inline_decode(&stream, 4);
-		if (!p)
-			goto out_err_free;
-		fh_count = be32_to_cpup(p);
+			/* stateid */
+			rc = decode_pnfs_stateid(&stream, &dss_info->stateid);
+			if (rc)
+				goto out_err_free;
 
-		fls->mirror_array[i]->dss[dss_id].fh_versions =
-		    kcalloc(fh_count, sizeof(struct nfs_fh),
-			    gfp_flags);
-		if (fls->mirror_array[i]->dss[dss_id].fh_versions == NULL) {
-			rc = -ENOMEM;
-			goto out_err_free;
-		}
+			/* fh */
+			rc = -EIO;
+			p = xdr_inline_decode(&stream, 4);
+			if (!p)
+				goto out_err_free;
+			fh_count = be32_to_cpup(p);
 
-		for (j = 0; j < fh_count; j++) {
-			rc = decode_nfs_fh(&stream,
-					   &fls->mirror_array[i]->dss[dss_id].fh_versions[j]);
+			dss_info->fh_versions =
+			    kcalloc(fh_count, sizeof(struct nfs_fh),
+				    gfp_flags);
+			if (dss_info->fh_versions == NULL) {
+				rc = -ENOMEM;
+				goto out_err_free;
+			}
+
+			for (j = 0; j < fh_count; j++) {
+				rc = decode_nfs_fh(&stream,
+						   &dss_info->fh_versions[j]);
+				if (rc)
+					goto out_err_free;
+			}
+
+			dss_info->fh_versions_cnt = fh_count;
+
+			/* user */
+			rc = decode_name(&stream, &id);
 			if (rc)
 				goto out_err_free;
-		}
 
-		fls->mirror_array[i]->dss[dss_id].fh_versions_cnt = fh_count;
+			uid = make_kuid(&init_user_ns, id);
 
-		/* user */
-		rc = decode_name(&stream, &id);
-		if (rc)
-			goto out_err_free;
+			/* group */
+			rc = decode_name(&stream, &id);
+			if (rc)
+				goto out_err_free;
 
-		uid = make_kuid(&init_user_ns, id);
+			gid = make_kgid(&init_user_ns, id);
 
-		/* group */
-		rc = decode_name(&stream, &id);
-		if (rc)
-			goto out_err_free;
+			if (gfp_flags & __GFP_FS)
+				kcred = prepare_kernel_cred(&init_task);
+			else {
+				unsigned int nofs_flags = memalloc_nofs_save();
 
-		gid = make_kgid(&init_user_ns, id);
+				kcred = prepare_kernel_cred(&init_task);
+				memalloc_nofs_restore(nofs_flags);
+			}
+			rc = -ENOMEM;
+			if (!kcred)
+				goto out_err_free;
+			kcred->fsuid = uid;
+			kcred->fsgid = gid;
+			cred = RCU_INITIALIZER(kcred);
 
-		if (gfp_flags & __GFP_FS)
-			kcred = prepare_kernel_cred(&init_task);
-		else {
-			unsigned int nofs_flags = memalloc_nofs_save();
-			kcred = prepare_kernel_cred(&init_task);
-			memalloc_nofs_restore(nofs_flags);
+			if (lgr->range.iomode == IOMODE_READ)
+				rcu_assign_pointer(dss_info->ro_cred, cred);
+			else
+				rcu_assign_pointer(dss_info->rw_cred, cred);
 		}
-		rc = -ENOMEM;
-		if (!kcred)
-			goto out_err_free;
-		kcred->fsuid = uid;
-		kcred->fsgid = gid;
-		cred = RCU_INITIALIZER(kcred);
-
-		if (lgr->range.iomode == IOMODE_READ)
-			rcu_assign_pointer(fls->mirror_array[i]->dss[dss_id].ro_cred, cred);
-		else
-			rcu_assign_pointer(fls->mirror_array[i]->dss[dss_id].rw_cred, cred);
 
 		mirror = ff_layout_add_mirror(lh, fls->mirror_array[i]);
 		if (mirror != fls->mirror_array[i]) {
-			/* swap cred ptrs so free_mirror will clean up old */
-			if (lgr->range.iomode == IOMODE_READ) {
-				cred = xchg(&mirror->dss[dss_id].ro_cred,
-					    fls->mirror_array[i]->dss[dss_id].ro_cred);
-				rcu_assign_pointer(fls->mirror_array[i]->dss[dss_id].ro_cred, cred);
-			} else {
-				cred = xchg(&mirror->dss[dss_id].rw_cred,
-					    fls->mirror_array[i]->dss[dss_id].rw_cred);
-				rcu_assign_pointer(fls->mirror_array[i]->dss[dss_id].rw_cred, cred);
+			for (dss_id = 0; dss_id < dss_count; dss_id++) {
+				dss_info = &fls->mirror_array[i]->dss[dss_id];
+				/* swap cred ptrs so free_mirror will clean up old */
+				if (lgr->range.iomode == IOMODE_READ) {
+					cred = xchg(&mirror->dss[dss_id].ro_cred,
+						    dss_info->ro_cred);
+					rcu_assign_pointer(dss_info->ro_cred, cred);
+				} else {
+					cred = xchg(&mirror->dss[dss_id].rw_cred,
+						    dss_info->rw_cred);
+					rcu_assign_pointer(dss_info->rw_cred, cred);
+				}
 			}
 			ff_layout_free_mirror(fls->mirror_array[i]);
 			fls->mirror_array[i] = mirror;
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.h b/fs/nfs/flexfilelayout/flexfilelayout.h
index 142324d6d5c5..17a008c8e97c 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.h
+++ b/fs/nfs/flexfilelayout/flexfilelayout.h
@@ -21,6 +21,8 @@
  * due to network error etc. */
 #define NFS4_FLEXFILE_LAYOUT_MAX_MIRROR_CNT 4096
 
+#define NFS4_FLEXFILE_LAYOUT_MAX_STRIPE_CNT 4096
+
 /* LAYOUTSTATS report interval in ms */
 #define FF_LAYOUTSTATS_REPORT_INTERVAL (60000L)
 #define FF_LAYOUTSTATS_MAXDEV 4
-- 
2.34.1


