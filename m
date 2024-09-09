Return-Path: <linux-nfs+bounces-6342-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9A9971C35
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 16:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94586B22555
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 14:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F891B5828;
	Mon,  9 Sep 2024 14:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAxlQdNe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B435411712
	for <linux-nfs@vger.kernel.org>; Mon,  9 Sep 2024 14:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725891323; cv=none; b=DBxLxcI5pftHCcd3DtqAO8ptd593YksnVt14qVp9NL+CGCr0+DhS7jv7so4FR9/evs44OZqEYxjzESSQ/s1LVoF0S4+SLTvq0Yaq+UgCrbA/G8LfWjzKYcu9jOKJbjIjkrGPTFEGFiBe2nMSD95R9w+xE7nPE3q/Ej9eZsdPewo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725891323; c=relaxed/simple;
	bh=tgDNA+ztFgSyqqZU3JwTpu2E7+iNhJZ+8NC8kVk2+S4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gmxa17mGbEJiFva1m02X66sEmXq/YBZai0RUPZ2+g3RI4ZsWPqDhd1W9/HTsrFtLLZUYHWeFYQd60Lkb+taE3fyoUh8gxSrKrQD/qqN92e6gYYgTE3dmBW/GGiVVrct0LB1fw11wthP1TAC2TOuazRlc6wzXJR+dvzsHyP0DhJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAxlQdNe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA107C4CEC5;
	Mon,  9 Sep 2024 14:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725891323;
	bh=tgDNA+ztFgSyqqZU3JwTpu2E7+iNhJZ+8NC8kVk2+S4=;
	h=From:To:Cc:Subject:Date:From;
	b=GAxlQdNeuDCweQQ2JrMV6Jj5kMegmPVbRJwOCt30dnAMVxlDh56fZ4IZYYVEbQRzu
	 oE+JSF0/OJjDutZSPK3+EEvu7jkMWKh37ti1fJVlWb9/YjyD+heiGsSBq265uq1alA
	 N6YHUZuKfR92UeAXI1mV3MlnJzQffvWXv/RKNrgtHE8OHSqDg/sQtghNG+lu0B5I9l
	 2M3qHcUGBDH1T4bUBYiuo2G668v/TMzEZDN+14BUD/q8WIxg743HDenS8ZXW9LTtY0
	 vPqlzmbuRfQW+7xglYtOEiJW9r+2nkC3TeQsW/tIBR8DNotyDVgBBCkkdtk3aBXXER
	 pP3ZQ9GrzGHPQ==
From: cel@kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] NFSD: Fix nfs4_delegation_stat()
Date: Mon,  9 Sep 2024 10:15:16 -0400
Message-ID: <20240909141516.64363-1-cel@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The xfstests workflow on NFSv4.2 exhausts the capacity of both the
main and scratch devices (backed by xfs) about half-way through
each test run.

Deleting all visible files on both devices frees only a little bit
of space. The test exports can be unshared but not unmounted
(EBUSY). Looks like unlinked but still open files, maybe.

Bisected to commit c495f65ad2ff ("nfsd: fix initial getattr on write
delegation")

Ensure nfsd_file objects acquired by find_rw_file() are released.

Fixes: c495f65ad2ff ("nfsd: fix initial getattr on write delegation")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

Tested, problem no longer reproducible. I intend to squash this into
c495f65ad2ff.

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 252297b98a2e..cb5a9ab451c5 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5920,6 +5920,7 @@ nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
 {
 	struct nfsd_file *nf = find_rw_file(dp->dl_stid.sc_file);
 	struct path path;
+	int rc;
 
 	if (!nf)
 		return false;
@@ -5927,11 +5928,12 @@ nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
 	path.mnt = currentfh->fh_export->ex_path.mnt;
 	path.dentry = file_dentry(nf->nf_file);
 
-	if (vfs_getattr(&path, stat,
-			(STATX_SIZE | STATX_CTIME | STATX_CHANGE_COOKIE),
-			AT_STATX_SYNC_AS_STAT))
-		return false;
-	return true;
+	rc = vfs_getattr(&path, stat,
+			 (STATX_SIZE | STATX_CTIME | STATX_CHANGE_COOKIE),
+			 AT_STATX_SYNC_AS_STAT);
+
+	nfsd_file_put(nf);
+	return rc == 0;
 }
 
 /*
-- 
2.45.2


