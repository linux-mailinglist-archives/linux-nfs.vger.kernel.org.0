Return-Path: <linux-nfs+bounces-9740-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 067A1A21DFC
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 14:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 120637A342A
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 13:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DF517A597;
	Wed, 29 Jan 2025 13:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JiOulLSS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D17613CFA6;
	Wed, 29 Jan 2025 13:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738158014; cv=none; b=sAMUZJmzI/7XB1IHoFal5iPZwQf2uLZjqbyE33gHnAVh1j0A0fKSNClpzLpG7IRqBB82UFcDVBX/UcUKkH0SJm2CyVsJpKVOs/AklDmXDxMvT4Xr6VXG1bGmen0aJPmI2jLbKuk4vE9ux3nAd88hZfyphRNboDtfhHEiUNBcXdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738158014; c=relaxed/simple;
	bh=mWtiwAf1TWZ09yyz9/4JnDmExVA8h8RD1xcqnFMYDnk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XzSkmzi36tKsb6wvFJez5eq0vEuT+gSOibrgUC9m0xqoQ6+mod/40CVJnpjAfCl7Kfj2IT6anc5GAvywrxVcU0m2qQO8E6ot+KWPugVF9bovejXreDa4fon+Z5tacVtc5YFCfpF0bLt+7Va8kTLMzw1CeBD1uFJPn6JVAA6NqrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JiOulLSS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B24C4CEE2;
	Wed, 29 Jan 2025 13:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738158014;
	bh=mWtiwAf1TWZ09yyz9/4JnDmExVA8h8RD1xcqnFMYDnk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JiOulLSSV4OfEywzA9OUYRdih2lp1BWM7vqb+wXtpTxJw9HkE6sGBCxl9UXbTEr8X
	 AA1ooGkemqqJF5ArjjDOiYuGXiMAvddn0htbRuj8yQidxBGgyoWT6UEKiAdG0xh1oT
	 WRkpo4L6GIPKWEy3ZHMUFzJIxpHpkJKdFFfIzANoj6tzpcqc51h+vZNex5vDBfTR9+
	 fB+bZxlHzwptuKIaDTJDCAZhGWfR28jhPcomV1ageP0nLrOkq1s8off3nB/B5aT5iV
	 IQ5YZh1prmnkhIzH3QUA5OvBkl2UwufzLYlknaoquXJmM4gYApXi2jDLuQRhBQLz0f
	 RsiiyvLkJbwGQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 29 Jan 2025 08:39:55 -0500
Subject: [PATCH v2 2/7] nfsd: make clp->cl_cb_session be an RCU managed
 pointer
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-nfsd-6-14-v2-2-2700c92f3e44@kernel.org>
References: <20250129-nfsd-6-14-v2-0-2700c92f3e44@kernel.org>
In-Reply-To: <20250129-nfsd-6-14-v2-0-2700c92f3e44@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>, 
 Kinglong Mee <kinglongmee@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5132; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=mWtiwAf1TWZ09yyz9/4JnDmExVA8h8RD1xcqnFMYDnk=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnmi+5JSnjBAWyiG4qQQ2kv3L6ZSJp2FBu86FSN
 NimqNzhvFKJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ5ovuQAKCRAADmhBGVaC
 FR0TD/sE2qHB5B5CHboApL7X1xcF+YN4HqZZmlt6zpJiecDTYecifScooaZN2cppXeaho7eC9hi
 jtXHSl/1I43GUBrV5+Or7mhMapeUvURjEhoqxTiCf5gCkQQkTw59Wd1NPqgcRFCrS7QcwS2dZq/
 mHnGD0TjfQcvhSt7AutFajJLw9Drn+An+iG3q8XwDzGVlwNsfwYOr1RBWqRmslWgeTUs1fYHQyj
 qy4oQpQ33AO5kHX1uhPSd27CQZYFNla8UUCN3mZE20uNCRiERdarpJ8XxLxgEDHgi571fA8k/vF
 cld+zCj9kFTdDujaIFa+yb3QRIJCDBlnEdSbctk2JIOt8z9WODo3Rdyo9wKpBV7mSugLQb4QGPp
 zKkXIOVDzYEaoDQgG+T7T79If1I/3q2p3E8s8pGmhA+4KLagAToVe0nCFg857CIsL5VbSIrCXzR
 XtubnqTGcrLyS0mo/VirYRN4JP2dVOCRehlBdrlmIikbg88k0adVv9iEJY7dIzavaUUT75n+mnz
 L00wr3ZGaGmNSWF4pwjJo8tZKigWg5fScHjvIX86jp6V23X7gIJKZfzbYEK+1NCnhCmVWVP+WNH
 6aKBUTtqHSeL13Gux9Zz3Gzp1b9kl2eE6kNKVKLpdi4tAYMy1u3SgrGKGq/q47x6JsMuuQZHEUs
 oFmkTZM4JAcSUsg==
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
index 2c26c6aaea93e3e1eb438e7e23dc881c7bf35fe2..59d3111f558396ec46f7d286b2c90500bda642d9 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2180,7 +2180,7 @@ static void __free_session(struct nfsd4_session *ses)
 {
 	free_session_slots(ses, 0);
 	xa_destroy(&ses->se_slots);
-	kfree(ses);
+	kfree_rcu(ses, se_rcu);
 }
 
 static void free_session(struct nfsd4_session *ses)
@@ -3283,7 +3283,7 @@ static struct nfs4_client *create_client(struct xdr_netobj name,
 	clp->cl_time = ktime_get_boottime_seconds();
 	copy_verf(clp, verf);
 	memcpy(&clp->cl_addr, sa, sizeof(struct sockaddr_storage));
-	clp->cl_cb_session = NULL;
+	rcu_assign_pointer(clp->cl_cb_session, NULL);
 	clp->net = net;
 	clp->cl_nfsd_dentry = nfsd_client_mkdir(
 		nn, &clp->cl_nfsdfs,
@@ -4251,6 +4251,13 @@ nfsd4_destroy_session(struct svc_rqst *r, struct nfsd4_compound_state *cstate,
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


