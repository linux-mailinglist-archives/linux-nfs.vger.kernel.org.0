Return-Path: <linux-nfs+bounces-14534-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAAEB81D58
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 22:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EB0258132B
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 20:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC489478;
	Wed, 17 Sep 2025 20:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="RvO6nGjp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD32A293C44
	for <linux-nfs@vger.kernel.org>; Wed, 17 Sep 2025 20:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758142138; cv=none; b=Hbx/iZ+YpjKqhPgtWp/3C9NWaUYk+fB71ooY5AbyFT/TSQnlJ+vQAZC8I0RkYjnkT9A/h1a1pZAHgSRRIKrAJoS2MITNWIh6XiqpohcqcqdXpQ1pYNssLJfxeiUaZKY3xILxouPQIbm6t5xxZC8fcRDH0siipgGOQmVn1Dofbtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758142138; c=relaxed/simple;
	bh=x/vz0Nx5gBL4sXPQw2SYjQuhf82Hq1P+ENsktJ+pVnA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CySqQ+Ylih4OSdLlinHraUcTiqAGVhyEiyg9lY12n0AVwIi2jrgeh1WPL4fWo/W05sQvVxAqDWNEg97hZLAgrdDfsuyPgUjMAKjSFUCJj2LhUDk7IkT+Q1SqU5Cc5/DzcMGEuvkRVoscQ7WM10XyTxtvOeGysrnaXD8fOD5Wdps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=RvO6nGjp; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-62fa062a1abso281649a12.2
        for <linux-nfs@vger.kernel.org>; Wed, 17 Sep 2025 13:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758142135; x=1758746935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PcLJQ3J8u6QJ1Ai+SfXJtHdzwyNhLeepz8mGsqkdJ0=;
        b=RvO6nGjpd56GhnF1yRLMQuWZdXnfK8n6CzqntWD3rE4NPxeYOuq2DFjsl6vi2ATWl0
         yna0BftjKPLD2yPhAwRuh9Bqx05uw1vlrbDxFlzxMxRaUTsoXr8noDj1R6LPRhf5DkFX
         HD5U8Tx434HApsWI9gYStFlFQTq7NKgqEax3f9RlOYdyAAAlwKhYJnbjTDybQic7zPpR
         PmfiEM00syeNxEXnSyfaCaid1u1d9pEPvBAe+ONSX9jSXN0Q9nwmee4BJTDXCf+t60uH
         IHnibWIPYRLtmAgouYRwGfUYTa2BGPFiwIPLIBtG3AJRnJRoSGk/7GNYxH+d6EzHYEad
         MroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758142135; x=1758746935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7PcLJQ3J8u6QJ1Ai+SfXJtHdzwyNhLeepz8mGsqkdJ0=;
        b=HN3nTdZRhX1IA3syPNcJRZIWCBz+QvBrXcydHNko9Uagq1n5rDNTRwa6LtdPSobfHe
         qkKTaQaRE3tDJu8g6YKNuKWeWYoGxV/0vOeOTdvdU72uDxEDoDstoplCfpVc3a7sCF0T
         yPEoTK8zz4zzvpeV6hvIJ57xIDJ+kFXtBuKtG5sj/JqX53egN2B8+/VPCsNyxcHmei0T
         8uB8Vy+ZJIFEtFZVmce6uN104JmaIHKFQNrTwThaCoszTmGc3Dt76Zf/AK8vnPUwI/Hz
         j7sAmKFDYTYlqlm8JUy2KDIOAtqcOsBgvzn8IpBftzJ1pQIoktZvf9BaJL7SZS4kItW4
         h/bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpUYQ0jYBu4f3/yMggmfNi/bHpTZUnzRWflXp0eEtUfyf7zcXPbglNeJSQYXFFYCcMD1kxgL/IL7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPLRjVJQiv3rbLm5yTZPTPTHCm8I9xWxCVtO3hM9a/26I70QbS
	TaTNACeCF0N99hEiawVrVzkO7xLcN9NXg0rsSIwbkOg8b+iekrT4GOCrAOf2bZvCNlg=
X-Gm-Gg: ASbGncvH9ksqvykWI3eMM1ArIVVK/hq7snatcOsYeK/UN0NJuBBIZLNZmuw1Grf5sP3
	dmuZnAFuwocX5bom2sHJCraz1sAYy3cieseNCojmdy7h4xxsZOd/wQLTjf4V52XcFm0LWcyZeLu
	gqs6KTEjIBuLLChjIs+aHeJ5DZw6jAh2GtfacDd2E0TeNhCe94mKG5eDAyfQ/1BakVLKNbTMccG
	b/SJJVVGK8ON9L1OISZHvkb14e8bn3aE8Wz/e1GNmfDRERskSyvL6r4gpV+vLpsO4FJtmTeZJVl
	Dxts3e3MXuj5+vbgtwmH1VYQQMMCJfgL29w31FV/jMGC3rgszuRPtQiQd3bED8M5lFTJmDk1VFS
	d0l+qYe5u9SXr38QvHNOZ0cH/S/3GScU8Pw==
X-Google-Smtp-Source: AGHT+IHMIJGrcnj7hCGFkTxq2lLUwfLf6dcg7PUhi+cA5VOuPUgnPvcC0PjWTgNQ6eeJ3ioWvJzBcg==
X-Received: by 2002:a17:907:1c94:b0:b04:708e:7348 with SMTP id a640c23a62f3a-b1bc02f8ab6mr382386066b.30.1758142134934;
        Wed, 17 Sep 2025 13:48:54 -0700 (PDT)
Received: from localhost ([208.88.158.129])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b1fcfe88d97sm43090066b.58.2025.09.17.13.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 13:48:54 -0700 (PDT)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	linux-nfs@vger.kernel.org
Subject: [RFC PATCH v2 9/9] NFSv4/flexfiles: Add support for striped layouts
Date: Wed, 17 Sep 2025 20:48:27 +0000
Message-Id: <20250917204827.495253-10-jcurley@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250917204827.495253-1-jcurley@purestorage.com>
References: <20250917204827.495253-1-jcurley@purestorage.com>
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
index 28d982af4450..6d9aea16ef44 100644
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


