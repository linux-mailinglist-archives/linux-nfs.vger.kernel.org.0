Return-Path: <linux-nfs+bounces-15028-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA60BC20B6
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Oct 2025 18:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA2D43B0902
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Oct 2025 16:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEC31FDE09;
	Tue,  7 Oct 2025 16:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CA7IUWyF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F6828F5
	for <linux-nfs@vger.kernel.org>; Tue,  7 Oct 2025 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759853411; cv=none; b=aTVXDN9FRl+/fVeZ55aCJ/HlfBMO0DjPL1Js9uRPkZmF/KDr67AwDYTZdpjLBeBDNNCgjdkKjZS5An4g6pym/KaxVivlFNCMBiKZV7DMuBshU5zi8PTf1i1pVK8EdUdRb64daSxCW1pVyUAOhwgOVG6ie6WhqetCd+JbiowWEzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759853411; c=relaxed/simple;
	bh=TFijNMdNryFF9QrvwCzCsjuDz6WQxcUMHoQtgGczzrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhXnPk4xQKlixI68Xm2bnmQdu0h4IfhzYBisCpNuymB5u2CAIZ2jxBcNe3N+9fbsK2Ugy+u++6sLohxrKT9HiPzDXOMfp4k1tUf9oHSb/Xcbdh9ELI4pvPpqKGDGF2QIc0FtiTNztYG963kKMvbgixK9ZuUOawtp87C3iQFDplI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CA7IUWyF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC75C4CEF1;
	Tue,  7 Oct 2025 16:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759853410;
	bh=TFijNMdNryFF9QrvwCzCsjuDz6WQxcUMHoQtgGczzrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CA7IUWyF+rpI7JP5E6d1giXAehI9J/uiS/J64lSGK6sCut8oAjzDy8DDR5DUK3ZAH
	 fEcaBqh7W3LNtxAE2gfFUGkSA7qaVPZrOvvSF/lWO7PsmXTBqD1oRiyT2Z11ntdAP4
	 oi2HqJwyli4LorH//Zdj2HkUVGH3wq521xLz0ssh1zrQaXcyNMrtqk+rmeDl2Om6BJ
	 aR8JICy+XfWgFqvbqyYAsDv51qKkIUvXv7Hw/FBZyWwBwH/pWbqOJAdGBBfJNMWRsQ
	 9dkVaof/RCfuK1NfVgmT1NTe28VESrMqsrS+DswIbIgOt4wibQdnOU4zvxBnCrewDU
	 i5CzemC3+37Wg==
Date: Tue, 7 Oct 2025 12:10:09 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jonathan Curley <jcurley@purestorage.com>,
	Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>, linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4/flexfiles: fix to allocate mirror->dss before use
Message-ID: <aOU7Yc8RnF4Eq65C@kernel.org>
References: <20250924162050.634451-1-jcurley@purestorage.com>
 <aOUeDCzouBMwjalF@kernel.org>
 <aOUonNQRjYBpYcrD@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOUonNQRjYBpYcrD@kernel.org>

Move mirror_array's dss_count initialization and dss allocation to
ff_layout_alloc_mirror(), just before the loop that initializes each
nfs4_ff_layout_ds_stripe's nfs_file_localio.

This resolves dangling nfsd_serv refcount issues seen when using NFS
LOCALIO.

Fixes: 20b1d75fb840 ("NFSv4/flexfiles: Add support for striped layouts")
Signed-off-by: Mike Snitzer <snitzer@kernel.org>

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index fedd7d90e12f..364e16708ca7 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -270,7 +270,8 @@ ff_layout_remove_mirror(struct nfs4_ff_layout_mirror *mirror)
 	mirror->layout = NULL;
 }
 
-static struct nfs4_ff_layout_mirror *ff_layout_alloc_mirror(gfp_t gfp_flags)
+static struct nfs4_ff_layout_mirror *ff_layout_alloc_mirror(gfp_t gfp_flags,
+							    int dss_count)
 {
 	struct nfs4_ff_layout_mirror *mirror;
 	u32 dss_id;
@@ -280,6 +281,12 @@ static struct nfs4_ff_layout_mirror *ff_layout_alloc_mirror(gfp_t gfp_flags)
 		spin_lock_init(&mirror->lock);
 		refcount_set(&mirror->ref, 1);
 		INIT_LIST_HEAD(&mirror->mirrors);
+
+		mirror->dss_count = dss_count;
+		mirror->dss =
+			kcalloc(dss_count, sizeof(struct nfs4_ff_layout_ds_stripe),
+				gfp_flags);
+
 		for (dss_id = 0; dss_id < mirror->dss_count; dss_id++)
 			nfs_localio_file_init(&mirror->dss[dss_id].nfl);
 	}
@@ -507,17 +514,12 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 		if (dss_count > 1 && stripe_unit == 0)
 			goto out_err_free;
 
-		fls->mirror_array[i] = ff_layout_alloc_mirror(gfp_flags);
+		fls->mirror_array[i] = ff_layout_alloc_mirror(gfp_flags, dss_count);
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

