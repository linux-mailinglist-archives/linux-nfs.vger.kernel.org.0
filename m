Return-Path: <linux-nfs+bounces-1862-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D8784E498
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Feb 2024 17:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E7F61F28B0C
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Feb 2024 16:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029177B3D9;
	Thu,  8 Feb 2024 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oK3u67Yc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A167CF3A
	for <linux-nfs@vger.kernel.org>; Thu,  8 Feb 2024 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707408032; cv=none; b=HqNiCK+tNxItTBNFBNYLvFEGiQgRe/eC3EXskGhAp4Xh3Vr65EjFlBOy1q2gjXj00AAoicXdbtsW22TnK5kiiJAArOLA04Gnvpd176e6BT8PRFK+RnzJdVJ7d4N9qkE9RhC9WraEVwpQvrEOQJZPRSV+QAS9El8347WDHofO34A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707408032; c=relaxed/simple;
	bh=lQUvOMGDRx8nGvdRJw/9Yu90tLPvuIzHjvWWWzMLxWU=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HdU5HZ37INyB4cK08NslfPMxCojJ65USs2qQmkMeJeR2AEmeyX5ZIjhopLFuAmFOWG4TylS5EZXfjDglVDZteZHqGeBOWc2mHGMai20bf2xXPlVUQ1/CMYTPS8YUqNNVuT7wWvM6oIJX2d0puvOpeWbGhDv3++C8H9/51eRajjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oK3u67Yc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7792CC433F1
	for <linux-nfs@vger.kernel.org>; Thu,  8 Feb 2024 16:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707408030;
	bh=lQUvOMGDRx8nGvdRJw/9Yu90tLPvuIzHjvWWWzMLxWU=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=oK3u67YceJW7Kmcg25uxtCZl3AXB9tyDvJKzc4HdpbF8dzQ0YucOHa7ROmcPyMAF/
	 FC3Hcuit6VREpfSyzj4w5w7Y3BqeAy6iFv7bE57Q53C/ZwN3EnfSybob5DG1AtYtew
	 MIBq+gjJ4x6TuPWMcBTU7/+hZAr+EL8q2AWSCA7BT1xLQWCHIiMQ6TlC71wcMc1DeN
	 SuDEKhg64ideC615JvpzBSj0UCR+AiXG0ZfwXQFcsn6RQPTcUymuiiwsSGhYIItaYY
	 9vr4OlGVbvMwgouuH+AHeSpQABApLNlfg/1VNrRJ7mvTtGmHal6KQPH0PkTFiuiVwa
	 FeSoT3KnHD4pg==
Subject: [PATCH v1 1/2] NFSD: Fix the NFSv4.1 CREATE_SESSION operation
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Thu, 08 Feb 2024 11:00:29 -0500
Message-ID: 
 <170740802941.2139.6791733027839730270.stgit@manet.1015granger.net>
In-Reply-To: 
 <170740799184.2139.1775683633369731917.stgit@manet.1015granger.net>
References: 
 <170740799184.2139.1775683633369731917.stgit@manet.1015granger.net>
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

RFC 8881 Section 18.36.4 discusses the implementation of the NFSv4.1
CREATE_SESSION operation. The section defines four phases of
operation.

Phase 2 processes the CREATE_SESSION sequence ID. As a separate
step, Phase 3 evaluates the CREATE_SESSION arguments.

The problem we are concerned with is when phase 2 is successful but
phase 3 fails. The spec language in this case is "No changes are
made to any client records on the server."

RFC 8881 Section 18.35.4 defines a "client record", and it does
/not/ contain any details related to the special CREATE_SESSION
slot. Therefore NFSD is incorrect to skip incrementing the
CREATE_SESSION sequence id when phase 3 (see Section 18.36.4) of
CREATE_SESSION processing fails. In other words, even though NFSD
happens to store the cs_slot in a client record, in terms of the
protocol the slot is logically separate from the client record.

Three complications:

1. The world has moved on since commit 86c3e16cc7aa ("nfsd4: confirm
   only on succesful create_session") broke this. So we can't simply
   revert that commit.

2. NFSD's CREATE_SESSION implementation does not cleanly delineate
   the logic of phases 2 and 3. So this won't be a surgical fix.

3. Because of the way it currently handles the CREATE_SESSION slot
   sequence number, nfsd4_create_session() isn't caching error
   responses in the CREATE_SESSION slot. Instead of replaying the
   response cache in those cases, it's executing the transaction
   again.

Reorganize the CREATE_SESSION slot sequence number accounting. This
requires that error responses are appropriately cached in the
CREATE_SESSION slot (once it is found).

Reported-by: Connor Smith <connor.smith@hitachivantara.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218382
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |   57 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 6dc6340e2852..bca2c2878ad6 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3414,6 +3414,9 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	new->cl_spo_must_allow.u.words[0] = exid->spo_must_allow[0];
 	new->cl_spo_must_allow.u.words[1] = exid->spo_must_allow[1];
 
+	/* Contrived initial CREATE_SESSION response */
+	new->cl_cs_slot.sl_status = nfserr_seq_misordered;
+
 	add_to_unconfirmed(new);
 	swap(new, conf);
 out_copy:
@@ -3584,10 +3587,10 @@ nfsd4_create_session(struct svc_rqst *rqstp,
 	struct nfsd4_create_session *cr_ses = &u->create_session;
 	struct sockaddr *sa = svc_addr(rqstp);
 	struct nfs4_client *conf, *unconf;
+	struct nfsd4_clid_slot *cs_slot;
 	struct nfs4_client *old = NULL;
 	struct nfsd4_session *new;
 	struct nfsd4_conn *conn;
-	struct nfsd4_clid_slot *cs_slot = NULL;
 	__be32 status = 0;
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 
@@ -3613,50 +3616,51 @@ nfsd4_create_session(struct svc_rqst *rqstp,
 	spin_lock(&nn->client_lock);
 	unconf = find_unconfirmed_client(&cr_ses->clientid, true, nn);
 	conf = find_confirmed_client(&cr_ses->clientid, true, nn);
-	WARN_ON_ONCE(conf && unconf);
+	if (!conf && !unconf) {
+		status = nfserr_stale_clientid;
+		goto out_free_conn;
+	}
 
-	if (conf) {
-		status = nfserr_wrong_cred;
-		if (!nfsd4_mach_creds_match(conf, rqstp))
-			goto out_free_conn;
+	if (conf)
 		cs_slot = &conf->cl_cs_slot;
-		status = check_slot_seqid(cr_ses->seqid, cs_slot->sl_seqid, 0);
-		if (status) {
-			if (status == nfserr_replay_cache)
-				status = nfsd4_replay_create_session(cr_ses, cs_slot);
+	else
+		cs_slot = &unconf->cl_cs_slot;
+	status = check_slot_seqid(cr_ses->seqid, cs_slot->sl_seqid, 0);
+	if (status) {
+		if (status == nfserr_replay_cache) {
+			status = nfsd4_replay_create_session(cr_ses, cs_slot);
 			goto out_free_conn;
 		}
-	} else if (unconf) {
+		goto out_cache_error;
+	}
+	cs_slot->sl_seqid++;
+	cr_ses->seqid = cs_slot->sl_seqid;
+
+	if (conf) {
+		status = nfserr_wrong_cred;
+		if (!nfsd4_mach_creds_match(conf, rqstp))
+			goto out_cache_error;
+	} else {
 		status = nfserr_clid_inuse;
 		if (!same_creds(&unconf->cl_cred, &rqstp->rq_cred) ||
 		    !rpc_cmp_addr(sa, (struct sockaddr *) &unconf->cl_addr)) {
 			trace_nfsd_clid_cred_mismatch(unconf, rqstp);
-			goto out_free_conn;
+			goto out_cache_error;
 		}
 		status = nfserr_wrong_cred;
 		if (!nfsd4_mach_creds_match(unconf, rqstp))
-			goto out_free_conn;
-		cs_slot = &unconf->cl_cs_slot;
-		status = check_slot_seqid(cr_ses->seqid, cs_slot->sl_seqid, 0);
-		if (status) {
-			/* an unconfirmed replay returns misordered */
-			status = nfserr_seq_misordered;
-			goto out_free_conn;
-		}
+			goto out_cache_error;
 		old = find_confirmed_client_by_name(&unconf->cl_name, nn);
 		if (old) {
 			status = mark_client_expired_locked(old);
 			if (status) {
 				old = NULL;
-				goto out_free_conn;
+				goto out_cache_error;
 			}
 			trace_nfsd_clid_replaced(&old->cl_clientid);
 		}
 		move_to_confirmed(unconf);
 		conf = unconf;
-	} else {
-		status = nfserr_stale_clientid;
-		goto out_free_conn;
 	}
 	status = nfs_ok;
 	/* Persistent sessions are not supported */
@@ -3669,8 +3673,6 @@ nfsd4_create_session(struct svc_rqst *rqstp,
 
 	memcpy(cr_ses->sessionid.data, new->se_sessionid.data,
 	       NFS4_MAX_SESSIONID_LEN);
-	cs_slot->sl_seqid++;
-	cr_ses->seqid = cs_slot->sl_seqid;
 
 	/* cache solo and embedded create sessions under the client_lock */
 	nfsd4_cache_create_session(cr_ses, cs_slot, status);
@@ -3683,6 +3685,9 @@ nfsd4_create_session(struct svc_rqst *rqstp,
 	if (old)
 		expire_client(old);
 	return status;
+
+out_cache_error:
+	nfsd4_cache_create_session(cr_ses, cs_slot, status);
 out_free_conn:
 	spin_unlock(&nn->client_lock);
 	free_conn(conn);



