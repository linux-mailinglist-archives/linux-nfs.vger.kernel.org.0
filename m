Return-Path: <linux-nfs+bounces-16657-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EF7C7C09A
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 01:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AED1B3A6514
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 00:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126E323E320;
	Sat, 22 Nov 2025 00:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="eOEGQGBq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RGQFFuHw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDE2239E80
	for <linux-nfs@vger.kernel.org>; Sat, 22 Nov 2025 00:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763772803; cv=none; b=k9RlfWEKGJXTR2OYbz1wlJZvjPW8H7tOM3+TaRn61oyPg5hYd6CtMpN+8I4JOBb5S3ro3gTLm3OKqXRVBvdD1PJp0yTQPIXocTWKR6Rjt7/kBgrpB10m4bBMMQKbNbwTJyNf/TEoGztJUZkCc8yplvL8k0jP6xh6WnqB6wRfWH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763772803; c=relaxed/simple;
	bh=nbMRVREgAu5PPss2C8gLWq2sXTZU9PIztuCGuO8sojY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n50iRWwcEb03q8QJPpbxRPdD8E/M82UvFinJXrk7n9DVO+GHyTJ6vqyltNRztsexmQfhOHlAtWo4+bF4EY6nv/9o8DpyS/EmHaPizFUR03vqpNZ4ykB1+F+4ykc6PXolxYS7PQ2WCc3qbfaiOkxFozteNghgDRm47nMTDh6jPRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=eOEGQGBq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RGQFFuHw; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id C57CEEC00F9;
	Fri, 21 Nov 2025 19:53:20 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 21 Nov 2025 19:53:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1763772800;
	 x=1763859200; bh=BiexMDC9/zAru0oGfUqOr0i4btAYYG0zspd0xzuSNSY=; b=
	eOEGQGBqjazFHEe5456evXZ40o9OB+cfKKWAPEufn8Leva6oXL/3r54zN9r6LweP
	uYPf/dbrlkaCKwT4HCIE7tgO6br3vr7LERcGiXVI0zdBoZUvnpCPDhc1cD5JLPDZ
	ZiN3W7EhxXXyK0uwJPp1aDrwyxmf8yDtQBEb3VHKL2Lc8GoLQXbK9oIrzHoPCPfN
	tBcFZUzr8JhPrUUFEkIfC5KBki3QJViEKGmVLHDlFpklScjb6DpC254c49Ovc97x
	NEzEwUFgzGhqG2nQp9alowQwOQ0ubvSo0GDpngId42uuBnzNTOnLVzJ6xMhfs/YM
	UYnwA/7YnPZCEN9aLKnfJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763772800; x=1763859200; bh=B
	iexMDC9/zAru0oGfUqOr0i4btAYYG0zspd0xzuSNSY=; b=RGQFFuHwbnnJ7lXlD
	Y+kGZ4e8KyfjSQMr5RAEwmWdFxbd+ZxDgG9FBlhGXGBEQ1/F4/LeYAyFeREWcwi+
	wn+KC9R8EvmNMBKxa9iWvA51FzW6mNioQAOz5+2pQZH6f5iPT/5Naic7wflQA7nd
	YQ4LNE2dpEJP5KTW0kbV9n+QAvul6+n5QqyKk/EMpxeiAq5xobGh0TmJo4UlwpbR
	nhNye/G1nEsbvdJg/tGlmgykuak0mQnDqAcOoRmun6VF1ZfW/3dvxxL4u0njzdDW
	Fw8j+P8o40ryUoXxscmMN39a5j9fUJ0d4GYHhS/lUOfsB0XBu/PmsvC4c1NQ1A+g
	lk9Aw==
X-ME-Sender: <xms:gAkhaYFXBQMN7zI42Ix3lR_jofVy1iLHUEsew76UUG6P34Y8qWyYOA>
    <xme:gAkhaVBpQZbhohsol5UbkOceaiId0n4ixpAvnh3J4AsKerwJH14d9AHF-L7jtXtPY
    thT4shk6ZJq98OBq1phAiekmdxaao9srgrIoAEnkS3KM_oB5dA>
X-ME-Received: <xmr:gAkhab8R-3ywraD_lQD5IARjwrQqR3tILue7Oo1SNQXYSZIVCfD7587Mvza0FLZ4_VlZq9kgcubJX4bP9wZ_iFJZyGyjhw6hx9bdUzrQS9cI>
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
X-ME-Proxy: <xmx:gAkhaRCY2apY0VzvX83NSMyISAhlRXqXuPvZIzcnWpTAiKu6xwyFNg>
    <xmx:gAkhaQTuebJzFDYU9N9ZN8R-31K8t-ioWEv62hU8bSl0T8fEkXsfLA>
    <xmx:gAkhaYsOovzk6_-lqk213BKWXv01a95kEzs-Q7sBL_ucn8_QVetMQg>
    <xmx:gAkhac2JPSrObWAT5no5SEHkxs4-qbx-aqhO2h8Jk0cfWPWEasyvdQ>
    <xmx:gAkhadkzlBPD7x-2ypyvLs6FOSFMgXVGbph0slk3x945Sg21ECoJBnmk>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 19:53:18 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v6 08/14] nfsd: pass parent_fh explicitly to nfsd4_process_open2()
Date: Sat, 22 Nov 2025 11:47:06 +1100
Message-ID: <20251122005236.3440177-9-neilb@ownmail.net>
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

nfsd4_process_open2() sometimes needs the filehandle of the parent of
the created file.  This is passed to nfs4_set_delegation() to verify
that the parent is unchanged after the delegation is obtained.

Currently nfsd4_process_open2() knows that the parent is
cstate->current_fh but that will change in the next patch.

So with this patch we take a copy of current_fh earlier in the one case
(NFS4_OPEN_CLAIM_NULL) where it is needed and before any lookup happens.

nfs4_open_delegation() currently uses "currentfh" (which is the parent)
to pass to nfs4_delegation_stat().  As nfs4_delegation_stat() only wants
the vfsmount, it can equally well use "fh" which is the filehandle for the
newly created file - it must be on the same filesystem.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c  |  8 ++++++--
 fs/nfsd/nfs4state.c | 25 ++++++++++++-------------
 fs/nfsd/xdr4.h      |  4 +++-
 3 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index bd7ba5df07a7..0c13c75e4092 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -538,6 +538,7 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd4_open *open = &u->open;
 	__be32 status;
 	struct svc_fh *resfh = NULL;
+	struct svc_fh parent_fh = {};
 	struct net *net = SVC_NET(rqstp);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	bool reclaim = false;
@@ -601,8 +602,10 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		goto out;
 
 	switch (open->op_claim_type) {
-	case NFS4_OPEN_CLAIM_DELEGATE_CUR:
 	case NFS4_OPEN_CLAIM_NULL:
+		fh_dup2(&parent_fh, &cstate->current_fh);
+		fallthrough;
+	case NFS4_OPEN_CLAIM_DELEGATE_CUR:
 		status = do_open_lookup(rqstp, cstate, open, &resfh);
 		if (status)
 			goto out;
@@ -630,7 +633,8 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		goto out;
 	}
 
-	status = nfsd4_process_open2(rqstp, resfh, open);
+	status = nfsd4_process_open2(rqstp, resfh, &parent_fh, open);
+	fh_put(&parent_fh);
 	if (status && open->op_created)
 		pr_warn("nfsd4_process_open2 failed to open newly-created file: status=%u\n",
 			be32_to_cpu(status));
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f10c22d02735..3aebe90a12ec 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6046,7 +6046,7 @@ static bool nfsd4_want_deleg_timestamps(const struct nfsd4_open *open)
 
 static struct nfs4_delegation *
 nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
-		    struct svc_fh *parent)
+		    struct svc_fh *parent_fh)
 {
 	bool deleg_ts = nfsd4_want_deleg_timestamps(open);
 	struct nfs4_client *clp = stp->st_stid.sc_client;
@@ -6146,8 +6146,8 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	if (status)
 		goto out_clnt_odstate;
 
-	if (parent) {
-		status = nfsd4_verify_deleg_dentry(open, fp, parent);
+	if (parent_fh && parent_fh->fh_dentry) {
+		status = nfsd4_verify_deleg_dentry(open, fp, parent_fh);
 		if (status)
 			goto out_unlock;
 	}
@@ -6288,13 +6288,12 @@ nfsd4_add_rdaccess_to_wrdeleg(struct svc_rqst *rqstp, struct nfsd4_open *open,
  */
 static void
 nfs4_open_delegation(struct svc_rqst *rqstp, struct nfsd4_open *open,
-		     struct nfs4_ol_stateid *stp, struct svc_fh *currentfh,
+		     struct nfs4_ol_stateid *stp, struct svc_fh *parent_fh,
 		     struct svc_fh *fh)
 {
 	struct nfs4_openowner *oo = openowner(stp->st_stateowner);
 	bool deleg_ts = nfsd4_want_deleg_timestamps(open);
 	struct nfs4_client *clp = stp->st_stid.sc_client;
-	struct svc_fh *parent = NULL;
 	struct nfs4_delegation *dp;
 	struct kstat stat;
 	int status = 0;
@@ -6308,8 +6307,6 @@ nfs4_open_delegation(struct svc_rqst *rqstp, struct nfsd4_open *open,
 				open->op_recall = true;
 			break;
 		case NFS4_OPEN_CLAIM_NULL:
-			parent = currentfh;
-			fallthrough;
 		case NFS4_OPEN_CLAIM_FH:
 			/*
 			 * Let's not give out any delegations till everyone's
@@ -6327,7 +6324,7 @@ nfs4_open_delegation(struct svc_rqst *rqstp, struct nfsd4_open *open,
 		default:
 			goto out_no_deleg;
 	}
-	dp = nfs4_set_delegation(open, stp, parent);
+	dp = nfs4_set_delegation(open, stp, parent_fh);
 	if (IS_ERR(dp))
 		goto out_no_deleg;
 
@@ -6337,7 +6334,7 @@ nfs4_open_delegation(struct svc_rqst *rqstp, struct nfsd4_open *open,
 		struct file *f = dp->dl_stid.sc_file->fi_deleg_file->nf_file;
 
 		if (!nfsd4_add_rdaccess_to_wrdeleg(rqstp, open, fh, stp) ||
-				!nfs4_delegation_stat(dp, currentfh, &stat)) {
+				!nfs4_delegation_stat(dp, fh, &stat)) {
 			nfs4_put_stid(&dp->dl_stid);
 			destroy_delegation(dp);
 			goto out_no_deleg;
@@ -6354,7 +6351,7 @@ nfs4_open_delegation(struct svc_rqst *rqstp, struct nfsd4_open *open,
 		spin_unlock(&f->f_lock);
 		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
 	} else {
-		open->op_delegate_type = deleg_ts && nfs4_delegation_stat(dp, currentfh, &stat) ?
+		open->op_delegate_type = deleg_ts && nfs4_delegation_stat(dp, fh, &stat) ?
 					 OPEN_DELEGATE_READ_ATTRS_DELEG : OPEN_DELEGATE_READ;
 		dp->dl_atime = stat.atime;
 		trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);
@@ -6403,6 +6400,7 @@ static bool open_xor_delegation(struct nfsd4_open *open)
  * nfsd4_process_open2 - finish open processing
  * @rqstp: the RPC transaction being executed
  * @current_fh: NFSv4 COMPOUND's current filehandle
+ * @parent_fh: filehandle of parent when CLAIM_NULL
  * @open: OPEN arguments
  *
  * If successful, (1) truncate the file if open->op_truncate was
@@ -6412,7 +6410,9 @@ static bool open_xor_delegation(struct nfsd4_open *open)
  * network byte order is returned.
  */
 __be32
-nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_open *open)
+nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh,
+		    struct svc_fh *parent_fh,
+		    struct nfsd4_open *open)
 {
 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
 	struct nfs4_client *cl = open->op_openowner->oo_owner.so_client;
@@ -6509,8 +6509,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	* Attempt to hand out a delegation. No error return, because the
 	* OPEN succeeds even if we fail.
 	*/
-	nfs4_open_delegation(rqstp, open, stp,
-		&resp->cstate.current_fh, current_fh);
+	nfs4_open_delegation(rqstp, open, stp, parent_fh, current_fh);
 
 	/*
 	 * If there is an existing open stateid, it must be updated and
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index b5ec2cdd61a0..ea61e1a4c263 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -974,7 +974,9 @@ __be32 nfsd4_reclaim_complete(struct svc_rqst *, struct nfsd4_compound_state *,
 extern __be32 nfsd4_process_open1(struct nfsd4_compound_state *,
 		struct nfsd4_open *open, struct nfsd_net *nn);
 extern __be32 nfsd4_process_open2(struct svc_rqst *rqstp,
-		struct svc_fh *current_fh, struct nfsd4_open *open);
+				  struct svc_fh *current_fh,
+				  struct svc_fh *parent_fh,
+				  struct nfsd4_open *open);
 extern void nfsd4_cstate_clear_replay(struct nfsd4_compound_state *cstate);
 extern void nfsd4_cleanup_open_state(struct nfsd4_compound_state *cstate,
 		struct nfsd4_open *open);
-- 
2.50.0.107.gf914562f5916.dirty


