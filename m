Return-Path: <linux-nfs+bounces-16663-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DB100C7C0B3
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 01:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6F7F3362879
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 00:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EDA218AAD;
	Sat, 22 Nov 2025 00:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="C3YmfxN8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yt7ujZwE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F771DF736
	for <linux-nfs@vger.kernel.org>; Sat, 22 Nov 2025 00:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763772830; cv=none; b=NSKCmGO6Mgt/LI62EXXf7uw3zkwEiam1MOGwgOxlNmUff2cXyYHGYhuLJXf9XNdChVDrKvmG8VaO4VJnEubaA7ChkRF/Dsgs/QI7p44kazlJTHOouZXm4hPRW0ERT6cKSb2oxy3WONEKe4TBwSA8mMr3A6JCutMjYaeP28iiTRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763772830; c=relaxed/simple;
	bh=bqMl7AuG/BIWWTv+w+U/zCn/4Pv4eFyLjfyTvwHaFg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=emCv0Rl3MMcgx5hb/39gV9miF5AmJ3w4p2s6vW8MKMlNX7sjppuIs+VxXX+B7K8n2O73bogD9PGQXl/Y++1Zk85ZEi7chTd23QOjeQXmsWbZL5SSe1axG5FjCoGdKLRoxToFSzs//696KHiPFPPEWOw7ts1NYMZiF1wfG/RYpI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=C3YmfxN8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yt7ujZwE; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6A465140009C;
	Fri, 21 Nov 2025 19:53:46 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 21 Nov 2025 19:53:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1763772826;
	 x=1763859226; bh=TKmcYM4mItX1mYkljYjnfvBlXL9B/gfIDYt97gOsKMM=; b=
	C3YmfxN80uBJ5Vuiu2g2MyyCbqI0qzV31dUzubwkGuo5rxD0bE3ejPr6hfsj6AKh
	asJY13G0id9XxxxBpILykPUQnO254ijOD73cpuhkuBrLGBCKKqPReww18pQfHcKd
	zVZh5Di6lDz5WId8c8VklqLBKtzaI/YCnyYJeJ/RypverhR/y278oXychgEVEnEv
	+D7lelU6ScUWyuI8Ub1qkJCM4RBWaMyC7vUA1TA2omHsS7DRmVy2hLPl2nsXF/jP
	/NJb+uL5QnJarbNWIZ7nPBbbUuOYbQ4x6L18jGaYnfJFg2bcpfxRPV5aA1dVhoEJ
	wgTLQqwwALrRjAG8OX8RJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763772826; x=1763859226; bh=T
	KmcYM4mItX1mYkljYjnfvBlXL9B/gfIDYt97gOsKMM=; b=Yt7ujZwEpi0ya02Mj
	uNKwEzNpKxmDgSBuKiBqWhhyN7m7Kv/hXYQtI2m5BtyqYbJSQEZveugF/+Sal8V0
	M6nSL3MgXf6wqinPFe7LbR2KKXATBM9kdGycO3cA6NOzMfEKm9+Xcz85Cd4oQG0D
	TmqLIyn2IFhq6sb1HWGy61elEH98sZmL7r2qKxwog6By943RrLL6HDtc+BKXu8HR
	2KizCKZlveOtVwYSD7p1h3WQ9cBtEC8/bBnuhjNJ/gJTTx+ZyLK+19eQ2TfAqF+R
	stDpJq6+tKNdfDlpQEHzYszzS9wwXk7HxlNvbvLzoilkuRIsHZpF/VTyEMwI4rqP
	CkqEw==
X-ME-Sender: <xms:mgkhabyOHRP_nY9oVBOifnBlJwc7gzM-i2rWBf7ltr-3CksoDxdxNA>
    <xme:mgkhaW_vk0bdXvc6mkyYdaOeboNgZCzsDjJUzrqYh3_hpp6WLTBNV4deKUajw66M3
    ngNKtALc24cf_m3z43X1yZOwhBaSW67ZYQcse5FxDlkbHvws5w>
X-ME-Received: <xmr:mgkhafIGMjt1hsf7mNItog-eK1Qsb_qXPNYMGByut46ldEFMMv8BsVyQzH07D_RX58dobQl_VLWjZFt7jDirs0uc7ecVntbZiODoSOl6y5cu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedugeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesoh
    hrrggtlhgvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:mgkhacfQj03Wkwe67expYFafj8S3-3X1bOJrgEEwaCcjGy68nf8OEA>
    <xmx:mgkhae99uKtVWet_qbrJjBmFOluR5GVO8s7lQ1xWCtUCtYFsBxt7UA>
    <xmx:mgkhaZp3NsjTvKFdT6zj8fhkfezKSON3HRJauFNwPj3TpDKvVVchZA>
    <xmx:mgkhaTC_pQoL-t6lw31wtmYNKxkkSdxkOoRnV0a-mGh2wfeoJKT-fw>
    <xmx:mgkhadSiSM30PbwYyLIvAMJfYAppTSYXm-LcH1kgt4U_qdAS1UxxxSf5>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 19:53:44 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v6 14/14] nfsd: conditionally clear seqid when current_stateid is used.
Date: Sat, 22 Nov 2025 11:47:12 +1100
Message-ID: <20251122005236.3440177-15-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251122005236.3440177-1-neilb@ownmail.net>
References: <20251122005236.3440177-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

As described in RFC 8881 scions 8.2.3 on Special Stateids:

    The stateid passed to the operation in place of the special value
    has its "seqid" value set to zero, except when the current stateid
    is used by the operation CLOSE or OPEN_DOWNGRADE.

Linux NFSD does not currently follow this guidance.  The seqid (known as
si_generation) is left unchanged.

This patch introduces a new status flag SC_STATUS_KEEP_SEQID which is
only used for lookup requests and sets it for the two exceptions: CLOSE
and OPEN_DOWNGRADE.  When this flag is not present, the value copied
from the current stateid has the si_generation (aka seqid) cleared.

A situation where this might produce a different result is if an
  OPEN WRITE
request which makes use for current_stateid for the WRITE races with
another request which OPENs the same file (possibly via different name)
and that OPEN happens between the OPEN and WRITE in the first request.
The second OPEN would update the seqid on the stateid of that file and
prior to this patch, the WRITE would fail.  After this patch the WRITE
will succeed.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4state.c | 24 +++++++++++++++---------
 fs/nfsd/state.h     |  6 ++++++
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 67afa253f408..c1dcc332b22c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7201,6 +7201,8 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 		if (!cstate->current_fh.fh_have_stateid)
 			return nfserr_bad_stateid;
 		memcpy(stateid, &cstate->current_stateid, sizeof(stateid_t));
+		if (!(statusmask & SC_STATUS_KEEP_SEQID))
+			stateid->si_generation = 0;
 	}
 	/*
 	 *  only return revoked delegations if explicitly asked.
@@ -7522,6 +7524,7 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		if (!cstate->current_fh.fh_have_stateid)
 			return nfserr_bad_stateid;
 		memcpy(stateid, &cstate->current_stateid, sizeof(stateid_t));
+		stateid->si_generation = 0;
 	}
 
 	spin_lock(&cl->cl_lock);
@@ -7644,15 +7647,17 @@ nfs4_preprocess_seqid_op(struct nfsd4_compound_state *cstate, u32 seqid,
 	return status;
 }
 
-static __be32 nfs4_preprocess_confirmed_seqid_op(struct nfsd4_compound_state *cstate, u32 seqid,
-						 stateid_t *stateid, struct nfs4_ol_stateid **stpp, struct nfsd_net *nn)
+static __be32
+nfs4_preprocess_confirmed_seqid_op(struct nfsd4_compound_state *cstate, u32 seqid,
+				   stateid_t *stateid, struct nfs4_ol_stateid **stpp,
+				   struct nfsd_net *nn, unsigned short statusmask)
 {
 	__be32 status;
 	struct nfs4_openowner *oo;
 	struct nfs4_ol_stateid *stp;
 
 	status = nfs4_preprocess_seqid_op(cstate, seqid, stateid,
-					  SC_TYPE_OPEN, 0, &stp, nn);
+					  SC_TYPE_OPEN, statusmask, &stp, nn);
 	if (status)
 		return status;
 	oo = openowner(stp->st_stateowner);
@@ -7750,7 +7755,8 @@ nfsd4_open_downgrade(struct svc_rqst *rqstp,
 			od->od_deleg_want);
 
 	status = nfs4_preprocess_confirmed_seqid_op(cstate, od->od_seqid,
-					&od->od_stateid, &stp, nn);
+						    &od->od_stateid, &stp, nn,
+						    SC_STATUS_KEEP_SEQID);
 	if (status)
 		goto out; 
 	status = nfserr_inval;
@@ -7820,7 +7826,8 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 	status = nfs4_preprocess_seqid_op(cstate, close->cl_seqid,
 					  &close->cl_stateid,
-					  SC_TYPE_OPEN, SC_STATUS_CLOSED,
+					  SC_TYPE_OPEN,
+					  SC_STATUS_CLOSED | SC_STATUS_KEEP_SEQID,
 					  &stp, nn);
 	nfsd4_bump_seqid(cstate, status);
 	if (status)
@@ -8312,10 +8319,9 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 				sizeof(clientid_t));
 
 		/* validate and update open stateid and open seqid */
-		status = nfs4_preprocess_confirmed_seqid_op(cstate,
-				        lock->lk_new_open_seqid,
-		                        &lock->lk_new_open_stateid,
-					&open_stp, nn);
+		status = nfs4_preprocess_confirmed_seqid_op(
+			cstate,	lock->lk_new_open_seqid,
+			&lock->lk_new_open_stateid, &open_stp, nn, 0);
 		if (status)
 			goto out;
 		mutex_unlock(&open_stp->st_mutex);
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index c6e97d6daa5f..6043baf10ceb 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -138,6 +138,12 @@ struct nfs4_stid {
 #define SC_STATUS_ADMIN_REVOKED	BIT(2)
 #define SC_STATUS_FREEABLE	BIT(3)
 #define SC_STATUS_FREED		BIT(4)
+/*
+ * Ops other than CLOSE and OPEN_DOWNGRADE which use the "current stateid"
+ * must clear the seqid (aka si_generation). Following flag is never stored
+ * in states but is passed through to request the seq not be cleared.
+ */
+#define SC_STATUS_KEEP_SEQID	BIT(5)
 	unsigned short		sc_status;
 
 	struct list_head	sc_cp_list;
-- 
2.50.0.107.gf914562f5916.dirty


