Return-Path: <linux-nfs+bounces-10849-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF997A706A0
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 17:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723331778E8
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 16:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84055253B62;
	Tue, 25 Mar 2025 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaBSJ6et"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCB81B392B
	for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919468; cv=none; b=uYYVgDnY9XtBfMUVJ4SE29e7SNSvfMl4ouWhseAbKyw3+JdHjPmyr3O7/T600jWhP+NQwYbVLvzkPPbwmFRu1E1wsiBvZvHUYsWzUO26wMfYZOQwEX+XInaG9ExvxyCwiuHC/Iiw6uZgMdBw3eRyLTroRAtHKNXPl03O55sxV10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919468; c=relaxed/simple;
	bh=8JCxl4LWyqCt+F5GlZBDc7rXaOPF4L2wNED+Yh7B7u8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KKj3S1BI+iM0aVprWHN4bzQOxqZcsTLduw1ss3SQPJqxd1lhNSpm6Tnir7VjiFzKk9YJOCJGJFkFf+9GcLqwGbCxji1jexQomS2uG8SdCCxh8y0k2SV/grqP8cXUCj81Q/QKfhqdd0kACJNHIw3Xb55Fm6aUpLVK8R8q/kOaCxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaBSJ6et; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBCAC4CEEA;
	Tue, 25 Mar 2025 16:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742919467;
	bh=8JCxl4LWyqCt+F5GlZBDc7rXaOPF4L2wNED+Yh7B7u8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NaBSJ6etwLxtkhlcTAGW1g8sA9MPIU76mVdWkAtlomQ3yrsnlZbGkTRmufLjBz2VN
	 3kSD+WJbDBRidAKD5Ar12DH6nzKXx7dpk2X7ICd62yaYJoG5Ql9GLixt0YK6B9Aj+z
	 nAaKFMoSG78ICW+HqSji1BxAFX8DQH9ecD7wKYNnO7hStvqg4uBNssvEK9jRvkVO2A
	 FFbwJJmQKO5z51X5wZ/uK0vbZacdbU5CWWB80RDCKhjXO9FidqZKwLPVIWyKqyiLZ+
	 HVwAUAFLD9DaNCxWThQcAwS0LsoJ2FmQIRQ33hcx4Y5Xa7XfbMasETWAa3r3ZBYVDu
	 GIAkOQZZCNsfw==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 4/4] NFSv4: Treat ENETUNREACH errors as fatal for state recovery
Date: Tue, 25 Mar 2025 12:17:44 -0400
Message-ID: <b1989a8316da4dcaaaaedad3b9d234d212be1083.1742919341.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1742919341.git.trond.myklebust@hammerspace.com>
References: <cover.1742919341.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If a containerised process is killed and causes an ENETUNREACH or
ENETDOWN error to be propagated to the state manager, then mark the
nfs_client as being dead so that we don't loop in functions that are
expecting recovery to succeed.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4state.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 738eb2789266..14ba3f96e6fc 100644
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
2.49.0


