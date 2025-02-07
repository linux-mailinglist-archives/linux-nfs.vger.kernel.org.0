Return-Path: <linux-nfs+bounces-9936-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 408F5A2C40A
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 14:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E12C7166ECA
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 13:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86511F76B4;
	Fri,  7 Feb 2025 13:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBkFF6oD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF41C1F754A;
	Fri,  7 Feb 2025 13:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738935917; cv=none; b=RMpG/uKfLUxSUc9ZHdLE4iUGyFyKWM2ftEUg0/wKbFCS8muf3m2YHwbqRmnuaVVdCPI7/IoeU0quBvLITN+eCezdElqHHOg9U3qAlq4YV14Yfw8UmVAC9t+wF+wmN/b9m/E6qe1widzneqlNU9jpcYv8UQe0vLAcdwiCG6Lc83Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738935917; c=relaxed/simple;
	bh=mhlgEsqmP9VSPJgXJ5mpnUcPmqpV38SKAibvEQJ9U04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T5P7qkoP9xpyq2f4Qeqx5LF5YP8bCdvyntpzlzMqEk5tjM4oLQgKU6O+AxUE08Djn3i3jmLlOFPmWRR48gQMJtbstCzDEbrvFB/dD1FC6ct+3IRAZVsA/1DoHBjPxr+xx0mGCMlmmRK4bdRUCnuMS4no6JtFGZjQ75TDrnj6e1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBkFF6oD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D00CC4CEE2;
	Fri,  7 Feb 2025 13:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738935917;
	bh=mhlgEsqmP9VSPJgXJ5mpnUcPmqpV38SKAibvEQJ9U04=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BBkFF6oDsBDzc1BLemGCUFMYTqH7t7YaEJfXTakSU0enuy46Bgrn/ocW40iV8ZLIU
	 JyEvqMTXudGsFCIKFu5Ezw+aV3+RWtLGIA/9ozgmODjl5QPd0yR3zKBy4K3jQC8SHP
	 0IJV3Eq6oTeedEslecut7QFwatabpnGZS4/gH0rqEii3TRPgZ4QHnE1Ol4hlJQVx+t
	 KZROmvJsiJKGr6DWOA7RIjxrqLH8yDjFPGsNYbwYn/RT7QDon3osvaxExw78ZvqblY
	 8KMhbdXcOZ9Vb3rH12BEpiMNmRSebhyR6IWFX84UeL1yN3CY8MXFN1GrAPNkpg2cFj
	 aRYdQlf/XlBsg==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 07 Feb 2025 08:45:03 -0500
Subject: [PATCH v4 1/2] nfsd: overhaul CB_SEQUENCE error handling
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-nfsd-6-14-v4-1-1aa42c407265@kernel.org>
References: <20250207-nfsd-6-14-v4-0-1aa42c407265@kernel.org>
In-Reply-To: <20250207-nfsd-6-14-v4-0-1aa42c407265@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5447; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=mhlgEsqmP9VSPJgXJ5mpnUcPmqpV38SKAibvEQJ9U04=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnpg5qcomsPCmwGPjwrL/0gYLKZGpe1MOCBAdKy
 Wte9nQeL4WJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ6YOagAKCRAADmhBGVaC
 FYD1EADKn5DHUO9G8vD08dWiehPKTsdOS6t+MBWtzvfv1Y6DLgjqUFDQODhUk3BIEJuaFkKNuXg
 gWk1o3lbdJIVTmhpgTJGqv9t+T5yFb6QmPAfSDtTG7Hs0lSG/xf+4iVRW+Y5MUERlVLsZ6CKiX1
 EyaLZkD0nwsN2z2u9tiEL3p/dG7vFjzhQ0/jcwK2GzxYibCqyYyjx8wss/8mNPmF5LJzina/Og9
 pYrrWtp1zy1Y8oYezGMpKDpbmgVl/plBZ4EngjwGhqVfs83Tp0RKekiMO6JNzTy8nS5dMzFjtbF
 1AudhmXBq4VIlEU7NlyBPexoglOrdfplfSh27vHilj3odekvGmoib+oI3e/htodkP14HbOXBO7r
 hGjzuzDB93FNaVgtoZshbEZJy9Xlbw9KTnjX1PvSgVYCH4YKEV61juafwajiBVpvbl4f6wcEDbb
 tjsuXENA8KDhM9eHvMlwNET6gismerslD0ATcWkVft1qkvTl/2pcCmJA86HDyM4gOstoft/z8wY
 txvPsP5rxipHyW3/ue6RrHzhzEcm/4ZbBRpTZstSyrOgnAqYMP27MPMaFBfZNeBfNAZZjASpbSy
 yzhfRXAK1Xy98V0QS3NykNCMYVN91z6V9d88Bz/LKzvjYUPGtMTsqvtlQfD2VdS8yvZ6HwVD4Ka
 S+tL8DnfOGCVvkg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Some of the existing error handling in nfsd4_cb_sequence_done is
incorrect. For instance, if a NFS4ERR_SEQ_MISORDERED or NFS4ERR_BADSLOT
status races with rpc_clnt teardown, then the callback could be dropped
on the floor and never resent. This patch first does some general cleanup
and then reworks most of the error handling cases from first principles:

There is only one case where we want to proceed with processing the rest
of the CB_COMPOUND, and that's when the cb_seq_status is 0. Make the
default return value be false, and only set it to true in that case.

Rename the "need_restart" label to "requeue", to better indicate that
it's being requeued to the workqueue.

When the callback isn't going to be requeued or restarted, don't bother
checking RPC_SIGNALLED(). That should only be checked when we intend to
restart an rpc_task.

For -ESERVERFAULT, don't increment the sequence number since it's
possible the sessionid didn't match. Mark the backchannel bad and wait
for it to be recreated.

For NFS4ERR_DELAY, test for RPC_SIGNALLED() first, since that's an
indication that the client is being torn down. Requeue it in that case.

When restarting the RPC (but not the entire callback), test
RPC_SIGNALLED(). If it has been, then fall through to restart the
callback instead of just restarting the RPC.

For NFS4ERR_BADSLOT, mark the backchannel faulty and leak the slot so
that it can't be reused.

For NFS4ERR_SEQ_MISORDERED, retry once with seq_nr of 1, and if that
fails, handle it like BADSLOT.

When requeuing a callback, always release the slot in case there
have been changes to the slot table or session in the interim when it's
resubmitted.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 64 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 21 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index cf6d29828f4e561418b812ea2c9402929dd52bd0..a8603c3cdcdafbf9ccc6296425112f1730419b7b 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1332,7 +1332,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 {
 	struct nfs4_client *clp = cb->cb_clp;
 	struct nfsd4_session *session = clp->cl_cb_session;
-	bool ret = true;
+	bool ret = false;
 
 	if (!clp->cl_minorversion) {
 		/*
@@ -1345,13 +1345,13 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		 * handle that case here.
 		 */
 		if (RPC_SIGNALLED(task))
-			goto need_restart;
+			goto requeue;
 
 		return true;
 	}
 
 	if (cb->cb_held_slot < 0)
-		goto need_restart;
+		goto requeue;
 
 	/* This is the operation status code for CB_SEQUENCE */
 	trace_nfsd_cb_seq_status(task, cb);
@@ -1365,11 +1365,15 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		 * (sequence ID, cached reply) MUST NOT change.
 		 */
 		++session->se_cb_seq_nr[cb->cb_held_slot];
+		ret = true;
 		break;
 	case -ESERVERFAULT:
-		++session->se_cb_seq_nr[cb->cb_held_slot];
+		/*
+		 * Call succeeded, but CB_SEQUENCE reply failed sanity checks.
+		 * The client has gone insane. Mark the BC faulty, since there
+		 * isn't much else we can do.
+		 */
 		nfsd4_mark_cb_fault(cb->cb_clp);
-		ret = false;
 		break;
 	case 1:
 		/*
@@ -1380,39 +1384,57 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		 */
 		fallthrough;
 	case -NFS4ERR_BADSESSION:
+		/* Mark the backchannel faulty. Restart the call. */
 		nfsd4_mark_cb_fault(cb->cb_clp);
-		ret = false;
-		goto need_restart;
+		goto requeue;
 	case -NFS4ERR_DELAY:
+		/*
+		 * If the rpc_clnt is being torn down, then we must restart
+		 * the call from scratch.
+		 */
+		if (RPC_SIGNALLED(task))
+			goto requeue;
 		cb->cb_seq_status = 1;
-		if (!rpc_restart_call(task))
-			goto out;
-
+		rpc_restart_call(task);
 		rpc_delay(task, 2 * HZ);
 		return false;
-	case -NFS4ERR_BADSLOT:
-		goto retry_nowait;
 	case -NFS4ERR_SEQ_MISORDERED:
+		/*
+		 * Reattempt once with seq_nr 1. If that fails, treat this
+		 * like BADSLOT.
+		 */
 		if (session->se_cb_seq_nr[cb->cb_held_slot] != 1) {
 			session->se_cb_seq_nr[cb->cb_held_slot] = 1;
 			goto retry_nowait;
 		}
-		break;
+		fallthrough;
+	case -NFS4ERR_BADSLOT:
+		/*
+		 * BADSLOT means that the client and server are out of sync
+		 * on the BC parameters. In this case, we want to mark the
+		 * backchannel faulty and then try it again, but _leak_ the
+		 * slot so no one uses it.
+		 */
+		nfsd4_mark_cb_fault(cb->cb_clp);
+		cb->cb_held_slot = -1;
+		goto retry_nowait;
 	default:
 		nfsd4_mark_cb_fault(cb->cb_clp);
 	}
 	trace_nfsd_cb_free_slot(task, cb);
 	nfsd41_cb_release_slot(cb);
-
-	if (RPC_SIGNALLED(task))
-		goto need_restart;
-out:
 	return ret;
 retry_nowait:
-	if (rpc_restart_call_prepare(task))
-		ret = false;
-	goto out;
-need_restart:
+	/*
+	 * RPC_SIGNALLED() means that the rpc_client is being torn down and
+	 * (possibly) recreated. Restart the call completely in that case.
+	 */
+	if (!RPC_SIGNALLED(task)) {
+		rpc_restart_call_prepare(task);
+		return false;
+	}
+requeue:
+	nfsd41_cb_release_slot(cb);
 	if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
 		trace_nfsd_cb_restart(clp, cb);
 		task->tk_status = 0;

-- 
2.48.1


