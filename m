Return-Path: <linux-nfs+bounces-10790-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133ECA6E7BD
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 01:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46788175883
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 00:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3247BAD51;
	Tue, 25 Mar 2025 00:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OByzaeD3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC6E149C6F
	for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 00:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742863603; cv=none; b=Zi/H3dh3A2iYWgOzE477CrVZ7IGJYNH5Vof3EOahpOSvVWFXob1jM4aji70U3+OASJ+mqnekJIPcWr9MDkn9Sy7h8ZE5FJYtFuItYPeokd2KLcIGwmDzZmgGBNcwGv1lsEEqme0fQSi8vstZJeyO7tIDzwAZYC1R54bTaPQsJy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742863603; c=relaxed/simple;
	bh=UFB3jUwcCxDUXVdknAFj4Uw6pT1TD0qSPXu/fNHud/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QdsYMPRNgNKGQ9Z+CuCF9JP0SCGPb3wc2EGP4a2ULNWCaWhbV20obg3/4eL//WPXUs981C5KptJCEqGBDRl9fOh9pYlJTwZcVMYMM0WPR14AIWPKWxBOCRe376tMwQC8ZrdJque/ld7QA/8zySwiu8lqvfyIZE0SV0V0v5QZG2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OByzaeD3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DBEC4CEED;
	Tue, 25 Mar 2025 00:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742863602;
	bh=UFB3jUwcCxDUXVdknAFj4Uw6pT1TD0qSPXu/fNHud/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OByzaeD30dSu668EhJGDCLwEIvtHzB2HXT0Onkp+Izmsi9vqeN1pMYHnOKnXX9r1g
	 tXg4XGrCWjWJT2roHECf/XaxqfkeUEkJgaSA6WvFzN3F66OFNF5FzKWPrQ9gZi4qrM
	 eSKjMPHRpxul5ZEzlIx6NDyEWL/A01SJwXjglKdZgGIBk9GahKUVWJPlx0GfzL3oew
	 R2J8167bHweHvuZh2e19eVbS4IZol1FJfSJhq7o/3V0lynaEJMTo5Kw9clNplInNbC
	 F2ViF/JdIepyC7Vzf1xqjqNowoBktWchJ95HZJ43ufGtD7aSkQwKUAeBmmL8hJYVcv
	 HHOmmUkEkvZ7A==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 3/4] NFSv4: clp->cl_cons_state < 0 signifies an invalid nfs_client
Date: Mon, 24 Mar 2025 20:46:38 -0400
Message-ID: <56bc4d7e614a6d9d0aa520c71bd0ffb102e3ef08.1742863168.git.trond.myklebust@hammerspace.com>
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

If someone calls nfs_mark_client_ready(clp, status) with a negative
value for status, then that should signal that the nfs_client is no
longer valid.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4state.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 542cdf71229f..738eb2789266 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1198,7 +1198,7 @@ void nfs4_schedule_state_manager(struct nfs_client *clp)
 	struct rpc_clnt *clnt = clp->cl_rpcclient;
 	bool swapon = false;
 
-	if (clnt->cl_shutdown)
+	if (clnt->cl_shutdown || clp->cl_cons_state < 0)
 		return;
 
 	set_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state);
@@ -1403,7 +1403,7 @@ int nfs4_schedule_stateid_recovery(const struct nfs_server *server, struct nfs4_
 	dprintk("%s: scheduling stateid recovery for server %s\n", __func__,
 			clp->cl_hostname);
 	nfs4_schedule_state_manager(clp);
-	return 0;
+	return clp->cl_cons_state < 0 ? clp->cl_cons_state : 0;
 }
 EXPORT_SYMBOL_GPL(nfs4_schedule_stateid_recovery);
 
-- 
2.49.0


