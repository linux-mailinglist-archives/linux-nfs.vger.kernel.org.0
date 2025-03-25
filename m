Return-Path: <linux-nfs+bounces-10847-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B101A7069D
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 17:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F27D16866A
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 16:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E049C25B690;
	Tue, 25 Mar 2025 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="timsKRwQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA6425A631
	for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919467; cv=none; b=LlZIxXa/dGr80YMCzmjUfQK9r+lLmKeNYizBrWHKXqj743mI4rPfY1mrk5x+WrgSLGY+Ynr4L+DQTwoYEsckdlG9Z3++ohMmUz1WnrDxM57/w4hZL4/ZpPpyM6Tubrc0qJyUG+OdNj5y8Eh7lgCHl42Ry4/wEzqFVNOh0x5+faM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919467; c=relaxed/simple;
	bh=UFB3jUwcCxDUXVdknAFj4Uw6pT1TD0qSPXu/fNHud/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=obqFsRdcpJEUhg1jwW6+9aIcHcprlOyIRGq2Aa9yHdXq2ySSy4DeZ5BcwaNvn/9w2TotUFRd1v5dEbOblrphpyJLdDzHN3Sml/OE4B+PWgdw3tDVdt20EO/C50o5iwyCt6mLpp4cOEOq2MILFEHUJaVCzwAuXiHH4Ju73MT3Os0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=timsKRwQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2344C4CEF3;
	Tue, 25 Mar 2025 16:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742919467;
	bh=UFB3jUwcCxDUXVdknAFj4Uw6pT1TD0qSPXu/fNHud/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=timsKRwQH9epFFWjDrQrZi7SZh8MBGENUL8C9T3ECNd6JHSndw9pBXcN0iqkPx4r4
	 ToJcEOx172s2ZB+Z+SfTrsfN8Z1RndCxCr2yUvW1dkXAg4EKHXh6uPAU96mpWVbz54
	 mIaWLxdxlskMAz5sBa7PRUJEwtmEohP1joRtVSVTBDoVNhRHiBVBi0/wcl/YR2N+DI
	 KgLy79MwA5FDYV4G6rogGfnIuXbR7g3Yu+iDr4XNulq0SgTGQK4JKIEr/Nm6KKXU1V
	 uSTL/EqGMHcp6iZZ5VguuSHId6MY7SikvcepmJC9hAcbGjNAk+PNtz3WaBjEtcnwQL
	 JYz7Vu8ihH9pw==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 3/4] NFSv4: clp->cl_cons_state < 0 signifies an invalid nfs_client
Date: Tue, 25 Mar 2025 12:17:43 -0400
Message-ID: <56bc4d7e614a6d9d0aa520c71bd0ffb102e3ef08.1742919341.git.trond.myklebust@hammerspace.com>
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


