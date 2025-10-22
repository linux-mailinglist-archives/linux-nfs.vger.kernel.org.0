Return-Path: <linux-nfs+bounces-15555-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 748D9BFE700
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 00:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37B614E7123
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 22:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0836B26F443;
	Wed, 22 Oct 2025 22:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="NSQuzKuB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k1xJp0qD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56959289376
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 22:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761172683; cv=none; b=VTP45UHGQ3XO+gn38QstQjhAzsmzoXFYSv3sIOd+xoUfHzeOUT5dA5b4jFNotg9TFtIWmb6largkJhgebK6jWDneTj9DTv6aMbsbJeh3HcMQ6AK9bY48pSwu5Ka8zRiHX+HV/vGC01cC+Vnyn+M9XmP1n+fNg/JY9b0JlWAqC9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761172683; c=relaxed/simple;
	bh=quA7haAz5tU0jcSgJd28RCszAQk00873mJH0rQN4SsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3SBOqz9D+8Aa6UZvTf87xEdWaMCvmZUGowvYlhcC4iAdFWVNqy2k0dwtmq1tZrwGGMkigAC2I65Lar5Qd3Zu4yNu+mWJpasZz2QZtz607uGdiPD5+7yBTjoeuPMTAalqMaiEooQAjD8ts+N8T///6IyB8dKsGQ9eQ3zidzgxxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=NSQuzKuB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k1xJp0qD; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 87F0AEC01C2;
	Wed, 22 Oct 2025 18:38:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 22 Oct 2025 18:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1761172680;
	 x=1761259080; bh=hStpnVk7btk5IiGNXJoMnFSjiyU0U7iIki9maEqjOWI=; b=
	NSQuzKuBp4mwhDMvYDoqF0weyoCwMkNUyr+p7t4h0K0yiHfat+0uIWfdfY4MGee7
	qJeSo37Rie0fYIlDOhLqn+Zh89ISSH9OhGCnvWDZiNTGtIqKFggXCGQAsn8ITHyj
	uvNjKi85L3bpFr8ureHUsgboadyZp9wDGHWjbl0ukwDfbAdVee8zznDxk8IVvK35
	TcuHXdCqWgGHHVfzQN4iQeOdvkZymT2SzAoLoVpG2qF7Ax8XBhymZSWdoNArL8eZ
	UZGkktmnNi2KH22+3EzLEhUWU5zawYzk3H0LJ1vvP4HdI7rBes+PwxOD+8S/+Rzz
	m7ZH62LsG+m+F3canl0QDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1761172680; x=1761259080; bh=h
	StpnVk7btk5IiGNXJoMnFSjiyU0U7iIki9maEqjOWI=; b=k1xJp0qDDWu3+SUFC
	ShDfa1Q32KHf6uyCWMNZiKsQLlyPKI8c3x2v8DY+i96D0qunnZSLq3ODd9Z6pb9/
	o+IvpmL0yG9bmVx8MfUmZdfkSxiijuMb7xdbmMfqhKOExTfP4l53eJjt2fmOjFaT
	2CV6kAK+LKDcBg9Ci9wFbcEzDgCOydZpMQoyEcdQ0wqJaV91tqGCwsjxo2EXC+J5
	3FB83fOnjitfOPF17IgDE2Uw/3Amz8tKpp70XlRbbBnRI4GHn+WjCQFDwZGYEfMh
	8TiCExHeWsL1oG+umM+FTDRvvBIi3xZoJulWlXbzEAznT7sHzWvSI2RjUBZAh4ye
	mKrHg==
X-ME-Sender: <xms:yFz5aJyQVP_dIPIhGheyoGWvWNn0lzc2_wb9Jr7SHsqmrBrAiK5CFw>
    <xme:yFz5aM_7LkB-eVRsrAW-k0nx1pVOabE3h_watkxUMQlkJIXpicqsI9BOBJkVrwDqH
    7Z5aox_rkC4G7Aq-e7n3a_3xOc3mTVR-9GzEwxxHJswJoWpWA>
X-ME-Received: <xmr:yFz5aNKL1HfyvANFjIziq5N58YPJrkABnOZb49bxps8h3Qz1ce5unfJSSbmM71T_Q9ZD0XosHu54d39jtCFzz_c5Zi-V-5TzB-S89L07gIul>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeegkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesoh
    hrrggtlhgvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:yFz5aCeko-BdM6NuAju7PB9jixF7djzayW25lEvG1C8wsTVu7zqIwg>
    <xmx:yFz5aM-9kTcSWWjM84NjYww3eoLS2lXqkRx8jlwucEIK5wdoPNUOdw>
    <xmx:yFz5aPrpmaWpvgfdsL5d6eSzlqgDB8M0r6VHMt9cPINDxSUPjfmxpA>
    <xmx:yFz5aBCyP1d_6DETtLNskw-cINzUD9PxuErrL5Wnd7SoIvRTNPpTMQ>
    <xmx:yFz5aLS8wJX99Ccoy1MEPK_KQm7OE2rScvPY1UyvKVR_l_spFxmcJUOc>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 18:37:58 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 8/8] nfsd: replace sid_flags with two bools.
Date: Thu, 23 Oct 2025 09:34:35 +1100
Message-ID: <20251022223713.1217694-9-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251022223713.1217694-1-neilb@ownmail.net>
References: <20251022223713.1217694-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

Rather than having accessor macros (which I find to obscure the code),
use two bools for the two flags stored in sid_flags, and access them directly.

Also rename "save_stateid" to "saved_stateid" and align all fields in
struct nfsd4_compound_state.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c  | 12 ++++++------
 fs/nfsd/nfs4state.c |  4 ++--
 fs/nfsd/xdr4.h      | 20 +++++++-------------
 3 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 235fd27861b8..3dcd6bff7599 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -716,9 +716,9 @@ nfsd4_restorefh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		return nfserr_restorefh;
 
 	fh_dup2(&cstate->current_fh, &cstate->save_fh);
-	if (HAS_CSTATE_FLAG(cstate, SAVED_STATE_ID_FLAG)) {
-		memcpy(&cstate->current_stateid, &cstate->save_stateid, sizeof(stateid_t));
-		SET_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
+	if (cstate->have_saved_stateid) {
+		memcpy(&cstate->current_stateid, &cstate->saved_stateid, sizeof(stateid_t));
+		cstate->have_current_stateid = true;
 	}
 	return nfs_ok;
 }
@@ -728,9 +728,9 @@ nfsd4_savefh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	     union nfsd4_op_u *u)
 {
 	fh_dup2(&cstate->save_fh, &cstate->current_fh);
-	if (HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG)) {
-		memcpy(&cstate->save_stateid, &cstate->current_stateid, sizeof(stateid_t));
-		SET_CSTATE_FLAG(cstate, SAVED_STATE_ID_FLAG);
+	if (cstate->have_current_stateid) {
+		memcpy(&cstate->saved_stateid, &cstate->current_stateid, sizeof(stateid_t));
+		cstate->have_saved_stateid = true;
 	}
 	return nfs_ok;
 }
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 4cdf8668eb10..bb002e568811 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9113,7 +9113,7 @@ void
 nfsd41_get_current_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
 {
 	if (nfsd4_has_session(cstate) &&
-	    HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG) &&
+	    cstate->have_current_stateid &&
 	    IS_CURRENT_STATEID(stateid))
 		memcpy(stateid, &cstate->current_stateid, sizeof(stateid_t));
 }
@@ -9133,7 +9133,7 @@ void
 nfsd41_save_current_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
 {
 	memcpy(&cstate->current_stateid, stateid, sizeof(stateid_t));
-	SET_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
+	cstate->have_current_stateid = true;
 }
 
 /**
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 909318f8fdd3..4bf25eadc80e 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -43,13 +43,6 @@
 #define NFSD4_MAX_TAGLEN	128
 #define XDR_LEN(n)                     (((n) + 3) & ~3)
 
-#define CURRENT_STATE_ID_FLAG (1<<0)
-#define SAVED_STATE_ID_FLAG (1<<1)
-
-#define SET_CSTATE_FLAG(c, f) ((c)->sid_flags |= (f))
-#define HAS_CSTATE_FLAG(c, f) ((c)->sid_flags & (f))
-#define CLEAR_CSTATE_FLAG(c, f) ((c)->sid_flags &= ~(f))
-
 /**
  * nfsd4_encode_bool - Encode an XDR bool type result
  * @xdr: target XDR stream
@@ -187,14 +180,15 @@ struct nfsd4_compound_state {
 	struct nfsd4_session	*session;
 	struct nfsd4_slot	*slot;
 	int			data_offset;
-	bool                    spo_must_allowed;
+	bool			spo_must_allowed;
 	size_t			iovlen;
 	u32			minorversion;
 	__be32			status;
-	stateid_t	current_stateid;
-	stateid_t	save_stateid;
-	/* to indicate current and saved state id presents */
-	u32		sid_flags;
+	stateid_t		current_stateid;
+	stateid_t		saved_stateid;
+	/* to indicate current and saved state id are present */
+	bool			have_current_stateid;
+	bool			have_saved_stateid;
 };
 
 static inline bool nfsd4_has_session(struct nfsd4_compound_state *cs)
@@ -216,7 +210,7 @@ void nfsd41_save_current_stateid(struct nfsd4_compound_state *cstate,
 static inline
 void nfsd41_clear_current_stateid(struct nfsd4_compound_state *cstate)
 {
-	CLEAR_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
+	cstate->have_current_stateid = false;
 }
 
 struct nfsd4_change_info {
-- 
2.50.0.107.gf914562f5916.dirty


