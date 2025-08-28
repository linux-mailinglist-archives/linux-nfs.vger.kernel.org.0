Return-Path: <linux-nfs+bounces-13935-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D25B3A2D6
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Aug 2025 16:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBCBB5669E6
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Aug 2025 14:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151F4238C03;
	Thu, 28 Aug 2025 14:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="j38oK2r9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [131.169.56.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EA3313544
	for <linux-nfs@vger.kernel.org>; Thu, 28 Aug 2025 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756392670; cv=none; b=Y0BXkzDaKO8cv6dOL7cX2T9+tQFHQZfj/XvvtHQQUhy2uGdvyM1XlqeR1J0zMe2xApY9qUU6I+ubFJ9isbieoU7DEiPiSMt2Bt81cK9njXqTBXb4/lv1uviL4a0oLLexCzU/TfLDNCxtoa0ilXG/DGqQD0VWQQplMPLD2atshEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756392670; c=relaxed/simple;
	bh=dqVv/Z0nmYlT36sGFbjKhED7otNEzFN+96cOppicCCU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nSII9AI2+j5IDxe74beyLtFEiJluIkayw8w6eCbTV10SWkx0IHDG47mcSYiy3cASJAI5L0H5XgTmRW18yT7abva6mJZH7DvKYJ3XqM2EZIW+3IwF7WSy0PMjETVfuWfrYU+YBVunpgoxeHPE9no6BUEhTFv3VvlI5EquJWdaUto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=j38oK2r9; arc=none smtp.client-ip=131.169.56.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [131.169.56.164])
	by smtp-o-2.desy.de (Postfix) with ESMTP id D919013F648
	for <linux-nfs@vger.kernel.org>; Thu, 28 Aug 2025 16:51:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de D919013F648
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1756392664; bh=MNd2e0I6pqKNM9+zAJ9wR0IbSVWDPJGBrOugUahRBAg=;
	h=From:To:Cc:Subject:Date:From;
	b=j38oK2r9aWXPFxcQGlu/9IE0pmWvv8zFaPOSVEqaLwQHCBDJb48sy1R4M4RSPBYHQ
	 W42mFHnfu5IFRw+qkR38n56VWM/8b3OrRPB7ve7gkZfseZ7xk5Lh5z7xQqppAXz12D
	 GGS7C/bpVN2oCY3e90P6wov7iXwTnaw1Br+bzhA8=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [131.169.56.129])
	by smtp-buf-1.desy.de (Postfix) with ESMTP id C987420056;
	Thu, 28 Aug 2025 16:51:04 +0200 (CEST)
Received: from a1722.mx.srv.dfn.de (a1722.mx.srv.dfn.de [IPv6:2001:638:d:c301:acdc:1979:2:e7])
	by smtp-m-1.desy.de (Postfix) with ESMTP id BE38B40044;
	Thu, 28 Aug 2025 16:51:04 +0200 (CEST)
Received: from smtp-intra-2.desy.de (smtp-intra-2.desy.de [IPv6:2001:638:700:1038::1:53])
	by a1722.mx.srv.dfn.de (Postfix) with ESMTP id 62A80320093;
	Thu, 28 Aug 2025 16:51:03 +0200 (CEST)
Received: from fedora.fritz.box.de (VPN0473.desy.de [131.169.254.218])
	by smtp-intra-2.desy.de (Postfix) with ESMTP id 0AE1920044;
	Thu, 28 Aug 2025 16:51:02 +0200 (CEST)
From: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
To: trondmy@kernel.org,
	anna.schumaker@oracle.com
Cc: linux-nfs@vger.kernel.org,
	dan.carpenter@linaro.org,
	Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Subject: [PATCH v2] flexfiles/pNFS: fix NULL checks on result of ff_layout_choose_ds_for_read
Date: Thu, 28 Aug 2025 16:51:00 +0200
Message-ID: <20250828145100.1249014-1-tigran.mkrtchyan@desy.de>
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
Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Fixes: f06bedfa62d5 ("pNFS/flexfiles: don't attempt pnfs on fatal DS errors")
Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 8dc921d83538..f8ab7b4e09e7 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -773,8 +773,11 @@ ff_layout_choose_ds_for_read(struct pnfs_layout_segment *lseg,
 			continue;
 
 		if (check_device &&
-		    nfs4_test_deviceid_unavailable(&mirror->mirror_ds->id_node))
+		    nfs4_test_deviceid_unavailable(&mirror->mirror_ds->id_node)) {
+			// reinitialize the error state in case if this is the last iteration
+			ds = ERR_PTR(-EINVAL);
 			continue;
+		}
 
 		*best_idx = idx;
 		break;
@@ -804,7 +807,7 @@ ff_layout_choose_best_ds_for_read(struct pnfs_layout_segment *lseg,
 	struct nfs4_pnfs_ds *ds;
 
 	ds = ff_layout_choose_valid_ds_for_read(lseg, start_idx, best_idx);
-	if (ds)
+	if (!IS_ERR(ds))
 		return ds;
 	return ff_layout_choose_any_ds_for_read(lseg, start_idx, best_idx);
 }
@@ -818,7 +821,7 @@ ff_layout_get_ds_for_read(struct nfs_pageio_descriptor *pgio,
 
 	ds = ff_layout_choose_best_ds_for_read(lseg, pgio->pg_mirror_idx,
 					       best_idx);
-	if (ds || !pgio->pg_mirror_idx)
+	if (!IS_ERR(ds) || !pgio->pg_mirror_idx)
 		return ds;
 	return ff_layout_choose_best_ds_for_read(lseg, 0, best_idx);
 }
@@ -868,7 +871,7 @@ ff_layout_pg_init_read(struct nfs_pageio_descriptor *pgio,
 	req->wb_nio = 0;
 
 	ds = ff_layout_get_ds_for_read(pgio, &ds_idx);
-	if (!ds) {
+	if (IS_ERR(ds)) {
 		if (!ff_layout_no_fallback_to_mds(pgio->pg_lseg))
 			goto out_mds;
 		pnfs_generic_pg_cleanup(pgio);
@@ -1072,11 +1075,13 @@ static void ff_layout_resend_pnfs_read(struct nfs_pgio_header *hdr)
 {
 	u32 idx = hdr->pgio_mirror_idx + 1;
 	u32 new_idx = 0;
+	struct nfs4_pnfs_ds *ds;
 
-	if (ff_layout_choose_any_ds_for_read(hdr->lseg, idx, &new_idx))
-		ff_layout_send_layouterror(hdr->lseg);
-	else
+	ds = ff_layout_choose_any_ds_for_read(hdr->lseg, idx, &new_idx);
+	if (IS_ERR(ds))
 		pnfs_error_mark_layout_for_return(hdr->inode, hdr->lseg);
+	else
+		ff_layout_send_layouterror(hdr->lseg);
 	pnfs_read_resend_pnfs(hdr, new_idx);
 }
 
-- 
2.51.0


