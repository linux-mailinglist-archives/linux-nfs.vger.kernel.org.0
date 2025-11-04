Return-Path: <linux-nfs+bounces-16035-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0152FC333C2
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 23:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6ABD188AD5C
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 22:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BC92FABFA;
	Tue,  4 Nov 2025 22:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hX93Gtdp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371131DF25F
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 22:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295375; cv=none; b=oloNMOiq42tCBHp1KLIxyyx+HwzmX+eyemEOUM4RhS3iqIGOPNzyhrUXhnI21jSxFFPwhmBLv6INu1Siv8pIFsSDxFqkNSMuet4ZmfJkVlPdydDxF2kHEzw9iR+sondyHePu/RbFmECmlL9bovK4a3FYc4wkC1Fc09BueOCPQTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295375; c=relaxed/simple;
	bh=i0kHG/J0+E6y8y10HJ2FKRrr+Utx7tTSzBjSxkxGYM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p5I1iEiYk02JxyEPS0GapvHWLgCnWmX2DvLVT6/esHDVf1F5QgZiuO2+8uHjVayIlOVlyxDEgmiFIkjAXvfSdYiyTmLUdn3669cHHXQ9VuMVY+pGtWN16fgV7BO7XL19/XWE4dBMTJ4LD0sRliNj2aigCpOa20RXsTuVzBiMACs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hX93Gtdp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762295372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=saU9BKoY4uam2td03r40a3b0Q/3pC3WtZrqwh9S1bDg=;
	b=hX93GtdpFPLSWudVXTAmL2ACxxLt+lLxtAht2NjyO6+43AjxtLKPvObbCB1LZyHfWZw83h
	rF4/QzLVnw5XGxfMPnG6noLZCelWmA1tj7/2YErtrRrPoJ49okGVqEaL9qG9vPA0km1Q01
	9cfhVVuAQWUzxsPNb376HH7JRAMp48A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-jLO23EvINaiICC3dmvZABw-1; Tue,
 04 Nov 2025 17:29:31 -0500
X-MC-Unique: jLO23EvINaiICC3dmvZABw-1
X-Mimecast-MFC-AGG-ID: jLO23EvINaiICC3dmvZABw_1762295370
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CB231956088;
	Tue,  4 Nov 2025 22:29:30 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.88.89])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 873471956056;
	Tue,  4 Nov 2025 22:29:29 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v4 1/4] NFSv4.1: pass transport for callback shutdown
Date: Tue,  4 Nov 2025 17:29:24 -0500
Message-ID: <20251104222927.69423-2-okorniev@redhat.com>
In-Reply-To: <20251104222927.69423-1-okorniev@redhat.com>
References: <20251104222927.69423-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

When we are setting up the 4.1 callback server, we pass in
the appropriate rpc_xprt transport pointer with which to associate
the callback server structure. Similarly, pass in the rpc_xprt
pointer for when we are shutting down the callback. This will be
used to make sure that we free the server structure and then clear
the rpc_xprt's bc_server pointer in a safe manner.

Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfs/callback.c   | 2 +-
 fs/nfs/callback.h   | 3 ++-
 fs/nfs/nfs4client.c | 9 +++++++--
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index c8b837006bb2..8b674ee093a6 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -258,7 +258,7 @@ int nfs_callback_up(u32 minorversion, struct rpc_xprt *xprt)
 /*
  * Kill the callback thread if it's no longer being used.
  */
-void nfs_callback_down(int minorversion, struct net *net)
+void nfs_callback_down(int minorversion, struct net *net, struct rpc_xprt *xprt)
 {
 	struct nfs_callback_data *cb_info = &nfs_callback_info[minorversion];
 	struct svc_serv *serv;
diff --git a/fs/nfs/callback.h b/fs/nfs/callback.h
index 154a6ed1299f..8809f93d82c0 100644
--- a/fs/nfs/callback.h
+++ b/fs/nfs/callback.h
@@ -188,7 +188,8 @@ extern __be32 nfs4_callback_recall(void *argp, void *resp,
 				   struct cb_process_state *cps);
 #if IS_ENABLED(CONFIG_NFS_V4)
 extern int nfs_callback_up(u32 minorversion, struct rpc_xprt *xprt);
-extern void nfs_callback_down(int minorversion, struct net *net);
+extern void nfs_callback_down(int minorversion, struct net *net,
+			      struct rpc_xprt *xprt);
 #endif /* CONFIG_NFS_V4 */
 /*
  * nfs41: Callbacks are expected to not cause substantial latency,
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 5998d6bd8a4f..ab38efd020b0 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -280,8 +280,13 @@ struct nfs_client *nfs4_alloc_client(const struct nfs_client_initdata *cl_init)
  */
 static void nfs4_destroy_callback(struct nfs_client *clp)
 {
-	if (__test_and_clear_bit(NFS_CS_CALLBACK, &clp->cl_res_state))
-		nfs_callback_down(clp->cl_mvops->minor_version, clp->cl_net);
+	if (__test_and_clear_bit(NFS_CS_CALLBACK, &clp->cl_res_state)) {
+		struct rpc_xprt *xprt;
+
+		xprt = rcu_dereference_raw(clp->cl_rpcclient->cl_xprt);
+		nfs_callback_down(clp->cl_mvops->minor_version, clp->cl_net,
+				  xprt);
+	}
 }
 
 static void nfs4_shutdown_client(struct nfs_client *clp)
-- 
2.47.1


