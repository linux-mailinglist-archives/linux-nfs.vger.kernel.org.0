Return-Path: <linux-nfs+bounces-13895-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64236B34E09
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Aug 2025 23:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AF56486B43
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Aug 2025 21:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E969A1991D2;
	Mon, 25 Aug 2025 21:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="awUeoFKz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225B028469C
	for <linux-nfs@vger.kernel.org>; Mon, 25 Aug 2025 21:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756157274; cv=none; b=bGu/fa5DdKVaMVU/WHVf5GvkU1oOve7Vmq+c1tpiCLVK3mpaNqlztuKb9ddnPQj8j9qjpiaSecdMj9rKkSS64+E8NfWlk9KSdN1saD+3QD6lH4wy51nDJ8m9gB53WK4ZG1SWRQaByBDlAYMos9geFCgooLOf3Ihgko859PZd9Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756157274; c=relaxed/simple;
	bh=aPYnUi5hpowTOoHVC5aeVOlwM9JkatgHmqV2akwvea4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ryIZKkiOu0DRrlpoujxqyODzijO6rrzKlQDY42ht1JN4BOSIYB/o72rYgPyeHqWohAg95akmOQYK9H+z5fMOKBic+ypvL9cWMXq4huzPthQr1tfkGWekPrcilO/FHfxjuW2Cdbl9nmcw5AtZB2ADSaUmE7IqYMDm15YYc63U72I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=awUeoFKz; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb78c66dcso678853566b.1
        for <linux-nfs@vger.kernel.org>; Mon, 25 Aug 2025 14:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1756157271; x=1756762071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=giypt3XjOwYhOOtBE2ywzWhvrd7pYRyRrO79cdbGyvM=;
        b=awUeoFKzRDWP0WgCMFf3h7xSTxxMNV/Nz/UUuZqDpX1jNO9hQE50oobFRS+ju9bNKL
         VXDNhRtyaQWlu8W1SJKZcf3Y8AImvyae5PVBQngwXstOuqgQKU+nj1Jzv1QShm3KkfFr
         qYAC7XKIOTQCyCbh8X9E4rSRgX/t8Vmhc5Pna5IYDKVl8IriR9fjdS5Thh0DxXTBbu/+
         R9Z33ywaTFFF854n7toMZRDLKQ25sUMrMXiuFOc3tG4AgTTxiZP5BWjb99jTvJ1Jhweb
         3nxxmp80XBlUQjLHjN8mz7dSVIGDr6sVDAZuXtrWxID73+1owVJD3wb4cfvgQ+xR6Cse
         DFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756157271; x=1756762071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=giypt3XjOwYhOOtBE2ywzWhvrd7pYRyRrO79cdbGyvM=;
        b=ArjNk0O1ubd2mbyFg6Mm6tJ9uAitQZ1qzsrW+gaZk7APp7xXyctXNv0WAA6BKO/XTw
         Z1hEsYt2OE7d6OiHHuHYtv3z6iLFi/BXqvoPHEh1txBfnr5kauYyg6q7bNMH1PH0lR+0
         Rak+ASnj6/7mMVhajp0N6A2sOGmA21gq5/Y/IjtmkzOaGLbi4HibEUrorQWojzCaWwp+
         sTMFEClHRBSvTDCSLpc3t14jxURUwmGiAav0yWc6xl4IIL0MrwPZ9uFIMFsgnhBFD/2/
         VaAZzjwMdO5+6qkKVsKr7yTo1GAifn6jsP9r37x8l7F9LbLGvyljCkQKYz49pzfXFtCy
         lx3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4+dXlN9rKdFGVwUtqBJnX22nwnEFb3gUmgAh2WOrNj6U/w3mg6PDGABA5m94Ez0qD4L666GobJtA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9sqsOSIVM6F6aaM3I3BjLv5V2qPZmq8r71gm75NJKD+v8MQ5g
	tCm1h5LHeFT7Wr9383aDkIyYT1Gjc/GpDd612bz7GmhKWQ3yyZNFYuzqgo0qjl1J8Ao=
X-Gm-Gg: ASbGncs++bjqT+KquQshgQ0kgdXIEW+DDk6QR1UmrI6IIqCtUjcQVkBDoTThY9GDeOk
	hQxh7ki98VCJ8B3zfFRLDZLew5y/ZRfnnlnVOoXun+tkaHJcjb+AU5zmIoGT+DPu3ev3K21wpXx
	ooU5pcHcReSCSw7B2XgP/YqwKas+T1xWVJjMzppen2k5hs5khlojOW20EtD0gxgwdbAd9OzUJJd
	oYFHis4LVdH64PvLtTJnW2MPEG3qaDxmm5gJ6mdMp3R546TdQdff7e7U9avnqzByKj42+OKzuI9
	AChp0D3htnpBXCEG/lzDqK3HCwfd9ZckSJEZTMYG0bYYDlxTEOeSLEQL+odYFm3upCB4arHaeMy
	yhan21n8rlrVpb33xMnH6GBU=
X-Google-Smtp-Source: AGHT+IGQKNqHFePJKaYLFQUtRpsFpP8xrWBGArPUWFoOhgNqwnYnsE0VWTGALKFP/8LRS+pK0/S9OQ==
X-Received: by 2002:a17:907:da2:b0:ae3:f16a:c165 with SMTP id a640c23a62f3a-afe290466e3mr1379362466b.31.1756157271336;
        Mon, 25 Aug 2025 14:27:51 -0700 (PDT)
Received: from localhost ([208.88.158.128])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-afe97a4b200sm86109966b.72.2025.08.25.14.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 14:27:51 -0700 (PDT)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	linux-nfs@vger.kernel.org
Subject: [RFC PATCH v1 7/9] NFSv4/flexfiles: Write path updates for striped layouts
Date: Mon, 25 Aug 2025 21:27:27 +0000
Message-Id: <20250825212729.4833-8-jcurley@purestorage.com>
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


