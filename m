Return-Path: <linux-nfs+bounces-11454-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6F8AAAE87
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 04:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F62C465340
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 02:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF8E38DB72;
	Mon,  5 May 2025 23:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/NVT//e"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1412B35B92E;
	Mon,  5 May 2025 22:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485841; cv=none; b=DMJ4g3gibpUJ2fIh2tfpHXnoY/hHjth0AYJr8X5l02SVeB1+7KvTZg7PJN+qjJIggLJMWuJKStkqjhtd7kPVq2CbM2lqhwMs23isc+cxSghxAYudji3JiTytElffByCslehO3gCRqcfLZjKjnrAo1gOPodo6AdoVQvgMW3Sq1/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485841; c=relaxed/simple;
	bh=r0BFMOQNK5XzDChbKZz77n0K6xWYlsbv5PIyw+Iw7nI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iRx0u2g46L1bnrt7hvf9juwpa9APeHSwWcJ+ZTdEpT+MhW/EY9c2fuVd2udYiOcCb/KgIDA4qMTWHSpc/a29zas08+CYx+7PJ0nTeAsRbtmGT7jtLxA7VrE2mkF2tjETFj1WRko6Nflxamy1I7/G/FftdsNS0eHyCVgTr87yVfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/NVT//e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C4CC4CEF3;
	Mon,  5 May 2025 22:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485839;
	bh=r0BFMOQNK5XzDChbKZz77n0K6xWYlsbv5PIyw+Iw7nI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f/NVT//e3Qo6tCHYaadeH/0gB+/gyff4Tv8DhhWPNVwiw1A8BWloA11mHFKxsPXFB
	 86p9GpotQdfC4hnmojbRYP1s7LSNjIhXwGR/SSXKZPbkY/0JqwDTHI383rU2V3/HHp
	 w+IgKRqXCY5MGUDq6sirbMnU+tHmAdGFwvsBHhYapwXz+RP8Sk0SKyHDFLfQij4oTN
	 2UrC+jLkwXZF+xPriq+ekJ+9OWFsxbm63L1mTNX671hxse0vijQ7nx6WPJGg8sQJrM
	 0AVIuz0GXrfjCZTY7NRtsMGl3oLYeAxGjMXy8ALAFsGfrqwx9bo0nDnexfaiODNbwc
	 U26nQFf9fs+Gg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Jeff Layton <jlayton@kernel.org>,
	Benjamin Coddington <bcodding@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 022/294] NFSv4: Treat ENETUNREACH errors as fatal for state recovery
Date: Mon,  5 May 2025 18:52:02 -0400
Message-Id: <20250505225634.2688578-22-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit 0af5fb5ed3d2fd9e110c6112271f022b744a849a ]

If a containerised process is killed and causes an ENETUNREACH or
ENETDOWN error to be propagated to the state manager, then mark the
nfs_client as being dead so that we don't loop in functions that are
expecting recovery to succeed.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4state.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 794bb4aa588d3..9fc71dc090c25 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2741,7 +2741,15 @@ static void nfs4_state_manager(struct nfs_client *clp)
 	pr_warn_ratelimited("NFS: state manager%s%s failed on NFSv4 server %s"
 			" with error %d\n", section_sep, section,
 			clp->cl_hostname, -status);
-	ssleep(1);
+	switch (status) {
+	case -ENETDOWN:
+	case -ENETUNREACH:
+		nfs_mark_client_ready(clp, -EIO);
+		break;
+	default:
+		ssleep(1);
+		break;
+	}
 out_drain:
 	memalloc_nofs_restore(memflags);
 	nfs4_end_drain_session(clp);
-- 
2.39.5


