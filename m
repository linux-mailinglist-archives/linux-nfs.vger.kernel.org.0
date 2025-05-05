Return-Path: <linux-nfs+bounces-11465-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C10C4AAB041
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 05:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF8511892A83
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 03:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02026286D5B;
	Mon,  5 May 2025 23:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="achvxy+T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AB03B96ED;
	Mon,  5 May 2025 23:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487323; cv=none; b=gPPfTg/l2ZbE0pjBiDu6XjVAygaKUH3vkyako8KxGbVqoQhX7NTCiwgZFmFpCxYaLyqlGcJxtnTdYyDUEbHsBI6uznwlg2XDWfqFoCkeP9nigtvwpJUCpEJnpuzbyoGOW2Qx15xytG2Ufgx7Qa8IHLqvfpHZTGPH1eIP7TXn8Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487323; c=relaxed/simple;
	bh=0ykm/0vK3HhFGgPGriruaUJgrWRvgzXlTZAKnX0DZnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UuPxEBBcScXJcgkmkG6A7A1swctj963guZ3jW6H2OwX4ksSV79CG+t6MNAD/bH7tieRwPNi8Cm2zAn6yurK7iKIsh1mNSx+b5w+T/7Gcldq5QCtemXzphAdiOh2vOOQKy/bUHAMOL1rnYFtUqbH6xWGLKSRYOtwDKeSBgKJV/Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=achvxy+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4EFC4CEF1;
	Mon,  5 May 2025 23:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487322;
	bh=0ykm/0vK3HhFGgPGriruaUJgrWRvgzXlTZAKnX0DZnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=achvxy+TRKPz10bFXeJTAUE53bFh3xFBD/C44elSHRoQ25KqLDk2Kpl7+9c+vhfgt
	 ZcR/1zZIjZePrVKgwy++vaBKLmeYeTuS9XM9rZD49R7QGI1ddwpIqFOjf0PwZSyc7L
	 K4wbKdiZLnU3sG3Th7Sz1nwdjuDR0m/cOXwMWY+rp9o5CXVWJD0OteOFPxTRkPfc3W
	 tA2yhICYySvCjGyl+pfYe0UpmlK588iZgEL1BRmzVkhZg563lSQsCUNUFwJlQkEXCO
	 r91rov3qqtgX+plKuuUPNUkhGmIg/cKIRS5WBeUJoHXVVOWZNnXwe8uB4XSLTrUeVS
	 z58YcvODjW4jw==
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
Subject: [PATCH AUTOSEL 5.4 05/79] NFSv4: Treat ENETUNREACH errors as fatal for state recovery
Date: Mon,  5 May 2025 19:20:37 -0400
Message-Id: <20250505232151.2698893-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
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
index 1d38484e0a53b..b64a3751c3e4a 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2655,7 +2655,15 @@ static void nfs4_state_manager(struct nfs_client *clp)
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


