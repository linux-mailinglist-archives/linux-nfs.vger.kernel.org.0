Return-Path: <linux-nfs+bounces-8062-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FC39D1A59
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 22:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC448281CFF
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 21:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9F61C07DE;
	Mon, 18 Nov 2024 21:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4cEwMe3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D74155312;
	Mon, 18 Nov 2024 21:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731964839; cv=none; b=Q3oGCeP3q1aaRyC6arHQWFIml4IW8RkoKhBqdLfdZDphv62WkPW8Ju+18hcglpnfmjDh7kekGacih6QBwCfrQnEbeniTRxsvaUNxzSfL4AMkspsnHXuhMWLamLuIPeyj6S6zUDMG6g4ruc+7djjhlMOcg9NwJbePYzlgoUnRdyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731964839; c=relaxed/simple;
	bh=ytUBqDm/ZNlD24zTNRBFChXh1eKV2k05IMXuHZRh6IU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2RUTlXq/RJeZfXxPlA9OohGxELHyObtXv8kN548MZUGu5jgnZKXrPijLNjVU5r3xk1+jP52CPy0gesX+zbplnKh6uW3OE2HQCiVZ635HQhqaDGZ7wxU2eis9S/Fksygi0BtptQCw/7onLKreBJHxCfuPTthwIVKrURhZZKIBGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4cEwMe3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0EBC4CED9;
	Mon, 18 Nov 2024 21:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731964839;
	bh=ytUBqDm/ZNlD24zTNRBFChXh1eKV2k05IMXuHZRh6IU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f4cEwMe3aMjh8TquYQID+0F2uxNJ3q9f+Yhzp4oL+z0g5zBk2BUypB6iD+X4LYhPB
	 76SNa0y2ylJ6Z6zYQnzYVD9b1ZlJdaEM3FxvmHsARtNXJLzKdOIdEr57KefxRrXpVC
	 g4grr2iZFrORHH7bV0yto7iC6JzPyzpKNMicUm/z7FJE5iAxzPIdrUKLHW9+zqkaGI
	 bB+vh/hryoo4W3SnJ5MplAzO8D2o3uAb2yoYkF+bJ42jnI1o4g4MAgRBxQZ5KMdumw
	 53mtr/Xw31rb6y3SIDa7jEU69HHPENKF4zBll+wFf1MJcYbpSIQMpcfpVcO2cmw0bE
	 7q4JhYxCW2yeQ==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dai Ngo <dai.ngo@oracle.com>,
	Chen Hanxiao <chenhx.fnst@fujitsu.com>
Subject: [PATCH 5.15 1/5] NFSD: initialize copy->cp_clp early in nfsd4_copy for use by trace point
Date: Mon, 18 Nov 2024 16:20:13 -0500
Message-ID: <20241118212035.3848-2-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118212035.3848-1-cel@kernel.org>
References: <20241118212035.3848-1-cel@kernel.org>
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
index 11dcf3debb1d..2b1fcf5b6bf8 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1769,6 +1769,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	__be32 status;
 	struct nfsd4_copy *async_copy = NULL;
 
+	copy->cp_clp = cstate->clp;
 	if (nfsd4_ssc_is_inter(copy)) {
 		if (!inter_copy_offload_enable || nfsd4_copy_is_sync(copy)) {
 			status = nfserr_notsupp;
@@ -1783,7 +1784,6 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			return status;
 	}
 
-	copy->cp_clp = cstate->clp;
 	memcpy(&copy->fh, &cstate->current_fh.fh_handle,
 		sizeof(struct knfsd_fh));
 	if (nfsd4_copy_is_async(copy)) {
-- 
2.47.0


