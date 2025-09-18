Return-Path: <linux-nfs+bounces-14563-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F484B84DBA
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 15:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 979F2547707
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 13:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191648F58;
	Thu, 18 Sep 2025 13:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="b+No29Pt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4065BD515
	for <linux-nfs@vger.kernel.org>; Thu, 18 Sep 2025 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202420; cv=none; b=hR0ll8lxe6lSAPwXwWkqtjv+IPL+sRdDMGMZthBDJX4A8CGXoPdSD4Jo6kE7lLnmnKzBuZSi1H7fzexjvkzViouyVCiLf6rc7eC14yOT3Poeg71sAoiWVJnIESVgjODAfiRutZHN7xB8P6t0LJDlsDm8+iTM/VVKT46plXxKZe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202420; c=relaxed/simple;
	bh=ri4IODWgnXeD6qCOb1zKKNO6p2wNByTTZzUCVi7Ykik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q8si2R3/BxbhpSoxg9IbtelzMUrhL8WV0YJY3Rrf6rqNMHzFNU9nJF9QYeNrPaj7vfNuDu+yNiCVFSFy+dYbuX1/FG45RRaWDXRtLpOd4051et1ZCqNtoxkMgT9iBki/hSKXIYhfxRhjE3Dgam54LFgTY9Na1uXAEbaWKsSudjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=b+No29Pt; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-62f24b7be4fso1593970a12.0
        for <linux-nfs@vger.kernel.org>; Thu, 18 Sep 2025 06:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758202416; x=1758807216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gxq/0lgMQZ7X29f/z0HbxfdTU2T4qCh9QvCO/oVUtGs=;
        b=b+No29Pt0Srg7uC4DZE3W0rBDwKOcrBwmzNRAxgVKOFVEiFNvEhgOZQ8TsP57HIsbL
         +VWNdtFBkfSwdBI2uPCtcymrzRJUrOHunjabuiBcPbVRYiUYbwL7hhcGI1rv8ILsk/+Z
         bD65KcKaXK86fmCu2b83n/ZMf31SEG9cyBYgIZqjT63BW9obFWRJyMBJwtT8CPvfruUr
         ALQK3TpdrdkMvEPG0pJub97JyiQ01L8yQn8ejG+plOFLuQBvcdISCnW4XBVXBR4YoFtP
         Om2DfclEna8T+/POo88wU1P9VFfLpNadXpVca4xImc5L/f44CAGgwtjkNZyL0Y/5Y+9r
         eICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758202416; x=1758807216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gxq/0lgMQZ7X29f/z0HbxfdTU2T4qCh9QvCO/oVUtGs=;
        b=Pad44yAhsvbvAtI0CkZjpf0++N+ZCcLqYY8RratwLaGRrsAngkRkM43nMv5l+N3OGF
         vlvS0EG48lpGgIZ81IVQxBVBEm3DRJZIPsbN6AM3xW1PwJRc6I2P+DtbwQdsPPKt8rQk
         W5rpmxIW8kcPjLzI6vMwK03GxsJlRmUyIvmrdOoc69HNVHKAGbECaqIZutbQMRSYndaD
         4qaeMG0Oz+ZofxrfgP89D2vxQH9WHI5Rdfu/g6YY+Xd8gYdKV7rbTIk40WcqEk8WT7Pp
         ZTmaqBFRo1SxZm3tukP0IF0mx5v/3LGZP0QRUe7w06fO6ielZ6PzUf9zjoHzn5lsKdhY
         OhQw==
X-Forwarded-Encrypted: i=1; AJvYcCXK5E5fnax7tuv5iEy1bZgPGNz1tWFTUlWgGD/1U/ZrtKdWgoGmnIZWxgz3RuKtg3h8y9RUn0EAo/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy9NayBxXPMHM3fE0O24mBPluHw4CdrW6o+zxxfr/hkN+HskPv
	Yjxfbfj1VeTm9Vu3gtpKmr62o02bSjc3bJRoX99dZdgqTrfS1CteCq2BgvcHu4WoTUzVNNHx8On
	qEz3V
X-Gm-Gg: ASbGnctZ10huHfjRIWcCXz3m0kk/6gU4KNbe8rDKxdMb9Y3nFQ1h+TxOMgt11joDKWN
	d8gsBPLq0OZA+YTjIukVO9Xs9H/mb19400dB3lA0sC9VjTDkFtPlxrD+muPgSRq8q1251E84GQf
	gyRH4M17ib6eAgSimqvR/i/X2XwNShVGfjr85EwcguFnP7pTLrqf/0kfkpU8egdnySclVXjibC0
	WKnG9ivp2VrK41dYpRMmBBsH4ibfmd+d+t3AgSYAZU489wTHfAnescDSy9NlsidqX/hBL7363fF
	u8LKEepD/KSVoK+PqsJ7LfQNYytFcwuZOIFMUET7nt/vdor3aUFteqwLCjdvgRM5wzeACUfKx+H
	JjOKfQ48yutJF0YP88UKZM7HUbqzWIqr8QYgi97Y0DA==
X-Google-Smtp-Source: AGHT+IGdK38iw7Z8KY5fa2PBHuhcIgSfa3A7vBKW5zBLVGse3pCN4LRPlqNUJAVjMQ/T4bAuBJFxLg==
X-Received: by 2002:a17:907:9713:b0:b04:39af:bee9 with SMTP id a640c23a62f3a-b1ba947957emr622658966b.0.1758202416251;
        Thu, 18 Sep 2025 06:33:36 -0700 (PDT)
Received: from localhost ([208.88.158.128])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b1fc5f44bbcsm199933066b.5.2025.09.18.06.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 06:33:35 -0700 (PDT)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	linux-nfs@vger.kernel.org
Subject: [RFC PATCH v3 7/9] NFSv4/flexfiles: Write path updates for striped layouts
Date: Thu, 18 Sep 2025 13:33:08 +0000
Message-Id: <20250918133310.508943-8-jcurley@purestorage.com>
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

Updates write path to calculate and use dss_id to direct IO to the
appropriate stripe DS.

Signed-off-by: Jonathan Curley <jcurley@purestorage.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 42 ++++++++++++++++++--------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index b061e7a576cf..5c4aebe9b905 100644
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


