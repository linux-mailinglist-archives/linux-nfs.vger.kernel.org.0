Return-Path: <linux-nfs+bounces-8082-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4D79D1A86
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 22:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07B171F227E9
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 21:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4699815D5B7;
	Mon, 18 Nov 2024 21:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meb+PPfK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA0E155C94;
	Mon, 18 Nov 2024 21:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731965027; cv=none; b=DIDHKIUqBScn0aZjFdc/vCF3j4SoBMYL1Cr5GHGfpXVsehq22Ewk4RRQFxsADdsQtuZqTS8bkuowE373Q/BHFraCBtCHI/cYVeqvmfI2Gk5on4zSv6lHUbpyaidIXiXytE7T3pM13nnqSS8ddmVXz5ytRSeTDt1cfbkOq4lM8r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731965027; c=relaxed/simple;
	bh=ytUBqDm/ZNlD24zTNRBFChXh1eKV2k05IMXuHZRh6IU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+ELI++xskOkv1i8LzdWowduQRKj8d0fEjvmxrGbuRix8rXE6yX3ohW1BuWUavSslNzlROkO7ZwOSVbSTI4JmZqnnGV+EscjChKTo/8Hp+J+eKFSr+IlHShObpqrs7hiicpxoRtxg4hK30pLWXTfQeSJQeD96aw6bwm1t3aLnXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=meb+PPfK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777CBC4CED7;
	Mon, 18 Nov 2024 21:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731965027;
	bh=ytUBqDm/ZNlD24zTNRBFChXh1eKV2k05IMXuHZRh6IU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=meb+PPfK6rFfeIyv44mJokHHz9XmKggHw3gBbabBKyrdNz5R6QLPWyVlWrt02pA1A
	 CIIyaHx0PUr1nhQcvoxvfS636UMTH9W5gv806CEiyCwju8ukCkO0dJYqo3dKpYoioc
	 7crHMZxz7ghq05e1gYrKivUo55CznnlvNvcezPoFssVPX85rbsh+Q6fID7sNcZmvVU
	 wrXGGJkSWqKTFhwkAyg+8b+Bk3lSxCXRMlESvfvht0XY+m88Owjr+Wxm3J5rK8K74T
	 N7XSrewwrZVghCWN1QsrDre6GOS/yGcfCpxNnAV4jzP1RBZBjC2LMde8XUs+xwPZtj
	 i5SI3YBEE/PMQ==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dai Ngo <dai.ngo@oracle.com>,
	Chen Hanxiao <chenhx.fnst@fujitsu.com>
Subject: [PATCH 5.15 1/5] NFSD: initialize copy->cp_clp early in nfsd4_copy for use by trace point
Date: Mon, 18 Nov 2024 16:23:39 -0500
Message-ID: <20241118212343.3935-2-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118212343.3935-1-cel@kernel.org>
References: <20241118212343.3935-1-cel@kernel.org>
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


