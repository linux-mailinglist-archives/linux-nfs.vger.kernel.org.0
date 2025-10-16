Return-Path: <linux-nfs+bounces-15291-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A41ACBE3CD5
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 15:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA69E4FD6C3
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 13:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609AF33CE89;
	Thu, 16 Oct 2025 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URsGkZpj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7BC442C
	for <linux-nfs@vger.kernel.org>; Thu, 16 Oct 2025 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760622603; cv=none; b=p5S50XUp7E6OGXD73kuhIGDs9BN9wWJGBBulSBtCeN8ynC6+Vw+kMISgHyWuRAouJvgPmy4Ykn8lScEM+oeNaYaQBdFRYpDEgUqJflaRxrQ/e9qOGg1fDY9bvzyR6FyFtZwWNyLoybI5uw4enPZkH20f+0mqMq78A8pXRtDJYr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760622603; c=relaxed/simple;
	bh=Ve89rL1gluaFx19L1QgjbZSMVAJ8F5rBvw7nHTtPsO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQYhixHbZLuiaaHH7tXCQWCwMgJjiIm1YLnZWpz4bViI4alX4Slk6Ma7eHaqmb2J8A9WABUHzkq/7cjfuAGIffyDImNnVlq4gCoy/xqr9a7NBo2lsNjc6iqu5kUeZOhZFzjNxkEVEKZlr8lTKOvp5gQrRF5q8xCt/4ITtQ65pbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URsGkZpj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97322C4CEF1;
	Thu, 16 Oct 2025 13:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760622603;
	bh=Ve89rL1gluaFx19L1QgjbZSMVAJ8F5rBvw7nHTtPsO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=URsGkZpj/jdIP/PbbP4AtgvAH44T8rDE/rumOKrLD1ylMLavfEigS4lV+BYnpvaBI
	 4Cu1U+N0LwDFJSIKnW0HnVv/+dR9fUzj2QdyLellBIVOpSsOQHtRpEhhz3bRfK5UDm
	 N0v2BM2st6EMTR6OKfI8JhOuXcN4hbrmkDw2EoO3bwIa1A3ka4oEBMNRvDnSMT7v95
	 WgLov4HJQ/qZjYB/hj9CnPCass7pIGGZgOn4WreV+MLuQ4At7G5kBomjCPtiZX5H0I
	 1SIzrAdBZFueYCnxFLFydWlhutj5LXoeOQwx7CuvqJtolm/EqFXjYni4yDsFCieJMm
	 gYJSWwwNtqnvQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>
Subject: [PATCH v5 3/4] nfsd: ensure SEQUENCE replay sends a valid reply.
Date: Thu, 16 Oct 2025 09:49:57 -0400
Message-ID: <20251016134958.14050-4-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016134958.14050-1-cel@kernel.org>
References: <20251016134958.14050-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

nfsd4_enc_sequence_replay() uses nfsd4_encode_operation() to encode a
new SEQUENCE reply when replaying a request from the slot cache - only
ops after the SEQUENCE are replayed from the cache in ->sl_data.

However it does this in nfsd4_replay_cache_entry() which is called
*before* nfsd4_sequence() has filled in reply fields.

This means that in the replayed SEQUENCE reply:
 maxslots will be whatever the client sent
 target_maxslots will be -1 (assuming init to zero, and
      nfsd4_encode_sequence() subtracts 1)
 status_flags will be zero

The incorrect maxslots value, in particular, can cause the client to
think the slot table has been reduced in size so it can discard its
knowledge of current sequence number of the later slots, though the
server has not discarded those slots.  When the client later wants to
use a later slot, it can get NFS4ERR_SEQ_MISORDERED from the server.

This patch moves the setup of the reply into a new helper function and
call it *before* nfsd4_replay_cache_entry() is called.  Only one of the
updated fields was used after this point - maxslots.  So the
nfsd4_sequence struct has been extended to have separate maxslots for
the request and the response.

Reported-by: Olga Kornievskaia <okorniev@redhat.com>
Closes: https://lore.kernel.org/linux-nfs/20251010194449.10281-1-okorniev@redhat.com/
Tested-by: Olga Kornievskaia <okorniev@redhat.com>
Signed-off-by: NeilBrown <neil@brown.name>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c | 50 ++++++++++++++++++++++++++++++---------------
 fs/nfsd/nfs4xdr.c   |  2 +-
 fs/nfsd/xdr4.h      |  3 ++-
 3 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 4b4467e54ec9..28a79d23dd77 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4362,6 +4362,36 @@ static bool replay_matches_cache(struct svc_rqst *rqstp,
 	return true;
 }
 
+/*
+ * Note that the response is constructed here both for the case
+ * of a new SEQUENCE request and for a replayed SEQUENCE request.
+ * We do not cache SEQUENCE responses as SEQUENCE is idempotent.
+ */
+static void nfsd4_construct_sequence_response(struct nfsd4_session *session,
+					      struct nfsd4_sequence *seq)
+{
+	struct nfs4_client *clp = session->se_client;
+
+	seq->maxslots_response = max(session->se_target_maxslots,
+				     seq->maxslots);
+	seq->target_maxslots = session->se_target_maxslots;
+
+	switch (clp->cl_cb_state) {
+	case NFSD4_CB_DOWN:
+		seq->status_flags = SEQ4_STATUS_CB_PATH_DOWN;
+		break;
+	case NFSD4_CB_FAULT:
+		seq->status_flags = SEQ4_STATUS_BACKCHANNEL_FAULT;
+		break;
+	default:
+		seq->status_flags = 0;
+	}
+	if (!list_empty(&clp->cl_revoked))
+		seq->status_flags |= SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
+	if (atomic_read(&clp->cl_admin_revoked))
+		seq->status_flags |= SEQ4_STATUS_ADMIN_STATE_REVOKED;
+}
+
 __be32
 nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		union nfsd4_op_u *u)
@@ -4411,6 +4441,9 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	dprintk("%s: slotid %d\n", __func__, seq->slotid);
 
 	trace_nfsd_slot_seqid_sequence(clp, seq, slot);
+
+	nfsd4_construct_sequence_response(session, seq);
+
 	status = check_slot_seqid(seq->seqid, slot->sl_seqid, slot->sl_flags);
 	if (status == nfserr_replay_cache) {
 		status = nfserr_seq_misordered;
@@ -4508,23 +4541,6 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	}
 
 out:
-	seq->maxslots = max(session->se_target_maxslots, seq->maxslots);
-	seq->target_maxslots = session->se_target_maxslots;
-
-	switch (clp->cl_cb_state) {
-	case NFSD4_CB_DOWN:
-		seq->status_flags = SEQ4_STATUS_CB_PATH_DOWN;
-		break;
-	case NFSD4_CB_FAULT:
-		seq->status_flags = SEQ4_STATUS_BACKCHANNEL_FAULT;
-		break;
-	default:
-		seq->status_flags = 0;
-	}
-	if (!list_empty(&clp->cl_revoked))
-		seq->status_flags |= SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
-	if (atomic_read(&clp->cl_admin_revoked))
-		seq->status_flags |= SEQ4_STATUS_ADMIN_STATE_REVOKED;
 	trace_nfsd_seq4_status(rqstp, seq);
 out_no_session:
 	if (conn)
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 85b773a65670..30ce5851fe4c 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5085,7 +5085,7 @@ nfsd4_encode_sequence(struct nfsd4_compoundres *resp, __be32 nfserr,
 		return nfserr;
 	/* Note slotid's are numbered from zero: */
 	/* sr_highest_slotid */
-	nfserr = nfsd4_encode_slotid4(xdr, seq->maxslots - 1);
+	nfserr = nfsd4_encode_slotid4(xdr, seq->maxslots_response - 1);
 	if (nfserr != nfs_ok)
 		return nfserr;
 	/* sr_target_highest_slotid */
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index ee0570cbdd9e..1ce8e12ae335 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -574,8 +574,9 @@ struct nfsd4_sequence {
 	struct nfs4_sessionid	sessionid;		/* request/response */
 	u32			seqid;			/* request/response */
 	u32			slotid;			/* request/response */
-	u32			maxslots;		/* request/response */
+	u32			maxslots;		/* request */
 	u32			cachethis;		/* request */
+	u32			maxslots_response;	/* response */
 	u32			target_maxslots;	/* response */
 	u32			status_flags;		/* response */
 };
-- 
2.51.0


