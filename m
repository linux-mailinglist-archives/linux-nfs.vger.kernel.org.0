Return-Path: <linux-nfs+bounces-14652-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B51B0B9ADC4
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 18:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25CA19C2836
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 16:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4623E1C860E;
	Wed, 24 Sep 2025 16:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Nb+x/GwJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B22313286
	for <linux-nfs@vger.kernel.org>; Wed, 24 Sep 2025 16:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758730881; cv=none; b=OVsXa6BNBPNrtb5q9MNTAtwjk/eaY+9kGIs2VOBWt1D2pO5wAoIoeU40UUCZi4QRB46PEuttWy3Toavsw0ccgj4Q5SY875bW6WV7EOKkdYswbKNaGMTOINBw3epYyyfZOvp/XaSAmtm2iZz9vs9chhfRdyGXw7t98f2huMBZZSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758730881; c=relaxed/simple;
	bh=NuZCFD7+WKhLVWmbedr49dIGUUZqJs/14RxwV1lRSnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bQ7CAAIJNGglMzfndLp8/vO0eZkVKpzFypGI+Nb0A2CyKrtq3KdCO2oSzO7AkZwd3GlNJ6A29tfubLVe9QQQmOeuCZ3ku6fbFCsuuoNbzkH1R6C9luIseCpiycrFyYG7GyJL2JBG5uFNgy1Ehbuu6+Mh0PseJQNZAG2K8hpvc74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Nb+x/GwJ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b0787fdb137so5726666b.0
        for <linux-nfs@vger.kernel.org>; Wed, 24 Sep 2025 09:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758730878; x=1759335678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDtMx/VZjHuTnVfHP5ObpsN7xdba2VVc2Ycd+65MPRQ=;
        b=Nb+x/GwJYUNkEEnZldaNfTo2S0PdA8QSFNvt0u+qUOKO6eOjssv/AWzJvEsdm06ogX
         5gRZN8plSVfuZq2Jt0mIzaf4O3QtGJx6HMFtWAl0vsFHqQPNXE2do9N46fAmQkIEW6Mr
         ei8lf5MRRuSgZeJtxihurLCOT+Fs6B44Cd78PYLz9Zrq0jhSsUNWuIm7ruEPzmeMT0Qy
         fYiDkszT4r0tIzxdHdo7kCapo5Qvb4ujmoX9yvk3JNsYqK05LHnM63Yi2+h3smEolUnZ
         OZE3Dl5IDKndp6+r2e4OrYFTwvwowLfzmJoRL/P7GJ4QsgMrm9nQ5SqSxumR1+0Y+rJN
         KKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758730878; x=1759335678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDtMx/VZjHuTnVfHP5ObpsN7xdba2VVc2Ycd+65MPRQ=;
        b=SxK8OJyfzhfwoD/7FqmtZRCS8akmOlzoCMM8Emwzt6VACQGzc0xg2pnMj6WqMJzmQH
         rZAjkBciP3Yvaqg9IhUGnRcNr044N1iALLCDGF2MVOg+T0/LFI5KhTtBwcXopojxsVtl
         ikxFaqSwe835/DAgMajMc7QJTytDJrmWJpVmkfkd4S2O9adcEk2zxNpPUtrV+hG97VJX
         mcOhBgKF7cRBMeovTmm8r8Zr7oShdFWuBZ/ydlbn3B8TeLuZWhBVk8y/jWUwP7z3VtkP
         2+Qmz8Xq4LOzpD9SZ3xwu8zVMGSrzBfOFIqXPqNrMEKYhWX+kA567Cl+cnoifMwqZeJB
         uW7A==
X-Forwarded-Encrypted: i=1; AJvYcCXenCiTAO7z44FRNQduNaSxJtVEYY+hauu4UOsJAXYdOUWC8HNtkn9dMv8GPen2VAAQbTz+a/iZBwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIU/8e5VGlPyEj23Gdd5l3GBMgDOe5D0JQvQfb4NSEvyilycGy
	wFf3pYa0zJZ9kDaEsan3PSO9Q3St2+0/uL9IeNTqrMlUaxolOMNFkseM4IHKDpNn4sI=
X-Gm-Gg: ASbGncvom07BuM40Oah80e9dZlq3u647SR/qluYy7eKIXiGUwDGvHdMDiIcE1Zpb4FX
	+eoBwsl9OW9l6vNyTsCp/O/z5RrGy/2U5pPo1F/1t28mWVCe4zAOBu+yRbnMd6lF9BwMoA+bodr
	ynQeUm5nM7GkE3F+8Q2PjKQ0FGWiV50GuDbDJyA7dEZnlRaCKXPfQ3Stq/T5Ua/WxJ+O/ZgTIy6
	4nhLjLw8U6BenTMuREaur16KZzPBNp1Ngf6TQMLoWGUbwqDhhY1FY+ZDvw4bj/U6pmTMKQqPaeL
	lk/+jQYdUranjEsqvfmlVLHbgRU2qfLsIeMLHHo7zmbeLoJWolobcnTUHrkSqr5TWOIAJaSisy3
	Omj7unHfXcK32rKv19gxoWys=
X-Google-Smtp-Source: AGHT+IH/EQ4te8kW3OzOZapzR8NQOVZ8Omeecx9ZCMs0fmFlTCdfxgeD3UX9z1AsFB5nfde/ln7r+w==
X-Received: by 2002:a17:907:2da6:b0:b0f:135f:62e3 with SMTP id a640c23a62f3a-b34baa36a2emr34817666b.15.1758730877625;
        Wed, 24 Sep 2025 09:21:17 -0700 (PDT)
Received: from localhost ([208.88.158.128])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b296627ef6esm950253766b.23.2025.09.24.09.21.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 09:21:17 -0700 (PDT)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [RFC PATCH v4 7/9] NFSv4/flexfiles: Write path updates for striped layouts
Date: Wed, 24 Sep 2025 16:20:48 +0000
Message-Id: <20250924162050.634451-8-jcurley@purestorage.com>
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

Updates write path to calculate and use dss_id to direct IO to the
appropriate stripe DS.

Signed-off-by: Jonathan Curley <jcurley@purestorage.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 42 ++++++++++++++++++--------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 3e04de09c3c2..95a5779c32c5 100644
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
@@ -1006,7 +1014,7 @@ ff_layout_pg_init_write(struct nfs_pageio_descriptor *pgio,
 	struct nfs4_ff_layout_mirror *mirror;
 	struct nfs_pgio_mirror *pgm;
 	struct nfs4_pnfs_ds *ds;
-	u32 i;
+	u32 i, dss_id;
 
 retry:
 	pnfs_generic_pg_check_layout(pgio, req);
@@ -1031,7 +1039,12 @@ ff_layout_pg_init_write(struct nfs_pageio_descriptor *pgio,
 
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
@@ -1041,7 +1054,7 @@ ff_layout_pg_init_write(struct nfs_pageio_descriptor *pgio,
 			goto retry;
 		}
 		pgm = &pgio->pg_mirrors[i];
-		pgm->pg_bsize = mirror->dss[0].mirror_ds->ds_versions[0].wsize;
+		pgm->pg_bsize = mirror->dss[dss_id].mirror_ds->ds_versions[0].wsize;
 	}
 
 	if (NFS_SERVER(pgio->pg_inode)->flags &
@@ -1114,7 +1127,7 @@ static const struct nfs_pageio_ops ff_layout_pg_read_ops = {
 
 static const struct nfs_pageio_ops ff_layout_pg_write_ops = {
 	.pg_init = ff_layout_pg_init_write,
-	.pg_test = pnfs_generic_pg_test,
+	.pg_test = ff_layout_pg_test,
 	.pg_doio = pnfs_generic_pg_writepages,
 	.pg_get_mirror_count = ff_layout_pg_get_mirror_count_write,
 	.pg_cleanup = pnfs_generic_pg_cleanup,
@@ -2043,22 +2056,27 @@ ff_layout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
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
@@ -2068,12 +2086,12 @@ ff_layout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
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
@@ -2082,7 +2100,7 @@ ff_layout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
 	hdr->args.offset = offset;
 
 	/* Start IO accounting for local write */
-	localio = ff_local_open_fh(lseg, idx, 0, ds->ds_clp, ds_cred, fh,
+	localio = ff_local_open_fh(lseg, idx, dss_id, ds->ds_clp, ds_cred, fh,
 				   FMODE_READ|FMODE_WRITE);
 	if (localio) {
 		hdr->task.tk_start = ktime_get();
-- 
2.34.1


