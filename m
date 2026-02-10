Return-Path: <linux-nfs+bounces-18840-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBHsIeJai2ljUAAAu9opvQ
	(envelope-from <linux-nfs+bounces-18840-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:20:50 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 320D411D109
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 430A0304226B
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 16:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE8E2E7BCC;
	Tue, 10 Feb 2026 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xwm6gDju"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A7B2ED141
	for <linux-nfs@vger.kernel.org>; Tue, 10 Feb 2026 16:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770740434; cv=none; b=EOQIdjrERCzx15dWFcFLAapkLMKC8q+0p9op7IxhqP5ZDG9ZYOsLOL/xE/j+RDa1VNvYD4VFy1KVBNnXhMmOQ+m2gIzEViNb8xSfthq5VoHsGIYAc/v6hfiaNbqNmR4+Vsjw3CytUqKmRGSfeV4VVNzFCuw7JdynkO+ehZR/I6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770740434; c=relaxed/simple;
	bh=cVvU9CbYMQEVPhUIpiVBo3S6C+Xm6J0l+/xwJ7quUiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o6UUrfKzAYqI3AkDRoq/28TEo2Qe+iHwUT5eSUhI9qeiU9MD4o/CjuASIFyO2M6clC/RIXNkGZukIUtZNJigrAhvbBKa1f/6HD5LVgRQKQ5234FYUjig+i+13AVL82uufL2/SIcljjLT7JtRDVmgWy8MneeP115imbV+oKReVuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xwm6gDju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47752C19421;
	Tue, 10 Feb 2026 16:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770740433;
	bh=cVvU9CbYMQEVPhUIpiVBo3S6C+Xm6J0l+/xwJ7quUiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xwm6gDjuYMM39Lbhzy+1IzUtOTnGebpIPIRcjf36/xeTEMY92rwzGwA0c8jSSr8e6
	 c8vP28mVQoSyU3SlyDLsvUQ0m9mYyspV2O2wzTTFUiRaSxVsccug8zUG8QyRLfXc0n
	 voytOFpxLXy3Z9QN6jLI2oJ8lwXmR538YVaZPK/ntRB6XTnErTKoNUtQjpgjicMehh
	 4/SrKp+sZQbef5YI/VO3MTB1+ggs1dMrQM883klxQiHrSsxsAd9l4qzUDrhxObJc8d
	 oQ4FoeBMuv9NCnr5LoiJSZmrq6W7G15clgOISCs4jphaomUmsiQeMKsuLpJCDEY9Z9
	 rfzxeXsFOTtAw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 7/8] sunrpc: unify fore and backchannel server TCP send paths
Date: Tue, 10 Feb 2026 11:20:24 -0500
Message-ID: <20260210162025.2356389-8-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260210162025.2356389-1-cel@kernel.org>
References: <20260210162025.2356389-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	TAGGED_FROM(0.00)[bounces-18840-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 320D411D109
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

High latency in callback processing for NFSv4.1+ sessions can occur
when the fore channel sustains heavy request traffic. The backchannel
implementation acquires xpt_mutex directly while the fore channel
uses flat combining to batch socket operations. A thread in the
combining loop processes queued sends continuously until the llist
empties, which under load means backchannel threads block on xpt_mutex
for extended periods waiting for a turn at the socket. Delegation
recalls and other callback operations carry time constraints that
make this starvation problematic.

Routing backchannel sends through the same flat combining
infrastructure eliminates this starvation; a shared llist queue
replaces direct mutex acquisition and separate code paths. The
struct svc_pending_send now holds an xdr_buf pointer instead of
svc_rqst, decoupling the queueing mechanism from RPC request
structures. A new svc_tcp_send() function accepts an xprt, xdr_buf,
and marker, then either enters the combining loop or enqueues for
processing by an active combiner.

The fore channel path through svc_tcp_sendto() now calls
svc_tcp_send() after preparing its xdr_buf. The backchannel
bc_send_request() similarly calls svc_tcp_send() in place of its
former mutex acquisition and direct bc_sendto() invocation. Both
channels queue into the same llist, so backchannel operations
receive fair treatment in the send ordering. When a backchannel
send queues behind fore channel traffic, the combining loop
processes both together with shared socket lock acquisition and
MSG_MORE coalescing where applicable.

Maintenance burden decreases with a single code path for TCP sends.
The backchannel gains batching benefits when concurrent with fore
channel load, and starvation no longer occurs because queueing
provides deterministic ordering independent of mutex contention
timing.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svcsock.h |  2 +
 net/sunrpc/svcsock.c           | 76 +++++++++++++++++++++++++---------
 net/sunrpc/xprtsock.c          | 60 ++++++---------------------
 3 files changed, 71 insertions(+), 67 deletions(-)

diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
index fae760eaa9f7..07619bf2131c 100644
--- a/include/linux/sunrpc/svcsock.h
+++ b/include/linux/sunrpc/svcsock.h
@@ -101,6 +101,8 @@ static inline u32 svc_sock_final_rec(struct svc_sock *svsk)
  */
 void		svc_recv(struct svc_rqst *rqstp);
 void		svc_send(struct svc_rqst *rqstp);
+int		svc_tcp_send(struct svc_xprt *xprt, struct xdr_buf *xdr,
+			     rpc_fraghdr marker);
 int		svc_addsock(struct svc_serv *serv, struct net *net,
 			    const int fd, char *name_return, const size_t len,
 			    const struct cred *cred);
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index e3fa81b63191..8b2e9f524506 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1683,13 +1683,13 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
  */
 struct svc_pending_send {
 	struct llist_node	node;
-	struct svc_rqst		*rqstp;
+	struct xdr_buf		*xdr;
 	rpc_fraghdr		marker;
 	struct completion	done;
 	int			result;
 };
 
-static int svc_tcp_sendmsg(struct svc_sock *svsk, struct svc_rqst *rqstp,
+static int svc_tcp_sendmsg(struct svc_sock *svsk, struct xdr_buf *xdr,
 			   rpc_fraghdr marker);
 
 /*
@@ -1750,6 +1750,8 @@ static void svc_tcp_combine_sends(struct svc_sock *svsk, struct svc_xprt *xprt)
 	start = ktime_get_ns();
 
 	for (node = pending; node; node = next) {
+		size_t expected;
+
 		next = node->next;
 		ps = container_of(node, struct svc_pending_send, node);
 
@@ -1760,16 +1762,29 @@ static void svc_tcp_combine_sends(struct svc_sock *svsk, struct svc_xprt *xprt)
 			continue;
 		}
 
-		sent = svc_tcp_sendmsg(svsk, ps->rqstp, ps->marker);
+		sent = svc_tcp_sendmsg(svsk, ps->xdr, ps->marker);
 		trace_svcsock_tcp_send(xprt, sent);
 
-		if (sent == ps->rqstp->rq_res.len + sizeof(ps->marker)) {
+		expected = ps->xdr->len + sizeof(ps->marker);
+		if (sent == expected) {
 			ps->result = sent;
 		} else {
 			pr_notice("rpc-srv/tcp: %s: %s (%d of %zu bytes) - shutting down socket\n",
 				  xprt->xpt_server->sv_name,
-				  sent < 0 ? "send error" : "short send", sent,
-				  ps->rqstp->rq_res.len + sizeof(ps->marker));
+				  sent < 0 ? "send error" : "short send",
+				  sent, expected);
+			pr_notice("rpc-srv/tcp: %s: %s (%d of %zu bytes) - shutting down socket\n",
+				  xprt->xpt_server->sv_name,
+				  sent < 0 ? "send error" : "short send",
+				  sent, expected);
+			pr_notice("rpc-srv/tcp: %s: %s (%d of %zu bytes) - shutting down socket\n",
+				  xprt->xpt_server->sv_name,
+				  sent < 0 ? "send error" : "short send",
+				  sent, expected);
+			pr_notice("rpc-srv/tcp: %s: %s (%d of %zu bytes) - shutting down socket\n",
+				  xprt->xpt_server->sv_name,
+				  sent < 0 ? "send error" : "short send",
+				  sent, expected);
 			svc_xprt_deferred_close(xprt);
 			transport_dead = true;
 			ps->result = -EAGAIN;
@@ -1789,7 +1804,7 @@ static void svc_tcp_combine_sends(struct svc_sock *svsk, struct svc_xprt *xprt)
  * copy operations in this path. Therefore the caller must ensure
  * that the pages backing @xdr are unchanging.
  */
-static int svc_tcp_sendmsg(struct svc_sock *svsk, struct svc_rqst *rqstp,
+static int svc_tcp_sendmsg(struct svc_sock *svsk, struct xdr_buf *xdr,
 			   rpc_fraghdr marker)
 {
 	struct msghdr msg = {
@@ -1809,39 +1824,40 @@ static int svc_tcp_sendmsg(struct svc_sock *svsk, struct svc_rqst *rqstp,
 	memcpy(buf, &marker, sizeof(marker));
 	bvec_set_virt(svsk->sk_bvec, buf, sizeof(marker));
 
-	count = xdr_buf_to_bvec(svsk->sk_bvec + 1, rqstp->rq_maxpages,
-				&rqstp->rq_res);
+	count = xdr_buf_to_bvec(svsk->sk_bvec + 1, svsk->sk_maxpages, xdr);
 
 	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, svsk->sk_bvec,
-		      1 + count, sizeof(marker) + rqstp->rq_res.len);
+		      1 + count, sizeof(marker) + xdr->len);
 	ret = sock_sendmsg(svsk->sk_sock, &msg);
 	page_frag_free(buf);
 	return ret;
 }
 
 /**
- * svc_tcp_sendto - Send out a reply on a TCP socket
- * @rqstp: completed svc_rqst
+ * svc_tcp_send - Send an XDR buffer on a TCP socket using flat combining
+ * @xprt: the transport to send on
+ * @xdr: the XDR buffer to send
+ * @marker: RPC record marker
  *
  * Flat combining reduces mutex contention: threads enqueue send
  * requests; a single thread processes the batch while holding xpt_mutex
  * to ensure RPC-level serialization.
  *
+ * Can be used for both fore channel (NFS replies) and backchannel
+ * (NFSv4 callbacks) sends since both share the same TCP connection
+ * and xpt_mutex.
+ *
  * Returns the number of bytes sent, or a negative errno.
  */
-static int svc_tcp_sendto(struct svc_rqst *rqstp)
+int svc_tcp_send(struct svc_xprt *xprt, struct xdr_buf *xdr,
+		 rpc_fraghdr marker)
 {
-	struct svc_xprt *xprt = rqstp->rq_xprt;
 	struct svc_sock *svsk = container_of(xprt, struct svc_sock, sk_xprt);
-	struct xdr_buf *xdr = &rqstp->rq_res;
 	struct svc_pending_send ps = {
-		.rqstp = rqstp,
-		.marker = cpu_to_be32(RPC_LAST_STREAM_FRAGMENT | (u32)xdr->len),
+		.xdr = xdr,
+		.marker = marker,
 	};
 
-	svc_tcp_release_ctxt(xprt, rqstp->rq_xprt_ctxt);
-	rqstp->rq_xprt_ctxt = NULL;
-
 	init_completion(&ps.done);
 
 	/* Enqueue send request; lock-free via llist */
@@ -1886,6 +1902,26 @@ static int svc_tcp_sendto(struct svc_rqst *rqstp)
 
 	return ps.result;
 }
+EXPORT_SYMBOL_GPL(svc_tcp_send);
+
+/**
+ * svc_tcp_sendto - Send out a reply on a TCP socket
+ * @rqstp: completed svc_rqst
+ *
+ * Returns the number of bytes sent, or a negative errno.
+ */
+static int svc_tcp_sendto(struct svc_rqst *rqstp)
+{
+	struct svc_xprt *xprt = rqstp->rq_xprt;
+	struct xdr_buf *xdr = &rqstp->rq_res;
+	rpc_fraghdr marker = cpu_to_be32(RPC_LAST_STREAM_FRAGMENT |
+					 (u32)xdr->len);
+
+	svc_tcp_release_ctxt(xprt, rqstp->rq_xprt_ctxt);
+	rqstp->rq_xprt_ctxt = NULL;
+
+	return svc_tcp_send(xprt, xdr, marker);
+}
 
 static struct svc_xprt *svc_tcp_create(struct svc_serv *serv,
 				       struct net *net,
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 2e1fe6013361..4e1d82186b00 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2979,36 +2979,13 @@ static void bc_free(struct rpc_task *task)
 	free_page((unsigned long)buf);
 }
 
-static int bc_sendto(struct rpc_rqst *req)
-{
-	struct xdr_buf *xdr = &req->rq_snd_buf;
-	struct sock_xprt *transport =
-			container_of(req->rq_xprt, struct sock_xprt, xprt);
-	struct msghdr msg = {
-		.msg_flags	= 0,
-	};
-	rpc_fraghdr marker = cpu_to_be32(RPC_LAST_STREAM_FRAGMENT |
-					 (u32)xdr->len);
-	unsigned int sent = 0;
-	int err;
-
-	req->rq_xtime = ktime_get();
-	err = xdr_alloc_bvec(xdr, rpc_task_gfp_mask());
-	if (err < 0)
-		return err;
-	err = xprt_sock_sendmsg(transport->sock, &msg, xdr, 0, marker, &sent);
-	xdr_free_bvec(xdr);
-	if (err < 0 || sent != (xdr->len + sizeof(marker)))
-		return -EAGAIN;
-	return sent;
-}
-
 /**
  * bc_send_request - Send a backchannel Call on a TCP socket
  * @req: rpc_rqst containing Call message to be sent
  *
- * xpt_mutex ensures @rqstp's whole message is written to the socket
- * without interruption.
+ * Uses flat combining via svc_tcp_send() to participate in batched
+ * sending with fore channel traffic, ensuring fair ordering and
+ * reduced lock contention.
  *
  * Return values:
  *   %0 if the message was sent successfully
@@ -3016,29 +2993,18 @@ static int bc_sendto(struct rpc_rqst *req)
  */
 static int bc_send_request(struct rpc_rqst *req)
 {
-	struct svc_xprt	*xprt;
-	int len;
+	struct xdr_buf *xdr = &req->rq_snd_buf;
+	struct svc_xprt *xprt = req->rq_xprt->bc_xprt;
+	rpc_fraghdr marker = cpu_to_be32(RPC_LAST_STREAM_FRAGMENT |
+					 (u32)xdr->len);
+	int ret;
 
-	/*
-	 * Get the server socket associated with this callback xprt
-	 */
-	xprt = req->rq_xprt->bc_xprt;
+	req->rq_xtime = ktime_get();
+	ret = svc_tcp_send(xprt, xdr, marker);
 
-	/*
-	 * Grab the mutex to serialize data as the connection is shared
-	 * with the fore channel
-	 */
-	mutex_lock(&xprt->xpt_mutex);
-	if (test_bit(XPT_DEAD, &xprt->xpt_flags))
-		len = -ENOTCONN;
-	else
-		len = bc_sendto(req);
-	mutex_unlock(&xprt->xpt_mutex);
-
-	if (len > 0)
-		len = 0;
-
-	return len;
+	if (ret < 0)
+		return ret;
+	return 0;
 }
 
 static void bc_close(struct rpc_xprt *xprt)
-- 
2.52.0


