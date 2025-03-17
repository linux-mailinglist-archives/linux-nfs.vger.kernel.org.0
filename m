Return-Path: <linux-nfs+bounces-10641-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0890A66041
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Mar 2025 22:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E830C7A9E58
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Mar 2025 21:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1D32066EC;
	Mon, 17 Mar 2025 21:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlC0xV7g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729282066E0;
	Mon, 17 Mar 2025 21:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742245221; cv=none; b=KwAnqEZuGmyft6W5fDJp7glkwrtC1qbVHHiuS9Z0+QWwcNRAUpwkjI4b16AjSNoXZnxXphcFFCrJoJsZERH+AvVW1fm/JY+vHjIUZ9bzp0+kluLCsVj/eFiIW21JbLaZnFJXa0trSlQuAj1I+2jhvVn1KoHCcsryLLIKT8LF7hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742245221; c=relaxed/simple;
	bh=Z5/wSBNGoRjPZe6UknBCcjWslKIoPkOSczStlrLokkU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EnGgG+XhAo3PtQPMavZZQ24ZbpbuPIOhNDmJbrp0pRqtfvLhtkmYFAjm0se3sPnV5ySeIPrRQm4R0/sTDFBuPvgitWQH+CxSpc+nGG5XVPQQWJu1p+MU+WDJXUoiHlfzUAHAwNhQcUAnK+I8QOhALuW8fkSfe7lUc2+zOGvYtHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlC0xV7g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4112C4CEEF;
	Mon, 17 Mar 2025 21:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742245221;
	bh=Z5/wSBNGoRjPZe6UknBCcjWslKIoPkOSczStlrLokkU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dlC0xV7gWnb5Piajps05kRnNTjz4kFH/UqeRyh8mxSq6O+U8JRgpM+31MOU8EESQ/
	 bnMSBbZbVyO7hxfs6rRY1aLbNtcS/cBb0XyDGDVx1/DP8WKCXkYqCww25Zjf6uOGon
	 OuwpWqB4twFviRdoFaAgO8TiDWsBEBJckD0MlCO9JFjKHh+y4zUO9Acwk+JY80364X
	 qL1laAMaHq4AkXP22RzLn9uiKMs7ZQ04USiP5Pc/pxMTNrGn037C+efmEY1Lb4Vbtl
	 Okvc3XrBMEnFKX/Ex4d8y4lIewu510llwJI4eCIFbyLJ81U1iRd2MND6WajfKUqy5R
	 biWmzAVjkYJMQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 17 Mar 2025 17:00:00 -0400
Subject: [PATCH RFC 8/9] sunrpc: don't hold a struct net reference in
 rpc_xprt
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-rpc-shutdown-v1-8-85ba8e20b75d@kernel.org>
References: <20250317-rpc-shutdown-v1-0-85ba8e20b75d@kernel.org>
In-Reply-To: <20250317-rpc-shutdown-v1-0-85ba8e20b75d@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, 
 Benjamin Coddington <bcodding@redhat.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3896; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Z5/wSBNGoRjPZe6UknBCcjWslKIoPkOSczStlrLokkU=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn2I1Vj76f1dyfLM00qicCuaAy4iF0NNiiErKEW
 Ny/ljZX97KJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ9iNVQAKCRAADmhBGVaC
 FZMyEACW1N5BEF57kUM5FZfXzAJBtxwviaBnfpvfg6IdomUa+OMZNyknDcvW2Cpne3A25FxSbRq
 JRwRzuvkGKuTntaWfOo0XE7C8CuxF4Ue9eE6qEK9tF9nal8csEUVWJPvF6HeR+NWFx9XXAIBc31
 jxqtEH/EL/04oCwKshI8ICyG/wP2EqadP2J8CrxD6lXycXGEYlk2PeNkpfmEXNxg2auKP+nfu6I
 4AIBbzO9hRx4CS1SlgHm+YoP77dt3c2XYoGQrM/91VcTmvbtZNWovU+0dLHpyNHkGSyaajxv2GH
 X58AI//LLSiz5e+PyyQrCGABcOFB+XJyUJvC+PpShcFAKK9rq/mKTq5TlYN0pnU+k8lZyz+2hrm
 uSxMalLCSyGqeqMP5ayTthCKaRqYB3/riEpe/uwcKbIkQt2hnEcXDVnAEAUh/jYkWyk5Tbe0Pt0
 OhCEIdhhVrPx4ztil89apW1KnmCOFdA7DGKyJqqBws/o9dC6GULrnppVcUJsiInCOU+h6cg13te
 HvA9U0SN5LQxnbcy39zMWK7KM8lDzTDWRHAk1ox/69VoyhXkGu/Hcgrl+O3KE9HGaMzsoJ/hDca
 oyVNBxxUVzFNY+vycfJ54kVJrmZXhYDr3053aff/TDogLu7leIGeuC3mgq7fd/ERghS7UA5ZtTX
 wcUBQkaosHktBow==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Currently each rpc_xprt holds a reference to struct net. This is
problematic for at least a couple of reasons:

1/ a container with an nfs mount inside can spontaneously die and take
network connectivity with it. When this happens, the netns and rpc_clnt
stick around and the client continually tries to retransmit any RPCs in
a net namespace that is otherwise defunct.

2/ the gssproxy rpc_clnt is torn down when the netns exits, but that
can never happen due to the circular dependency. The result is that any
container that runs gssproxy will leak the netns on exit.

Instead of holding a reference to the netns in rpc_xprt, add a pre_exit
routine that will shut down all rpc_clnt's associated with the netns,
and then wait for the list to go empty.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/sunrpc/xprt.h |  1 -
 net/sunrpc/clnt.c           |  2 ++
 net/sunrpc/sunrpc_syms.c    | 29 +++++++++++++++++++++++++++++
 net/sunrpc/xprt.c           |  3 +--
 4 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index 81b952649d35e3ad4fa8c7e77388ac2ceb44ce60..67c41917e3d83fc0b5c2240f2f1243a2b67da0ec 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -296,7 +296,6 @@ struct rpc_xprt {
 	} stat;
 
 	struct net		*xprt_net;
-	netns_tracker		ns_tracker;
 	const char		*servername;
 	const char		*address_strings[RPC_DISPLAY_MAX];
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 0028858b12d97e7b45f4c24cfbd761ba2a734b32..80cd1ddd155db64fc5b2449ebf54714d80a2838c 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -91,6 +91,8 @@ static void rpc_unregister_client(struct rpc_clnt *clnt)
 
 	spin_lock(&sn->rpc_client_lock);
 	list_del(&clnt->cl_clients);
+	if (list_empty(&sn->all_clients))
+		wake_up_var(&sn->all_clients);
 	spin_unlock(&sn->rpc_client_lock);
 }
 
diff --git a/net/sunrpc/sunrpc_syms.c b/net/sunrpc/sunrpc_syms.c
index bab6cab2940524a970422b62b3fa4212c61c4f43..d919f77522a7c6f7c477b2674f0b3a54155c91d9 100644
--- a/net/sunrpc/sunrpc_syms.c
+++ b/net/sunrpc/sunrpc_syms.c
@@ -77,9 +77,38 @@ static __net_exit void sunrpc_exit_net(struct net *net)
 	WARN_ON_ONCE(!list_empty(&sn->all_clients));
 }
 
+static void shutdown_all_clients(struct sunrpc_net *sn)
+{
+	struct rpc_clnt *clnt;
+
+	lockdep_assert_held(&sn->rpc_client_lock);
+
+	list_for_each_entry(clnt, &sn->all_clients, cl_clients)
+		rpc_clnt_shutdown(clnt);
+}
+
+static bool all_clients_gone(struct sunrpc_net *sn)
+{
+	bool empty;
+
+	spin_lock(&sn->rpc_client_lock);
+	empty = list_empty(&sn->all_clients);
+	spin_unlock(&sn->rpc_client_lock);
+	return empty;
+}
+
+static void sunrpc_pre_exit_net(struct net *net)
+{
+	struct sunrpc_net *sn = net_generic(net, sunrpc_net_id);
+
+	shutdown_all_clients(sn);
+	wait_var_event(&sn->all_clients, all_clients_gone(sn));
+}
+
 static struct pernet_operations sunrpc_net_ops = {
 	.init = sunrpc_init_net,
 	.exit = sunrpc_exit_net,
+	.pre_exit = sunrpc_pre_exit_net,
 	.id = &sunrpc_net_id,
 	.size = sizeof(struct sunrpc_net),
 };
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 09f245cda5262a572c450237419c80b183a83568..040cc9bf92cfa8f28edaee707a09a9e8d9955c41 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1849,7 +1849,6 @@ EXPORT_SYMBOL_GPL(xprt_alloc);
 
 void xprt_free(struct rpc_xprt *xprt)
 {
-	put_net_track(xprt->xprt_net, &xprt->ns_tracker);
 	xprt_free_all_slots(xprt);
 	xprt_free_id(xprt);
 	rpc_sysfs_xprt_destroy(xprt);
@@ -2047,7 +2046,7 @@ static void xprt_init(struct rpc_xprt *xprt, struct net *net)
 
 	xprt_init_xid(xprt);
 
-	xprt->xprt_net = get_net_track(net, &xprt->ns_tracker, GFP_KERNEL);
+	xprt->xprt_net = net;
 }
 
 /**

-- 
2.48.1


