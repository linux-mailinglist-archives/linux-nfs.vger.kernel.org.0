Return-Path: <linux-nfs+bounces-22424-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1PiINttTKGoECQMAu9opvQ
	(envelope-from <linux-nfs+bounces-22424-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 19:56:43 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA996631D1
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 19:56:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RqGwVv5Z;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22424-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22424-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82691316D505
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jun 2026 17:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319574DB563;
	Tue,  9 Jun 2026 17:48:22 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D594DB549;
	Tue,  9 Jun 2026 17:48:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781027302; cv=none; b=VnwtwNM8dMYKDHuO5BEh2aAInCMuhQiF8Y3YhWtYIpHM9JeZL7ElNHhDYLnVAqNcZ/tRqsNEv6tHShVMv//FvozYb33mc1Ef2h1RNSVZHmNLCLqvTp6QBnYXP67tlQ3c10xUHB1qjAXyVJ7JM1xmqnXSvni2W9ak2Xa4xDX6zB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781027302; c=relaxed/simple;
	bh=1kJ1ChSnKS7J7VfqTRws065X/L9ZOSDN8gGyGpZUVMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mv9A+4eTBxMOl2LitX6cSa/SEIlZYPnBkHb1F1swBzXjMZ1Q3yR7dEqm0Kt4BNK8Hppz7XRdKyT5P05REzLGeQhODHcgQJDxq3fUCL6HSEPoBZVVA17017agBpGbg2IrIYXcr+4EyZ9VGZVcU5W9R4YfnFUeoj4NLJleC1LIsow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqGwVv5Z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F851F00893;
	Tue,  9 Jun 2026 17:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781027300;
	bh=lBaZdFp81xmuHwEZkfS1LrWrg1i5jjVrUOrBMB1dFV0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RqGwVv5ZK96k5x2u/cjTrKczlD0Vklc/cCMe2148npAn46hnjqdWf9DRQXnfIp/mw
	 mBW11I4mgI1gvT+pno5GLUFhdBqq1lpF3rl/RDzaOg6CzjVjsZpHJ6Rtyp1Nz+OK3u
	 i5wYKYBSjQFPQFQ+tQ6pgqFkmWLnbb0h0/1qvnnB4FPYUv7ilRHG+qZN0AZi/CtmQT
	 xsfNP/hAf1yA3YONJLmHl8uSoyghsdupzN3LcYTyQM+aEfft2bWlBII1Qgu3wB6N/r
	 ZSTDu6Moi4hChcEBVATS//QopGnc2MWTD107Bpb5NQi4za1sMhlRg3og+hqSq+5Rhx
	 3ZGCJswp6nvVg==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 09 Jun 2026 13:47:38 -0400
Subject: [PATCH 17/19] lockd, nfsd: RCU-protect nlmsvc_ops dispatch
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-nfsd-testing-v1-17-e83acead2ae8@kernel.org>
References: <20260609-nfsd-testing-v1-0-e83acead2ae8@kernel.org>
In-Reply-To: <20260609-nfsd-testing-v1-0-e83acead2ae8@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Benjamin Coddington <bcodding@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Muchun Song <muchun.song@linux.dev>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7682; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=1kJ1ChSnKS7J7VfqTRws065X/L9ZOSDN8gGyGpZUVMg=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKFG9aoVc3h9z1cSle/dQyXdvWI0XgRabuZ4WU
 FdFWAgzMZ+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaihRvQAKCRAADmhBGVaC
 FUPpEACa2JKadsKY65GvuWsMZ8kdkQ8BXy8qy+avvuZthnstULgAjpBbbMedxygMVU5x/tH566B
 IYRpoS5V2UZw8a5lXwAb4WHbkTrqWSft/kM4D1zGQJk2Bk/vBNJwGA6zgES3oJhLehReAoNA2Ry
 PtahY0p9AV9B84MvSRpTIqzr0JH0PFXygpltUwibV92JZbMtzedjSvNVLcJKFSCFGhhOrFt+cRu
 BhK1CsDQ6azsRYEuKfPWwC63S9Tukuv0miw4QbBfIo9QFfj5DHx63rwMafsLlwRRLpEe+OGoimZ
 WUbYxlECIz8HqWCMcr7LIym7WXgd9c5XwE989x3i+h6I5u1/CJ2/C/+iIGbGb4aetFwqmBYPWpw
 DnBc1ltSqGy8TKroJOLSWbqYDrnRCNW81XVLv7uGfIU4mB38g5lNR9kv6ErPX7RcKtLkbQDRQMr
 RpQNoWh5CB7Lc1Ww9VpoMzZV9Ow7doE0f9Xy11AuhNuJyIbvhw9vCElrV09Ls29Si+QVpB+2MqE
 f2vxa4378QUGp6elSEOs36CcLCpBz4xHHpl/6iPSu+nDJjwcbCZM0erC4Tf5QAOlfYPCMJCYHqq
 Ff4+v2t+r5THBE2WpH4xO0zt5+J3T0Yb7fr4NesLbqXSoD6X0MUj1vNXGhJM7do7ifP9bTUIWc8
 /Nc/dtufmn87fVA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:brauner@kernel.org,m:bcodding@redhat.com,m:donald.hunter@gmail.com,m:lorenzo@kernel.org,m:qi.zheng@linux.dev,m:akpm@linux-foundation.org,m:muchun.song@linux.dev,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:jlayton@kernel.org,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_TO(0.00)[kernel.org,oracle.com,brown.name,redhat.com,talpey.com,davemloft.net,google.com,gmail.com,linux.dev,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22424-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8CA996631D1

nlmsvc_ops is published by nfsd_lockd_init() and cleared by
nfsd_lockd_shutdown() with plain stores, while lockd dereferences
it unguarded from dispatch sites in fs/lockd/svcsubs.c. The pointer
targets nfsd's .rodata and the fopen/fclose callbacks live in nfsd's
.text, so a stale load after rmmod nfsd results in either a NULL
deref or a module-text use-after-free.

Declare nlmsvc_ops as __rcu, publish via rcu_assign_pointer(), clear
via RCU_INIT_POINTER() + synchronize_rcu(). Add a struct module
*owner field to nlmsvc_binding and pin the module across indirect
calls with try_module_get/module_put. When the binding is torn down,
fall back to fput() to avoid leaking struct file references.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/lockd/svc.c             |  4 ++--
 fs/lockd/svc4proc.c        |  4 ++--
 fs/lockd/svcproc.c         |  4 ++--
 fs/lockd/svcsubs.c         | 52 +++++++++++++++++++++++++++++++++++++++-------
 fs/nfsd/lockd.c            |  6 ++++--
 include/linux/lockd/bind.h | 12 ++++++++---
 6 files changed, 64 insertions(+), 18 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 490551369ef2..ee90e743064a 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -47,7 +47,7 @@
 
 static struct svc_program	nlmsvc_program;
 
-const struct nlmsvc_binding	*nlmsvc_ops;
+const struct nlmsvc_binding __rcu *nlmsvc_ops;
 EXPORT_SYMBOL_GPL(nlmsvc_ops);
 
 static DEFINE_MUTEX(nlmsvc_mutex);
@@ -142,7 +142,7 @@ lockd(void *vrqstp)
 		nlmsvc_retry_blocked(rqstp);
 		svc_recv(rqstp, 0);
 	}
-	if (nlmsvc_ops)
+	if (rcu_access_pointer(nlmsvc_ops))
 		nlmsvc_invalidate_all();
 	nlm_shutdown_hosts();
 	cancel_delayed_work_sync(&ln->grace_period_end);
diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 78e675470c4b..080dffce9d8e 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -128,7 +128,7 @@ nlm4svc_lookup_host(struct svc_rqst *rqstp, string caller, bool monitored)
 {
 	struct nlm_host *host;
 
-	if (!nlmsvc_ops)
+	if (!rcu_access_pointer(nlmsvc_ops))
 		return NULL;
 	host = nlmsvc_lookup_host(rqstp, caller.data, caller.len);
 	if (!host)
@@ -894,7 +894,7 @@ static __be32 nlm4svc_proc_granted_res(struct svc_rqst *rqstp)
 {
 	struct nlm4_res_wrapper *argp = rqstp->rq_argp;
 
-	if (!nlmsvc_ops)
+	if (!rcu_access_pointer(nlmsvc_ops))
 		return rpc_success;
 
 	if (nlm4_netobj_to_cookie(&argp->cookie, &argp->xdrgen.cookie))
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 4836887f11ef..dce6f6e3fd40 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -133,7 +133,7 @@ nlm3svc_lookup_host(struct svc_rqst *rqstp, string caller, bool monitored)
 {
 	struct nlm_host *host;
 
-	if (!nlmsvc_ops)
+	if (!rcu_access_pointer(nlmsvc_ops))
 		return NULL;
 	host = nlmsvc_lookup_host(rqstp, caller.data, caller.len);
 	if (!host)
@@ -923,7 +923,7 @@ static __be32 nlmsvc_proc_granted_res(struct svc_rqst *rqstp)
 {
 	struct nlm_res_wrapper *argp = rqstp->rq_argp;
 
-	if (!nlmsvc_ops)
+	if (!rcu_access_pointer(nlmsvc_ops))
 		return rpc_success;
 
 	if (nlm_netobj_to_cookie(&argp->cookie, &argp->xdrgen.cookie))
diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index d7ada90dc048..e44eb20d3453 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -90,22 +90,35 @@ int lock_to_openmode(struct file_lock *lock)
 static __be32 nlm_do_fopen(struct svc_rqst *rqstp,
 			   struct nlm_file *file, int mode)
 {
+	const struct nlmsvc_binding *ops;
 	__be32 nlmerr = nlm__int__failed;
 	__be32 deferred = 0;
 	int error;
 	int m;
 
+	rcu_read_lock();
+	ops = rcu_dereference(nlmsvc_ops);
+	if (!ops || !try_module_get(ops->owner)) {
+		rcu_read_unlock();
+		return nlm__int__failed;
+	}
+	rcu_read_unlock();
+
 	for (m = O_RDONLY; m <= O_WRONLY; m++) {
 		struct file **fp = &file->f_file[m];
 
 		if (mode != O_RDWR && mode != m)
 			continue;
-		if (*fp)
+		if (*fp) {
+			module_put(ops->owner);
 			return nlm_granted;
+		}
 
-		error = nlmsvc_ops->fopen(rqstp, &file->f_handle, fp, m);
-		if (!error)
+		error = ops->fopen(rqstp, &file->f_handle, fp, m);
+		if (!error) {
+			module_put(ops->owner);
 			return nlm_granted;
+		}
 
 		dprintk("lockd: open failed (errno %d)\n", error);
 		switch (error) {
@@ -122,6 +135,7 @@ static __be32 nlm_do_fopen(struct svc_rqst *rqstp,
 		}
 	}
 
+	module_put(ops->owner);
 	return deferred ? deferred : nlmerr;
 }
 
@@ -185,6 +199,33 @@ nlm_lookup_file(struct svc_rqst *rqstp, struct nlm_file **result,
 	goto out_unlock;
 }
 
+/*
+ * Release the struct file references held by a nlm_file.
+ */
+static void nlm_release_files(struct nlm_file *file)
+{
+	const struct nlmsvc_binding *ops;
+	bool have_ops;
+
+	rcu_read_lock();
+	ops = rcu_dereference(nlmsvc_ops);
+	have_ops = ops && try_module_get(ops->owner);
+	rcu_read_unlock();
+
+	if (have_ops) {
+		if (file->f_file[O_RDONLY])
+			ops->fclose(file->f_file[O_RDONLY]);
+		if (file->f_file[O_WRONLY])
+			ops->fclose(file->f_file[O_WRONLY]);
+		module_put(ops->owner);
+	} else {
+		if (file->f_file[O_RDONLY])
+			fput(file->f_file[O_RDONLY]);
+		if (file->f_file[O_WRONLY])
+			fput(file->f_file[O_WRONLY]);
+	}
+}
+
 /*
  * Delete a file after having released all locks, blocks and shares
  */
@@ -194,10 +235,7 @@ nlm_delete_file(struct nlm_file *file)
 	nlm_debug_print_file("closing file", file);
 	if (!hlist_unhashed(&file->f_list)) {
 		hlist_del(&file->f_list);
-		if (file->f_file[O_RDONLY])
-			nlmsvc_ops->fclose(file->f_file[O_RDONLY]);
-		if (file->f_file[O_WRONLY])
-			nlmsvc_ops->fclose(file->f_file[O_WRONLY]);
+		nlm_release_files(file);
 		kfree(file);
 	} else {
 		printk(KERN_WARNING "lockd: attempt to release unknown file!\n");
diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
index 6fe1325815e0..72a5b499839d 100644
--- a/fs/nfsd/lockd.c
+++ b/fs/nfsd/lockd.c
@@ -92,6 +92,7 @@ nlm_fclose(struct file *filp)
 }
 
 static const struct nlmsvc_binding nfsd_nlm_ops = {
+	.owner		= THIS_MODULE,
 	.fopen		= nlm_fopen,		/* open file for locking */
 	.fclose		= nlm_fclose,		/* close file */
 };
@@ -100,11 +101,12 @@ void
 nfsd_lockd_init(void)
 {
 	dprintk("nfsd: initializing lockd\n");
-	nlmsvc_ops = &nfsd_nlm_ops;
+	rcu_assign_pointer(nlmsvc_ops, &nfsd_nlm_ops);
 }
 
 void
 nfsd_lockd_shutdown(void)
 {
-	nlmsvc_ops = NULL;
+	RCU_INIT_POINTER(nlmsvc_ops, NULL);
+	synchronize_rcu();
 }
diff --git a/include/linux/lockd/bind.h b/include/linux/lockd/bind.h
index b614e0deea72..db8207d4059f 100644
--- a/include/linux/lockd/bind.h
+++ b/include/linux/lockd/bind.h
@@ -16,17 +16,23 @@ struct svc_rqst;
 struct rpc_task;
 struct rpc_clnt;
 struct super_block;
+struct module;
 
-/*
- * This is the set of functions for lockd->nfsd communication
+/**
+ * struct nlmsvc_binding - lockd -> nfsd callback table
+ * @owner:  module that provides this binding.
+ * @fopen:  open a file by NFS file handle on behalf of an NLM request.
+ * @fclose: close a file that was previously opened via @fopen.
+ *          Implementations MUST be semantically equivalent to fput().
  */
 struct nlmsvc_binding {
+	struct module	*owner;
 	int		(*fopen)(struct svc_rqst *rqstp, struct nfs_fh *f,
 				 struct file **filp, int flags);
 	void		(*fclose)(struct file *filp);
 };
 
-extern const struct nlmsvc_binding *nlmsvc_ops;
+extern const struct nlmsvc_binding __rcu *nlmsvc_ops;
 
 /*
  * Similar to nfs_client_initdata, but without the NFS-specific

-- 
2.54.0


