Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18F56A9715
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Mar 2023 13:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjCCMQO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Mar 2023 07:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjCCMQM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Mar 2023 07:16:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB7C5F52B
        for <linux-nfs@vger.kernel.org>; Fri,  3 Mar 2023 04:16:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49ABC617EF
        for <linux-nfs@vger.kernel.org>; Fri,  3 Mar 2023 12:16:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D188C4339C;
        Fri,  3 Mar 2023 12:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677845770;
        bh=iuFd6XnZyP4BVdezS9wf6YTJY4wU9VeTYPKM7QJ9EaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E254Vcjl2fA9lxX8a7jSAsJpRYSWdrzjQZrrOmry5BgLL+09TXZ1J9BTn+AE/iCdo
         BNC/2bn4D+fv1r/+hUIHxKHCEHMxjakwaHepIe0lvcDUB4QyEZU972W+KC3N4QA5kg
         dPdORvGCXe3LHhtiGzWyMsHyNTkAEwMX38ndSS18iD3uRMBbRMQ9Zhn6XMh3RWCS9+
         /CpZPCyorL9+JmMrQ/ckU144fLCJQTEYVnK6ZcrGROf0DATiRvoi6KBT5TP8SwAz1S
         t1oZ6IZfAljcsftwFhOY+h2oBiX+B6VwCnht33KOWCBNFvWBADt7IV3xm7A1zAYJ/Z
         WHvbY3uTp5BzA==
From:   Jeff Layton <jlayton@kernel.org>
To:     trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, yoyang@redhat.com
Subject: [PATCH 7/7] lockd: add some client-side tracepoints
Date:   Fri,  3 Mar 2023 07:16:03 -0500
Message-Id: <20230303121603.132103-8-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230303121603.132103-1-jlayton@kernel.org>
References: <20230303121603.132103-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/lockd/Makefile   |  6 ++--
 fs/lockd/clntlock.c |  4 +++
 fs/lockd/clntproc.c | 14 ++++++++
 fs/lockd/trace.c    |  3 ++
 fs/lockd/trace.h    | 83 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 108 insertions(+), 2 deletions(-)
 create mode 100644 fs/lockd/trace.c
 create mode 100644 fs/lockd/trace.h

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
index 000000000000..b79d154d5e66
--- /dev/null
+++ b/fs/lockd/trace.h
@@ -0,0 +1,83 @@
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
+#define show_nlm_status(val)							\
+	__print_symbolic(val,							\
+		{ NLM_LCK_GRANTED,		"LCK_GRANTED" },		\
+		{ NLM_LCK_DENIED,		"LCK_DENIED" },			\
+		{ NLM_LCK_DENIED_NOLOCKS,	"LCK_DENIED_NOLOCKS" },		\
+		{ NLM_LCK_BLOCKED,		"LCK_BLOCKED" },		\
+		{ NLM_LCK_DENIED_GRACE_PERIOD,	"LCK_DENIED_GRACE_PERIOD" },	\
+		{ NLM_DEADLCK,			"DEADLCK" },			\
+		{ NLM_ROFS,			"ROFS" },			\
+		{ NLM_STALE_FH,			"STALE_FH" },			\
+		{ NLM_FBIG,			"FBIG" },			\
+		{ NLM_FAILED,			"FAILED" })
+
+DECLARE_EVENT_CLASS(nlmclnt_lock_event,
+		TP_PROTO(
+			const struct nlm_lock *lock,
+			const struct sockaddr *addr,
+			unsigned int addrlen,
+			__be32	status
+		),
+
+		TP_ARGS(lock, addr, addrlen, status),
+
+		TP_STRUCT__entry(
+			__field(u32, oh)
+			__field(u32, svid)
+			__field(u32, fh)
+			__field(u32, status)
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
+			TP_PROTO( 				\
+				const struct nlm_lock *lock,	\
+				const struct sockaddr *addr,	\
+				unsigned int addrlen,		\
+				__be32	status			\
+			), 					\
+			TP_ARGS(lock, addr, addrlen, status))
+
+DEFINE_NLMCLNT_EVENT(nlmclnt_test);
+DEFINE_NLMCLNT_EVENT(nlmclnt_lock);
+DEFINE_NLMCLNT_EVENT(nlmclnt_unlock);
+DEFINE_NLMCLNT_EVENT(nlmclnt_grant);
+#endif /* _TRACE_LOCKD_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE trace
+#include <trace/define_trace.h>
-- 
2.39.2

