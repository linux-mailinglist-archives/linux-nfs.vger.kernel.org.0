Return-Path: <linux-nfs+bounces-16651-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA57C7C08B
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 01:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C06B235F44E
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 00:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168BB201004;
	Sat, 22 Nov 2025 00:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="iHBdbELN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kG6dQlO7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA70239E80
	for <linux-nfs@vger.kernel.org>; Sat, 22 Nov 2025 00:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763772778; cv=none; b=F+K4z4zAJYITXGMtm52yx7e7726TUI4yn+blzXWSDBaVixTy77rIIZYOFyNaLRPGb/hOUaOmapgReMX7y+jlWVlqMUWJjXDFaxn34G+bM0P8vwSaC6V3UEK6APdwKkK+h39x9hUSaAp2KnyE/sdjgSHaKkOtY2DKvIdTgEkKcBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763772778; c=relaxed/simple;
	bh=Kpiv2IqvgCG9tZrqt2UuaBUaFF+P1PFp1G05/9zABkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NBX3ecy70HH4ipCYzA71RQTpyaeCmGF4ioIpXQbs/ElBpyRN3j8d6ejhBcrjUuN+kpLqFjDQ0j7HDF5VMfZf6QtPNFcUtoq/5ODJ2EQ6SzHaLSqu1EOky4KLRj41i4BU54n8GlTMx5k1lGYpsWQXwjb8zT+etLUx0z5Pjw2s1e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=iHBdbELN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kG6dQlO7; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 81B48140009C;
	Fri, 21 Nov 2025 19:52:55 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 21 Nov 2025 19:52:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1763772775;
	 x=1763859175; bh=LmNCmKp7vg7gzZhjPc0Dl4fvPtwhr9qrgRocg7+SdsI=; b=
	iHBdbELNTe6cdebHvc+mmkVnMDRf/prJrqQxiFQAt9UkpzkeUyu9N7opVWNhaNXs
	RT19Yw/nQ3a+FuMJ82IYRPFJUDnNIynKeWnoxQeFbh8rH0542E7PYdZkPGNuOgI7
	At5YZxDzq7Sl1iqRwU0Ly1bZiQHSu2NuAt451+n/MHE3mnqLlhBcsbCw1cmO4rF0
	q+4t+sxLO9XT09QymFEnR5hkg27+vPBCOO+XCHTn+MpCh3YFsNgapaCikML5svGf
	pPUhOo2iiOvd2Pn4+uKNJY1BmAin0zf3HreXV0MWDlqBf1o1UazG+XoM8dPaUE0R
	kI70iCPj7DxgRCg76IdHPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763772775; x=1763859175; bh=L
	mNCmKp7vg7gzZhjPc0Dl4fvPtwhr9qrgRocg7+SdsI=; b=kG6dQlO7rSFgZ1kPw
	+RoW6hHScaTyiCaPJD5VRY+LhOrDxxDptiJsI+weGcyQ9xHaE1HbaM3M8qm9nTD4
	3OM72LDlpzaLtQXQhvY7djV1PL6T3yyjj6jlZa768i0Tc9aSbma1h3ZDF4Q4zdL2
	lEAzlrHuFHNtiPZypzavJ9mFnEgE+x/df+d0D4aPiKplpiV5oe2iMXcX0BvnAvzs
	utpNd4BNku4iVIDYno9yXWSTpq0o80UVG68JJqKj0/tOPMV1b+8BN4ZlD0igX65O
	RKGBKHNIceIULeopUcYhj8zw5YdnoLfl36AEhRjAwNUBP02wtKMCCiI+eSY7jhq0
	qv2jw==
X-ME-Sender: <xms:ZwkhaS6jGKODX0h0i1pPwHW8OaSL8FeXTdU_jaTcVJJ9wY8cUDSjHQ>
    <xme:ZwkhafkP8t2Sl56Yos8H-lr4IP616AeTTXh2ok2YF7lcb-dTF0j_ahUixGpa6o1sk
    Ajew5U4NrdNdWURass7fXZecvpXwgZ8xYlUsJBzglkDbTl_Ew>
X-ME-Received: <xmr:ZwkhabTdueqTrVduJ7qN2NuIxruAesqCQMn_q7wYs1T9FczImtquz1AVNbrlkvSgjAWgeurxkpCjzgGOpC7JubCHZjegE4712a5G3cYWBVmZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedugeehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:ZwkhaWGNMEwj9wSkJeEIV4ICkPcY5NpcE9yKSwA7v4jRBoSJc2OfPg>
    <xmx:ZwkhaYEnk-mNd0ZKnxCyezOkJd7fZ8d_PtuCmaRufQCx6T7wvMJUDA>
    <xmx:ZwkhacTWQYFHXRHvx2MF6JXvrNsVVqbDfpwE1Xc1Ef9t7Cp_69gl1w>
    <xmx:ZwkhaRIAtTLkv3ACrlG9EWF3fOkNMrm0vG8Vgyp-9OMCLxQP6NDMcA>
    <xmx:Zwkhacb5jH4t3OO_o6xWarAb93YQvN8k1v8maVDypmr8egGAoPRwt4M3>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 19:52:53 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v6 02/14] nfsd: discard NFSD4_FH_FOREIGN
Date: Sat, 22 Nov 2025 11:47:00 +1100
Message-ID: <20251122005236.3440177-3-neilb@ownmail.net>
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

NFSD4_FH_FOREIGN is not needed as the same information is elsewhere.

If fh_handle.fh_size is 0 then there is no filehandle
else if fh_dentry is NULL then the filehandle is foreign
else the filehandle is local.

So we can discard NFSD4_FH_FOREIGN and the related struct field,
and code.

In NFSv4.1, SECINFO and similar OPs can consume current_fh, but don't
currently set fh_size to zero.  So the above rule for filehandle type
determination isn't currently accurate.  This is fixed by enhancing
fh_put() to clear fhp->fh_handle.fh_size.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>

---
changes since v5
- clear fh_handle.fh_size in fh_put()
---
 fs/nfsd/nfs4proc.c | 7 ++-----
 fs/nfsd/nfsfh.c    | 1 +
 fs/nfsd/nfsfh.h    | 4 ----
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 947b1b6d2282..cbf66091b0e4 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -693,10 +693,8 @@ nfsd4_putfh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	       putfh->pf_fhlen);
 	ret = fh_verify(rqstp, &cstate->current_fh, 0, NFSD_MAY_BYPASS_GSS);
 #ifdef CONFIG_NFSD_V4_2_INTER_SSC
-	if (ret == nfserr_stale && putfh->no_verify) {
-		SET_FH_FLAG(&cstate->current_fh, NFSD4_FH_FOREIGN);
+	if (ret == nfserr_stale && putfh->no_verify)
 		ret = 0;
-	}
 #endif
 	return ret;
 }
@@ -735,8 +733,7 @@ nfsd4_savefh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	 * *is* required so that a foreign fh can be saved as needed for
 	 * inter-server COPY.
 	 */
-	if (!cstate->current_fh.fh_dentry &&
-	    !HAS_FH_FLAG(&cstate->current_fh, NFSD4_FH_FOREIGN))
+	if (cstate->current_fh.fh_handle.fh_size == 0)
 		return nfserr_nofilehandle;
 
 	fh_dup2(&cstate->save_fh, &cstate->current_fh);
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index ed85dd43da18..3c449e5e2459 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -806,6 +806,7 @@ fh_put(struct svc_fh *fhp)
 		fhp->fh_export = NULL;
 	}
 	fhp->fh_no_wcc = false;
+	fhp->fh_handle.fh_size = 0;
 	return;
 }
 
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 5ef7191f8ad8..43fcc1dcf69a 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -93,7 +93,6 @@ typedef struct svc_fh {
 						 */
 	bool			fh_use_wgather;	/* NFSv2 wgather option */
 	bool			fh_64bit_cookies;/* readdir cookie size */
-	int			fh_flags;	/* FH flags */
 	bool			fh_post_saved;	/* post-op attrs saved */
 	bool			fh_pre_saved;	/* pre-op attrs saved */
 
@@ -111,9 +110,6 @@ typedef struct svc_fh {
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


