Return-Path: <linux-nfs+bounces-8050-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4379D1A35
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 22:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74F3A1F226D2
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 21:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909C41E7C01;
	Mon, 18 Nov 2024 21:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvqAileT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671E31E7676;
	Mon, 18 Nov 2024 21:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731964457; cv=none; b=CBU7FFZLzFPBMTTU5bFzu0KqzualAxqXHaRWydsYQhujREV8H8QEDH+iF6XQ5LMjFcjxMcjqXg42M3Vco+7WaUwxNLiDL89ziLKC+ZbINdOYKwWrMNb696aZ3oSda0y34Xjo0ikTgJd1tRHbJexOu2aYeNg5R/P9mc6DCkMRsgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731964457; c=relaxed/simple;
	bh=mXnmYI3CEGwEX003uQzZKukhDWAt/2Snk6B8E/IGtEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CTefHLNznAdA+0Lj1JJjTyoM4CU0M+GK+6I7WL0gQs4sqNGA4AZzmzSs9SxwejU2OB/4ZTTAY/OMIdyz4K0lxLEkf1om+FC19A2FcTRLTpSUWeX0kQz0PPhX8P9b5CmOHpW8XD0nWX3p9xGHYiNNNYFswEiqlzXjl1Le8Oh5UOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvqAileT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B861AC4CED6;
	Mon, 18 Nov 2024 21:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731964457;
	bh=mXnmYI3CEGwEX003uQzZKukhDWAt/2Snk6B8E/IGtEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cvqAileTHgsznwrT48LnAYOaiFPdLKA4KzHhJkHWUT61bKbK25mfbPwj7INITh6Fy
	 3Urkh2NvyWvWsHArWIvvSySCh35Joh5C4mVx0EHH5Ir+Hh1Y5GbUFTNFIl9LLSnLGC
	 UzM344IYhbjww4SNWXvnaG4Q0M6PEZY5c9feWxp3bGtzR/eCtPEs66xhfTpONJMWwX
	 PSgGIe9uQu8vTOu8tUGccINTJFdmPoIjCDsIRkIpE0O1B6GewzmnnLDh76ic7eNvZr
	 giwQyHEqLa32Rs3/8ifBJ78xgsnxjo217uuDUgDXkn3RETW1pmearYp6Xt/7yDnywP
	 aU2P/tRPktPvQ==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dai Ngo <dai.ngo@oracle.com>,
	Chen Hanxiao <chenhx.fnst@fujitsu.com>
Subject: [PATCH 6.6 1/5] NFSD: initialize copy->cp_clp early in nfsd4_copy for use by trace point
Date: Mon, 18 Nov 2024 16:14:09 -0500
Message-ID: <20241118211413.3756-2-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118211413.3756-1-cel@kernel.org>
References: <20241118211413.3756-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dai Ngo <dai.ngo@oracle.com>

[ Upstream commit 15d1975b7279693d6f09398e0e2e31aca2310275 ]

Prepare for adding server copy trace points.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
Tested-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
Stable-dep-of: 9ed666eba4e0 ("NFSD: Async COPY result needs to return a write verifier")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index ae0057c54ef4..a378dcb2ceb2 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1798,6 +1798,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	__be32 status;
 	struct nfsd4_copy *async_copy = NULL;
 
+	copy->cp_clp = cstate->clp;
 	if (nfsd4_ssc_is_inter(copy)) {
 		if (!inter_copy_offload_enable || nfsd4_copy_is_sync(copy)) {
 			status = nfserr_notsupp;
@@ -1812,7 +1813,6 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			return status;
 	}
 
-	copy->cp_clp = cstate->clp;
 	memcpy(&copy->fh, &cstate->current_fh.fh_handle,
 		sizeof(struct knfsd_fh));
 	if (nfsd4_copy_is_async(copy)) {
-- 
2.47.0


