Return-Path: <linux-nfs+bounces-11656-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786B2AB2878
	for <lists+linux-nfs@lfdr.de>; Sun, 11 May 2025 15:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF5133B9E0E
	for <lists+linux-nfs@lfdr.de>; Sun, 11 May 2025 13:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3511A315D;
	Sun, 11 May 2025 13:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pz2g5Ie+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0C73A1B6
	for <linux-nfs@vger.kernel.org>; Sun, 11 May 2025 13:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746970118; cv=none; b=cOl+NLnwVCUl6hAgpV0IeFaDbKphTj1FID0mOUp8E8helHnWw/nNhD1Dz7e9vkNdBk71EmxeG4WJgFA23ionGIo7bRy7JEpJBp5vGYnANzzzNoVP+Af14Xqr60eMzmHyP6zMCfG3TmoXyb/Sac6WSrc9NWIGzvBazQFPfSafEQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746970118; c=relaxed/simple;
	bh=NU3WHBkvRj06C0joCDifO4hfCy01v9eZD+dlxgziJNc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=c2hY8asLNnWnrNu2fp12hm6Mq3225NP8RRnextLjSUOFnAiLmiDHhYDYZFfVqGHmnSHd9YJHGcJ2Dy0RsCDjyMApynnicyGQ674o5Cu37aaBla1CFE3ouPZNL7PypPh/HgVR5YgowINmVVHndDy+3UwjimNNY4IHqpezZNks6nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pz2g5Ie+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D467C4CEE4
	for <linux-nfs@vger.kernel.org>; Sun, 11 May 2025 13:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746970117;
	bh=NU3WHBkvRj06C0joCDifO4hfCy01v9eZD+dlxgziJNc=;
	h=From:To:Subject:Date:From;
	b=pz2g5Ie+4UuqMH+cWRwg3YTfnfysSJyIpsu1jicUYd6zdJm+3nwQRHj9Qra78rMp5
	 zBf4TJ43Wh+pYT4FWZM0gYFiDcID+vtP+Gylt5UWFHplzznEfkvi5en/6RooJU0Txb
	 V41Az0o0s+wtDYc4GRVWhcN/1bu2WnbVEoFO2t259GmVWz/QgYI66HQbAEE34AN8lJ
	 EWlfNOSLUKaOzkC3TGJLKtbVX4t3l24+EtnWvve1zymNrDEPIUyikkerInTTVUbOhy
	 Q9tLO584BlOR0pKVms4fPziuoLf5WwGypc3CYaUpI9sYay8uVgspg5y/XVCMFm78pj
	 Pf6SRBKFWmXLA==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4/pnfs: Reset the layout state after a layoutreturn
Date: Sun, 11 May 2025 09:28:35 -0400
Message-ID: <956259d72ee10ad81fd49daa8f2daf12644dc50f.1746970063.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If there are still layout segments in the layout plh_return_lsegs list
after a layout return, we should be resetting the state to ensure they
eventually get returned as well.

Fixes: 68f744797edd ("pNFS: Do not free layout segments that are marked for return")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 10fdd065a61c..fc7c5fb10198 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -745,6 +745,14 @@ pnfs_mark_matching_lsegs_invalid(struct pnfs_layout_hdr *lo,
 	return remaining;
 }
 
+static void pnfs_reset_return_info(struct pnfs_layout_hdr *lo)
+{
+	struct pnfs_layout_segment *lseg;
+
+	list_for_each_entry(lseg, &lo->plh_return_segs, pls_list)
+		pnfs_set_plh_return_info(lo, lseg->pls_range.iomode, 0);
+}
+
 static void
 pnfs_free_returned_lsegs(struct pnfs_layout_hdr *lo,
 		struct list_head *free_me,
@@ -1292,6 +1300,7 @@ void pnfs_layoutreturn_free_lsegs(struct pnfs_layout_hdr *lo,
 		pnfs_mark_matching_lsegs_invalid(lo, &freeme, range, seq);
 		pnfs_free_returned_lsegs(lo, &freeme, range, seq);
 		pnfs_set_layout_stateid(lo, stateid, NULL, true);
+		pnfs_reset_return_info(lo);
 	} else
 		pnfs_mark_layout_stateid_invalid(lo, &freeme);
 out_unlock:
-- 
2.49.0


