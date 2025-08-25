Return-Path: <linux-nfs+bounces-13897-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8ACB34E0B
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Aug 2025 23:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78CF8169F47
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Aug 2025 21:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415B71991D2;
	Mon, 25 Aug 2025 21:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="DTCNISVS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2619B28D831
	for <linux-nfs@vger.kernel.org>; Mon, 25 Aug 2025 21:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756157281; cv=none; b=pY0+twod2g9vherWNLmQav2e1QyYOFu3yWVCBhwRRDfuptt4vFe4TQU6f+Ysc7hp6yTrh+89JXkkvNPVRbqiLneDF9T1iykkyTffLi7LPOL6KnPcSL8wWm56oVafUNF05bpcISPDcMqo1YL8bl/qvG42g0UnR0Gn8nC255DICtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756157281; c=relaxed/simple;
	bh=XGhKrop+17OYir1NqM8j5jvhaMkicQIwPnymgTbAq90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fk0kJQ0+4ElddFCJR3Bd8jJXFWJ/erRZHtof+KS+mXYw+dp5sr8x0J5tnrY5mmot2glMo72LrV0nq8CqZ+kYexHaIvC7YKxB4y0kOTcp1DCbNl/695+1zQuF/YSseFOnfT3hY2brpcNsWsUpf5TYfFUTEPBbqWZkc/HIaxmiWIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=DTCNISVS; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61c51f56fc7so2322070a12.1
        for <linux-nfs@vger.kernel.org>; Mon, 25 Aug 2025 14:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1756157277; x=1756762077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mT5O+FLfTRxCU2w0ib628Dfu2yu2/CDwalkTABmEb14=;
        b=DTCNISVSmwQ7A0vmi1bxCvdncUGxi+X97GUbMhaXKm8VYoL6IA7xyQRSoOGP0gOvy0
         YEBj+qtPRpZko28TYPnVdzPTIfWCh2m2Aq02iq3vsw+HLYnw3UKKmBUKldu92gxO20qJ
         9zl95BAZcp5DWpHOnVyeWWLLc3etNHyfodd+5ZkPNDKGEwCSMmxq7io9gi8qunOZtYYx
         NydLjbGuM4cH4Ny2crpkchBO3BYFFaCkvNxQ2hdfpbmCr5qtbITwcTG1B870iSjCTXs4
         L4dbreZtzTMoJBSORRfMWIEGSdWWpNUAZLR6i+Ykb5esPwRLIDRD+yFA4bOlPvDmj2Yv
         0k2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756157277; x=1756762077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mT5O+FLfTRxCU2w0ib628Dfu2yu2/CDwalkTABmEb14=;
        b=c//L62eGjc5xQtetzpWLa7dk/thRB60JNRZAqinaNQPIcJftJmt3xAbtSy3SooG2Zb
         xnx5m5aj5E/PaxbYjb75l0nQ3A91UeUB+5OvYkYPGiM3y3AVRVvXMhnRi753N5J5q3hA
         5+3lE+pMSVf+EyRErd31iIrJZUc79IAOGmmh95zYTU6aEgAvZ8c9bnGJ4z2KuT80Y4Xf
         b398ziZCo5aOkRidriEWyP6OoWWdWQ9rfpAC8KEldnzS5UqMlPqqvWbcFMsLg0rkkD2S
         D75VBQgd7wFy4ZFHOEq7SSORzUVMcWYvNv8g2H7044rvuPt7Ob0MzGewGK4VlHJX0PrG
         BgHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPgktQsltrHfsEmbAXMDMe0KoqFOZMBqdB+DQ+fkzbWVflNYn43ionhx3vUj1XryyFFiiDiYAgE4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMFyQZDaFClzSh6aR8BG6ZvIbJhyilY2sJGeTh0lofIKDWNq5Y
	KF/OWSe3odLom1OFkw/73tAV/QPVtuTlmd8Qie0FPLyZLMLutT0wz7f7XHNlSo0I7MrIHbY3qTu
	aVmSb
X-Gm-Gg: ASbGnctkFp12QaJxSiQQtH9tIc9UBaYiW3Y2eVV/Dn9XF9tujT0PmDi/f1g8MAlzu5h
	tkCFIAaW1PHXOUw1yg9jYpNoOFtTYWqNQel7n51iOo/FU4J01k4F+pWMmoNuQqbXfBhoAHYKLYv
	Kg7eqF0moY369j42Plor73HmMSKaI7mLRg9uOIx0E3aje7KGSehMmjBrgMqqIOwv0noet8Rtf8k
	4ZZfXsDg2l6kik7DNhB0xAOG0hPO3P7BIr1JAVcgdxsKT/2sZgRPWs5C6IsCbGsAOOCP7i7lm9I
	DzXBaQgECLJhRUCdZgQvKvn2FRHqHuaYNl/e0elkYiGYePCodXISjZF69UorG0gKLkQPJyu4Cbz
	PXOGsY7gmP+/RleaNzHOE8KQ=
X-Google-Smtp-Source: AGHT+IHGhMCU2+vHkSnUHsL06fKZlZxLQpw3RGPfTZMK4iDlYQJM1X+IGpqDSB8LU83y5YJzSWPofg==
X-Received: by 2002:a17:907:720d:b0:ae6:d47a:105d with SMTP id a640c23a62f3a-afe294b236fmr1307846166b.55.1756157277226;
        Mon, 25 Aug 2025 14:27:57 -0700 (PDT)
Received: from localhost ([208.88.158.128])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-afe7c2c7820sm306630966b.64.2025.08.25.14.27.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 14:27:56 -0700 (PDT)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	linux-nfs@vger.kernel.org
Subject: [RFC PATCH v1 9/9] NFSv4/flexfiles: Add support for striped layouts
Date: Mon, 25 Aug 2025 21:27:29 +0000
Message-Id: <20250825212729.4833-10-jcurley@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825212729.4833-1-jcurley@purestorage.com>
References: <20250825212729.4833-1-jcurley@purestorage.com>
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


