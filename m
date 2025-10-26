Return-Path: <linux-nfs+bounces-15637-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8377FC0B5D4
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Oct 2025 23:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 653984E2488
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Oct 2025 22:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8796728468D;
	Sun, 26 Oct 2025 22:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="cfM3wv6o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QzeOTYUD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C881F4CAE
	for <linux-nfs@vger.kernel.org>; Sun, 26 Oct 2025 22:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761517665; cv=none; b=feG4x+y2HTFNz/9GpNtkUe41Ycxdx3WGRTZpEM4F0zZ5MeqacS4cFsHjInFmTTb4wN8xtV2X7ObLLZW8NGlFjldyc4I9qMgfaekqAGqrhz9m6f8x3ETeDM2DWRoHjdjPDiAKcA1Z6W78UcK3RCMxS0SH5+nt2u6yTpxt6h8Nujc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761517665; c=relaxed/simple;
	bh=TC9bjt2zNUUbePlhu1YKoKEGvZGzYTItILVu0Z8yRXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C6hVoTB6zjtSmJ58SM/MqWJAK1KxHG1Edg5uRSDCRkqcnahLsNLVDfBzrBHKjAjvOvyG3a7GahmoTrjG0IhL3Ym3LAqc+7RbjfD8mZb5D8FR6f0kSrYvlMV284LlSoPJ6mWmDe5p8kfU7qHIFAKb9rZGhoTWhBAt5iGG9e4eU3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=cfM3wv6o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QzeOTYUD; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 267517A028B;
	Sun, 26 Oct 2025 18:27:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sun, 26 Oct 2025 18:27:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1761517663;
	 x=1761604063; bh=sBB9+VW+XP/JTvnLVZOJXXo0j3ttgSGNYS46kR7TrME=; b=
	cfM3wv6oHH8i5A07lvA/gS+uFNJ0R2QB1dXT2XE/f/omf0kas0EAKezIwPDYFuyx
	HELW7UljVctCYbVWhiQuW0OF9omVQHHkaj/sRBWeeoE5fuaynd7Gz35S+bKXLgWb
	zlp3AWHzLmPh4tBNpvKGmhwD3HGG5qSJHKQyUZPfW9KQArUcWGAyVdCOWtV0brve
	jjkkOO+sjS6U95wXqJr4sq66iGmgYd/EazAUeQHC+p8C+asPjq+MBBrrOfFd5T+I
	92cOZ2hQQ+ZBpJdaNn4JRKqUtwfv3mJB+nA7qb7525ss4mhiL9SBTddMaDcLw81T
	d79GWLvAqpITk0M2DE5PnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1761517663; x=1761604063; bh=s
	BB9+VW+XP/JTvnLVZOJXXo0j3ttgSGNYS46kR7TrME=; b=QzeOTYUD0JQwBFcdJ
	bw+uYBPBn9qNHoS3qlK+zrUDnzm2IB7nJ7plMS9ObhGWIAkFNMpY6j6c/uNFkD37
	L3ZwVWbrZO/BYYV3UpCjzbcY9Z68U0iQhTaPqWZQJMDIou+rYa1Z7dIpxFxPTxHf
	xxVXZAzOaDWAbruU0doyXANi9KCQSGfylOTD+RAvMHMRCGjix0yauheCFzcaKSZj
	Rrq4AghciESWT+m6eBwEEBWqV/Zo4G3X5EC3E7TYlzjTnXUj0O0Skj1GMKc+Kfaj
	1YUfg9zZYi6ZzFqNBqAqD1B92tDSQeOP+ikorBXbDUCd2w1s8CNp0RUDMx9r0HzG
	zEG7g==
X-ME-Sender: <xms:XqD-aJJTD-H8IsBiaWoFBgA_2wYvonH9EC8b8dzmin1tFETsHVDBmA>
    <xme:XqD-aI0CpTYd2nUpOGNLTuXERj45am3XIU-VeOH4oQxlZQ2ikWRVcOKy0v1FS9LdV
    vMNYofckHNkO5xxF2ZSpCcYv9P2svoVOFQrCp1caamUfalGLA>
X-ME-Received: <xmr:XqD-aLgeTG1SIKUQkbgWtwlIsruP0xdsQA6QVKVj33thJfBtrR94spaRUP2bTB2CTEl819iLK4pwC1J3BfB8wtsMXAOfKx43H4nIjeitP9d6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheeivdelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:XqD-aBXUj7J_FX1Ssn07bWwu10ihdMjfOGWopwiiBTul4s_9nocZTw>
    <xmx:XqD-aCX6mV95tl9I-k3aEPyIT_p8DolMkKpSbX7VmL0FTCNuYuTu7g>
    <xmx:XqD-aJjemEq6vyiD8Y1Wdg_7wraK_tOstYlmjqbgLpZ70L1it9vsIA>
    <xmx:XqD-aFbNOy06eLrgwpvMCNGP3Sf5O3_ztSg5RmcdiM5jRRho3xOFQQ>
    <xmx:XqD-aCqPuhpp8d-6mfSxJ10TNEgf1Sh2J2E4SMZANgA6ASsB7HtxvqXU>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Oct 2025 18:27:40 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 06/10] nfsd: move set_current_stateid and clear_current_stateid calls earlier.
Date: Mon, 27 Oct 2025 09:23:51 +1100
Message-ID: <20251026222655.3617028-7-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251026222655.3617028-1-neilb@ownmail.net>
References: <20251026222655.3617028-1-neilb@ownmail.net>
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
index 1f1d21dfd0cc..995ac3c4c150 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2950,6 +2950,12 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
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
@@ -2957,12 +2963,6 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
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


