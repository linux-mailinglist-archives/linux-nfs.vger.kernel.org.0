Return-Path: <linux-nfs+bounces-22313-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 40HFLOoLI2pWhAEAu9opvQ
	(envelope-from <linux-nfs+bounces-22313-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 05 Jun 2026 19:48:26 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BFF64A4DF
	for <lists+linux-nfs@lfdr.de>; Fri, 05 Jun 2026 19:48:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="FFWW/6+O";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22313-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22313-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D7C453054A42
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jun 2026 17:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BEF3A75AC;
	Fri,  5 Jun 2026 17:34:59 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFE037FF4B;
	Fri,  5 Jun 2026 17:34:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680899; cv=none; b=DS/rfpwLXD73wr/u39N02DOOCXQTJdXmAzeK9PgdXQee/Hc4+sVHLcA+TyRlDKVIqDeUs1YUSvS2OXLJKooTkNiZ48Mb0Byc+/NqWKJ7hBWnA1/rV3Rbnwu5pEnPcgFmYDKjlaq51JIbXcms+BFNenqVVR5IX/PCYaQIdJeZFcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680899; c=relaxed/simple;
	bh=H6lhC835yo9sIyeUdcsPfFNN+P3mHjq79WTX7rAcLlk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LEsD8/eKBjTAvwvyX+3dJIWUEuqQiVGB7xdjEQ7+xzeotvFKb75c6xUECz9sVF5/bJ4/noz+htXnr4RjFyluPIx+6bqRXnbHKqQyt3FebGdhmQ32gZORyZ+xTadEH2OSBrWrLUe6hzDDW8mg4ea1QWcfvUCRYpFwwC5IG4n5U1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFWW/6+O; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343001F0089B;
	Fri,  5 Jun 2026 17:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780680895;
	bh=JKfrH+fs08jZaVa8UV/YBO/fCpiBB9pl8CotG+DDB7Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FFWW/6+OmTbv87BuG+bPw1OtU8WBzhRukMx7go1khx2IVyLO3JUfiHvw/FQoKEu/D
	 W6jPj3AlvQ6/LFaPQdutTh6HiRqe3VIUs7ELz3RrvoGl7Iuhwb2ojYAAdS/Asz7tt6
	 LgRLTPSFAp3DLe+CoW0rYWfBxQuXYQ9NPP91vKR8i191E1HFw6wN09cpfK9wVkJ/Ti
	 Yv5XrhsrxkbabXX51QCf6slXR4SoRH+IVG6Lj6pAkYSAKp068uXuibZmxQxTxV9U/q
	 mSdjTLM/cR+S5XZSIgY/g+yugR4tock9vxyYrjtnhg4iBPo+iNuISwYjF6Te/K+MeF
	 7ZSMNQwJwa0PQ==
From: Chuck Lever <cel@kernel.org>
Date: Fri, 05 Jun 2026 13:34:41 -0400
Subject: [PATCH 7/9] SUNRPC: Copy the TLS session tags when they are
 available
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-tls-session-tags-v1-7-47bd1d94d552@oracle.com>
References: <20260605-tls-session-tags-v1-0-47bd1d94d552@oracle.com>
In-Reply-To: <20260605-tls-session-tags-v1-0-47bd1d94d552@oracle.com>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Sabrina Dubroca <sd@queasysnail.net>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=5831;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=SB9lbn4bTXkhbHlINiXFgS4v3fKKam4sDv2d4D8u9PM=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqIwi4ulMmp1e2SiKkRo0g9ukK9t2WRbF9JPx9O
 UzWFV3B9IOJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaiMIuAAKCRAzarMzb2Z/
 lz1KD/48JkJty56ZE1HHJZiRy4/3nkOGLWy2WHC1s72bCdfLWnnrRz98DPAszEovYgSWSaWQbW9
 ZOZeUJW2EreCeY8kmNkHe5lTeMRnFndrxcf7FdaH3uT6ftXFfGtx7b18O8aYM3WPtfNvrOU9kbd
 +LX6MinWvG800rLwLbknjRj2gKWpPIe7k0RRvIaRrBDsosebWYw62lUK6JI0si4iDGlQ6FOSbci
 XwBUa6PxjoEZv6QJ6rv77aFY8YbWWaYGcp4Nnkk9u99Z+fwCBb21T4MgB+SQcJDnywBbUURd42Y
 cUxnC8HFgzIFnNU+Rr1HBWVB2m9ylNLxT/+JKdTwCda1QYZfSWAdlYBemXa90jlEKUZMACYpUQO
 vCb5KN6TmNRtNAQnVqMnkJPlV2rMh+dNP8mzd/GStpa97MU7WxHLca1PqVrxNGxfbcRf7NNFlLt
 58nmLfO+SDUu+kWhPRkcPttEtYJwTiAwZFFFdMZOlZRladQvkDKYmxLYz3mci+m1ZPSq8q9EJeK
 Fd6UYDDFCBZIL0ZVGVUoae00eXSSw1nCaZh+Ngsfmhqb5SvuwPF9ct6U8SyYmSPDuFzfjhGcMMB
 CWQWdHFZP77oVo9Nr0xA+brIN87ztOg9Fa8aPZ8u5UL7A3k1PfZ8/1N+9xC8ZkcFAbJUvsqvfJA
 JxIMurlaPx93p3g==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:donald.hunter@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:akpm@linux-foundation.org,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:kbusch@kernel.org,m:axboe@kernel.dk,m:hch@lst.de,m:sagi@grimberg.me,m:kch@nvidia.com,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:kernel-tls-handshake@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:linux-nfs@vger.kernel.org,m:chuck.lever@oracle.com,m:donaldhunter@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,lwn.net,linuxfoundation.org,linux-foundation.org,queasysnail.net,kernel.dk,lst.de,grimberg.me,nvidia.com,brown.name,oracle.com,talpey.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22313-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oracle.com:mid,oracle.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E6BFF64A4DF

From: Chuck Lever <chuck.lever@oracle.com>

When a server handshake completes successfully, tlshd might provide
a set of TLS session tags. SUNRPC can save these within the svc_xprt;
NFSD can later use them to authorize or reject operations that target
NFS exports that have a similar set of tags associated with them.
A second handshake on the same transport would destroy the saved
tags while other workers read them, so svcauth_tls_accept() now
refuses AUTH_TLS on a transport that already carries a TLS session,
and svc_tcp_handshake() rechecks the session flag under XPT_BUSY to
close the race with a handshake that completes concurrently.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_xprt.h |  2 ++
 net/sunrpc/svc_xprt.c           | 11 ++++++++---
 net/sunrpc/svcauth_unix.c       | 12 ++++++++++++
 net/sunrpc/svcsock.c            | 33 ++++++++++++++++++++++++++++++++-
 4 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
index da2a2531e110..15f678d00876 100644
--- a/include/linux/sunrpc/svc_xprt.h
+++ b/include/linux/sunrpc/svc_xprt.h
@@ -9,6 +9,7 @@
 #define SUNRPC_SVC_XPRT_H
 
 #include <linux/sunrpc/svc.h>
+#include <linux/tagset.h>
 
 struct module;
 
@@ -79,6 +80,7 @@ struct svc_xprt {
 	const struct cred	*xpt_cred;
 	struct rpc_xprt		*xpt_bc_xprt;	/* NFSv4.1 backchannel */
 	struct rpc_xprt_switch	*xpt_bc_xps;	/* NFSv4.1 backchannel */
+	struct tagset		xpt_handshake_tags;	/* TLS session tags */
 };
 
 /* flag bits for xpt_flags */
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 63d1002e63e7..1638fc09db8b 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -168,6 +168,8 @@ static void svc_xprt_free(struct kref *kref)
 	struct svc_xprt *xprt =
 		container_of(kref, struct svc_xprt, xpt_ref);
 	struct module *owner = xprt->xpt_class->xcl_owner;
+
+	tagset_destroy(&xprt->xpt_handshake_tags);
 	if (test_bit(XPT_CACHE_AUTH, &xprt->xpt_flags))
 		svcauth_unix_info_release(xprt);
 	put_cred(xprt->xpt_cred);
@@ -188,9 +190,12 @@ void svc_xprt_put(struct svc_xprt *xprt)
 }
 EXPORT_SYMBOL_GPL(svc_xprt_put);
 
-/*
- * Called by transport drivers to initialize the transport independent
- * portion of the transport instance.
+/**
+ * svc_xprt_init - initialize transport-independent fields of an xprt
+ * @net: Network namespace
+ * @xcl: Transport class
+ * @xprt: Transport to be initialized
+ * @serv: RPC service
  */
 void svc_xprt_init(struct net *net, struct svc_xprt_class *xcl,
 		   struct svc_xprt *xprt, struct svc_serv *serv)
diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
index 64a2658faddb..7a779e773107 100644
--- a/net/sunrpc/svcauth_unix.c
+++ b/net/sunrpc/svcauth_unix.c
@@ -1129,6 +1129,18 @@ svcauth_tls_accept(struct svc_rqst *rqstp)
 		return SVC_DENIED;
 	}
 
+	/*
+	 * AUTH_TLS initiates a handshake. Refuse it on a transport
+	 * that already has a TLS session: a second handshake would
+	 * destroy xpt_handshake_tags. This test can pass before a
+	 * concurrent handshake completes; svc_tcp_handshake()
+	 * rechecks under XPT_BUSY before destroying the tags.
+	 */
+	if (test_bit(XPT_TLS_SESSION, &xprt->xpt_flags)) {
+		rqstp->rq_auth_stat = rpc_autherr_badcred;
+		return SVC_DENIED;
+	}
+
 	/* Signal that mapping to nobody uid/gid is required */
 	cred->cr_uid = INVALID_UID;
 	cred->cr_gid = INVALID_GID;
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index b4ad84910687..cc06ed3075db 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -470,7 +470,18 @@ static void svc_tcp_handshake_done(void *data, int status, key_serial_t peerid,
 	if (!status) {
 		if (peerid != TLS_NO_PEERID)
 			set_bit(XPT_PEER_AUTH, &xprt->xpt_flags);
-		set_bit(XPT_TLS_SESSION, &xprt->xpt_flags);
+		/*
+		 * Leaving XPT_TLS_SESSION clear on copy failure makes
+		 * svc_tcp_handshake() close the connection. The tags
+		 * cannot be recovered later on this transport because
+		 * a second handshake is refused once a session is
+		 * established; a reconnect retries both the handshake
+		 * and the copy.
+		 */
+		if (tagset_copy(&xprt->xpt_handshake_tags, tags, GFP_KERNEL))
+			set_bit(XPT_TLS_SESSION, &xprt->xpt_flags);
+		else
+			pr_warn_ratelimited("svc: failed to copy TLS session tags\n");
 	}
 	clear_bit(XPT_HANDSHAKE, &xprt->xpt_flags);
 	complete_all(&svsk->sk_handshake_done);
@@ -481,6 +492,9 @@ static void svc_tcp_handshake_done(void *data, int status, key_serial_t peerid,
  * svc_tcp_handshake - Perform a transport-layer security handshake
  * @xprt: connected transport endpoint
  *
+ * If the transport already has a TLS session, the handshake request
+ * is declined: a fresh handshake would destroy the saved session
+ * tags.
  */
 static void svc_tcp_handshake(struct svc_xprt *xprt)
 {
@@ -493,8 +507,25 @@ static void svc_tcp_handshake(struct svc_xprt *xprt)
 	};
 	int ret;
 
+	/*
+	 * The XPT_TLS_SESSION test in svcauth_tls_accept() is not
+	 * race-free: a worker can pass it before a concurrent
+	 * handshake completes and raise XPT_HANDSHAKE afterwards.
+	 * XPT_BUSY serializes handshake starts, so this test cannot
+	 * go stale: a set bit here means an established session
+	 * whose tags other workers may be reading. Decline to start
+	 * a handshake that would destroy them.
+	 */
+	if (test_bit(XPT_TLS_SESSION, &xprt->xpt_flags)) {
+		clear_bit(XPT_HANDSHAKE, &xprt->xpt_flags);
+		set_bit(XPT_DATA, &xprt->xpt_flags);
+		svc_xprt_enqueue(xprt);
+		return;
+	}
+
 	trace_svc_tls_upcall(xprt);
 
+	tagset_destroy(&xprt->xpt_handshake_tags);
 	clear_bit(XPT_TLS_SESSION, &xprt->xpt_flags);
 	init_completion(&svsk->sk_handshake_done);
 

-- 
2.54.0


