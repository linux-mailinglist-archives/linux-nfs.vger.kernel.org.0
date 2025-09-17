Return-Path: <linux-nfs+bounces-14532-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9375B81D4F
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 22:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61B191C22D6C
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 20:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CFF1B3923;
	Wed, 17 Sep 2025 20:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="SznVt+6x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D4A284670
	for <linux-nfs@vger.kernel.org>; Wed, 17 Sep 2025 20:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758142132; cv=none; b=L9BAO/EmMQs/xLFMIoMOR7ZC8fr9Cr7W5eg9x1WsDbzund54gl4h+yUTXyiDduBewKdn34bl3dGHKRgp8D6J6ZK9vsONg5hDSXuZeNErLvzjBGGJYg83Fn+8U3THo7ybA/y+MfbylzRil4fXddOS/PwkRNS5y+QNkJazdjtmdVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758142132; c=relaxed/simple;
	bh=aPYnUi5hpowTOoHVC5aeVOlwM9JkatgHmqV2akwvea4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V2wDnyVYs/H+HdP0ogQ3nU9FbJwJeemlMf+1rhoTz0q+Y2iLzAXc4cgTNlwd1Siq0MmwXdF6mhB3Dnupr8xtMqCPfpaORhsv6DbYZQHNU2/xP6JeYh/DHp4jhVl7OVGcRabHAs1ZtNIGwZDATlP0xF6pmy7DuiVppnVXq0CZ3vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=SznVt+6x; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-628f29d68ecso330819a12.3
        for <linux-nfs@vger.kernel.org>; Wed, 17 Sep 2025 13:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758142129; x=1758746929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=giypt3XjOwYhOOtBE2ywzWhvrd7pYRyRrO79cdbGyvM=;
        b=SznVt+6xI8uswkLy3MV9b9uuCAO+euCuW96S6l5QdHwQfvCcU1uRr48G8G8/dEO5nL
         8kZSelmJmvAc136er8ivBh2Mkq8pvDkwLle1qMs57FOcRB1kscoWxzWM038wae62w65f
         cy4+xz34xQUoqEWf2Kfbct/9L2RBzxg54Y1OzjB/GeKqiHlf0NpcDb09Th2xWFIU/uBN
         aEQQT4Nxbtt/JmhUmLVQIcjl1UV0xe2y77v5pfny2IwPOdn3KbfHzT4WgzziuXKOwVmk
         44RiM4sAy4dtqo5kmE3lsefGGdljrfoGOm8ugrebsP3toVXWu1fueOJjWk4Esy3UTTiV
         cfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758142129; x=1758746929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=giypt3XjOwYhOOtBE2ywzWhvrd7pYRyRrO79cdbGyvM=;
        b=IxBS8qTpvWbkcegQqnyUJUo1peKQA5wRYeIioM45vqlt/eBSWcu6zlijqPhWwV36cy
         xwWpUDnJcMHTs0X6tmha9DZaLIjrXpr6izOG3jbKSFqEwkNyJBfvDhRNgOlG8Fvpyjia
         MvaXKHcngUmkLZDuXemqgH2RveQp8dv+xoc9g5HzgNvb6uF/UkYw3ZUYC4QZvFa5wN2G
         iP+xnFTfs/yCl4eRf51DFYnuL1dWne0XmiI6gi6hoxtaTOqUNxTwLp0ceA49sbUZf4Ba
         pjRhfiiF5BixnDZi1KBQjbidC4Cgrd5Vg6SuAKJ+/FvZvhhetESYDGh5qCrmgjHlhB9g
         8xgg==
X-Forwarded-Encrypted: i=1; AJvYcCUBKYnWvrBOu6lGWbt4/WTqYVg0rRxMPGF8KSK/Md/b7x0lpvpQmxVSQslFGkiRGrd92wwcA90zYbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8xSrMRT+bYFSJW2MLLk2VqkIqKbLphkG3obPhSjRjS4++2yud
	1CqtsGR1BnkHEBD9Ngy+l8gg1/JVypmxOybQXINM1xL7mmg3EGnXBFv4EC+f9qgOblmsKIOOk/X
	nyvxG
X-Gm-Gg: ASbGncu0Cue/ttRUGTfORK7jU8QMrz4g/f/yDnL13iLk8HAoDm6wJMuB38sWewzkqW0
	uaqkDzmmhJJR/8DttxjLQZWUgdyzw9UFW4Su7HuXKDGSaLPrRYJuugFwd050jE/YQ2ZpwjrqJaU
	6kKfUZ7VsH8WoRXixJl5s1GueQ6JOGbmf9Hlf+7lvom3O+L8fSWVO/GACUXNRAMTVx6uvnjPG/D
	au3FlgxoCY5KColKuRJLrB/WTblkN60BPjWxbSESx4KsMj0hbX5NVx6y37tGhf8LLSBwLX8NdOL
	wEWMSeZJ7+EeR+utLYCjklUAYT451PVayHLzaIxiJ0TS9WKKuhkk5/Z9f8LfBANKjlfvB+CWa2W
	aydKMFN73u9LkgSOhauoD8SigivMof8GYpEIUy1gnQg==
X-Google-Smtp-Source: AGHT+IF1SbjSvxYW7s1/dwwGNuE15OigxT7KeeEObp8nGPReBtb0dXJ2WZ5+YWnPj5EHLvwbDVaS4Q==
X-Received: by 2002:a17:906:d25d:b0:b1d:baa3:5c69 with SMTP id a640c23a62f3a-b1dbaa36c95mr234596266b.41.1758142129311;
        Wed, 17 Sep 2025 13:48:49 -0700 (PDT)
Received: from localhost ([208.88.158.128])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b1fcfe88e14sm42615666b.54.2025.09.17.13.48.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 13:48:49 -0700 (PDT)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	linux-nfs@vger.kernel.org
Subject: [RFC PATCH v2 7/9] NFSv4/flexfiles: Write path updates for striped layouts
Date: Wed, 17 Sep 2025 20:48:25 +0000
Message-Id: <20250917204827.495253-8-jcurley@purestorage.com>
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


