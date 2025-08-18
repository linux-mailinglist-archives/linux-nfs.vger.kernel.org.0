Return-Path: <linux-nfs+bounces-13760-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FCEB2B3F3
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 00:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB10D7A489C
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 22:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79914246BB0;
	Mon, 18 Aug 2025 22:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="W8C/VKIE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47641E25F2
	for <linux-nfs@vger.kernel.org>; Mon, 18 Aug 2025 22:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755554926; cv=none; b=MlCOHivLnLD9BgZwb9UICoyUuMLKFcQZkaGzjLKuVpkwtG+vMUlGM7RpWKYm+K0YkQHgzDQgNYN0ibkZCNDao3FbdJuNRdKVYKdljq9Dvk24pbT8ZFtIeb/boY84XNz6K7LVUtxfyige1seiHw94ETNWmPjSdVNqjGyFQC/TaIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755554926; c=relaxed/simple;
	bh=aPYnUi5hpowTOoHVC5aeVOlwM9JkatgHmqV2akwvea4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M8i+BVxXkWvKHM7pQxjI6ZNhmiWwRjPPUHqbFVD0/27JhwASm/mzEiVA3z8XNn0PERm4YmA/B5eeIMJ269RABhj5LTaR0HUzrRI3/clC9avoK+e/EHvi8ff4ptn2jva7DPTsVPYfOC6SvQ8kegs6t3x2aGOAjOlf4BrtCWgoTcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=W8C/VKIE; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6188b5b11b2so5870567a12.0
        for <linux-nfs@vger.kernel.org>; Mon, 18 Aug 2025 15:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1755554923; x=1756159723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=giypt3XjOwYhOOtBE2ywzWhvrd7pYRyRrO79cdbGyvM=;
        b=W8C/VKIEdsCwpzvy8JVYONh7C9EHb96HJKXBbrQtLX60tE4DNp4s5ZpOwiKD5I4J3Z
         w5I1vaVSq30jT3tUV5z3sUZksbL1sqBshwenFV5eENKd6BVm2kCtDiNwFUmRbF3mJGuB
         BnOrjApCB+TLK5XWCGocQ1XidhdysiglgBcmteusBre8B3d3aKkiixBHz1CSOaKWSLRu
         ZzJH9k14HmeokL8MYsRZXkU0j0nfiATr44dDWUaAn7iharhal6LiQyYQbn06pnOM7IDA
         Jk+6Huxxr8SyApKe4TCka0fA+X+2bQO7gLvzfzcc75p4309Xf4tGQX0G10Ub7dAjG4Rt
         2yXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755554923; x=1756159723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=giypt3XjOwYhOOtBE2ywzWhvrd7pYRyRrO79cdbGyvM=;
        b=HqedxNEXYPTm1et2mxQRUbX/Dd1b67dduzW6jpy0YGvbhMeirVyb/HCPZj5FbiNkA8
         5M/NukFqEkNG2TkWdlYUq/ijZuKc0V54UUknkEDXQklRAr4EKI9PYT+76ppDc/hUvMUA
         n0YXP0fPFNGLX4KdfHfR5XKgULxeQgTilygUYnjAJq62aUmCXc7mmL4fDhEPRxH3zcsY
         r3ntdxyCLPQHKVqGhie/0dqSKknJwtpGd6LpzMNBdwcpEm/jOmIlrvKhJ5QoVOkLOaq4
         UZnV4ZmPln/fZcHKhJW2YwEkshRSXbJU9mznu9VdOa97oU6amdMQMiPMT1rK78+9mIvu
         +J+g==
X-Forwarded-Encrypted: i=1; AJvYcCVECKvnPOUcGkT2rHl6vQGSPpTamHSh1XxP/g9YBX4T/2mAwJPlfLsEZHrQbk84O9D2U4NibPF6bws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5BDJO3TMkAJDk54SGoZlS6A17g8OcEA/LHKoiiUzP+Uphhxhl
	7MT7bNrFp5cvix4Gr75H/8ecTiVdVvBsmsfknYR7ew2KraDsdlwrzRh9CdeaAieyT+2oBrdwHsB
	xmSna
X-Gm-Gg: ASbGncsyZ97YLOMurjaJBFoR2KaAmOapNnC0Dx6X6ieUZLnvwNUOnkmt1hkA7dKlG1f
	E89E+0XQJSMSmxx4q3vJLBd/ygqFWmt/YCCCb2F6YVSZ+NF32Q8EKwnYC3pFWLDKXl2M/tX/Q6i
	J+q6cswuJfCk7PAeTuDTgbw9XRvo1ksR4pFSSGuURZ8ZFTmDI5ruijy4f7kj96kgScvbXJxS+au
	XnTsBDVsPXOIjcnAnnvEpvSxUfJu9zPK8LBiuhMFOPVRCc2TvVQ5PajkFXXO6TJladT3ZWzVCO0
	g3gsu3LsABffLS43gYdmak0eY5ZgNoiO+WWt1OVoZpf6057uK63V6ZRSwakqMJYhGFet1CZNXrc
	jI7+6i1HxSkYOh1WXNwsc5G8=
X-Google-Smtp-Source: AGHT+IGMzgOxqEFUJ5AUk4hdZNWRQXEvgfGqX0Sk1TWOVwgZYOrOjfOydcMaVijG5atJvCKB5IAUhA==
X-Received: by 2002:a05:6402:26c3:b0:617:b3e8:97aa with SMTP id 4fb4d7f45d1cf-61a7e6bcb2fmr141531a12.3.1755554922933;
        Mon, 18 Aug 2025 15:08:42 -0700 (PDT)
Received: from localhost ([208.88.158.129])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-61a75777beesm525418a12.26.2025.08.18.15.08.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 15:08:42 -0700 (PDT)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 7/9] NFSv4/flexfiles: Write path updates for striped layouts
Date: Mon, 18 Aug 2025 22:07:48 +0000
Message-Id: <20250818220750.47085-8-jcurley@purestorage.com>
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

Updates write path to calculate and use dss_id to direct IO to the
appropriate stripe DS.

Signed-off-by: Jonathan Curley <jcurley@purestorage.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 42 ++++++++++++++++++--------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index b0d870359536..696589d191e5 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -605,6 +605,14 @@ ff_layout_free_lseg(struct pnfs_layout_segment *lseg)
 	_ff_layout_free_lseg(fls);
 }
 
+static u32 calc_commit_idx(struct pnfs_layout_segment *lseg,
+			   u32 mirror_idx, u32 dss_id)
+{
+	struct nfs4_ff_layout_segment *flseg = FF_LAYOUT_LSEG(lseg);
+
+	return (mirror_idx * flseg->mirror_array[0]->dss_count) + dss_id;
+}
+
 static u32 calc_mirror_idx_from_commit(struct pnfs_layout_segment *lseg,
 				       u32 commit_index)
 {
@@ -1014,7 +1022,7 @@ ff_layout_pg_init_write(struct nfs_pageio_descriptor *pgio,
 	struct nfs4_ff_layout_mirror *mirror;
 	struct nfs_pgio_mirror *pgm;
 	struct nfs4_pnfs_ds *ds;
-	u32 i;
+	u32 i, dss_id;
 
 retry:
 	pnfs_generic_pg_check_layout(pgio, req);
@@ -1039,7 +1047,12 @@ ff_layout_pg_init_write(struct nfs_pageio_descriptor *pgio,
 
 	for (i = 0; i < pgio->pg_mirror_count; i++) {
 		mirror = FF_LAYOUT_COMP(pgio->pg_lseg, i);
-		ds = nfs4_ff_layout_prepare_ds(pgio->pg_lseg, mirror, 0, true);
+		dss_id = nfs4_ff_layout_calc_dss_id(
+			FF_LAYOUT_LSEG(pgio->pg_lseg)->stripe_unit,
+			mirror->dss_count,
+			req_offset(req));
+		ds = nfs4_ff_layout_prepare_ds(pgio->pg_lseg, mirror,
+					       dss_id, true);
 		if (!ds) {
 			if (!ff_layout_no_fallback_to_mds(pgio->pg_lseg))
 				goto out_mds;
@@ -1049,7 +1062,7 @@ ff_layout_pg_init_write(struct nfs_pageio_descriptor *pgio,
 			goto retry;
 		}
 		pgm = &pgio->pg_mirrors[i];
-		pgm->pg_bsize = mirror->dss[0].mirror_ds->ds_versions[0].wsize;
+		pgm->pg_bsize = mirror->dss[dss_id].mirror_ds->ds_versions[0].wsize;
 	}
 
 	if (NFS_SERVER(pgio->pg_inode)->flags &
@@ -1122,7 +1135,7 @@ static const struct nfs_pageio_ops ff_layout_pg_read_ops = {
 
 static const struct nfs_pageio_ops ff_layout_pg_write_ops = {
 	.pg_init = ff_layout_pg_init_write,
-	.pg_test = pnfs_generic_pg_test,
+	.pg_test = ff_layout_pg_test,
 	.pg_doio = pnfs_generic_pg_writepages,
 	.pg_get_mirror_count = ff_layout_pg_get_mirror_count_write,
 	.pg_cleanup = pnfs_generic_pg_cleanup,
@@ -2051,22 +2064,27 @@ ff_layout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
 	int vers;
 	struct nfs_fh *fh;
 	u32 idx = hdr->pgio_mirror_idx;
+	u32 dss_id;
 
 	mirror = FF_LAYOUT_COMP(lseg, idx);
-	ds = nfs4_ff_layout_prepare_ds(lseg, mirror, 0, true);
+	dss_id = nfs4_ff_layout_calc_dss_id(
+		FF_LAYOUT_LSEG(lseg)->stripe_unit,
+		mirror->dss_count,
+		offset);
+	ds = nfs4_ff_layout_prepare_ds(lseg, mirror, dss_id, true);
 	if (!ds)
 		goto out_failed;
 
 	ds_clnt = nfs4_ff_find_or_create_ds_client(mirror, ds->ds_clp,
-						   hdr->inode, 0);
+						   hdr->inode, dss_id);
 	if (IS_ERR(ds_clnt))
 		goto out_failed;
 
-	ds_cred = ff_layout_get_ds_cred(mirror, &lseg->pls_range, hdr->cred, 0);
+	ds_cred = ff_layout_get_ds_cred(mirror, &lseg->pls_range, hdr->cred, dss_id);
 	if (!ds_cred)
 		goto out_failed;
 
-	vers = nfs4_ff_layout_ds_version(mirror, 0);
+	vers = nfs4_ff_layout_ds_version(mirror, dss_id);
 
 	dprintk("%s ino %lu sync %d req %zu@%llu DS: %s cl_count %d vers %d\n",
 		__func__, hdr->inode->i_ino, sync, (size_t) hdr->args.count,
@@ -2076,12 +2094,12 @@ ff_layout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
 	hdr->pgio_done_cb = ff_layout_write_done_cb;
 	refcount_inc(&ds->ds_clp->cl_count);
 	hdr->ds_clp = ds->ds_clp;
-	hdr->ds_commit_idx = idx;
-	fh = nfs4_ff_layout_select_ds_fh(mirror, 0);
+	hdr->ds_commit_idx = calc_commit_idx(lseg, idx, dss_id);
+	fh = nfs4_ff_layout_select_ds_fh(mirror, dss_id);
 	if (fh)
 		hdr->args.fh = fh;
 
-	nfs4_ff_layout_select_ds_stateid(mirror, 0, &hdr->args.stateid);
+	nfs4_ff_layout_select_ds_stateid(mirror, dss_id, &hdr->args.stateid);
 
 	/*
 	 * Note that if we ever decide to split across DSes,
@@ -2090,7 +2108,7 @@ ff_layout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
 	hdr->args.offset = offset;
 
 	/* Start IO accounting for local write */
-	localio = ff_local_open_fh(lseg, idx, 0, ds->ds_clp, ds_cred, fh,
+	localio = ff_local_open_fh(lseg, idx, dss_id, ds->ds_clp, ds_cred, fh,
 				   FMODE_READ|FMODE_WRITE);
 	if (localio) {
 		hdr->task.tk_start = ktime_get();
-- 
2.34.1


