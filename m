Return-Path: <linux-nfs+bounces-18845-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEV7Is9di2mYUAAAu9opvQ
	(envelope-from <linux-nfs+bounces-18845-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:33:19 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B6B11D3BE
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFDCD303CA6B
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 16:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53F930C626;
	Tue, 10 Feb 2026 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTZODGHm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFCA2D0607;
	Tue, 10 Feb 2026 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770741148; cv=none; b=sGGXFIxKOYI2Vy4EpL928WJam8W9UvuRjb+TuupUaIPsUUB0YdPDg/lgZBRaG3Klk0GatkwnMg0jNwsu7rzE5zT05m9lJSeglTVki14ZCW00EtAV5V16Vv5MQpGLL+oUzWMiYXp30XnZNxBxzCiZaDmKnmfPHIQTASVRGY10HnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770741148; c=relaxed/simple;
	bh=du9ImbiBDVLUmdoxx+RJgA96dkv9t9BRiJs4H3C3V+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HfiCE+fNSGSSfOe2RFEDChPjbIDnSepCcNkmHpWUbkAYt5Z6h7gVQXcCnZS4MPY2xLQkZqE6o6Og98u1Q2zXYWCea7R455StZ55ZPixpldYQ46WBZbNngPWcu+Jhvmd8iQy1gmf3A8fCjB4DsmbdTy3xJKEV5+MdP8OeDzfDSDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTZODGHm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE5AC116C6;
	Tue, 10 Feb 2026 16:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770741148;
	bh=du9ImbiBDVLUmdoxx+RJgA96dkv9t9BRiJs4H3C3V+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qTZODGHmgZH84jt9TdPmgD6WhrfdYv49z9LVaf2zHNU6Wk8qsmUvZglIAqy2xxpti
	 EkD439hIHb2YLWKqrBW7k9d9gsbRs6KWmGzBksTe4EhGA+suwpFuuIMv12o+vTQ7UO
	 MKRCJj6iK68ruqXWVzhda8OuBzLaWurxtJCNOSj+P+RN2+xBNMM7MnUbwnkBGRXF3q
	 o/H3JIm3NH3i+C9VqPR8deGjpfWgl30Cr1u95QUJ0TiC5DtAzdil/VIf6eo3MqcKSX
	 J9MNHTxNybmyxCIJqsQb96butXxwGAtrA7DWv6wbzcV8wSLnCZzPVTkwAr0ljvBvGX
	 K9CuMDSCmZCXQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 02/15] svcrdma: Clean up use of rdma->sc_pd->device in Receive paths
Date: Tue, 10 Feb 2026 11:32:09 -0500
Message-ID: <20260210163222.2356793-3-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260210163222.2356793-1-cel@kernel.org>
References: <20260210163222.2356793-1-cel@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18845-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 07B6B11D3BE
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

I can't think of a reason why svcrdma is using the PD's device. Most
other consumers of the IB DMA API use the ib_device pointer from the
connection's rdma_cm_id.

I don't believe there's any functional difference between the two,
but it is a little confusing to see some uses of rdma_cm_id->device
and some of ib_pd->device.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index e7e4a39ca6c6..29a71fa79e2b 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -118,7 +118,7 @@ svc_rdma_next_recv_ctxt(struct list_head *list)
 static struct svc_rdma_recv_ctxt *
 svc_rdma_recv_ctxt_alloc(struct svcxprt_rdma *rdma)
 {
-	int node = ibdev_to_node(rdma->sc_cm_id->device);
+	struct ib_device *device = rdma->sc_cm_id->device;
 	struct svc_rdma_recv_ctxt *ctxt;
 	unsigned long pages;
 	dma_addr_t addr;
@@ -126,16 +126,17 @@ svc_rdma_recv_ctxt_alloc(struct svcxprt_rdma *rdma)
 
 	pages = svc_serv_maxpages(rdma->sc_xprt.xpt_server);
 	ctxt = kzalloc_node(struct_size(ctxt, rc_pages, pages),
-			    GFP_KERNEL, node);
+			    GFP_KERNEL, ibdev_to_node(device));
 	if (!ctxt)
 		goto fail0;
 	ctxt->rc_maxpages = pages;
-	buffer = kmalloc_node(rdma->sc_max_req_size, GFP_KERNEL, node);
+	buffer = kmalloc_node(rdma->sc_max_req_size, GFP_KERNEL,
+			      ibdev_to_node(device));
 	if (!buffer)
 		goto fail1;
-	addr = ib_dma_map_single(rdma->sc_pd->device, buffer,
-				 rdma->sc_max_req_size, DMA_FROM_DEVICE);
-	if (ib_dma_mapping_error(rdma->sc_pd->device, addr))
+	addr = ib_dma_map_single(device, buffer, rdma->sc_max_req_size,
+				 DMA_FROM_DEVICE);
+	if (ib_dma_mapping_error(device, addr))
 		goto fail2;
 
 	svc_rdma_recv_cid_init(rdma, &ctxt->rc_cid);
@@ -167,7 +168,7 @@ svc_rdma_recv_ctxt_alloc(struct svcxprt_rdma *rdma)
 static void svc_rdma_recv_ctxt_destroy(struct svcxprt_rdma *rdma,
 				       struct svc_rdma_recv_ctxt *ctxt)
 {
-	ib_dma_unmap_single(rdma->sc_pd->device, ctxt->rc_recv_sge.addr,
+	ib_dma_unmap_single(rdma->sc_cm_id->device, ctxt->rc_recv_sge.addr,
 			    ctxt->rc_recv_sge.length, DMA_FROM_DEVICE);
 	kfree(ctxt->rc_recv_buf);
 	kfree(ctxt);
@@ -962,7 +963,7 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 		return 0;
 
 	percpu_counter_inc(&svcrdma_stat_recv);
-	ib_dma_sync_single_for_cpu(rdma_xprt->sc_pd->device,
+	ib_dma_sync_single_for_cpu(rdma_xprt->sc_cm_id->device,
 				   ctxt->rc_recv_sge.addr, ctxt->rc_byte_len,
 				   DMA_FROM_DEVICE);
 	svc_rdma_build_arg_xdr(rqstp, ctxt);
-- 
2.52.0


