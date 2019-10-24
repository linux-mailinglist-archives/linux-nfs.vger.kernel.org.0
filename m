Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 247AFE344B
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2019 15:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393573AbfJXNeP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Oct 2019 09:34:15 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37662 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388422AbfJXNeP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Oct 2019 09:34:15 -0400
Received: by mail-io1-f65.google.com with SMTP id 1so18132892iou.4
        for <linux-nfs@vger.kernel.org>; Thu, 24 Oct 2019 06:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=o9JR5w00XEddWEDCY+0yU4TSIhJayQ9rcyqIPKWuYF8=;
        b=ofIB016F5qTfI8a9p7PHEIMjhRyBh6IczwPJRYMIXmjexAON20/oxOwLdakaw1nIsM
         sOoe9Ei94NC4GmluQMqm0hhRpk6gl1Z3tjQQbHo9jo0QyNGV4ow/quKBHpcEy3JP97bc
         EPK10Eoc5kEejdiVZDkrkCbxsmYMfvx4l1hVfT2wd9QD3XJiy9+FMe7/lWtxkPy84syw
         gNxBL3manMGSSbidIrzNw0ETODncLXpKPRjM513UF6blqEmrCpUx4CXYQ3ZBaQd7A+OW
         UAM4xnQY8LiRLPx9/6gJ3cet6cmI0pSTNSNkauVLRmqHRDAp2OmVUMQLgeP8PvXiYZ3C
         xlyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=o9JR5w00XEddWEDCY+0yU4TSIhJayQ9rcyqIPKWuYF8=;
        b=o58zTyJGLeaoU/GQi/tqNqlfqlxVE6m35FKikRcHzYC42KhjkTINP3tewaikcnNrKL
         X4PZ3GrhQxO47IfvkTTccjli6plfPLDPwt8FaFz70NYNZM+PK8KFez1cGuJrVRmmE0zD
         +XVdDWxvwZE1I9eBK640Fk39pz+NAiWOwhWQFSJzgzooYfWQAYmwXw16WHiaekpyvZjo
         4fqTjt12sx7rw97M4DbT+lYOZiFCkqawfoqh+pK9QBaXag6aMI4PfcVv4g9/fAj3ARb+
         CrpVgEagcbchuescDSvUZlz8vMyiRlyo0StCzw78AO/rELg5X2g3KREkQUf2tlUYcIu9
         iicw==
X-Gm-Message-State: APjAAAUt+4t//yQH+7m66OoU3FbeIJI6udmOTxG1D0Vs1jTyIkY57obX
        JoMlScWgeScUQQwsG3ihgBhQe5vG
X-Google-Smtp-Source: APXvYqwjMCNf5D8rwJ0DoZmE85q5ndQG9Z0wNrAq+0lkbvLfbRzeYLZMeqt3vplmJrsXAqDZPw4qWw==
X-Received: by 2002:a02:694e:: with SMTP id e75mr14786413jac.85.1571924052870;
        Thu, 24 Oct 2019 06:34:12 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id y1sm252842iot.6.2019.10.24.06.34.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2019 06:34:12 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x9ODYA3l015338;
        Thu, 24 Oct 2019 13:34:10 GMT
Subject: [PATCH v1 1/2] SUNRPC: Trace gssproxy upcall results
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 24 Oct 2019 09:34:10 -0400
Message-ID: <20191024133410.2148.3456.stgit@klimt.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Record results of a GSS proxy ACCEPT_SEC_CONTEXT upcall and the
svc_authenticate() function to make field debugging of NFS server
Kerberos issues easier.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Bill Baker <bill.baker@oracle.com>
---
 include/trace/events/rpcgss.h         |   45 +++++++++++++++++++++++++++
 include/trace/events/sunrpc.h         |   55 +++++++++++++++++++++++++++++++++
 net/sunrpc/auth_gss/gss_mech_switch.c |    4 ++
 net/sunrpc/auth_gss/svcauth_gss.c     |    8 +++--
 net/sunrpc/svc.c                      |    2 +
 net/sunrpc/svcauth.c                  |    2 +
 6 files changed, 112 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/rpcgss.h b/include/trace/events/rpcgss.h
index d1f7fe1..9827f53 100644
--- a/include/trace/events/rpcgss.h
+++ b/include/trace/events/rpcgss.h
@@ -126,6 +126,34 @@
 DEFINE_GSSAPI_EVENT(wrap);
 DEFINE_GSSAPI_EVENT(unwrap);
 
+TRACE_EVENT(rpcgss_accept_upcall,
+	TP_PROTO(
+		__be32 xid,
+		u32 major_status,
+		u32 minor_status
+	),
+
+	TP_ARGS(xid, major_status, minor_status),
+
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(u32, minor_status)
+		__field(unsigned long, major_status)
+	),
+
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(xid);
+		__entry->minor_status = minor_status;
+		__entry->major_status = major_status;
+	),
+
+	TP_printk("xid=0x%08x major_status=%s (0x%08lx) minor_status=%u",
+		__entry->xid, __entry->major_status == 0 ? "GSS_S_COMPLETE" :
+				show_gss_status(__entry->major_status),
+		__entry->major_status, __entry->minor_status
+	)
+);
+
 
 /**
  ** GSS auth unwrap failures
@@ -355,6 +383,23 @@
 		show_pseudoflavor(__entry->flavor), __entry->error)
 );
 
+TRACE_EVENT(rpcgss_oid_to_mech,
+	TP_PROTO(
+		const char *oid
+	),
+
+	TP_ARGS(oid),
+
+	TP_STRUCT__entry(
+		__string(oid, oid)
+	),
+
+	TP_fast_assign(
+		__assign_str(oid, oid);
+	),
+
+	TP_printk("mech for oid %s was not found", __get_str(oid))
+);
 
 #endif	/* _TRACE_RPCGSS_H */
 
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index ffa3c51..c358a0a 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -14,6 +14,26 @@
 #include <linux/net.h>
 #include <linux/tracepoint.h>
 
+TRACE_DEFINE_ENUM(RPC_AUTH_OK);
+TRACE_DEFINE_ENUM(RPC_AUTH_BADCRED);
+TRACE_DEFINE_ENUM(RPC_AUTH_REJECTEDCRED);
+TRACE_DEFINE_ENUM(RPC_AUTH_BADVERF);
+TRACE_DEFINE_ENUM(RPC_AUTH_REJECTEDVERF);
+TRACE_DEFINE_ENUM(RPC_AUTH_TOOWEAK);
+TRACE_DEFINE_ENUM(RPCSEC_GSS_CREDPROBLEM);
+TRACE_DEFINE_ENUM(RPCSEC_GSS_CTXPROBLEM);
+
+#define rpc_show_auth_stat(status)					\
+	__print_symbolic(status,					\
+		{ RPC_AUTH_OK,			"AUTH_OK" },		\
+		{ RPC_AUTH_BADCRED,		"BADCRED" },		\
+		{ RPC_AUTH_REJECTEDCRED,	"REJECTEDCRED" },	\
+		{ RPC_AUTH_BADVERF,		"BADVERF" },		\
+		{ RPC_AUTH_REJECTEDVERF,	"REJECTEDVERF" },	\
+		{ RPC_AUTH_TOOWEAK,		"TOOWEAK" },		\
+		{ RPCSEC_GSS_CREDPROBLEM,	"GSS_CREDPROBLEM" },	\
+		{ RPCSEC_GSS_CTXPROBLEM,	"GSS_CTXPROBLEM" })	\
+
 DECLARE_EVENT_CLASS(rpc_task_status,
 
 	TP_PROTO(const struct rpc_task *task),
@@ -866,6 +886,41 @@
 			show_rqstp_flags(__entry->flags))
 );
 
+#define svc_show_status(status)				\
+	__print_symbolic(status,			\
+		{ SVC_GARBAGE,	"SVC_GARBAGE" },	\
+		{ SVC_SYSERR,	"SVC_SYSERR" },		\
+		{ SVC_VALID,	"SVC_VALID" },		\
+		{ SVC_NEGATIVE,	"SVC_NEGATIVE" },	\
+		{ SVC_OK,	"SVC_OK" },		\
+		{ SVC_DROP,	"SVC_DROP" },		\
+		{ SVC_CLOSE,	"SVC_CLOSE" },		\
+		{ SVC_DENIED,	"SVC_DENIED" },		\
+		{ SVC_PENDING,	"SVC_PENDING" },	\
+		{ SVC_COMPLETE,	"SVC_COMPLETE" })
+
+TRACE_EVENT(svc_authenticate,
+	TP_PROTO(const struct svc_rqst *rqst, int auth_res, __be32 auth_stat),
+
+	TP_ARGS(rqst, auth_res, auth_stat),
+
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(unsigned long, svc_status)
+		__field(unsigned long, auth_stat)
+	),
+
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqst->rq_xid);
+		__entry->svc_status = auth_res;
+		__entry->auth_stat = be32_to_cpu(auth_stat);
+	),
+
+	TP_printk("xid=0x%08x auth_res=%s auth_stat=%s",
+			__entry->xid, svc_show_status(__entry->svc_status),
+			rpc_show_auth_stat(__entry->auth_stat))
+);
+
 TRACE_EVENT(svc_process,
 	TP_PROTO(const struct svc_rqst *rqst, const char *name),
 
diff --git a/net/sunrpc/auth_gss/gss_mech_switch.c b/net/sunrpc/auth_gss/gss_mech_switch.c
index 8206009..30b7de6 100644
--- a/net/sunrpc/auth_gss/gss_mech_switch.c
+++ b/net/sunrpc/auth_gss/gss_mech_switch.c
@@ -20,6 +20,7 @@
 #include <linux/sunrpc/sched.h>
 #include <linux/sunrpc/gss_api.h>
 #include <linux/sunrpc/clnt.h>
+#include <trace/events/rpcgss.h>
 
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 # define RPCDBG_FACILITY        RPCDBG_AUTH
@@ -158,7 +159,6 @@ struct gss_api_mech *gss_mech_get_by_OID(struct rpcsec_gss_oid *obj)
 
 	if (sprint_oid(obj->data, obj->len, buf, sizeof(buf)) < 0)
 		return NULL;
-	dprintk("RPC:       %s(%s)\n", __func__, buf);
 	request_module("rpc-auth-gss-%s", buf);
 
 	rcu_read_lock();
@@ -172,6 +172,8 @@ struct gss_api_mech *gss_mech_get_by_OID(struct rpcsec_gss_oid *obj)
 		}
 	}
 	rcu_read_unlock();
+	if (!gm)
+		trace_rpcgss_oid_to_mech(buf);
 	return gm;
 }
 
diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 8be2f20..f130990 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -49,6 +49,9 @@
 #include <linux/sunrpc/svcauth.h>
 #include <linux/sunrpc/svcauth_gss.h>
 #include <linux/sunrpc/cache.h>
+
+#include <trace/events/rpcgss.h>
+
 #include "gss_rpc_upcall.h"
 
 
@@ -1270,9 +1273,8 @@ static int svcauth_gss_proxy_init(struct svc_rqst *rqstp,
 	if (status)
 		goto out;
 
-	dprintk("RPC:       svcauth_gss: gss major status = %d "
-			"minor status = %d\n",
-			ud.major_status, ud.minor_status);
+	trace_rpcgss_accept_upcall(rqstp->rq_xid, ud.major_status,
+				   ud.minor_status);
 
 	switch (ud.major_status) {
 	case GSS_S_CONTINUE_NEEDED:
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index d11b705..187dd4e 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1337,6 +1337,8 @@ static __printf(2,3) void svc_printk(struct svc_rqst *rqstp, const char *fmt, ..
 		auth_stat = rpc_autherr_badcred;
 		auth_res = progp->pg_authenticate(rqstp);
 	}
+	if (auth_res != SVC_OK)
+		trace_svc_authenticate(rqstp, auth_res, auth_stat);
 	switch (auth_res) {
 	case SVC_OK:
 		break;
diff --git a/net/sunrpc/svcauth.c b/net/sunrpc/svcauth.c
index 550b214..552617e 100644
--- a/net/sunrpc/svcauth.c
+++ b/net/sunrpc/svcauth.c
@@ -19,6 +19,8 @@
 #include <linux/err.h>
 #include <linux/hash.h>
 
+#include <trace/events/sunrpc.h>
+
 #define RPCDBG_FACILITY	RPCDBG_AUTH
 
 

