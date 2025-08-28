Return-Path: <linux-nfs+bounces-13933-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B58B39F24
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Aug 2025 15:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 132553A4C8A
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Aug 2025 13:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D481E25F9;
	Thu, 28 Aug 2025 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="AT6UUkrW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [131.169.56.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843A51A0B0E
	for <linux-nfs@vger.kernel.org>; Thu, 28 Aug 2025 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756388333; cv=none; b=s9WbnQJOUW0PLzn17LB2eII9AejmGLL0NzpwV/iR3H91I/AHGUiDb4zogxJuHCCJAiAbiBc6Yzj+KMj4pa5quyzEk99n/d1iMVVq2U863zdy/kCqWqGlzgtP576PyYHOvb5zMnQjIgYBCLJx8TzmeZI4o1P95tc0aAMbD6ff0yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756388333; c=relaxed/simple;
	bh=KAxHqGTUvMrl8VMtqmnOWwiFb+GhaiK+6NYek8RBnR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qgWJcSNg1og/emgsncwqR3jK1bdwf+A+ZZwHUpRUqgrOI1ZgPgXjWhW8t+0J4xhZQ6+uRbDmi00kqimNmKO3VFFq0LbeojfaRz5wYFGE22t4kL/rEQTvxCVxZnQabyEGz4pGqYMwPYaG3L/sG+BXURIZYNS46lb783ncAG6NIwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=AT6UUkrW; arc=none smtp.client-ip=131.169.56.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [131.169.56.164])
	by smtp-o-2.desy.de (Postfix) with ESMTP id 8A11013F651
	for <linux-nfs@vger.kernel.org>; Thu, 28 Aug 2025 15:38:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 8A11013F651
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1756388327; bh=7ETVXkyNIFCrKQg7HDWEotkB4Tmg8rlojqR8o2eEkBA=;
	h=From:To:Cc:Subject:Date:From;
	b=AT6UUkrWwcfNuvYoKoaQQczWTUJj8FMGJgzS1mza6NL5Yqw7utFlDlO//3nN27Dng
	 qlB4xPTQCv7bYYLdJFG6h8TM0liXDkGNuyNMDZ2MY6sbewOBEQ3g38AWCdWDY/oNKd
	 F6YM7PBOYTgcBrD7msTNHdqtHgAlyA7Zg6DyYtVA=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [131.169.56.130])
	by smtp-buf-1.desy.de (Postfix) with ESMTP id 7C6F820056;
	Thu, 28 Aug 2025 15:38:47 +0200 (CEST)
Received: from b1722.mx.srv.dfn.de (b1722.mx.srv.dfn.de [IPv6:2001:638:d:c302:acdc:1979:2:e7])
	by smtp-m-2.desy.de (Postfix) with ESMTP id 7167416003F;
	Thu, 28 Aug 2025 15:38:47 +0200 (CEST)
Received: from smtp-intra-1.desy.de (smtp-intra-1.desy.de [131.169.56.82])
	by b1722.mx.srv.dfn.de (Postfix) with ESMTP id DB02C160059;
	Thu, 28 Aug 2025 15:38:45 +0200 (CEST)
Received: from fedora.fritz.box.de (VPN0473.desy.de [131.169.254.218])
	by smtp-intra-1.desy.de (Postfix) with ESMTP id 8C34180046;
	Thu, 28 Aug 2025 15:38:45 +0200 (CEST)
From: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
To: trondmy@kernel.org,
	anna.schumaker@oracle.com
Cc: linux-nfs@vger.kernel.org,
	dan.carpenter@linaro.org,
	Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Subject: [PATCH] flexfiles/pNFS: fix NULL checks on result of ff_layout_choose_ds_for_read
Date: Thu, 28 Aug 2025 15:38:43 +0200
Message-ID: <20250828133843.1057488-1-tigran.mkrtchyan@desy.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent commit f06bedfa62d5 ("pNFS/flexfiles: don't attempt pnfs on fatal DS
errors") has changed the error return type of ff_layout_choose_ds_for_read() from
NULL to an error pointer. However, not all code paths have been updated
to match the change. Thus, some non-NULL checks will accept error pointers
as a valid return value.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Fixes: f06bedfa62d5 ("pNFS/flexfiles: don't attempt pnfs on fatal DS errors")
Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 8dc921d83538..258158dfd557 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -804,7 +804,7 @@ ff_layout_choose_best_ds_for_read(struct pnfs_layout_segment *lseg,
 	struct nfs4_pnfs_ds *ds;
 
 	ds = ff_layout_choose_valid_ds_for_read(lseg, start_idx, best_idx);
-	if (ds)
+	if (!IS_ERR(ds))
 		return ds;
 	return ff_layout_choose_any_ds_for_read(lseg, start_idx, best_idx);
 }
@@ -818,7 +818,7 @@ ff_layout_get_ds_for_read(struct nfs_pageio_descriptor *pgio,
 
 	ds = ff_layout_choose_best_ds_for_read(lseg, pgio->pg_mirror_idx,
 					       best_idx);
-	if (ds || !pgio->pg_mirror_idx)
+	if (!IS_ERR(ds) || !pgio->pg_mirror_idx)
 		return ds;
 	return ff_layout_choose_best_ds_for_read(lseg, 0, best_idx);
 }
@@ -868,7 +868,7 @@ ff_layout_pg_init_read(struct nfs_pageio_descriptor *pgio,
 	req->wb_nio = 0;
 
 	ds = ff_layout_get_ds_for_read(pgio, &ds_idx);
-	if (!ds) {
+	if (IS_ERR(ds)) {
 		if (!ff_layout_no_fallback_to_mds(pgio->pg_lseg))
 			goto out_mds;
 		pnfs_generic_pg_cleanup(pgio);
-- 
2.51.0


