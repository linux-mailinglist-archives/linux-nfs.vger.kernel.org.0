Return-Path: <linux-nfs+bounces-18846-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ArjFdxdi2mYUAAAu9opvQ
	(envelope-from <linux-nfs+bounces-18846-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:33:32 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB05511D3D3
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA4E4304522C
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 16:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C922F3C02;
	Tue, 10 Feb 2026 16:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVLrP9YU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AEA3A1C9;
	Tue, 10 Feb 2026 16:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770741149; cv=none; b=BBylCre0UXFZowmrsfnpGcRsQNq5N+sq29sWBupWKnh3HNK+aaJPgUG7WeCrL4VItcjGZ9zRvwLbNz7WiuFibFhD0CxztdlPSz3pxxha9EMXJkc+8xZcQPnJ2dhOGZgyR5qHK74TvEVHzhyrOeDz5hwSOK8iit6I1sbifiYriFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770741149; c=relaxed/simple;
	bh=4V+/pALjiiIGT2vjcnAo7AdCD08dDUNSo+Umu5NfQWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/hbW5lwhAUvKbm1/gdQ9+4RjMNzgKEHVU65GJ0VjFcFbv6C/+Lhf8eERr+4mHqjiFIf1bh/Liz3uKRVlnBqCKsTqPuBwGKOUICEiT8XSnqQt+Rd9CTtjscW40H11aj7vdCA/Q+XNhqhWe4+p93QJ67pBx1t95Ye+R1+GYthrO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVLrP9YU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E17C19421;
	Tue, 10 Feb 2026 16:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770741149;
	bh=4V+/pALjiiIGT2vjcnAo7AdCD08dDUNSo+Umu5NfQWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PVLrP9YU/DtG1eVRxgLt0+oo3VrsDsCm4Qhcj/5hQt/KhJ3SZjHMZ6ag4630nQW0N
	 x/w4zfYMnU2R+zjZdn3qPhsEUJjjLbYUeKfPhJiY83TdWRmu3ZWUCLGyI5vSG4Mzhq
	 lAew5TxprykSlX9VmzU30tVNko2m2jcXfQjWj3fUc7m12chL0RSmKSakmwnCoOGK32
	 V07s8xw2+FoQkgiyAou8ULcaPHVJCcRyEChiGfcjCsYJ3QQZ2iY45CIwU0JTODEayt
	 Kf8vrh7KFjxEf9PU++79gfpO17VqRx4+9wjZDr7nYygnmbO+PVJM7516B0FcXU579R
	 k/xB3/+qUYUaQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 03/15] svcrdma: Clean up use of rdma->sc_pd->device
Date: Tue, 10 Feb 2026 11:32:10 -0500
Message-ID: <20260210163222.2356793-4-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	TAGGED_FROM(0.00)[bounces-18846-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB05511D3D3
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
 net/sunrpc/xprtrdma/svc_rdma_sendto.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index da0d637ba4fb..eb21544f4a61 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -116,7 +116,7 @@ static void svc_rdma_wc_send(struct ib_cq *cq, struct ib_wc *wc);
 static struct svc_rdma_send_ctxt *
 svc_rdma_send_ctxt_alloc(struct svcxprt_rdma *rdma)
 {
-	int node = ibdev_to_node(rdma->sc_cm_id->device);
+	struct ib_device *device = rdma->sc_cm_id->device;
 	struct svc_rdma_send_ctxt *ctxt;
 	unsigned long pages;
 	dma_addr_t addr;
@@ -124,21 +124,22 @@ svc_rdma_send_ctxt_alloc(struct svcxprt_rdma *rdma)
 	int i;
 
 	ctxt = kzalloc_node(struct_size(ctxt, sc_sges, rdma->sc_max_send_sges),
-			    GFP_KERNEL, node);
+			    GFP_KERNEL, ibdev_to_node(device));
 	if (!ctxt)
 		goto fail0;
 	pages = svc_serv_maxpages(rdma->sc_xprt.xpt_server);
 	ctxt->sc_pages = kcalloc_node(pages, sizeof(struct page *),
-				      GFP_KERNEL, node);
+				      GFP_KERNEL, ibdev_to_node(device));
 	if (!ctxt->sc_pages)
 		goto fail1;
 	ctxt->sc_maxpages = pages;
-	buffer = kmalloc_node(rdma->sc_max_req_size, GFP_KERNEL, node);
+	buffer = kmalloc_node(rdma->sc_max_req_size, GFP_KERNEL,
+			      ibdev_to_node(device));
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
@@ -412,7 +412,7 @@ int svc_rdma_post_send(struct svcxprt_rdma *rdma,
 	might_sleep();
 
 	/* Sync the transport header buffer */
-	ib_dma_sync_single_for_device(rdma->sc_pd->device,
+	ib_dma_sync_single_for_device(rdma->sc_cm_id->device,
 				      send_wr->sg_list[0].addr,
 				      send_wr->sg_list[0].length,
 				      DMA_TO_DEVICE);
-- 
2.52.0


