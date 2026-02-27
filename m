Return-Path: <linux-nfs+bounces-19400-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNQqM0qmoWmivQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19400-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:12:26 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F57F1B87FE
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4FE0030DD9A8
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 14:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D8028D8DB;
	Fri, 27 Feb 2026 14:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yac5Bgwf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92409274FD0
	for <linux-nfs@vger.kernel.org>; Fri, 27 Feb 2026 14:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201030; cv=none; b=IHSGex+zRTWl4TJjh871K1oPuKjhHOjTuWANpqtGgkhHsVU2fqCCty7RVHlnBvRXMRufcIYsbk6pp5ItjHFsjyo1bygtgAA/jp4LURy+vydu9ZwmNQ3Aq4qPClwnM9PtUVhnfrANGmIEMFlyLzkJ9LGEwmCykD4LGTZtRzrBxVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201030; c=relaxed/simple;
	bh=4IroLFjyMngnG+rnW2Y7BytfOCiilFOqBkRJC2sQK1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGbcRsX3P4lXBw77DJ44B29LrHEp7RMJrjiGKqLvz8bwvGUPDUZH72ktAwBq7GmkN/THBNU7BGXR32pjoIMf4/7j84u9PJtuJopg6nvlW9t+65uz/Oz4Q9oXqc8jEfIyc2Vg9Z3qYEVm+CmNw3LhsPBGTdJawv1M9AyI4Gra2d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yac5Bgwf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57E9C116C6;
	Fri, 27 Feb 2026 14:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772201030;
	bh=4IroLFjyMngnG+rnW2Y7BytfOCiilFOqBkRJC2sQK1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yac5Bgwfl5c+xqhPavXgX5cKTrCxRumgeUBRybIzDQjA+ZO6ew7C2ZvhcDsZl8tCz
	 xJND7LZuiQeI6iNWU07cMTSAowr9nbeA8cPCEfEl6d2EH/tGlALOKhlJ0kBltwOYgP
	 BfbnUj1KWTzhZVzlb+PHNwhf7Im28pe2TF6F78MBMWMWVYUqXTCeiYag4tTvXd8gK0
	 ZkmE0DnSYWSn2Nqgng0CfcdIWLv9NdEUsYzc/z/CAAw1lxLPHtWHkU19KuxDfXolcF
	 nEUQASYx129FzLSg/4UT4UpXe2Plu6ivvzyXBB2WUXoLca9o6XZVxbIBUgiuN4+9cn
	 rjPryAdJWDxHA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 03/18] svcrdma: Clean up use of rdma->sc_pd->device
Date: Fri, 27 Feb 2026 09:03:30 -0500
Message-ID: <20260227140345.40488-4-cel@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-19400-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 5F57F1B87FE
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

I can't think of a reason why svcrdma is using the PD's device. Most
other consumers of the IB DMA API use the ib_device pointer from the
connection's rdma_cm_id.

I don't think there's any functional difference between the two, but
it is a little confusing to see some uses of rdma_cm_id and some of
ib_pd.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_sendto.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 22354e12d390..4fff03b96b84 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -116,7 +116,8 @@ static void svc_rdma_wc_send(struct ib_cq *cq, struct ib_wc *wc);
 static struct svc_rdma_send_ctxt *
 svc_rdma_send_ctxt_alloc(struct svcxprt_rdma *rdma)
 {
-	int node = ibdev_to_node(rdma->sc_cm_id->device);
+	struct ib_device *device = rdma->sc_cm_id->device;
+	int node = ibdev_to_node(device);
 	struct svc_rdma_send_ctxt *ctxt;
 	unsigned long pages;
 	dma_addr_t addr;
@@ -136,9 +137,9 @@ svc_rdma_send_ctxt_alloc(struct svcxprt_rdma *rdma)
 	buffer = kmalloc_node(rdma->sc_max_req_size, GFP_KERNEL, node);
 	if (!buffer)
 		goto fail2;
-	addr = ib_dma_map_single(rdma->sc_pd->device, buffer,
-				 rdma->sc_max_req_size, DMA_TO_DEVICE);
-	if (ib_dma_mapping_error(rdma->sc_pd->device, addr))
+	addr = ib_dma_map_single(device, buffer, rdma->sc_max_req_size,
+				 DMA_TO_DEVICE);
+	if (ib_dma_mapping_error(device, addr))
 		goto fail3;
 
 	svc_rdma_send_cid_init(rdma, &ctxt->sc_cid);
@@ -175,15 +176,14 @@ svc_rdma_send_ctxt_alloc(struct svcxprt_rdma *rdma)
  */
 void svc_rdma_send_ctxts_destroy(struct svcxprt_rdma *rdma)
 {
+	struct ib_device *device = rdma->sc_cm_id->device;
 	struct svc_rdma_send_ctxt *ctxt;
 	struct llist_node *node;
 
 	while ((node = llist_del_first(&rdma->sc_send_ctxts)) != NULL) {
 		ctxt = llist_entry(node, struct svc_rdma_send_ctxt, sc_node);
-		ib_dma_unmap_single(rdma->sc_pd->device,
-				    ctxt->sc_sges[0].addr,
-				    rdma->sc_max_req_size,
-				    DMA_TO_DEVICE);
+		ib_dma_unmap_single(device, ctxt->sc_sges[0].addr,
+				    rdma->sc_max_req_size, DMA_TO_DEVICE);
 		kfree(ctxt->sc_xprt_buf);
 		kfree(ctxt->sc_pages);
 		kfree(ctxt);
@@ -463,7 +463,7 @@ int svc_rdma_post_send(struct svcxprt_rdma *rdma,
 	might_sleep();
 
 	/* Sync the transport header buffer */
-	ib_dma_sync_single_for_device(rdma->sc_pd->device,
+	ib_dma_sync_single_for_device(rdma->sc_cm_id->device,
 				      send_wr->sg_list[0].addr,
 				      send_wr->sg_list[0].length,
 				      DMA_TO_DEVICE);
-- 
2.53.0


