Return-Path: <linux-nfs+bounces-13015-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D560DB034D6
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 05:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 397293B3A57
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 03:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DE72E3713;
	Mon, 14 Jul 2025 03:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkQEQZRq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40141D7E5C
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 03:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752462847; cv=none; b=M0h6l6wSXUiscHvRwsMelfQY040uSdb/XWdg6VyNlm3JYTKkFq12vWBWdl+kLkis/so6i4mU2u5K9tADsdIbUgC+tmkc3H8/26sdht07ntJBYPujog23U8cnbXR2gbxZ2YCGIe0e4shZWIOLrbnJsRD5fl2VaUB7l8/2DrQkjj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752462847; c=relaxed/simple;
	bh=hH1Rv6CYGGFvsjBpeyk4mC/I6SBkykcszOjIlV412bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wp/Ta0ShhjtKml/Ig0DQmHU71ZlpgNGPHoB/Z7dOJozT1NNAy09aVxrcN1XmaHWbdoXBoB7XOG0H1iYU5boYINxFvgc3YnLvWhqUwt4sI0h/MgjlGiwBp8I2b4J1wCe62R5PdcfW8NV7wuV2muBIWs4/4MSh2eRUxYQ3Li6IbUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkQEQZRq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2635EC4CEE3;
	Mon, 14 Jul 2025 03:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752462847;
	bh=hH1Rv6CYGGFvsjBpeyk4mC/I6SBkykcszOjIlV412bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lkQEQZRqPKUkOkmdGPPdwvnbehH2AChsSpEszQnatV4Oq5J6UpV7SJbdX+lPpkNvr
	 H4IYV42LXyy+qUBcGAFrH74tj7FZpa9wRLTL+ZnLTr+VD15CwQc4VD5Bgo7gdb1hkA
	 ra4YVOPmKjm3RjMIu7VcZijtytlA6CSPJFZ5VqpmWz1eLR1w/NS/j4Gx0fTtd5R2xA
	 3PDAcBv5Gk2l0DJOPAkkai+ik6SRFIbyCHX1oSArEHRoDZ3Vc4oXKgYGChG151eumi
	 zxI6yjigqiK+ysE/SjaJd/WqNjyN3dnDNaLUKzdXSY0EVN+vlK+Z804cZcXGLWtPbJ
	 KNIDXqyVg/e7A==
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>
Cc: linux-nfs@vger.kernel.org
Subject: [for-6.16-final PATCH 4/9] Revert "nfs_localio: duplicate nfs_close_local_fh()"
Date: Sun, 13 Jul 2025 23:13:54 -0400
Message-ID: <20250714031359.10192-5-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250714031359.10192-1-snitzer@kernel.org>
References: <20250714031359.10192-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 23adb30505afe36b3e587a9074c3288de3c7e583.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs_common/nfslocalio.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index 49c59f0c78c6..503f85f64b76 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -171,26 +171,7 @@ static bool nfs_uuid_put(nfs_uuid_t *nfs_uuid)
 
 	/* Walk list of files and ensure their last references dropped */
 	list_for_each_entry_safe(nfl, tmp, &local_files, list) {
-		struct nfsd_file *ro_nf;
-		struct nfsd_file *rw_nf;
-
-		ro_nf = unrcu_pointer(xchg(&nfl->ro_file, NULL));
-		rw_nf = unrcu_pointer(xchg(&nfl->rw_file, NULL));
-
-		spin_lock(&nfs_uuid->lock);
-		/* Remove nfl from nfs_uuid->files list */
-		list_del_init(&nfl->list);
-		spin_unlock(&nfs_uuid->lock);
-		/* Now we can allow racing nfs_close_local_fh() to
-		 * skip the locking.
-		 */
-		RCU_INIT_POINTER(nfl->nfs_uuid, NULL);
-
-		if (ro_nf)
-			nfs_to_nfsd_file_put_local(ro_nf);
-		if (rw_nf)
-			nfs_to_nfsd_file_put_local(rw_nf);
-
+		nfs_close_local_fh(nfl);
 		cond_resched();
 	}
 
-- 
2.44.0


