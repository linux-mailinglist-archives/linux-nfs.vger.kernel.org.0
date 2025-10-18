Return-Path: <linux-nfs+bounces-15355-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAF3BEC14E
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 02:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EDD5A4F2FD2
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 00:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0C31397;
	Sat, 18 Oct 2025 00:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="KHqOkDsP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LgL8r20y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2881E211F
	for <linux-nfs@vger.kernel.org>; Sat, 18 Oct 2025 00:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760745988; cv=none; b=UPmq7lIyMCB9MChht8Uhrmx8nYsqQJBP3m+3wrryJT4YLj+oIm2EhvflmUwhzbxFBGpEj+ss+FCUjNgTS547bzijsIiIN4/JVhLeXcCybMyKaVXYYYgL0RK1UWt1Q8/3sAxDuCnkq6PO6zJ5ndfH6Gr5xxrLiWyKjlebnGsaMAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760745988; c=relaxed/simple;
	bh=tikNUUF2SomQ0SnV7A2Fzcf8HqmmlYoOTqSnZgXfrmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kCVcIm/2bcvy4AnluPRh+/OsFyLg370KMco3XI/3hV7eK9Uw4BRSE5RHEjf/gFuU0dEQCrkYAA/nKafD/atnlpLjfeLqFhPs1G2JCq0wSOKpfgitiev8CQO84UYFp40kUwaq0J4YLWVmn5ZBvlFC9jNFXts4YcviodgzUn5Pkf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=KHqOkDsP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LgL8r20y; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5E4E77A0100;
	Fri, 17 Oct 2025 20:06:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 17 Oct 2025 20:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1760745986;
	 x=1760832386; bh=QKKJU+TK/DFwIcA01Fk7Byry2TGayRtQ0cbf6Xa39SA=; b=
	KHqOkDsPMYWQ08kqvduKVpTz+Stx4DaOQG4CFRI9B4pCdgXnWhPuRhsp4uYFQjwf
	v4v1TlGW0M5jGF++q8Vw03bHgin854vNOI1zSedbOKDrab3zRPy/Hqgb0ms5K1hT
	DG+KJQ/eXuF6rDCHtuACE5/kz7KBn9xTIr4yyTfiR6TN/VgQjIJJuwj0rd9GJTgt
	yfK3S0GXSkSTyzvin7ZpOWP0kU5em+H8ciB/8GbUNm8EJpze1K5Omx4KJZKJh+LD
	/YKHnAL/2j2UXUIoG2QqwdZ/4aIiI0H98FKbABnFAKWbcTCAV7iKqN86iP1hITDX
	a2tzFFpEntlU66G4ufBC5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760745986; x=1760832386; bh=Q
	KKJU+TK/DFwIcA01Fk7Byry2TGayRtQ0cbf6Xa39SA=; b=LgL8r20yh0kw++Bno
	z7grCTnXNrvsP0tFNHIBHRzy+NYjVXi/+R0Hv2ThqYgfh0d2rcEbCTlvFZ3d1TQ8
	GK5iqXZkuGEsdgRWN1NoajloQFW7POAWWmlUjralJRWPkAwLTRtY8tjojcwYUDjc
	bub8+q9+JN94WLyhJKekF6bof8Vg3aXSFXDr/kGpCWAVYqAQ27EcDBtiYZCgXBsE
	qmGwawZkCEQ9Tq4dQPtkC9uZCpvPlZlLf/B4a5RBj8We6a9a7El85FSvWqfVpeyO
	Rbm2etBucRrGN3NIZg4/9QV2lTDfykeTQfFwgxhym4EEs3wG7CIr2MuzIu4y+OHf
	DYtug==
X-ME-Sender: <xms:AtryaKphweTQ6eSuIh8Wl5rgOezks7WEmM7l2C4lSyP5FWcje3u_Wg>
    <xme:AtryaMWSPpApPb_ay8vb_fXsBoc0aI5fU1vrofUSnug-buH_9XwN28tUjRqrJgarV
    ns11KH7Y0bC2s1VUTBDN9r5uLS2QY1pzb9646Si6v9RR9-zAMU>
X-ME-Received: <xmr:AtryaJDW4A7rKuycWEtgddEEbACKpoSBaJHP-aztn4xR1E8SEcUr-DmzIbcpUuE9QqwXW0LPXo-4-c6c3L9p3Tx52lG6oBGxEVTcMpTVrv6u>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufedtheejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:AtryaA0rLufEOJv4jVpwIKroghpuSLl5T9c329D6KhbpdU7P2RX4Uw>
    <xmx:AtryaL3Rx0W7xCzJXQfS8xoT5cwvRj5vgeDtsnJISEf3NGcnGkG7Nw>
    <xmx:AtryaFA68AuIi6_e39DFQpQfn9fLd3VIuTPzeO0GlmITsN6-HTpnug>
    <xmx:AtryaK4qdRmVB7ytzJRvQOMKqM8i1_KgU-VdCYJJCS8od5VKMO-w2g>
    <xmx:AtryaEIrKt81V__K4dXIvoqCWz8o8_wDAVFiKIYabtir_hqdNKvI--2c>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 20:06:23 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 5/7] nfsd: replace sid_flags with two bools.
Date: Sat, 18 Oct 2025 11:02:25 +1100
Message-ID: <20251018000553.3256253-6-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251018000553.3256253-1-neilb@ownmail.net>
References: <20251018000553.3256253-1-neilb@ownmail.net>
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
use to bools for the two flags stored in sid_flags, and access them directly.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c  |  8 ++++----
 fs/nfsd/nfs4state.c |  6 +++---
 fs/nfsd/xdr4.h      | 10 ++--------
 3 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 944f10a08c77..7b6a40cf8afd 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -717,9 +717,9 @@ nfsd4_restorefh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		return nfserr_restorefh;
 
 	fh_dup2(&cstate->current_fh, &cstate->save_fh);
-	if (HAS_CSTATE_FLAG(cstate, SAVED_STATE_ID_FLAG)) {
+	if (cstate->have_save_stateid) {
 		memcpy(&cstate->current_stateid, &cstate->save_stateid, sizeof(stateid_t));
-		SET_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
+		cstate->have_current_stateid = true;
 	}
 	return nfs_ok;
 }
@@ -729,9 +729,9 @@ nfsd4_savefh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	     union nfsd4_op_u *u)
 {
 	fh_dup2(&cstate->save_fh, &cstate->current_fh);
-	if (HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG)) {
+	if (cstate->have_current_stateid) {
 		memcpy(&cstate->save_stateid, &cstate->current_stateid, sizeof(stateid_t));
-		SET_CSTATE_FLAG(cstate, SAVED_STATE_ID_FLAG);
+		cstate->have_save_stateid = true;
 	}
 	return nfs_ok;
 }
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 59abe1ab490d..dbf5300c8baa 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9081,7 +9081,7 @@ nfs4_state_shutdown(void)
 void
 get_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
 {
-	if (HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG) &&
+	if (cstate->have_current_stateid &&
 	    CURRENT_STATEID(stateid))
 		memcpy(stateid, &cstate->current_stateid, sizeof(stateid_t));
 }
@@ -9090,13 +9090,13 @@ void
 put_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
 {
 	memcpy(&cstate->current_stateid, stateid, sizeof(stateid_t));
-	SET_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
+	cstate->have_current_stateid = true;
 }
 
 void
 clear_current_stateid(struct nfsd4_compound_state *cstate)
 {
-	CLEAR_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
+	cstate->have_current_stateid = false;
 }
 
 /**
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 0ca30a92d40c..7218c503e5fe 100644
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
@@ -194,7 +187,8 @@ struct nfsd4_compound_state {
 	stateid_t	current_stateid;
 	stateid_t	save_stateid;
 	/* to indicate current and saved state id presents */
-	u32		sid_flags;
+	bool		have_current_stateid;
+	bool		have_save_stateid;
 };
 
 static inline bool nfsd4_has_session(struct nfsd4_compound_state *cs)
-- 
2.50.0.107.gf914562f5916.dirty


