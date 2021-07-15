Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4D53CAD44
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jul 2021 21:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344917AbhGOT4W (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Jul 2021 15:56:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:45846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345748AbhGOTzH (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 15 Jul 2021 15:55:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A946361370;
        Thu, 15 Jul 2021 19:52:13 +0000 (UTC)
Subject: [PATCH v2 2/7] SUNRPC: Set rq_auth_stat in the pg_authenticate()
 callout
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 15 Jul 2021 15:52:12 -0400
Message-ID: <162637873295.728653.11355266133316488186.stgit@manet.1015granger.net>
In-Reply-To: <162637843471.728653.5920517086867549998.stgit@manet.1015granger.net>
References: <162637843471.728653.5920517086867549998.stgit@manet.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In a few moments, rq_auth_stat will need to be explicitly set to
rpc_auth_ok before execution gets to the dispatcher.

svc_authenticate() already sets it, but it often gets reset to
rpc_autherr_badcred right after that call, even when authentication
is successful. Let's ensure that the pg_authenticate callout and
svc_set_client() set it properly in every case.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc.c                    |    2 ++
 fs/nfs/callback.c                 |    4 ++++
 net/sunrpc/auth_gss/svcauth_gss.c |    4 ++++
 net/sunrpc/svc.c                  |    4 +---
 net/sunrpc/svcauth_unix.c         |    6 +++++-
 5 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 2de048f80eb8..8e936999216c 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -649,6 +649,7 @@ static int lockd_authenticate(struct svc_rqst *rqstp)
 	switch (rqstp->rq_authop->flavour) {
 		case RPC_AUTH_NULL:
 		case RPC_AUTH_UNIX:
+			rqstp->rq_auth_stat = rpc_auth_ok;
 			if (rqstp->rq_proc == 0)
 				return SVC_OK;
 			if (is_callback(rqstp->rq_proc)) {
@@ -659,6 +660,7 @@ static int lockd_authenticate(struct svc_rqst *rqstp)
 			}
 			return svc_set_client(rqstp);
 	}
+	rqstp->rq_auth_stat = rpc_autherr_badcred;
 	return SVC_DENIED;
 }
 
diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index 7817ad94a6ba..86d856de1389 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -429,6 +429,8 @@ check_gss_callback_principal(struct nfs_client *clp, struct svc_rqst *rqstp)
  */
 static int nfs_callback_authenticate(struct svc_rqst *rqstp)
 {
+	rqstp->rq_auth_stat = rpc_autherr_badcred;
+
 	switch (rqstp->rq_authop->flavour) {
 	case RPC_AUTH_NULL:
 		if (rqstp->rq_proc != CB_NULL)
@@ -439,6 +441,8 @@ static int nfs_callback_authenticate(struct svc_rqst *rqstp)
 		 if (svc_is_backchannel(rqstp))
 			return SVC_DENIED;
 	}
+
+	rqstp->rq_auth_stat = rpc_auth_ok;
 	return SVC_OK;
 }
 
diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 635449ed7af6..f89075070fb0 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1038,6 +1038,8 @@ svcauth_gss_set_client(struct svc_rqst *rqstp)
 	struct rpc_gss_wire_cred *gc = &svcdata->clcred;
 	int stat;
 
+	rqstp->rq_auth_stat = rpc_autherr_badcred;
+
 	/*
 	 * A gss export can be specified either by:
 	 * 	export	*(sec=krb5,rw)
@@ -1053,6 +1055,8 @@ svcauth_gss_set_client(struct svc_rqst *rqstp)
 	stat = svcauth_unix_set_client(rqstp);
 	if (stat == SVC_DROP || stat == SVC_CLOSE)
 		return stat;
+
+	rqstp->rq_auth_stat = rpc_auth_ok;
 	return SVC_OK;
 }
 
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 360dab62b6b4..2019d1203641 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1328,10 +1328,8 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 	 */
 	auth_res = svc_authenticate(rqstp);
 	/* Also give the program a chance to reject this call: */
-	if (auth_res == SVC_OK && progp) {
-		rqstp->rq_auth_stat = rpc_autherr_badcred;
+	if (auth_res == SVC_OK && progp)
 		auth_res = progp->pg_authenticate(rqstp);
-	}
 	if (auth_res != SVC_OK)
 		trace_svc_authenticate(rqstp, auth_res);
 	switch (auth_res) {
diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
index eacfebf326dd..d7ed7d49115a 100644
--- a/net/sunrpc/svcauth_unix.c
+++ b/net/sunrpc/svcauth_unix.c
@@ -681,8 +681,9 @@ svcauth_unix_set_client(struct svc_rqst *rqstp)
 
 	rqstp->rq_client = NULL;
 	if (rqstp->rq_proc == 0)
-		return SVC_OK;
+		goto out;
 
+	rqstp->rq_auth_stat = rpc_autherr_badcred;
 	ipm = ip_map_cached_get(xprt);
 	if (ipm == NULL)
 		ipm = __ip_map_lookup(sn->ip_map_cache, rqstp->rq_server->sv_program->pg_class,
@@ -719,6 +720,9 @@ svcauth_unix_set_client(struct svc_rqst *rqstp)
 		put_group_info(cred->cr_group_info);
 		cred->cr_group_info = gi;
 	}
+
+out:
+	rqstp->rq_auth_stat = rpc_auth_ok;
 	return SVC_OK;
 }
 


