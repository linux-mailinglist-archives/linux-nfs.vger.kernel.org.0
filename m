Return-Path: <linux-nfs+bounces-21555-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOPwGBRwA2p15wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21555-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:23:16 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2344A52778B
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2676C30A1E5B
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F8A374186;
	Tue, 12 May 2026 18:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnZJaPcv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B7A372B3C
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 18:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609653; cv=none; b=Snqxgcg/mHDexC/uaxrQAaDF4jRS49JQEMv6eM6LpSbjKfnWBcEYS6rqmGFUAguQYfLvh3SvLWoidELaX3OZbVPHpvGbDQT6TWs3PO8O7QfsjvFfH1ieX3Shucnj57Qs5t/4Njd6T2QKUKINK5vN5aj8JgsF6XaDd2yUwXQfWWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609653; c=relaxed/simple;
	bh=0FB57j08UIQkZ/zXwzT6vzkCcgtKWoiEyUpjHSYl+KI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZkBmv4OeAmMn0416Wg/+mFKALw+hZb1UGWQ6kPWdVTocDwTW6y4FZFkxnqgKPG15soqPbvpG+1OdnBh9JyKLM1fzv5F8Mqi4/WCSxCUzWs4jek0viXNO5JhKmqVRx+jIEG5BPbBjT97CrdQhlPj0nkH/sUju4zGP7So4QzzBQ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnZJaPcv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C884CC2BCF5;
	Tue, 12 May 2026 18:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609653;
	bh=0FB57j08UIQkZ/zXwzT6vzkCcgtKWoiEyUpjHSYl+KI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GnZJaPcvVMgx9g9PY6HWxUBZMve9t5oGV3lVNf8mDdklfpSPB1zX/SPfcXRC78sp5
	 kBU2/wQV4YWDDttuYVLJNum6Z0JRGME5MXEh8Hoq1jOrjgb50+dua6l2TWBi6oqNh7
	 5WCWrNSPThXOV5poYRtP5KrKCjfuGQoyeR6LWiZG/Kz8LJDaHPP7+aEAq81Oe9pIi7
	 Xj0WDjc1CQFHDLgqaMNwpdasGhigAtNQmdnvZqcosVIGW0dIm8RUPcJzF0KM3Q2If1
	 y6wTfGOMCAdg39TQ6V1aXvMc4n5YWxRNe2ycKhm1eLeguZ3zTNd4hst2XqJCMiDLt2
	 gPVYQi9hyJ3mw==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 12 May 2026 14:13:50 -0400
Subject: [PATCH 15/38] lockd: Use xdrgen XDR functions for the NLMv3 LOCK
 procedure
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nlm4-xdrgen-v1-15-19d99b2634b4@oracle.com>
References: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
In-Reply-To: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=6790;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=+xz6WCGTfjWyYIN6//YZTtmfOfxGdpFBkWrXvdii+AE=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqA23lTMdMZsjtDFw7GtJUPATzw+6VxFJYguLO2
 IvSCuZeywCJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagNt5QAKCRAzarMzb2Z/
 l0KGEAC29LJ7LXu6oRZUSRehnezFSYCCjqc4AppcHVtzdnD1dPKy3Q8NLl0Ej6ZoCvLtb8J0GAj
 DTIb2xg3zEgWh93Y24+vghJhwKgPm7D8pvBKCP4X8CM1rG5SuGXWROjU2+Se1KYmJ7oTAdTFdKH
 dqDhFDIm54Ssa2EQnlecsWK7Z9IwbId5teI7lFyY3sKWKw6N92C6alwDyOnOpBQS2BoCgH4dEbr
 1HNnqVUt7dv2hbeBo4bNq2thVCQV7/xeMaI5Kaf05sifxnaEtN/Wzs5HY18P0UwHEyy2mCF6S2b
 ejtOs0zVF7Yf155HrEJe1mZzuK7a7tvZCz1rxF9YTGR5Ojc6ExYsQtFraXqc4QPZ2lq+YdQc5ia
 S9jKZEcs4GBxUqmtt9oklFN1ITmTO2exzG0O5hnD9GN+GfdL2AKuspoqHpXDi8xn7y7OpEgoyya
 lx6gJtA4HQmetENShXPiKOuriqv41vhCK7UujHcmAHrID8wBN7OZodf8fLj99lvYoaj9nd80UWi
 rBFRChxm963JAwDSpTSEzDICkM/o8c5BzfcELwfSzpMbcWDB3tNueC5UfReicJE2iVUJa6G6xHM
 bnwqfPOTTANpscI6n67N8RtMlgAP/amcG7XUnAYdcmQXxgjf8basHIypJs4S9eqif7DHF5pSHDH
 Fbz9F1Fruhiiaew==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 2344A52778B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21555-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email,oracle.com:mid]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The NLM LOCK procedure requires the same host and file lookup
operations established in the TEST procedure conversion. This
patch extends the xdrgen migration to the LOCK procedure,
leveraging the shared nlm3svc_lookup_host() and
nlm3svc_lookup_file() helpers to establish consistent patterns
across the series.

This patch converts the LOCK procedure to use xdrgen functions
nlm_svc_decode_nlm_lockargs and nlm_svc_encode_nlm_res generated
from the NLM version 3 protocol specification. The procedure
handler uses xdrgen types through wrapper structures that bridge
between generated code and the legacy lockd_lock representation
still used by the core lockd logic.

Setting pc_argzero to zero is safe because the generated decoder
fills the argp->xdrgen subfields before the procedure runs, so
the zeroing memset performed by the dispatch layer is not needed.
The cookie and lock members of the wrapper are populated
explicitly in nlm_netobj_to_cookie() and nlm3svc_lookup_file()
rather than relying on zero-initialization.

The hand-rolled svcxdr_decode_cookie() previously substituted a
four-byte zero cookie when a zero-length cookie arrived on the
wire, a compatibility shim for HP-UX clients that had been
carried in fs/lockd/ since the original import. The xdrgen
decoder reproduces the cookie verbatim, and
nlm_netobj_to_cookie() copies whatever length the peer sent. As
subsequent patches replace the remaining call sites of
svcxdr_decode_cookie(), this series retires that HP-UX compat
behavior on the server side.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svcproc.c | 118 +++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 106 insertions(+), 12 deletions(-)

diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 7794e6f88a71..66bc9a2efddb 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -51,6 +51,30 @@ struct nlm_testres_wrapper {
 
 static_assert(offsetof(struct nlm_testres_wrapper, xdrgen) == 0);
 
+struct nlm_lockargs_wrapper {
+	struct nlm_lockargs		xdrgen;
+	struct lockd_cookie		cookie;
+	struct lockd_lock		lock;
+};
+
+static_assert(offsetof(struct nlm_lockargs_wrapper, xdrgen) == 0);
+
+struct nlm_res_wrapper {
+	struct nlm_res			xdrgen;
+};
+
+static_assert(offsetof(struct nlm_res_wrapper, xdrgen) == 0);
+
+static __be32
+nlm_netobj_to_cookie(struct lockd_cookie *cookie, netobj *object)
+{
+	if (object->len > NLM_MAXCOOKIELEN)
+		return nlm_lck_denied_nolocks;
+	cookie->len = object->len;
+	memcpy(cookie->data, object->data, object->len);
+	return nlm_granted;
+}
+
 static struct nlm_host *
 nlm3svc_lookup_host(struct svc_rqst *rqstp, string caller, bool monitored)
 {
@@ -385,10 +409,79 @@ __nlmsvc_proc_lock(struct svc_rqst *rqstp, struct lockd_res *resp)
 	return rc;
 }
 
+static __be32
+nlmsvc_do_lock(struct svc_rqst *rqstp, bool monitored)
+{
+	struct nlm_lockargs_wrapper *argp = rqstp->rq_argp;
+	unsigned char type = argp->xdrgen.exclusive ? F_WRLCK : F_RDLCK;
+	struct nlm_res_wrapper *resp = rqstp->rq_resp;
+	struct nlm_file	*file = NULL;
+	struct nlm_host	*host = NULL;
+
+	resp->xdrgen.cookie = argp->xdrgen.cookie;
+
+	resp->xdrgen.stat.stat = nlm_netobj_to_cookie(&argp->cookie,
+						      &argp->xdrgen.cookie);
+	if (resp->xdrgen.stat.stat)
+		goto out;
+
+	resp->xdrgen.stat.stat = nlm_lck_denied_nolocks;
+	host = nlm3svc_lookup_host(rqstp, argp->xdrgen.alock.caller_name,
+				   monitored);
+	if (!host)
+		goto out;
+
+	resp->xdrgen.stat.stat = nlm3svc_lookup_file(rqstp, host, &argp->lock,
+						     &file, &argp->xdrgen.alock,
+						     type);
+	if (resp->xdrgen.stat.stat)
+		goto out;
+
+	resp->xdrgen.stat.stat = cast_status(nlmsvc_lock(rqstp, file, host,
+							 &argp->lock,
+							 argp->xdrgen.block,
+							 &argp->cookie,
+							 argp->xdrgen.reclaim));
+
+	nlmsvc_release_lockowner(&argp->lock);
+
+out:
+	if (file)
+		nlm_release_file(file);
+	nlmsvc_release_host(host);
+	return resp->xdrgen.stat.stat == nlm__int__drop_reply ?
+		rpc_drop_reply : rpc_success;
+}
+
+/**
+ * nlmsvc_proc_lock - LOCK: Establish a monitored lock
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ *   %rpc_drop_reply:		Do not send an RPC reply.
+ *
+ * RPC synopsis:
+ *   nlm_res NLM_LOCK(nlm_lockargs) = 2;
+ *
+ * Permissible procedure status codes:
+ *   %LCK_GRANTED:		The requested lock was granted.
+ *   %LCK_DENIED:		The requested lock conflicted with existing
+ *				lock reservations for the file.
+ *   %LCK_DENIED_NOLOCKS:	The server could not allocate the resources
+ *				needed to process the request.
+ *   %LCK_BLOCKED:		The blocking request cannot be granted
+ *				immediately. The server will send an
+ *				NLM_GRANTED callback to the client when
+ *				the lock can be granted.
+ *   %LCK_DENIED_GRACE_PERIOD:	The server has recently restarted and is
+ *				re-establishing existing locks, and is not
+ *				yet ready to accept normal service requests.
+ */
 static __be32
 nlmsvc_proc_lock(struct svc_rqst *rqstp)
 {
-	return __nlmsvc_proc_lock(rqstp, rqstp->rq_resp);
+	return nlmsvc_do_lock(rqstp, true);
 }
 
 static __be32
@@ -674,7 +767,7 @@ nlmsvc_proc_nm_lock(struct svc_rqst *rqstp)
 	dprintk("lockd: NM_LOCK       called\n");
 
 	argp->monitor = 0;		/* just clean the monitor flag */
-	return nlmsvc_proc_lock(rqstp);
+	return __nlmsvc_proc_lock(rqstp, rqstp->rq_resp);
 }
 
 /*
@@ -771,15 +864,15 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_xdrressize	= NLM3_nlm_testres_sz,
 		.pc_name	= "TEST",
 	},
-	[NLMPROC_LOCK] = {
-		.pc_func = nlmsvc_proc_lock,
-		.pc_decode = nlmsvc_decode_lockargs,
-		.pc_encode = nlmsvc_encode_res,
-		.pc_argsize = sizeof(struct lockd_args),
-		.pc_argzero = sizeof(struct lockd_args),
-		.pc_ressize = sizeof(struct lockd_res),
-		.pc_xdrressize = Ck+St,
-		.pc_name = "LOCK",
+	[NLM_LOCK] = {
+		.pc_func	= nlmsvc_proc_lock,
+		.pc_decode	= nlm_svc_decode_nlm_lockargs,
+		.pc_encode	= nlm_svc_encode_nlm_res,
+		.pc_argsize	= sizeof(struct nlm_lockargs_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= sizeof(struct nlm_res_wrapper),
+		.pc_xdrressize	= NLM3_nlm_res_sz,
+		.pc_name	= "LOCK",
 	},
 	[NLMPROC_CANCEL] = {
 		.pc_func = nlmsvc_proc_cancel,
@@ -998,9 +1091,10 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
  */
 union nlmsvc_xdrstore {
 	struct nlm_testargs_wrapper	testargs;
+	struct nlm_lockargs_wrapper	lockargs;
 	struct nlm_testres_wrapper	testres;
+	struct nlm_res_wrapper		res;
 	struct lockd_args		args;
-	struct lockd_res		res;
 	struct lockd_reboot		reboot;
 };
 

-- 
2.54.0


