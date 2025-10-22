Return-Path: <linux-nfs+bounces-15550-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD7CBFE6F1
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 00:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 502B93A7669
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 22:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1AB1D798E;
	Wed, 22 Oct 2025 22:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="EGvCL4Mb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b3az3F1Y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E324326ED44
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 22:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761172661; cv=none; b=bzd2Vc77z6tVZeyQcSlNlAa7pz831kyXe5JxGEreugmKY+pPRX/AZzhYKmvyA5Y3vsk/B0qhNtITA9HYt3UAkes5qj/61EHkrznr+1U2fq3Mt8Ze4lpt5eRbm969yx7A1+c+XCQoWYyPcxK01bwgAuTTaiduCYLrCHQIJaf8U5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761172661; c=relaxed/simple;
	bh=ue1YrRQ4Tn6vtu0e74CeQfQQGxANaEn2i+JZVvP71eU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GscXyrw78X0jb56Vh1qdLuDvmTPyjfmosv4x337YghOlwvkghvlDMaFbz4SC5hsqiNwN/oXqoH3u+jF4G+sbMROH/4TdeY6++to931e2qb7FiO/8JV+rZ0WFQUU1Gx4H+QxcuHfazspXyT5lXnXUDDnqBTn8bKODhWqeDbfBxTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=EGvCL4Mb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b3az3F1Y; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 160591400126;
	Wed, 22 Oct 2025 18:37:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 22 Oct 2025 18:37:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1761172659;
	 x=1761259059; bh=oMLJOLxGsAp6ZZ2wG/ksty2lzQGhMkQySBxol5Qfc6E=; b=
	EGvCL4MbAn9IvX5MJZnnTGEeDZ0/WA0YpYq3ZgGN+fQVcc4dCW8u5f8ECIptzsOD
	8rXNLTQuuEVwZ4UUAJGlhD17+LzSmWVn63kvJWgMh2SkR7JWRO0FEkJrJBcgggiK
	dgbZJbRmni3fjv+D9xpt8fl05hVfqMnEINVg6voabOxkf1yzBD8Eb5HQ2TQueTHv
	3Qvwfdg1W6x30e7G7XyehWlpdFKQWOr3mYmE4GM3Vxu18qRtwQf+KDR4FeXOXOwO
	5d/CoowrX15zcNIJZM5a6L4Jia6w3A+A2+g+d3chvwgR4SLz5titK4cY+jWa1Adw
	Ft8mMDvvc4MAns9KjuS1pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1761172659; x=1761259059; bh=o
	MLJOLxGsAp6ZZ2wG/ksty2lzQGhMkQySBxol5Qfc6E=; b=b3az3F1YOqAWrlBDH
	XdN3zMr11BxJgU5TXX3nzBaXL5RsZJXczRT9NtWF428949SJz5w/HwkN9Kor4iBh
	oTfKUO1uJ9rnCPqIuoWrrdp9LEUjENmrvCFoaaD17KvwExXIFVfnWU8itiI+PvZz
	ACmTrhasoYaJc1C5XCdjTc/Hs78x/i7sldHS6pLxsm8cJbKQXHddCDjAK0OueW+x
	Ig2PZo0L3Se0F1pwloh8Sgt42vRVR3jmmAeTNMJopaHH9d0UcsYpp8GO8SYe+LSu
	wZKga9Fkho4ETKG94pWmR7kmjBcbf/GDWPONp06kQLvFHxr2Mc40w4ftduKCCl5U
	pDfQA==
X-ME-Sender: <xms:slz5aPMLlBfJmwEIdCyt_Ndg34O_i4SbaY8lIFBwbi2J2BBMGNKxOg>
    <xme:slz5aNqpOsJSWMHttjvxYWjxj74ANuRBEW2NQDA-ZQUVfcBVjFcAj_9BaIZzazvhO
    UGASxV-NLQDRbvsltT8pg3Eip3_-no9ZkMFts-7L7xnexqKUg>
X-ME-Received: <xmr:slz5aIGIT1FyfSPrg-SMF5V-6F1HPXtBFSLOgmz5NeWOi2XaWYUveNNUoqwQN1r6cDCCZ5AgYJh6YIEE4WbPU0dAqZ1RE7PzywnE523vuB6c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeegkedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:slz5aKp0Wqy057SyyyFvjc9E-j8ECE-elYxXFXdkvOQa1P1B7BjNxA>
    <xmx:slz5aJY3ggazVIwORowVq3VXitUoBZF9Q6exBXrt9ZTGoCbXl_mWVw>
    <xmx:slz5aLWN2qTX-OXJ97sDf_EqMLb9-5GyEod2FDgNj1MHM6BYEiUMlw>
    <xmx:slz5aK9qQzOSRGUFORGpO-Dplzthps8kGdOiWu5lhLZapfl2GHdqiw>
    <xmx:s1z5aMsqNMprkao_dKXZ_T0pYD-8BiE18w_6B5APcXKANBMIkEU0dp1g>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 18:37:36 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 3/8] nfsd: move set_current_stateid and clear_current_stateid calls earlier.
Date: Thu, 23 Oct 2025 09:34:30 +1100
Message-ID: <20251022223713.1217694-4-neilb@ownmail.net>
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

It is perfectly safe to call either ->set_current_stateid() or
nfsd41_clear_current_stateid() when an error has occurred as no future
ops will be attempted in this COMPOUND, so the saved stateid will not be
used (whether it is set or clear).

So the calls can be moved outside if the "if (!op->status)" tests.  They
can also moved before the nfserr_replay_cache as that only applies to
SEQUENCE ops and those never save or clear the current stateid.

Moving these closer to the ->op_func call makes subsequent patches more
obviously correct.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index a2b78577ddb2..875964551812 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2956,6 +2956,12 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 		op->status = op->opdesc->op_func(rqstp, cstate, &op->u);
 		trace_nfsd_compound_op_err(rqstp, op->opnum, op->status);
 
+		if (op->opdesc->op_set_currentstateid)
+			op->opdesc->op_set_currentstateid(cstate, &op->u);
+
+		if (op->opdesc->op_flags & OP_CLEAR_STATEID)
+			nfsd41_clear_current_stateid(cstate);
+
 		/* Only from SEQUENCE */
 		if (cstate->status == nfserr_replay_cache) {
 			dprintk("%s NFS4.1 replay from cache\n", __func__);
@@ -2963,12 +2969,6 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 			goto out;
 		}
 		if (!op->status) {
-			if (op->opdesc->op_set_currentstateid)
-				op->opdesc->op_set_currentstateid(cstate, &op->u);
-
-			if (op->opdesc->op_flags & OP_CLEAR_STATEID)
-				nfsd41_clear_current_stateid(cstate);
-
 			if (current_fh->fh_export &&
 					need_wrongsec_check(rqstp))
 				op->status = check_nfsd_access(current_fh->fh_export, rqstp, false);
-- 
2.50.0.107.gf914562f5916.dirty


