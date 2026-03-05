Return-Path: <linux-nfs+bounces-19799-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FfnNv2ZqWm7AgEAu9opvQ
	(envelope-from <linux-nfs+bounces-19799-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 15:58:05 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E437213FE0
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 15:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B933031C9D2F
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Mar 2026 14:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703E03AA183;
	Thu,  5 Mar 2026 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PT0DPgiO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7FB3A9DB9;
	Thu,  5 Mar 2026 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772722268; cv=none; b=pB0KvsEnJcRuzLKd6Hpk9SnEUSSz9KDGLNqJZiErc7+up8DRg//MRL+ScxDsBppTA21OvKJAFCYku6sYUDtJzIjS8nk4iCnSecMP7CaklZ2MDSwaAQXGvDTbGjSzGcYYEhy8BnrhLfgPrj3BbHCoIQSCDLf1g3FulPoniczEzIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772722268; c=relaxed/simple;
	bh=rq4BHiiCcabo7gcPdEWEW+x1M5J6IKn6QNtDOWZqR+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTIko3VCzsYyp4sRtf1hKCmOhCL7RPyXoYCWIGviNY1i5f3oKfrYDgCVJD4oLeEqDss6wsN0Kjy712VPj19XYVjADhK46Q8h5nDEy0svh1CLasGX9h47RWxTwEOIIPC5kxugkzt+oA1LmRws9QjXIEICme3pe9du6meFtgyScx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PT0DPgiO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE91C2BC9E;
	Thu,  5 Mar 2026 14:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772722268;
	bh=rq4BHiiCcabo7gcPdEWEW+x1M5J6IKn6QNtDOWZqR+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PT0DPgiO6mTSVTxCQqrErAcTahHho7meC0z7pDd856PFhyYho7fdxywOYk2Qq8k8+
	 zG1WRvpHmeoG3pY4fmNfb1TFP1rmbMa2weBFlnmEc/ZjvRug/bIghMmZX7WM7HK9bn
	 eI18ce7guZDGMivzKKACG49XxvYOQmOmXxoDpLo6zfF7vUVbn7p/rhXgGUUEx7RWYU
	 oYXWqay14Jax3p53BQeVsUFGyKeuTu2v6dRonmfaM7cgT41ZdfBZhnB1E7R6yKLSX4
	 eyef3Mv3DFO3SlAf5slkEBQY2nlZHE35tv97wLc74xXl/rus3CQVlOSioRloFadbiz
	 zgmnpXTxP6vpQ==
From: Chuck Lever <cel@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	<linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Eric Badger <ebadger@purestorage.com>
Subject: [PATCH v2 1/8] xprtrdma: Decrement re_receiving on the early exit paths
Date: Thu,  5 Mar 2026 09:50:56 -0500
Message-ID: <20260305145054.7096-11-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305145054.7096-10-cel@kernel.org>
References: <20260305145054.7096-10-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2769; i=chuck.lever@oracle.com; h=from:subject; bh=DbTWoaOmC5YvD/uexMHeuzEaauOPfSsyhH5uSNXM2Nw=; b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpqZhVaMy/ag2q2q990/xkdywo3Ej4TnZm0fWQs 4ovj2gD3oOJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaamYVQAKCRAzarMzb2Z/ l4wbEACKByQbr1LpSlymm5jD6u6uDhBrJ697xgz1arVGGyevk4aaXn1N8YHOnaPxDNYWOJIQR+b 86l//PaleIYtdHzciMEgJBp09OcbTziNCxTQV8FvjkYHwF+H7xh+8fsDK7S3cP7l4vNSch/CZ53 I/JzJ0d2zpojuK+ZTbCURtACXvyk9xTQ5jCW8BHF4G5dGM2oJd04rpHFMb77M4xm/rmDz+zQZn1 GYSXVhzIkxJfGA+77w863sc91LOmOMNMZrf0e8g5k5fXHOgRmvwhcdyEWPvv2ivkANMwu+jozoA R4H83QhqlxNRTqaYQtGqE5rnG/crE/XgReTgvaadLxQqIEr+Qf/sgklf4YjFi5FHxYxahSBippi w5GsnwrU2SNj4a3qwqicDnaKdZEnBNnWDTc+OludbuQtD12Fl0CNEO4o/pdqJ00cIVN8jSpf4Ax XUOEmOWIFr0sJyhb54M5AmgIqGPcG58ydqvaNh021gN9pstO2yZNqpGNt+hSKFEw3VWLKjuTK13 AzKyTPA7QJ/8RFnQli8iR/gQephz1cvED2Qwclwj/Wz/RYVZMMlmeyq+6XOB1sQh+p4ScSaee3h pCLCKuFDYWivmqjJaUohnxrkoCSKCSuZB13uzYYVeauP4kXq/ZYVOOQmtG7SWcpHOm3pgC/dKFa 4QFQMt1S900eS1A==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5E437213FE0
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
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19799-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,purestorage.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Eric Badger <ebadger@purestorage.com>

In the event that rpcrdma_post_recvs() fails to create a work request
(due to memory allocation failure, say) or otherwise exits early, we
should decrement ep->re_receiving before returning. Otherwise we will
hang in rpcrdma_xprt_drain() as re_receiving will never reach zero and
the completion will never be triggered.

On a system with high memory pressure, this can appear as the following
hung task:

    INFO: task kworker/u385:17:8393 blocked for more than 122 seconds.
          Tainted: G S          E       6.19.0 #3
    "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
    task:kworker/u385:17 state:D stack:0     pid:8393  tgid:8393  ppid:2      task_flags:0x4248060 flags:0x00080000
    Workqueue: xprtiod xprt_autoclose [sunrpc]
    Call Trace:
     <TASK>
     __schedule+0x48b/0x18b0
     ? ib_post_send_mad+0x247/0xae0 [ib_core]
     schedule+0x27/0xf0
     schedule_timeout+0x104/0x110
     __wait_for_common+0x98/0x180
     ? __pfx_schedule_timeout+0x10/0x10
     wait_for_completion+0x24/0x40
     rpcrdma_xprt_disconnect+0x444/0x460 [rpcrdma]
     xprt_rdma_close+0x12/0x40 [rpcrdma]
     xprt_autoclose+0x5f/0x120 [sunrpc]
     process_one_work+0x191/0x3e0
     worker_thread+0x2e3/0x420
     ? __pfx_worker_thread+0x10/0x10
     kthread+0x10d/0x230
     ? __pfx_kthread+0x10/0x10
     ret_from_fork+0x273/0x2b0
     ? __pfx_kthread+0x10/0x10
     ret_from_fork_asm+0x1a/0x30

Fixes: 15788d1d1077 ("xprtrdma: Do not refresh Receive Queue while it is draining")
Signed-off-by: Eric Badger <ebadger@purestorage.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 15bbf953dfad..b51a162885bb 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1362,7 +1362,7 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed)
 	needed += RPCRDMA_MAX_RECV_BATCH;
 
 	if (atomic_inc_return(&ep->re_receiving) > 1)
-		goto out;
+		goto out_dec;
 
 	/* fast path: all needed reps can be found on the free list */
 	wr = NULL;
@@ -1385,7 +1385,7 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed)
 		++count;
 	}
 	if (!wr)
-		goto out;
+		goto out_dec;
 
 	rc = ib_post_recv(ep->re_id->qp, wr,
 			  (const struct ib_recv_wr **)&bad_wr);
@@ -1400,9 +1400,10 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed)
 			--count;
 		}
 	}
+
+out_dec:
 	if (atomic_dec_return(&ep->re_receiving) > 0)
 		complete(&ep->re_done);
-
 out:
 	trace_xprtrdma_post_recvs(r_xprt, count);
 	ep->re_receive_count += count;
-- 
2.53.0


