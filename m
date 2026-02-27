Return-Path: <linux-nfs+bounces-19412-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHFAO3SmoWmivQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19412-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:13:08 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5670F1B8861
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D980A30ADA7E
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 14:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC475413223;
	Fri, 27 Feb 2026 14:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efiBeR//"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B2040FD92
	for <linux-nfs@vger.kernel.org>; Fri, 27 Feb 2026 14:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201040; cv=none; b=j2zLfYB3dMQMi0dfpnVSCB4v6xttVoK87jOT59lN23syU1dTGUec0Xls00G7CxFZXTMDWAG88cDXBk3ATFJiOCFMOzdgRhJT17YE7b+xCh0fduPre4jVU0rHgKp9HaJuSQVpoGqqaDzHqVAZ443zxGH/hKcIlOhutUhRuzZysnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201040; c=relaxed/simple;
	bh=gT1HgOWbisJIjF0BDskA17IJE2+tg+5+UY6fuygjobI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vks4CsHydVsTNAH3i5pN++E1DIIqxBNZSJoNtxu7cqtX2Q46zEXR36CM3pzmxpD3aUu7JGdiFjELY/4/SSA33cCAH8GIvxvs/b2gVC+GhWx8+pwvZcO1A/42ndD7f2nGJQgAgqs36r6r7b+FupjyxUccl8/Qlx2u8MGTH615uqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efiBeR//; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EDB9C19423;
	Fri, 27 Feb 2026 14:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772201040;
	bh=gT1HgOWbisJIjF0BDskA17IJE2+tg+5+UY6fuygjobI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=efiBeR//zq3LC8DgmDtawJsBbN1plzJb2MRA/tZkPZbr+XmiH2DLOtlKLQjd7alfQ
	 Nw76Jkag65JyPs4EGxlOc7kl1IMZ+4Iof7FVbSP1kL5qVv2avNmQEzpXAQveK3qYbz
	 zDZM9Z9g7b3JJOmgNq+rzqL0HdOn7xB57ZHu3yU3MArTy+owrXNLf0tYOz6NEGUOl3
	 WNRFkk6B7XfxC1LUr7Vo+PllaU9mgY5nbrPy7BboU/Mied7lpVU4qC4hqsk5DxNVtI
	 uW25r8WLMUQIA+VE7OtmPXnlKX0ONZ7Fnstqi5xCD2RIgS0mqK/JFZ5WDm5IUIZQsn
	 c5kWBW3tjqfWg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 15/18] svcrdma: clear XPT_DATA on sc_rq_dto_q consumption
Date: Fri, 27 Feb 2026 09:03:42 -0500
Message-ID: <20260227140345.40488-16-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19412-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 5670F1B8861
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

svc_rdma_wc_receive() sets XPT_DATA when adding a
completed Receive to sc_rq_dto_q. When
svc_rdma_recvfrom() consumes the item from sc_rq_dto_q,
XPT_DATA is left set. The subsequent svc_xprt_received()
clears XPT_BUSY and re-enqueues the transport; because
stale XPT_DATA remains set, svc_xprt_enqueue() dispatches
a second thread. That thread finds both queues empty,
accomplishes nothing, and returns zero.

Trace data from a 256KB NFSv3 workload over RDMA shows
172,280 of 467,171 transport dequeues (36.9%) are these
spurious dispatches. The READ phase averages 1.99
dequeues per RPC (expected 1.0) and the WRITE phase
averages 2.77 (expected 2.0). Each wasted cycle traverses
svc_alloc_arg, svc_thread_wait_for_work,
svc_rdma_recvfrom, and svc_xprt_release before the
thread can accept new work.

Add svc_rdma_update_xpt_data() on the sc_rq_dto_q
success path, matching the existing call on the
sc_read_complete_q path added by commit 6807f36a39b7
("svcrdma: clear XPT_DATA on sc_read_complete_q
consumption"). The same barrier semantics apply: the
clear/recheck pattern in svc_rdma_update_xpt_data()
ensures a concurrent producer's llist_add + set_bit
is not lost.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index d274b03b1958..79e9ca9f44dc 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -994,6 +994,7 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 	node = llist_del_first(&rdma_xprt->sc_rq_dto_q);
 	if (node) {
 		ctxt = llist_entry(node, struct svc_rdma_recv_ctxt, rc_node);
+		svc_rdma_update_xpt_data(rdma_xprt);
 	} else {
 		ctxt = NULL;
 		svc_rdma_update_xpt_data(rdma_xprt);
-- 
2.53.0


