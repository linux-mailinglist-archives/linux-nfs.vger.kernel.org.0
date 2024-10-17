Return-Path: <linux-nfs+bounces-7226-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6749A240D
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 15:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B618A28C1CF
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 13:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39471DDC13;
	Thu, 17 Oct 2024 13:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTyV3J5i"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFA21DDC09
	for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2024 13:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172199; cv=none; b=JCeeJ4zLQHQ03tlDhRknKImQ+AGth8ijRRdtFaNfLw4icCsMNPJKhc7v2t6L+REBE6koRdLL0XjnzEA4N257nUIHVfqqD5Y9WEHX0PmD6fP4iToRoFLGrPaGkKs8Kpna02s/8u5cIgupOTFy64B7CAW6bH5bzO649XjSL6btJWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172199; c=relaxed/simple;
	bh=G1zgE4U+FZDFacoFDNj97/oqQOgIBgKTnVwyOA8k0l8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QmVirtgJxxPeVjYAK0ezQXt9pZKhCekvGaU6aUZ0v+FfCFYRcwa3PsK6XnxUEI4La+L8dAmSMETPBVo1VtxAq3u5wEqFWys9pkvpSC+fvHyaTQ47GvdfqIRyYGqNbupFBlCnrXwbr0QJEN77yZMNN+tUnDBydtl5AFIqqwuAywM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTyV3J5i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9974AC4CED0;
	Thu, 17 Oct 2024 13:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729172199;
	bh=G1zgE4U+FZDFacoFDNj97/oqQOgIBgKTnVwyOA8k0l8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bTyV3J5iGHwikUGSSZK6b5zdEenW38rpex8etnhiVQNgYFi1CdWJUVwWNaPrX5Njw
	 KVThypMZbOGaK/TMuvJOTtslzWno6k3Hu5sLh2kb3fSI9/XY3Sw6E+yqgdHKmuB2IS
	 VLPNQ6nu0+ZKMqwPKXieBPZTjghdwsCogNlgURd264gdRGv8kloaUcOgN1UGR4Mr6n
	 ifIZl+Uwef7GZzTuWh0PW29/jRD5qia3JsTHbmY6t7euISZrxFE8+p/JU0ltVxfrJx
	 uUecR1ZDA6B26D+fa70SEJlBpxo7FywES7S2mKtws2JLO1vViX3sxegQ3gCWEchGMF
	 dtv5aEImC8yYQ==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 3/5] lockd: Remove some snippets of unfinished code
Date: Thu, 17 Oct 2024 09:36:29 -0400
Message-ID: <20241017133631.213274-4-cel@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241017133631.213274-1-cel@kernel.org>
References: <20241017133631.213274-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Clean up.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 12 ------------
 fs/lockd/svcproc.c  | 12 ------------
 2 files changed, 24 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 8a72c418cdcc..1d0400d94b3d 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -142,18 +142,6 @@ __nlm4svc_proc_lock(struct svc_rqst *rqstp, struct nlm_res *resp)
 	if ((resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
 		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
 
-#if 0
-	/* If supplied state doesn't match current state, we assume it's
-	 * an old request that time-warped somehow. Any error return would
-	 * do in this case because it's irrelevant anyway.
-	 *
-	 * NB: We don't retrieve the remote host's state yet.
-	 */
-	if (host->h_nsmstate && host->h_nsmstate != argp->state) {
-		resp->status = nlm_lck_denied_nolocks;
-	} else
-#endif
-
 	/* Now try to lock the file */
 	resp->status = nlmsvc_lock(rqstp, file, host, &argp->lock,
 					argp->block, &argp->cookie,
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index a03220e66ce0..d959a5dbe0ae 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -165,18 +165,6 @@ __nlmsvc_proc_lock(struct svc_rqst *rqstp, struct nlm_res *resp)
 	if ((resp->status = nlmsvc_retrieve_args(rqstp, argp, &host, &file)))
 		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
 
-#if 0
-	/* If supplied state doesn't match current state, we assume it's
-	 * an old request that time-warped somehow. Any error return would
-	 * do in this case because it's irrelevant anyway.
-	 *
-	 * NB: We don't retrieve the remote host's state yet.
-	 */
-	if (host->h_nsmstate && host->h_nsmstate != argp->state) {
-		resp->status = nlm_lck_denied_nolocks;
-	} else
-#endif
-
 	/* Now try to lock the file */
 	resp->status = cast_status(nlmsvc_lock(rqstp, file, host, &argp->lock,
 					       argp->block, &argp->cookie,
-- 
2.46.2


