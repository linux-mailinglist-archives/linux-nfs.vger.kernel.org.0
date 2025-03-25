Return-Path: <linux-nfs+bounces-10791-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8873A6E7BE
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 01:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 470C2175A53
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 00:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEB2149C6F;
	Tue, 25 Mar 2025 00:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSiZmkiF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9804E14EC46
	for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 00:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742863603; cv=none; b=NNdwxkKTPMM7ZFkUOKWWONLq1Pjc2lsTtsprWsECeZe3hXv7sicIeKwMnRDf349zUZqrTG5t016wiz0KC/1cKYA3coU3RVIU43rQRiDlvHvTugE9ytm0PUFSL2/IAh4rZ45UM0mFNLhiBmZiee9DeE6EZtuNIs9PdSmw+Wi7ZNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742863603; c=relaxed/simple;
	bh=Kfgauw/EnVYAo8cJqBMjHtRC4yvf+AskOEsKx0CG9X8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmwzl98LqNZXHf+yjG+pGcaiAj0XJ44p3ny+W7VtmU6KbmXAjG5yoXVIS7L1s6ewEPEgCz0vrNvNgef4msy/P6QH+2sAZ2BcRDnEyqb1cB5MOGWL25gpWxVvMmwHCuMUbw7XQ1Eqnn6HbURWX42jnUra2XeuuCdT+NzA2FRT7wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSiZmkiF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C69BC4CEDD;
	Tue, 25 Mar 2025 00:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742863603;
	bh=Kfgauw/EnVYAo8cJqBMjHtRC4yvf+AskOEsKx0CG9X8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lSiZmkiFjViUoCCppJa13zPplDoF0MagWWzCOVgZcq0r3bL+22e4tFLpiwvU23YxR
	 nNlN2BEbR7b/TK01K5bTr81S0HvjizuFUVfV5WsrvfgRaWImkHDoXFefirGEQ7HEF0
	 raup+DGdEwMKhepWMmCWnUXPhxJAUMpbTACINPTA/wrFv8ERuAclgjWzdWtbPLqcjC
	 OYdrtlIEhR/JYzHTvx6y/NFmqDrb2OkJZO4Nb9lqXgZLrVQRQrrcDwQhW1mb8uGbjG
	 1f+yZzRj6Ar2FQTiX0QlRVR/jIs000/DZGxipxskERSmHCNl1fPRJJOFDqj7ARelcX
	 D3FJNEMDVcDjw==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 4/4] NFSv4: Treat ENETUNREACH errors as fatal for state recovery
Date: Mon, 24 Mar 2025 20:46:39 -0400
Message-ID: <4855d263e403a8b56738f2f630954348718d7cc5.1742863168.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1742863168.git.trond.myklebust@hammerspace.com>
References: <cover.1742863168.git.trond.myklebust@hammerspace.com>
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
index 738eb2789266..629578dd4a42 100644
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
+		nfs_mark_client_ready(clp, status);
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


