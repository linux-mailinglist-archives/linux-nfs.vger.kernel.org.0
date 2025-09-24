Return-Path: <linux-nfs+bounces-14654-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C07CB9ADD0
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 18:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8972619C5278
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 16:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89733313D68;
	Wed, 24 Sep 2025 16:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FpIMPdiJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC3416D4EF
	for <linux-nfs@vger.kernel.org>; Wed, 24 Sep 2025 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758730890; cv=none; b=oBhzQT5CkObM4gcOgTsl/aZxGyz2yJ4sJSIM088advf2S6uh8fTu+XBr5FJHAsa6jdXbKKoyClkKZDz0zr5hpPFzZqd1YJFRPIIiASPtmBsFUKjOKLf5zbwsScGrHkXCrfnlBuyWMTD1nZYv7e/YFyr98aTbFJ1XIBNnecBbvuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758730890; c=relaxed/simple;
	bh=nqW2h1nzZmrgKHkYh0mqd5hTWv86rIYdv2r19ezz3eM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bA98wIjQz/vb0yaK24FF9CksglaP3asG7gL4TAt0io+sq3eQFwxvhDVAomlY+7HjgeNRIrjvuUjgnrkM4CtHA2YGh5304Teud3onwW+r4jR2yuvQI1DHeAzXB0ZZyF8wmPZa5esLZe4r2OU8t8W0Dd21IWnwtEJJJ//rHJdESVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=FpIMPdiJ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b2d92b52149so4705166b.1
        for <linux-nfs@vger.kernel.org>; Wed, 24 Sep 2025 09:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758730886; x=1759335686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rol2DdP5KmBrYWCOHENNA+OSR/baYPto/CZEXE4xH+0=;
        b=FpIMPdiJGQMQHqwuLHNnm29+W2gBTFhDOFZ4/bR7sn4+VT/WB0ADyo0pW+ELjOJ0tS
         uFNAiRoqF4DAP6vrjahWDViYDHeBfDG7/k97/ZNh1PCPLsJjq6L+//7YZ0+CpU5HFkdK
         GWxcdPvfsZl/pWVAj8TcAKkJeZVBo9sdrxmKkCwpw6HKzSirAcqW2tBJ3iTbI0q4PlNI
         QhOns6J49e31ycSFYE3qW9SL7evg0Wj6d1Bk5dvnRQLr4SBhIGP5z5Nvo1SxfK2LRQaO
         YPMmKil8vKiYHP5cuxamGFni+90ZDlskDQbeMhbnkUWvKVCSi2XKfvSAH4eeosSS6pGO
         pJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758730886; x=1759335686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rol2DdP5KmBrYWCOHENNA+OSR/baYPto/CZEXE4xH+0=;
        b=ShGHzMctIcoDbu5YC/D3pxz+sEiC949cHWWOH2sg6i2M71R3H6P2CARZvERKfiP42B
         PKTRWSSS2tENI2ywDW8YKItXP7o2hqofbAxwP+nBxj6i5KBbUrHnkGhVD4EFV9+opHbo
         vSWddqhd5rAKf6AoPZyYkiErghqT50sdsbiDeBSjzVb/z81sG+KtTMQ10qyjt8XlL3li
         UazQgCHR7tMu05AJcG+kquvzxJRLPJ6W0EUlzAhfkgDiUawcodMzvLuvTAhgHLIbeRhv
         bYCbEC8fE4tsMpoqB5bTZcyG04J+rQzsW4cZGDwpkCmDUps7/NwiWZSkluNKl8pLax5V
         7Oag==
X-Forwarded-Encrypted: i=1; AJvYcCVbyALzyLlaXyufCciEWpvDmgwY/k6MNRFlLbBsIzsKs5fJHIyXsEJwlxcJ2DykIW0pcE/T2l0tDPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcN5Bsv5ARZ7CAVBlmkREL7nAbAod/9HTMcxFy/1O/wo7KN4QO
	S0EK1hYp+uSc3uv1DeNYJoIiVh3cK2jSVXMj2tZdg0e/TYR6urwz4NMGmC9Sdl/yTOt1n3D1EX6
	XFtR4
X-Gm-Gg: ASbGncvdQqD7JeLEaxtzi+cXjkCzwhvX9DfvHE9lnw55se9nnr8ZmGxbT34+zuULLuF
	pJHBIa9p+WaaPy2q+9WCVgK2TEWcEymlw3l3icQwSHkV1hJUeaobgH3XcQRHUKOF5EiqXr5Fqcx
	t2Pq3bcu7+XPBGF6eYfLKhJkV9RdUSwlmqcn8Gc6jROgiVOGWZyIp2OcjIgc3LNgFvwrpYeYFOe
	0yB4GRlIuRfgxOH0TABVofXT6oBMEUEQvkoWAitIsLmtGRz2IVb1NiMmZK/p4HHKgSOe8OTpJHH
	ZPt037CO4E5GYYlTkNMWslc6hSM3jP04qne+FueG8rwiXoEC+t0m/XtnSIiLivX6VlgYfSsd6Ka
	Z4xhVAx2vwBeoMCdrFs6Slvw=
X-Google-Smtp-Source: AGHT+IE2kL8yUSmI+rjVD6eY22WbzEVqGthBkBlesKei5hRlPi/ETfG9yj7XawVPFbUuwXd8EvOQNw==
X-Received: by 2002:a17:907:9815:b0:b30:ea06:af29 with SMTP id a640c23a62f3a-b34b7fbb555mr46266066b.16.1758730884410;
        Wed, 24 Sep 2025 09:21:24 -0700 (PDT)
Received: from localhost ([208.88.158.128])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b2761cb52aesm1134138266b.54.2025.09.24.09.21.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 09:21:24 -0700 (PDT)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [RFC PATCH v4 9/9] NFSv4/flexfiles: Add support for striped layouts
Date: Wed, 24 Sep 2025 16:20:50 +0000
Message-Id: <20250924162050.634451-10-jcurley@purestorage.com>
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
index 7b95ab1cd140..4546711a7117 100644
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


