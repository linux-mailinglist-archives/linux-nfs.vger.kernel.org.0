Return-Path: <linux-nfs+bounces-14565-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A40AB84DC0
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 15:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 348BA1773A0
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 13:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64B2212562;
	Thu, 18 Sep 2025 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="VcMwxwHx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43D42D3752
	for <linux-nfs@vger.kernel.org>; Thu, 18 Sep 2025 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202426; cv=none; b=NnFwjUH4oj55dFLvbLvQ0pDBh3wl8Qo3jM3rwzweCXLqh9b8sobWnbS+K0QQJ4rFeQDd95VLTFxRVn+UXtRyWfI1K3zr7npVmZ4JAD/MfDoyUaJkhVLYrcVP5A2qQWIvyrDiHASeWTt3EwB8BvviFhC5sHZpSH+0xxmrWmbUreA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202426; c=relaxed/simple;
	bh=l5NA75vUNw4Yeh019EfmF3/IbA4I5GQBgxVOdejRkYk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uap1/42qHZcxp+odL7PiLqBeuwjSxKXiCI1wGNZ+lWa7yCND22gdfJXeDS2HLWISSC7kA3IXnB38Fu0J1jEmf1wSgv5ZNou+0k/mhr4xW6zM7RWv0TFw/Yi7zeuvs4MhVYNGrX2F2tcixghkHeQ+Ge0W7RCNy0n/OZ6uXcEo9XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=VcMwxwHx; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b0e7bc49263so167207566b.1
        for <linux-nfs@vger.kernel.org>; Thu, 18 Sep 2025 06:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758202423; x=1758807223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhWUWO/D5nHCRyISocD00ccBZX/Phe06pjh+dQABBnk=;
        b=VcMwxwHxCjmvoQoh8o3g0s7MxwP7qnz9ooLwXAUJzNtidH60QEKQ/c4OnXks3b/uqF
         7cGcFuXOE2zT02+lGFa4LYBTYLhRjzleoIu9Uhrb2SFvit9NubTAfUS3Aj8ayHbSHhbn
         woKaCaJMZcLKEyMFKUKwtu6ul8Nmu2TrzLdLEKoL+DF+g1sv+juk38rgKIDzLGqaLfyi
         ajuMIcHuNuOE9gINvhPUItKnj415Xabb5wtAdr+QLsSsN6AABBFJbp0M4CCSDP2TbIM5
         velJXZc5ZsdJq3MzRvpgJiROl2QOwM9pSp6N3/dY3YcGfFaXok53CpkWF93IJGCAKYhr
         k5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758202423; x=1758807223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DhWUWO/D5nHCRyISocD00ccBZX/Phe06pjh+dQABBnk=;
        b=TCbRLQm06/Pp+cQZ0uUcqQuM7XWqlK1nHaJRxQrQvU2w+B2Lfdrrf4FLjDrY2iUEtU
         0Juk2iHAU3NbudHfoMJdnSutpw/ciKhbtH5Oba2lhhmvG3XEwJPJXRs+u224NRUYt30t
         Zz483IamxUIl51obDbpCnuTBTeHsKzeg9TRQBlsjXRwN+MmO3luq1dssVvTSYQ/Yjngz
         e4lkOAuuypMkPtYirU1Am/Yu8SlhPPPmYqNVZdseDBBPRMbeq91ZxVpnnKUGdkRX/OQ6
         DN7g9NxSxGLlSxbO2zfkKHV+0uf1bLHlHjhnMS9ff8/I8poTWVRX/4Cs9g8sEOxQRldS
         Vg2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXRCEbQ50jMK4FPM+NbLdyhIYfF7PD1scsvF30EBgx1HXIu1oJzZ7Y7XDFOxtJByejh5nOSmRFfdyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs7CwwAd/OuV8lz3s/+r1PXXXr66UQypftX/WNtwH/RvShupUN
	92RCzWpid0dPIuRkUZPZWlWRQkht8F/JkBFpkFCyxQsfDwrNIdGQXdGjoKH0IH8hzN4=
X-Gm-Gg: ASbGncvTY3G2fHH2o1OwUPKn9JwSl5ZJrQUxazkJgIxoxk5c4ydqNmiuS0b6BYTEmJx
	bU33eChA3Xk8hV/TroZQnBMx8I/XVqcXavTAbyGeFkMqi0UTgSFWhIe0swOFeLo07K5Qckrtqc6
	LrOpRI8i6ou6XLSH9uYvwWeaiP/5a4uiAlGwpsWBhJdFiwiRgSiUhSRM01ejxM7b5QwvoMhI9rM
	P8jFQNoMFH2ovQshMOz+qtX4jy15QrktZg3bpYe2bN2y2QdqdGWinjIQaLiv7XOEocip3xL+P8g
	ugtdUwUfrHh+tu0SZKoODu1koIOfTkjwgRvcZ+9MvxogFSVChkti6GTpTz6HsVyNskBAUmgKljF
	sMPX3fQ/aXZM6kPChh+9ERIZP5IHhI0OtoLgOhLlUgrGFHU1qLwlg
X-Google-Smtp-Source: AGHT+IFLExEaXq7gcqhkxhBH7QoXhN+az7rnueVk6V4sNI+MOKKvARolinNsF5f33gcKEbmj9fJVNw==
X-Received: by 2002:a17:907:7f0a:b0:b04:3e43:eccc with SMTP id a640c23a62f3a-b1bc05df2e6mr684156266b.40.1758202422920;
        Thu, 18 Sep 2025 06:33:42 -0700 (PDT)
Received: from localhost ([208.88.158.129])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b1fba8d2700sm204386866b.0.2025.09.18.06.33.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 06:33:42 -0700 (PDT)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	linux-nfs@vger.kernel.org
Subject: [RFC PATCH v3 9/9] NFSv4/flexfiles: Add support for striped layouts
Date: Thu, 18 Sep 2025 13:33:10 +0000
Message-Id: <20250918133310.508943-10-jcurley@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918133310.508943-1-jcurley@purestorage.com>
References: <20250918133310.508943-1-jcurley@purestorage.com>
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
index fa1214659df7..40fab561802f 100644
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


