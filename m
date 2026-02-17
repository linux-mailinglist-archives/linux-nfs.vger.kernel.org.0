Return-Path: <linux-nfs+bounces-18986-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CM1FOgHnlGmjIgIAu9opvQ
	(envelope-from <linux-nfs+bounces-18986-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:09:05 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 510C5151503
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B84F63061442
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 22:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6DC313276;
	Tue, 17 Feb 2026 22:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFR6aQHx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3881131328B
	for <linux-nfs@vger.kernel.org>; Tue, 17 Feb 2026 22:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771366049; cv=none; b=JBI41cEXHe9HQb2vLmmOP0H2PLBHrqwC8pZerfnM4LIHJqfUrqcqyrFMt7wfxc7kGwBHjFqNdjLvWyc5Tvcq18s1Z7DGiZ60EpgZ9qCFdpKUhsx71bFWcVlOyhO6uDCnVghM0wi8i+blWTRZrqvKZ0AgBkG59x7z083pZLPZN2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771366049; c=relaxed/simple;
	bh=2bqltGzHT4xkR8Ul7BnUL+53iF6WyU2GaMkXnk1Oxng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B/fkG0lP5uCDmMw+Q0UeOQHGw+NXHNy0JcMDZ/GgWNbvT6ptfIuQnzDVXX/83iArxqU/9YfUWePHlJa+XltPf+AbkQvqIC/wqbmac0ktW5851g/9JLsLl2UCLsH6HT5IQUQZZlnJJBuATjSmmwxf5HbUuRZRx5XbVDKHxRyqs9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFR6aQHx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41621C19423;
	Tue, 17 Feb 2026 22:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771366048;
	bh=2bqltGzHT4xkR8Ul7BnUL+53iF6WyU2GaMkXnk1Oxng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BFR6aQHxct49gtbPlmNHRU1eFQ0p6pkb/krfX0jzChrlMfu6gk0VrhE65Annb9aYs
	 hyLQdR9pPHF1z3G+OGmWfQNhI6tbK7MGdKN20p9xjJiQ+WnzhdRTGWU0KNh3x9ExKf
	 pnbHpURtJNr5rbMSWIUQBfwf6T0nmdckzr3kMNvuRUQwV/B9w4vzKhg+OTEqTyGJ7Q
	 iJUQq88x0wzNkuYPBgUU6uTURvYoLDKbBE+6cJl5ehLvGPKf/BP5LQo3HTnUAzwFjb
	 lcv5WiSxCYCDDfDio3UyXcLqI046Wi8ZC29GUKChZ2R7acDTYkC30d9OQ9idAyJw9d
	 dY/PiQs31XYDQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 03/29] lockd: Use xdrgen XDR functions for the NLMv4 TEST procedure
Date: Tue, 17 Feb 2026 17:06:55 -0500
Message-ID: <20260217220721.1928847-4-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217220721.1928847-1-cel@kernel.org>
References: <20260217220721.1928847-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	TAGGED_FROM(0.00)[bounces-18986-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 510C5151503
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The NLM TEST procedure requires host and file lookups to check
lock state, operations that will be common across multiple NLM
procedures being migrated to xdrgen. By introducing the helper
functions nlm4svc_lookup_host() and nlm4svc_lookup_file() now,
we establish reusable patterns for subsequent conversions in
this series.

This patch converts the TEST procedure to use xdrgen functions
nlm4_svc_decode_testargs and nlm4_svc_encode_testres generated
from the NLM version 4 protocol specification. The procedure
handler is rewritten to use xdrgen types through wrapper
structures that bridge between generated code and the legacy
nlm_lock representation still used by the core lockd logic.
TEST_MSG is to be converted in a subsequent patch.

The pc_argzero field is set to zero because xdrgen decoders
reliably initialize all arguments in the argp->xdrgen field,
making the early defensive memset unnecessary. Remaining argp
fields are cleared as needed.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 186 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 174 insertions(+), 12 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 4fcd66beb4df..b07ab4d60871 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -28,6 +28,95 @@
 
 #define NLMDBG_FACILITY		NLMDBG_CLIENT
 
+/*
+ * Wrapper structures combine xdrgen types with legacy nlm_lock.
+ * The xdrgen field must be first so the structure can be cast
+ * to its XDR type for the RPC dispatch layer.
+ */
+struct nlm4_testargs_wrapper {
+	struct nlm4_testargs		xdrgen;
+	struct nlm_lock			lock;
+};
+
+static_assert(offsetof(struct nlm4_testargs_wrapper, xdrgen) == 0);
+
+struct nlm4_testres_wrapper {
+	struct nlm4_testres		xdrgen;
+	struct nlm_lock			lock;
+};
+
+static_assert(offsetof(struct nlm4_testres_wrapper, xdrgen) == 0);
+
+static struct nlm_host *
+nlm4svc_lookup_host(struct svc_rqst *rqstp, string caller, bool monitored)
+{
+	struct nlm_host *host;
+
+	if (!nlmsvc_ops)
+		return NULL;
+	host = nlmsvc_lookup_host(rqstp, caller.data, caller.len);
+	if (!host)
+		return NULL;
+	if (monitored && nsm_monitor(host) < 0) {
+		nlmsvc_release_host(host);
+		return NULL;
+	}
+	return host;
+}
+
+static __be32
+nlm4svc_lookup_file(struct svc_rqst *rqstp, struct nlm_host *host,
+		    struct nlm_lock *lock, struct nlm_file **filp,
+		    struct nlm4_lock *xdr_lock, unsigned char type)
+{
+	struct file_lock *fl = &lock->fl;
+	struct nlm_file *file = NULL;
+	__be32 error;
+
+	if (xdr_lock->fh.len > NFS_MAXFHSIZE)
+		return nlm_lck_denied_nolocks;
+	lock->fh.size = xdr_lock->fh.len;
+	memcpy(lock->fh.data, xdr_lock->fh.data, xdr_lock->fh.len);
+
+	lock->oh.len = xdr_lock->oh.len;
+	lock->oh.data = xdr_lock->oh.data;
+
+	lock->svid = xdr_lock->svid;
+	lock->lock_start = xdr_lock->l_offset;
+	lock->lock_len = xdr_lock->l_len;
+
+	if (lock->lock_start > OFFSET_MAX ||
+	    (lock->lock_len && ((lock->lock_len - 1) > (OFFSET_MAX - lock->lock_start))))
+		return nlm4_fbig;
+
+	locks_init_lock(fl);
+	fl->c.flc_type = type;
+	lockd_set_file_lock_range4(fl, lock->lock_start, lock->lock_len);
+
+	error = nlm_lookup_file(rqstp, &file, lock);
+	switch (error) {
+	case nlm_granted:
+		break;
+	case nlm__int__stale_fh:
+		return nlm4_stale_fh;
+	case nlm__int__failed:
+		return nlm4_failed;
+	default:
+		return error;
+	}
+	*filp = file;
+
+	fl->c.flc_flags = FL_POSIX;
+	fl->c.flc_file = file->f_file[lock_to_openmode(fl)];
+	fl->c.flc_pid = current->tgid;
+	fl->fl_lmops = &nlmsvc_lock_operations;
+	nlmsvc_locks_init_private(fl, host, (pid_t)lock->svid);
+	if (!fl->c.flc_owner)
+		return nlm_lck_denied_nolocks;
+
+	return nlm_granted;
+}
+
 /*
  * Obtain client and file from arguments
  */
@@ -151,10 +240,81 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
 	return rc;
 }
 
-static __be32
-nlm4svc_proc_test(struct svc_rqst *rqstp)
+/**
+ * nlm4svc_proc_test - TEST: Check for conflicting lock
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ *   %rpc_drop_reply:		Do not send an RPC reply.
+ *
+ * RPC synopsis:
+ *   nlm4_testres NLMPROC4_TEST(nlm4_testargs) = 1;
+ *
+ * Permissible procedure status codes:
+ *   %NLM4_GRANTED:		The server would be able to grant the
+ *				requested lock.
+ *   %NLM4_DENIED:		The requested lock conflicted with existing
+ *				lock reservations for the file.
+ *   %NLM4_DENIED_NOLOCKS:	The server could not allocate the resources
+ *				needed to process the request.
+ *   %NLM4_DENIED_GRACE_PERIOD:	The server has recently restarted and is
+ *				re-establishing existing locks, and is not
+ *				yet ready to accept normal service requests.
+ *
+ * The Linux NLM server implementation also returns:
+ *   %NLM4_STALE_FH:		The request specified an invalid file handle.
+ *   %NLM4_FBIG:		The request specified a length or offset
+ *				that exceeds the range supported by the
+ *				server.
+ *   %NLM4_FAILED:		The request failed for an unspecified reason.
+ */
+static __be32 nlm4svc_proc_test(struct svc_rqst *rqstp)
 {
-	return __nlm4svc_proc_test(rqstp, rqstp->rq_resp);
+	struct nlm4_testargs_wrapper *argp = rqstp->rq_argp;
+	unsigned char type = argp->xdrgen.exclusive ? F_WRLCK : F_RDLCK;
+	struct nlm4_testres_wrapper *resp = rqstp->rq_resp;
+	struct nlm_file	*file = NULL;
+	struct nlm_host	*host;
+
+	resp->xdrgen.cookie = argp->xdrgen.cookie;
+
+	resp->xdrgen.stat.stat = nlm_lck_denied_nolocks;
+	host = nlm4svc_lookup_host(rqstp, argp->xdrgen.alock.caller_name, false);
+	if (!host)
+		goto out;
+
+	resp->xdrgen.stat.stat = nlm4svc_lookup_file(rqstp, host, &argp->lock,
+						     &file, &argp->xdrgen.alock,
+						     type);
+	if (resp->xdrgen.stat.stat)
+		goto out;
+
+	resp->xdrgen.stat.stat = nlmsvc_testlock(rqstp, file, host,
+						 &argp->lock, &resp->lock);
+	nlmsvc_release_lockowner(&argp->lock);
+
+	if (resp->xdrgen.stat.stat == nlm_lck_denied) {
+		struct nlm_lock *conf = &resp->lock;
+		struct nlm4_holder *holder = &resp->xdrgen.stat.u.holder;
+
+		holder->exclusive = (conf->fl.c.flc_type != F_RDLCK);
+		holder->svid = conf->svid;
+		holder->oh.len = conf->oh.len;
+		holder->oh.data = conf->oh.data;
+		holder->l_offset = conf->fl.fl_start;
+		if (conf->fl.fl_end == OFFSET_MAX)
+			holder->l_len = 0;
+		else
+			holder->l_len = conf->fl.fl_end - conf->fl.fl_start + 1;
+	}
+
+out:
+	if (file)
+		nlm_release_file(file);
+	nlmsvc_release_host(host);
+	return resp->xdrgen.stat.stat == nlm__int__drop_reply ?
+		rpc_drop_reply : rpc_success;
 }
 
 static __be32
@@ -557,15 +717,15 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
 		.pc_xdrressize	= XDR_void,
 		.pc_name	= "NULL",
 	},
-	[NLMPROC_TEST] = {
-		.pc_func = nlm4svc_proc_test,
-		.pc_decode = nlm4svc_decode_testargs,
-		.pc_encode = nlm4svc_encode_testres,
-		.pc_argsize = sizeof(struct nlm_args),
-		.pc_argzero = sizeof(struct nlm_args),
-		.pc_ressize = sizeof(struct nlm_res),
-		.pc_xdrressize = Ck+St+2+No+Rg,
-		.pc_name = "TEST",
+	[NLMPROC4_TEST] = {
+		.pc_func	= nlm4svc_proc_test,
+		.pc_decode	= nlm4_svc_decode_nlm4_testargs,
+		.pc_encode	= nlm4_svc_encode_nlm4_testres,
+		.pc_argsize	= sizeof(struct nlm4_testargs_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= sizeof(struct nlm4_testres_wrapper),
+		.pc_xdrressize	= NLM4_nlm4_testres_sz,
+		.pc_name	= "TEST",
 	},
 	[NLMPROC_LOCK] = {
 		.pc_func = nlm4svc_proc_lock,
@@ -793,6 +953,8 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
  * Storage requirements for XDR arguments and results
  */
 union nlm4svc_xdrstore {
+	struct nlm4_testargs_wrapper	testargs;
+	struct nlm4_testres_wrapper	testres;
 	struct nlm_args			args;
 	struct nlm_res			res;
 	struct nlm_reboot		reboot;
-- 
2.53.0


