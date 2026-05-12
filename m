Return-Path: <linux-nfs+bounces-21554-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JgaLvNvA2p15wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21554-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:22:43 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DE5527724
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 373D93123A81
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5516368972;
	Tue, 12 May 2026 18:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uv91U4GM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32D9374E60
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 18:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609652; cv=none; b=IRQHQZg/ofEDm5tuwN09PRxkmU3BbpFb8a4n4oOcEiFJP2dU3U0PM/f5FvkV9/I0SFaOsn2COoir6MsxGsZhvwUcwj+vf73jjr2P3lf+qRbW2NKyWuIis1lQAOjSQOcCJf2vnzm8ENARtwYE6wbJi3n9snyYWOb5rCeouatq2ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609652; c=relaxed/simple;
	bh=ISrqb2TZ+bbRW3oNYyfLoiBvOCSUGOQsWwg/vRwki4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M1P2+2puZrGqddh8eskPE3vCiIL0qdRjnd2VFaUStV3GiujcoZTBBMwjuJL2A/Ov2tM3n55xi8SEFryIY8e8IVQ6ZiVVTrViJzBIVipimqx6hI4e8eWJxwcvNnaZmShTkriyxGPoJI4HuF2w7Wb7B45ihIuuU2+JgPViExD3/nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uv91U4GM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC58BC2BCB0;
	Tue, 12 May 2026 18:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609652;
	bh=ISrqb2TZ+bbRW3oNYyfLoiBvOCSUGOQsWwg/vRwki4M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Uv91U4GM0bQxqgh9sOX52B3gHZLro2citYPYSrMrKwTE4vggaVb/gHdwh5o6P7BUY
	 2jwQq6uBeyd3gYjngOk8IpXUM/o3qvOKGg3CdufKy1B4wa2+eutoZdT3y3stpiGg5m
	 QT84H0LXNmLcENwhqnJzSjjVmfzURAIDCPYXCAXWgQy2jUsgDGXD3sZClcatGKcw3l
	 U5GHdTH5Fl8+HLRc2SCDCpqhA+xSqHwFryMFS/UKojYwUxAkh/9yjtu3QfDkc9VWoQ
	 J7KB0O9weSEb1eimeJY9kXS6g/FqflWrmImfpQzf0bLiiFvd4hG97MPzNtW+YanHwy
	 gZ80FX/rzZ9CQ==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 12 May 2026 14:13:49 -0400
Subject: [PATCH 14/38] lockd: Use xdrgen XDR functions for the NLMv3 TEST
 procedure
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nlm4-xdrgen-v1-14-19d99b2634b4@oracle.com>
References: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
In-Reply-To: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=10487;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=+9QLxyFhZ7V2nfBgv7hf7uh8f+0Y5+c3f8DFO+CROns=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqA23lpRrfmrglBFvOoefcy8iKmMooU3ZpfxDur
 1wNd/s8s7qJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagNt5QAKCRAzarMzb2Z/
 l6RiD/4sB2i50QTr6c0lD6m/enZz1M+GkgoTE4c5CKrJlvP+kky9sR3xk7yLOQPDlLxA2egYc1o
 efA911bsI+WJkREZNonuBewQZYl3pkgxv/Tp8LKZsPIoKTv9Yp73PYorzwi7itCkBMT5UwoiE88
 YCVub5L/i+FEMGwFuYK8m4L3pxHB4cdwfMvErqapQJV95rw8j6UxeoxbpbhQBNy3ZDy+fsUxDqA
 E2JcBxQbbsnlIF0mJJXdZaxOntZWgi2I+UfqMTsy62bm/h4XhLc8K5PnVJg4AYd0M4bUYuKYgHP
 pgYLlh8FSfFrtF0QEbYNxrtOB0xrAff5d//jtRKuR8p/AVG1zqm/vsFMk53TIvBk+Us1u8glaKm
 zDpW6ISlokEbFHCKKSohfXVBDaBt/J+3+Ufb/qkFia3HZ63fY2xblZB4ZnocUuETL+82RTcgkEJ
 E9kmkOf8RoXi1KJ/3w+6v+0K6sxJZ1Z+0ujdKJQfMUM/kIJJ0NtTbCE7iVP+W0Q9B9ry+Jg9FcH
 i+QimAcZGB+F4VWmC0MSgQmOTfBac4an4gYeHboQjP+ENcftW4yokRmQUxwiBHrVDlG8lc8PqM1
 xxMGB19VjjZq+yGLQCk50XGT6MkdqEeGs3MfbVlFbBJBQikgjw9TrsOUTsoOW7gGl9XfBytw4Yl
 hQpLxDf8klmdH7g==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 61DE5527724
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21554-lists,linux-nfs=lfdr.de];
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

The NLM TEST procedure requires host and file lookups to check
lock state, operations that will be common across multiple NLM
procedures being migrated to xdrgen. Introducing the
nlm3svc_lookup_host() and nlm3svc_lookup_file() helpers now keeps
these common patterns in one place for subsequent conversions in
this series.

This patch converts the TEST procedure to use xdrgen functions
nlm_svc_decode_nlm_testargs and nlm_svc_encode_nlm_testres
generated from the NLM version 3 protocol specification. The
procedure handler is rewritten to use xdrgen types through wrapper
structures that bridge between generated code and the legacy
lockd_lock representation still used by the core lockd logic.

Setting pc_argzero to zero is safe because the generated decoder
fills the argp->xdrgen subfields before the procedure runs, so the
zeroing memset performed by the dispatch layer is not needed. The
lock member of the wrapper is populated explicitly in
nlm3svc_lookup_file() rather than relying on zero-initialization.

The conflicting holder's offset and length are saturated to
NLM_OFFSET_MAX when constructing the reply. A conflicting lock
established by an NLMv4 client or by a local process can sit
beyond the NLMv3 signed 32-bit range, and copying fl_start and
fl_end straight into the unsigned 32-bit XDR fields would wrap
and report a bogus range. The previous hand-written encoder in
svcxdr_encode_holder() used loff_t_to_s32() for the same reason,
but this patch series intends to separate the concerns of data
conversion (XDR) from dealing with local byte range constraints,
so clamping is hoisted into the proc function.

The previous hand-written decoder in svcxdr_decode_cookie()
rewrote a zero-length NLM cookie into a four-byte zero cookie,
with a comment attributing the substitution to HP-UX clients.
The xdrgen-generated netobj decoder performs no such rewrite, so
a zero-length request cookie now round-trips unchanged into the
reply. HP-UX has reached end of support, and NLM_TEST reply
matching relies on the RPC XID rather than the NLM cookie, so
the workaround is dropped intentionally here.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/lockd.h   |  23 +++++++
 fs/lockd/svcproc.c | 195 +++++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 206 insertions(+), 12 deletions(-)

diff --git a/fs/lockd/lockd.h b/fs/lockd/lockd.h
index 5c79681b7e95..0be0dac59ea2 100644
--- a/fs/lockd/lockd.h
+++ b/fs/lockd/lockd.h
@@ -422,6 +422,29 @@ static inline int nlm_compare_locks(const struct file_lock *fl1,
 	     &&(fl1->c.flc_type  == fl2->c.flc_type || fl2->c.flc_type == F_UNLCK);
 }
 
+/**
+ * lockd_set_file_lock_range3 - set the byte range of a file_lock
+ * @fl: file_lock whose length fields are to be initialized
+ * @off: starting offset of the lock, in bytes
+ * @len: length of the byte range, in bytes, or zero
+ *
+ * NLMv3 uses a (start, length) representation for lock byte ranges,
+ * while the kernel's file_lock uses (start, end). Treat a length of
+ * zero or arithmetic overflow (end wrapping negative when the sum
+ * exceeds S32_MAX) as "lock to end of file."
+ */
+static inline void
+lockd_set_file_lock_range3(struct file_lock *fl, u32 off, u32 len)
+{
+	s32 end = off + len - 1;
+
+	fl->fl_start = off;
+	if (len == 0 || end < 0)
+		fl->fl_end = OFFSET_MAX;
+	else
+		fl->fl_end = end;
+}
+
 /**
  * lockd_set_file_lock_range4 - set the byte range of a file_lock
  * @fl: file_lock whose length fields are to be initialized
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index ad37f3611eea..7794e6f88a71 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -26,6 +26,106 @@
 
 #define NLMDBG_FACILITY		NLMDBG_CLIENT
 
+/*
+ * Size of an NFSv2 file handle, in bytes, which is 32.
+ * Defined locally to avoid including uapi/linux/nfs2.h.
+ */
+#define NLM3_FHSIZE		32
+
+/*
+ * Wrapper structures combine xdrgen types with legacy lockd_lock.
+ * The xdrgen field must be first so the structure can be cast
+ * to its XDR type for the RPC dispatch layer.
+ */
+struct nlm_testargs_wrapper {
+	struct nlm_testargs		xdrgen;
+	struct lockd_lock		lock;
+};
+
+static_assert(offsetof(struct nlm_testargs_wrapper, xdrgen) == 0);
+
+struct nlm_testres_wrapper {
+	struct nlm_testres		xdrgen;
+	struct lockd_lock		lock;
+};
+
+static_assert(offsetof(struct nlm_testres_wrapper, xdrgen) == 0);
+
+static struct nlm_host *
+nlm3svc_lookup_host(struct svc_rqst *rqstp, string caller, bool monitored)
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
+nlm3svc_lookup_file(struct svc_rqst *rqstp, struct nlm_host *host,
+		    struct lockd_lock *lock, struct nlm_file **filp,
+		    struct nlm_lock *xdr_lock, unsigned char type)
+{
+	bool is_test = (rqstp->rq_proc == NLMPROC_TEST ||
+			rqstp->rq_proc == NLMPROC_TEST_MSG);
+	struct file_lock *fl = &lock->fl;
+	struct nlm_file *file = NULL;
+	__be32 error;
+	int mode;
+
+	if (xdr_lock->fh.len != NLM3_FHSIZE)
+		return nlm_lck_denied_nolocks;
+	lock->fh.size = xdr_lock->fh.len;
+	memcpy(lock->fh.data, xdr_lock->fh.data, xdr_lock->fh.len);
+
+	lock->oh.len = xdr_lock->oh.len;
+	lock->oh.data = xdr_lock->oh.data;
+
+	lock->svid = xdr_lock->uppid;
+	lock->lock_start = xdr_lock->l_offset;
+	lock->lock_len = xdr_lock->l_len;
+
+	locks_init_lock(fl);
+	fl->c.flc_type = type;
+	lockd_set_file_lock_range3(fl, lock->lock_start, lock->lock_len);
+
+	mode = lock_to_openmode(fl);
+	if (is_test)
+		mode = O_RDWR;
+
+	error = nlm_lookup_file(rqstp, &file, lock, mode);
+	switch (error) {
+	case nlm_granted:
+		break;
+	case nlm__int__stale_fh:
+	case nlm__int__failed:
+		return nlm_lck_denied_nolocks;
+	default:
+		return error;
+	}
+	*filp = file;
+
+	fl->c.flc_flags = FL_POSIX;
+	if (is_test)
+		fl->c.flc_file = nlmsvc_file_file(file);
+	else
+		fl->c.flc_file = file->f_file[mode];
+	fl->c.flc_pid = current->tgid;
+	fl->fl_lmops = &nlmsvc_lock_operations;
+	nlmsvc_locks_init_private(fl, host, (pid_t)lock->svid);
+	if (!fl->c.flc_owner)
+		return nlm_lck_denied_nolocks;
+
+	return nlm_granted;
+}
+
 #ifdef CONFIG_LOCKD_V4
 static inline __be32 cast_status(__be32 status)
 {
@@ -178,10 +278,79 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct lockd_res *resp)
 	return rc;
 }
 
-static __be32
-nlmsvc_proc_test(struct svc_rqst *rqstp)
+/**
+ * nlmsvc_proc_test - TEST: Check for conflicting lock
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ *   %rpc_drop_reply:		Do not send an RPC reply.
+ *
+ * RPC synopsis:
+ *   nlm_testres NLM_TEST(nlm_testargs) = 1;
+ *
+ * Permissible procedure status codes:
+ *   %LCK_GRANTED:		The server would be able to grant the
+ *				requested lock.
+ *   %LCK_DENIED:		The requested lock conflicted with existing
+ *				lock reservations for the file.
+ *   %LCK_DENIED_NOLOCKS:	The server could not allocate the resources
+ *				needed to process the request.
+ *   %LCK_DENIED_GRACE_PERIOD:	The server has recently restarted and is
+ *				re-establishing existing locks, and is not
+ *				yet ready to accept normal service requests.
+ */
+static __be32 nlmsvc_proc_test(struct svc_rqst *rqstp)
 {
-	return __nlmsvc_proc_test(rqstp, rqstp->rq_resp);
+	struct nlm_testargs_wrapper *argp = rqstp->rq_argp;
+	unsigned char type = argp->xdrgen.exclusive ? F_WRLCK : F_RDLCK;
+	struct nlm_testres_wrapper *resp = rqstp->rq_resp;
+	struct nlm_file *file = NULL;
+	struct nlm_host	*host;
+
+	resp->xdrgen.cookie = argp->xdrgen.cookie;
+
+	resp->xdrgen.test_stat.stat = nlm_lck_denied_nolocks;
+	host = nlm3svc_lookup_host(rqstp, argp->xdrgen.alock.caller_name, false);
+	if (!host)
+		goto out;
+
+	resp->xdrgen.test_stat.stat =
+		nlm3svc_lookup_file(rqstp, host, &argp->lock, &file,
+				    &argp->xdrgen.alock, type);
+	if (resp->xdrgen.test_stat.stat)
+		goto out;
+
+	resp->xdrgen.test_stat.stat =
+		cast_status(nlmsvc_testlock(rqstp, file, host, &argp->lock,
+					    &resp->lock));
+	nlmsvc_release_lockowner(&argp->lock);
+
+	if (resp->xdrgen.test_stat.stat == nlm_lck_denied) {
+		struct lockd_lock *conf = &resp->lock;
+		struct nlm_holder *holder = &resp->xdrgen.test_stat.u.holder;
+
+		holder->exclusive = (conf->fl.c.flc_type != F_RDLCK);
+		holder->uppid = conf->svid;
+		holder->oh.len = conf->oh.len;
+		holder->oh.data = conf->oh.data;
+		holder->l_offset = min_t(loff_t, conf->fl.fl_start,
+					 NLM_OFFSET_MAX);
+		if (conf->fl.fl_end == OFFSET_MAX)
+			holder->l_len = 0;
+		else
+			holder->l_len = min_t(loff_t,
+					      conf->fl.fl_end -
+					      conf->fl.fl_start + 1,
+					      NLM_OFFSET_MAX);
+	}
+
+out:
+	if (file)
+		nlm_release_file(file);
+	nlmsvc_release_host(host);
+	return resp->xdrgen.test_stat.stat == nlm__int__drop_reply ?
+		rpc_drop_reply : rpc_success;
 }
 
 static __be32
@@ -592,15 +761,15 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_xdrressize	= XDR_void,
 		.pc_name	= "NULL",
 	},
-	[NLMPROC_TEST] = {
-		.pc_func = nlmsvc_proc_test,
-		.pc_decode = nlmsvc_decode_testargs,
-		.pc_encode = nlmsvc_encode_testres,
-		.pc_argsize = sizeof(struct lockd_args),
-		.pc_argzero = sizeof(struct lockd_args),
-		.pc_ressize = sizeof(struct lockd_res),
-		.pc_xdrressize = Ck+St+2+No+Rg,
-		.pc_name = "TEST",
+	[NLM_TEST] = {
+		.pc_func	= nlmsvc_proc_test,
+		.pc_decode	= nlm_svc_decode_nlm_testargs,
+		.pc_encode	= nlm_svc_encode_nlm_testres,
+		.pc_argsize	= sizeof(struct nlm_testargs_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= sizeof(struct nlm_testres_wrapper),
+		.pc_xdrressize	= NLM3_nlm_testres_sz,
+		.pc_name	= "TEST",
 	},
 	[NLMPROC_LOCK] = {
 		.pc_func = nlmsvc_proc_lock,
@@ -828,6 +997,8 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
  * Storage requirements for XDR arguments and results
  */
 union nlmsvc_xdrstore {
+	struct nlm_testargs_wrapper	testargs;
+	struct nlm_testres_wrapper	testres;
 	struct lockd_args		args;
 	struct lockd_res		res;
 	struct lockd_reboot		reboot;

-- 
2.54.0


