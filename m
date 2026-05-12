Return-Path: <linux-nfs+bounces-21559-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCupMBpuA2rF5gEAu9opvQ
	(envelope-from <linux-nfs+bounces-21559-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:14:50 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 896C95271E5
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4718C3038898
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3279F36CDE0;
	Tue, 12 May 2026 18:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i12gCRJ6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1005336F900
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 18:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609657; cv=none; b=IRgEPC5hD2OS7o3jnDW7xXrwOoK8TjlwzpLTwc4RncCiWtO1kpqOD/sGYardkNiifQkTAMIZhlfgGYeInHQZgF19PWlfSwfEasiRsmuAp7eA/Xv8SzVvg3ruk4ZhRdOCiIRYAQ+s3DB+BcsBoSX4OrP90CAjHyQcIru9v2ZupEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609657; c=relaxed/simple;
	bh=yx/4ZUvKGxUaCj+HkXVu3Ahm9Tw3dSisrmPi3sSnQ1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XqJtDVRp4w+FUaH21bJj+FTllhy6uIiobnvvyKmPr8oBt4R6Sx9AIcYgcqhYqgxdJ6kiOmJgd8Iq6dwB7NHrh8CNyHdOyf4LlJQ+BObRo2w9N22ScMImhkpLaut3n9BCreWkkyQNHZIIL7bVDsG54HriWZW1LvPtFKasstJ+mOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i12gCRJ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7B6C2BCFB;
	Tue, 12 May 2026 18:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609657;
	bh=yx/4ZUvKGxUaCj+HkXVu3Ahm9Tw3dSisrmPi3sSnQ1A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=i12gCRJ6ZMxays/eP4ITN5wSvHjV/7kXqL7m0DB2GXOhpktorAlkq6/cqEsKKH/XB
	 zl6j7CouX7l3J1bPs3w84jsfS3qHhLAZLS2LEiuZK6lnYqE9ifbniSOmsh1m/T/5x5
	 AL9Dk4tOhnq1tH7HqjBPJSP5SjRt+r13HASo4fMyFzwI3kAQOQVyftsHhSjIafyIEu
	 vZQXmE1dBaxJGIXvewC0K2udmAf+c90dSsSAH2oKv+LGyDtsHj0VTsSNCqAwekH8p6
	 QH+D2uE+JHz14+Z1v+7QnOI+iQeBC2KHfsERuSjI99l49i8suhRezZfN6ioATvEuh4
	 Kdn3HaY2Q8NPA==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 12 May 2026 14:13:54 -0400
Subject: [PATCH 19/38] lockd: Refactor nlmsvc_callback()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nlm4-xdrgen-v1-19-19d99b2634b4@oracle.com>
References: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
In-Reply-To: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=4339;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=kQwviLDkgqXpHhb5MMkb4Eu6uB0e7Haz1cc9NI4WiKk=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqA23laV+I/wRUsQxIaeYQlzo1Swf3UXtZWwbxa
 tUuDxhLu26JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagNt5QAKCRAzarMzb2Z/
 l+YUEAC2ludpmyTgj4U/22tl+jXuEvmLR951r0GnBKVw8cmu6WbPxwsrgvhLafFHvKXnq6qVijB
 cM52nV0xNz/DTj4WSPhQHvJg6xGRc/RzrxIEnbJMZuGGmI4YtWfUqPZy9ySwn1BA5f728gCmB6k
 opAYELXMOiVVMw1MMwAJJnntxPS755k/4wypu9FbyjDTNkUAVWA3gr4kzNHK8cwp0aq39sM39kp
 C2kbvyv9JD18rGa13G/5PR2qpyByg/8N+LqRKKUbujilLmAUvifsqKwxC/dTG48aSpR316ELo6G
 SrGsMFY+Jl1tDVSHriVWCgUhbO6nl8PmkrrOkIoNs9Ikve3PK7GANxrjq2Q9ulHqDxZoBDsVdE+
 MuazGPdfuUMlgsA+l2t8Li/RbBdBlSFcf63r5AF7F0KVTzBi8n0NrxKOBgyIy6GwFGVk/NG7bs0
 ukGFhK65gnIQa2wMKU3Z4zlFRXzkqd8OSFrsKs/yiezouu6qiHTDVpnPxCahD57RsJs0DMZWR2I
 JjjTFqJAwGYt1iOLWCeeZOB5CrYWzX6fCf2A/5O7ouF3GFoS4DvObLXe62yzmGkh+enLooy1tVD
 y/5IxrjNVTytoqGaB8IkfyM9UHC79RKU5W4G4+ohLttkGm1pxKg2rPVva97yX1BeavdJ76BcQSR
 1Ml0s/PJv0Wrw9A==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 896C95271E5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21559-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The xdrgen-based XDR conversion requires each RPC procedure to
extract its own arguments, since xdrgen generates distinct
argument structures for each procedure rather than using a
single shared type.

Move the host lookup logic from nlmsvc_callback() into each
of the five MSG procedure handlers (TEST_MSG, LOCK_MSG,
CANCEL_MSG, UNLOCK_MSG, and GRANTED_MSG). Each handler now
performs its own host lookup from rqstp->rq_argp and passes
the resulting host pointer to nlmsvc_callback(). This
establishes the per-procedure argument-handling pattern that
the subsequent xdrgen conversion patches require.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svcproc.c | 72 ++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 54 insertions(+), 18 deletions(-)

diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 264212e44ec5..2e6afb9a19b9 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -781,20 +781,13 @@ static const struct rpc_call_ops nlmsvc_callback_ops = {
  * because we send the callback before the reply proper. I hope this
  * doesn't break any clients.
  */
-static __be32 nlmsvc_callback(struct svc_rqst *rqstp, u32 proc,
+static __be32
+nlmsvc_callback(struct svc_rqst *rqstp, struct nlm_host *host, u32 proc,
 		__be32 (*func)(struct svc_rqst *, struct lockd_res *))
 {
-	struct lockd_args *argp = rqstp->rq_argp;
-	struct nlm_host	*host;
 	struct nlm_rqst	*call;
 	__be32 stat;
 
-	host = nlmsvc_lookup_host(rqstp,
-				  argp->lock.caller,
-				  argp->lock.len);
-	if (host == NULL)
-		return rpc_system_err;
-
 	call = nlm_alloc_call(host);
 	nlmsvc_release_host(host);
 	if (call == NULL)
@@ -814,34 +807,77 @@ static __be32 nlmsvc_callback(struct svc_rqst *rqstp, u32 proc,
 
 static __be32 nlmsvc_proc_test_msg(struct svc_rqst *rqstp)
 {
+	struct lockd_args *argp = rqstp->rq_argp;
+	struct nlm_host	*host;
+
 	dprintk("lockd: TEST_MSG      called\n");
-	return nlmsvc_callback(rqstp, NLMPROC_TEST_RES, __nlmsvc_proc_test);
+
+	host = nlmsvc_lookup_host(rqstp, argp->lock.caller, argp->lock.len);
+	if (!host)
+		return rpc_system_err;
+
+	return nlmsvc_callback(rqstp, host, NLMPROC_TEST_RES,
+			       __nlmsvc_proc_test);
 }
 
 static __be32 nlmsvc_proc_lock_msg(struct svc_rqst *rqstp)
 {
+	struct lockd_args *argp = rqstp->rq_argp;
+	struct nlm_host	*host;
+
 	dprintk("lockd: LOCK_MSG      called\n");
-	return nlmsvc_callback(rqstp, NLMPROC_LOCK_RES, __nlmsvc_proc_lock);
+
+	host = nlmsvc_lookup_host(rqstp, argp->lock.caller, argp->lock.len);
+	if (!host)
+		return rpc_system_err;
+
+	return nlmsvc_callback(rqstp, host, NLMPROC_LOCK_RES,
+			       __nlmsvc_proc_lock);
 }
 
 static __be32 nlmsvc_proc_cancel_msg(struct svc_rqst *rqstp)
 {
+	struct lockd_args *argp = rqstp->rq_argp;
+	struct nlm_host	*host;
+
 	dprintk("lockd: CANCEL_MSG    called\n");
-	return nlmsvc_callback(rqstp, NLMPROC_CANCEL_RES, __nlmsvc_proc_cancel);
+
+	host = nlmsvc_lookup_host(rqstp, argp->lock.caller, argp->lock.len);
+	if (!host)
+		return rpc_system_err;
+
+	return nlmsvc_callback(rqstp, host, NLMPROC_CANCEL_RES,
+			       __nlmsvc_proc_cancel);
 }
 
-static __be32
-nlmsvc_proc_unlock_msg(struct svc_rqst *rqstp)
+static __be32 nlmsvc_proc_unlock_msg(struct svc_rqst *rqstp)
 {
+	struct lockd_args *argp = rqstp->rq_argp;
+	struct nlm_host	*host;
+
 	dprintk("lockd: UNLOCK_MSG    called\n");
-	return nlmsvc_callback(rqstp, NLMPROC_UNLOCK_RES, __nlmsvc_proc_unlock);
+
+	host = nlmsvc_lookup_host(rqstp, argp->lock.caller, argp->lock.len);
+	if (!host)
+		return rpc_system_err;
+
+	return nlmsvc_callback(rqstp, host, NLMPROC_UNLOCK_RES,
+			       __nlmsvc_proc_unlock);
 }
 
-static __be32
-nlmsvc_proc_granted_msg(struct svc_rqst *rqstp)
+static __be32 nlmsvc_proc_granted_msg(struct svc_rqst *rqstp)
 {
+	struct lockd_args *argp = rqstp->rq_argp;
+	struct nlm_host	*host;
+
 	dprintk("lockd: GRANTED_MSG   called\n");
-	return nlmsvc_callback(rqstp, NLMPROC_GRANTED_RES, __nlmsvc_proc_granted);
+
+	host = nlmsvc_lookup_host(rqstp, argp->lock.caller, argp->lock.len);
+	if (!host)
+		return rpc_system_err;
+
+	return nlmsvc_callback(rqstp, host, NLMPROC_GRANTED_RES,
+			       __nlmsvc_proc_granted);
 }
 
 /*

-- 
2.54.0


