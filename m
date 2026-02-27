Return-Path: <linux-nfs+bounces-19406-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FQSGkanoWmivQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19406-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:16:38 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B651B89CE
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 56299308CA83
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 14:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A33C423153;
	Fri, 27 Feb 2026 14:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9JIH2lZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BE128A72B
	for <linux-nfs@vger.kernel.org>; Fri, 27 Feb 2026 14:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201035; cv=none; b=PAAHnKtGu5uYHr+xKcvetSvvzv+P038ShwMiGFiQu1bAQbJ+4gO+PQ9YJjQuCJkqEvdaVZeBl94MoqfStFhzarA/Wrp9pgiraAh61BNfJ31bhQZQefFsjyP2cTo5HtZyA+7gfhOaaWD+nysWwO7z6R06wje4AnqBgl5ig+PuiWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201035; c=relaxed/simple;
	bh=P5ZxDrstuP9D4oXfKob9Qoe/tvGwS4BwkJZTfPhTw60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6KTbSqn9/G+VWhRs9+YSGIoaVLEtDYVFpv+um0LOYpuscZTdjnfEiKh1vdrFs7fVj32i1CecYAX5IcWpdyeOv5T0+L+YMzbaLSxJXSMfpZuV25YcacwjN0UFVk/At2q5C60bGoMHOLA5Xxyuo3x0JEAEbQQDCFOO79iaGbugvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9JIH2lZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B183EC116C6;
	Fri, 27 Feb 2026 14:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772201035;
	bh=P5ZxDrstuP9D4oXfKob9Qoe/tvGwS4BwkJZTfPhTw60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e9JIH2lZPVx09mpfbuxrbGVpRvLd6dfSl2mUtR3aSwy0Pl1sag+TPaS3zE141hEcX
	 SXjnhgufKe4bLHkUib6dO6K6FsEuxN/P+tNyYqOx5isoCyp1qerW/pb01rx8/GwYrE
	 +/YKQfhZCWls54a6KwUlGOW5CID1FivenzR4zk5S0lA/HEHXusWCwqcF3o7JOlGhLP
	 Qic5/lzsEQKhl8Xxtjo2s4+s6H3UkxGMove2KNIOyF+qPCASVUXIdmFDQR8ToFWcXU
	 20L3YZ67vANmikwN8PqZeE0Al/dk7ikSLO1ZPZxYlcW2iFiftxIJJoBKjf31vDXNbg
	 c5E1YkGtpSDEg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 09/18] svcrdma: Release write chunk resources without re-queuing
Date: Fri, 27 Feb 2026 09:03:36 -0500
Message-ID: <20260227140345.40488-10-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19406-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 22B651B89CE
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Each RDMA Send completion triggers a cascade of work items on the
svcrdma_wq unbound workqueue:

  ib_cq_poll_work (on ib_comp_wq, per-CPU)
    -> svc_rdma_send_ctxt_put -> queue_work    [work item 1]
      -> svc_rdma_write_info_free -> queue_work [work item 2]

Every transition through queue_work contends on the unbound
pool's spinlock. Profiling an 8KB NFSv3 read/write workload
over RDMA shows about 4% of total CPU cycles spent on this
lock, with the cascading re-queue of write_info release
contributing roughly 1%.

The initial queue_work in svc_rdma_send_ctxt_put is needed to
move release work off the CQ completion context (which runs on
a per-CPU bound workqueue). However, once executing on
svcrdma_wq, there is no need to re-queue for each write_info
structure. svc_rdma_reply_chunk_release already calls
svc_rdma_cc_release inline, confirming these operations are
safe in workqueue and nfsd thread context alike.

Release write chunk resources inline in
svc_rdma_write_info_free, removing the intermediate
svc_rdma_write_info_free_async work item and the wi_work
field from struct svc_rdma_write_info.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h   |  1 -
 net/sunrpc/xprtrdma/svc_rdma_rw.c | 13 ++-----------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 8f6483ed9e5f..a2d3232593a2 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -252,7 +252,6 @@ struct svc_rdma_write_info {
 	unsigned int		wi_next_off;
 
 	struct svc_rdma_chunk_ctxt	wi_cc;
-	struct work_struct	wi_work;
 };
 
 struct svc_rdma_send_ctxt {
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 554463c72f1f..3c18b1ab1d35 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -236,19 +236,10 @@ svc_rdma_write_info_alloc(struct svcxprt_rdma *rdma,
 	return info;
 }
 
-static void svc_rdma_write_info_free_async(struct work_struct *work)
-{
-	struct svc_rdma_write_info *info;
-
-	info = container_of(work, struct svc_rdma_write_info, wi_work);
-	svc_rdma_cc_release(info->wi_rdma, &info->wi_cc, DMA_TO_DEVICE);
-	kfree(info);
-}
-
 static void svc_rdma_write_info_free(struct svc_rdma_write_info *info)
 {
-	INIT_WORK(&info->wi_work, svc_rdma_write_info_free_async);
-	queue_work(svcrdma_wq, &info->wi_work);
+	svc_rdma_cc_release(info->wi_rdma, &info->wi_cc, DMA_TO_DEVICE);
+	kfree(info);
 }
 
 /**
-- 
2.53.0


