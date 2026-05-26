Return-Path: <linux-nfs+bounces-21980-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBWcG8fJFWpEbgcAu9opvQ
	(envelope-from <linux-nfs+bounces-21980-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 18:26:47 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E02345D9A86
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 18:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F15F13000713
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 16:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02A93B5821;
	Tue, 26 May 2026 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iruf0jDL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD293B38B8;
	Tue, 26 May 2026 16:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779812698; cv=none; b=JYGxy/AWGEVFghfFL512tfQ+5KpsjrVuf/r51/6hv1e60L69WwHANdzogAqDxx2yRAAgVnzQruyUdP1/hCKojrTgjhdJ5aZXxPeMQifWtz5LY8S7JTsUIKfNERRnJ0tmJ6m/1mHiWjdc91inLIfDOKRtfZIf/7OCyXTGl/MVG3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779812698; c=relaxed/simple;
	bh=Qs+drLTdfHANV4ibP3h9QqGu1P/ASE9VyuPSa4GpKj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hQHhQn+UwQKc5AqNAeJtbf8Pd9+YaEIy51/j283JRtEKx52ruf2umz78glEpCZxTIKDgw6azcxwWb1wI1zDvzltcMSIiubeQ0CjdSxP0y4fX9sAgUuJLlWlGXZK7s9OAUwavDnJoAsGGD1jixC4i2mYuNUfhQn8CZ922IdYuoBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iruf0jDL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EEDE1F00A3A;
	Tue, 26 May 2026 16:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779812697;
	bh=9nCFAQCP2BZx8jA4KvO/3irz3CKK5yscEAn46NjEwuM=;
	h=From:Date:Subject:To:Cc;
	b=Iruf0jDLSfod3uSNG/6HVFQKyOVIIobMIJuUJ+3ow+SQJ7TmIeocZSt2IqwOANJtY
	 RjgpkrQBV8XK8eBQtG29s0u8kb28fUyMd1HOshJXIfnArDQsIErN0HyAvKUEGvKhm+
	 dz/9amNXR/RavYWWz+8m802Lnex50Jpu9VGPLa8vR0h4qJi3dWAWln6aYVhNyqq8e3
	 LP+ZIdg+42F0CQW3AapmFSpIKXv65rXVGUzNBC3+rzKFjTUqZ9fpq75evlC3fUFoL0
	 oPwPLJVoX6P0vRZ7svOW5sU0M56TAs+xff7g3Ebm21/qcJ88MJJwovth8DMD5S0Ci6
	 wTPsAUmy8E61g==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 26 May 2026 12:24:48 -0400
Subject: [PATCH v2] nfsd: don't free session slots that are still in use
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-nfsd4_sequence_shrink_uaf_on_loaded_slot-v2-1-74a89db0639e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/53NQQ6DIBRF0a0YxqUBilY76j4aQ1A+SjTQ8tW0M
 ey91CV0eN/gnZ0gRAdIbsVOImwOXfA5xKkg/aj9ANSZ3EQwUbFSVNRbNFIhvFbwPSgco/OTWrV
 Vwas5aANG4RwWyptaXjpgvNY9yXfPCNa9D+rR5h4dLiF+Dnnjv/UPZOOU05JJXemrNU0n7xNED
 /M5xIG0KaUvZ/zq/eEAAAA=
X-Change-ID: 20260526-nfsd4_sequence_shrink_uaf_on_loaded_slot-19843be018ac
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3701; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Qs+drLTdfHANV4ibP3h9QqGu1P/ASE9VyuPSa4GpKj4=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqFclUvdJqeTeJyyIkON4/089f1hw4vrIKFytEf
 ocQh17WRxuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahXJVAAKCRAADmhBGVaC
 Fa4VD/0U/p4O6KnPnrPLOb5m7K7iO0l1wLZoLAqABCs+9IVRmjD/zNcxIg8sanCrokg3NhrG3t1
 nNjG87Ip8G3dMcneu2aOFlBcbx6ZXzfDeVPMns6hwMVKScukU0jl5kBIrU79hOlW6k1fDlAlGiV
 O5DiFwtF5Iw/9v8wTM3Wq21uUsD4uvhPa/YOcFwb91zQrpYIG2JdTEeDUbE6HYgNsNzJAVGDCZY
 mE7WeYAYBtgEhk2q2Uq75mnlP6ImmKDDqpnWER6ejYbEMAgONbNrcaAU4dLjHHiBpHEsgVHoPq7
 COk56m2qYTbCz4oSMZYQF4ZmjeVK1STqJumUqVL9ChSAqnB00+gRHjpIJFz36bgoBBPtyCW6I22
 mbpbMEhQtikzhQplx2MJo1Zo9zp0S0RG6+k/2k/Cc85j7grGSl9xDPhlDC/R7Xk0WpskJp/BVbK
 xSd3D7gT5ffyT7dDdHMeXVw8a7kwyb21o3X4tUs8rC+u7lR8CKRpoGpn8UYeK8H1B6+O6PX/22Q
 7PzKU5rYLV3Toy+WpMim7ytb8SM1O1w9Z2t/2Dx7uO6Yy54SwiMAJEowKBaoBN+vdftLR6wggs0
 vktQAxCq87EvYknDnYhSohVrtaCeLIkTZHukvm5MbVxK3Wsbb5PunHK0SVBbKR6oB1WyM/Tjhi+
 tjRp+ZZzwZPCvTg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21980-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E02345D9A86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nfsd4_sequence() can free the very slot it is currently processing.
When the session shrinker has reduced se_target_maxslots below
se_fchannel.maxreqs, the shrink path checks three conditions before
calling free_session_slots():

  1. se_target_maxslots < maxreqs  (shrink was advertised)
  2. slot->sl_generation == se_slot_gen  (slot is up-to-date)
  3. seq->maxslots <= se_target_maxslots  (client acknowledges)

However, seq->slotid is never checked against se_target_maxslots.
A client using a slot in the range [se_target_maxslots, maxreqs) can
satisfy all three conditions: its slot has the current generation
(set by a prior SEQUENCE), and it sends sa_highest_slotid <=
se_target_maxslots to acknowledge the reduction.

free_session_slots() then kfrees every slot at index >=
se_target_maxslots, including the caller's own slot. The function
continues to write sl_seqid, sl_flags, sl_generation, and stores the
dangling pointer in cstate->slot. Later, nfsd4_store_cache_entry()
copies up to maxresp_cached bytes of the compound reply into the freed
sl_data[] array, corrupting whatever slab object now occupies that
address.

Additionally, a concurrent thread processing SEQUENCE on a different
high-numbered slot can have its slot freed out from under it.
NFSD4_SLOT_INUSE is set under nn->client_lock before the lock is
released, so any concurrent thread past SEQUENCE will have its slot
marked. However, free_session_slots() does not check NFSD4_SLOT_INUSE
before freeing.

Fix both problems by:
 1. Checking that the current request's slotid is below the shrink
    boundary.
 2. Scanning slots in the to-be-freed range for NFSD4_SLOT_INUSE and
    deferring the shrink if any are active.

Fixes: 8fb77d12c76e ("nfsd: add support for freeing unused session-DRC slots")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Assisted-by: Claude:claude-opus-4-6
---
Changes in v2:
- Skip doing the shrink if any potential victims have NFSD4_SLOT_INUSE set
- Link to v1: https://lore.kernel.org/r/20260526-nfsd4_sequence_shrink_uaf_on_loaded_slot-v1-1-504a6a7fd9b4@kernel.org
---
 fs/nfsd/nfs4state.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index d5cbf626ab9b..496a86d4d8a2 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4769,6 +4769,19 @@ static void nfsd4_construct_sequence_response(struct nfsd4_session *session,
 		seq->status_flags |= SEQ4_STATUS_ADMIN_STATE_REVOKED;
 }
 
+static bool nfsd4_slots_inuse(struct nfsd4_session *ses, int from)
+{
+	int i;
+
+	for (i = from; i < ses->se_fchannel.maxreqs; i++) {
+		struct nfsd4_slot *slot = xa_load(&ses->se_slots, i);
+
+		if (slot->sl_flags & NFSD4_SLOT_INUSE)
+			return true;
+	}
+	return false;
+}
+
 __be32
 nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		union nfsd4_op_u *u)
@@ -4848,7 +4861,9 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 	if (session->se_target_maxslots < session->se_fchannel.maxreqs &&
 	    slot->sl_generation == session->se_slot_gen &&
-	    seq->maxslots <= session->se_target_maxslots)
+	    seq->maxslots <= session->se_target_maxslots &&
+	    seq->slotid < session->se_target_maxslots &&
+	    !nfsd4_slots_inuse(session, session->se_target_maxslots))
 		/* Client acknowledged our reduce maxreqs */
 		free_session_slots(session, session->se_target_maxslots);
 

---
base-commit: 97bac3c7a039675d7ae71fbdf3a7c39e840339b6
change-id: 20260526-nfsd4_sequence_shrink_uaf_on_loaded_slot-19843be018ac

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


