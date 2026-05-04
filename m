Return-Path: <linux-nfs+bounces-21380-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKqfJuR0+Gk9vgIAu9opvQ
	(envelope-from <linux-nfs+bounces-21380-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 04 May 2026 12:28:52 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC034BBB83
	for <lists+linux-nfs@lfdr.de>; Mon, 04 May 2026 12:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9E8C33006B45
	for <lists+linux-nfs@lfdr.de>; Mon,  4 May 2026 10:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C1E3A4501;
	Mon,  4 May 2026 10:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTHbL/a1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603CC3A383A;
	Mon,  4 May 2026 10:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777890529; cv=none; b=Ht/ur3As4ZuF0fywPKH7siHxAmgBi8esUsHIHBZJqa378qRaFUgwEpv5VRon5MtRUodNd2Vg2itycWHckgVzrErRhzv7QF0parrcA7/q469vL3AQG0qv7FparuSjhy/HiDHpThcxnB6obe4YfytNTolLF1EB1sX2WM3pN3Gy5+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777890529; c=relaxed/simple;
	bh=VZBsdc2WQodrunCtmqG713gWgMzqFs5worxTs2iYY8g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p8RJO9kiuO3aBgMf23P8+Aa6LaclXvUrbwqvrqYGIS7c5Rs+eCpo9OHkK4AOu8R4dDkaX9WKPYtrI9yPIpiSyeaYvewoytiY86S5S0Wbf3/rpmcADr9Naj+Jmb+qT/+sjcc1lizwYpgPROy+IN7HUQNkTGawQJZZwRsxpi4TlWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTHbL/a1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF73C2BCB9;
	Mon,  4 May 2026 10:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777890529;
	bh=VZBsdc2WQodrunCtmqG713gWgMzqFs5worxTs2iYY8g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UTHbL/a1xXJFH+DcXKOOYxLen60FCp9E4ByrPh3V0c+P2hBf3xrAbLRtw4RaE21Tl
	 hlE+LGR0Tu0qFw8mYnaanZqdsrXVPGHjZ5/5WHUH2xyFGqN9ztgTNsOS4L1l0EXzQ3
	 uLi8YiSOY3FK1tVPlvNcDEO0wT4aSGnBctzvLd3E5blUFmRNUpIj0K3xmEVfaMES9i
	 M7QfaEfjT3DipnhWyjJU/A4hDzi1b4ToN0GxqlyLcIh0sPCLw5MHAUGaNonrPpBG/R
	 k1KzZeuVld6SdRwWdAkVYvx7ZdwWFjhfz4SE9c92bcHkHPKdeeHc4Dy9M+lYpv57tG
	 bRIXFCIGZgHIg==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 04 May 2026 06:28:19 -0400
Subject: [PATCH 2/2] SUNRPC: pin upper rpc_clnt across the TLS
 connect_worker
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-sunrpc-tls-clnt-pin-v1-2-197f359c6072@oracle.com>
References: <20260504-sunrpc-tls-clnt-pin-v1-0-197f359c6072@oracle.com>
In-Reply-To: <20260504-sunrpc-tls-clnt-pin-v1-0-197f359c6072@oracle.com>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Michael Nemanov <michael.nemanov@vastdata.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4579;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=Z2mi03BXplcOUgGlee6DH+aK0nCLSgN52+68zCXFPac=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp+HTYGaOICNcMMjeFxr6Jieth/r+/4B62fvRxj
 4QGvoMibyWJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafh02AAKCRAzarMzb2Z/
 l8mzD/9LTu8dNPIiVYl6uuJOFqtWR6NwsZkif+SBhA2xsS0igInbjjaCLbTZBafCPXTl+xCl3Zg
 SJzI2oqsbGKwAYHtrCstJFR5lgrH4jEyF6oM8z6uCzpXX2jow0Siq57OR3niIBSDqVhlWEP34gy
 oMpoZu+L/PGxWn6/6YhVkCYIqpW9jIYvcJAMxIfgMX+Kso5BYfNZ5AZ6rvbjzabOZ/Jz768lbf9
 RdSdxVkNpzyD2ifIQ/cXolB7zLzFB93mV3ffJdgahpnP8j8K0y6RIqYbnST3MeWhZBymO9ZakD9
 7v5XLgih8JlQT+T4cbJplbfeylfUwkXmyxwSr9EwrClUAaRBtdUl1UVI8Xo2aNEVoeSFTDhSmDG
 iXwFniZxg4WU2EoD+zDxS+odJrkbltZXtAXippekSFnaFM3T3Bj8B75CZosRRZatGod4lGEL8fS
 C1mpbDD05SriT3qalUWIT5M/qldjIuYGGNl0bGi/CvTdo7jp2NBMmtzLwm2YyGtVVLf0Wzgxb2A
 rLzyHMXoEOP7G2qvSZw6sUJ1aY92VYFjPy9o7CPHAK5M30rro9eOjsQvzGv5Eq9PeEeb5RV6M3Q
 oi7bdFNY3+KVoOnU5W//LhHBsMOg4KzWfwBcYBrqjvLBGO1T/G0wNvpcSTc36rCiQ4f+1NUHkBD
 mctO55lBv+DuFUA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 3AC034BBB83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21380-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: Chuck Lever <chuck.lever@oracle.com>

The TLS connect path has a use-after-free: nothing pins the
upper rpc_clnt across the delayed connect_worker. xs_connect()
stores task->tk_client in sock_xprt::clnt as a raw pointer
and queues the worker; for TLS-secured transports that worker
is xs_tcp_tls_setup_socket(), which reads several fields out
of the saved pointer (cl_timeout, cl_program, cl_prog,
cl_vers, cl_cred, cl_stats) to construct the args for the
inner handshake rpc_clnt.

The xprt does not reference the rpc_clnt; the rpc_clnt
references the xprt. xs_destroy() does cancel the
connect_worker, but it runs only when the xprt's refcount
drops to zero, which cannot happen until the rpc_clnt
releases its cl_xprt reference in rpc_free_client_work().
When a TLS handshake fails fatally (for example, an mTLS
mount whose client cert does not match the server), the
connecting task is woken with -EACCES and exits, the mount
caller invokes rpc_shutdown_client(), and the upper rpc_clnt
is freed before the queued connect_worker fires.
xs_tcp_tls_setup_socket() then dereferences the freed clnt,
producing the refcount_t underflow Michael Nemanov reported.

Take a reference on the upper rpc_clnt in xs_connect() for
TLS transports via a new rpc_hold_client() helper, and drop
it in the connect_worker's exit path with rpc_release_client().
The xprt_lock_connect() / xprt_unlock_connect() pairing
already serialises xs_connect() with xs_tcp_tls_setup_socket(),
so the take and release are balanced one-for-one.

The non-TLS connect worker (xs_tcp_setup_socket) never reads
sock_xprt::clnt, so leave that path alone and avoid the
clnt-holds-xprt-holds-clnt cycle that would otherwise prevent
xprt destruction.

Reported-by: Michael Nemanov <michael.nemanov@vastdata.com>
Closes: https://lore.kernel.org/linux-nfs/40e3d522-dfcf-4fc1-9c55-b5e81f1536d5@vastdata.com/
Fixes: 75eb6af7acdf ("SUNRPC: Add a TCP-with-TLS RPC transport class")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/clnt.h |  1 +
 net/sunrpc/clnt.c           | 19 +++++++++++++++++--
 net/sunrpc/xprtsock.c       | 11 ++++++++++-
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index f8b406b0a1af..3c2b8c355ab3 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -190,6 +190,7 @@ int		rpc_switch_client_transport(struct rpc_clnt *,
 				const struct rpc_timeout *);
 
 void		rpc_shutdown_client(struct rpc_clnt *);
+void		rpc_hold_client(struct rpc_clnt *);
 void		rpc_release_client(struct rpc_clnt *);
 void		rpc_task_release_transport(struct rpc_task *);
 void		rpc_task_release_client(struct rpc_task *);
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index bc8ca470718b..efa26899bc7d 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1026,8 +1026,23 @@ rpc_free_auth(struct rpc_clnt *clnt)
 	return NULL;
 }
 
-/*
- * Release reference to the RPC client
+/**
+ * rpc_hold_client - acquire a reference on an rpc_clnt
+ * @clnt: rpc_clnt to pin
+ *
+ * Pairs with rpc_release_client().
+ */
+void rpc_hold_client(struct rpc_clnt *clnt)
+{
+	refcount_inc(&clnt->cl_count);
+}
+
+/**
+ * rpc_release_client - release a reference on an rpc_clnt
+ * @clnt: rpc_clnt to release
+ *
+ * Pairs with rpc_hold_client(). The rpc_clnt's resources are
+ * freed once its reference count drops to zero.
  */
 void
 rpc_release_client(struct rpc_clnt *clnt)
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 3eccd4923e6c..359407aae03e 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2761,6 +2761,7 @@ static void xs_tcp_tls_setup_socket(struct work_struct *work)
 out_unlock:
 	current_restore_flags(pflags, PF_MEMALLOC);
 	upper_transport->clnt = NULL;
+	rpc_release_client(upper_clnt);
 	xprt_unlock_connect(upper_xprt, upper_transport);
 	return;
 
@@ -2808,7 +2809,15 @@ static void xs_connect(struct rpc_xprt *xprt, struct rpc_task *task)
 	} else
 		dprintk("RPC:       xs_connect scheduled xprt %p\n", xprt);
 
-	transport->clnt = task->tk_client;
+	/*
+	 * Only the TLS connect_worker reads transport->clnt; pinning
+	 * the upper rpc_clnt unconditionally would form a cycle with
+	 * cl_xprt and prevent xprt destruction.
+	 */
+	if (xprt->xprtsec.policy != RPC_XPRTSEC_NONE) {
+		rpc_hold_client(task->tk_client);
+		transport->clnt = task->tk_client;
+	}
 	queue_delayed_work(xprtiod_workqueue,
 			&transport->connect_worker,
 			delay);

-- 
2.53.0


