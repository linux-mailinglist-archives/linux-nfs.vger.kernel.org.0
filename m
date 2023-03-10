Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0396B4BDE
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Mar 2023 17:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjCJQDc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Mar 2023 11:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjCJQDD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Mar 2023 11:03:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538C239CE0
        for <linux-nfs@vger.kernel.org>; Fri, 10 Mar 2023 07:58:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A8E0B822B7
        for <linux-nfs@vger.kernel.org>; Fri, 10 Mar 2023 15:58:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32FE6C433D2;
        Fri, 10 Mar 2023 15:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678463909;
        bh=zWxkSD6vO0GZvWZvHg8AAL4LOU0opoK2QxzsOthNbaY=;
        h=Subject:From:To:Cc:Date:From;
        b=W2OENSWNHl6BYuueslDgJzugLvviQI/IkoRIOegerLnyALDfPE2b7V6OlxXPJ99Ug
         zDaixuW/9GrBC4Dj4EV14IliOk25G7PVzBdIVklJermQXAuujy3Ya1BEchdOzYExqL
         s5KZhrKFM2gc6nohkrp9/svMPoAWSe7syzhj5Q5IXq8nUotXBqhZvJGVmUK8W3NQ5Y
         6MZHdzlY43wCrktougnNDREt4XF0ZiUb2eG23o3NW4dZI3iaa5vk/oTAsOA/7E/bUi
         XWh2XyOHOQQyhB00ZUwK2cm9qPnyeLWtMeFo0W802q5qt3x9taIgyywALsiNqmwPPT
         tMAZ0WzFc8Ivw==
Subject: [PATCH] lockd: add some client-side tracepoints
From:   Chuck Lever <cel@kernel.org>
To:     jlayton@redhat.com
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 10 Mar 2023 10:58:28 -0500
Message-ID: <167846387033.12529.1222975070992586314.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Jeff Layton <jlayton@kernel.org>

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/Makefile   |    6 ++-
 fs/lockd/clntlock.c |    4 ++
 fs/lockd/clntproc.c |   14 +++++++
 fs/lockd/trace.c    |    3 +
 fs/lockd/trace.h    |  106 +++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 131 insertions(+), 2 deletions(-)
 create mode 100644 fs/lockd/trace.c
 create mode 100644 fs/lockd/trace.h

Jeff, how about something like this?

diff --git a/fs/lockd/Makefile b/fs/lockd/Makefile
index 6d5e83ed4476..ac9f9d84510e 100644
--- a/fs/lockd/Makefile
+++ b/fs/lockd/Makefile
@@ -3,10 +3,12 @@
 # Makefile for the linux lock manager stuff
 #
 
+ccflags-y += -I$(src)			# needed for trace events
+
 obj-$(CONFIG_LOCKD) += lockd.o
 
-lockd-objs-y := clntlock.o clntproc.o clntxdr.o host.o svc.o svclock.o \
-	        svcshare.o svcproc.o svcsubs.o mon.o xdr.o
+lockd-objs-y += clntlock.o clntproc.o clntxdr.o host.o svc.o svclock.o \
+	        svcshare.o svcproc.o svcsubs.o mon.o trace.o xdr.o
 lockd-objs-$(CONFIG_LOCKD_V4) += clnt4xdr.o xdr4.o svc4proc.o
 lockd-objs-$(CONFIG_PROC_FS) += procfs.o
 lockd-objs		      := $(lockd-objs-y)
diff --git a/fs/lockd/clntlock.c b/fs/lockd/clntlock.c
index c374ee072db3..e3972aa3045a 100644
--- a/fs/lockd/clntlock.c
+++ b/fs/lockd/clntlock.c
@@ -14,9 +14,12 @@
 #include <linux/nfs_fs.h>
 #include <linux/sunrpc/addr.h>
 #include <linux/sunrpc/svc.h>
+#include <linux/sunrpc/svc_xprt.h>
 #include <linux/lockd/lockd.h>
 #include <linux/kthread.h>
 
+#include "trace.h"
+
 #define NLMDBG_FACILITY		NLMDBG_CLIENT
 
 /*
@@ -186,6 +189,7 @@ __be32 nlmclnt_grant(const struct sockaddr *addr, const struct nlm_lock *lock)
 		res = nlm_granted;
 	}
 	spin_unlock(&nlm_blocked_lock);
+	trace_nlmclnt_grant(lock, addr, svc_addr_len(addr), res);
 	return res;
 }
 
diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
index a14c9110719c..fba6c7fa7474 100644
--- a/fs/lockd/clntproc.c
+++ b/fs/lockd/clntproc.c
@@ -20,6 +20,8 @@
 #include <linux/sunrpc/svc.h>
 #include <linux/lockd/lockd.h>
 
+#include "trace.h"
+
 #define NLMDBG_FACILITY		NLMDBG_CLIENT
 #define NLMCLNT_GRACE_WAIT	(5*HZ)
 #define NLMCLNT_POLL_TIMEOUT	(30*HZ)
@@ -451,6 +453,9 @@ nlmclnt_test(struct nlm_rqst *req, struct file_lock *fl)
 			status = nlm_stat_to_errno(req->a_res.status);
 	}
 out:
+	trace_nlmclnt_test(&req->a_args.lock,
+			   (const struct sockaddr *)&req->a_host->h_addr,
+			   req->a_host->h_addrlen, req->a_res.status);
 	nlmclnt_release_call(req);
 	return status;
 }
@@ -605,10 +610,16 @@ nlmclnt_lock(struct nlm_rqst *req, struct file_lock *fl)
 	else
 		status = nlm_stat_to_errno(resp->status);
 out:
+	trace_nlmclnt_lock(&req->a_args.lock,
+			   (const struct sockaddr *)&req->a_host->h_addr,
+			   req->a_host->h_addrlen, req->a_res.status);
 	nlmclnt_release_call(req);
 	return status;
 out_unlock:
 	/* Fatal error: ensure that we remove the lock altogether */
+	trace_nlmclnt_lock(&req->a_args.lock,
+			   (const struct sockaddr *)&req->a_host->h_addr,
+			   req->a_host->h_addrlen, req->a_res.status);
 	dprintk("lockd: lock attempt ended in fatal error.\n"
 		"       Attempting to unlock.\n");
 	fl_type = fl->fl_type;
@@ -704,6 +715,9 @@ nlmclnt_unlock(struct nlm_rqst *req, struct file_lock *fl)
 	/* What to do now? I'm out of my depth... */
 	status = -ENOLCK;
 out:
+	trace_nlmclnt_unlock(&req->a_args.lock,
+			     (const struct sockaddr *)&req->a_host->h_addr,
+			     req->a_host->h_addrlen, req->a_res.status);
 	nlmclnt_release_call(req);
 	return status;
 }
diff --git a/fs/lockd/trace.c b/fs/lockd/trace.c
new file mode 100644
index 000000000000..d9a6ff6e673c
--- /dev/null
+++ b/fs/lockd/trace.c
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0
+#define CREATE_TRACE_POINTS
+#include "trace.h"
diff --git a/fs/lockd/trace.h b/fs/lockd/trace.h
new file mode 100644
index 000000000000..7461b13b6e74
--- /dev/null
+++ b/fs/lockd/trace.h
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM lockd
+
+#if !defined(_TRACE_LOCKD_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_LOCKD_H
+
+#include <linux/tracepoint.h>
+#include <linux/crc32.h>
+#include <linux/nfs.h>
+#include <linux/lockd/lockd.h>
+
+#ifdef CONFIG_LOCKD_V4
+#define NLM_STATUS_LIST					\
+	nlm_status_code(LCK_GRANTED)			\
+	nlm_status_code(LCK_DENIED)			\
+	nlm_status_code(LCK_DENIED_NOLOCKS)		\
+	nlm_status_code(LCK_BLOCKED)			\
+	nlm_status_code(LCK_DENIED_GRACE_PERIOD)	\
+	nlm_status_code(DEADLCK)			\
+	nlm_status_code(ROFS)				\
+	nlm_status_code(STALE_FH)			\
+	nlm_status_code(FBIG)				\
+	nlm_status_code_end(FAILED)
+#else
+#define NLM_STATUS_LIST					\
+	nlm_status_code(LCK_GRANTED)			\
+	nlm_status_code(LCK_DENIED)			\
+	nlm_status_code(LCK_DENIED_NOLOCKS)		\
+	nlm_status_code(LCK_BLOCKED)			\
+	nlm_status_code_end(LCK_DENIED_GRACE_PERIOD)
+#endif
+
+#undef nlm_status_code
+#undef nlm_status_code_end
+#define nlm_status_code(x)	TRACE_DEFINE_ENUM(NLM_##x);
+#define nlm_status_code_end(x)	TRACE_DEFINE_ENUM(NLM_##x);
+
+NLM_STATUS_LIST
+
+#undef nlm_status_code
+#undef nlm_status_code_end
+#define nlm_status_code(x)	{ NLM_##x, #x },
+#define nlm_status_code_end(x)	{ NLM_##x, #x }
+
+#define show_nlm_status(x)	__print_symbolic(x, NLM_STATUS_LIST)
+
+DECLARE_EVENT_CLASS(nlmclnt_lock_event,
+		TP_PROTO(
+			const struct nlm_lock *lock,
+			const struct sockaddr *addr,
+			unsigned int addrlen,
+			__be32 status
+		),
+
+		TP_ARGS(lock, addr, addrlen, status),
+
+		TP_STRUCT__entry(
+			__field(u32, oh)
+			__field(u32, svid)
+			__field(u32, fh)
+			__field(unsigned long, status)
+			__field(u64, start)
+			__field(u64, len)
+			__sockaddr(addr, addrlen)
+		),
+
+		TP_fast_assign(
+			__entry->oh = ~crc32_le(0xffffffff, lock->oh.data, lock->oh.len);
+			__entry->svid = lock->svid;
+			__entry->fh = nfs_fhandle_hash(&lock->fh);
+			__entry->start = lock->lock_start;
+			__entry->len = lock->lock_len;
+			__entry->status = be32_to_cpu(status);
+			__assign_sockaddr(addr, addr, addrlen);
+		),
+
+		TP_printk(
+			"addr=%pISpc oh=0x%08x svid=0x%08x fh=0x%08x start=%llu len=%llu status=%s",
+			__get_sockaddr(addr), __entry->oh, __entry->svid,
+			__entry->fh, __entry->start, __entry->len,
+			show_nlm_status(__entry->status)
+		)
+);
+
+#define DEFINE_NLMCLNT_EVENT(name)				\
+	DEFINE_EVENT(nlmclnt_lock_event, name,			\
+			TP_PROTO(				\
+				const struct nlm_lock *lock,	\
+				const struct sockaddr *addr,	\
+				unsigned int addrlen,		\
+				__be32	status			\
+			),					\
+			TP_ARGS(lock, addr, addrlen, status))
+
+DEFINE_NLMCLNT_EVENT(nlmclnt_test);
+DEFINE_NLMCLNT_EVENT(nlmclnt_lock);
+DEFINE_NLMCLNT_EVENT(nlmclnt_unlock);
+DEFINE_NLMCLNT_EVENT(nlmclnt_grant);
+
+#endif /* _TRACE_LOCKD_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE trace
+#include <trace/define_trace.h>


