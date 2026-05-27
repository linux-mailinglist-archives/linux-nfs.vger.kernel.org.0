Return-Path: <linux-nfs+bounces-22016-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wID7LMYHF2oo1wcAu9opvQ
	(envelope-from <linux-nfs+bounces-22016-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 17:03:34 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B24B5E67FC
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 17:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E275B305CB23
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 15:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DF1427A1A;
	Wed, 27 May 2026 15:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6TLiB8s"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA958426EBF;
	Wed, 27 May 2026 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779894026; cv=none; b=XYX8AZe38mDq0PgjnGM//ztLTMPjwMAX1w3RnIZwrup4xhKb77mTfWY+kDacfdWQ8PUIoInFEZ6KhLWzsEHyzDtRzKp1aRsols6/n5VcKsefCwWal/0SsGFUQUEazLv2QwN9boY/dUYQXYaRzU85KmoFTgZQt2Da5BFLNd/ZeJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779894026; c=relaxed/simple;
	bh=2doSkw4dIIdG4I1hG0LGz/hWujTeZ5RT3HbJDWJyj98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QcnWWAICYh4U2vQKUW3/Vt+mx1o/2OGIfV7UGykAEhxPoSvLsMCgA0uT3TNGMZBJ85R/4L18ilsWlSrS0Pquw2JEAlhY4GKdOE87mIH2AfY839dPUHnKF8DqB/pHNXZr5jHIHkrtVisdZQ8sVBPXFeUGVEU4EjQs/YU98UT87Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6TLiB8s; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F56B1F00A3F;
	Wed, 27 May 2026 15:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779894025;
	bh=LkY0UIvH4x0q8hYmpsfD5ljPg2RTn96gfu3sbMKr810=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=A6TLiB8syr+1Lu3k5ME26Rj12s/YdvSl47oNeNq9Izeokds/JPnOw4BpAdw+dmfd0
	 gfeNwNnrgIeMWgm5127RP5+w+/QFoHbfX28OUahX9DpOpN0U/+tlTHUAHjHlbBs/FL
	 j4HVquZS43EGCjgni5hpu9iqDhjtvI+4Dy1+lZ9JNUppxqGcpFiT83q+wjitFt7JKk
	 Vxhi/CzmK9iQZEQMQbxef+pJB698QwPg/01/cu77jfQyChjPIHaVXeVav5uxMiL8nO
	 rckOpuDlKZk0mMsFkNd6uMbeuXkEAnzmqf/U+3Wdj7B6W1Rj0jdhHDxDyzsxmgywNq
	 oox8vzP7iyzew==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 27 May 2026 11:00:15 -0400
Subject: [PATCH 5/5] svcrdma: Clear sc_cm_id when ADDR_CHANGE replacement
 fails
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-rdma-follow-on-v1-5-1b09bd87b6cd@oracle.com>
References: <20260527-rdma-follow-on-v1-0-1b09bd87b6cd@oracle.com>
In-Reply-To: <20260527-rdma-follow-on-v1-0-1b09bd87b6cd@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=1699;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=MKizhDMwqXmfYH6PtyQVDwxHFB1fn9+Phby6DYKo5d4=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqFwcFx7DFfpsNkreyFK+bOm02G6ZVsegMMGi8d
 NaGN8RSM9yJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahcHBQAKCRAzarMzb2Z/
 lxcbD/4xSgecrHOrPdYPafly9waarQQyR9oukjTqGsP9ow4oSfO79/TDprOfVacMRZBz3u+1+Dv
 j3naWOFw46r4x+WPxr4zzjeSaPc3K3ITFVtU7qTR4wR50APfrvKgoaY1DKIgdUS+zCFtlRgI1kX
 LZ6rbRE6Q/zFiUYbEZl27c2Xvl4sfT23SQbs51L2mx5oCPSuRhxRRfb/1dnZJlkET0LEcjiHD97
 vWOzTlvXpKxLhvN7i763Kx5CF5yipqOV//9LxT04KyAxDaPN8C+IDdyZAhjTd1s+bHSEZcDcKzy
 B34LZirt4Y/jqDwFHkU5E43PfT/cy96UeAvnDlsdyR4W7Yel0X5NHv7BuyFhAG7ImFHHmv3702E
 zlM174EigdIHiWim/aym44W+F7knheugUl6AVaN9ldmsvq0uxjXOsrg6qq4sXTOKEIf9X6XVLIP
 p4351nZ9lqMdFQNtOkvpQPNtSgB6VtojPbB0dGNv6h4fjwtycVastoIXBJGVcOHst6q76KdfCVQ
 jb/7faiVLjwAXS1BJZJw1HhDXtlIzO33RQza53pn8CCaVg/pVPFbjpEtKZu64i4KCiW9uJ3KGrS
 FwRtE5zIxJG9NW1RmzVE2bdvZpCFNYBR4cctLoWYn1eH1hEtK8xLtCRHhKkEeZDRyJX4RvQIBsC
 1sl4hotHJzkKZtA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22016-lists,linux-nfs=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oracle.com:mid,oracle.com:email]
X-Rspamd-Queue-Id: 8B24B5E67FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

When svc_rdma_listen_handler() handles RDMA_CM_EVENT_ADDR_CHANGE,
it creates a replacement listener cm_id and returns 1, telling
the CM core to destroy the old one. If the replacement allocation
fails, sc_cm_id still points at the old cm_id that the CM core is
about to destroy. Any subsequent dereference of sc_cm_id --
such as svc_rdma_detach()'s rdma_disconnect() call -- is a
use-after-free.

NULL sc_cm_id on the failure path and guard svc_rdma_detach()'s
rdma_disconnect() call against NULL so that the listener can
be torn down safely when the server shuts down.

Fixes: d1b586e75ec6 ("svcrdma: Handle ADDR_CHANGE CM event properly")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 656b2bd258a9..093371f9d245 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -330,6 +330,7 @@ static int svc_rdma_listen_handler(struct rdma_cm_id *cma_id,
 		if (IS_ERR(listen_id)) {
 			pr_err("Listener dead, address change failed for device %s\n",
 				cma_id->device->name);
+			cma_xprt->sc_cm_id = NULL;
 		} else
 			cma_xprt->sc_cm_id = listen_id;
 		return 1;
@@ -638,7 +639,8 @@ static void svc_rdma_detach(struct svc_xprt *xprt)
 	struct svcxprt_rdma *rdma =
 		container_of(xprt, struct svcxprt_rdma, sc_xprt);
 
-	rdma_disconnect(rdma->sc_cm_id);
+	if (rdma->sc_cm_id)
+		rdma_disconnect(rdma->sc_cm_id);
 
 	/*
 	 * Most close paths go through svc_rdma_xprt_deferred_close(),

-- 
2.54.0


