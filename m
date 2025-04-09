Return-Path: <linux-nfs+bounces-11055-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 483C7A82807
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 16:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BBC216E939
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 14:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134F3267721;
	Wed,  9 Apr 2025 14:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poF6vQFj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE565267706;
	Wed,  9 Apr 2025 14:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209188; cv=none; b=ntRD0sJhQtdWih20fO4KF4tdUekxzzE29WQ/ut7KSFj2rgzNw+cXPvXLpp3HIppW/gDWgcUFcnFCcx+3gFVdelkgovtq9Cp8JrNZqaxfcd8qC0Z/w3vv6PePY9/oIVZXPxOWnEO0bCBB0aAgqDFXIP3baRvPXnl9v8Tcp14hR+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209188; c=relaxed/simple;
	bh=9GBSxEPmoVssLVVXgixK7d8cLIsgqzh/i3Oj+v1CSYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=chjAu2eh7ts82+CQZnqb58cW7jmMtoZCu3UepVKMW83QykQxdc49NH6tAicPN5OaW1QPvjVa0D07+TANRHJgEx9sJ4juDeHkSbtxdEd29qQ1XKeZUagT3Ks1N/yxSrPsj8WMEOCBPXz+h4Ox1sir1Ue3KkEoemEIMVYGM+86TpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poF6vQFj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D95AC4CEE2;
	Wed,  9 Apr 2025 14:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744209185;
	bh=9GBSxEPmoVssLVVXgixK7d8cLIsgqzh/i3Oj+v1CSYw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=poF6vQFjPAbgP7MZft040YytMazQEtBwEHsj3dnnpySBSykNB5U8y5htTvlGvwbz7
	 N7zZ3VmJD0MpnT2FZcTQ4+hs+LK+ZOojT98XsMe45xUjQmJfP1RjroE54hCmlrX5Dn
	 NqIsI5Ve4rwc67XphZhFnidzLEaiOAju7wAATGrq8cxnConyMCMpY9o0MXzoRkX1zL
	 DvP1AaOzH0DWfNClmSz/6iTd4toRLBwsRi2Tlyn2gXQ2T4AMr0qlWSj60kwJNUGcLw
	 3A8LqdsRccn4jf2ifII7RIWL7Z7Vvqu8IbAxy3wSozNzGTB59LTIFL3Sfz/1vKETPh
	 uMPOWdBY5ARWw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 09 Apr 2025 10:32:26 -0400
Subject: [PATCH v2 04/12] nfsd: add a tracepoint for nfsd_setattr
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-nfsd-tracepoints-v2-4-cf4e084fdd9c@kernel.org>
References: <20250409-nfsd-tracepoints-v2-0-cf4e084fdd9c@kernel.org>
In-Reply-To: <20250409-nfsd-tracepoints-v2-0-cf4e084fdd9c@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: Sargun Dillon <sargun@sargun.me>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4577; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=9GBSxEPmoVssLVVXgixK7d8cLIsgqzh/i3Oj+v1CSYw=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn9oUa4rNlyoqwJ4nfz4w/qtI/yqAhiQf52rlo0
 zrseXJX6o+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ/aFGgAKCRAADmhBGVaC
 FaDzEAC3qh2gTL7P94Je3dil8MWepI7Q+/buZQVGrIrE9uJQcnjbC2N8lOlqOPlJmxEuwv4smX8
 4+FxPIIGnN9xs/R7tGFKSj7/FL35nnr+fNsbcqA57TPzZQzjQhiB3SeSE5V5Dog9kpEZAJlJKty
 VMURWmChc0tqvDlRtK5p5LwtFshPc6FKZUjLEArvWZVXD+u6vUik/GJ97VEnyLcWzhS6OH3G5Sv
 rkPrHM/45HpoyyjxKApIUz0/CxSwSQw5SXJmQ+WLzgXrHwaMmnwNjXdrKm6kBxVj77GMEtJPvZe
 KafMD+5fN/tSc4Y4jXdPty1MbFk1sHDz1h7cVMBJH+GDmQvs91qd5jQim7jt4vBWgnQRrbPOO/z
 TRaII+3J7RxHFgCezXX4yIuDLl02vEKlYitYbPfnqwlFoAGmCEXEfP+aS66Mww1qZEJDvTALzKf
 sbYtml9CweQfIfrwJEyQRQ64eEiFl2P2wLoLAx3tqS0Flxwq7wR1yZKeaNCegmR74lHVJK8Ub8k
 2iJRz+pLLLH61U8/Hxsf2PFUTRlUqAo10VyoGLYepNKxcjGfbte8vZIHmrQaITsTi1J5bVZ58A/
 CTHFrCdzxxFQQY9pWV7Ixpc15CCbs+6HqEW4vSCDbuemWijkkuMLOKWqtFYMrAzuwGN+kS97+L0
 9Ecjseu4qdt/B8A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Turn Sargun's internal kprobe based implementation of this into a normal
static tracepoint. Also, remove the dprintk's that got added recently
with the fix for zero-length ACLs.

Cc: Sargun Dillon <sargun@sargun.me>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/trace.h         | 35 +++++++++++++++++++++++++++++++++++
 fs/nfsd/vfs.c           |  5 ++---
 include/trace/misc/fs.h | 21 +++++++++++++++++++++
 3 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 0d49fc064f7273f32c93732a993fd77bc0783f5d..c496fed58e2eed15458f35a158fbfef39a972c55 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -11,6 +11,7 @@
 #include <linux/tracepoint.h>
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/xprt.h>
+#include <trace/misc/fs.h>
 #include <trace/misc/nfs.h>
 #include <trace/misc/sunrpc.h>
 
@@ -2337,6 +2338,40 @@ DEFINE_EVENT(nfsd_copy_async_done_class,		\
 DEFINE_COPY_ASYNC_DONE_EVENT(done);
 DEFINE_COPY_ASYNC_DONE_EVENT(cancel);
 
+TRACE_EVENT(nfsd_setattr,
+	TP_PROTO(const struct svc_rqst *rqstp, const struct svc_fh *fhp,
+		 const struct iattr *iap, const struct timespec64 *guardtime),
+	TP_ARGS(rqstp, fhp, iap, guardtime),
+	TP_STRUCT__entry(
+		SVC_RQST_ENDPOINT_FIELDS(rqstp)
+		__field(u32, fh_hash)
+		__field(s64, gtime_tv_sec)
+		__field(u32, gtime_tv_nsec)
+		__field(unsigned int, ia_valid)
+		__field(loff_t, ia_size)
+		__field(uid_t, ia_uid)
+		__field(gid_t, ia_gid)
+		__field(umode_t, ia_mode)
+	),
+	TP_fast_assign(__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		SVC_RQST_ENDPOINT_ASSIGNMENTS(rqstp);
+		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
+		__entry->gtime_tv_sec = guardtime ? guardtime->tv_sec : 0;
+		__entry->gtime_tv_nsec = guardtime ? guardtime->tv_nsec : 0;
+		__entry->ia_valid = iap->ia_valid;
+		__entry->ia_size = iap->ia_size;
+		__entry->ia_uid = __kuid_val(iap->ia_uid);
+		__entry->ia_gid = __kgid_val(iap->ia_gid);
+		__entry->ia_mode = iap->ia_mode;
+	),
+	TP_printk(
+		"xid=0x%08x fh_hash=0x%08x ia_valid=%s ia_size=%llu ia_mode=0%o ia_uid=%u ia_gid=%u guard_time=%lld.%u",
+		__entry->xid, __entry->fh_hash, show_ia_valid_flags(__entry->ia_valid),
+		__entry->ia_size, __entry->ia_mode, __entry->ia_uid, __entry->ia_gid,
+		__entry->gtime_tv_sec, __entry->gtime_tv_nsec
+	)
+)
+
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index d1156a18a79579bf427fe5809dc93d06e241201e..77ae22abc1a21ec587cf089b2a5f750464b5e985 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -501,7 +501,8 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	bool		size_change = (iap->ia_valid & ATTR_SIZE);
 	int		retries;
 
-dprintk("nfsd_setattr pacl=%p valid=0x%x\n", attr->na_pacl, iap->ia_valid);
+	trace_nfsd_setattr(rqstp, fhp, iap, guardtime);
+
 	if (iap->ia_valid & ATTR_SIZE) {
 		accmode |= NFSD_MAY_WRITE|NFSD_MAY_OWNER_OVERRIDE;
 		ftype = S_IFREG;
@@ -597,7 +598,6 @@ dprintk("nfsd_setattr pacl=%p valid=0x%x\n", attr->na_pacl, iap->ia_valid);
 						NULL);
 	}
 	if (IS_ENABLED(CONFIG_FS_POSIX_ACL) && attr->na_pacl) {
-dprintk("at set_posix_acl\n");
 		/*
 		 * For any file system that is not ACL_SCOPE_FILE_OBJECT,
 		 * a_count == 0 MUST reply nfserr_inval.
@@ -612,7 +612,6 @@ dprintk("at set_posix_acl\n");
 							attr->na_pacl);
 		else
 			attr->na_paclerr = -EINVAL;
-dprintk("set_posix_acl=%d\n", attr->na_paclerr);
 	}
 out_fill_attrs:
 	/*
diff --git a/include/trace/misc/fs.h b/include/trace/misc/fs.h
index 738b97f22f3651f2370830037a8f4bfdf9a42ad4..0406ebe2a80a499dfcadb7e63db4d9e4a84d4d64 100644
--- a/include/trace/misc/fs.h
+++ b/include/trace/misc/fs.h
@@ -120,3 +120,24 @@
 		{ LOOKUP_BENEATH,	"BENEATH" }, \
 		{ LOOKUP_IN_ROOT,	"IN_ROOT" }, \
 		{ LOOKUP_CACHED,	"CACHED" })
+
+#define show_ia_valid_flags(flags)			\
+	__print_flags(flags, "|",			\
+		{ ATTR_MODE,		"MODE" },	\
+		{ ATTR_UID,		"UID" },	\
+		{ ATTR_GID,		"GID" },	\
+		{ ATTR_SIZE,		"SIZE" },	\
+		{ ATTR_ATIME,		"ATIME" },	\
+		{ ATTR_MTIME,		"MTIME" },	\
+		{ ATTR_CTIME,		"CTIME" },	\
+		{ ATTR_ATIME_SET,	"ATIME_SET" },	\
+		{ ATTR_MTIME_SET,	"MTIME_SET" },	\
+		{ ATTR_FORCE,		"FORCE" },	\
+		{ ATTR_KILL_SUID,	"KILL_SUID" },	\
+		{ ATTR_KILL_SGID,	"KILL_SGID" },	\
+		{ ATTR_FILE,		"FILE" },	\
+		{ ATTR_KILL_PRIV,	"KILL_PRIV" },	\
+		{ ATTR_OPEN,		"OPEN" },	\
+		{ ATTR_TIMES_SET,	"TIMES_SET" },	\
+		{ ATTR_TOUCH,		"TOUCH"},	\
+		{ ATTR_DELEG,		"DELEG"})

-- 
2.49.0


