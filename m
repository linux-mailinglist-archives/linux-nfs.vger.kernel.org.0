Return-Path: <linux-nfs+bounces-15035-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8EEBC244B
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Oct 2025 19:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 959AD19A229C
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Oct 2025 17:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B946E2E8E0F;
	Tue,  7 Oct 2025 17:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I07pDbO4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959B62E8E0C
	for <linux-nfs@vger.kernel.org>; Tue,  7 Oct 2025 17:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759858747; cv=none; b=amPQr7RiYQ4MCr7d6ZHs+XuqDu5l+2GXiMSPMbpvQSeWHirTMTSVmEhMmoENyRTXIgsC45SAkkiNmfIEGnVdR+JDvkSzr3hJk9BnooMwKR8XPt6lvWnLY6wdIbU1It+2+lXtCqwF3iM5ufDBoj26U1OpX9E6PuUW69ZMrf/KiXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759858747; c=relaxed/simple;
	bh=lb1OHsO5cW6cu4PT9gfFuAIPqFvolGQLlrcZy3hr0mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKzrJxSpl90ozUQxqoZm5+jmAu53YLfBBURk59mPtl2jwAI9t53trFC7EXBKY+ENQIDRB2zDK2gXoGKHzC6G8auCdUtNs15G6+RC3zpNDKaJOUmds4HgA4MU8IzaY+9JokKp8mYHgzDVn7bpJkw50qpA/dcWljRIpDUFqbQfwwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I07pDbO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB602C4CEF1;
	Tue,  7 Oct 2025 17:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759858747;
	bh=lb1OHsO5cW6cu4PT9gfFuAIPqFvolGQLlrcZy3hr0mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I07pDbO4pxA8nZ69ZOefJvTBZZznzsNlC/w8/A4tgwS0s4RBNowydHI/4sQ4Xh8kw
	 eqX8NOhfWmUMRq80wrTEpfgzz2HmrR3WAUU9CArFHoXiQd7Gu9WZjmKP9lamR92ebO
	 O9A5PQWDOqPnteHCx8ImbthyehhXsbjGuHlm7X9iUO8BbPBRlzaDKcVTealZFv1fQ2
	 skW/W5luyGAG4iPAZgXwWIKvCd82JKwD3TfVCEav9piBy04r7TmEauot6wK96eekpT
	 KlV2VaRYnGReb9GhSpNE+JJA/+FgCX58bQYoXRoMCKOum1FHR13pCqhLfpSnZytBGj
	 bsyjBxZkTuINA==
Date: Tue, 7 Oct 2025 13:39:05 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jonathan Curley <jcurley@purestorage.com>,
	Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>, linux-nfs@vger.kernel.org
Subject: [PATCH v2] NFSv4/flexfiles: fix to allocate mirror->dss before use
Message-ID: <aOVQORJe8DkQrHH4@kernel.org>
References: <20250924162050.634451-1-jcurley@purestorage.com>
 <aOUeDCzouBMwjalF@kernel.org>
 <aOUonNQRjYBpYcrD@kernel.org>
 <aOU7Yc8RnF4Eq65C@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOU7Yc8RnF4Eq65C@kernel.org>

Move mirror_array's dss_count initialization and dss allocation to
ff_layout_alloc_mirror(), just before the loop that initializes each
nfs4_ff_layout_ds_stripe's nfs_file_localio.

Also handle NULL return from kcalloc() and remove one level of ident
in ff_layout_alloc_mirror().

This commit fixes dangling nfsd_serv refcount issues seen when using
NFS LOCALIO and then attempting to stop the NFSD service.

Fixes: 20b1d75fb840 ("NFSv4/flexfiles: Add support for striped layouts")
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
v2: checks for NULL return from kcalloc() and remove one level of ident in ff_layout_alloc_mirror

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index fedd7d90e12f..b7d2c0ef25fe 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -270,19 +270,31 @@ ff_layout_remove_mirror(struct nfs4_ff_layout_mirror *mirror)
 	mirror->layout = NULL;
 }
 
-static struct nfs4_ff_layout_mirror *ff_layout_alloc_mirror(gfp_t gfp_flags)
+static struct nfs4_ff_layout_mirror *ff_layout_alloc_mirror(u32 dss_count,
+							    gfp_t gfp_flags)
 {
 	struct nfs4_ff_layout_mirror *mirror;
-	u32 dss_id;
 
 	mirror = kzalloc(sizeof(*mirror), gfp_flags);
-	if (mirror != NULL) {
-		spin_lock_init(&mirror->lock);
-		refcount_set(&mirror->ref, 1);
-		INIT_LIST_HEAD(&mirror->mirrors);
-		for (dss_id = 0; dss_id < mirror->dss_count; dss_id++)
-			nfs_localio_file_init(&mirror->dss[dss_id].nfl);
+	if (mirror == NULL)
+		return NULL;
+
+	spin_lock_init(&mirror->lock);
+	refcount_set(&mirror->ref, 1);
+	INIT_LIST_HEAD(&mirror->mirrors);
+
+	mirror->dss_count = dss_count;
+	mirror->dss =
+		kcalloc(dss_count, sizeof(struct nfs4_ff_layout_ds_stripe),
+			gfp_flags);
+	if (mirror->dss == NULL) {
+		kfree(mirror);
+		return NULL;
 	}
+
+	for (u32 dss_id = 0; dss_id < mirror->dss_count; dss_id++)
+		nfs_localio_file_init(&mirror->dss[dss_id].nfl);
+
 	return mirror;
 }
 
@@ -507,17 +519,12 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 		if (dss_count > 1 && stripe_unit == 0)
 			goto out_err_free;
 
-		fls->mirror_array[i] = ff_layout_alloc_mirror(gfp_flags);
+		fls->mirror_array[i] = ff_layout_alloc_mirror(dss_count, gfp_flags);
 		if (fls->mirror_array[i] == NULL) {
 			rc = -ENOMEM;
 			goto out_err_free;
 		}
 
-		fls->mirror_array[i]->dss_count = dss_count;
-		fls->mirror_array[i]->dss =
-		    kcalloc(dss_count, sizeof(struct nfs4_ff_layout_ds_stripe),
-			    gfp_flags);
-
 		for (dss_id = 0; dss_id < dss_count; dss_id++) {
 			dss_info = &fls->mirror_array[i]->dss[dss_id];
 			dss_info->mirror = fls->mirror_array[i];

