Return-Path: <linux-nfs+bounces-19411-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPV1HjyroWm1vQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19411-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:33:32 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 811BE1B9070
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3B5B0309C79D
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 14:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060D643CEEC;
	Fri, 27 Feb 2026 14:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yx8PR+gv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B3140FD92
	for <linux-nfs@vger.kernel.org>; Fri, 27 Feb 2026 14:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201039; cv=none; b=HM7g0EhCab4BKQkCK257EzRaQi/oJ1ENoRiSqesgnhRj/2FpmPd4I1lcrLVmQLmQfzaYuD4ocn6YWlzfVE5P2fW4qT3em7knLbQeL0QiscjDJsmP/eyXSw5fDzqrfQRTCaFDRWQaQmtdXDj2C3pLG4i7q/I5jBD1AXTG262zX1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201039; c=relaxed/simple;
	bh=oQJW6DJI/TAKkS8Y/Y5RwwGEtikvpCEVvtBBaV1iRgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPQnxdUlGTqp2mSlrRgBqdnFr2f+g9pRgIRl7AMvChgUamq2ZmHZ+Bepdoa/VkgTF33kaTrpYqaBQqo2jMYWedn7qc7xv2N0jWM5f6AxEBirasMC9/1FhqjWHh5SU4RHGLdNH/sV/EnyUC6daK6gojRzrBpgGod3ms29jPWRDVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yx8PR+gv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB542C116C6;
	Fri, 27 Feb 2026 14:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772201039;
	bh=oQJW6DJI/TAKkS8Y/Y5RwwGEtikvpCEVvtBBaV1iRgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yx8PR+gv2xuklXEYWE+D0kyz2wq+86RnR4D3p6dfsvQhU+YJRzBVdodAQhq2lH6/5
	 iK+ZbvQSEMAc2s1DT/a0gAKv3mpFsdPXeuFShpc0keiq6bM/NtXF/mEpI1YSeCeybS
	 I1kOshwd7GrfK8g6GMSLGa/D8RCN/69GJg9kd6ctMYO509hZKQevb5RvSyxIz0ZrjI
	 0vSs3rMkcQBWFOHuwEds0i5tFOrKtMx+G8QwYLsH4ZQ6HyJVq62r2fh3fg0NofCRqb
	 lSmCFw9j2q1jgtxCnTK3GbX0XDCYSDlz0gKWq4rikr3aShIMXlrwJRjC5izlhwFX8J
	 dfOKTqenan9Gg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 14/18] svcrdma: retry when receive queues drain transiently
Date: Fri, 27 Feb 2026 09:03:41 -0500
Message-ID: <20260227140345.40488-15-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227140345.40488-1-cel@kernel.org>
References: <20260227140345.40488-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19411-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 811BE1B9070
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

When svc_rdma_recvfrom finds both sc_read_complete_q
and sc_rq_dto_q empty, svc_rdma_update_xpt_data clears
XPT_DATA, executes a barrier, and rechecks the queues.
If a completion arrived between the llist_del_first and
the recheck, XPT_DATA is re-set, but recvfrom returns
zero regardless. The thread then traverses the full
svc_recv cycle -- page allocation, dequeue, recvfrom,
release -- only to find the item that was already
available at the time of the recheck.

Trace data from a 256KB NFSv3 workload over RDMA shows
267,848 of 464,355 transport dequeues (57.7%) are these
empty bounces. Each bounce costs roughly 37 us. During
the READ phase, empty bounces consume 8.6% of thread
capacity and inflate inter-RPC gaps by an average of
87 us.

The calling thread holds XPT_BUSY for the duration, so
no other consumer can drain the queue between the
recheck and the retry. A retry is therefore guaranteed
to find data on its first iteration.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 54545fcd8762..d274b03b1958 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -981,6 +981,7 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 
 	rqstp->rq_xprt_ctxt = NULL;
 
+retry:
 	node = llist_del_first(&rdma_xprt->sc_read_complete_q);
 	if (node) {
 		ctxt = llist_entry(node, struct svc_rdma_recv_ctxt, rc_node);
@@ -995,8 +996,19 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 		ctxt = llist_entry(node, struct svc_rdma_recv_ctxt, rc_node);
 	} else {
 		ctxt = NULL;
-		/* No new incoming requests, terminate the loop */
 		svc_rdma_update_xpt_data(rdma_xprt);
+		/*
+		 * A completion may have arrived between the
+		 * llist_del_first above and the queue recheck
+		 * inside svc_rdma_update_xpt_data. This thread
+		 * holds XPT_BUSY, preventing any other consumer
+		 * from draining the queue in the meantime.
+		 * Retry at most once to avoid a full svc_recv
+		 * round-trip: the second iteration is guaranteed
+		 * to find data or clear XPT_DATA.
+		 */
+		if (test_bit(XPT_DATA, &xprt->xpt_flags))
+			goto retry;
 	}
 
 	/* Unblock the transport for the next receive */
-- 
2.53.0


