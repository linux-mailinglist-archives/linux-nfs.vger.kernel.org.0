Return-Path: <linux-nfs+bounces-2500-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0770988EC6F
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Mar 2024 18:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 394331C3176A
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Mar 2024 17:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C6114D709;
	Wed, 27 Mar 2024 17:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4s8yCtY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AEE14E2C1
	for <linux-nfs@vger.kernel.org>; Wed, 27 Mar 2024 17:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711560014; cv=none; b=teWVq8VbkA2FItbilGcuK7aEeqNNWSe29/RnO2qi+bh7fjJoxY2i545gSGNgrNcoxp6oXy7xXUJHS/IGfA+Hxm33Bq7efMsDmBfSATDjUWQi3/ZgCzUt8FJ9bzc2GIcigbLtyBsTaG2bE6b/v1uOh3mREjT+tkahdebiBwveqFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711560014; c=relaxed/simple;
	bh=45vtvw+fq+fj3ZEXawkKtAn2mcTFbd0QASGwbLIgoME=;
	h=Subject:From:To:Date:Message-ID:MIME-Version:Content-Type; b=PuI5itXBEnXI/jfbXAVJuR5q8VdpDBzCnpp0v9B/9JXV/vTAIa9llMzH8GF3AA/up4QDGLzY/1KfNN+Xf1AjuzY+S3b2b5glCTI3LwoPJQfakaV+5p4gmNAb+bQZsRRTJDhTPC8/2m5x1pRSJYfKUI01q7EBfxgSSYXssUpixzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4s8yCtY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06DFC43601
	for <linux-nfs@vger.kernel.org>; Wed, 27 Mar 2024 17:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711560014;
	bh=45vtvw+fq+fj3ZEXawkKtAn2mcTFbd0QASGwbLIgoME=;
	h=Subject:From:To:Date:From;
	b=R4s8yCtY7wzUkJsNxlyMiFtdA2F2+1HYUOkMUbry06wa65VQRm02dHO6BIn4mpIGg
	 XG+c8/CT5MmLnJpyXZlNoKgDy9FSYPvOU71hw6FNtoYGdUmmWPssWJC07LBh71yoUY
	 qXhbBGwgpTuDBRINOa67KQnMx9dR4IYwyPO8lvJ8gYgWyWZI30aycgKd4CZInhK51y
	 1HxJvxfnJwrnvM0uKovVZB/+3J3WJeQ854O2S3RSzMenJa+c3+ETLTNm2FfpOCKAn0
	 Kxi+4rYYHHaH84sGIrAQRlggPUDOoZJbT0l+3KHt5DjYiLxrbtkIOH7GzbJvSHCi55
	 HMNUAye7cUm+Q==
Subject: [PATCH] NFSD: CREATE_SESSION must never cache NFS4ERR_DELAY replies
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Wed, 27 Mar 2024 13:20:12 -0400
Message-ID: 
 <171156001280.1469.15703028652039429964.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

There are one or two cases where CREATE_SESSION returns
NFS4ERR_DELAY in order to force the client to wait a bit and try
CREATE_SESSION again. However, after commit e4469c6cc69b ("NFSD: Fix
the NFSv4.1 CREATE_SESSION operation"), NFSD caches that response in
the CREATE_SESSION slot. Thus, when the client resends the
CREATE_SESSION, the server always returns the cached NFS4ERR_DELAY
response rather than actually executing the request and properly
recording its outcome. This blocks the client from making further
progress.

RFC 8881 Section 15.1.1.3 says:
> If NFS4ERR_DELAY is returned on an operation other than SEQUENCE
> that validly appears as the first operation of a request ... [t]he
> request can be retried in full without modification. In this case
> as well, the replier MUST avoid returning a response containing
> NFS4ERR_DELAY as the response to an initial operation of a request
> solely on the basis of its presence in the reply cache.

Neither the original NFSD code nor the discussion in section 18.36.4
refer explicitly to this important requirement, so I missed it.

Note also that not only must the server not cache NFS4ERR_DELAY, but
it has to not advance the CREATE_SESSION slot sequence number so
that it can properly recognize and accept the client's retry.

Reported-by: Dai Ngo <dai.ngo@oracle.com>
Fixes: e4469c6cc69b ("NFSD: Fix the NFSv4.1 CREATE_SESSION operation")
Tested-by: Dai Ngo <dai.ngo@oracle.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |   36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index ee9aa4843443..5fcd93f7cb8c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3831,15 +3831,20 @@ nfsd4_create_session(struct svc_rqst *rqstp,
 	else
 		cs_slot = &unconf->cl_cs_slot;
 	status = check_slot_seqid(cr_ses->seqid, cs_slot->sl_seqid, 0);
-	if (status) {
-		if (status == nfserr_replay_cache) {
-			status = nfsd4_replay_create_session(cr_ses, cs_slot);
-			goto out_free_conn;
-		}
+	switch (status) {
+	case nfs_ok:
+		cs_slot->sl_seqid++;
+		cr_ses->seqid = cs_slot->sl_seqid;
+		break;
+	case nfserr_replay_cache:
+		status = nfsd4_replay_create_session(cr_ses, cs_slot);
+		fallthrough;
+	case nfserr_jukebox:
+		/* The server MUST NOT cache NFS4ERR_DELAY */
+		goto out_free_conn;
+	default:
 		goto out_cache_error;
 	}
-	cs_slot->sl_seqid++;
-	cr_ses->seqid = cs_slot->sl_seqid;
 
 	/* RFC 8881 Section 18.36.4 Phase 3: Client ID confirmation. */
 	if (conf) {
@@ -3859,10 +3864,8 @@ nfsd4_create_session(struct svc_rqst *rqstp,
 		old = find_confirmed_client_by_name(&unconf->cl_name, nn);
 		if (old) {
 			status = mark_client_expired_locked(old);
-			if (status) {
-				old = NULL;
-				goto out_cache_error;
-			}
+			if (status)
+				goto out_expired_error;
 			trace_nfsd_clid_replaced(&old->cl_clientid);
 		}
 		move_to_confirmed(unconf);
@@ -3894,6 +3897,17 @@ nfsd4_create_session(struct svc_rqst *rqstp,
 		expire_client(old);
 	return status;
 
+out_expired_error:
+	old = NULL;
+	/*
+	 * Revert the slot seq_nr change so the server will process
+	 * the client's resend instead of returning a cached response.
+	 */
+	if (status == nfserr_jukebox) {
+		cs_slot->sl_seqid--;
+		cr_ses->seqid = cs_slot->sl_seqid;
+		goto out_free_conn;
+	}
 out_cache_error:
 	nfsd4_cache_create_session(cr_ses, cs_slot, status);
 out_free_conn:



