Return-Path: <linux-nfs+bounces-9771-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6BBA226D7
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 00:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDDB4188735C
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 23:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A481E3DEC;
	Wed, 29 Jan 2025 23:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s242wHhM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DAE1E3DD6;
	Wed, 29 Jan 2025 23:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738192856; cv=none; b=jtj5JruxaSnSTui52tRX7DgCU+Tow0MymYunhFDTh72FZ3vZGE3D1IYyI1SBnF+m/oQfmEJL4xRqfV9jvt3KpwonVN7lD7rA6L6e7BDx53VRJpcNJQUY817di11Jho+Cng/1sLfHR2y87cFB6HyAlfhuPHbrjpKHf6Y/csDWdWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738192856; c=relaxed/simple;
	bh=OiL8q1LfHA/I9AsXcKVH8K322R8abnjFCLN6FLdRUSQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OB9ACMbRBkYLfEC2mCMrNHrDZLaBmjb1VYlQ2UfEKmnnO/Y6jxFfgyI6AAHRaMRO5dR8e4AQNdsf6li63qh3tXK7s5l1WhPlzq0RQvL6TZ/wjdoDBn45YQgMcZK/XZP3R66EfeXU3VLWFtANqpW7ZnQurWpILz+Vg6T2D+cPtaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s242wHhM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C04BC4CEE4;
	Wed, 29 Jan 2025 23:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738192856;
	bh=OiL8q1LfHA/I9AsXcKVH8K322R8abnjFCLN6FLdRUSQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=s242wHhMFUWyBxKvDwZgymd8KV25vZ8jIx8+rxHstzeS10W1GYl7JTc2STN/S3cRi
	 sS9TsIOasm3gPRuuOInY8uvZv1n1a2JEi8QJKInftS+RmY/+yF8n1qs/dj/zWb6GL4
	 kvXMpytt1h3qGbjPgxZOUYIlzb+2NycDO9heF5Ktel5cXADGjCQBKNYOr9wqy/9wUB
	 cdfpsUB9wlc9Bdu/ln1JGXySyMtleSBbJkM41oEMJ/vFlMuYPy/Z5xckd5wEDACNf3
	 DKcWsvTflFWB1DVb3Adm8GlN0O3wzrS42XwHyxrbEuaQ73Fp5HkdrUnmHOGlJzLczi
	 90Fl56FmaXXEA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 29 Jan 2025 18:20:42 -0500
Subject: [PATCH v3 2/6] nfsd: make clp->cl_cb_session be an RCU managed
 pointer
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-nfsd-6-14-v3-2-506e71e39e6b@kernel.org>
References: <20250129-nfsd-6-14-v3-0-506e71e39e6b@kernel.org>
In-Reply-To: <20250129-nfsd-6-14-v3-0-506e71e39e6b@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5132; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=OiL8q1LfHA/I9AsXcKVH8K322R8abnjFCLN6FLdRUSQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnmrfU6rKdmT6h/T/xIiITDkf7glkLWYjyWRRJE
 9wamiqtBgWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ5q31AAKCRAADmhBGVaC
 FecvEACHwdFbOL7MO/krhGsetbMdrgJ4vtbGthNke+p87/8psLO7Jc4OpKmU19FZHINQBxcB3ub
 qVvmp/OziCGmGrjXCBX/45GTVr4OF47FXoNmqD1VZoGZhlyGnfcFL1GI2bJDR2btEXNmDMOocSj
 VAyLxNbM1tD4oiBMcNiueDJdw9Gi1AjYUZz0/+k+e5qPzOmZLwPJxoAsmfVgCMPVGUJl73XCuyy
 RLaIM6Js/ua7RhTTPE+wX9RBiq8VTAunM7l5lsxwOvmHytPU8AIBNCvo0qIWrCKTSgvzVpsrofn
 0+x9UukF+bawrzNCNys6y/GUM9kIzr84ypDdXJsC6mE/iUuNDAhrvDZ3txfmS6kXQSFpliu67h+
 hITLhAcrw/WjqhfyDPniukecsGUD89SZVFvMJIbWltMNyRcJaMMvprbpW/Ob8M2h/C0Mrpm5l2f
 RvfDW6uraYVuwgHalTn6XrAVpq4zX7FbLmaeJk1Xdch5hr1ZMiT1+fb5uKHRIkI5MMDlNbmhgbd
 49o94MJtrBFzums7Uqpbbe8BYBKsiVTprJx6Iq1vFpHHyHIWw3YSDfvql7mmxIjzN5MKCoa7SgD
 NKSGUjl2fBUfYGsnrzLYT/qMppmUG+weKtObRYp5ui5LVXBEw5ou72sd/jhuaYR9Y1Dec3oZ8HT
 D4dNRO9rv26Igtw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Currently, this is just a pointer to the most recent session, but
there is no guarantee that the session is still valid and in memory.
It's possible for this pointer go NULL or replaced.

First, embed a struct rcu in nfsd4_session and free it via free_rcu.
Ensure that when clp->cl_cb_session pointer is changed, that it is done
via RCU-safe methods.

This will allow callbacks to access the cl_cb_session pointer safely via
RCU.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 21 ++++++++++++++++++---
 fs/nfsd/nfs4state.c    | 11 +++++++++--
 fs/nfsd/state.h        |  3 ++-
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 50e468bdb8d4838b5217346dcc2bd0fec1765c1a..e55bf66a33d6efb56d2f75f0a49a60307e3807ac 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1122,6 +1122,7 @@ static int setup_callback_client(struct nfs4_client *clp, struct nfs4_cb_conn *c
 	};
 	struct rpc_clnt *client;
 	const struct cred *cred;
+	int ret;
 
 	if (clp->cl_minorversion == 0) {
 		if (!clp->cl_cred.cr_principal &&
@@ -1137,7 +1138,9 @@ static int setup_callback_client(struct nfs4_client *clp, struct nfs4_cb_conn *c
 	} else {
 		if (!conn->cb_xprt || !ses)
 			return -EINVAL;
-		clp->cl_cb_session = ses;
+		if (!nfsd4_cb_get_session(ses))
+			return -EINVAL;
+		rcu_assign_pointer(clp->cl_cb_session, ses);
 		args.bc_xprt = conn->cb_xprt;
 		args.prognumber = clp->cl_cb_session->se_cb_prog;
 		args.protocol = conn->cb_xprt->xpt_class->xcl_ident |
@@ -1148,13 +1151,15 @@ static int setup_callback_client(struct nfs4_client *clp, struct nfs4_cb_conn *c
 	client = rpc_create(&args);
 	if (IS_ERR(client)) {
 		trace_nfsd_cb_setup_err(clp, PTR_ERR(client));
-		return PTR_ERR(client);
+		ret = PTR_ERR(client);
+		goto out_put_ses;
 	}
 	cred = get_backchannel_cred(clp, client, ses);
 	if (!cred) {
 		trace_nfsd_cb_setup_err(clp, -ENOMEM);
 		rpc_shutdown_client(client);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out_put_ses;
 	}
 
 	if (clp->cl_minorversion != 0)
@@ -1166,6 +1171,12 @@ static int setup_callback_client(struct nfs4_client *clp, struct nfs4_cb_conn *c
 			    args.authflavor);
 	rcu_read_unlock();
 	return 0;
+out_put_ses:
+	if (clp->cl_minorversion != 0) {
+		rcu_assign_pointer(clp->cl_cb_session, NULL);
+		nfsd4_cb_put_session(ses);
+	}
+	return ret;
 }
 
 static void nfsd4_mark_cb_state(struct nfs4_client *clp, int newstate)
@@ -1529,11 +1540,15 @@ static void nfsd4_process_cb_update(struct nfsd4_callback *cb)
 	 * kill the old client:
 	 */
 	if (clp->cl_cb_client) {
+		struct nfsd4_session *ses;
+
 		trace_nfsd_cb_bc_shutdown(clp, cb);
 		rpc_shutdown_client(clp->cl_cb_client);
 		clp->cl_cb_client = NULL;
 		put_cred(clp->cl_cb_cred);
 		clp->cl_cb_cred = NULL;
+		ses = rcu_replace_pointer(clp->cl_cb_session, NULL, true);
+		nfsd4_cb_put_session(ses);
 	}
 	if (clp->cl_cb_conn.cb_xprt) {
 		svc_xprt_put(clp->cl_cb_conn.cb_xprt);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index db68fd579ff0454153537817ee3cca71303654b4..77b0338c50d7f75fe6d03659b2ed3188976debac 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2182,7 +2182,7 @@ static void __free_session(struct nfsd4_session *ses)
 {
 	free_session_slots(ses, 0);
 	xa_destroy(&ses->se_slots);
-	kfree(ses);
+	kfree_rcu(ses, se_rcu);
 }
 
 static void free_session(struct nfsd4_session *ses)
@@ -3285,7 +3285,7 @@ static struct nfs4_client *create_client(struct xdr_netobj name,
 	clp->cl_time = ktime_get_boottime_seconds();
 	copy_verf(clp, verf);
 	memcpy(&clp->cl_addr, sa, sizeof(struct sockaddr_storage));
-	clp->cl_cb_session = NULL;
+	rcu_assign_pointer(clp->cl_cb_session, NULL);
 	clp->net = net;
 	clp->cl_nfsd_dentry = nfsd_client_mkdir(
 		nn, &clp->cl_nfsdfs,
@@ -4253,6 +4253,13 @@ nfsd4_destroy_session(struct svc_rqst *r, struct nfsd4_compound_state *cstate,
 	status = nfserr_wrong_cred;
 	if (!nfsd4_mach_creds_match(ses->se_client, r))
 		goto out_put_session;
+
+	/*
+	 * Is this session the backchannel session? Count an extra
+	 * reference if so.
+	 */
+	if (ses == rcu_access_pointer(ses->se_client->cl_cb_session))
+		ref_held_by_me++;
 	status = mark_session_dead_locked(ses, 1 + ref_held_by_me);
 	if (status)
 		goto out_put_session;
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 79d985d2a656e1a5b22a6a9c88f309515725e847..0faa367c9fa3280fa4a8a982f974804bb89f2035 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -354,6 +354,7 @@ struct nfsd4_session {
 	u16			se_slot_gen;
 	bool			se_dead;
 	u32			se_target_maxslots;
+	struct rcu_head		se_rcu;
 };
 
 /* formatted contents of nfs4_sessionid */
@@ -465,7 +466,7 @@ struct nfs4_client {
 #define NFSD4_CB_FAULT		3
 	int			cl_cb_state;
 	struct nfsd4_callback	cl_cb_null;
-	struct nfsd4_session	*cl_cb_session;
+	struct nfsd4_session	__rcu *cl_cb_session;
 
 	/* for all client information that callback code might need: */
 	spinlock_t		cl_lock;

-- 
2.48.1


