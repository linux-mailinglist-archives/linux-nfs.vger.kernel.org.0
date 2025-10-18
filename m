Return-Path: <linux-nfs+bounces-15351-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC08BEC139
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 02:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44B784F0D19
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 00:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D5A3C17;
	Sat, 18 Oct 2025 00:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="plo3YBTW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TxRp3t6e"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2891BC41
	for <linux-nfs@vger.kernel.org>; Sat, 18 Oct 2025 00:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760745969; cv=none; b=CcN+tH1fU0hE4fKhwY35dqzaPNao54U/yhbjcs9jxAiUJSOH6fOdxXxDmyrnPPoWVQL203ShfXNe50uzgpwfzcs6ChdjuoDQ56cVhRZuHCAyGCn1WI4ATc1vTJ18SG21v5+REu9Ho0iFFpBO1RAY4PjwVXHOSCibDU6Sq+uSELI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760745969; c=relaxed/simple;
	bh=rk9laKS5fdXa7wHGxWmjTqs2ZgxOlzyqRfKoTBYgq1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BP0NEl1VeKu7mADwWRlUe+lILtHofGxfUVXX/ko1ayGNa47ZNfctOcLzbcN+s2HT8En3UrX7BsT5xIwXXq0y0I71SmESZ6slFvc6VpoEBpqbMvnCYpXdkXoZ2DRdl+vZ9sHDacME9MCELEGL1iyfGBPxyL+kAv9C5kSK+oh1UoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=plo3YBTW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TxRp3t6e; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1BC5A7A0056;
	Fri, 17 Oct 2025 20:06:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 17 Oct 2025 20:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1760745965;
	 x=1760832365; bh=G+eg0lHITt/yPLbj5nhb6WRg4uqgPhOfgI4kDa/k5R0=; b=
	plo3YBTWlAp8FSWJGhE8vnlO2G1hBYbEIdUqdRIcz10i5lhdlJKUpgXwm/lnkncm
	IWrXfWj4tefy9+1w05eUpBiDTj/Rw2j74jn3BxJPGFgxTgwwqRi+86evmOipBSMW
	GD+8f4zESTZEzR4QzbvcuWIya2UgUrBa6Vw2oosNtpRtq6C1zuFGFc6KKQHhFAjU
	e0hJG4tjbQbxzYzqM5dxaIjRuXwAH+G6f8YZDkYFDr+4il6IjrO9RgOYhfmsexRB
	1Om5iQ5BBa3WUsgDM9ZNAMC9kIz1EkPQZoZAmtT2z0uBltEIbKd9Hl8EUe/QZbX2
	NhJeKmGiWJ3/RB9F4WngEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760745965; x=1760832365; bh=G
	+eg0lHITt/yPLbj5nhb6WRg4uqgPhOfgI4kDa/k5R0=; b=TxRp3t6eAtrovln49
	6Wv1+/KHjYW7m0d9ljPDWsTxG40z+Ivf7Mtt6OgBXjWvO+cjr3ztu+QywprNJ+1d
	PEhJ/PDklrFgEZNFhhWwzFJwyPx8D/XuKb2YfwbhyPYcBNFQjikKO+6asQ+z6K9o
	/9VXq3mHGb9weadH2qcYYc7ErLZ4d/oUduK5aGEf5nkL+KGAc1kaCBPQK02Acnpv
	b/c2Il8ORNxgQimUC2m0/qLir1fzgKDsMiSky9w7BtNyLUbzyaD8pNpyJuXphpso
	asFrfNFBq5CH6Z5hsX97cdx57PLZb7a6BCVGNG2qrc6MBd5scRuWxnSKr4ZTmY2p
	KgA0g==
X-ME-Sender: <xms:7dnyaJS-qPmRK_9tUhOS5fqWFjOSLjch43seLCmeote673o7wYzxKw>
    <xme:7dnyaGde8-e0z1dhtr1eNDUtbeNTzW2ICt7t7j9p2jlqM9l9Fx1Msma97VApYBMCA
    k5J1xJmVr5Siokmf0zdpo9hMPfU04G5jWCc5EgBFlMQJRIAbg>
X-ME-Received: <xmr:7dnyaIoWJwsSiFAUJl64JMQtCo5czIbyml2Rl48nvQNhxdj6ozj4xE9-FNsjhQoETAKyGctzYbFp30UY63CsCcrFSOUtxKwhk5TA7fd69wDl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufedtheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    ephfekffegueetheejvdegjeffieeigefhvdeftdeltdeuhfeigeffuefhtefhhfehnecu
    ffhomhgrihhnpehluggpohifnhgvrhdruggrthgrnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsgesohifnhhmrghilhdrnhgvthdp
    nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinh
    hugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhmseht
    rghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtoh
    hmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghp
    thhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepjhhlrgihth
    honheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7dnyaH8ECjUVA-qOy6DWs5O1onEC7G_Y7VCtKRf1eHOu1yjfJstPTg>
    <xmx:7dnyaEfT10JwlilPcredvVnvZDf7iyXZ5cKnLViFT9-mAwNw3Qo3yw>
    <xmx:7dnyaBLeWkTai3D6YjUSUmqp1RY2fZKvJ5Lcm0HaeCeZMfi7-cPBOw>
    <xmx:7dnyaEgw1SDZ-jZdsoOOrE3ub5awHg320BPIWSAsiS9AHMVmuKQRmg>
    <xmx:7dnyaKwQ5ViSQRHyJCZf4C-cyamL4KJX4CBRZ8uBB_wc4D-Nt4o_yA5T>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 20:06:03 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 1/7] nfsd: discard ->op_release() for v4 operations
Date: Sat, 18 Oct 2025 11:02:21 +1100
Message-ID: <20251018000553.3256253-2-neilb@ownmail.net>
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

Instead of having a separate ->op_release() function, change to
releasing any resources immediately after they have been encoded into
the reply or, in one case, if processing the op resulted in an error.

There have been two bugs recently which were (arguably) caused by having
the ->op_release code quite separate from the other code.  I think it
makes more sense to keep it all together.  Any resources that ->op_func()
allocates are now freed after the op reply has been encoded.  The encode
function easily knows when the resource is present and so needs to be
freed.

One effect of this is that the trace_nfsd_read_done() tracepoint is no
longer considered to be part of "releasing" anything, and is now only
called when the read is done successfully.  It is also now *before*
generic errors are traced, rather than after.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/blocklayout.c | 10 ++++++++--
 fs/nfsd/nfs4proc.c    | 46 -------------------------------------------
 fs/nfsd/nfs4state.c   | 16 ---------------
 fs/nfsd/nfs4xdr.c     | 28 ++++++++++++++++++++------
 fs/nfsd/xdr4.h        |  3 ---
 5 files changed, 30 insertions(+), 73 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 101cccbee4a3..cd38c7f9d806 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -206,6 +206,7 @@ nfsd4_block_get_device_info_simple(struct super_block *sb,
 {
 	struct pnfs_block_deviceaddr *dev;
 	struct pnfs_block_volume *b;
+	int status;
 
 	dev = kzalloc(struct_size(dev, volumes, 1), GFP_KERNEL);
 	if (!dev)
@@ -217,8 +218,13 @@ nfsd4_block_get_device_info_simple(struct super_block *sb,
 
 	b->type = PNFS_BLOCK_VOLUME_SIMPLE;
 	b->simple.sig_len = PNFS_BLOCK_UUID_LEN;
-	return sb->s_export_op->get_uuid(sb, b->simple.sig, &b->simple.sig_len,
-			&b->simple.offset);
+	status = sb->s_export_op->get_uuid(sb, b->simple.sig, &b->simple.sig_len,
+					   &b->simple.offset);
+	if (status) {
+		kfree(dev);
+		gdp->gd_device = NULL;
+	}
+	return status;
 }
 
 static __be32
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 2222bb283baf..9d53ea289bf3 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -984,17 +984,6 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	return status;
 }
 
-
-static void
-nfsd4_read_release(union nfsd4_op_u *u)
-{
-	if (u->read.rd_nf) {
-		trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
-				     u->read.rd_offset, u->read.rd_length);
-		nfsd_file_put(u->read.rd_nf);
-	}
-}
-
 static __be32
 nfsd4_readdir(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	      union nfsd4_op_u *u)
@@ -1120,20 +1109,6 @@ nfsd4_secinfo_no_name(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstat
 	return nfs_ok;
 }
 
-static void
-nfsd4_secinfo_release(union nfsd4_op_u *u)
-{
-	if (u->secinfo.si_exp)
-		exp_put(u->secinfo.si_exp);
-}
-
-static void
-nfsd4_secinfo_no_name_release(union nfsd4_op_u *u)
-{
-	if (u->secinfo_no_name.sin_exp)
-		exp_put(u->secinfo_no_name.sin_exp);
-}
-
 /*
  * Validate that the requested timestamps are within the acceptable range. If
  * timestamp appears to be in the future, then it will be clamped to
@@ -2426,12 +2401,6 @@ nfsd4_getdeviceinfo(struct svc_rqst *rqstp,
 	return nfserr;
 }
 
-static void
-nfsd4_getdeviceinfo_release(union nfsd4_op_u *u)
-{
-	kfree(u->getdeviceinfo.gd_device);
-}
-
 static __be32
 nfsd4_layoutget(struct svc_rqst *rqstp,
 		struct nfsd4_compound_state *cstate, union nfsd4_op_u *u)
@@ -2512,12 +2481,6 @@ nfsd4_layoutget(struct svc_rqst *rqstp,
 	return nfserr;
 }
 
-static void
-nfsd4_layoutget_release(union nfsd4_op_u *u)
-{
-	kfree(u->layoutget.lg_content);
-}
-
 static __be32
 nfsd4_layoutcommit(struct svc_rqst *rqstp,
 		struct nfsd4_compound_state *cstate, union nfsd4_op_u *u)
@@ -3444,7 +3407,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 	},
 	[OP_LOCK] = {
 		.op_func = nfsd4_lock,
-		.op_release = nfsd4_lock_release,
 		.op_flags = OP_MODIFIES_SOMETHING |
 				OP_NONTRIVIAL_ERROR_ENCODE,
 		.op_name = "OP_LOCK",
@@ -3453,7 +3415,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 	},
 	[OP_LOCKT] = {
 		.op_func = nfsd4_lockt,
-		.op_release = nfsd4_lockt_release,
 		.op_flags = OP_NONTRIVIAL_ERROR_ENCODE,
 		.op_name = "OP_LOCKT",
 		.op_rsize_bop = nfsd4_lock_rsize,
@@ -3526,7 +3487,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 	},
 	[OP_READ] = {
 		.op_func = nfsd4_read,
-		.op_release = nfsd4_read_release,
 		.op_name = "OP_READ",
 		.op_rsize_bop = nfsd4_read_rsize,
 		.op_get_currentstateid = nfsd4_get_readstateid,
@@ -3576,7 +3536,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 	},
 	[OP_SECINFO] = {
 		.op_func = nfsd4_secinfo,
-		.op_release = nfsd4_secinfo_release,
 		.op_flags = OP_HANDLES_WRONGSEC,
 		.op_name = "OP_SECINFO",
 		.op_rsize_bop = nfsd4_secinfo_rsize,
@@ -3627,7 +3586,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 	/* NFSv4.1 operations */
 	[OP_EXCHANGE_ID] = {
 		.op_func = nfsd4_exchange_id,
-		.op_release = nfsd4_exchange_id_release,
 		.op_flags = ALLOWED_WITHOUT_FH | ALLOWED_AS_FIRST_OP
 				| OP_MODIFIES_SOMETHING,
 		.op_name = "OP_EXCHANGE_ID",
@@ -3681,7 +3639,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 	},
 	[OP_SECINFO_NO_NAME] = {
 		.op_func = nfsd4_secinfo_no_name,
-		.op_release = nfsd4_secinfo_no_name_release,
 		.op_flags = OP_HANDLES_WRONGSEC,
 		.op_name = "OP_SECINFO_NO_NAME",
 		.op_rsize_bop = nfsd4_secinfo_rsize,
@@ -3708,14 +3665,12 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 #ifdef CONFIG_NFSD_PNFS
 	[OP_GETDEVICEINFO] = {
 		.op_func = nfsd4_getdeviceinfo,
-		.op_release = nfsd4_getdeviceinfo_release,
 		.op_flags = ALLOWED_WITHOUT_FH,
 		.op_name = "OP_GETDEVICEINFO",
 		.op_rsize_bop = nfsd4_getdeviceinfo_rsize,
 	},
 	[OP_LAYOUTGET] = {
 		.op_func = nfsd4_layoutget,
-		.op_release = nfsd4_layoutget_release,
 		.op_flags = OP_MODIFIES_SOMETHING,
 		.op_name = "OP_LAYOUTGET",
 		.op_rsize_bop = nfsd4_layoutget_rsize,
@@ -3761,7 +3716,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 	},
 	[OP_READ_PLUS] = {
 		.op_func = nfsd4_read,
-		.op_release = nfsd4_read_release,
 		.op_name = "OP_READ_PLUS",
 		.op_rsize_bop = nfsd4_read_plus_rsize,
 		.op_get_currentstateid = nfsd4_get_readstateid,
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 35004568d43e..1e821f5d09a3 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -8454,14 +8454,6 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	return status;
 }
 
-void nfsd4_lock_release(union nfsd4_op_u *u)
-{
-	struct nfsd4_lock *lock = &u->lock;
-	struct nfsd4_lock_denied *deny = &lock->lk_denied;
-
-	kfree(deny->ld_owner.data);
-}
-
 /*
  * The NFSv4 spec allows a client to do a LOCKT without holding an OPEN,
  * so we do a temporary open here just to get an open file to pass to
@@ -8567,14 +8559,6 @@ nfsd4_lockt(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	return status;
 }
 
-void nfsd4_lockt_release(union nfsd4_op_u *u)
-{
-	struct nfsd4_lockt *lockt = &u->lockt;
-	struct nfsd4_lock_denied *deny = &lockt->lt_denied;
-
-	kfree(deny->ld_owner.data);
-}
-
 __be32
 nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	    union nfsd4_op_u *u)
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 30ce5851fe4c..1ffe8ddc1215 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4174,6 +4174,7 @@ nfsd4_encode_lock(struct nfsd4_compoundres *resp, __be32 nfserr,
 	case nfserr_denied:
 		/* denied */
 		status = nfsd4_encode_lock4denied(xdr, &lock->lk_denied);
+		kfree(lock->lk_denied.ld_owner.data);
 		break;
 	default:
 		return nfserr;
@@ -4192,6 +4193,7 @@ nfsd4_encode_lockt(struct nfsd4_compoundres *resp, __be32 nfserr,
 	if (nfserr == nfserr_denied) {
 		/* denied */
 		status = nfsd4_encode_lock4denied(xdr, &lockt->lt_denied);
+		kfree(lockt->lt_denied.ld_owner.data);
 		if (status != nfs_ok)
 			return status;
 	}
@@ -4532,6 +4534,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
 	/* Reserve space for the eof flag and byte count */
 	if (unlikely(!xdr_reserve_space(xdr, XDR_UNIT * 2))) {
 		WARN_ON_ONCE(splice_ok);
+		nfsd_file_put(read->rd_nf);
 		return nfserr_resource;
 	}
 	xdr_commit_encode(xdr);
@@ -4543,6 +4546,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
 		nfserr = nfsd4_encode_splice_read(resp, read, file, maxcount);
 	else
 		nfserr = nfsd4_encode_readv(resp, read, maxcount);
+	nfsd_file_put(read->rd_nf);
 	if (nfserr) {
 		xdr_truncate_encode(xdr, eof_offset);
 		return nfserr;
@@ -4551,6 +4555,8 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
 	wire_data[0] = read->rd_eof ? xdr_one : xdr_zero;
 	wire_data[1] = cpu_to_be32(read->rd_length);
 	write_bytes_to_xdr_buf(xdr->buf, eof_offset, &wire_data, XDR_UNIT * 2);
+	trace_nfsd_read_done(read->rd_rqstp, read->rd_fhp,
+			     read->rd_offset, read->rd_length);
 	return nfs_ok;
 }
 
@@ -4803,8 +4809,11 @@ nfsd4_encode_secinfo(struct nfsd4_compoundres *resp, __be32 nfserr,
 {
 	struct nfsd4_secinfo *secinfo = &u->secinfo;
 	struct xdr_stream *xdr = resp->xdr;
+	__be32 status;
 
-	return nfsd4_encode_SECINFO4resok(xdr, secinfo->si_exp);
+	status = nfsd4_encode_SECINFO4resok(xdr, secinfo->si_exp);
+	exp_put(secinfo->si_exp);
+	return status;
 }
 
 static __be32
@@ -4813,8 +4822,11 @@ nfsd4_encode_secinfo_no_name(struct nfsd4_compoundres *resp, __be32 nfserr,
 {
 	struct nfsd4_secinfo_no_name *secinfo = &u->secinfo_no_name;
 	struct xdr_stream *xdr = resp->xdr;
+	__be32 status;
 
-	return nfsd4_encode_SECINFO4resok(xdr, secinfo->sin_exp);
+	status = nfsd4_encode_SECINFO4resok(xdr, secinfo->sin_exp);
+	exp_put(secinfo->sin_exp);
+	return status;
 }
 
 static __be32
@@ -4963,6 +4975,8 @@ nfsd4_encode_exchange_id(struct nfsd4_compoundres *resp, __be32 nfserr,
 	struct nfsd_net *nn = net_generic(SVC_NET(resp->rqstp), nfsd_net_id);
 	struct nfsd4_exchange_id *exid = &u->exchange_id;
 	struct xdr_stream *xdr = resp->xdr;
+	/* impl_name is encoded in nii_name.data */
+	char *impl_name __free(kfree) = exid->server_impl_name;
 
 	/* eir_clientid */
 	nfserr = nfsd4_encode_clientid4(xdr, &exid->clientid);
@@ -5210,6 +5224,7 @@ nfsd4_encode_getdeviceinfo(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 	/* gdir_device_addr */
 	nfserr = nfsd4_encode_device_addr4(xdr, gdev);
+	kfree(gdev->gd_device);
 	if (nfserr)
 		return nfserr;
 	/* gdir_notification */
@@ -5245,6 +5260,7 @@ nfsd4_encode_layoutget(struct nfsd4_compoundres *resp, __be32 nfserr,
 {
 	struct nfsd4_layoutget *lgp = &u->layoutget;
 	struct xdr_stream *xdr = resp->xdr;
+	const struct pnfs_ff_layout *fl __free(kfree) = lgp->lg_content;
 
 	/* logr_return_on_close */
 	nfserr = nfsd4_encode_bool(xdr, true);
@@ -5468,8 +5484,10 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 	eof_offset = xdr->buf->len;
 
 	/* Reserve space for the eof flag and segment count */
-	if (unlikely(!xdr_reserve_space(xdr, XDR_UNIT * 2)))
+	if (unlikely(!xdr_reserve_space(xdr, XDR_UNIT * 2))) {
+		nfsd_file_put(read->rd_nf);
 		return nfserr_io;
+	}
 	xdr_commit_encode(xdr);
 
 	read->rd_eof = read->rd_offset >= i_size_read(file_inode(file));
@@ -5477,6 +5495,7 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 		goto out;
 
 	nfserr = nfsd4_encode_read_plus_data(resp, read);
+	nfsd_file_put(read->rd_nf);
 	if (nfserr) {
 		xdr_truncate_encode(xdr, eof_offset);
 		return nfserr;
@@ -5951,9 +5970,6 @@ nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *op)
 	write_bytes_to_xdr_buf(xdr->buf, op_status_offset,
 			       &op->status, XDR_UNIT);
 release:
-	if (opdesc && opdesc->op_release)
-		opdesc->op_release(&op->u);
-
 	/*
 	 * Account for pages consumed while encoding this operation.
 	 * The xdr_stream primitives don't manage rq_next_page.
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index ae75846b3cd7..2a347c1bc3e7 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -985,10 +985,8 @@ extern __be32 nfsd4_open_downgrade(struct svc_rqst *rqstp,
 		struct nfsd4_compound_state *, union nfsd4_op_u *u);
 extern __be32 nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *,
 		union nfsd4_op_u *u);
-extern void nfsd4_lock_release(union nfsd4_op_u *u);
 extern __be32 nfsd4_lockt(struct svc_rqst *rqstp, struct nfsd4_compound_state *,
 		union nfsd4_op_u *u);
-extern void nfsd4_lockt_release(union nfsd4_op_u *u);
 extern __be32 nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *,
 		union nfsd4_op_u *u);
 extern __be32
@@ -1040,7 +1038,6 @@ enum nfsd4_op_flags {
 struct nfsd4_operation {
 	__be32 (*op_func)(struct svc_rqst *, struct nfsd4_compound_state *,
 			union nfsd4_op_u *);
-	void (*op_release)(union nfsd4_op_u *);
 	u32 op_flags;
 	char *op_name;
 	/* Try to get response size before operation */
-- 
2.50.0.107.gf914562f5916.dirty


