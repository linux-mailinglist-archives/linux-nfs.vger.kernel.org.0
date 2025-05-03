Return-Path: <linux-nfs+bounces-11411-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B38AA8271
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 22:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C3F55A4583
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 20:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC08927F74D;
	Sat,  3 May 2025 19:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uynP6bD/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E2F27F745;
	Sat,  3 May 2025 19:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746302385; cv=none; b=KLOxK0VxldF1Xy1xTtcq79AKznHPu7nts/ogR5lhB//J9NE2VZdQ3HmOwXJV26Czff4K28FsBUVwoCbQ2mbQDmjsLzzuxbw/l4zwmxtduZ5iTSPYMGWa10hTYbF+lH1nPEW8MzpsDp/Gr9+5vWCKOGQLFFWoQrcnP3j6ZKno/q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746302385; c=relaxed/simple;
	bh=mA6jQwvjY/Md2m6fWa8ZHdJ64DCSmyrszl57vuZvK2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yniwpv5X6X7PRvkRUH4K2HIV8Bkg++nbcpLGApNu6voH5K6uFDl9U05teGxINyzBG2i5Y8aJ2ry05tj9moZ7cSiRfsfn5KyEFVNMv0h4tYJPxO4cjm9hYxW+ZYH9BQOh1q8RkSmMsKAQDlYBwRZGvTBFXz95KRUMX6MfA5WwjKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uynP6bD/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A64C4CEF2;
	Sat,  3 May 2025 19:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746302384;
	bh=mA6jQwvjY/Md2m6fWa8ZHdJ64DCSmyrszl57vuZvK2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uynP6bD/0n74uEJT2kZbSzSO2E1PBXvjMn7JuCZ4IDaitR3dqaRaKOARGJEXPl5Dk
	 QeSr3o9clHjv/o/I7C47D5nqVVcN5PT62bQT9Wv4uL3sCj+faUkmxLL5E3ReWEUaw9
	 gtI2zAXa3MIhkAarDEn4LHxyRkhmywjnj/l1/WyuntgH0cFJu2nOp5dfd5QCzMUI0M
	 F0uYjfMAGTGJ+DOaeKzGG3kRY+Gh0z+CTLMv/lPUx4rupt6NfHxkCP5oo4plVW1lod
	 Fc63QmbYeamLHOzcV9ja//86+VjJCS8Vcb8iz6V+VvUk0YE7k+rqyyA7uz3JcTiddq
	 5BMFUrh5Qt5lA==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: sargun@sargun.me,
	<linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 03/18] nfsd: add a tracepoint for nfsd_setattr
Date: Sat,  3 May 2025 15:59:21 -0400
Message-ID: <20250503195936.5083-4-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250503195936.5083-1-cel@kernel.org>
References: <20250503195936.5083-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

Turn Sargun's internal kprobe based implementation of this into a normal
static tracepoint. Also, remove the dprintk's that got added recently
with the fix for zero-length ACLs.

Cc: Sargun Dillon <sargun@sargun.me>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/trace.h         | 39 +++++++++++++++++++++++++++++++++++++++
 fs/nfsd/vfs.c           |  2 ++
 include/trace/misc/fs.h | 21 +++++++++++++++++++++
 3 files changed, 62 insertions(+)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index fc373c4d5fdd..b435276a1aaa 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -11,6 +11,7 @@
 #include <linux/tracepoint.h>
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/xprt.h>
+#include <trace/misc/fs.h>
 #include <trace/misc/nfs.h>
 #include <trace/misc/sunrpc.h>
 
@@ -2355,6 +2356,44 @@ DEFINE_EVENT(nfsd_copy_async_done_class,		\
 DEFINE_COPY_ASYNC_DONE_EVENT(done);
 DEFINE_COPY_ASYNC_DONE_EVENT(cancel);
 
+TRACE_EVENT(nfsd_vfs_setattr,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const struct svc_fh *fhp,
+		const struct iattr *iap,
+		const struct timespec64 *guardtime
+	),
+	TP_ARGS(rqstp, fhp, iap, guardtime),
+	TP_STRUCT__entry(
+		NFSD_TRACE_PROC_CALL_FIELDS(rqstp)
+		__field(u32, fh_hash)
+		__field(s64, gtime_tv_sec)
+		__field(u32, gtime_tv_nsec)
+		__field(unsigned int, ia_valid)
+		__field(loff_t, ia_size)
+		__field(uid_t, ia_uid)
+		__field(gid_t, ia_gid)
+		__field(umode_t, ia_mode)
+	),
+	TP_fast_assign(
+		NFSD_TRACE_PROC_CALL_ASSIGNMENTS(rqstp);
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
index 68f7d0094b06..9e0a858d2129 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -501,6 +501,8 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	bool		size_change = (iap->ia_valid & ATTR_SIZE);
 	int		retries;
 
+	trace_nfsd_vfs_setattr(rqstp, fhp, iap, guardtime);
+
 	if (iap->ia_valid & ATTR_SIZE) {
 		accmode |= NFSD_MAY_WRITE|NFSD_MAY_OWNER_OVERRIDE;
 		ftype = S_IFREG;
diff --git a/include/trace/misc/fs.h b/include/trace/misc/fs.h
index 738b97f22f36..0406ebe2a80a 100644
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


