Return-Path: <linux-nfs+bounces-15834-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FBAC232AB
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 04:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B8613BF4C0
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 03:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061AA28E5;
	Fri, 31 Oct 2025 03:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="C+oMzEVn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZRWlUR+x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0E725CC7A
	for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 03:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761881188; cv=none; b=umlmeSj+hSeoBQtGRjfnot28cMBUW6IyBml5WmqKo91w6/N+ssqMi48rvpkSUGr7/MO2LIurQONUmB1D/UjFGwYeXTYL/796WFktqkwANt4bE4N3kvaEjrf36zGa0fLnGLsACUgt0zEa/8JYdszJibE3ZzvR4+j1ZZ2GvNVvmqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761881188; c=relaxed/simple;
	bh=MpRqnmJCAtOu8bUiXWlxuD2GNKy8AgnnNKKNCPTG8FI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jg7t4/8VCndApmJ93+KFsTmlcfwsLkaVdyO1+BmpYBML0XfLWaMjVln/yZDODXROlNkzEuZXAX84wrhBSI2xHcpMqiIA2tFcJeo3+hROFK1YzNY7X0MVDiJjUN+UWYh7/jpqmtjB3PjJpNofUlcLmypdB2XoVzZPwR1TpGzUdj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=C+oMzEVn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZRWlUR+x; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 89D217A0163;
	Thu, 30 Oct 2025 23:26:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 30 Oct 2025 23:26:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1761881186;
	 x=1761967586; bh=ElCetH2HGaRsB3oRql/UxbY9JVSGdDxysJp9hhEF3BQ=; b=
	C+oMzEVnuF97cJl+IBjshQBzo3GLKD3utRA21cZdpcgQPBa2zB4dc6eOyOWuAPoC
	FFX9ZN9rmIMhFr8fCO+UQuxaVjYFllcPSUrmt67fpPMxiLEf6WliOsQagOU6F+Yu
	GRWhMqmkPBU4jjdzb3l4pKjpWSY+PqPrYmgFG3eIzg2sLkRjwrKB/ujz7GzEvzw1
	K8PgYC6C8lBCVK0L6XjVDRFx3iQaT/uVNHpuoDjrM9FalBgW/gkH/oCQD+mihJcf
	wTV1qolT3Zcfnm+d++QZvtq4eMC5FnKVBSUSOV5YRrVgL6eEsaj+zQcWy+D9Z+7P
	jg2Oygo7MsAeHvBP5ue2CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761881186; x=1761967586; bh=E
	lCetH2HGaRsB3oRql/UxbY9JVSGdDxysJp9hhEF3BQ=; b=ZRWlUR+xChMQPoEUx
	drCt60d/vjnZwtBUwLNGJmshKMO6N/Om8+ckTcSxM/WDGQHQqNJXabJ1KKlYOox8
	FWCuugGajKNXMeu1iCWvo/1AenewzQDGbmi7YC5E9K2VDoBy2R6ye/L9ISHzj6Jb
	6Gi9SBpN8HiskH9vpOAVMNe+xzTVQTG9uEmRsH+B97Sqwdi3D9YHIBvclnjkW0cN
	frOterW9/P8SglxVPIoXawqAN6pi5QC0ryWmiU2qDM0TzDmtLXfUvBXhWVnRwhMP
	bux05BA4/ym+/aZlx5nL5ULPmhaiMtZloBwuJAtW66dF87GX4IkRssZIwTQHZek5
	Hq5pA==
X-ME-Sender: <xms:YiwEaZfJEbwHL2mOQ0-BN4zk0iTGDIEQNeZePk2iFepiMN3WRJkFUA>
    <xme:YiwEaa7AVc9gDsWm0oKsFQCMwZapvjgQLiEuv9CalWRKBfMsqjDrT9UhVR8dGl6xR
    yhhWaP4dM4Ouz7lofyEUpaPPSEfOf6UIiXGcoNaq6nzWKzm>
X-ME-Received: <xmr:YiwEacW4yh8tvum1fOc9DaA0owRs1MAZ0mlbi4iYXKYnDmPe5wDRpom4pXWU6raj79NHKVzJ_aIb85yk9cBl_JmsOz-htUxebFOvIwLAb_39>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesoh
    hrrggtlhgvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:YiwEaZ4Z27p4j6wq0mfxLmgyLmrEhmBUM2_QIb82T2VcHciT4CWS9Q>
    <xmx:YiwEaXqra3CkY3CSAVeTPNevBZCUo_ymdZ5igaGg1ZEQXVzbOnfANw>
    <xmx:YiwEacm9jwmMhKnG7Iuc2bPnkV7727ONeMGH0yLIdmdQIT8YkMHyLQ>
    <xmx:YiwEaTPbCogsfp-Qn2w7WqSvSDMxUMulqrXr4A010hR7jKR3Pp5VVQ>
    <xmx:YiwEaW_dBcLuTDmNLylcYU05-Kbi7fPC4lJgRz7S0ugGFiHwgB9xennr>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 23:26:24 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v4 10/10] nfsd: conditionally clear seqid when current_stateid is used.
Date: Fri, 31 Oct 2025 14:16:17 +1100
Message-ID: <20251031032524.2141840-11-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251031032524.2141840-1-neilb@ownmail.net>
References: <20251031032524.2141840-1-neilb@ownmail.net>
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

Linux NFSD does not current follow this guidance.  The seqid (known as
si_generation) is left unchanged.

This patch introduced a new status flag SC_STATUS_KEEP_SEQID which is
only used for lookup requests and sets it for the two exceptions: CLOSE
and OPEN_DOWNGRADE.  When this flag is not present, the value copied
from the current stateid has the si_generation (aka seqid) cleared.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4state.c | 24 +++++++++++++++---------
 fs/nfsd/state.h     |  6 ++++++
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 515c78226a11..553ed2c1677b 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7185,6 +7185,8 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 		if (!cstate->current_fh.fh_have_stateid)
 			return nfserr_bad_stateid;
 		memcpy(stateid, &cstate->current_stateid, sizeof(stateid_t));
+		if (!(statusmask & SC_STATUS_KEEP_SEQID))
+			stateid->si_generation = 0;
 	}
 	/*
 	 *  only return revoked delegations if explicitly asked.
@@ -7508,6 +7510,7 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		if (!cstate->current_fh.fh_have_stateid)
 			return nfserr_bad_stateid;
 		memcpy(stateid, &cstate->current_stateid, sizeof(stateid_t));
+		stateid->si_generation = 0;
 	}
 
 	spin_lock(&cl->cl_lock);
@@ -7630,15 +7633,17 @@ nfs4_preprocess_seqid_op(struct nfsd4_compound_state *cstate, u32 seqid,
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
@@ -7736,7 +7741,8 @@ nfsd4_open_downgrade(struct svc_rqst *rqstp,
 			od->od_deleg_want);
 
 	status = nfs4_preprocess_confirmed_seqid_op(cstate, od->od_seqid,
-					&od->od_stateid, &stp, nn);
+						    &od->od_stateid, &stp, nn,
+						    SC_STATUS_KEEP_SEQID);
 	if (status)
 		goto out; 
 	status = nfserr_inval;
@@ -7806,7 +7812,8 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 	status = nfs4_preprocess_seqid_op(cstate, close->cl_seqid,
 					  &close->cl_stateid,
-					  SC_TYPE_OPEN, SC_STATUS_CLOSED,
+					  SC_TYPE_OPEN,
+					  SC_STATUS_CLOSED | SC_STATUS_KEEP_SEQID,
 					  &stp, nn);
 	nfsd4_bump_seqid(cstate, status);
 	if (status)
@@ -8299,10 +8306,9 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
index c6e97d6daa5f..7566f6b6949b 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -138,6 +138,12 @@ struct nfs4_stid {
 #define SC_STATUS_ADMIN_REVOKED	BIT(2)
 #define SC_STATUS_FREEABLE	BIT(3)
 #define SC_STATUS_FREED		BIT(4)
+/*
+ * Ops other than CLOSE and OPEN_DOWNGRADE which use the "current stateid"
+ * must clear the seqid (aka si_generation). Follow flag is never stored
+ * in states but is passed through to request the seq not be cleared.
+ */
+#define SC_STATUS_KEEP_SEQID	BIT(5)
 	unsigned short		sc_status;
 
 	struct list_head	sc_cp_list;
-- 
2.50.0.107.gf914562f5916.dirty


