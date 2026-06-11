Return-Path: <linux-nfs+bounces-22510-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FL9+CQYVK2pl2QMAu9opvQ
	(envelope-from <linux-nfs+bounces-22510-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 22:05:26 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B82D674EF6
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 22:05:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UbFz9825;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22510-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22510-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4F0B53044A41
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 20:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3063A6F16;
	Thu, 11 Jun 2026 20:01:24 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43AD3A48E9;
	Thu, 11 Jun 2026 20:01:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781208084; cv=none; b=U/0TrW419ivNTmOUXcZqNyB/D33oOCu/fWjeys/Be0KaYOoZEfOG5sk67nSN6aMIFzz2bAIIWU74JVHL3Om2u79N0sht5KbdjAUyQUrL2ugzFNJtTjIHBGtuq9Ri/oh92lnFVncoD5HZCMCVzJcMNuJDYoslOtwG+evuTK20cgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781208084; c=relaxed/simple;
	bh=1kJ1ChSnKS7J7VfqTRws065X/L9ZOSDN8gGyGpZUVMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FN6uUOfQcnPGwcYkGe/n8KqvQVRfvp6XONY0EduLktDyEiamUhVim+7VcW8Srv974Wzp3+ntOUQPlqswzDpHcG2ksXUg3fwrR/GiEG1hFhCpfEvq1l8SXVu9rmqN6cY2fNc5VxHdiRdw9CymPfq3sIDSM4nU77DJ0xNwWDXy71g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbFz9825; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C8C1F00A3A;
	Thu, 11 Jun 2026 20:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781208082;
	bh=lBaZdFp81xmuHwEZkfS1LrWrg1i5jjVrUOrBMB1dFV0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UbFz9825eKlrAQaPib5EA+eMJBYFlwCi9Ml+bk7/MC9n3c1ykW3iueYOeC+BUELtp
	 TA1auqHZtnhZt2zqy4ydt7fSG0sJ8Er55PW01YmoKruVqD/TTwM1h1VqLJIaT6yaeQ
	 o0hlQARBC/huigoRRxiAF3j812LTFfP5TfVkbHCwMgJ5Gh2CqT15VQSHXaz+S+kEIi
	 GE6WkwB+/JZ/DAYhdW893MBfQcYVZcb1y0FhIWE5DzYfm9OfIyPVSpstfIIpKjo2qw
	 WZmLsxOwOyDUzgxEMHdhKEkwJlEm2bwUi7g1/YoSBWlYeQNIMnFDaGfzBPr/hAtk8q
	 9CgEa8Qa0Nrhg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jun 2026 16:00:59 -0400
Subject: [PATCH v2 16/21] lockd, nfsd: RCU-protect nlmsvc_ops dispatch
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-nfsd-testing-v2-16-5b90e276f2d9@kernel.org>
References: <20260611-nfsd-testing-v2-0-5b90e276f2d9@kernel.org>
In-Reply-To: <20260611-nfsd-testing-v2-0-5b90e276f2d9@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7682; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=1kJ1ChSnKS7J7VfqTRws065X/L9ZOSDN8gGyGpZUVMg=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKxQAUhHhSmdmuG/eyJEjl+B6VDCr2HzW7M7h5
 1Pth7olmNmJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaisUAAAKCRAADmhBGVaC
 FdoYD/4lDVmbr/wDbD8xkL5GUoyLxTsSZ5zhVaHb5enGzd1GJUkKjTyTnfz3JM3MUxl3ESh4lnF
 KDK+weOQ0I5jSOgUXPzE/9awOn6skmSwKIcJStil5stpEL5aWrO0JxaaqA50vYrJBmQRoVeEJ5o
 kYcC3IhdZxwf5UMDIvOEOPFLEN3ZEs0lfrx1KD9R3YeX5dO+Gx6leOsBlxiimQ1M546A0Nkt42E
 UaaMZ//p0aFhf2/HGr04tCkwB48T9YPrPrO7mDJ4cfPAqpkbQfD3hgzIjzUBZBx/bIMiv2GY1d4
 8KSfoqGWU7meAmX3pl/TWZmtoAVlruS39XNI35IEUcX0TmxjqZ/T2iSaFkgVs7+zeRQnEJhnNq0
 YshzLS4SA7YYgHkFw7Bguq6FLmb69CudAgGAP4xaunR60hC/EFeTm7sigpC6S8dgG+bu7PUGeWS
 sWTktk1tDDeDALOdzjKT8FXxVvJ+tHOrM4dBfs/XigzjxMLE/Tzgj0mHs+978SvjzP/yMqM57zS
 jk4MmRyOO9CsaoEx8B6hdqpyQfZtxKBkgz7tA3Oo8d4he9uJx4Ax4a2oWw7Md2v7P2qhGCJ56CH
 BGl2JgpBmMZ+Agd5jTQLX88UIFEkpzelWeZJgljIm9/0lZVJzJyhgFnsAQnRTCT8xAkb5WsubZJ
 GcqIiybHEaHan1w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22510-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:clm@meta.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B82D674EF6

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


