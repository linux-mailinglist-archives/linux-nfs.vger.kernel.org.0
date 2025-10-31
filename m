Return-Path: <linux-nfs+bounces-15827-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5C7C2329F
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 04:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 559DD4EA4BE
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 03:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A487E26B96A;
	Fri, 31 Oct 2025 03:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="TsQpkJDM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B0tmlENa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C364C28E5
	for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 03:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761881155; cv=none; b=gMitfR0wY0W3AEysdnfraFjAjktiE/AFM6rdfX9uGtyENkLT47Yzk7kCDb30BpLNkDiowWlYxCX68PUaMIFHRRDuRAQ+ScqedXd8uqiBMgsBe3c2dWmGgDUFKu4B1uaWl6f9gPEfjfjOsCwi1YrWQfZj/sN8er03kxTRUiphDnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761881155; c=relaxed/simple;
	bh=NcXQH0E6kEVTOswr0jSzIqXApQEVDlDTJAu+gq1ZnGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u65GI3/s6g1f3ezO9ck+bzZQoUJ37BSSJnr0g6gH5xvi9wDz9AaHq8X2R5fs/1pqaklbjAXzqUedVhVpX2vSgm5H6SW6w5azPL30QCwbmcifN2o+uJEIuIAcImdjn4oEkYRR06d0SrYmJCdw4KJ4VVRNqpmZPMbUIj/ThEuZ7hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=TsQpkJDM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B0tmlENa; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F14A07A016F;
	Thu, 30 Oct 2025 23:25:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 30 Oct 2025 23:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1761881152;
	 x=1761967552; bh=zCezXxDJR5XX7/jLqJGxA2Uy8983UqMsaMTIFesk1gQ=; b=
	TsQpkJDMuusWusuiP37ry+Kxv+ylZEGnI19SYmqEYWqEr2PYECq3ZXObHljtglf+
	O4ymdzBe3Twz6SaDkqqJvvnNA0OVsMG9FKngjNHOHXMzBsePDacGrpZL+40GXyk3
	4VkA7XHmIcrb00JNwajFdF5tkNEy6glFJBnjQHcwEroOFnCM6cGz1ZzU1sBHKKDw
	Pj3X0vXnUr7ZBjSeNRjtvJ2GDhCmtCk97XePZ3OIq8YpUi2YUE9xFjsffqalHi+F
	5NuZ2t8HKVeeIWt2RzWRXnszh5fFgff6J8LwfE6fHheTh3cymTe4cmJKRHA75UEV
	zZLjUCEvhOJ3fB6M3y2DSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761881152; x=1761967552; bh=z
	CezXxDJR5XX7/jLqJGxA2Uy8983UqMsaMTIFesk1gQ=; b=B0tmlENaNr2Gt3jMJ
	eEYfl4+C83GlNQfDLU5GHKWG4o82tQ5IuJXYIccmPu/W3STaFycrWh5iOfds4z8K
	kGcb6hB7baHQljqhDiDtAc4COvAEP0YvfwS+yEOb5M7JzZWlf6qXEW+P4hGXzSUt
	2bqSdYA0pTfE8YCGw1kprclxkO8vDWaXNDMGfN/WPUmLG9rSyyd0/u0QYa92Ut8l
	Pk4WJCGAyM1Rn6EsKSeBl5Jyo2Ctxo3sDlZbCyQ6bj5F6E3LcR78WyGtLqEr/o3G
	r1MBf8YbRRpQ/gFFvmeWzFWbJgWINAsvNZpHQf9Z+Jxb8jolhXtplcwfcbm1jd+x
	t/IHw==
X-ME-Sender: <xms:QCwEadmXUr-mwytWAfOfW8Tz-b_zSEy9chrwej7YRB2_L6EOcsaacw>
    <xme:QCwEacjeFMw_RnCvYLMeNx7MxANVcOW0tDTEB5U1rqLxmwG5SbyhpI07Yf9T0xNi1
    WctBSxvricAPMnJsktF7s64qqePpAaGRxkPlZ6M7qR2SO1fcg>
X-ME-Received: <xmr:QCwEadflLb6-DhxzfUlKo8ce57H7qhHZs5M5bQL09tJ4l9WMml_S0b8H7CSyEELPcKrZGjEZIoFHmtrEXOjIAF9qfPO5mkdikLPrmyyFY0Yy>
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
X-ME-Proxy: <xmx:QCwEaUh2K277j2wNhYh4Lr5wmE57z65Z9u5EyNkCtsbvGOTABHM32A>
    <xmx:QCwEadzbm9XS57V0ETynODQD2GH0eFKdmq1oASs1CE9MnBph8Gcphg>
    <xmx:QCwEaYNj5ABGzEQCBb8E-FxuUDDyR_412qT9aRlTuDTmcyY_K9JIVQ>
    <xmx:QCwEaWWHcvePo32QUiE4vvkXphEu8bC4A8uIsJczSKIwsOMybZ5PNQ>
    <xmx:QCwEaTFSfBVLIzFb7vV1U8WRZw0YKUia7pfLTxD48lZSWSYg-F2dpf0F>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 23:25:50 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v4 03/10] nfsd: use a bool instead of NFSD4_FH_FOREIGN
Date: Fri, 31 Oct 2025 14:16:10 +1100
Message-ID: <20251031032524.2141840-4-neilb@ownmail.net>
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

fh_flags only contains a single flag.  The svc_fh structure containing
it has a bunch of other bools.  So change this one flag to a bool.

Doing that clarifies the code and makes the struct slightly smaller.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 5 ++---
 fs/nfsd/nfsfh.h    | 5 +----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 2222bb283baf..2ab411718a27 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -690,7 +690,7 @@ nfsd4_putfh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	ret = fh_verify(rqstp, &cstate->current_fh, 0, NFSD_MAY_BYPASS_GSS);
 #ifdef CONFIG_NFSD_V4_2_INTER_SSC
 	if (ret == nfserr_stale && putfh->no_verify) {
-		SET_FH_FLAG(&cstate->current_fh, NFSD4_FH_FOREIGN);
+		cstate->current_fh.fh_foreign = true;
 		ret = 0;
 	}
 #endif
@@ -2917,8 +2917,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 				op->status = nfsd4_open_omfg(rqstp, cstate, op);
 			goto encode_op;
 		}
-		if (!current_fh->fh_dentry &&
-				!HAS_FH_FLAG(current_fh, NFSD4_FH_FOREIGN)) {
+		if (!current_fh->fh_dentry && !current_fh->fh_foreign) {
 			if (!(op->opdesc->op_flags & ALLOWED_WITHOUT_FH)) {
 				op->status = nfserr_nofilehandle;
 				goto encode_op;
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 5ef7191f8ad8..85019ae58ed3 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -93,7 +93,7 @@ typedef struct svc_fh {
 						 */
 	bool			fh_use_wgather;	/* NFSv2 wgather option */
 	bool			fh_64bit_cookies;/* readdir cookie size */
-	int			fh_flags;	/* FH flags */
+	bool			fh_foreign;
 	bool			fh_post_saved;	/* post-op attrs saved */
 	bool			fh_pre_saved;	/* pre-op attrs saved */
 
@@ -111,9 +111,6 @@ typedef struct svc_fh {
 	struct kstat		fh_post_attr;	/* full attrs after operation */
 	u64			fh_post_change; /* nfsv4 change; see above */
 } svc_fh;
-#define NFSD4_FH_FOREIGN (1<<0)
-#define SET_FH_FLAG(c, f) ((c)->fh_flags |= (f))
-#define HAS_FH_FLAG(c, f) ((c)->fh_flags & (f))
 
 enum nfsd_fsid {
 	FSID_DEV = 0,
-- 
2.50.0.107.gf914562f5916.dirty


