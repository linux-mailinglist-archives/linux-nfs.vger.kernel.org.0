Return-Path: <linux-nfs+bounces-16658-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 547C2C7C09D
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 01:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CDF3C35F9CE
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 00:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707F823D2AB;
	Sat, 22 Nov 2025 00:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="L6LpNG53";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UtGqniNF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8411F09AD
	for <linux-nfs@vger.kernel.org>; Sat, 22 Nov 2025 00:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763772808; cv=none; b=XPLo0BB6FT+pIFmrwuDx6lPbPr+YkEyIL65GhH7poHqZea/vk/bJJ9itCJC2AjspgCjkUmJic+jm3bLYWfRXyLISEKQP8fxHeirr6iwIUm7mHGV3rX8FYJxQxnGzVSEPLKc8YvC+pFLdItxpEFkZvkExSZDnzwS+xam/ncqboh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763772808; c=relaxed/simple;
	bh=ZB8Wk3FGi/EjZIs1HEybwoVZ2DJO/ayhbO/cB9C2jmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WkzwbRX7z/2ASRBrne86WBmxRTqgS2oocpcGvWnwvN9X2Oy1uO6CMIVMk2a8xmVTE8FehqngUdZmYbVnk5c20L6h/Oib0URnEn7HaybE5BnR/YzR6a7/2m/rzHU5jVSDKWPdknzv9RgAyfWfMz+lkrVhEMjv4FIBfXWaL3SCUG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=L6LpNG53; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UtGqniNF; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F333A14000B6;
	Fri, 21 Nov 2025 19:53:24 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 21 Nov 2025 19:53:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1763772804;
	 x=1763859204; bh=hGA9OMrjnY119at1nMXs2smI0COoyeN15d7fioruhQo=; b=
	L6LpNG53Ev37E2qW+qOONrz60GF0PmWUY6rIod9PU7zQZ0ySeZoLI6Pb/xkW1oOn
	BWnqv3rPKxqUpnwYhnwbzUBtydDaGkf2wZ/5E1BL+lxaFE6D5S3jIf0nypsOXSQc
	1Rj82vb3i8SaRY+yFxzjPGlW8QU+Hw++pGxm9OX86mDObVQiGKZ4ex8MYAL4rtkS
	cDgK+Z25ieLMnFJ907EG0Cko+P4ZRlkB1dX01MfXL6arHdiUB8fdMYDpVaO/Eys6
	l7IWOn2NWtVDEEPa9+5Fy6DP/z3m1p3M1SK3IocRsv6sD8ybHLs5Zx8300/HXk8u
	Xhz2+NuAKLSojo9R3iOTyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763772804; x=1763859204; bh=h
	GA9OMrjnY119at1nMXs2smI0COoyeN15d7fioruhQo=; b=UtGqniNFztmkFseOc
	Q2DcUpMVWKtC68PAp1tqU/B/gLoEUVB5B7XGIhg4fuNCxCGrwS2EiGrKnE0sGdkO
	Umm7MDtfVeCJoLd/FNvNQlOmT6NivAlMlK/JT2d/DzpuhWokVip/2O29xLc9WX6w
	Ezop1HxKZCixtgaV9RMfs1/Y2UxpR/HfRzPRsz/a8y3/W3IhssIKsdrRym60t206
	SIsuPicOibrk7k82pA6H0Oc4J+NW2mJikC+irv2uTfRKOWDS7jL68e7x83yHYt+v
	Cw1Ildi0rH7pSCY7PAtmZHElWY2GVEPqVEEbXMy7dd7I7U6u5QyWTkEJZ+9X6SHR
	1EFIA==
X-ME-Sender: <xms:hAkhaU0L2ZNwb6uMJvJO2XAqhUbflWjM5VhBHwJAvpbRH5803ajxVA>
    <xme:hAkhaSw__hsFNNglxh8FDTPsRu1S_V9tN2Y3ky7KXcgVd7sTofdipq4PlJU0bWGJR
    IlTmu1m8wnrdb-_GDLYqioZ506raGPUZopWxNkT3C0guMDLUN4>
X-ME-Received: <xmr:hAkhaWvIVQUN9Vhv41uBiK-ATtALKpshoYwCpjrnGEbB4wIYGrfIrXhxSf2LuflBXLEVH95zRW4V9IYuvR4JU80ed_FFpZCNeUy3sMRrGqr7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedugeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesoh
    hrrggtlhgvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:hAkhaUznJ8gKwhvFAgZbHw447oImL5ByoD1XVu1FsKKOGGyvAjgngQ>
    <xmx:hAkhaZCSUZsO-2gq4C0btW1HIf1jY-ddGaZWM_njaQ8hQuC4MrY-5A>
    <xmx:hAkhaSfmWPflR5XtF0X9v-aeN371EWQNLS7bQ04UoinujSTmxav5hQ>
    <xmx:hAkhaTl_nTtbCu0HahFtR4gDjJ2FLHnEw4IGN2bifjYK3OiQ002CZA>
    <xmx:hAkhaaUeVmNbMDVGmWZ-s-EYdMp9y3rg1l6M5girbkmD2YpX8HhTqVP6>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 19:53:22 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v6 09/14] nfsd: revert nfsd4: delay setting current_fh in open
Date: Sat, 22 Nov 2025 11:47:07 +1100
Message-ID: <20251122005236.3440177-10-neilb@ownmail.net>
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

This reverts
 Commit: c0e6bee48059 ("nfsd4: delay setting current_fh in open")

That patch was a precusor to

Commit: 4335723e8e9f ("nfsd4: fix delegation-unlink/rename race")

which attempted to fix a race by holding the parent directory locked for
longer.  That race was subsequently fixed a better way
Commit: 876c553cb410 ("NFSD: verify the opened dentry after setting a delegation")

which repeated the lookup after the delegation was obtained.

So delaying the setting of current_fh is no longer needed.

A cost of setting current_fh later is that when
nfs4_inc_and_copy_stateid() is called, current_fh has already been set
to the correct filehandle everywhere *except* in nfsd4_process_open2().
With this change, the current_fh will be stable from when
nfs4_inc_and_copy_stateid() which will allow a future patch which
simplifies the handling of current_stateid.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 0c13c75e4092..0f490f2524fa 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -424,16 +424,17 @@ set_change_info(struct nfsd4_change_info *cinfo, struct svc_fh *fhp)
 }
 
 static __be32
-do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, struct nfsd4_open *open, struct svc_fh **resfh)
+do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, struct nfsd4_open *open)
 {
 	struct svc_fh *current_fh = &cstate->current_fh;
+	struct svc_fh *resfh;
 	int accmode;
 	__be32 status;
 
-	*resfh = kmalloc(sizeof(struct svc_fh), GFP_KERNEL);
-	if (!*resfh)
+	resfh = kmalloc(sizeof(struct svc_fh), GFP_KERNEL);
+	if (!resfh)
 		return nfserr_jukebox;
-	fh_init(*resfh, NFS4_FHSIZE);
+	fh_init(resfh, NFS4_FHSIZE);
 	open->op_truncate = false;
 
 	if (open->op_create) {
@@ -453,7 +454,7 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, stru
 		 */
 
 		current->fs->umask = open->op_umask;
-		status = nfsd4_create_file(rqstp, current_fh, *resfh, open);
+		status = nfsd4_create_file(rqstp, current_fh, resfh, open);
 		current->fs->umask = 0;
 
 		/*
@@ -466,7 +467,7 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, stru
 						FATTR4_WORD1_TIME_MODIFY);
 	} else {
 		status = nfsd_lookup(rqstp, current_fh,
-				     open->op_fname, open->op_fnamelen, *resfh);
+				     open->op_fname, open->op_fnamelen, resfh);
 		if (status == nfs_ok)
 			/* NFSv4 protocol requires change attributes even though
 			 * no change happened.
@@ -475,18 +476,21 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, stru
 	}
 	if (status)
 		goto out;
-	status = nfsd_check_obj_isreg(*resfh, cstate->minorversion);
+	status = nfsd_check_obj_isreg(resfh, cstate->minorversion);
 	if (status)
 		goto out;
 
-	nfsd4_set_open_owner_reply_cache(cstate, open, *resfh);
+	nfsd4_set_open_owner_reply_cache(cstate, open, resfh);
 	accmode = NFSD_MAY_NOP;
 	if (open->op_created ||
 			open->op_claim_type == NFS4_OPEN_CLAIM_DELEGATE_CUR)
 		accmode |= NFSD_MAY_OWNER_OVERRIDE;
-	status = do_open_permission(rqstp, *resfh, open, accmode);
+	status = do_open_permission(rqstp, resfh, open, accmode);
 	set_change_info(&open->op_cinfo, current_fh);
+	fh_dup2(current_fh, resfh);
 out:
+	fh_put(resfh);
+	kfree(resfh);
 	return status;
 }
 
@@ -537,7 +541,6 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 {
 	struct nfsd4_open *open = &u->open;
 	__be32 status;
-	struct svc_fh *resfh = NULL;
 	struct svc_fh parent_fh = {};
 	struct net *net = SVC_NET(rqstp);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
@@ -606,7 +609,7 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		fh_dup2(&parent_fh, &cstate->current_fh);
 		fallthrough;
 	case NFS4_OPEN_CLAIM_DELEGATE_CUR:
-		status = do_open_lookup(rqstp, cstate, open, &resfh);
+		status = do_open_lookup(rqstp, cstate, open);
 		if (status)
 			goto out;
 		break;
@@ -622,7 +625,6 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		status = do_open_fhandle(rqstp, cstate, open);
 		if (status)
 			goto out;
-		resfh = &cstate->current_fh;
 		break;
 	case NFS4_OPEN_CLAIM_DELEG_PREV_FH:
 	case NFS4_OPEN_CLAIM_DELEGATE_PREV:
@@ -633,7 +635,7 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		goto out;
 	}
 
-	status = nfsd4_process_open2(rqstp, resfh, &parent_fh, open);
+	status = nfsd4_process_open2(rqstp, &cstate->current_fh, &parent_fh, open);
 	fh_put(&parent_fh);
 	if (status && open->op_created)
 		pr_warn("nfsd4_process_open2 failed to open newly-created file: status=%u\n",
@@ -645,11 +647,6 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		fput(open->op_filp);
 		open->op_filp = NULL;
 	}
-	if (resfh && resfh != &cstate->current_fh) {
-		fh_dup2(&cstate->current_fh, resfh);
-		fh_put(resfh);
-		kfree(resfh);
-	}
 	nfsd4_cleanup_open_state(cstate, open);
 	nfsd4_bump_seqid(cstate, status);
 	return status;
-- 
2.50.0.107.gf914562f5916.dirty


