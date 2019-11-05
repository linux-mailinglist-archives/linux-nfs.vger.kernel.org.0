Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85907F022E
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Nov 2019 17:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390083AbfKEQEM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Nov 2019 11:04:12 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:41091 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389934AbfKEQEM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Nov 2019 11:04:12 -0500
Received: by mail-yb1-f193.google.com with SMTP id b2so9559710ybr.8
        for <linux-nfs@vger.kernel.org>; Tue, 05 Nov 2019 08:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=sFkbpPlfmQs3dTxZIAP+NR8cTrWo+MNga0gaYtRnRhI=;
        b=ntlJ2iwC8L3YYfEjXwG87AL9UCMqkS9Qn5Ad2bBfT9zTFdS5GgbGcNvF8a3X9Xae6T
         4Ppq7k9u3OihFY7U2s7ApGViuDwP6gbuyy1muufY2flaO4eKTVf3hfYYnGTnK7ua9rhh
         5nLKBZ/RX/p3Fj3zDdpVWP1QmR+6xGyG+2Xu2BxLbvBgzp5mvH2KEmm2OflHOhV9mP6X
         cPOqjQbLBfagsi3OMplmuNE+dg6QBF3I0rP6ces7nGUy4PZ0EAhE3vBHYW3INjQWSb0H
         UlhMJe/qUrnoc4NueCF3BIkRTFWZP+qJRvxzFXF0lGu9edReMX/odXj0TVywZGe08WUP
         9sqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=sFkbpPlfmQs3dTxZIAP+NR8cTrWo+MNga0gaYtRnRhI=;
        b=ZLMvbyRiYiU7zUosi85s0arvVGlplxwaDTDws6eJYDrE9rxdW0h04wvzRWJ3JPJPNO
         y8jBa/3BBict9HPyNSHPyueJvORNApgcpICiD++xtyW0DWzISqfZ5u1NceYzfu76Ixn/
         Zgbxbw5G+ykYCsoSw5QM+AeqFdfqRaSiLAWlxmXQ+H8d2rmn+10/QJbgqguQyFmDWFym
         QuiB/aoGf2kFh0eo811eHkpcqvnvlDWMC4zFdI6lZKz3Xi4Ou2YAmdVC6AXqS0uut7yb
         i/zKIdMHawox9GBFkfD/VetMxBOT0aK4o47EqA9iN0ipUHQZy3zryn5S6ivL1Keuxt2/
         pppA==
X-Gm-Message-State: APjAAAVlmHXrpM8aTCEFgjQeMdR+YHA3NBdcdWKIETvptKibACtnidsj
        9C6JtOdso7oFYDNd1bqucLbxVlmaVf8=
X-Google-Smtp-Source: APXvYqzvNcZOMbrK6MDPZGL0D+6KDfmlv0UKXzsdwjtOceAFfT9g92cVlimfABNfkYSMs1gGwjbeYw==
X-Received: by 2002:a25:ca0c:: with SMTP id a12mr27811499ybg.201.1572969849098;
        Tue, 05 Nov 2019 08:04:09 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id w133sm7930949ywa.25.2019.11.05.08.04.08
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 08:04:08 -0800 (PST)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id xA5G47wR016748
        for <linux-nfs@vger.kernel.org>; Tue, 5 Nov 2019 16:04:07 GMT
Subject: [PATCH RFC 1/2] NFS4: Trace state recovery operation
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Nov 2019 11:04:07 -0500
Message-ID: <20191105160407.26481.79496.stgit@manet.1015granger.net>
In-Reply-To: <20191105160208.26481.97809.stgit@manet.1015granger.net>
References: <20191105160208.26481.97809.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add a trace point in the main state manager loop to observe state
recovery operation. Help track down state recovery bugs.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs4state.c |    3 ++
 fs/nfs/nfs4trace.h |   93 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 0c6d53dc3672..b69c33c3600c 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -60,6 +60,7 @@
 #include "nfs4session.h"
 #include "pnfs.h"
 #include "netns.h"
+#include "nfs4trace.h"
 
 #define NFSDBG_FACILITY		NFSDBG_STATE
 
@@ -2508,6 +2509,7 @@ static void nfs4_state_manager(struct nfs_client *clp)
 
 	/* Ensure exclusive access to NFSv4 state */
 	do {
+		trace_nfs4_state_mgr(clp);
 		clear_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state);
 		if (test_bit(NFS4CLNT_PURGE_STATE, &clp->cl_state)) {
 			section = "purge state";
@@ -2621,6 +2623,7 @@ static void nfs4_state_manager(struct nfs_client *clp)
 out_error:
 	if (strlen(section))
 		section_sep = ": ";
+	trace_nfs4_state_mgr_failed(clp, section, status);
 	pr_warn_ratelimited("NFS: state manager%s%s failed on NFSv4 server %s"
 			" with error %d\n", section_sep, section,
 			clp->cl_hostname, -status);
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index b86f3f567bd0..a66af56c7eef 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -562,6 +562,99 @@
 		)
 );
 
+TRACE_DEFINE_ENUM(NFS4CLNT_MANAGER_RUNNING);
+TRACE_DEFINE_ENUM(NFS4CLNT_CHECK_LEASE);
+TRACE_DEFINE_ENUM(NFS4CLNT_LEASE_EXPIRED);
+TRACE_DEFINE_ENUM(NFS4CLNT_RECLAIM_REBOOT);
+TRACE_DEFINE_ENUM(NFS4CLNT_RECLAIM_NOGRACE);
+TRACE_DEFINE_ENUM(NFS4CLNT_DELEGRETURN);
+TRACE_DEFINE_ENUM(NFS4CLNT_SESSION_RESET);
+TRACE_DEFINE_ENUM(NFS4CLNT_LEASE_CONFIRM);
+TRACE_DEFINE_ENUM(NFS4CLNT_SERVER_SCOPE_MISMATCH);
+TRACE_DEFINE_ENUM(NFS4CLNT_PURGE_STATE);
+TRACE_DEFINE_ENUM(NFS4CLNT_BIND_CONN_TO_SESSION);
+TRACE_DEFINE_ENUM(NFS4CLNT_MOVED);
+TRACE_DEFINE_ENUM(NFS4CLNT_LEASE_MOVED);
+TRACE_DEFINE_ENUM(NFS4CLNT_DELEGATION_EXPIRED);
+TRACE_DEFINE_ENUM(NFS4CLNT_RUN_MANAGER);
+TRACE_DEFINE_ENUM(NFS4CLNT_DELEGRETURN_RUNNING);
+
+#define show_nfs4_clp_state(state) \
+	__print_flags(state, "|", \
+		{ NFS4CLNT_MANAGER_RUNNING,	"MANAGER_RUNNING" }, \
+		{ NFS4CLNT_CHECK_LEASE,		"CHECK_LEASE" }, \
+		{ NFS4CLNT_LEASE_EXPIRED,	"LEASE_EXPIRED" }, \
+		{ NFS4CLNT_RECLAIM_REBOOT,	"RECLAIM_REBOOT" }, \
+		{ NFS4CLNT_RECLAIM_NOGRACE,	"RECLAIM_NOGRACE" }, \
+		{ NFS4CLNT_DELEGRETURN,		"DELEGRETURN" }, \
+		{ NFS4CLNT_SESSION_RESET,	"SESSION_RESET" }, \
+		{ NFS4CLNT_LEASE_CONFIRM,	"LEASE_CONFIRM" }, \
+		{ NFS4CLNT_SERVER_SCOPE_MISMATCH, \
+						"SERVER_SCOPE_MISMATCH" }, \
+		{ NFS4CLNT_PURGE_STATE,		"PURGE_STATE" }, \
+		{ NFS4CLNT_BIND_CONN_TO_SESSION, \
+						"BIND_CONN_TO_SESSION" }, \
+		{ NFS4CLNT_MOVED,		"MOVED" }, \
+		{ NFS4CLNT_LEASE_MOVED,		"LEASE_MOVED" }, \
+		{ NFS4CLNT_DELEGATION_EXPIRED,	"DELEGATION_EXPIRED" }, \
+		{ NFS4CLNT_RUN_MANAGER,		"RUN_MANAGER" }, \
+		{ NFS4CLNT_DELEGRETURN_RUNNING,	"DELEGRETURN_RUNNING" })
+
+TRACE_EVENT(nfs4_state_mgr,
+		TP_PROTO(
+			const struct nfs_client *clp
+		),
+
+		TP_ARGS(clp),
+
+		TP_STRUCT__entry(
+			__field(unsigned long, state)
+			__string(hostname, clp->cl_hostname)
+		),
+
+		TP_fast_assign(
+			__entry->state = clp->cl_state;
+			__assign_str(hostname, clp->cl_hostname)
+		),
+
+		TP_printk(
+			"hostname=%s clp state=%s", __get_str(hostname),
+			show_nfs4_clp_state(__entry->state)
+		)
+)
+
+TRACE_EVENT(nfs4_state_mgr_failed,
+		TP_PROTO(
+			const struct nfs_client *clp,
+			const char *section,
+			int status
+		),
+
+		TP_ARGS(clp, section, status),
+
+		TP_STRUCT__entry(
+			__field(unsigned long, error)
+			__field(unsigned long, state)
+			__string(hostname, clp->cl_hostname)
+			__string(section, section)
+		),
+
+		TP_fast_assign(
+			__entry->error = status;
+			__entry->state = clp->cl_state;
+			__assign_str(hostname, clp->cl_hostname);
+			__assign_str(section, section);
+		),
+
+		TP_printk(
+			"hostname=%s clp state=%s error=%ld (%s) section=%s",
+			__get_str(hostname),
+			show_nfs4_clp_state(__entry->state), -__entry->error,
+			show_nfsv4_errors(__entry->error), __get_str(section)
+
+		)
+)
+
 TRACE_EVENT(nfs4_xdr_status,
 		TP_PROTO(
 			const struct xdr_stream *xdr,

