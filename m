Return-Path: <linux-nfs+bounces-11473-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E2FAAB4BC
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 07:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24A9D1BA0276
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 05:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A2B38DC05;
	Tue,  6 May 2025 00:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CY8aU0no"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB322F2C50;
	Mon,  5 May 2025 23:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486822; cv=none; b=LpPvATkVDMU4IE9GZZOx9W81ivfBqL4Xz1+N85CaQ4Mea7JqnIaBa4SojQ8hxqo3x6kWAC5GdWIch5ocW/V0UlcltopT17ol6aznBndOgu4q9tohufFFGACa482Fj2De4LKCA2U3oj4JHDmP8QR9BOQ9Jyuu9T/jMi/5yIG9cvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486822; c=relaxed/simple;
	bh=ispatKRpWlb5wfrhSPJHXYIpR4sWJYMrjMX2BIsRmNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XEyFjJ2KoRAPuZd7PX6VWR9HWqjJMvKT6zuN0na5IRZivs2Bt1hsFxPHfRHza7UR2AwX6cLCIApHZSQaMKgNOnCo4QFbGwYMeb3MjNKIS1NJcLzKI5CF3qLOYKF8TUbNJiuoKo0yysW3Py/kkfkDf/edeLaZ7dwKaK/xZ4LFGgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CY8aU0no; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26294C4CEE4;
	Mon,  5 May 2025 23:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486822;
	bh=ispatKRpWlb5wfrhSPJHXYIpR4sWJYMrjMX2BIsRmNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CY8aU0no5bSkunUbHlkHAEW/YSrnKhspmmBKFnyKYWFpoh5fCwMWrpWBG36AxX9G+
	 +dPbiNQandXD0jy7l7t1O+Syr2vYrtZIhoZJ1cmUWJkOsLmF/mi5y2t35OU+LFoTvV
	 DCcpJssXlG8dawqo4q0wGEWYKn9v+hTiLB52WzA4yXd9p61OL2cOubffC+RYAh8OsV
	 u2wQI5o55AbB+V97zDC2xt3Vx7GFphVC4/SXtfjDrhQWZsVyPf4M9gk2qeokzsIMTe
	 Hgwo0ve7PJ9Gk3f8UHZpLLiHhvkPHLQ3XhB0wDK0cHsCKG/Pqd8l9uplddQA8fSSs0
	 FG11lWpnaBMNw==
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
Subject: [PATCH AUTOSEL 5.15 008/153] NFSv4: Treat ENETUNREACH errors as fatal for state recovery
Date: Mon,  5 May 2025 19:10:55 -0400
Message-Id: <20250505231320.2695319-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
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
index 76e2cdddf95c1..b1dec7a9bd723 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2726,7 +2726,15 @@ static void nfs4_state_manager(struct nfs_client *clp)
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


