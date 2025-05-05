Return-Path: <linux-nfs+bounces-11442-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F65FAA9F58
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 00:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 288301890989
	for <lists+linux-nfs@lfdr.de>; Mon,  5 May 2025 22:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D530281513;
	Mon,  5 May 2025 22:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBXFBUcQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E91280CEA;
	Mon,  5 May 2025 22:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483322; cv=none; b=a8/A7RdKArcB9E17xDbwRbzmg7youBQKnmOzzx+9gVLLz2BFF7WlJcqEm7Hr/dH+b6SOF+OhXzLR7ZwqR99YrC/Z+pctgdj+p5niNUFTFK9FAJPfi+DMiaXbcR57BTZR3P0jEI21jQwNqOXobElGU3cOG4fuByXpXuV2Pyjv/JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483322; c=relaxed/simple;
	bh=56aH40xul6RSzMnF6aY9vs1FeAPbJlSX860QCYvQkPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uaa3F3BjSsoaDZLXyGQkkhvsz5i08Fw8VXxcx/2kWBW1xnBGWMAQjaRsWxQP3f6G1RkPnKCvdQB6eNsqObwz7r9y6OpkcYJMAuIj2FYPvrb3WCNi7MkH5/+7gBFq1g0mtnnvsnxiqv4X/0b/+HGSjehtm7VVDv2HDa+QfV8kCqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qBXFBUcQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F28C4CEEF;
	Mon,  5 May 2025 22:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483321;
	bh=56aH40xul6RSzMnF6aY9vs1FeAPbJlSX860QCYvQkPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qBXFBUcQGKT6kmUHh3LtH8f8/2pzlPMZw3LLh0bCoTLONVHc0fHpH4yRgs/lGF19d
	 7AYIQ64lMM0o9I1ckMXiaTkVVswFnRJwhdt/8z7yBIUCVmdClDNw/8sCKli8VW39lk
	 h6CT2zyW5GOZL9IupXm5TpFdi2jcRQI0+UKS0TELSSYW1eIKhYw9CSrP+BVZedOty+
	 OR1QcHWbL3u0nQk4lloIO7TWhUXF021fQ4nqM0syJ31DhQF+Xof0uRGpO7jsqSgC+d
	 b9gWi3B5lPsLyxTWoEAOgCooAbzLr1bNWUit7oZVKDKpwqCA7cUY/rLkBY5z+K6PT+
	 1ntlCtMJS1UIQ==
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
Subject: [PATCH AUTOSEL 6.14 032/642] NFSv4: Treat ENETUNREACH errors as fatal for state recovery
Date: Mon,  5 May 2025 18:04:08 -0400
Message-Id: <20250505221419.2672473-32-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index 542cdf71229fe..04c726cc2900b 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2739,7 +2739,15 @@ static void nfs4_state_manager(struct nfs_client *clp)
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


